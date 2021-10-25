Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE29439221
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhJYJRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 05:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232227AbhJYJRb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:17:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EA3F60EDF;
        Mon, 25 Oct 2021 09:15:07 +0000 (UTC)
Date:   Mon, 25 Oct 2021 11:15:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] fs/namespace: use percpu_rw_semaphore for writer
 holding
Message-ID: <20211025091504.6k7d57awbfpqmmqs@wittgenstein>
References: <20211021220102.bm5bvldjtzsabbfn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211021220102.bm5bvldjtzsabbfn@linutronix.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:01:02AM +0200, Sebastian Andrzej Siewior wrote:
> From: John Ogness <john.ogness@linutronix.de>
> 
> The MNT_WRITE_HOLD flag is used to hold back any new writers while the
> mount point is about to be made read-only. __mnt_want_write() then loops
> with disabled preemption until this flag disappears. Callers of
> mnt_hold_writers() (which sets the flag) hold the spinlock_t of
> mount_lock (seqlock_t) which disables preemption on !PREEMPT_RT and
> ensures the task is not scheduled away so that the spinning side spins
> for a long time.
> 
> On PREEMPT_RT the spinlock_t does not disable preemption and so it is
> possible that the task setting MNT_WRITE_HOLD is preempted by task with
> higher priority which then spins infinitely waiting for MNT_WRITE_HOLD
> to get removed.
> 
> To avoid the spinning, the synchronisation mechanism is replaced by a
> per-CPU-rwsem. The rwsem has been added to struct super_block instead of
> struct mount because in sb_prepare_remount_readonly() it iterates over
> mount points while holding a spinlock_t and the per-CPU-rwsem must not
> be acquired with disabled preemption. This could be avoided by adding a
> mutex_t to protect just the list-add/del operations. There is also the
> lockdep problem where it complains about locking multiple locks of the
> same class where it may lead to a dead lock…
> 
> That problem (with multiple locks of the kind) now occurs in
> do_mount_setattr().

Iiuc, this only becomes a problem by switching to the rwsem. I stared at
and tested that locking for a good few weeks last year to make sure it's
sane. It's not as neatly documented as it probably should be.

> As far as I've seen, all add/remove operation of the list behind
> next_mnt() are performed with namespace_lock() acquired so the rwsem can
> be acquired before lock_mount_hash() with namespace_lock() held.
> Since multiple mountpoints may belong to different super-blocks it is
> needed to acquire multiple rwsems of the same kind and here is where
> lockdep complains. I *assume* that it is possible that two different

Afaict, in that case it would be false-positive.

> mount points belong to the same super block at which point the code in

Yes, that's possible and it's not a rare case.

> do_mount_setattr() really deadlocks.

Yes that would deadlock as you would be reacquiring the same rwsem of a
superblock with multiple mounts.

> 
> So now by writing all this and reevaluating all options it might be
> easier to just lock_mount_hash()+unlock on PREEMPT_RT to PI-boost the
> owner of MNT_WRITE_HOLD and by that avoiding spinning in
> __mnt_want_write().

So the locking would be unchanged on non-rt kernels and only change on
rt kernels? Would be ok to send that patch for comparison if it's not
too much work?

Christian

