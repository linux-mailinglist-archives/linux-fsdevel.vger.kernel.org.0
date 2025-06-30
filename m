Return-Path: <linux-fsdevel+bounces-53242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991FBAED286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C3F3AE48F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8617BB21;
	Mon, 30 Jun 2025 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GBAk8nwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75A29D05
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251914; cv=none; b=CCz54eoHAoUSGIpFwAv2Yype1yXngTuP6SSHnOEV6x0SrOp2Sw2L9pBmCc5vJQuZDIPUCI0eNqmKUoqWGtng0Pg7Y3oOpUddgxKaTX+nlGlN2e09D7YpqBOeajjwQF23p0rIcdRRIqXqeprQkMOWHFU/6to7x7ZN2HHA0wBlSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251914; c=relaxed/simple;
	bh=oQ9tnUaV7M6QSLxtKpSBx+fZkmW3LgmhRT/RapjqAh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAwcQjrRdvokkY0GIAPo7w0coPKGkjqlwT+HfTwQX5Q+D1GXQks8a7GLteqMHAHl1m4aeUYTumH2vqmWfR//lznx0eDeRdKfvP+qXdfaDJWWWJcwX6YOQYhhMXw5TDvvsVPX+q1eBeMmC14Ug2NpBO3wb6guBr90fblTwHj6+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GBAk8nwW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OP8xPgFe8ejbPm3BPCmC2bSZVhED0eaqQiQ/aEmZkdc=; b=GBAk8nwWElASsa/ArsBCJO+BBx
	gpnSThn69xV+8oGV9xLinQuDaR3Z9s832vSsovk/uMJK08Q35xqq/J/w2Ta8lxWaVvJNFEcthZqng
	Riqbk/gmnxSUNsi8/csSl2Igzzc8yEnx8LiihcVX6BGaAE/qwqpNIZMp62Dp2SZ9o/sfT7wNL6YSM
	dektWXfiIObKqK835old9iaPrTLxiveDevZ7PPUMWUiTJHg5BTg2/5ogeeTFC6I7UeyqQqlBY6PIr
	hy6XCAjtir2Cq0Nz1idmXjRuTo5gjCVXQM3/yHpiNTlZErSPOto8B7XhwqC/In6ZvPePK2Voek8+/
	Tq/g4NrA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4cW-00000005oYF-1RVr;
	Mon, 30 Jun 2025 02:51:48 +0000
Date: Mon, 30 Jun 2025 03:51:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCHES v3][RFC][CFR] mount-related stuff
Message-ID: <20250630025148.GA1383774@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250623044912.GA1248894@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623044912.GA1248894@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Updated variant (-rc4-based) force-pushed to
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
individual patches in followups.  It seems to survive testing here, but
more testing and review would be very welcome.  Again, that is not all -
there's more stuff coming...

Folks, please review - if nobody objects, it goes into #for-next in
a day or two.

Changes since v2:
Fixes went into mainline.

Added change_mnt_propagation() stuff: cleanups and getting rid of
potentially O(N^2) work in umount() - when a long slave list gets moved
from one doomed mount to another, with O(list length) work on each move.

In the same area, mnt_slave_list/mnt_slave turned into hlist.

Added propagate_mnt() series - refactoring instead of brute-force
"pass a structure around instead of playing with globals".

Added a few ->mnt_group_id-related cleanups.

New: ##32--44,46--48
Slight changes in #16 (Rewrite of propagate_umount()) and #30
(mount: separate the flags accessed only under namespace_sem).

	Rough overview:

Part 1: getting rid of mount hash conflicts for good
1) attach_mnt(): expand in attach_recursive_mnt(), then lose the flag argument
2) get rid of mnt_set_mountpoint_beneath()
3) prevent mount hash conflicts

Part 2: trivial cleanups and helpers:
4) copy_tree(): don't set ->mnt_mountpoint on the root of copy
5) constify mnt_has_parent()
6) pnode: lift peers() into pnode.h
7) new predicate: mount_is_ancestor()
8) constify is_local_mountpoint()
9) new predicate: anon_ns_root(mount)
10) dissolve_on_fput(): use anon_ns_root()
11) __attach_mnt(): lose the second argument
12) don't set MNT_LOCKED on parentless mounts
13) clone_mnt(): simplify the propagation-related logics
14) do_umount(): simplify the "is it still mounted" checks

