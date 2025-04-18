Return-Path: <linux-fsdevel+bounces-46672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C203A9377E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7EB7AAD92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8977276032;
	Fri, 18 Apr 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pep9X01n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9101FBCAD;
	Fri, 18 Apr 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744980911; cv=none; b=saQxNVjAx6QqKyW1ULCeW7qQW3pYRJdOQ+FVv4sCsHlBfEhyIUPddtW8R+ALollg/4nTsAllLt5EhK7ez9nA76kTg1QYO+nFkZuo+1OckfQ/qHBzp244u0MIm8uLr5YZhr5kEckqYeOJq7rzUf5Ba0iJMH04dyRDtqrECc6WdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744980911; c=relaxed/simple;
	bh=R9Y5BT4hEWMGj8h1G6rpnC1OFMDnJNmXe6gCJRvToQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZg+k7dhUesLnizua8f1pW8OPwJTV4md+3Q3iR2ABFRWJFx1tLnwuVHhY5qxMwNXwpzVGOT6B8uEgYPDzEx2gr64Bm48ETYNNCwM2/09cvMTC3jAb9cYj01tmcdmC/s9tYAlFOnuTUbWpKkWc6mPXSJbXczEdet+Khh9Y4CMwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pep9X01n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C7C4CEE2;
	Fri, 18 Apr 2025 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744980910;
	bh=R9Y5BT4hEWMGj8h1G6rpnC1OFMDnJNmXe6gCJRvToQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pep9X01nvmu9zDZxhqnLyD28sEPUAOpUBUrUlfeE7DNU3s9Ci5zYeTK/DL0z/oYOW
	 +WQqYvepCy2Suv/KrMLBEAQXtRFtscKoWtByExKGvRWV7h445R+MK6S35J1Oi3DA26
	 OvTdEggnk3JkoRwUchjYq0XsbmA5aYe9s9G86WCFSIl4JNuXEuIUDDAVAj8tlCnf+q
	 xlQ1LbYq3Ax4Sq9LsShcdrzBZz3ixv2DowA4zsScglUyTI0a05p8Oj3b/u1/zp6ooJ
	 c4HQEs5Zfu2YWzkTkjGUeo/tFusRNpt52p0fNqxnx26xdOgDAcUgVraPY61+oAOkjH
	 Tm+OVGod2TRZw==
Date: Fri, 18 Apr 2025 14:55:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250418-elefant-antrieb-cd111787d6b2@brauner>
References: <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
 <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
 <39c36187-615e-4f83-b05e-419015d885e6@themaw.net>
 <125df195-5cac-4a65-b8bb-8b1146132667@themaw.net>
 <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n7c2fkulbsmjbpdu"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>


