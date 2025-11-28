Return-Path: <linux-fsdevel+bounces-70155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54942C92A0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972A43A9558
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF92D6638;
	Fri, 28 Nov 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blBl3tIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F02D5959;
	Fri, 28 Nov 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348679; cv=none; b=CAzhV4KIcig+V+jJRvg/NVJBccoXM6Ari9UKHktMqxfcpf7b+CjBhiYCirpP27UgM25fvCNWhuygbOMrAf1Y52kwR3nmQrOLDCAnZfIJZb8vIJFn/bx7AXv7D2vhO7Q8ekjfOnvvmkax1XFVy12jvzOjR18izDe33Lz/7sw7cZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348679; c=relaxed/simple;
	bh=jLl9Wq4EGvPFVOna/D3JFB+ObeoIGvh8N/8aK/2TYWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZXsHe9oe/AavscGmUI0tfhr4LuhveY2ER2sF3wAiq+w+cYWodZLnrNBDQvkCa70m77QzJYjHviMRa5VtLOm2lo8pYkP8nQcaaeTsby/PPjCxDmMM4MOQ/To5vxowJ6ckZKy+4VOxctDV1ZeuGYDdFSQy34Lt88pJ05W92uPJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blBl3tIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D682C4CEF1;
	Fri, 28 Nov 2025 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348676;
	bh=jLl9Wq4EGvPFVOna/D3JFB+ObeoIGvh8N/8aK/2TYWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blBl3tIZjfQxciVMbp3QANxTragrcBYRGJhGBDll0wBr4FDBhLc2GtlF6uY6dOYDX
	 9UI89HCDxETnpnFmlj3LeDaCvVY/40BINY0J5I2gTJW/3U7E4Gaa6sIggMl9QsrjPG
	 zKi++yNUtqIZTzDnejGS4yFKThei9N9ySfnU6SSOkEx/B913gFt6AuC31Ui0UVmubH
	 mxHm+zkSHqql3tZEk0bEXVDu2M7gwFzrA+TZZZ+NVeP8+qkvy083GlK+9FqsiLSTCR
	 s34rGzY1rOufu84PZtGCJPF3KC3+x0B6xEu5olJ6X8RitFU6wY0wNM6l7qlAqMOfBl
	 k0jsbq3AMidmA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 04/17 for v6.19] vfs writeback
Date: Fri, 28 Nov 2025 17:48:15 +0100
Message-ID: <20251128-vfs-writeback-v619-24e0f5ebe21f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5922; i=brauner@kernel.org; h=from:subject:message-id; bh=jLl9Wq4EGvPFVOna/D3JFB+ObeoIGvh8N/8aK/2TYWA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnp4aK09W8Hj38xb79RulFvhuPuYmNsrjQgv4yvKe +fPli9d3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARIzWGv9JPXzAxaQRfnzV/ UZ+VoebjN7LumrX3656+qF/zbupS050M/+tKJHZ/m8reskY433vjtyNugmv0+7fxL2Gb4NDEdtJ wDRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains writeback changes for this cycle:

Features

- Allow file systems to increase the minimum writeback chunk size. The
  relatively low minimal writeback size of 4MiB means that written back
  inodes on rotational media are switched a lot. Besides introducing
  additional seeks, this also can lead to extreme file fragmentation on
  zoned devices when a lot of files are cached relative to the available
  writeback bandwidth. This adds a superblock field that allows the file
  system to override the default size, and sets it to the zone size for
  zoned XFS.

- Add logging for slow writeback when it exceeds sysctl_hung_task_timeout_secs.
  This helps identify tasks waiting for a long time and pinpoint potential
  issues. Recording the starting jiffies is also useful when debugging a
  crashed vmcore.

- Wake up waiting tasks when finishing the writeback of a chunk.

Cleanups

- filemap_* writeback interface cleanups. Adding filemap_fdatawrite_wbc
  ended up being a mistake, as all but the original btrfs caller should
  be using better high level interfaces instead. This series removes all
  these low-level interfaces, switches btrfs to a more specific interface,
  and cleans up other too low-level interfaces. With this the
  writeback_control that is passed to the writeback code is only
  initialized in three places.

