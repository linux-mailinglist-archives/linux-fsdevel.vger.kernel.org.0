Return-Path: <linux-fsdevel+bounces-18210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DA98B684A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89338B21BF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FC310979;
	Tue, 30 Apr 2024 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcccXUih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650612E63;
	Tue, 30 Apr 2024 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447150; cv=none; b=b9hdB0EWP/woMXeQpZUMmx66bsrs6na0YO2kK17uZ9QGwLG76u9MDWBhdz8q+UdtJteiuE1y+BtWVwPCQccqX2ITgU4P24iHuvfJ1i1IKb/sIWoVDW+0q0FKXXaTUjIVdPnkvOZzi147pKWMX3l7Bh2NGhM+zLgq+xUbnxwoulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447150; c=relaxed/simple;
	bh=WXWIRp8b84gW40Oz6GIjp75D8fmFPc4voGJalTZbaqw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8VCbOtnFpGtps2AFqxICL4CwTbulFkoScjc9BIT76DHwZjfvjQDqvLmJXfssn64kaiHBbpPCfCrJ4OR+QQnLrwmkrJ40xuzsv3M3p1YiPwdnIumMVnIO9VIMIbLvBlvBZUG6Dm5fojBxGxWE+y5LQNk/pxziye77wmDSeXSwE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcccXUih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F2EC116B1;
	Tue, 30 Apr 2024 03:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447149;
	bh=WXWIRp8b84gW40Oz6GIjp75D8fmFPc4voGJalTZbaqw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XcccXUiha24WiDV3y9ZzKdNxfJEQyJ4GZ7qfYA/X4Zh4o12NBdgcGNynSmZ2acCo7
	 RNaykJADRA7S1dGaVGAqFGunZQAh+Fl16fMo/gEQJLRUxpwz3ai/hLn2hGKM3X3cvm
	 Si44FWOWp+kU4+iZbLUQkUFA4lsJzSur2cdWr8Zj3O2GkadqDyozSKn51JTZe+nG+V
	 LE5EGZVH410sfWcjHvS8zadghlfmu9tJqRqx6FAjgLY5fWCSuySAmpR5jeI3SxrS0m
	 vSUHOyy9ReZw+i6zPlFSy1yaQkYQVa6Q+yKAFdl2EZEh0ybTRVNj4z7eUX3dWa6IYS
	 zVjOlgrUsgc0Q==
Date: Mon, 29 Apr 2024 20:19:09 -0700
Subject: [PATCHSET v5.6] xfsprogs: fs-verity support for XFS
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: "Darrick J. Wong" <djwong@djwong.org>, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, fsverity@lists.linux.dev
Message-ID: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
In-Reply-To: <20240430031134.GH360919@frogsfrogsfrogs>
References: <20240430031134.GH360919@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This patchset adds support for fsverity to XFS.  In keeping with
Andrey's original design, XFS stores all fsverity metadata in the
extended attribute data.  However, I've made a few changes to the code:
First, it now caches merkle tree blocks directly instead of abusing the
buffer cache.  This reduces lookup overhead quite a bit, at a cost of
needing a new shrinker for cached merkle tree blocks.

To reduce the ondisk footprint further, I also made the verity
enablement code detect trailing zeroes whenever fsverity tells us to
write a buffer, and elide storing the zeroes.  To further reduce the
footprint of sparse files, I also skip writing merkle tree blocks if the
block contents are entirely hashes of zeroes.

Next, I implemented more of the tooling around verity, such as debugger
support, as much fsck support as I can manage without knowing the
internal format of the fsverity information; and added support for
xfs_scrub to read fsverity files to validate the consistency of the data
against the merkle tree.

Finally, I add the ability for administrators to turn off fsverity,
which might help recovering damaged data from an inconsistent file.

From Andrey Albershteyn:

Here's v5 of my patchset of adding fs-verity support to XFS.

