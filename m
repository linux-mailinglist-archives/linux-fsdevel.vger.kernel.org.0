Return-Path: <linux-fsdevel+bounces-38445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF3A02ABB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283661881807
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F09155300;
	Mon,  6 Jan 2025 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO8xTxxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F907BA34;
	Mon,  6 Jan 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177795; cv=none; b=Tm3093bhrp9KiP1oqjVHTPpLhgnjWh+DJ8rGZg8kwa9T1a4NNM2XH3Q5J2DtXpfy8RSu2Jin1FZ4g7zhWp1fUW2mIZ8jcC6V0exfM38LFXZleBlYAPFXRl2/xvsrPtU3s+CQ7w0Y0oG4q4gaYYlYjA99LcOpbPWeT4bEjczA3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177795; c=relaxed/simple;
	bh=iiynLgs3P+7Sxa9qn+UPkCEgB1748cx6ki83a7aJJUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdOVgwSbZ1k6r8W1/cxxlx8U3fTCjxbsmmd31wFd8PBFw4Nj4aA/ZjMEdLVMCgAcolyCNeUFk3HUJUPKXoUw4jsi8DihVu9vBqjbTyESLC21PBdcpji8+yHHWwkZq/G1l9NnqiKmEc3fjSKtlrr3ick+nGEoTqB9pmxoTe5vECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO8xTxxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201F6C4CED2;
	Mon,  6 Jan 2025 15:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736177795;
	bh=iiynLgs3P+7Sxa9qn+UPkCEgB1748cx6ki83a7aJJUY=;
	h=From:To:Cc:Subject:Date:From;
	b=XO8xTxxgn9RBBtJdQR8s030W/QGQPzPOnxLOYJFiEcb7cFPvyloouuDmIXsKYvl9T
	 G1Omck0VqqXGJ0yq0dL9SA21IPT2g9tPwYporcZ7hOrUfaVfTogex+hhYXv8+Tluyx
	 aKpLIsygvFuULLZs5+sDnVco10Op2hQFh8fwIPD8AtsH37iyTTNU/Q2Iz44wPfFpJu
	 kJ1ElV1jGl+7WjHwyCaIS0mhdtsywj/TesUQVnOmOMwWMjOrAoHOdbFFVh4NvpHY3n
	 ffUUsnYXTsB01QTo7eJgUtzyR0fQ8kqnZwzlWfeK8elnxf8EG1b9Zzd96lJppDuIl7
	 Ywc0Vl0AdlyTw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon,  6 Jan 2025 16:32:26 +0100
Message-ID: <20250106-vfs-fixes-5a197ffbc262@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6782; i=brauner@kernel.org; h=from:subject:message-id; bh=iiynLgs3P+7Sxa9qn+UPkCEgB1748cx6ki83a7aJJUY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRX/6hWcliSO/fpwcLIlrr+wqcs+4wnvD3+4dKaW6pp8 7h6nxn+6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjITR9Ghqf2mZEiPyQucXnO nnVirljGXzaX7Ya2JmcnCiw3+XH+ZRrD/8yTx3pO2B8/UqWTEWGmGSVQlCu0zPZb667fEWUuH3R 3sQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

slowly resurrecting from the holidays... What year is it? And have we
already started generating pull requests with AI?

/* Summary */

This contains various fixes for this cycle:

- Relax assertions on failure to encode file handles.
  The ->encode_fh() method can fail for various reasons. None of them
  warrant a WARN_ON().

- Fix overlayfs file handle encoding by allowing encoding an fid from an
  inode without an alias.

- Make sure fuse_dir_open() handles FOPEN_KEEP_CACHE. If it's not
  specified fuse needs to invaludate the directory inode page cache.

- Fix qnx6 so it builds with gcc-15.

- Various fixes for netfslib and ceph and nfs filesystems:

  - Ignore silly rename files from afs and nfs when building header archives.

  - Fix read result collection in netfslib with multiple subrequests.

  - Handle ENOMEM for netfslib buffered reads.

  - Fix oops in nfs_netfs_init_request().

  - Parse the secctx command immediately in cachefiles.

  - Remove a redundant smp_rmb() in netfslib.

  - Handle recursion in read retry in netfslib.

  - Fix clearing of folio_queue.

  - Fix missing cancellation of copy-to_cache when the cache for a file
    is temporarly disabled in netfslib.

- Sanity check the hfs root record.

- Fix zero padding data issues in concurrent write scenarios.

- Fix is_mnt_ns_file() after converting nsfs to path_from_stashed().

- Fix missing declaration of init_files.

- Increase I/O priority when writing revoke records in jbd2.

- Flush filesystem device before updating tail sequence in jbd2.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

- There will be a small merge conflict with mainline. The conflict
  resolution should like this:

