Return-Path: <linux-fsdevel+bounces-59530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA3EB3ADF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19BC58174A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE8B2C2341;
	Thu, 28 Aug 2025 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GtWzUSym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495B2BE653
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422431; cv=none; b=IAN9Y+7nDYTshYRtx/TOwC6qlB8GWWZW1Xq/BHonOhKuWjkoN1oljvn+gIG6MhJZIicN4PvPfrhly6rHoQPS0I7W/iKFM/xvPv1lbdanqbj2PG1X3EOL8QBFU1KNOkL4I8+SAuytbakZuSbadrRen3aTQeHG7AcDchDmn3pUab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422431; c=relaxed/simple;
	bh=TGOSfK7jbpnbGfqc52s0Dv6XwVdp9ahbKBdD+jYkHQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwUZ7jtXWl1dYJhwmTb1QIRHeKpSQKfDBc50DcNN9Eu/AUGb7MxgdTNi6GjQgc4D07BhtKVQqLdfZlcEEngcxOPeNSZIJTBHYIjK586PxjLvS+zIsbx1w1chYgsmr8bA+dqbz+zfr/2EJNNYpmBprXK8a/v3zMZPNDpjr+r1ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GtWzUSym; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N2A1Pfy56UWsn31MGi62N9L/Sl0sCtz19axc3WbsAKA=; b=GtWzUSymoDj98VFbYSfzHVAXXk
	oIlNofJhXyp0mWe7IORBZTvpc/rbosa8yCxFFq6Pgxf4g+8QuFUmLgHWHFCBUQ5IrIeA6a4X/Kohi
	6unVXP6UZHNOfAW9y7UWvefRR4sSCUXeS8j9Y0D9t9yBu6AbQZGQg5PrVNlYb6I59bjgKIYz0zU2Z
	4TVb+nIViwcMUZ3xi8ksCzhr6f90FJU28E09Rt4uM+3l9/L30M7YKC+BCSpUWS4kocPDqQPROip8w
	ZkzsQvq/+XuZmrbloYXacUErGo/zM8pyVtBhHZrkBYW/PhtALa90C8FKDfamoRIxb8h/KPVHTvPeA
	oSP2H7NQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlhy-0000000F1JF-3sL3;
	Thu, 28 Aug 2025 23:07:07 +0000
