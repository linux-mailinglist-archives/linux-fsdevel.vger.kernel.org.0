Return-Path: <linux-fsdevel+bounces-46633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E6A922AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A319E4B14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31889254AF4;
	Thu, 17 Apr 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUuFSUhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9A22371B;
	Thu, 17 Apr 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907307; cv=none; b=C+IvH4vW/7mGm0jxqZRwL8T23VE0jHpUg1VACPWF5BRi+cQBO/4vfXPVUgCXnzK6rxYR0VkfcuLEJTRaQnHFWVVwUu0yfSmBhNWj9DlD21PjG8f3gX6E40/kZQOaVD3HOJgpqKoeP6YpP/883Ks66q9DjNYgQiMlHcshbpOFLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907307; c=relaxed/simple;
	bh=5+bAhaVCEtouC2Gh1wkP9M4D61cnTPG4oGIs+tydw0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxCXmeDo4oAYJqBCCJAGH5Hy774Fy+w54rUiDCH4ABxIHXNt2iY3IQgahEWrGrvfCIl4PAHb+NCd7/pUYRraydAkqzandscvOly0ghno5RH89eOUvSmvqMlSYQQy2jLp8aFTm1kH7EfD8U3n2NhFPmZQlKEGWVUfr7c3vFlXqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUuFSUhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9FAC4CEE4;
	Thu, 17 Apr 2025 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744907306;
	bh=5+bAhaVCEtouC2Gh1wkP9M4D61cnTPG4oGIs+tydw0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUuFSUhbCr0KN9vxBx/yjPs2XDBTvTml7q0EaqU3kVRzCRGw2+w4H2SzSgDsU2eay
	 kWINEYHYqyuhbaH2emnJMq/6UhEh3NIZbWcE4YpG8hhuLXGCCrOrFtDad8EYwI6Nfs
	 sUYqFAggBbZhu1UkhPnU50awF9nrdBqgPqb/OpgoqV+relcoekBgTyFWAbyk2wUNZh
	 Zz23GXyoAEslDzf5L0Qymk6Lmjdbqk28o4OLJq+SvW0f7AzOxwaDCNXxag8rHvP/Ta
	 JMDt9K74J28voIaRSpBZ+01NEm1ft3HKBZNhomDgTuU8ZYbYH7kI2VpudOGWwWRmar
	 3CGqnIaAXdsXw==
Date: Thu, 17 Apr 2025 18:28:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Ian Kent <raven@themaw.net>
Cc: Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250417153126.QrVXSjt-@linutronix.de>

On Thu, Apr 17, 2025 at 05:31:26PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-17 17:28:20 [+0200], Christian Brauner wrote:
> > >     So if there's some userspace process with a broken NFS server and it
> > >     does umount(MNT_DETACH) it will end up hanging every other
> > >     umount(MNT_DETACH) on the system because the dealyed_mntput_work
> > >     workqueue (to my understanding) cannot make progress.
> > 
> > Ok, "to my understanding" has been updated after going back and reading
> > the delayed work code. Luckily it's not as bad as I thought it is
> > because it's queued on system_wq which is multi-threaded so it's at
> > least not causing everyone with MNT_DETACH to get stuck. I'm still
> > skeptical how safe this all is. 
> 
> I would (again) throw system_unbound_wq into the game because the former
> will remain on the CPU on which has been enqueued (if speaking about
> multi threading).

Yes, good point.

However, what about using polled grace periods?

A first simple-minded thing to do would be to record the grace period
after umount_tree() has finished and the check it in namespace_unlock():

diff --git a/fs/namespace.c b/fs/namespace.c
index d9ca80dcc544..1e7ebcdd1ebc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -77,6 +77,7 @@ static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
 static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
+static unsigned long rcu_unmount_seq; /* protected by namespace_sem */
 static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);
@@ -1794,6 +1795,7 @@ static void namespace_unlock(void)
        struct hlist_head head;
        struct hlist_node *p;
        struct mount *m;
+       unsigned long unmount_seq = rcu_unmount_seq;
        LIST_HEAD(list);

        hlist_move_list(&unmounted, &head);
@@ -1817,7 +1819,7 @@ static void namespace_unlock(void)
        if (likely(hlist_empty(&head)))
                return;

-       synchronize_rcu_expedited();
+       cond_synchronize_rcu_expedited(unmount_seq);

        hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
                hlist_del(&m->mnt_umount);
@@ -1939,6 +1941,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
                 */
                mnt_notify_add(p);
        }
+
+       rcu_unmount_seq = get_state_synchronize_rcu();
 }

 static void shrink_submounts(struct mount *mnt);


I'm not sure how much that would buy us. If it doesn't then it should be
possible to play with the following possibly strange idea:

diff --git a/fs/mount.h b/fs/mount.h
index 7aecf2a60472..51b86300dc50 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -61,6 +61,7 @@ struct mount {
                struct rb_node mnt_node; /* node in the ns->mounts rbtree */
                struct rcu_head mnt_rcu;
                struct llist_node mnt_llist;
+               unsigned long mnt_rcu_unmount_seq;
        };
 #ifdef CONFIG_SMP
        struct mnt_pcp __percpu *mnt_pcp;
diff --git a/fs/namespace.c b/fs/namespace.c
index d9ca80dcc544..aae9df75beed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
        struct hlist_head head;
        struct hlist_node *p;
        struct mount *m;
+       bool needs_synchronize_rcu = false;
        LIST_HEAD(list);

        hlist_move_list(&unmounted, &head);
@@ -1817,7 +1818,16 @@ static void namespace_unlock(void)
        if (likely(hlist_empty(&head)))
                return;

-       synchronize_rcu_expedited();
+       hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
+               if (!poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
+                       continue;
+
+               needs_synchronize_rcu = true;
+               break;
+       }
+
+       if (needs_synchronize_rcu)
+               synchronize_rcu_expedited();

        hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
                hlist_del(&m->mnt_umount);
@@ -1923,8 +1933,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
                        }
                }
                change_mnt_propagation(p, MS_PRIVATE);
-               if (disconnect)
+               if (disconnect) {
+                       p->mnt_rcu_unmount_seq = get_state_synchronize_rcu();
                        hlist_add_head(&p->mnt_umount, &unmounted);
+               }

                /*
                 * At this point p->mnt_ns is NULL, notification will be queued

This would allow to elide synchronize rcu calls if they elapsed in the
meantime since we moved that mount to the unmounted list.

