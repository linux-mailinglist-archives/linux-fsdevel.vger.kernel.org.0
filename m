Return-Path: <linux-fsdevel+bounces-46664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6062A934E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51EE4A091F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C5A205AD0;
	Fri, 18 Apr 2025 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2oyB14X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9725A2C8;
	Fri, 18 Apr 2025 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966037; cv=none; b=TY00PAUmyTmz7Dg6nOOtLh/p3xOq4ExvULr2P9Uf0YSQPVojJabfuM4jGZfMY9lqBZpPamBvxuAmef+/T0SYeCV2R5Cdt7X91Sh98n1NpZDoBkD2C8Q6BtFl95X8AI5ag3Pjkg7JVsvbsqzjLBMA05gP/Psggz4C88z7uOodmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966037; c=relaxed/simple;
	bh=W2tEL1iRqKZDZdoiAfbT8zNHiW9SPhUffLkWsQ3asFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apYL1RDJJV9aMiOf7oRltwDqLsBtZew4fSHaKIsmQ4xcpbOJaQSlQ6b0+QJ4zGDutNtlJ0PS8Ow7Os8ccPaf24mkMSyE4CUjZKY1ANPIHIw1raG9X2SpHKZvTNZWcaoxLP5OqYKV+nIzmOaPp9znemrqsc+JtTCrm3cp/ZGvsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2oyB14X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45997C4CEE2;
	Fri, 18 Apr 2025 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744966036;
	bh=W2tEL1iRqKZDZdoiAfbT8zNHiW9SPhUffLkWsQ3asFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2oyB14XIoQ2A7cJ1BV+dQLW2dPeV3HUffI1RrCXLH4tKd4qBbzvvr6uFulxv+yrj
	 hZDiYKL8BXqG9OaFMFI+NwkDUTN98/D+RmpJHDMp4rwSb5QfhRlumE7/tiwPewc7bq
	 mSBPWb+8sl1zsQmSrYrjHvbMdB5KeCf5I9ZCjupcZsbD2QawsuLmNHg2VShMtIzCHS
	 HMa4Y+dIRvm9NeyRbrbWk0VfGXk/Bu9nf0tx1ZiwKzOKh4YvyMU6qFzL9T7GsAmnDQ
	 qGbFcAVsiLVSZk3ntzS2N59ht/r2epcjFjFamHz1gv49ktfsjiVmQpAEESLrefTe3z
	 xICf7LMwhF0Iw==
Date: Fri, 18 Apr 2025 10:47:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>
References: <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
 <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
 <39c36187-615e-4f83-b05e-419015d885e6@themaw.net>
 <125df195-5cac-4a65-b8bb-8b1146132667@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <125df195-5cac-4a65-b8bb-8b1146132667@themaw.net>