--n7c2fkulbsmjbpdu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Apr 18, 2025 at 10:47:10AM +0200, Christian Brauner wrote:
> On Fri, Apr 18, 2025 at 09:20:52AM +0800, Ian Kent wrote:
> > On 18/4/25 09:13, Ian Kent wrote:
> > > 
> > > On 18/4/25 00:28, Christian Brauner wrote:
> > > > On Thu, Apr 17, 2025 at 05:31:26PM +0200, Sebastian Andrzej Siewior
> > > > wrote:
> > > > > On 2025-04-17 17:28:20 [+0200], Christian Brauner wrote:
> > > > > > >      So if there's some userspace process with a broken
> > > > > > > NFS server and it
> > > > > > >      does umount(MNT_DETACH) it will end up hanging every other
> > > > > > >      umount(MNT_DETACH) on the system because the dealyed_mntput_work
> > > > > > >      workqueue (to my understanding) cannot make progress.
> > > > > > Ok, "to my understanding" has been updated after going back
> > > > > > and reading
> > > > > > the delayed work code. Luckily it's not as bad as I thought it is
> > > > > > because it's queued on system_wq which is multi-threaded so it's at
> > > > > > least not causing everyone with MNT_DETACH to get stuck. I'm still
> > > > > > skeptical how safe this all is.
> > > > > I would (again) throw system_unbound_wq into the game because
> > > > > the former
> > > > > will remain on the CPU on which has been enqueued (if speaking about
> > > > > multi threading).
> > > > Yes, good point.
> > > > 
> > > > However, what about using polled grace periods?
> > > > 
> > > > A first simple-minded thing to do would be to record the grace period
> > > > after umount_tree() has finished and the check it in namespace_unlock():
> > > > 
> > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > index d9ca80dcc544..1e7ebcdd1ebc 100644
> > > > --- a/fs/namespace.c
> > > > +++ b/fs/namespace.c
> > > > @@ -77,6 +77,7 @@ static struct hlist_head *mount_hashtable
> > > > __ro_after_init;
> > > >   static struct hlist_head *mountpoint_hashtable __ro_after_init;
> > > >   static struct kmem_cache *mnt_cache __ro_after_init;
> > > >   static DECLARE_RWSEM(namespace_sem);
> > > > +static unsigned long rcu_unmount_seq; /* protected by namespace_sem */
> > > >   static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
> > > >   static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > > >   static DEFINE_SEQLOCK(mnt_ns_tree_lock);
> > > > @@ -1794,6 +1795,7 @@ static void namespace_unlock(void)
> > > >          struct hlist_head head;
> > > >          struct hlist_node *p;
> > > >          struct mount *m;
> > > > +       unsigned long unmount_seq = rcu_unmount_seq;
> > > >          LIST_HEAD(list);
> > > > 
> > > >          hlist_move_list(&unmounted, &head);
> > > > @@ -1817,7 +1819,7 @@ static void namespace_unlock(void)
> > > >          if (likely(hlist_empty(&head)))
> > > >                  return;
> > > > 
> > > > -       synchronize_rcu_expedited();
> > > > +       cond_synchronize_rcu_expedited(unmount_seq);
> > > > 
> > > >          hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
> > > >                  hlist_del(&m->mnt_umount);
> > > > @@ -1939,6 +1941,8 @@ static void umount_tree(struct mount *mnt,
> > > > enum umount_tree_flags how)
> > > >                   */
> > > >                  mnt_notify_add(p);
> > > >          }
> > > > +
> > > > +       rcu_unmount_seq = get_state_synchronize_rcu();
> > > >   }
> > > > 
> > > >   static void shrink_submounts(struct mount *mnt);
> > > > 
> > > > 
> > > > I'm not sure how much that would buy us. If it doesn't then it should be
> > > > possible to play with the following possibly strange idea:
> > > > 
> > > > diff --git a/fs/mount.h b/fs/mount.h
> > > > index 7aecf2a60472..51b86300dc50 100644
> > > > --- a/fs/mount.h
> > > > +++ b/fs/mount.h
> > > > @@ -61,6 +61,7 @@ struct mount {
> > > >                  struct rb_node mnt_node; /* node in the ns->mounts
> > > > rbtree */
> > > >                  struct rcu_head mnt_rcu;
> > > >                  struct llist_node mnt_llist;
> > > > +               unsigned long mnt_rcu_unmount_seq;
> > > >          };
> > > >   #ifdef CONFIG_SMP
> > > >          struct mnt_pcp __percpu *mnt_pcp;
> > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > index d9ca80dcc544..aae9df75beed 100644
> > > > --- a/fs/namespace.c
> > > > +++ b/fs/namespace.c
> > > > @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
> > > >          struct hlist_head head;
> > > >          struct hlist_node *p;
> > > >          struct mount *m;
> > > > +       bool needs_synchronize_rcu = false;
> > > >          LIST_HEAD(list);
> > > > 
> > > >          hlist_move_list(&unmounted, &head);
> > > > @@ -1817,7 +1818,16 @@ static void namespace_unlock(void)
> > > >          if (likely(hlist_empty(&head)))
> > > >                  return;
> > > > 
> > > > -       synchronize_rcu_expedited();
> > > > +       hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
> > > > +               if (!poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
> > > > +                       continue;
> 
> This has a bug. This needs to be:
> 
> 	/* A grace period has already elapsed. */
> 	if (poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
> 		continue;
> 
> 	/* Oh oh, we have to pay up. */
> 	needs_synchronize_rcu = true;
> 	break;
> 
> which I'm pretty sure will eradicate most of the performance gain you've
> seen because fundamentally the two version shouldn't be different (Note,
> I drafted this while on my way out the door. r.
> 
> I would test the following version where we pay the cost of the
> smb_mb() from poll_state_synchronize_rcu() exactly one time:
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 7aecf2a60472..51b86300dc50 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -61,6 +61,7 @@ struct mount {
>                 struct rb_node mnt_node; /* node in the ns->mounts rbtree */
>                 struct rcu_head mnt_rcu;
>                 struct llist_node mnt_llist;
> +               unsigned long mnt_rcu_unmount_seq;
>         };
>  #ifdef CONFIG_SMP
>         struct mnt_pcp __percpu *mnt_pcp;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d9ca80dcc544..dd367c54bc29 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
>         struct hlist_head head;
>         struct hlist_node *p;
>         struct mount *m;
> +       unsigned long mnt_rcu_unmount_seq = 0;
>         LIST_HEAD(list);
> 
>         hlist_move_list(&unmounted, &head);
> @@ -1817,7 +1818,10 @@ static void namespace_unlock(void)
>         if (likely(hlist_empty(&head)))
>                 return;
> 
> -       synchronize_rcu_expedited();
> +       hlist_for_each_entry_safe(m, p, &head, mnt_umount)
> +               mnt_rcu_unmount_seq = max(m->mnt_rcu_unmount_seq, mnt_rcu_unmount_seq);
> +
> +       cond_synchronize_rcu_expedited(mnt_rcu_unmount_seq);
> 
>         hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>                 hlist_del(&m->mnt_umount);
> @@ -1923,8 +1927,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>                         }
>                 }
>                 change_mnt_propagation(p, MS_PRIVATE);
> -               if (disconnect)
> +               if (disconnect) {
> +                       p->mnt_rcu_unmount_seq = get_state_synchronize_rcu();
>                         hlist_add_head(&p->mnt_umount, &unmounted);
> +               }
> 
>                 /*
>                  * At this point p->mnt_ns is NULL, notification will be queued

Appended is a version of the queue_rcu_work() patch that I think should
work... I've drafted it just now and folded all the changes into your
original patch. I have not at all tested this and I'm not really working
today because it's a public holiday but if you want to play with it
please do so.

I'm somewhat torn. I can see that this is painful on RT kernels and I
see that we should do something about it but I'm not sure whether I'm
willing to incur that new shenanigans on non-RT kernels as well if we
don't have to since the expedited grace period sync works just fine on
non-RT kernels. So maybe we just keep it and special-case the RT case
with queue_rcu_work(). I haven't decided whether I want to do that or
not.

--n7c2fkulbsmjbpdu
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-UNTESTED-fs-namespace-defer-RCU-sync-for-MNT_DETACH-.patch"

From 558b37682baaf251b761c455d02606db4abfedd8 Mon Sep 17 00:00:00 2001
From: Eric Chanudet <echanude@redhat.com>
Date: Tue, 8 Apr 2025 16:58:34 -0400
Subject: [PATCH] [UNTESTED] fs/namespace: defer RCU sync for MNT_DETACH umount

Defer releasing the detached file-system when calling namespace_unlock()
during a lazy umount to return faster.

When requesting MNT_DETACH, the caller does not expect the file-system
to be shut down upon returning from the syscall. Calling
synchronize_rcu_expedited() has a significant cost on RT kernel that
defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
mount in a separate list and put it on a workqueue to run post RCU
grace-period.

w/o patch, 6.15-rc1 PREEMPT_RT:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
    0.02455 +- 0.00107 seconds time elapsed  ( +-  4.36% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
    0.02555 +- 0.00114 seconds time elapsed  ( +-  4.46% )

w/ patch, 6.15-rc1 PREEMPT_RT:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
    0.026311 +- 0.000869 seconds time elapsed  ( +-  3.30% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
    0.003194 +- 0.000160 seconds time elapsed  ( +-  5.01% )

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
Link: https://lore.kernel.org/20250408210350.749901-12-echanude@redhat.com
Not-Tested-by: Christian Brauner <brauner@kernel.org>
Massaged-With-Great-Shame-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 78 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bc23c0e1fb9d..c36debbc5135 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -45,6 +45,11 @@ static unsigned int m_hash_shift __ro_after_init;
 static unsigned int mp_hash_mask __ro_after_init;
 static unsigned int mp_hash_shift __ro_after_init;
 
+struct deferred_free_mounts {
+	struct rcu_work rwork;
+	struct hlist_head release_list;
+};
+
 static __initdata unsigned long mhash_entries;
 static int __init set_mhash_entries(char *str)
 {
@@ -77,8 +82,9 @@ static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
 static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
-static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
-static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+static bool defer_unmount;		/* protected by namespace_sem */
+static HLIST_HEAD(unmounted);		/* protected by namespace_sem */
+static LIST_HEAD(ex_mountpoints);	/* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 
 #ifdef CONFIG_FSNOTIFY
@@ -1412,7 +1418,9 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	return ERR_PTR(err);
 }
 
-static void cleanup_mnt(struct mount *mnt)
+static void __mntput_no_expire(struct mount *mnt, bool cleanup_sync);
+
+static void cleanup_mnt(struct mount *mnt, bool cleanup_sync)
 {
 	struct hlist_node *p;
 	struct mount *m;
@@ -1428,7 +1436,9 @@ static void cleanup_mnt(struct mount *mnt)
 		mnt_pin_kill(mnt);
 	hlist_for_each_entry_safe(m, p, &mnt->mnt_stuck_children, mnt_umount) {
 		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
+		if (unlikely(m->mnt_expiry_mark))
+			WRITE_ONCE(m->mnt_expiry_mark, 0);
+		__mntput_no_expire(m, cleanup_sync);
 	}
 	fsnotify_vfsmount_delete(&mnt->mnt);
 	dput(mnt->mnt.mnt_root);
@@ -1439,7 +1449,7 @@ static void cleanup_mnt(struct mount *mnt)
 
 static void __cleanup_mnt(struct rcu_head *head)
 {
-	cleanup_mnt(container_of(head, struct mount, mnt_rcu));
+	cleanup_mnt(container_of(head, struct mount, mnt_rcu), false /* cleanup sync */);
 }
 
 static LLIST_HEAD(delayed_mntput_list);
