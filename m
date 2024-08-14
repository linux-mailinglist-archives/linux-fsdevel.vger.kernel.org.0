Return-Path: <linux-fsdevel+bounces-25916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE82951BD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D88AB23228
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0381B151B;
	Wed, 14 Aug 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjn9mCJk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F31B14F9;
	Wed, 14 Aug 2024 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642202; cv=none; b=I7yEYTHLJvs5lJxAOeQZy6mrnnHLOs8bTxjQZp4X0iwLb5r5mNeNEJ9WIMwIXS48kN+qJZ8lxaTVRDBLm5KstRCJTucTSNspM6Hwq/U/1vDR9INWJ1hMIXl+vTyh/YZW2AsGjs+mn133t4adFCXF7JF/Txw2PMnrS83ue99KGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642202; c=relaxed/simple;
	bh=r8U02fHcDjglTW1ClVVqzhXOPoM7YtNCoUpax9EOHuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MI+Xa9AbRYdBRYOiBkd5lzamg+BY119hkKh2Q4159SaPhCo4w+9EBeReUa3KOFSW8aD2qWQcHPs0v2EYOvNVipxbHcKmLy4ShErb4q6HKN+n+i1SBwJmrw9Q7lEl/3jeR9A6HidhdCkrCCyb0YeRsvX58WLMq2WtYWhCGq8G/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjn9mCJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FE7C32786;
	Wed, 14 Aug 2024 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723642201;
	bh=r8U02fHcDjglTW1ClVVqzhXOPoM7YtNCoUpax9EOHuA=;
	h=From:To:Cc:Subject:Date:From;
	b=bjn9mCJkWCILjYbICd0fecqIzkCxB3tkBgZFRU8EGY0X2ZuIdOcTiL4IDUaVhvzs7
	 kWK2XLtb2bVtrKB7kG5WfZHXo0XGJ/5L7C3FkwtU1wKQ0SrvwlV1CLIQskiVZAaQEC
	 2uIbVZiREp8+/tuv8rbNGnZgSjS4EZzQTNjrUREso0LJKQiQrwS7AWnWDKljZZL+Q7
	 qSQNgAaYnrDeKpwOqT55CQia1tGoh5ImPB3wTzbeeJLGwPU2maPIuDi7hvbTmJwF2d
	 vrDDgBgVgHolRbFZoWkVRrprSC++X56P5w/Fmrqlg4bzGKWSjOSCD8kBKKYes2qImY
	 EGci4jDfjobtg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Wed, 14 Aug 2024 15:29:46 +0200
Message-ID: <20240814-vfs-fixes-93bdbd119998@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5660; i=brauner@kernel.org; h=from:subject:message-id; bh=r8U02fHcDjglTW1ClVVqzhXOPoM7YtNCoUpax9EOHuA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTt2ejnr7vM4LDMuqtFhs9MLj3Z0Gj0VvxzespO/kVPy 50VsmVudpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzETY2R4e4TFomt3+d6rZTe knFyp1399nXusy9mNR3l7F587nqGuQDDXxnPIje2iKMfZ68SP8R4V/erS8eHFT5S525xas8OXlt nyQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */
This contains fixes for this merge window:

VFS:

-  Fix the name of file lease slab cache. When file leases were split out of
   file locks the name of the file lock slab cache was used for the file leases
   slab cache as well.

- Fix a type in take_fd() helper.

- Fix infinite directory iteration for stable offsets in tmpfs.

- When the icache is pruned all reclaimable inodes are marked with I_FREEING
  and other processes that try to lookup such inodes will block.

  But some filesystems like ext4 can trigger lookups in their inode evict
  callback causing deadlocks. Ext4 does such lookups if the ea_inode feature is
  used whereby a separate inode may be used to store xattrs.

  Introduce I_LRU_ISOLATING which pins the inode while its pages are
  reclaimed. This avoids inode deletion during inode_lru_isolate() avoiding the
  deadlock and evict is made to wait until I_LRU_ISOLATING is done.

netfs:

- Fault in smaller chunks for non-large folio mappings for filesystems that
  haven't been converted to large folios yet.

