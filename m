Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A457C47D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfGaONB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:13:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGaONB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:13:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA78630833B0;
        Wed, 31 Jul 2019 14:13:00 +0000 (UTC)
Received: from pegasus.maiolino.com (unknown [10.40.205.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B64860852;
        Wed, 31 Jul 2019 14:12:58 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 0/9 V4] New ->fiemap infrastructure and ->bmap removal
Date:   Wed, 31 Jul 2019 16:12:36 +0200
Message-Id: <20190731141245.7230-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 31 Jul 2019 14:13:01 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

This is the 4th version of the complete series with the goal to deprecate and
eventually remove ->bmap() interface, in lieu of FIEMAP.

Besides the rebase of the patchset against latest Linus's tree, the only changes
in this patchset regarding to the previous version, are concentrated in patches
4/9 and 8/9.

In patch 4  (fibmap: Use bmap instead of ->bmap method in ioctl_fibmap), the
difference compared with previous version, is a change in ioclt_fibmap() return
value, I spotted while testing this new version with filesystems using data
inlined in inodes. It now returns 0 in case of error instead an error value,
otherwise it would be an user interface change.


In patch 8 (Use FIEMAP for FIBMAP calls), there are minor changes regarding V3.
It just contains a coding style fix pointed by Andreas in the previous version,
but now, it also include changes to all filesystems which supports both FIEMAP
and FIBMAP, and need some sort of special handling (like inlined data, reflinked
inodes, etc).

Again, Patch 9 is xfs-specific removal of ->bmap() interface, without any
changes compared to the previous version.



I do apologize for taking so long to rework this patchset, I've got busy with
other stuff.

Comments are appreciated, specially regarding if the error values returned by
ioctl_fibmap() make sense.


Cheers

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
 fs/f2fs/data.c         |  15 ++++-
 fs/f2fs/f2fs.h         |   3 +-
 fs/gfs2/inode.c        |   9 ++-
 fs/hpfs/file.c         |   4 +-
 fs/inode.c             | 105 +++++++++++++++++++++++++++++----
 fs/ioctl.c             | 128 ++++++++++++++++++++++++++---------------
 fs/iomap.c             |  40 ++-----------
 fs/jbd2/journal.c      |  22 ++++---
 fs/nilfs2/inode.c      |   5 +-
 fs/nilfs2/nilfs.h      |   3 +-
 fs/ocfs2/extent_map.c  |  13 ++++-
 fs/ocfs2/extent_map.h  |   3 +-
 fs/overlayfs/inode.c   |   5 +-
 fs/xfs/xfs_aops.c      |  24 --------
 fs/xfs/xfs_iops.c      |  19 +++---
 fs/xfs/xfs_trace.h     |   1 -
 include/linux/fs.h     |  33 +++++++----
 include/linux/iomap.h  |   2 +-
 mm/page_io.c           |  11 ++--
 28 files changed, 320 insertions(+), 219 deletions(-)

-- 
2.20.1