- Remove __filemap_fdatawrite, __filemap_fdatawrite_range, and
  filemap_fdatawrite_wbc

- Add filemap_flush_nr helper for btrfs

- Push struct writeback_control into start_delalloc_inodes in btrfs

- Rename filemap_fdatawrite_range_kick to filemap_flush_range

- Stop opencoding filemap_fdatawrite_range in 9p, ocfs2, and mm

- Make wbc_to_tag() inline and use it in fs.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

diff --cc include/linux/writeback.h
index 102071ffedcb,2a81816f7507..000000000000
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@@ -189,6 -189,20 +189,13 @@@ void wakeup_flusher_threads_bdi(struct
  void inode_wait_for_writeback(struct inode *inode);
  void inode_io_list_del(struct inode *inode);

 -/* writeback.h requires fs.h; it, too, is not included from here. */
 -static inline void wait_on_inode(struct inode *inode)
 -{
 -      wait_var_event(inode_state_wait_address(inode, __I_NEW),
 -                     !(READ_ONCE(inode->i_state) & I_NEW));
 -}
 -
+ static inline xa_mark_t wbc_to_tag(struct writeback_control *wbc)
+ {
+       if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+               return PAGECACHE_TAG_TOWRITE;
+       return PAGECACHE_TAG_DIRTY;
+ }
+
  #ifdef CONFIG_CGROUP_WRITEBACK

  #include <linux/cgroup.h>

Merge conflicts with other trees
================================

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.writeback

for you to fetch changes up to 4952f35f0545f3b53dab8d5fd727c4827c2a2778:

  fs: Make wbc_to_tag() inline and use it in fs. (2025-10-29 23:33:48 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.writeback tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.writeback

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "filemap_* writeback interface cleanups v2"
      Merge patch series "allow file systems to increase the minimum writeback chunk size v2"

Christoph Hellwig (13):
      mm: don't opencode filemap_fdatawrite_range in filemap_invalidate_inode
      9p: don't opencode filemap_fdatawrite_range in v9fs_mmap_vm_close
      ocfs2: don't opencode filemap_fdatawrite_range in ocfs2_journal_submit_inode_data_buffers
      btrfs: use the local tmp_inode variable in start_delalloc_inodes
      btrfs: push struct writeback_control into start_delalloc_inodes
      mm,btrfs: add a filemap_flush_nr helper
      mm: remove __filemap_fdatawrite
      mm: remove filemap_fdatawrite_wbc
      mm: remove __filemap_fdatawrite_range
      mm: rename filemap_fdatawrite_range_kick to filemap_flush_range
      writeback: cleanup writeback_chunk_size
      writeback: allow the file system to override MIN_WRITEBACK_PAGES
      xfs: set s_min_writeback_pages for zoned file systems

Julian Sun (3):
      writeback: Wake up waiting tasks when finishing the writeback of a chunk.
      writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)
      fs: Make wbc_to_tag() inline and use it in fs.

 fs/9p/vfs_file.c                 |  17 ++----
 fs/btrfs/extent_io.c             |   5 +-
 fs/btrfs/inode.c                 |  46 +++++------------
 fs/ceph/addr.c                   |   6 +--
 fs/ext4/inode.c                  |   5 +-
 fs/f2fs/data.c                   |   5 +-
 fs/fs-writeback.c                |  55 ++++++++++++--------
 fs/gfs2/aops.c                   |   5 +-
 fs/ocfs2/journal.c               |  11 +---
 fs/super.c                       |   1 +
 fs/sync.c                        |  10 ++--
 fs/xfs/xfs_zone_alloc.c          |  28 +++++++++-
 include/linux/backing-dev-defs.h |   2 +
 include/linux/fs.h               |   7 +--
 include/linux/pagemap.h          |   5 +-
 include/linux/writeback.h        |  12 +++++
 mm/fadvise.c                     |   3 +-
 mm/filemap.c                     | 109 ++++++++++++++++-----------------------
 mm/page-writeback.c              |   6 ---
 19 files changed, 154 insertions(+), 184 deletions(-)

