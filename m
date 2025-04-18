Return-Path: <linux-fsdevel+bounces-46699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17BA93E75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 21:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79F7467049
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B422D7AB;
	Fri, 18 Apr 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iytmxcsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C56DCE1;
	Fri, 18 Apr 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006370; cv=none; b=BDhu5/130bzOnpYVOgrZI0aU1cYL64rNojs+gh08gR/0KzpcLGXUIiCX0RQbhLe6dOsPBb7eqohGCJuHetBvODoPyxC2gFl0GgfHAeuM13JSypwwckFPcLkQhH88rUg7TQnNOj61Ujq6RGdIp0vgf/kneHGvhxB6Fz4NqQTZhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006370; c=relaxed/simple;
	bh=gyBw2DM+jIc/hhY3YexqUJogoosVscXTFjVJLt9Ef30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llo5ICodRuAHoaw9eEbqc59DfGRY7VTzZVf7ZUh6rJsb1kT8RgqLu1BjDXWxtTmLFXcHXsJ7eo2NwOuAUeiLzcsThCypboa7I03erUJH8zw9Qep6DR/AGfnhplQ8MMYroGQfahR8uGyecWkkWGrtNdX2MjVB61hqXIkmgDAqePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iytmxcsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51051C4CEE2;
	Fri, 18 Apr 2025 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745006369;
	bh=gyBw2DM+jIc/hhY3YexqUJogoosVscXTFjVJLt9Ef30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iytmxcsyDe4jUx0gkedpiUtXOUpHB9SO/UiRwbo0c+v78CKAIazj89BlCMaO0X0Df
	 CJ7koj2bke+s/btBuPmO3gdkLNZ/OsvcKXcZJVxpYSqPPxkOwuS/mfRvaZ4u/PG3jZ
	 MPo7Xi71Q0eR4rKzLPqe2I7hUjusCSQW0oQWdmuEB6LQCGuYduG1Uavj3e+aYMquae
	 g6o0HJTOugTN1kODHkuS0dayczZJfrdxtlxXyQofAvYPW63tzbOpxvyn5nrqn7mg3G
	 6j2kPTlaIAmUlGs/2SZdIUXfxX2oaTq4e/n09Rht9Sf+lxVn1tabvgE+mwOuiS7FN5
	 xAV2AW88lSnrw==
Date: Fri, 18 Apr 2025 21:59:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250418-armselig-kabel-4710dc466170@brauner>
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
Content-Type: multipart/mixed; boundary="wlvjtn7bxagetzkl"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>


--wlvjtn7bxagetzkl
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

I'm appending a patch that improves on the first version of this patch.
Instead of simply sampling the current rcu state and hoping that the rcu
grace period has elapsed by the time we get to put the mounts we sample
the rcu state and kick off a new grace period at the end of
umount_tree(). That could even get us some performance improvement by on
non-RT kernels. I have no clue how well this will fare on RT though.

--wlvjtn7bxagetzkl
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-UNTESTED-mount-sample-and-kick-of-grace-period-durin.patch"

From 660bddec1241c46a7722f5c9b66a2450b5f85751 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 18 Apr 2025 13:33:43 +0200
Subject: [PATCH] [UNTESTED]: mount: sample and kick of grace period during
 umount

Sample the current rcu state and kick off a new grace period after we're
done with umount_tree() and make namespace_unlock() take the previous
state into account before invoking synchronize_rcu_expedited().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d9ca80dcc544..287189e85af5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -77,6 +77,7 @@ static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
 static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
+static struct rcu_gp_oldstate rcu_unmount_gp;
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);
@@ -1817,7 +1818,7 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
+	cond_synchronize_rcu_expedited_full(&rcu_unmount_gp);
 
 	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
 		hlist_del(&m->mnt_umount);
@@ -1939,6 +1940,9 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		 */
 		mnt_notify_add(p);
 	}
+
+	/* Record current grace period state and kick of new grace period. */
+	start_poll_synchronize_rcu_expedited_full(&rcu_unmount_gp);
 }
 
 static void shrink_submounts(struct mount *mnt);
-- 
2.47.2


--wlvjtn7bxagetzkl--

