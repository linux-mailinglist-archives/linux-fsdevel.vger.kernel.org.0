Return-Path: <linux-fsdevel+bounces-63495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634C7BBE350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C8C189557F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27722D24A7;
	Mon,  6 Oct 2025 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh5lXy4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683B27EFEF;
	Mon,  6 Oct 2025 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758332; cv=none; b=hqpLWA0+uov+XtqFGvWnqUXNaVKVYUElC/R+Q+S3X//z5nlXZpPgI2ovv01HvsOVPNGUu9S3EEXtARGOYu1P+3m4DFvxXw7ZDaqFeMGDB7PgUZDveu6fnf7JcBAXdjFHeTQcN02zoC9QW2ojZFJWAiTpOXRpmpU+F56jvf/8t1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758332; c=relaxed/simple;
	bh=SX2ygkhw/OQ0Zoqp5Tpkx6/pqRhwo4i1bVnZXTz9i98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbSkEmvP8gUzXLTAdnGCUAQclsy1RSfoNG/2QPCXtx1rD4VGxWi1MkAhkZSVQUlgJxJgKWoDp8r5DKKejo7ovQ8JpCq9QAIi6OL/FyUqUKrhmPbu0MMGjD8RAv+PSHw69pghiTp8A3G3aR8dH/pgTL0kawoIcqHfJbN6+nn7V8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh5lXy4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523D6C4CEFF;
	Mon,  6 Oct 2025 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759758331;
	bh=SX2ygkhw/OQ0Zoqp5Tpkx6/pqRhwo4i1bVnZXTz9i98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yh5lXy4djsm9iiOTnJJEO5UokrBtD2E0UKFWthi9jS+Xqn/+I2rQ08NZPiTk2URdd
	 51AY/gqvxgJxNIJTt8z+AanAb3yUWVcwFx0eakygtlCTlhFErQJ3gVsJ+3kHin8EQX
	 cwvyFtRHEGi6iOUlF5eU8C2WxvMdy1QwhDH98ww2gKWFc3XduMRnYVgT+3KhazED8h
	 prLD/Yst6YLiNB8cvypOigSNG0X1z6rdPR5m8NX+CgQ532h8VmoIJ91skb3l91QvMI
	 ntjvxH4T3OcDJX8GCZxAHDgo8rAgTLcr0394eoNQaa1FRs/v06TBqNHDDsGcYxTZpu
	 LiQkIudF7hztg==
Date: Mon, 6 Oct 2025 15:45:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Bhavik Sachdev <b.sachdev1904@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrei Vagin <avagin@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH 2/4] fs/namespace: add umounted mounts to umount_mnt_ns
Message-ID: <20251006-erlesen-anlagen-9af59899a969@brauner>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
 <20251002125422.203598-3-b.sachdev1904@gmail.com>
 <20251002163427.GN39973@ZenIV>
 <7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com>

On Fri, Oct 03, 2025 at 01:03:46PM +0800, Pavel Tikhomirov wrote:
> 
> 
> On 10/3/25 00:34, Al Viro wrote:
> > On Thu, Oct 02, 2025 at 06:18:38PM +0530, Bhavik Sachdev wrote:
> > 
> > > @@ -1438,6 +1440,18 @@ static void mntput_no_expire(struct mount *mnt)
> > >   	mnt->mnt.mnt_flags |= MNT_DOOMED;
> > >   	rcu_read_unlock();
> > > +	if (mnt_ns_attached(mnt)) {
> > > +		struct mnt_namespace *ns;
> > > +
> > > +		move_from_ns(mnt);
> > > +		ns = mnt->mnt_ns;
> > > +		if (ns) {
> > > +			ns->nr_mounts--;
> > > +			__touch_mnt_namespace(ns);
> > > +		}
> > > +		mnt->mnt_ns = NULL;
> > > +	}
> > 
> > Sorry, no.  You are introducing very special locking for one namespace's rbtree.
> > Not gonna fly.
> > 
> > NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Thank you for looking into it.
> 
> Sorry, we didn't have any intent to break locking, we would like to
> improve/rework the patch if we can.
> 
> 1) I see that I missed that __touch_mnt_namespace requires vfsmount lock
> (according to it's comment) and we don't have it in this code path, so that
> is one problem.
> 
> I also see that it sends wake up for mounts_poll() waiters, but since no-one
> can join umount_mnt_ns, there is no point in sending wakeup as no-one can
> poll on /proc/mounts for this namespace. So we can remove the use of
> __touch_mnt_namespace seemingly safely and remove this incorrect locking
> case.
> 
> 2) Another thing is, previously when we were at this point in code we were
> already out of namespace rbtree strictly before the reference from namespace
> was put (namespace_unlock()->mntput()). So no-one could've lookup-ed us, but
> after this change one can lookup us from umount_mnt_ns rbtree while we are
> in mntput_no_expire().
> 
> This one is a hard one, in this implementation at the minimum we can end up
> using the mount after it was freed due to this.
> 
> Previously mount lookup was protected by namespace_sem, and now when I use
> move_from_ns out of namespace_sem this protection is broken.
> 
> One stupid idea to fix it is to leave one reference to mount from detatched
> mntns, and have an asynchronous mechanism which detects last reference (in
> mntput_no_expire) and (under namespace_sem) first disconnects mount from
> umount_mnt_ns and only then calls final mntput.
> 
> We will think more on this one, maybe we will come up with something
> smarter.
> 
> 3) We had an alternative approach to make unmounted mounts mountinfo visible
> for the user, by allowing fd-based statmount() https://github.com/bsach64/linux/commit/ac0c03d44fb1e6f0745aec81079fca075e75b354
> 
> But we also recognize a problem with it that it would require getting
> mountinfo from fd which is not root dentry of the mount, but any dentry (as
> we (CRIU) don't really have an option to choose which fd will be given to
> us).

