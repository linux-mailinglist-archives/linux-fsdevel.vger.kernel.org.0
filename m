Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E557B85CC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfHHI1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 04:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731844AbfHHI1u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:27:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51032C06511D;
        Thu,  8 Aug 2019 08:27:50 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-236.brq.redhat.com [10.40.204.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 522C75C220;
        Thu,  8 Aug 2019 08:27:48 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 0/9 V5] New ->fiemap infrastructure and ->bmap removal
Date:   Thu,  8 Aug 2019 10:27:35 +0200
Message-Id: <20190808082744.31405-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 08 Aug 2019 08:27:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

This is the 5th version of the complete series with the goal to deprecate and
eventually remove ->bmap() interface, in lieu of FIEMAP.

This V5, compared with V4 is properly rebased against 5.3, and addresses the
issues raised in V4 discussion.

Details of what changed on each patch are in their specific changelogs.



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

 drivers/md/md-bitmap.c |  16 ++++--
 fs/bad_inode.c         |   3 +-
 fs/btrfs/inode.c       |   5 +-
 fs/cachefiles/rdwr.c   |  27 ++++-----
 fs/ecryptfs/mmap.c     |  16 ++----
 fs/ext2/ext2.h         |   3 +-
 fs/ext2/inode.c        |   6 +-
 fs/ext4/ext4.h         |   3 +-
 fs/ext4/extents.c      |  15 +++--
 fs/f2fs/data.c         |  31 +++++++---
 fs/f2fs/f2fs.h         |   3 +-
 fs/gfs2/inode.c        |   9 ++-
 fs/hpfs/file.c         |   4 +-
 fs/inode.c             | 105 +++++++++++++++++++++++++++++----
 fs/ioctl.c             | 128 ++++++++++++++++++++++++++---------------
 fs/iomap/fiemap.c      |   6 +-
 fs/jbd2/journal.c      |  22 ++++---
 fs/nilfs2/inode.c      |   5 +-
 fs/nilfs2/nilfs.h      |   3 +-
 fs/ocfs2/extent_map.c  |  13 ++++-
 fs/ocfs2/extent_map.h  |   3 +-
 fs/overlayfs/inode.c   |   5 +-
 fs/xfs/xfs_aops.c      |  24 --------
 fs/xfs/xfs_iops.c      |  20 ++++---
 fs/xfs/xfs_trace.h     |   1 -
 include/linux/fs.h     |  35 +++++++----
 include/linux/iomap.h  |   2 +-
 mm/page_io.c           |  11 ++--
 28 files changed, 334 insertions(+), 190 deletions(-)

-- 
2.20.1

