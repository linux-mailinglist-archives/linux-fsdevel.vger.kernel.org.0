Return-Path: <linux-fsdevel+bounces-15702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3DB89281C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7487281AC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101D187F;
	Sat, 30 Mar 2024 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWTlR7kV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADF17CD;
	Sat, 30 Mar 2024 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758760; cv=none; b=FihaHh+pMcoLPYuUuUQXAQh/Hk3uV589qIho04swcSVIhpqPT84BMEprEkdWx/M35b0TNsvDtz7a/GsCHunRPD12nFqud9TaHwNG4VJaL6I9LxSF5B8BHeEzACn45P7rSAEqsTVmch6m8JbLr9axUbdTaRO3/H5ohIEF1fqhhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758760; c=relaxed/simple;
	bh=NufIpT5aj+DHY8S5LHCIAS+wPWao9ep18Kyz8hrSfEE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJDkCinmgQvXdVDFRgZIxjush2JvtIE6hIfFyF8OE1ukIxseIt+DPe84hxq20HFCtLs2G8iyNAMKZ7Uc0NJD9SS2QIgACoq0eEt5oGyox6QhJYJ0szsmGCAlhphcY+Mq12WzfpeAo/8ctvSBe6zobpxkXQ6vumKYIAhoV3Zst4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWTlR7kV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E726C433F1;
	Sat, 30 Mar 2024 00:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758760;
	bh=NufIpT5aj+DHY8S5LHCIAS+wPWao9ep18Kyz8hrSfEE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AWTlR7kVnezCB3d8Ti5n4CCqVsDv/wMwfY3mvCrO2kSf/2iGupxLGJsyICKiKATfT
	 t06ShBCBzBTPSuojsj4ccSDIay28BJt8lTloWuz02Pbf/3OVSs5NsQbqzlCJdpjNz7
	 isUL5tXgRO8ieS5bOg9V0aeyvSc1F60gdjUEOOMPguHyxKS+t+PsU5hUqPQ6i6B2yY
	 f7i/2BgvKFzbhgZNvVGkh5IzoxpAc07mcQoxAZ2hBoDPTlbEK7d8FxpLp7ZDM1AiLH
	 DVxzmd+TZi/5glB39cXrLdy2QoezOhqr8O69hZZcuqvdmxj+/Wj7A+RxylOyro2jgK
	 SXpn2XV8WIOIg==
Date: Fri, 29 Mar 2024 17:32:40 -0700
Subject: [PATCHSET v5.5 2/2] xfs: fs-verity support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
In-Reply-To: <20240330003039.GT6390@frogsfrogsfrogs>
References: <20240330003039.GT6390@frogsfrogsfrogs>
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

A few key points of this patchset:
- fs-verity can work with Merkle tree blocks based caching (xfs) and
  PAGE caching (ext4, f2fs, btrfs)
- iomap does fs-verity verification
- In XFS, fs-verity metadata is stored in extended attributes
- per-sb workqueue for verification processing
- Inodes with fs-verity have new on-disk diflag
- xfs_attr_get() can return a buffer with an extended attribute
- xfs_buf can allocate double space for Merkle tree blocks. Part of
  the space is used to store  the extended attribute data without
  leaf headers
- xfs_buf tracks verified status of merkle tree blocks

Testing:
The patchset is tested with xfstests -g verity on xfs_1k, xfs_4k,
xfs_1k_quota, xfs_4k_quota, ext4_4k, and ext4_4k_quota. With
KMEMLEAK and KASAN enabled. More testing on the way.

Changes from V4:
- Mainly fs-verity changes; removed unnecessary functions
- Replace XFS workqueue with per-sb workqueue created in
  fsverity_set_ops()
- Drop patch with readahead calculation in bytes
Changes from V3:
- redone changes to fs-verity core as previous version had an issue
  on ext4
- add blocks invalidation interface to fs-verity
- move memory ordering primitives out of block status check to fs
  read block function
- add fs-verity verification to iomap instead of general post read
  processing
Changes from V2:
- FS_XFLAG_VERITY extended attribute flag
- Change fs-verity to use Merkle tree blocks instead of expecting
  PAGE references from filesystem
- Change approach in iomap to filesystem provided bio_set and
  submit_io instead of just callouts to filesystem
- Add possibility for xfs_buf allocate more space for fs-verity
  extended attributes
- Make xfs_attr module to copy fs-verity blocks inside the xfs_buf,
  so XFS can get data without leaf headers
- Add Merkle tree removal for error path
- Makae scrub aware of new dinode flag
Changes from V1:
- Added parent pointer patches for easier testing
- Many issues and refactoring points fixed from the V1 review
- Adjusted for recent changes in fs-verity core (folios, non-4k)
- Dropped disabling of large folios
- Completely new fsverity patches (fix, callout, log_blocksize)
- Change approach to verification in iomap to the same one as in
  write path. Callouts to fs instead of direct fs-verity use.
