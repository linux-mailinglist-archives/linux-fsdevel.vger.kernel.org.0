Return-Path: <linux-fsdevel+bounces-74588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A36D3C23D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2D744A1DE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3963B8BB5;
	Tue, 20 Jan 2026 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvG9FUsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73343B5304
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897045; cv=none; b=eqvFcr3vB2WPXeLE7m99ebvJ9Nhf8k7wtPJkE7lXfPFSyDvIz7plONZ/ua9LJiXAr9Q22eE3B9u4MHvLuvWKcfabXQoFEY+mfPj6ZOTg0c6iv4cI7ltAOXuEHsCi1KWE+Ozea9FMvIe+cIFlhxeTgZUYniiucUp3m8Kcb6Vh1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897045; c=relaxed/simple;
	bh=tzAjqv8TMTK5CHL19DO3W/Oh8quUn5KWK3ip/lvfyG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyF7W/XMLcHoOl/4lOlPMr7NwYQQvaIBP+52ouch7F3AhkQuoqvOulz0zvRp6C+zygy85IhwFPSXpTdWIIu4U6utgbe8aPV0ABwyolnd7rIKTkJ9Plc+pofraIyWxAAy3RldNUGfUd4Z59GUCiMOI10DYIi+X4cIbGroe2ToDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvG9FUsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA64C16AAE;
	Tue, 20 Jan 2026 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768897045;
	bh=tzAjqv8TMTK5CHL19DO3W/Oh8quUn5KWK3ip/lvfyG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvG9FUsDfJsWjKf91h/Zje9fYUGl+rN7YSTjzfAJuWLcBNUkqXGngfBQfQiAEpuxR
	 I9JCu+B7KWwVmaBMhOHMUSWt99m8ZNR6vvWXv7dpzEvMo9MLZmqIV78oNvXjIdj63Z
	 ELjJdUQTQkKvIUb0Z9r1TWVE10qQN4n7ueBIen/ZRPGuAd7twVM3tqZgCrQAA6yrPi
	 6v704iTptR5oNOj6F+PTPii30nniaXtK+dRFuwpvPv5vDljEQEGcZR1g5fQARn9RVN
	 p5tEzEUKggFeo+tnvXdtZB3zDumKOpkWeeHBTNHn3OfqwIU1jqyvESEZzkrTKONnX3
	 iXPjQvS0QVGRw==
Date: Tue, 20 Jan 2026 09:17:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] pidfs: convert rb-tree to rhashtable
Message-ID: <20260120-teilhaben-kruste-b947256ed6ab@brauner>
References: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
 <CAGudoHEej7_Q-nkJqBU8Md15ESVtyxZ9Wbq9zwyUEcfT034=xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEej7_Q-nkJqBU8Md15ESVtyxZ9Wbq9zwyUEcfT034=xg@mail.gmail.com>