@@ -1449,11 +1459,11 @@ static void delayed_mntput(struct work_struct *unused)
 	struct mount *m, *t;
 
 	llist_for_each_entry_safe(m, t, node, mnt_llist)
-		cleanup_mnt(m);
+		cleanup_mnt(m, false /* cleanup sync */);
 }
 static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
-static void mntput_no_expire(struct mount *mnt)
+static void __mntput_no_expire(struct mount *mnt, bool cleanup_sync)
 {
 	LIST_HEAD(list);
 	int count;
@@ -1507,7 +1517,7 @@ static void mntput_no_expire(struct mount *mnt)
 	unlock_mount_hash();
 	shrink_dentry_list(&list);
 
-	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
+	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL) && !cleanup_sync)) {
 		struct task_struct *task = current;
 		if (likely(!(task->flags & PF_KTHREAD))) {
 			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
@@ -1518,7 +1528,12 @@ static void mntput_no_expire(struct mount *mnt)
 			schedule_delayed_work(&delayed_mntput_work, 1);
 		return;
 	}
-	cleanup_mnt(mnt);
+	cleanup_mnt(mnt, cleanup_sync);
+}
+
+static inline void mntput_no_expire(struct mount *mnt)
+{
+	__mntput_no_expire(mnt, false);
 }
 
 void mntput(struct vfsmount *mnt)
