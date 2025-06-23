Return-Path: <linux-fsdevel+bounces-52434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E343AE345C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D63188BC56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF51BD4F7;
	Mon, 23 Jun 2025 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nLZpoULY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D26134CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654157; cv=none; b=FskHyg4IaWKzbhbNQlyx1kTOuaK4Cc+gjulQ6nRPBe6Rr+Ya3vefyC4qvfk9ldyD+tEzBZ5w4XBAQMhLcHqCA88eTC5snO2oQHf5gp4zpjJ555dPtT+BtLAUYG5nnrHRbo0gT5veai50FepVzXZsyppkFZ6VllwZcKCgvKyaLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654157; c=relaxed/simple;
	bh=Ny+uK9zmGYUvfUsPKStEV5jKC5S2fCLMIwVT5ScAEUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvlPNMexb0e3yWqXRtvmpw79iIGiygBlAFtsAmVqJkwvI89SHgf/+HeFXXi1hos9hxJ9BdYLas5Om5B09SL8Er8gGzbcTG0v7n58igot/QQdyHE+zeb9EHcrg+2uA9dXJjXQ3+Y7qIS8EQzYIokSKjGqATLZ8XoYki14yz5/7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nLZpoULY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rX+hl2JkBy6DPhweM08IgGE4taov0sfxgzNykp3FyBM=; b=nLZpoULYKevJzBkTxmKehvhcA1
	2TIK3RuUX4S5d3pzQmJCxVxfSYOLKl05ICPlJxF9LBS7C2tzr1UW+FYdQSAnj8R/Luk+flgAxWY1o
	F5onGUIJ1yjc+75dfMc7aXFORMsvo6Rv4GxRI8ezftiH18Z7GDU+fhxozLWy/aReeWohXZ07g/3bm
	UlE2DWFjIK66ZSRIZlQCpINxYDPWSAttcrzXrXkGPKVE8lAXKeODeB/lS9B7t4d+sZx5lFjIOyeEA
	XJUGGBBByvLfqLrsQgEehMYzRE5xVnsaObIQRxGliwMoo99q6jdkjdwFYr1VoQoK2DBv4Q5ZaHebB
	GUhm8TxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZ7I-00000005GTm-17LY;
	Mon, 23 Jun 2025 04:49:12 +0000
Date: Mon, 23 Jun 2025 05:49:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCHES v2][RFC][CFR] mount-related stuff
Message-ID: <20250623044912.GA1248894@ZenIV>
References: <20250610081758.GE299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610081758.GE299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 10, 2025 at 09:17:58AM +0100, Al Viro wrote:
> 	The next pile of mount massage; it will grow - there will be
> further modifications, as well as fixes and documentation, but this is
> the subset I've got in more or less settled form right now.
> 
> 	Review and testing would be very welcome.
> 
> 	This series (-rc1-based) sits in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> individual patches in followups.

Updated variant force-pushed to
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
individual patches in followups.  It seems to survive testing here, but
more testing and review would be very welcome.  That's still not all -
there's more stuff in local queue, but it needs more massage; this is
the reasonably settled-down subset at the moment.

Changes since v1:
Added fixes (-stable fodder, IMO):
	replace collect_mounts()/drop_collected_mounts() with safer variant
	attach_recursive_mnt(): do not lock the covering tree when sliding something under it

Another thing that is probably a -stable candidate:
	prevent mount hash conflicts
That's an old headache hopefully taken care of; what we get out of it
is the warranty that there won't be more than one hashed mount with
given parent/mountpoint at any given time.  I've pulled that very
early in the sequence, so that we had a chance to backport it.
That comes with two prereqs (reordered from the middle of v1 series),
both should be trivial to backport.

Added cleanups:
	__attach_mnt(): lose the second argument
	copy_tree(): don't link the mounts via mnt_list
All uses of ->mnt_list are transient now - basically, various sets
used during umount_tree().
	mount: separate the flags accessed only under namespace_sem