Part 3: (somewhat of a side story) restore the machinery for long-term
mounts from accumulated bitrot.
15) sanitize handling of long-term internal mounts
	Still unchanged; might end up moved on top of #work.fs_context
with its change of vfs_fs_parse_string() calling conventions.

Part 4: propagate_umount() rewrite (posted last cycle)
16) Rewrite of propagate_umount()

Part 5: untangling do_move_mount()/attach_recursive_mnt().
17) make commit_tree() usable in same-namespace move case
18) attach_recursive_mnt(): unify the mnt_change_mountpoint() logics
19) attach_recursive_mnt(): pass destination mount in all cases
20) attach_recursive_mnt(): get rid of flags entirely
21) do_move_mount(): take dropping the old mountpoint into attach_recursive_mnt()
22) do_move_mount(): get rid of 'attached' flag

Part 6: change locking for expiry lists.
23) attach_recursive_mnt(): remove from expiry list on move
24) take ->mnt_expire handling under mount_lock [read_seqlock_excl]

Part 7: struct mountpoint massage.
25) pivot_root(): reorder tree surgeries, collapse unhash_mnt() and put_mountpoint()
26) combine __put_mountpoint() with unhash_mnt()
27) get rid of mountpoint->m_count

Part 8: regularize mount refcounting a bit
28) don't have mounts pin their parents

Part 9: propagate_mnt() massage
29) mount: separate the flags accessed only under namespace_sem
30) propagate_one(): get rid of dest_master
31) propagate_mnt(): handle all peer groups in the same loop
32) propagate_one(): separate the "do we need secondary here?" logics
33) propagate_one(): separate the "what should be the master for this copy" part
34) propagate_one(): fold into the sole caller
35) fs/pnode.c: get rid of globals
36) propagate_mnt(): get rid of last_dest
37) propagate_mnt(): fix comment and convert to kernel-doc, while we are at it

Part 10: change_mnt_propagation() massage
38) change_mnt_propagation() cleanups, step 1
39) change_mnt_propagation(): do_make_slave() is a no-op unless IS_MNT_SHARED()
	these two are preliminary massage, getting do_make_slave() into shape for
40) do_make_slave(): choose new master sanely
	... getting rid of excessive work on umount().  The thing is, when
mount stops propagating events (e.g. when it gets taken out), we need to
transfer its slave list to its peer (if exists) or to its master.  If there's
neither, we need to dissolve that slave list.
	Each member of slave list needs at least to have ->mnt_master switched
to new value.  Unfortunately, if the chosen new master is itself getting taken
out on the same umount(2), the entire thing needs to be repeated there, etc.
and it doesn't take much to construct a situation when we have 2N mounts and
umount(2) taking out half of them will end up moving the slave list (consisting
of the other half) through all of those, resulting in N^2 reassignments of
->mnt_master alone.  Not hard to avoid, we just need to figure out where the
thing will settle and transfer it there from the very beginning.
41) turn do_make_slave() into transfer_propagation()
	cleanup, getting the things into convenient shape for...
42) mnt_slave_list/mnt_slave: turn into hlist_head/hlist_node
	what it says on the can.
43) change_mnt_propagation(): move ->mnt_master assignment into MS_SLAVE case
	finishing touches on the cleanups series.

Part 11: misc stuff, will grow...
44) copy_tree(): don't link the mounts via mnt_list
45) take freeing of emptied mnt_namespace to namespace_unlock()
46) get rid of CL_SHARE_TO_SLAVE
47) invent_group_ids(): zero ->mnt_group_id always implies !IS_MNT_SHARED()
48) statmount_mnt_basic(): simplify the logics for group id

Diffstat:
 Documentation/filesystems/propagate_umount.txt | 484 +++++++++++++++++
 drivers/gpu/drm/i915/gem/i915_gemfs.c          |  21 +-
 drivers/gpu/drm/v3d/v3d_gemfs.c                |  21 +-
 fs/hugetlbfs/inode.c                           |   2 +-
 fs/mount.h                                     |  40 +-
 fs/namespace.c                                 | 711 ++++++++++---------------
 fs/pnode.c                                     | 697 ++++++++++++------------
 fs/pnode.h                                     |  27 +-
 include/linux/mount.h                          |  18 +-
 ipc/mqueue.c                                   |   2 +-
 10 files changed, 1216 insertions(+), 807 deletions(-)
 create mode 100644 Documentation/filesystems/propagate_umount.txt

