Return-Path: <linux-fsdevel+bounces-59137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F36B34BA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 22:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6534A7A56DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039442882A1;
	Mon, 25 Aug 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ML4AvzlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABD27F01B
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153307; cv=none; b=O13K1ELof57xPE2aThbYJXMHcxgdGxkB4T34bKjAbdG0guxf+bGn/EYw11l9X87NltwweHlS5wZYZ2rNXRXdCLgDadDRax0QWKY7o0qJoHEqo6p32eTawMv3k6wBtZ/DmhzrHBM61hAri1hPG37iMW4r1xlP35/7GjIw3jBRqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153307; c=relaxed/simple;
	bh=UhUYD1Z7GbGX9WVHbgKRNU+GklZRirGxbkUe6Uzyt5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC/JTv2clpoEFrADHyB1g3xQ6BftbG59ZdC/8Np9FO23UJmk/swCZd1i3tjB1UJ0LI9cMM8JQI6+OnmKoJO4V7LwSKBTBgY7uGd6Ep6GToRFitfHgtXmzFDwRyE71Ppl4/se91xjFf25INakNYaHABEmRMxLdgnTwTiJIxRXpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ML4AvzlZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gmkjd2wU6ik+nCMQUrLriYGg37qdIwtFgUmmGHao83A=; b=ML4AvzlZOZwvMdJm2J8KQaQlmg
	HkFueQ4ENS104WWDyR0xMynTsiYBFgCbmfCxeP38bZgpJqZrRl+QXN0Ys8NOHVlpThuoLtu7umX/p
	2UhbiHqhcIYEZE/1VkXIjS94vltURoAqnWN2QGwCkh7nKFq9n9bGuTi/lDxEw61+e+xekE7+93Zts
	vOOj9nWeoT2F3I8RLqytbt+RSJdPsltGplpmbRP5DDsCYMfBj92pfsfCx4YfdyRUGY2xTq2Kp4jFi
	BKTF8MULHrAZBHwI05VcJNBrFKLBgmZ9DyBqKMGvTALmMfS6YUmlVPTHaKLBPEnl69KEk4Gu/Wv1t
	eCmpW87Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqdhF-00000002VgP-0796;
	Mon, 25 Aug 2025 20:21:41 +0000
Date: Mon, 25 Aug 2025 21:21:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/52] introduced guards for mount_lock
Message-ID: <20250825202141.GA220312@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-2-viro@zeniv.linux.org.uk>
 <20250825-repressiv-selektiert-7496db0b38aa@brauner>
 <20250825134604.GJ39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825134604.GJ39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 02:46:04PM +0100, Al Viro wrote:

> Basically, there are 3 kinds of contexts here:
> 	1) lockless, must be under RCU, fairly limited in which pointers they
> can traverse, read-only access to structures in question.  Must sample
> the seqcount side of mount_lock first, then verifying that it has not changed
> after everything.
> 
> 	2) hold the spinlock side of mount_lock, _without_ bumping the seqcount
> one.  Can be used for reads and writes, as long as the stuff being modified
> is not among the things that is traversed locklessly.  Do not disrupt the previous
> class, have full exclusion with calles 2 and 3
> 
> 	3) hold the spinlock side of mount_lock, and bump the seqcount one on
> entry and leave.  Any reads and writes.  Full exclusion with classes 2 and 3,
> invalidates the checks for class 1 (i.e. will push it into retries/fallbacks/
> whatnot).

FWIW, partial dump from what I hope to push out as docs:

	* all modifications of mount hash chains must be mount_writer.
	* only one function is allowed to traverse hash chains - __lookup_mnt().
Important part here is reachability - hash is a shared data structure, but
a struct mount instance can be reached that way only if it has parent equal
to the argument you've been able to pass to __lookup_mnt().
	* callers of __lookup_mnt() must either be at least mount_locked_reader