Makes for simpler locking; some of the flags are accessed only under
namespace_sem, and we already rely upon that in the readers; taking
them to a separate word avoids the need to grab mount_lock on the
write side.
	propagate_one(): get rid of dest_master
	propagate_mnt(): get rid of globals
Linus asked to get rid of fs/pnode.c globals; done.
	take freeing of emptied mnt_namespace to namespace_unlock()

A couple of commits made simpler by "prevent mount hash conflicts" -
	Rewrite of propagate_umount()
reparenting is guaranteed that there won't be more than one overmount now,
no loop needed.
	don't have mounts pin their parents
simpler logics for "is there something other than overmount?"

	Rough overview:

Part 1: fixes

1) replace collect_mounts()/drop_collected_mounts() with safer variant
2) attach_recursive_mnt(): do not lock the covering tree when sliding something under it

Part 2: getting rid of mount hash conflicts for good

3) attach_mnt(): expand in attach_recursive_mnt(), then lose the flag argument
4) get rid of mnt_set_mountpoint_beneath()
5) prevent mount hash conflicts

Part 3: trivial cleanups and helpers:

6) copy_tree(): don't set ->mnt_mountpoint on the root of copy
7) constify mnt_has_parent()
8) pnode: lift peers() into pnode.h
9) new predicate: mount_is_ancestor()
10) constify is_local_mountpoint()
11) new predicate: anon_ns_root(mount)
12) dissolve_on_fput(): use anon_ns_root()
13) __attach_mnt(): lose the second argument
	... and rename to make_visible()
14) don't set MNT_LOCKED on parentless mounts
15) clone_mnt(): simplify the propagation-related logics
16) do_umount(): simplify the "is it still mounted" checks

Part 4: (somewhat of a side story) restore the machinery for long-term
mounts from accumulated bitrot.

17) sanitize handling of long-term internal mounts

Part 5: propagate_umount() rewrite (posted last cycle)

18) Rewrite of propagate_umount()

Part 6: untangling do_move_mount()/attach_recursive_mnt().

19) make commit_tree() usable in same-namespace move case
20) attach_recursive_mnt(): unify the mnt_change_mountpoint() logics
21) attach_recursive_mnt(): pass destination mount in all cases
22) attach_recursive_mnt(): get rid of flags entirely
23) do_move_mount(): take dropping the old mountpoint into attach_recursive_mnt()
24) do_move_mount(): get rid of 'attached' flag

Part 7: change locking for expiry lists.
25) attach_recursive_mnt(): remove from expiry list on move
26) take ->mnt_expire handling under mount_lock [read_seqlock_excl]

Part 8: struct mountpoint massage.
27) pivot_root(): reorder tree surgeries, collapse unhash_mnt() and put_mountpoint()
28) combine __put_mountpoint() with unhash_mnt()
29) get rid of mountpoint->m_count

Part 9: regularize mount refcounting a bit
30) don't have mounts pin their parents

Part 10: misc stuff, will grow...
31) copy_tree(): don't link the mounts via mnt_list
32) mount: separate the flags accessed only under namespace_sem
33) propagate_one(): get rid of dest_master
34) propagate_mnt(): get rid of globals
35) take freeing of emptied mnt_namespace to namespace_unlock()

Diffstat:
 Documentation/filesystems/porting.rst          |   9 +
 Documentation/filesystems/propagate_umount.txt | 484 +++++++++++++++
 drivers/gpu/drm/i915/gem/i915_gemfs.c          |  21 +-
 drivers/gpu/drm/v3d/v3d_gemfs.c                |  21 +-
 fs/hugetlbfs/inode.c                           |   2 +-
 fs/mount.h                                     |  36 +-
 fs/namespace.c                                 | 783 +++++++++++--------------
 fs/pnode.c                                     | 499 ++++++++--------
 fs/pnode.h                                     |  28 +-
 include/linux/mount.h                          |  24 +-
 ipc/mqueue.c                                   |   2 +-
 kernel/audit_tree.c                            |  63 +-
 12 files changed, 1214 insertions(+), 758 deletions(-)
 create mode 100644 Documentation/filesystems/propagate_umount.txt