- New XFS workqueue for post read folio verification
- xfs_attr_get() can return underlying xfs_buf
- xfs_bufs are marked with XBF_VERITY_CHECKED to track verified
  blocks

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
 * xfs: use unsigned ints for non-negative quantities in xfs_attr_remote.c
 * xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
 * xfs: create a helper to compute the blockcount of a max sized remote value
 * xfs: minor cleanups of xfs_attr3_rmt_blocks
 * xfs: add attribute type for fs-verity
 * xfs: do not use xfs_attr3_rmt_hdr for remote verity value blocks
 * xfs: add fs-verity ro-compat flag
 * xfs: add inode on-disk VERITY flag
 * xfs: initialize fs-verity on file open and cleanup on inode destruction
 * xfs: don't allow to enable DAX on fs-verity sealed inode
 * xfs: disable direct read path for fs-verity files
 * xfs: widen flags argument to the xfs_iflags_* helpers
 * xfs: add fs-verity support
 * xfs: create a per-mount shrinker for verity inodes merkle tree blocks
 * xfs: create an icache tag for files with cached merkle tree blocks
 * xfs: shrink verity blob cache
 * xfs: only allow the verity iflag for regular files
 * xfs: don't store trailing zeroes of merkle tree blocks
 * xfs: use merkle tree offset as attr hash
 * xfs: don't bother storing merkle tree blocks for zeroed data blocks
 * xfs: add fs-verity ioctls
 * xfs: advertise fs-verity being available on filesystem
 * xfs: make scrub aware of verity dinode flag
 * xfs: teach online repair to evaluate fsverity xattrs
 * xfs: report verity failures through the health system
 * xfs: clear the verity iflag when not appropriate
 * xfs: make it possible to disable fsverity
 * xfs: allow verity files to be opened even if the fsverity metadata is damaged
 * xfs: enable ro-compat fs-verity flag
---
 fs/iomap/buffered-io.c          |    8 
 fs/xfs/Makefile                 |    2 
 fs/xfs/libxfs/xfs_attr.c        |   56 ++-
 fs/xfs/libxfs/xfs_attr.h        |    1 
 fs/xfs/libxfs/xfs_attr_leaf.c   |    5 
 fs/xfs/libxfs/xfs_attr_remote.c |  192 +++++++--
 fs/xfs/libxfs/xfs_attr_remote.h |   12 -
 fs/xfs/libxfs/xfs_da_format.h   |   54 ++
 fs/xfs/libxfs/xfs_format.h      |   15 -
 fs/xfs/libxfs/xfs_fs.h          |    2 
 fs/xfs/libxfs/xfs_fs_staging.h  |    3 
 fs/xfs/libxfs/xfs_health.h      |    4 
 fs/xfs/libxfs/xfs_inode_buf.c   |    8 
 fs/xfs/libxfs/xfs_inode_util.c  |    2 
 fs/xfs/libxfs/xfs_log_format.h  |    1 
 fs/xfs/libxfs/xfs_ondisk.h      |    5 
 fs/xfs/libxfs/xfs_sb.c          |    4 
 fs/xfs/libxfs/xfs_shared.h      |    1 
 fs/xfs/libxfs/xfs_verity.c      |   74 +++
 fs/xfs/libxfs/xfs_verity.h      |   14 +
 fs/xfs/scrub/attr.c             |  141 ++++++
 fs/xfs/scrub/attr.h             |    6 
 fs/xfs/scrub/attr_repair.c      |   50 ++
 fs/xfs/scrub/inode_repair.c     |    2 
 fs/xfs/scrub/reap.c             |    4 
 fs/xfs/scrub/trace.c            |    1 
 fs/xfs/scrub/trace.h            |   31 +
 fs/xfs/xfs_attr_inactive.c      |    2 
 fs/xfs/xfs_file.c               |   40 ++
 fs/xfs/xfs_fsverity.c           |  867 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h           |   32 +
 fs/xfs/xfs_health.c             |    1 
 fs/xfs/xfs_icache.c             |   85 ++++
 fs/xfs/xfs_icache.h             |    8 
 fs/xfs/xfs_inode.h              |   19 +
 fs/xfs/xfs_ioctl.c              |   27 +
 fs/xfs/xfs_iops.c               |    4 
 fs/xfs/xfs_mount.c              |   10 
 fs/xfs/xfs_mount.h              |    8 
 fs/xfs/xfs_super.c              |   19 +
 fs/xfs/xfs_trace.h              |   79 ++++
 fs/xfs/xfs_xattr.c              |   10 
 42 files changed, 1832 insertions(+), 77 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_verity.c
 create mode 100644 fs/xfs/libxfs/xfs_verity.h
 create mode 100644 fs/xfs/xfs_fsverity.c
 create mode 100644 fs/xfs/xfs_fsverity.h