Date: Fri, 29 Aug 2025 00:07:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCHES v2][RFC][CFT] mount-related stuff
Message-ID: <20250828230706.GA3340273@ZenIV>
References: <20250825044046.GI39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825044046.GI39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Branch force-pushed into
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
(also visible as #v2.mount, #v1.mount being the previous version)
Individual patches in followups.

Still -rc3-based, seems to survive local beating.  Please, help with
review and testing.

Note: no links in commits, I still don't understand what kind of use is
expected in this situation.

Changes since v1 (aside of reviewed-by applied):

	In #13, #14 and #15 scoped_guard replaced with guard.  I don't like
it, but I can live with it.

	Between old #18 and #19: do_new_mount_fc() switched to use of fc_mount().
vfs_get_tree() call moved from the caller into the function itself, unlock +
vfs_create_mount() reordered to before the checks in there and collapsed with
vfs_get_tree() into a call of fc_mount().  Cleanup aside, that avoids the
difference between the lexical scope of mnt and the actual lifetime of that
reference.
	Differs from the variant posted in https://lore.kernel.org/all/20250826182124.GV39973@ZenIV/
only by fixing an obvious braino - fetching fc->root->d_sb should be done after
successful fc_mount(), not before it.
	That change modifies old #25 (now #26) "do_new_mount_rc(): use __free()
to deal with dropping mnt on failure".

	Added to the end of queue: cleanup of populating a new namespace with
a tree (open_detached_copy() and copy_mnt_ns()); both end up using guards, BTW. 
	5 commits, #54..#58
	* open_detached_copy(): don't bother with mount_lock_hash()
It's useless there right now - namespace_excl is quite enough.
	* open_detached_copy(): separate creation of namespace into helper
Creation of namespace and opening that FMODE_NEED_UNMOUNT file are better
off separated - cleaner that way.
	* mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list
Currently it (and free_mnt_ns()) can't be used with non-anon namespace before
the insertion into mnt_ns_tree; very easy to make it work in such situation as
well - in fact, the old "is it non-anonymous" check is not needed anymore.
	* copy_mnt_ns(): use the regular mechanism for freeing empty mnt_ns on failure
Use the previous patch to avoid weird open-coding of free_mnt_ns().
	* copy_mnt_ns(): use guards
... and __free(mntput) for rootmnt/pwdmnt.

	Added to the end of queue: handling of ->s_mounts/->mnt_instance and
mnt_hold_writers().
	Each mount is associated with the same dentry (sub)tree of the same
filesystem through its entire lifetime.  They are allocated empty, then (in the
same function that had called allocator) attached to dentry tree and stay like
that all the way to destructor (cleanup_mnt()).
	Unfortunately, as soon as they are attached to a tree, they become
reachable from shared data structures - we maintain the set of all mounts
associated with given superblock.  Having to worry about that while we are
still setting them up is inconvenient.  Thankfully, the accesses via that set
are *very* limited - only sb_prepare_remount_readonly() goes there and the
only thing it does to a mount is setting/clearing MNT_WRITE_HOLD and checking
the write count (guaranteed to be zero during setup, since there's nobody
who could've asked for write access by that point).
	Turns out it's easy to take MNT_WRITE_HOLD out of ->mnt_flags and
basically move it into the same thing that establishes linkage in per-superblock
set of mounts.  That makes accesses via that set isolated from the rest of
struct mount; as far as we are concerned, this set is no longer a way to reach
the mount from shared data structures and mount remains private to caller
until it is explicitly made reachable (by mounting, attaching to overlayfs as
a layer, etc.).
	FWIW, I think we should get rid of the "empty" state of struct mount
and have allocator take the root dentry as additional argument.  Hadn't done
that yet; this series removes the need to delay attaching a partially set up
mount to filesystem - we can do that from the very beginning now.
	5 commits, #59..#63
	* setup_mnt(): primitive for connecting a mount to filesystem
Identical logics in clone_mnt() and vfs_create_mount() => common helper
	* preparations to taking MNT_WRITE_HOLD out of ->mnt_flags
Change the representation of set from list_head list to something equivalent
to hlist one, with forward linkage going to the entire struct mount rather
than embedded hlist_node.
	* struct mount: relocate MNT_WRITE_HOLD bit
Steal the LSB of back links in the set representation to store it.  We only
traverse the list forwards and all changes are under mount_lock, same as
for all mnt_hold_writers()/mnt_unhold_writers() pairs, so it's pretty
uncomplicated.
	* simplify the callers of mnt_unhold_writers()
	* WRITE_HOLD machinery: no need for to bump mount_lock seqcount
The last part is another group of "we only need mount_locked_reader" cases

Diffstat:
 fs/ecryptfs/dentry.c          |  14 +-
 fs/ecryptfs/ecryptfs_kernel.h |  27 +-
 fs/ecryptfs/file.c            |  15 +-
 fs/ecryptfs/inode.c           |  19 +-
 fs/ecryptfs/main.c            |  24 +-
 fs/internal.h                 |   4 +-
 fs/mount.h                    |  16 +-
 fs/namespace.c                | 989 +++++++++++++++++++-----------------------
 fs/pnode.c                    |  75 +++-
 fs/pnode.h                    |   1 +
 fs/super.c                    |   3 +-
 include/linux/fs.h            |   2 +-
 include/linux/mount.h         |   7 +-
 kernel/audit_tree.c           |  12 +-
 14 files changed, 573 insertions(+), 635 deletions(-)