OR hold rcu_read_lock through the entire thing, sample the seqcount side of
mount_lock before the call, validate it afterwards and discard the attempt
entirely if validation fails.  Note that __legitimize_mnt() contains validation.
	* being hashed contributes 1 to refcount.

	* (sub)tree topology (encoded in ->mnt_parent, ->mnt_mounts/->mnt_child,
->mnt_mp, ->mnt_mountpoint and ->overmount) is stabilize by either mount_locked_reader
OR by namespace_shared + positive refcount for root of subtree.
	namespace_shared by itself is *NOT* enough.  When the last reference to
mount past the umount_tree() (i.e. already with NULL ->mnt_ns) goes away, anything
subtree stuck to it will be detached from it and have its root unhashed and dropped.
In other words, such tree (e.g. result of umount -l) decays from root to leaves -
once all references to root are gone, it's cut off and all pieces are left
to decay.  That is done with mount_writer (has to be - there are mount hash changes
and for those mount_writer is a hard requirement) and only after the final reference
to root has been dropped.
	All other topology changes happen with namespace_excl and, at least,
mount_locked_reader.  Normally - with mount_writer; the only exception is that
setting parent for a newly allocated subtree is fine with mount_locked_reader;
we are not hashing it yet (that's done only in commit_tree()), so there's no
need to disrupt the lockless readers; note that RCU pathwalk *is* such, so
blind use of mount_writer has an effect on performance.
	->mnt_mounts/->mnt_child is never traversed unless the tree is stabilized
by either lock (note that list modifications there are not with ..._rcu() primitives).
->overmount, ->mnt_parent and ->mnt_mountpoint can be; those need sample/validate
on the seqcount side; it *would* require mount_write from those who modify them,
except that for the ones that had never been reachable yet we don't need to bother.
In practice, ->overmount is changed along with the mount hash, so we need mount_writer
anyway; ->mnt_parent/->mnt_mountpoint/->mnt_mp need it only for reachable mounts.
[[
	FWIW, I'm considering the possibility of having copy_tree() delay
hashing all nodes in the copy and having them hashed all at once; fewer disruptions
for lockless readers that way.  All nodes in the copy are reachable only for the
caller; we do need mount_locked_reader for attaching a new node to copy (it has
to be inserted into the per-mountpoint lists of mounts), but we don't need to
bump the seqcount every time - and we can't hold a spinlock over allocations.
It's not even that hard; all we'd need is a bit of a change in commit_tree()
and in a couple of places where we create a namespace with more than one node -
we have the loops in those places already where we insert the mounts into
per-namespace rbtrees; same loops could handle hashing them.
]]

	* propagation graph (->mnt_share, ->mnt_slave/->mnt_slave_list,
->mnt_master, ->mnt_group_id, IS_MNT_SHARED()) is modified only under
namespace_excl; all accesses are under at least namespace_shared.
Only mounts that belong to a namespace may be reached via those;
umount_tree() removed all victims from the graph before it returns
and it's impossible to include something that isn't a part of some
namespace into the graph afterwards.

	* ->mnt_expire is accessed (both traversals and modifications)
under mount_locked_reader.  No lockless traversals there.

	* per-namespace rbtree (->mnt_node linkage) is modified only
under namespace_excl and all traversals are at least namespace_shared.
Mount leaving a namespace is removed from that before the end of
namespace_excl scope.

	* ->mnt_root and ->mnt_sb are assign-once; never changed.  So's
->mnt_devname, ->mnt_id and ->mnt_id_unique.

	* per-mountpoint mount lists (->mnt_mp_list) are mount_locked_reader
for all accesses (modification and traversal along).

	* ->prev_ns is a fucking mess.

	* ->mnt_umount has only transient uses; umount_tree() uses it
to link the victims to be dropped at namespace_unlock(), final mntput
links the stuck children into a list stashed into ->mnt_stuch_children,
also for eventual dropping (by cleanup_mnt()).  mount_writer for gathering
them into those, nothing for "dissolve and drop everything on the list" -
in both cases the lists are visible only to a single thread by that point.