@@ -1789,15 +1804,37 @@ static bool need_notify_mnt_list(void)
 }
 #endif
 
-static void namespace_unlock(void)
+static void free_mounts(struct hlist_head *mount_list, bool cleanup_sync)
 {
-	struct hlist_head head;
 	struct hlist_node *p;
 	struct mount *m;
+
+	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
+		hlist_del(&m->mnt_umount);
+		if (unlikely(m->mnt_expiry_mark))
+			WRITE_ONCE(m->mnt_expiry_mark, 0);
+		__mntput_no_expire(m, cleanup_sync);
+	}
+}
+
+static void defer_free_mounts(struct work_struct *work)
+{
+	struct deferred_free_mounts *d;
+
+	d = container_of(to_rcu_work(work), struct deferred_free_mounts, rwork);
+	free_mounts(&d->release_list, true /* cleanup_sync */);
+	kfree(d);
+}
+
+static void namespace_unlock(void)
+{
+	HLIST_HEAD(head);
 	LIST_HEAD(list);
+	bool defer = defer_unmount;
 
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
+	defer_unmount = false;
 
 	if (need_notify_mnt_list()) {
 		/*
@@ -1817,12 +1854,19 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
+	if (defer) {
+		struct deferred_free_mounts *d;
 
-	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
-		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
+		d = kmalloc(sizeof(struct deferred_free_mounts), GFP_KERNEL);
+		if (d) {
+			hlist_move_list(&head, &d->release_list);
+			INIT_RCU_WORK(&d->rwork, defer_free_mounts);
+			queue_rcu_work(system_unbound_wq, &d->rwork);
+			return;
+		}
 	}
+	synchronize_rcu_expedited();
+	free_mounts(&head, false /* cleanup_sync */);
 }
 
 static inline void namespace_lock(void)
@@ -2044,8 +2088,10 @@ static int do_umount(struct mount *mnt, int flags)
 
 	event++;
 	if (flags & MNT_DETACH) {
-		if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
+		if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list)) {
 			umount_tree(mnt, UMOUNT_PROPAGATE);
+			defer_unmount = true;
+		}
 		retval = 0;
 	} else {
 		shrink_submounts(mnt);
-- 
2.47.2


--n7c2fkulbsmjbpdu--