The part about this just using an fd is - supresses gag reflex - fine.
We do that with the mount namespaces for listmount() already via
mnt_req->spare.

The part that I dislike is exactly the one you pointed out: using an
arbitrary fd to retrieve information about the mount but it's probably
something we can live with since the alternative is complicating the
lifetime rules of the mount and namespace interaction.

I had thought about a way to tie the _internal_ lifetime of the
namespace to the lifetime of unmounted mounts through the passive
reference count by moving them to a separate rb_root unmounted in the
namespace instance.

This would mean we'd have the owning namespace information around and
we'd also don't have to have any separate namespace around. The ->mnt_ns
field could work exactly the same. But alongside the ->mnt_ns pointer
we'd also have the ->mnt_ns_id of the container mount namespace stored.

On umount we'd move the mount to the unmounted mount tree in the same
namespace instance and take a passive reference to it. IOW, the
unmounted mounts keep the namespace alive but only internally.

So basically - handwaving - like this:

diff --git a/fs/mount.h b/fs/mount.h
index 97737051a8b9..4d3db03c8a82 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -14,6 +14,7 @@ struct mnt_namespace {
                struct rb_root  mounts;          /* Protected by namespace_sem */
                struct rb_node  *mnt_last_node;  /* last (rightmost) mount in the rbtree */
                struct rb_node  *mnt_first_node; /* first (leftmost) mount in the rbtree */
+               struct rb_root  unmounted;       /* unmounted mounts that are still active */
        };
        struct user_namespace   *user_ns;
        struct ucounts          *ucounts;
@@ -72,7 +73,10 @@ struct mount {
        struct hlist_head mnt_slave_list;/* list of slave mounts */
        struct hlist_node mnt_slave;    /* slave list entry */
        struct mount *mnt_master;       /* slave is on master->mnt_slave_list */
-       struct mnt_namespace *mnt_ns;   /* containing namespace */
+       struct {
+               struct mnt_namespace *mnt_ns;   /* containing namespace */
+               u64 mnt_ns_id;                  /* id of the containing mount namespace */
+       }
        struct mountpoint *mnt_mp;      /* where is it mounted */
        union {
                struct hlist_node mnt_mp_list;  /* list mounts with the same mountpoint */

->mnt_ns NULL still means as before that this is unmounted. The
containing namespace is alive (internally) and can still be looked up
via mnt->mnt_ns_id in the namespace tree. I stopped thinking here
because this has severe drawbacks:

* The scope of the namespace semaphore has to be extended to cover these
  mounts as well possibly even having to take it in cleanup_mnt() which
  is ugly and probably performance sensitive as it increases the
  codepaths that hammer on the semaphore.

  Alternative is a separate locking scheme. And if it's one thing that
  we don't need is another complex locking scheme in this code.

* The passive lifetime of the namespace would have to cover unmounted
  mounts which betrays the intent of the passive reference count. That's
  not supposed to regulate lifetimes beyond the namespace struct itself
  nor be bound to other objects in complex ways.

  Possibly we'd also have to tie the lifetime of the owning userns to
  the passive count so permission checking just works out of the box
  (One could also put that on the plus side of things but meh.).

* It's very weird to be able to statmount() unmounted mounts via the
  mount id if the actual mount namespace is indeed already dead.

  To put it another way: listmount() wouldn't surface the mount anymore
  - and rightly so - because it's not tied to any mount namespace
  anymore. But somehow we magically synthesize it into existence via
  statmount().

* While a mount is attached to a mount namespace said namespace is the
  rightful owner of the mount. Once the mount is unmounted that
  ownership is moved from the mount namespace and becomes inherently
  bound to processes that hold an active reference to that mount via
  file descriptors.

  But statmount() and listmount() are inherently about the mount
  namespace as the main container of the mount imho.

  Allowing an fd is probably be fine though but it dilutes the concept a
  bit which I'm not too fond of. Oh well.

The list continues...

So if you can make the fd-based statmount() work for your use-case then
this is probably the thing we should do.