On Fri, Apr 18, 2025 at 09:20:52AM +0800, Ian Kent wrote:
> On 18/4/25 09:13, Ian Kent wrote:
> > 
> > On 18/4/25 00:28, Christian Brauner wrote:
> > > On Thu, Apr 17, 2025 at 05:31:26PM +0200, Sebastian Andrzej Siewior
> > > wrote:
> > > > On 2025-04-17 17:28:20 [+0200], Christian Brauner wrote:
> > > > > >      So if there's some userspace process with a broken
> > > > > > NFS server and it
> > > > > >      does umount(MNT_DETACH) it will end up hanging every other
> > > > > >      umount(MNT_DETACH) on the system because the dealyed_mntput_work
> > > > > >      workqueue (to my understanding) cannot make progress.
> > > > > Ok, "to my understanding" has been updated after going back
> > > > > and reading
> > > > > the delayed work code. Luckily it's not as bad as I thought it is
> > > > > because it's queued on system_wq which is multi-threaded so it's at
> > > > > least not causing everyone with MNT_DETACH to get stuck. I'm still
> > > > > skeptical how safe this all is.
> > > > I would (again) throw system_unbound_wq into the game because
> > > > the former
> > > > will remain on the CPU on which has been enqueued (if speaking about
> > > > multi threading).
> > > Yes, good point.
> > > 
> > > However, what about using polled grace periods?
> > > 
> > > A first simple-minded thing to do would be to record the grace period
> > > after umount_tree() has finished and the check it in namespace_unlock():
> > > 
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index d9ca80dcc544..1e7ebcdd1ebc 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -77,6 +77,7 @@ static struct hlist_head *mount_hashtable
> > > __ro_after_init;
> > >   static struct hlist_head *mountpoint_hashtable __ro_after_init;
> > >   static struct kmem_cache *mnt_cache __ro_after_init;
> > >   static DECLARE_RWSEM(namespace_sem);
> > > +static unsigned long rcu_unmount_seq; /* protected by namespace_sem */
> > >   static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
> > >   static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > >   static DEFINE_SEQLOCK(mnt_ns_tree_lock);
> > > @@ -1794,6 +1795,7 @@ static void namespace_unlock(void)
> > >          struct hlist_head head;
> > >          struct hlist_node *p;
> > >          struct mount *m;
> > > +       unsigned long unmount_seq = rcu_unmount_seq;
> > >          LIST_HEAD(list);
> > > 
> > >          hlist_move_list(&unmounted, &head);
> > > @@ -1817,7 +1819,7 @@ static void namespace_unlock(void)
> > >          if (likely(hlist_empty(&head)))
> > >                  return;
> > > 
> > > -       synchronize_rcu_expedited();
> > > +       cond_synchronize_rcu_expedited(unmount_seq);
> > > 
> > >          hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
> > >                  hlist_del(&m->mnt_umount);
> > > @@ -1939,6 +1941,8 @@ static void umount_tree(struct mount *mnt,
> > > enum umount_tree_flags how)
> > >                   */
> > >                  mnt_notify_add(p);
> > >          }
> > > +
> > > +       rcu_unmount_seq = get_state_synchronize_rcu();
> > >   }
> > > 
> > >   static void shrink_submounts(struct mount *mnt);
> > > 
> > > 
> > > I'm not sure how much that would buy us. If it doesn't then it should be
> > > possible to play with the following possibly strange idea:
> > > 
> > > diff --git a/fs/mount.h b/fs/mount.h
> > > index 7aecf2a60472..51b86300dc50 100644
> > > --- a/fs/mount.h
> > > +++ b/fs/mount.h
> > > @@ -61,6 +61,7 @@ struct mount {
> > >                  struct rb_node mnt_node; /* node in the ns->mounts
> > > rbtree */
> > >                  struct rcu_head mnt_rcu;
> > >                  struct llist_node mnt_llist;
> > > +               unsigned long mnt_rcu_unmount_seq;
> > >          };
> > >   #ifdef CONFIG_SMP
> > >          struct mnt_pcp __percpu *mnt_pcp;
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index d9ca80dcc544..aae9df75beed 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
> > >          struct hlist_head head;
> > >          struct hlist_node *p;
> > >          struct mount *m;
> > > +       bool needs_synchronize_rcu = false;
> > >          LIST_HEAD(list);
> > > 
> > >          hlist_move_list(&unmounted, &head);
> > > @@ -1817,7 +1818,16 @@ static void namespace_unlock(void)
> > >          if (likely(hlist_empty(&head)))
> > >                  return;
> > > 
> > > -       synchronize_rcu_expedited();
> > > +       hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
> > > +               if (!poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
> > > +                       continue;

This has a bug. This needs to be:

	/* A grace period has already elapsed. */
	if (poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
		continue;

	/* Oh oh, we have to pay up. */
	needs_synchronize_rcu = true;
	break;

which I'm pretty sure will eradicate most of the performance gain you've
seen because fundamentally the two version shouldn't be different (Note,
I drafted this while on my way out the door. r.

I would test the following version where we pay the cost of the
smb_mb() from poll_state_synchronize_rcu() exactly one time:

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
index d9ca80dcc544..dd367c54bc29 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
        struct hlist_head head;
        struct hlist_node *p;
        struct mount *m;
+       unsigned long mnt_rcu_unmount_seq = 0;
        LIST_HEAD(list);

        hlist_move_list(&unmounted, &head);
@@ -1817,7 +1818,10 @@ static void namespace_unlock(void)
        if (likely(hlist_empty(&head)))
                return;

-       synchronize_rcu_expedited();
+       hlist_for_each_entry_safe(m, p, &head, mnt_umount)
+               mnt_rcu_unmount_seq = max(m->mnt_rcu_unmount_seq, mnt_rcu_unmount_seq);
+
+       cond_synchronize_rcu_expedited(mnt_rcu_unmount_seq);

        hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
                hlist_del(&m->mnt_umount);
@@ -1923,8 +1927,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
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

If this doesn't help I had considered recording the rcu sequence number
during __legitimize_mnt() in the mounts. But we likely can't do that
because get_state_synchronize_rcu() is expensive because it inserts a
smb_mb() and that would likely be noticable during path lookup. This
would also hinge on the notion that the last store of the rcu sequence
number is guaranteed to be seen when we check them in namespace_unlock().

Another possibly insane idea (haven't fully thought it out but throwing
it out there to test): allocate a percpu counter for each mount and
increment it each time we enter __legitimize_mnt() and decrement it when
we leave __legitimize_mnt(). During umount_tree() check the percpu sum
for each mount after it's been added to the @unmounted list.

If we see any mount that has a non-zero count we set a global
@needs_synchronize_rcu to true and stop counting for the other mounts
(saving percpu summing cycles). Then call or elide
synchronize_rcu_expedited() based on the @needs_synchronize_rcu boolean
in namespace_unlock().

The percpu might make this cheap enough for __legitimize_mnt() to be
workable (ignoring any other pitfalls I've currently not had time to
warp my head around).