> 
> [bigeasy: Forward port the old patch, new description and a gross hack
> 	  to let lockdep not complain about the deadlock while running a
> 	  few tests.]
> 
> Link: https://lore.kernel.org/r/20211021220102.bm5bvldjtzsabbfn@linutronix.de
> Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  fs/namespace.c                | 135 ++++++++++++++--------------------
>  fs/super.c                    |   3 +
>  include/linux/fs.h            |   1 +
>  include/linux/mount.h         |   3 +-
>  include/linux/percpu-rwsem.h  |   7 ++
>  kernel/locking/percpu-rwsem.c |  23 +++++-
>  6 files changed, 88 insertions(+), 84 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 659a8f39c61af..fb9bb813bca3c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -333,30 +333,17 @@ static int mnt_is_readonly(struct vfsmount *mnt)
>  int __mnt_want_write(struct vfsmount *m)
>  {
>  	struct mount *mnt = real_mount(m);
> +	struct super_block *sb = m->mnt_sb;
>  	int ret = 0;
>  
> -	preempt_disable();
> -	mnt_inc_writers(mnt);
> -	/*
> -	 * The store to mnt_inc_writers must be visible before we pass
> -	 * MNT_WRITE_HOLD loop below, so that the slowpath can see our
> -	 * incremented count after it has set MNT_WRITE_HOLD.
> -	 */
> -	smp_mb();
> -	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD)
> -		cpu_relax();
> -	/*
> -	 * After the slowpath clears MNT_WRITE_HOLD, mnt_is_readonly will
> -	 * be set to match its requirements. So we must not load that until
> -	 * MNT_WRITE_HOLD is cleared.
> -	 */
> -	smp_rmb();
> -	if (mnt_is_readonly(m)) {
> -		mnt_dec_writers(mnt);
> -		ret = -EROFS;
> -	}
> -	preempt_enable();
> +	percpu_down_read(&sb->mnt_writers_rws);
>  
> +	if (mnt_is_readonly(m))
> +		ret = -EROFS;
> +	else
> +		mnt_inc_writers(mnt);
> +
> +	percpu_up_read(&sb->mnt_writers_rws);
>  	return ret;
>  }
>  
> @@ -435,9 +422,11 @@ EXPORT_SYMBOL_GPL(mnt_want_write_file);
>   */
>  void __mnt_drop_write(struct vfsmount *mnt)
>  {
> -	preempt_disable();
> +	struct super_block *sb = mnt->mnt_sb;
> +
> +	percpu_down_read(&sb->mnt_writers_rws);
>  	mnt_dec_writers(real_mount(mnt));
> -	preempt_enable();
> +	percpu_up_read(&sb->mnt_writers_rws);
>  }
>  
>  /**
> @@ -470,28 +459,15 @@ EXPORT_SYMBOL(mnt_drop_write_file);
>  
>  static inline int mnt_hold_writers(struct mount *mnt)
>  {
> -	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
> -	/*
> -	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
> -	 * should be visible before we do.
> -	 */
> -	smp_mb();
> +	lockdep_assert_held(&mnt->mnt.mnt_sb->mnt_writers_rws);
>  
>  	/*
>  	 * With writers on hold, if this value is zero, then there are
> -	 * definitely no active writers (although held writers may subsequently
> -	 * increment the count, they'll have to wait, and decrement it after
> -	 * seeing MNT_READONLY).
> +	 * definitely no active writers.
>  	 *
>  	 * It is OK to have counter incremented on one CPU and decremented on
> -	 * another: the sum will add up correctly. The danger would be when we
> -	 * sum up each counter, if we read a counter before it is incremented,
> -	 * but then read another CPU's count which it has been subsequently
> -	 * decremented from -- we would see more decrements than we should.
> -	 * MNT_WRITE_HOLD protects against this scenario, because
> -	 * mnt_want_write first increments count, then smp_mb, then spins on
> -	 * MNT_WRITE_HOLD, so it can't be decremented by another CPU while
> -	 * we're counting up here.
> +	 * another: the sum will add up correctly. The rwsem ensures that the
> +	 * counters are not modified once the writer lock is acquired.
>  	 */
>  	if (mnt_get_writers(mnt) > 0)
>  		return -EBUSY;
> @@ -499,16 +475,6 @@ static inline int mnt_hold_writers(struct mount *mnt)
>  	return 0;
>  }
>  
> -static inline void mnt_unhold_writers(struct mount *mnt)
> -{
> -	/*
> -	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
> -	 * that become unheld will see MNT_READONLY.
> -	 */
> -	smp_wmb();
> -	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
> -}
> -
>  static int mnt_make_readonly(struct mount *mnt)
>  {
>  	int ret;
> @@ -516,7 +482,6 @@ static int mnt_make_readonly(struct mount *mnt)
>  	ret = mnt_hold_writers(mnt);
>  	if (!ret)
>  		mnt->mnt.mnt_flags |= MNT_READONLY;
> -	mnt_unhold_writers(mnt);
>  	return ret;
>  }
>  
> @@ -525,15 +490,15 @@ int sb_prepare_remount_readonly(struct super_block *sb)
>  	struct mount *mnt;
>  	int err = 0;
>  
> -	/* Racy optimization.  Recheck the counter under MNT_WRITE_HOLD */
> +	/* Racy optimization.  Recheck the counter under mnt_writers_rws. */
>  	if (atomic_long_read(&sb->s_remove_count))
>  		return -EBUSY;
>  
> +	percpu_down_write(&sb->mnt_writers_rws);
>  	lock_mount_hash();
> +
>  	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
>  		if (!(mnt->mnt.mnt_flags & MNT_READONLY)) {
> -			mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
> -			smp_mb();
>  			if (mnt_get_writers(mnt) > 0) {
>  				err = -EBUSY;
>  				break;
> @@ -547,11 +512,9 @@ int sb_prepare_remount_readonly(struct super_block *sb)
>  		sb->s_readonly_remount = 1;
>  		smp_wmb();
>  	}
> -	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
> -		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
> -			mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
> -	}
> +
>  	unlock_mount_hash();
> +	percpu_up_write(&sb->mnt_writers_rws);
>  
>  	return err;
>  }
> @@ -1068,7 +1031,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>  	}
>  
>  	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
> -	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
> +	mnt->mnt.mnt_flags &= ~(MNT_MARKED|MNT_INTERNAL);
>  
>  	atomic_inc(&sb->s_active);
>  	mnt->mnt.mnt_userns = mnt_user_ns(&old->mnt);
> @@ -2585,8 +2548,8 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
>   */
>  static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
>  {
> -	struct super_block *sb = path->mnt->mnt_sb;
>  	struct mount *mnt = real_mount(path->mnt);
> +	struct super_block *sb = mnt->mnt.mnt_sb;
>  	int ret;
>  
>  	if (!check_mnt(mnt))
> @@ -2603,11 +2566,13 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
>  	 * changing it, so only take down_read(&sb->s_umount).
>  	 */
>  	down_read(&sb->s_umount);
> +	percpu_down_write(&sb->mnt_writers_rws);
>  	lock_mount_hash();
>  	ret = change_mount_ro_state(mnt, mnt_flags);
>  	if (ret == 0)
>  		set_mount_attributes(mnt, mnt_flags);
>  	unlock_mount_hash();
> +	percpu_up_write(&sb->mnt_writers_rws);
>  	up_read(&sb->s_umount);
>  
>  	mnt_warn_timestamp_expiry(path, &mnt->mnt);
> @@ -4027,15 +3992,6 @@ static void mount_setattr_commit(struct mount_kattr *kattr,
>  			WRITE_ONCE(m->mnt.mnt_flags, flags);
>  		}
>  
> -		/*
> -		 * We either set MNT_READONLY above so make it visible
> -		 * before ~MNT_WRITE_HOLD or we failed to recursively
> -		 * apply mount options.
> -		 */
> -		if ((kattr->attr_set & MNT_READONLY) &&
> -		    (m->mnt.mnt_flags & MNT_WRITE_HOLD))
> -			mnt_unhold_writers(m);
> -
>  		if (!err && kattr->propagation)
>  			change_mnt_propagation(m, kattr->propagation);
>  
> @@ -4054,26 +4010,39 @@ static void mount_setattr_commit(struct mount_kattr *kattr,
>  static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
>  {
>  	struct mount *mnt = real_mount(path->mnt), *last = NULL;
> +	bool ns_lock = false;
>  	int err = 0;
>  
>  	if (path->dentry != mnt->mnt.mnt_root)
>  		return -EINVAL;
>  
> -	if (kattr->propagation) {
> +	if ((kattr->attr_set & MNT_READONLY) || kattr->propagation)
>  		/*
>  		 * Only take namespace_lock() if we're actually changing
> -		 * propagation.
> +		 * propagation or iterate via next_mnt().
>  		 */
> +		ns_lock = true;
> +
> +	if (ns_lock)
>  		namespace_lock();
> -		if (kattr->propagation == MS_SHARED) {
> -			err = invent_group_ids(mnt, kattr->recurse);
> -			if (err) {
> -				namespace_unlock();
> -				return err;
> -			}
> +
> +	if (kattr->propagation == MS_SHARED) {
> +		err = invent_group_ids(mnt, kattr->recurse);
> +		if (err) {
> +			namespace_unlock();
> +			return err;
>  		}
>  	}
>  
> +	if (kattr->attr_set & MNT_READONLY) {
> +		struct mount *m = mnt;
> +		int num = 0;
> +
> +		do {
> +			percpu_down_write_nested(&m->mnt.mnt_sb->mnt_writers_rws, num++);
> +		} while (kattr->recurse && (m = next_mnt(m, mnt)));
> +
> +	}
>  	lock_mount_hash();
>  
>  	/*
> @@ -4086,8 +4055,18 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
>  
>  	unlock_mount_hash();
>  
> -	if (kattr->propagation) {
> +	if (kattr->attr_set & MNT_READONLY) {
> +		struct mount *m = mnt;
> +
> +		do {
> +			percpu_up_write(&m->mnt.mnt_sb->mnt_writers_rws);
> +		} while (kattr->recurse && (m = next_mnt(m, mnt)));
> +
> +	}
> +	if (ns_lock)
>  		namespace_unlock();
> +
> +	if (kattr->propagation) {
>  		if (err)
>  			cleanup_group_ids(mnt, NULL);
>  	}
> diff --git a/fs/super.c b/fs/super.c
> index bcef3a6f4c4b5..9c828a05e145f 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -162,6 +162,7 @@ static void destroy_super_work(struct work_struct *work)
>  
>  	for (i = 0; i < SB_FREEZE_LEVELS; i++)
>  		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> +	percpu_free_rwsem(&s->mnt_writers_rws);
>  	kfree(s);
>  }
>  
> @@ -210,6 +211,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	INIT_LIST_HEAD(&s->s_mounts);
>  	s->s_user_ns = get_user_ns(user_ns);
>  	init_rwsem(&s->s_umount);
> +	percpu_init_rwsem(&s->mnt_writers_rws);
> +
>  	lockdep_set_class(&s->s_umount, &type->s_umount_key);
>  	/*
>  	 * sget() can have s_umount recursion.
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e7a633353fd20..2c7b67dfe4303 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1497,6 +1497,7 @@ struct super_block {
>  #endif
>  	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
>  	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
> +	struct percpu_rw_semaphore mnt_writers_rws;
>  	struct block_device	*s_bdev;
>  	struct backing_dev_info *s_bdi;
>  	struct mtd_info		*s_mtd;
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index 5d92a7e1a742d..d51f5b5f7cfea 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -33,7 +33,6 @@ struct fs_context;
>  #define MNT_NOSYMFOLLOW	0x80
>  
>  #define MNT_SHRINKABLE	0x100
> -#define MNT_WRITE_HOLD	0x200
>  
>  #define MNT_SHARED	0x1000	/* if the vfsmount is a shared mount */
>  #define MNT_UNBINDABLE	0x2000	/* if the vfsmount is a unbindable mount */
> @@ -50,7 +49,7 @@ struct fs_context;
>  				 | MNT_READONLY | MNT_NOSYMFOLLOW)
>  #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
>  
> -#define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
> +#define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_INTERNAL | \
>  			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
>  			    MNT_CURSOR)
>  
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index 5fda40f97fe91..db357f306ad6a 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -121,6 +121,13 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
>  	preempt_enable();
>  }
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +extern void percpu_down_write_nested(struct percpu_rw_semaphore *, int subclass);
> +#else
> +# define percpu_down_write_nested(lock, subclass)		\
> +	percpu_down_write(((void)(subclass), (lock)))
> +#endif
> +
>  extern void percpu_down_write(struct percpu_rw_semaphore *);
>  extern void percpu_up_write(struct percpu_rw_semaphore *);
>  
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 70a32a576f3f2..2065073b7d101 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -211,11 +211,8 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
>  	return true;
>  }
>  
> -void percpu_down_write(struct percpu_rw_semaphore *sem)
> +static void _percpu_down_write(struct percpu_rw_semaphore *sem)
>  {
> -	might_sleep();
> -	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> -
>  	/* Notify readers to take the slow path. */
>  	rcu_sync_enter(&sem->rss);
>  
> @@ -237,8 +234,26 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
>  	/* Wait for all active readers to complete. */
>  	rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
>  }
> +
> +void percpu_down_write(struct percpu_rw_semaphore *sem)
> +{
> +	might_sleep();
> +	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> +	_percpu_down_write(sem);
> +}
>  EXPORT_SYMBOL_GPL(percpu_down_write);
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +void percpu_down_write_nested(struct percpu_rw_semaphore *sem, int subclass)
> +{
> +	might_sleep();
> +	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
> +
> +	_percpu_down_write(sem);
> +}
> +EXPORT_SYMBOL_GPL(percpu_down_write_nested);
> +#endif
> +
>  void percpu_up_write(struct percpu_rw_semaphore *sem)
>  {
>  	rwsem_release(&sem->dep_map, _RET_IP_);
> -- 
> 2.33.0
