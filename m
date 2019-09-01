Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E027EA4B87
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfIAUIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 16:08:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbfIAUIs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:08:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADDE5AE96;
        Sun,  1 Sep 2019 20:08:46 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        david@fromorbit.com, riteshh@linux.ibm.com
Subject: [PATCH v3 0/15] Btrfs iomap
Date:   Sun,  1 Sep 2019 15:08:21 -0500
Message-Id: <20190901200836.14959-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an effort to use iomap for btrfs. This would keep most
responsibility of page handling during writes in iomap code, hence
code reduction. For CoW support, changes are needed in iomap code
to make sure we perform a copy before the write.
This is in line with the discussion we had during adding dax support in
btrfs.

[1] https://github.com/goldwynr/linux/tree/btrfs-iomap

-- 
Goldwyn

Changes since v1
- Added Direct I/O support
- Remove PagePrivate from btrfs pages for regular files

Changes since v2
- Added CONFIG_FS_IOMAP_DEBUG and some checks
- Fallback to buffered read in case of short direct reads

 fs/Kconfig                  |    3 
 fs/btrfs/Kconfig            |    1 
 fs/btrfs/Makefile           |    2 
 fs/btrfs/compression.c      |    1 
 fs/btrfs/ctree.h            |   15 -
 fs/btrfs/extent_io.c        |   13 
 fs/btrfs/extent_io.h        |    2 
 fs/btrfs/file.c             |  523 +-------------------------------------
 fs/btrfs/free-space-cache.c |    1 
 fs/btrfs/inode.c            |  170 +++---------
 fs/btrfs/ioctl.c            |    4 
 fs/btrfs/iomap.c            |  598 +++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.c       |    2 
 fs/dax.c                    |    8 
 fs/ext2/inode.c             |    2 
 fs/ext4/inode.c             |    2 
 fs/gfs2/bmap.c              |    3 
 fs/iomap/apply.c            |    5 
 fs/iomap/buffered-io.c      |   37 +-
 fs/iomap/direct-io.c        |   18 -
 fs/iomap/fiemap.c           |    4 
 fs/iomap/seek.c             |    4 
 fs/iomap/swapfile.c         |    3 
 fs/xfs/xfs_iomap.c          |    9 
 include/linux/fs.h          |    2 
 include/linux/iomap.h       |   18 +
 mm/filemap.c                |   13 
 27 files changed, 757 insertions(+), 706 deletions(-)