On Mon, Jan 19, 2026 at 09:51:30PM +0100, Mateusz Guzik wrote:
> On Mon, Jan 19, 2026 at 4:06 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
> > protection to an rhashtable. This removes the global pidmap_lock
> > contention from pidfs_ino_get_pid() lookups and allows the hashtable
> > insert to happen outside the pidmap_lock.
> >
> > pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
> > initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
> > inserts pid into rhashtable and is called outside pidmap_lock. Insertion
> > into the rhashtable can fail and memory allocation may happen so we need
> > to drop the spinlock.
> >
> > The hashtable removal is deferred to the RCU callback to ensure safe
> > concurrent lookups. To guard against accidently opening an already
> > reaped task pidfs_ino_get_pid() uses additional checks beyond pid_vnr().
> > If pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd
> > or it already went through pidfs_exit() aka the process as already
> > reaped. If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out
> > whether the task has exited. Switch to refcount_inc_not_zero() to ensure
> > that the pid isn't about to be freed.
> >
> > This slightly changes visibility semantics: pidfd creation is denied
> > after pidfs_exit() runs, which is just before the pid number is removed
> > from the via free_pid(). That should not be an issue though.
> >
> > I haven't perfed this and I would like to make this Mateusz problem...
> >
> > Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/pidfs.c            | 107 ++++++++++++++++++++++++++++----------------------
> >  include/linux/pid.h   |   4 +-
> >  include/linux/pidfs.h |   3 +-
> >  kernel/pid.c          |  19 ++++++---
> >  4 files changed, 79 insertions(+), 54 deletions(-)
> >
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index dba703d4ce4a..e97931249ba2 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/utsname.h>
> >  #include <net/net_namespace.h>
> >  #include <linux/coredump.h>
> > +#include <linux/rhashtable.h>
> >  #include <linux/xattr.h>
> >
> >  #include "internal.h"
> > @@ -55,7 +56,23 @@ struct pidfs_attr {
> >         __u32 coredump_signal;
> >  };
> >
> > -static struct rb_root pidfs_ino_tree = RB_ROOT;
> > +static struct rhashtable pidfs_ino_ht;
> > +
> > +static int pidfs_ino_ht_cmp(struct rhashtable_compare_arg *arg, const void *pidp)
> > +{
> > +       const u64 *ino = arg->key;
> > +       const struct pid *pid = pidp;
> > +
> > +       return pid->ino != *ino;
> > +}
> > +
> > +static const struct rhashtable_params pidfs_ino_ht_params = {
> > +       .key_offset             = offsetof(struct pid, ino),
> > +       .key_len                = sizeof(u64),
> > +       .head_offset            = offsetof(struct pid, pidfs_hash),
> > +       .obj_cmpfn              = pidfs_ino_ht_cmp,
> > +       .automatic_shrinking    = true,
> > +};
> >
> >  #if BITS_PER_LONG == 32
> >  static inline unsigned long pidfs_ino(u64 ino)
> > @@ -84,21 +101,11 @@ static inline u32 pidfs_gen(u64 ino)
> >  }
> >  #endif
> >
> > -static int pidfs_ino_cmp(struct rb_node *a, const struct rb_node *b)
> > -{
> > -       struct pid *pid_a = rb_entry(a, struct pid, pidfs_node);
> > -       struct pid *pid_b = rb_entry(b, struct pid, pidfs_node);
> > -       u64 pid_ino_a = pid_a->ino;
> > -       u64 pid_ino_b = pid_b->ino;
> > -
> > -       if (pid_ino_a < pid_ino_b)
> > -               return -1;
> > -       if (pid_ino_a > pid_ino_b)
> > -               return 1;
> > -       return 0;
> > -}
> > -
> > -void pidfs_add_pid(struct pid *pid)
> > +/*
> > + * Allocate inode number and initialize pidfs fields.
> > + * Called with pidmap_lock held.
> > + */
> > +void pidfs_prepare_pid(struct pid *pid)
> >  {
> >         static u64 pidfs_ino_nr = 2;
> >
> > @@ -134,17 +141,23 @@ void pidfs_add_pid(struct pid *pid)
> >         pid->stashed = NULL;
> >         pid->attr = NULL;
> >         pidfs_ino_nr++;
> > +}
> >
> > -       write_seqcount_begin(&pidmap_lock_seq);
> > -       rb_find_add_rcu(&pid->pidfs_node, &pidfs_ino_tree, pidfs_ino_cmp);
> > -       write_seqcount_end(&pidmap_lock_seq);
> > +/*
> > + * Insert pid into the pidfs hashtable.
> > + * Must be called without holding pidmap_lock (can allocate memory).
> > + * Returns 0 on success, negative error on failure.
> > + */
> > +int pidfs_add_pid(struct pid *pid)
> > +{
> > +       return rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> > +                                     pidfs_ino_ht_params);
> >  }
> >
> >  void pidfs_remove_pid(struct pid *pid)
> >  {
> > -       write_seqcount_begin(&pidmap_lock_seq);
> > -       rb_erase(&pid->pidfs_node, &pidfs_ino_tree);
> > -       write_seqcount_end(&pidmap_lock_seq);
> > +       rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> > +                              pidfs_ino_ht_params);
> >  }
> >
> >  void pidfs_free_pid(struct pid *pid)
> > @@ -773,43 +786,42 @@ static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> >         return FILEID_KERNFS;
> >  }
> >
> > -static int pidfs_ino_find(const void *key, const struct rb_node *node)
> > -{
> > -       const u64 pid_ino = *(u64 *)key;
> > -       const struct pid *pid = rb_entry(node, struct pid, pidfs_node);
> > -
> > -       if (pid_ino < pid->ino)
> > -               return -1;
> > -       if (pid_ino > pid->ino)
> > -               return 1;
> > -       return 0;
> > -}
> > -
> >  /* Find a struct pid based on the inode number. */
> >  static struct pid *pidfs_ino_get_pid(u64 ino)
> >  {
> >         struct pid *pid;
> > -       struct rb_node *node;
> > -       unsigned int seq;
> > +       struct pidfs_attr *attr;
> >
> >         guard(rcu)();
> > -       do {
> > -               seq = read_seqcount_begin(&pidmap_lock_seq);
> > -               node = rb_find_rcu(&ino, &pidfs_ino_tree, pidfs_ino_find);
> > -               if (node)
> > -                       break;
> > -       } while (read_seqcount_retry(&pidmap_lock_seq, seq));
> >
> > -       if (!node)
> > +       pid = rhashtable_lookup(&pidfs_ino_ht, &ino, pidfs_ino_ht_params);
> > +       if (!pid)
> >                 return NULL;
> >
> > -       pid = rb_entry(node, struct pid, pidfs_node);
> > -
> >         /* Within our pid namespace hierarchy? */
> >         if (pid_vnr(pid) == 0)
> >                 return NULL;
> >
> > -       return get_pid(pid);
> > +       /*
> > +        * If attr is NULL the pid is still in the IDR but never had
> > +        * a pidfd. If attr is an error the pid went through pidfs_exit()
> > +        * and is about to be removed. Either way, deny access.
> > +        */
> > +       attr = READ_ONCE(pid->attr);
> > +       if (IS_ERR_OR_NULL(attr))
> > +               return NULL;
> > +
> > +       /*
> > +        * If PIDFS_ATTR_BIT_EXIT is set the task has exited and we
> > +        * should not allow new file handle lookups.
> > +        */
> > +       if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
> > +               return NULL;
> > +
> > +       if (!refcount_inc_not_zero(&pid->count))
> > +               return NULL;
> > +
> > +       return pid;
> >  }
> >
> >  static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> > @@ -1086,6 +1098,9 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
> >
> >  void __init pidfs_init(void)
> >  {
> > +       if (rhashtable_init(&pidfs_ino_ht, &pidfs_ino_ht_params))
> > +               panic("Failed to initialize pidfs hashtable");
> > +
> >         pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
> >                                          (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
> >                                           SLAB_ACCOUNT | SLAB_PANIC), NULL);
> > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > index 003a1027d219..ce9b5cb7560b 100644
> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/rculist.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/refcount.h>
> > +#include <linux/rhashtable-types.h>
> >  #include <linux/sched.h>
> >  #include <linux/wait.h>
> >
> > @@ -60,7 +61,7 @@ struct pid {
> >         spinlock_t lock;
> >         struct {
> >                 u64 ino;
> > -               struct rb_node pidfs_node;
> > +               struct rhash_head pidfs_hash;
> >                 struct dentry *stashed;
> >                 struct pidfs_attr *attr;
> >         };
> > @@ -73,7 +74,6 @@ struct pid {
> >         struct upid numbers[];
> >  };
> >
> > -extern seqcount_spinlock_t pidmap_lock_seq;
> >  extern struct pid init_struct_pid;
> >
> >  struct file;
> > diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> > index 3e08c33da2df..416bdff4d6ce 100644
> > --- a/include/linux/pidfs.h
> > +++ b/include/linux/pidfs.h
> > @@ -6,7 +6,8 @@ struct coredump_params;
> >
> >  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
> >  void __init pidfs_init(void);
> > -void pidfs_add_pid(struct pid *pid);
> > +void pidfs_prepare_pid(struct pid *pid);
> > +int pidfs_add_pid(struct pid *pid);
> >  void pidfs_remove_pid(struct pid *pid);
> >  void pidfs_exit(struct task_struct *tsk);
> >  #ifdef CONFIG_COREDUMP
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index ad4400a9f15f..7da2c3e8f79c 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -43,7 +43,6 @@
> >  #include <linux/sched/task.h>
> >  #include <linux/idr.h>
> >  #include <linux/pidfs.h>
> > -#include <linux/seqlock.h>
> >  #include <net/sock.h>
> >  #include <uapi/linux/pidfd.h>
> >
> > @@ -85,7 +84,6 @@ struct pid_namespace init_pid_ns = {
> >  EXPORT_SYMBOL_GPL(init_pid_ns);
> >
> >  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
> > -seqcount_spinlock_t pidmap_lock_seq = SEQCNT_SPINLOCK_ZERO(pidmap_lock_seq, &pidmap_lock);
> >
> >  void put_pid(struct pid *pid)
> >  {
> > @@ -106,6 +104,7 @@ EXPORT_SYMBOL_GPL(put_pid);
> >  static void delayed_put_pid(struct rcu_head *rhp)
> >  {
> >         struct pid *pid = container_of(rhp, struct pid, rcu);
> > +       pidfs_remove_pid(pid);
> >         put_pid(pid);
> >  }
> >
> > @@ -141,7 +140,6 @@ void free_pid(struct pid *pid)
> >
> >                 idr_remove(&ns->idr, upid->nr);
> >         }
> > -       pidfs_remove_pid(pid);
> >         spin_unlock(&pidmap_lock);
> >
> >         call_rcu(&pid->rcu, delayed_put_pid);
> > @@ -315,7 +313,14 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
> >         retval = -ENOMEM;
> >         if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
> >                 goto out_free;
> > -       pidfs_add_pid(pid);
> > +       pidfs_prepare_pid(pid);
> > +       spin_unlock(&pidmap_lock);
> > +
> > +       retval = pidfs_add_pid(pid);
> > +       if (retval)
> > +               goto out_free_idr;
> > +
> > +       spin_lock(&pidmap_lock);
> 
> This brings back the relock trip, reducing eficacy of the patch.
> 
> Longer term someone(tm) will need to implement lockless alloc_pid (in
> the fast path anyway).
> 
> In order to facilitate that the pidfs thing needs to get its own
> synchronisation. To my understanding rhashtable covers its own locking
> just fine, so the thing left to handle is ino allocation.

I'm very confused why inode allocation would matter. Inode allocation
for pidfs is literally just a plain increment. IOW, it's not using any
atomic at all. So that can happen under pidmap_lock without any issue
and I don't see the need to change to any complex per-cpu allocation
mechanism for this.

