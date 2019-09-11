Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3158FAFDDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfIKNnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 09:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfIKNnW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 727A530041C9;
        Wed, 11 Sep 2019 13:43:22 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26ACC10016EB;
        Wed, 11 Sep 2019 13:43:20 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 0/9 V6] New ->fiemap infrastructure and ->bmap removal
Date:   Wed, 11 Sep 2019 15:43:06 +0200
Message-Id: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 11 Sep 2019 13:43:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

This is the 6th version of the complete series with the goal to deprecate and
eventually remove ->bmap() interface, in lieu if FIEMAP.

This V6, compared with the previous one, is rebased agains next-20190904, and
addresses a few issues found by kbuild test robot, and other points discussed in
previous version.

Detailed information are in each patch description, but the biggest change
in this version is the removal of FIEMAP_KERNEL_FIBMAP flag in patch 8, so,
reducing patch's complexity and avoiding any specific filesystem modification.

The impact of such change is further detailed in patch 8.

Carlos Maiolino (9):
  fs: Enable bmap() function to properly return errors
  cachefiles: drop direct usage of ->bmap method.
  ecryptfs: drop direct calls to ->bmap
  fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
  fs: Move start and length fiemap fields into fiemap_extent_info
  iomap: Remove length and start fields from iomap_fiemap
  fiemap: Use a callback to fill fiemap extents
  Use FIEMAP for FIBMAP calls
  xfs: Get rid of ->bmap

 drivers/md/md-bitmap.c |  16 +++---
 fs/bad_inode.c         |   3 +-
 fs/btrfs/inode.c       |   5 +-
 fs/cachefiles/rdwr.c   |  27 +++++-----
 fs/cifs/cifsfs.h       |   3 +-
 fs/cifs/inode.c        |   5 +-
 fs/ecryptfs/mmap.c     |  16 +++---
 fs/ext2/ext2.h         |   3 +-
 fs/ext2/inode.c        |   6 +--
 fs/ext4/ext4.h         |   6 +--
 fs/ext4/extents.c      |  18 +++----
 fs/ext4/ioctl.c        |   8 +--
 fs/f2fs/data.c         |  21 +++++---
 fs/f2fs/f2fs.h         |   3 +-
 fs/gfs2/inode.c        |   5 +-
 fs/hpfs/file.c         |   4 +-
 fs/inode.c             | 108 +++++++++++++++++++++++++++++++++++-----
 fs/ioctl.c             | 109 ++++++++++++++++++++++++-----------------
 fs/iomap/fiemap.c      |   4 +-
 fs/jbd2/journal.c      |  22 ++++++---
 fs/nilfs2/inode.c      |   5 +-
 fs/nilfs2/nilfs.h      |   3 +-
 fs/ocfs2/extent_map.c  |   6 ++-
 fs/ocfs2/extent_map.h  |   3 +-
 fs/overlayfs/inode.c   |   5 +-
 fs/xfs/xfs_aops.c      |  24 ---------
 fs/xfs/xfs_iops.c      |  14 ++----
 fs/xfs/xfs_trace.h     |   1 -
 include/linux/fs.h     |  38 +++++++++-----
 include/linux/iomap.h  |   2 +-
 mm/page_io.c           |  11 +++--
 31 files changed, 304 insertions(+), 200 deletions(-)

-- 
2.20.1

