Return-Path: <linux-fsdevel+bounces-59148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F2B34FC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 01:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD55B3AC55D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 23:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACDB2C15AE;
	Mon, 25 Aug 2025 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MNhPpxwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C3273F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165458; cv=none; b=NN7CLvoq3Zz76HZ8q1dL/GkiWOYLOUziToVoYcpWqaTJ9qL4ekASOno6h6N+yq6UgEIUtgImprgpPeTtfxhyTRPfk7qV/0s1hqkr0Js9pSZ3YHYrgLM9pxtiW/K92kwv+BvX7pUP+W6/4XN0F0utju2JBluBgJZAhpLSQRajYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165458; c=relaxed/simple;
	bh=yQiHOkjz0/5ngZp0I1XSp5ghEYVSCe8db/yQIStTb14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW/Grmj+6p3yjkSHc0ceMGyXsQcIYvI/Yvu8DeBWJ4i8ZE4s6yVmrMimvrqgWMcTqpJh793+ihcrT1hxB9Xs8zfLRIeHr3XxPPmJGch7KHrIGP5IqzQK/FemEWuShOkenu94ZuX280IHE5gW4Do5zYskmiJ1KMgizOIAlLnp2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MNhPpxwU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=34D+Lknin95BDmVnxH0FOybEL5Ad3zNpWSOxoPlyzfw=; b=MNhPpxwU3wgDbt226RI/uiMnPm
	bVLG+JhHVeJLDg39hDcM4OgEOqDOotsH5Yaut99RbDajcI92BYuuDT2PaJq+3d14gr65FyeYCBWqJ
	vv3U80ofwT3yWfpCJHXKaUwcNxLavHMdG17eO11x+MUouV7voODscmhv6DwZ+YWvpzYaK0msc8I7L
	KxAnF6iOCGWSvj59BE97IAgf5iyoUFIMX8Dz8PNJStKr9BIxMVL9S33q80T8ix5lRhBm/BuCtX7H0
	V69bzeHYI74XMztQ9dY6nY2WVVhjpiFZ4UXyMwgElUMa4Bt+yfWjyCNkOuR1ViRefUk299E4t5OVy
	LiNfg+dA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqgrF-00000005cwW-0wqH;
	Mon, 25 Aug 2025 23:44:13 +0000
Date: Tue, 26 Aug 2025 00:44:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/52] introduced guards for mount_lock
Message-ID: <20250825234413.GR39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-2-viro@zeniv.linux.org.uk>
 <20250825-repressiv-selektiert-7496db0b38aa@brauner>
 <20250825134604.GJ39973@ZenIV>
 <20250825202141.GA220312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825202141.GA220312@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 09:21:41PM +0100, Al Viro wrote:

> 	FWIW, I'm considering the possibility of having copy_tree() delay
> hashing all nodes in the copy and having them hashed all at once; fewer disruptions
> for lockless readers that way.  All nodes in the copy are reachable only for the
> caller; we do need mount_locked_reader for attaching a new node to copy (it has
> to be inserted into the per-mountpoint lists of mounts), but we don't need to
> bump the seqcount every time - and we can't hold a spinlock over allocations.
> It's not even that hard; all we'd need is a bit of a change in commit_tree()
> and in a couple of places where we create a namespace with more than one node -
> we have the loops in those places already where we insert the mounts into
> per-namespace rbtrees; same loops could handle hashing them.

The main issue I'm having with that is that currently "in list of children" implies
"hashed"; equivalent, even, except for a transient state seen only in mount_writer.
OTOH, having that not true for unreachable mounts...  I'm trying to find anything
that might care, but I don't see any candidates.

It would be nice to have regardless of doing fewer mount_lock seqcount bumps -
better isolation from shared data structures until we glue them in place would
make for simpler correctness proofs...

Anyway,
	copy_tree() call chains:
1.  copy_tree() <- propagate_mnt() <- attach_recursive_mnt(), with the call
chain prior to that point being one the
		<- graft_tree() <- do_loopback()
		<- graft_tree() <- do_add_mount() <- do_new_mount_fc()
		<- graft_tree() <- do_add_mount() <- finish_automount()
		<- do_move_mount().