This implementation uses extended attributes to store fs-verity
metadata. The Merkle tree blocks are stored in the remote extended
attributes. The names are offsets into the tree.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fsverity
---
Commits in this patchset:
 * fs: add FS_XFLAG_VERITY for verity files
 * xfs: use unsigned ints for non-negative quantities in xfs_attr_remote.c
 * xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
 * xfs: create a helper to compute the blockcount of a max sized remote value
 * xfs: minor cleanups of xfs_attr3_rmt_blocks
 * xfs: use an empty transaction to protect xfs_attr_get from deadlocks
 * xfs: add attribute type for fs-verity
 * xfs: do not use xfs_attr3_rmt_hdr for remote verity value blocks
 * xfs: add fs-verity ro-compat flag
 * xfs: add inode on-disk VERITY flag
 * xfs: add fs-verity support
 * xfs: use merkle tree offset as attr hash
 * xfs: advertise fs-verity being available on filesystem
 * xfs: report verity failures through the health system
 * xfs: enable ro-compat fs-verity flag
 * libfrog: add fsverity to xfs_report_geom output
 * xfs_db: introduce attr_modify command
 * xfs_db: add ATTR_PARENT support to attr_modify command
 * xfs_db: make attr_set/remove/modify be able to handle fs-verity attrs
 * man: document attr_modify command
 * xfs_db: create hex string as a field type
 * xfs_db: dump verity features and metadata
 * xfs_db: dump merkle tree data
 * xfs_db: dump the verity descriptor
 * xfs_db: don't obfuscate verity xattrs
 * xfs_db: dump the inode verity flag
 * xfs_db: compute hashes of merkle tree blocks
 * xfs_repair: junk fsverity xattrs when unnecessary
 * xfs_repair: clear verity iflag when verity isn't supported
 * xfs_repair: handle verity remote attrs
 * xfs_repair: allow upgrading filesystems with verity
 * xfs_scrub: check verity file metadata
 * xfs_scrub: validate verity file contents when doing a media scan
 * xfs_scrub: use MADV_POPULATE_READ to check verity files
 * xfs_spaceman: report data corruption
 * xfs_io: report fsverity status via statx
 * xfs_io: create magic command to disable verity
 * mkfs.xfs: add verity parameter
---
 configure.ac                    |    1 
 db/Makefile                     |    4 
 db/attr.c                       |  222 +++++++++++++++++++++-
 db/attrset.c                    |  237 ++++++++++++++++++++++-
 db/attrshort.c                  |   68 +++++++
 db/field.c                      |   31 +++
 db/field.h                      |    4 
 db/fprint.c                     |   24 ++
 db/fprint.h                     |    2 
 db/hash.c                       |   21 ++
 db/inode.c                      |    3 
 db/metadump.c                   |   16 +-
 db/sb.c                         |    2 
 db/write.c                      |    2 
 db/write.h                      |    1 
 include/builddefs.in            |    1 
 include/libxfs.h                |    1 
 include/linux.h                 |    4 
 include/platform_defs.h         |   13 +
 include/xfs_mount.h             |    2 
 io/attr.c                       |    2 
 io/scrub.c                      |   47 +++++
 libfrog/fsgeom.c                |    6 -
 libxfs/Makefile                 |    6 -
 libxfs/libxfs_api_defs.h        |    3 
 libxfs/xfs_ag.h                 |    8 +
 libxfs/xfs_attr.c               |   35 +++
 libxfs/xfs_attr_leaf.c          |    5 
 libxfs/xfs_attr_remote.c        |  199 +++++++++++++++----
 libxfs/xfs_attr_remote.h        |   12 +
 libxfs/xfs_da_format.h          |   55 +++++
 libxfs/xfs_format.h             |   15 +
 libxfs/xfs_fs.h                 |    2 
 libxfs/xfs_health.h             |    4 
 libxfs/xfs_inode_buf.c          |    8 +
 libxfs/xfs_inode_util.c         |    2 
 libxfs/xfs_log_format.h         |    1 
 libxfs/xfs_ondisk.h             |    5 
 libxfs/xfs_sb.c                 |    4 
 libxfs/xfs_shared.h             |    1 
 libxfs/xfs_verity.c             |   74 +++++++
 libxfs/xfs_verity.h             |   14 +
 m4/package_libcdev.m4           |   18 ++
 man/man2/ioctl_xfs_bulkstat.2   |    3 
 man/man2/ioctl_xfs_fsgetxattr.2 |    3 
 man/man8/mkfs.xfs.8.in          |    6 +
 man/man8/xfs_admin.8            |    6 +
 man/man8/xfs_db.8               |   47 ++++-
 man/man8/xfs_io.8               |    7 +
 mkfs/lts_4.19.conf              |    1 
 mkfs/lts_5.10.conf              |    1 
 mkfs/lts_5.15.conf              |    1 
 mkfs/lts_5.4.conf               |    1 
 mkfs/lts_6.1.conf               |    1 
 mkfs/lts_6.6.conf               |    1 
 mkfs/xfs_mkfs.c                 |   25 ++
 repair/attr_repair.c            |   44 ++++
 repair/dinode.c                 |   28 +++
 repair/globals.c                |    1 
 repair/globals.h                |    1 
 repair/phase2.c                 |   24 ++
 repair/xfs_repair.c             |   11 +
 scrub/Makefile                  |    4 
 scrub/inodes.h                  |   22 ++
 scrub/phase5.c                  |  182 ++++++++++++++++++
 scrub/phase6.c                  |  402 +++++++++++++++++++++++++++++++++++++++
 spaceman/health.c               |    4 
 67 files changed, 1918 insertions(+), 93 deletions(-)
 create mode 100644 libxfs/xfs_verity.c
 create mode 100644 libxfs/xfs_verity.h