diff --cc fs/smb/client/smb2pdu.c
index 959359301250,458b53d1f9cb..000000000000
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@@ -4840,12 -4841,12 +4841,14 @@@ smb2_writev_callback(struct mid_q_entr
                if (written > wdata->subreq.len)
                        written &= 0xFFFF;

 +              cifs_stats_bytes_written(tcon, written);
 +
-               if (written < wdata->subreq.len)
+               if (written < wdata->subreq.len) {
                        wdata->result = -ENOSPC;
-               else
+               } else if (written > 0) {
                        wdata->subreq.len = written;
+                       __set_bit(NETFS_SREQ_MADE_PROGRESS, &wdata->subreq.flags);
+               }
                break;
        case MID_REQUEST_SUBMITTED:
        case MID_RETRY_NEEDED:

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc7.fixes

for you to fetch changes up to 368fcc5d3f8bf645a630a44e65f5eb008aba7082:

  Merge patch series "Fix encoding overlayfs fid for fanotify delete events" (2025-01-06 15:43:58 +0100)

Please consider pulling these changes from the signed vfs-6.13-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13-rc7.fixes

----------------------------------------------------------------
Amir Goldstein (4):
      fs: relax assertions on failure to encode file handles
      fuse: respect FOPEN_KEEP_CACHE on opendir
      ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
      ovl: support encoding fid from inode with no alias

Brahmajit Das (1):
      fs/qnx6: Fix building with GCC 15

Christian Brauner (4):
      Merge patch series "jbd2: two straightforward fixes"
      Merge patch series "iomap: fix zero padding data issue in concurrent append writes"
      Merge patch series "netfs, ceph, nfs, cachefiles: Miscellaneous fixes/changes"
      Merge patch series "Fix encoding overlayfs fid for fanotify delete events"

David Howells (9):
      kheaders: Ignore silly-rename files
      netfs: Fix non-contiguous donation between completed reads
      netfs: Fix enomem handling in buffered reads
      nfs: Fix oops in nfs_netfs_init_request() when copying to cache
      netfs: Fix missing barriers by using clear_and_wake_up_bit()
      netfs: Work around recursion by abandoning retry if nothing read
      netfs: Fix ceph copy to cache on write-begin
      netfs: Fix the (non-)cancellation of copy when cache is temporarily disabled
      netfs: Fix is-caching check in read-retry

Leo Stone (1):
      hfs: Sanity check the root record

Long Li (2):
      iomap: pass byte granular end position to iomap_add_to_ioend
      iomap: fix zero padding data issue in concurrent append writes

Max Kellermann (1):
      cachefiles: Parse the "secctx" immediately

Miklos Szeredi (1):
      fs: fix is_mnt_ns_file()

Zhang Kunbo (1):
      fs: fix missing declaration of init_files

Zhang Yi (2):
      jbd2: increase IO priority for writing revoke records
      jbd2: flush filesystem device before updating tail sequence

Zilin Guan (1):
      netfs: Remove redundant use of smp_rmb()

 fs/9p/vfs_addr.c         |  6 ++++-
 fs/afs/write.c           |  5 +++-
 fs/cachefiles/daemon.c   | 14 +++++-----
 fs/cachefiles/internal.h |  3 ++-
 fs/cachefiles/security.c |  6 ++---
 fs/file.c                |  1 +
 fs/fuse/dir.c            |  2 ++
 fs/hfs/super.c           |  4 ++-
 fs/iomap/buffered-io.c   | 66 +++++++++++++++++++++++++++++++++++++++++-------
 fs/jbd2/commit.c         |  4 +--
 fs/jbd2/revoke.c         |  2 +-
 fs/namespace.c           | 10 ++++++--
 fs/netfs/buffered_read.c | 28 +++++++++++---------
 fs/netfs/direct_write.c  |  1 -
 fs/netfs/read_collect.c  | 33 ++++++++++++++----------
 fs/netfs/read_pgpriv2.c  |  4 +++
 fs/netfs/read_retry.c    |  8 +++---
 fs/netfs/write_collect.c | 14 ++++------
 fs/netfs/write_issue.c   |  2 ++
 fs/nfs/fscache.c         |  9 ++++++-
 fs/notify/fdinfo.c       |  4 +--
 fs/overlayfs/copy_up.c   | 16 ++++++------
 fs/overlayfs/export.c    | 49 +++++++++++++++++++----------------
 fs/overlayfs/namei.c     |  4 +--
 fs/overlayfs/overlayfs.h |  2 +-
 fs/qnx6/inode.c          | 11 +++-----
 fs/smb/client/cifssmb.c  | 13 +++++++---
 fs/smb/client/smb2pdu.c  |  9 ++++---
 include/linux/iomap.h    |  2 +-
 include/linux/netfs.h    |  7 +++--
 kernel/gen_kheaders.sh   |  1 +
 31 files changed, 217 insertions(+), 123 deletions(-)

