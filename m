Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070F5B715A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 03:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfISB5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 21:57:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39614 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfISB5D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:57:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAlgr-0005LH-5Z; Thu, 19 Sep 2019 01:57:01 +0000
Date:   Thu, 19 Sep 2019 02:57:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] more mount API conversions
Message-ID: <20190919015701.GJ1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Conversions to new API for shmem and friends and for mount_mtd()-using
filesystems.

	As for the rest of the work.mount in -next, some of the conversions
belong in the individual trees (e.g. binderfs one should definitely go through
android folks, after getting redone on top of their changes).  I'm going to
drop those and send the rest (trivial ones + stuff ACKed by maintainers) in
a separate series - by that point they are independent from each other.

	Some stuff has already migrated into individual trees (NFS conversion,
for example, or FUSE stuff, etc.); those presumably will go through the
regular merges from corresponding trees.

The following changes since commit 0f071004109d9c8de7023b9a64fa2ba3fa87cbed:

  mtd: Provide fs_context-aware mount_mtd() replacement (2019-09-05 14:34:23 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount2

for you to fetch changes up to 74983ac20aeafc88d9ceed64a8bf2a9024c488d5:

  vfs: Make fs_parse() handle fs_param_is_fd-type params better (2019-09-12 21:06:14 -0400)

----------------------------------------------------------------
Al Viro (7):
      devtmpfs: don't mix {ramfs,shmem}_fill_super() with mount_single()
      make ramfs_fill_super() static
      make shmem_fill_super() static
      shmem_parse_options(): use a separate structure to keep the results
      shmem_parse_options(): don't bother with mpol in separate variable
      shmem_parse_options(): take handling a single option into a helper
      shmem_parse_one(): switch to use of fs_parse()

David Howells (8):
      vfs: Add a single-or-reconfig keying to vfs_get_super()
      vfs: Convert romfs to use the new mount API
      vfs: Convert cramfs to use the new mount API
      vfs: Convert jffs2 to use the new mount API
      mtd: Kill mount_mtd()
      vfs: Convert squashfs to use the new mount API
      vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API
      vfs: Make fs_parse() handle fs_param_is_fd-type params better

 drivers/base/devtmpfs.c    |  38 +++--
 drivers/mtd/mtdsuper.c     | 189 ----------------------
 fs/cramfs/inode.c          |  69 ++++----
 fs/fs_parser.c             |  18 ++-
 fs/jffs2/fs.c              |  21 +--
 fs/jffs2/os-linux.h        |   4 +-
 fs/jffs2/super.c           | 172 ++++++++++----------
 fs/ramfs/inode.c           |  99 +++++++-----
 fs/romfs/super.c           |  46 +++---
 fs/squashfs/super.c        | 100 ++++++------
 fs/super.c                 |  35 ++++-
 include/linux/fs_context.h |   4 +
 include/linux/mtd/super.h  |   3 -
 include/linux/ramfs.h      |   6 +-
 include/linux/shmem_fs.h   |   3 +-
 init/do_mounts.c           |  11 +-
 mm/shmem.c                 | 385 +++++++++++++++++++++++++++++----------------
 17 files changed, 609 insertions(+), 594 deletions(-)