- Fix the CONFIG_NETFS_DEBUG config option. The config option was renamed a
  short while ago and that introduced two minor issues. First, it depended on
  CONFIG_NETFS whereas it wants to depend on CONFIG_NETFS_SUPPORT. The former
  doesn't exist, while the latter does. Second, the documentation for the
  config option wasn't fixed up.

- Revert the removal of the PG_private_2 writeback flag as ceph is using it and
  fix how that flag is handled in netfs.

- Fix DIO reads on 9p. A program watching a file on a 9p mount wouldn't see any
  changes in the size of the file being exported by the server if the file was
  changed directly in the source filesystem. Fix this by attempting to read the
  full size specified when a DIO read is requested.

- Fix a NULL pointer dereference bug due to a data race where a cachefiles
  cookies was retired even though it was still in use. Check the cookie's
  n_accesses counter before discarding it.

nsfs:

- Fix ioctl declaration for NS_GET_MNTNS_ID from _IO() to _IOR() as the kernel
  is writing to userspace.

pidfs:

- Prevent the creation of pidfds for kthreads until we have a use-case for it
  and we know the semantics we want. It also confuses userspace why they can
  get pidfds for kthreads.

squashfs:

- Fix an unitialized value bug reported by KMSAN caused by a corrupted symbolic
  link size read from disk. Check that the symbolic link size is not larger
  than expected.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc4.fixes

for you to fetch changes up to 810ee43d9cd245d138a2733d87a24858a23f577d:

  Squashfs: sanity check symbolic link size (2024-08-13 13:56:46 +0200)

----------------------------------------------------------------
vfs-6.11-rc4.fixes

----------------------------------------------------------------
Christian Brauner (2):
      nsfs: fix ioctl declaration
      pidfd: prevent creation of pidfds for kthreads

David Howells (2):
      netfs, ceph: Revert "netfs: Remove deprecated use of PG_private_2 as a second writeback flag"
      netfs: Fix handling of USE_PGPRIV2 and WRITE_TO_CACHE flags

Dominique Martinet (1):
      9p: Fix DIO read through netfs

Lukas Bulwahn (1):
      netfs: clean up after renaming FSCACHE_DEBUG config

Mathias Krause (1):
      file: fix typo in take_fd() comment

Matthew Wilcox (Oracle) (1):
      netfs: Fault in smaller chunks for non-large folio mappings

Max Kellermann (1):
      fs/netfs/fscache_cookie: add missing "n_accesses" check

Omar Sandoval (1):
      filelock: fix name of file_lease slab cache

Phillip Lougher (1):
      Squashfs: sanity check symbolic link size

Zhihao Cheng (1):
      vfs: Don't evict inode under the inode lru traversing context

yangerkun (1):
      libfs: fix infinite directory reads for offset dir

 Documentation/filesystems/caching/fscache.rst |   8 +-
 fs/9p/vfs_addr.c                              |   3 +-
 fs/afs/file.c                                 |   3 +-
 fs/ceph/addr.c                                |  28 ++++-
 fs/ceph/inode.c                               |   2 -
 fs/inode.c                                    |  39 ++++++-
 fs/libfs.c                                    |  35 ++++--
 fs/locks.c                                    |   2 +-
 fs/netfs/Kconfig                              |   2 +-
 fs/netfs/buffered_read.c                      | 123 +++++++++++++++++---
 fs/netfs/buffered_write.c                     |   2 +-
 fs/netfs/fscache_cookie.c                     |   4 +
 fs/netfs/io.c                                 | 161 +++++++++++++++++++++++++-
 fs/netfs/objects.c                            |  10 --
 fs/netfs/write_issue.c                        |   4 +-
 fs/nfs/fscache.c                              |   5 +-
 fs/nfs/fscache.h                              |   2 -
 fs/smb/client/file.c                          |   3 +-
 fs/squashfs/inode.c                           |   7 +-
 include/linux/file.h                          |   2 +-
 include/linux/fs.h                            |   5 +
 include/linux/netfs.h                         |   3 -
 include/trace/events/netfs.h                  |   2 +
 include/uapi/linux/nsfs.h                     |   3 +-
 kernel/fork.c                                 |  25 +++-
 25 files changed, 412 insertions(+), 71 deletions(-)

