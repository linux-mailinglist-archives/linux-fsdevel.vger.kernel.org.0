Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F046636706F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbhDUQqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:46:40 -0400
Received: from mx2.veeam.com ([64.129.123.6]:41916 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244347AbhDUQqj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:46:39 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 5EBE742406;
        Wed, 21 Apr 2021 12:45:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1619023555; bh=h41nYawhFuIkEKobo2LpVytJxoNFHzzj229eHud/Mao=;
        h=From:To:CC:Subject:Date:From;
        b=AIixUZHGmo+HZI8/mBT9Jyka2qBirNEsUiFr0ZNXQWEAEpkw0owg9Zthc60rcGMPc
         t2kC+i5K8uAHmV0ydIiixsQRHdFZ+OnAglYLP/Wb1RBw0p376hlrWcJo1InAMCFLTy
         tFApGARHJ4c0a8f55gHvN9aoqZZwxMXQjWYiq4K4=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 21 Apr 2021 18:45:53 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v9 0/4] block device interposer
Date:   Wed, 21 Apr 2021 19:45:41 +0300
Message-ID: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59677566
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new version of a block device interposer (blk_interposer).

In this series of patches,  I have tried to take into account the comments
made by Mike to the previous version.

First of all, this applies to more detailed explanations of the commits.
Indeed, the changes in blk-core.c and dm.c may seem complicated, but they
are no more complicated than the rest of the code in these files.

Removed the [interpose] option for block devices opened by the DM target.
Instead, the dm_get_device_ex() function is added, which allows to
explicitly specify which devices can be used for the interposer and which
can not.

Additional testing has revealed a problem with suspending and resuming DM
targets attached via blk_interposer. This has been fixed.

History:
v8 - https://patchwork.kernel.org/project/linux-block/cover/1617968884-15149-1-git-send-email-sergei.shtepa@veeam.com/
  * The attaching and detaching to interposed device moved to
    __dm_suspend() and __dm_resume() functions.
  * Redesigned the submit_bio_noacct() function and added a lock for the
    block device interposer.
  * Adds [interpose] option to block device patch in dm table.
  * Fix origin_map() then o->split_binary value is zero.

v7 - https://patchwork.kernel.org/project/linux-block/cover/1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com/
  * the request interception mechanism. Now the interposer is
    a block device that receives requests instead of the original device;
  * code design fixes.

v6 - https://patchwork.kernel.org/project/linux-block/cover/1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com/
  * designed for 5.12;
  * thanks to the new design of the bio structure in v5.12, it is
    possible to perform interception not for the entire disk, but
    for each block device;
  * instead of the new ioctl DM_DEV_REMAP_CMD and the 'noexcl' option,
    the DM_INTERPOSED_FLAG flag for the ioctl DM_TABLE_LOAD_CMD is
    applied.

v5 - https://patchwork.kernel.org/project/linux-block/cover/1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com/
 * rebase for v5.11-rc7;
 * patch set organization;
 * fix defects in documentation;
 * add some comments;
 * change mutex names for better code readability;
 * remove calling bd_unlink_disk_holder() for targets with non-exclusive
   flag;
 * change type for struct dm_remap_param from uint8_t to __u8.

v4 - https://patchwork.kernel.org/project/linux-block/cover/1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com/
Mostly changes were made, due to Damien's comments:
 * on the design of the code;
 * by the patch set organization;
 * bug with passing a wrong parameter to dm_get_device();
 * description of the 'noexcl' parameter in the linear.rst.
Also added remap_and_filter.rst.

v3 - https://patchwork.kernel.org/project/linux-block/cover/1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com/
In this version, I already suggested blk_interposer to apply to dm-linear.
Problems were solved:
 * Interception of bio requests from a specific device on the disk, not
   from the entire disk. To do this, we added the dm_interposed_dev
   structure and an interval tree to store these structures.
 * Implemented ioctl DM_DEV_REMAP_CMD. A patch with changes in the lvm2
   project was sent to the team lvm-devel@redhat.com.
 * Added the 'noexcl' option for dm-linear, which allows you to open
   the underlying block-device without FMODE_EXCL mode.

v2 - https://patchwork.kernel.org/project/linux-block/cover/1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com/
I tried to suggest blk_interposer without using it in device mapper,
but with the addition of a sample of its use. It was then that I learned
about the maintainers' attitudes towards the samples directory :).

v1 - https://lwn.net/ml/linux-block/20201119164924.74401-1-hare@suse.de/
This Hannes's patch can be considered as a starting point, since this is
where the interception mechanism and the term blk_interposer itself
appeared. It became clear that blk_interposer can be useful for
device mapper.

before v1 - https://patchwork.kernel.org/project/linux-block/cover/1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com/
I tried to offer a rather cumbersome blk-filter and a monster-like
blk-snap module for creating snapshots.

Sergei Shtepa (4):
  Adds blk_interposer
  Applying the blk_interposer in the block device layer
  Add blk_interposer in DM
  Using dm_get_device_ex() instead of dm_get_device()

 block/bio.c                   |   2 +
 block/blk-core.c              | 194 ++++++++++++++-------------
 block/genhd.c                 |  52 ++++++++
 drivers/md/dm-cache-target.c  |   5 +-
 drivers/md/dm-core.h          |   1 +
 drivers/md/dm-delay.c         |   3 +-
 drivers/md/dm-dust.c          |   3 +-
 drivers/md/dm-era-target.c    |   4 +-
 drivers/md/dm-flakey.c        |   3 +-
 drivers/md/dm-ioctl.c         |  59 ++++++++-
 drivers/md/dm-linear.c        |   3 +-
 drivers/md/dm-log-writes.c    |   3 +-
 drivers/md/dm-snap.c          |   3 +-
 drivers/md/dm-table.c         |  21 ++-
 drivers/md/dm-writecache.c    |   3 +-
 drivers/md/dm.c               | 242 ++++++++++++++++++++++++++++++----
 drivers/md/dm.h               |   8 +-
 fs/block_dev.c                |   3 +
 include/linux/blk_types.h     |   6 +
 include/linux/blkdev.h        |  32 +++++
 include/linux/device-mapper.h |  11 +-
 include/uapi/linux/dm-ioctl.h |   6 +
 22 files changed, 530 insertions(+), 137 deletions(-)

--
2.20.1