All of those start inside a lock_mount scope.
Result gets passed (prior to return from attach_recursive_mnt(), within
an mnt_writer scope there) either to commit_tree() or to umount_tree(),
without having been visible to others prior to that.
	That's creation of secondary copies from mount propagation, for
various pathways to mounting stuff.

2.  copy_tree() <- __do_loopback() <- do_loopback().  Inside a lock_mount scope.
Result gets passed into graft_tree() -> attach_recursive_mnt().  In the latter
either it gets passed to commit_tree() (within mount_writer scope, without
having been visible to others prior to that), in which case success is reported,
or it is left alone and error gets reported; in that case back in do_loopback()
it gets passed to umount_tree(), again in mount_writer scope and without having
been visible to others prior to that.
	That's MS_BIND|MS_REC mount(2).

3.  copy_tree() <- __do_loopback() <- open_detached_copy().  In namespace_excl
scope.  Result is fed through a loop that inserts those mounts into rbtree
of new namespace (in mount_writer scope) and its root is stored as ->root
of that new namespace.  Once out of namespace_excl scope, the tree becomes
visible (and an extra reference is attached to the file we are opening).
	That's open_tree(2)/open_tree_attr(2) with OPEN_TREE_CLONE.
	BTW, a bit of mystery there: insertions into rbtree don't need to be in
mount_writer - we do have places where it's done without that, all readers are
in namespace_shared scopes *and* the namespace, along with its rbtree, is not
visible to anyone yet to start with.  If we delay hashing until there it will
need mount_writer, though.

4.  copy_tree() <- copy_mnt_ns().  In namespace_excl scope.  Somewhat similar
to the previous, but the namespace is not an anonymous one and we have a couple
of extra passes - one might do lock_mnt_tree() (under mount_writer, almost
certainly excessive - mount_locked_reader would do just fine) and another
(combined with rbtree insertions) finds the counterparts of root and pwd of
the caller and flips over to those.  Old ones get dropped after we leave
the scope.

Looks like we should be able to unify quite a bit of logics in populating
a new namespace and yes, delaying hash insertions past copy_tree() looks
plausible...

	Incidentally, destruction of new namespace on copy_tree() failure
is another mystery: here we do
                ns_free_inum(&new_ns->ns);
		dec_mnt_namespaces(new_ns->ucounts);
		mnt_ns_release(new_ns);
and in open_detached_copy() it's
	free_mnt_ns(ns);

They are similar - free_mnt_ns() is
	if (!is_anon_ns(ns))
		ns_free_inum(&ns->ns);
	dec_mnt_namespaces(ns->ucounts);
	mnt_ns_tree_remove(ns);
and mnt_ns_tree_remove() is a bunch of !is_anon_ns() code, followed by
an rcu-delayed mnt_ns_release().  So in case of open_detached_copy(),
where the namespace is anonymous, it boils down to an RCU-delayed
call of mnt_ns_release()...

AFAICS the only possible reasons not to use free_mnt_ns() here are
	1) avoiding an RCU-delayed call and
	2) conditional removal of ns from mnt_ns_tree.

As for the second, couldn't we simply use !list_empty(&ns->mnt_ns_list)
as a condition?  And avoiding an RCU delay... nice, in principle, but
the case when that would've saved us anything is CLONE_NEWNS clone(2) or
unshare(2) failing due to severe OOM.  Do we give a damn about one extra
call_rcu() for each of such failures?

mnt_ns_tree handling is your code; do you see any problems with

static void mnt_ns_tree_remove(struct mnt_namespace *ns)
{
	/* remove from global mount namespace list */
	if (!list_empty(&ns->mnt_ns_list)) {
		mnt_ns_tree_write_lock();
		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
		list_bidir_del_rcu(&ns->mnt_ns_list);
		mnt_ns_tree_write_unlock();
	}

	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
}
and
	mnt = __do_loopback(path, recursive);
	if (IS_ERR(mnt)) {
		emptied_ns = ns;
		namespace_unlock();
		return ERR_CAST(mnt);
	}
in open_detached_copy() and
	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
	if (IS_ERR(new)) {
		emptied_ns = new_ns;
		namespace_unlock();
		return ERR_CAST(new);
	}
in copy_mnt_ns()?

