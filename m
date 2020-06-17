Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06E01FCCEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 13:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgFQL6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 07:58:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgFQL6p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:58:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AE3B7BEBE72483282702;
        Wed, 17 Jun 2020 19:58:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 17 Jun 2020
 19:58:32 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 0/5] ext4: fix inconsistency since reading old metadata from disk
Date:   Wed, 17 Jun 2020 19:59:42 +0800
Message-ID: <20200617115947.836221-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v1:
 - Give up the solution of re-adding metadata buffer's uptodate flag.
 - Patch 1-2: Add a call back for end_buffer_async_write() and invoke
   ext4_error_err() to handle metadata buffer async write IO error
   immediately.
 - Patch 3: Add mapping->wb_err check and also invoke ext4_error_err()
   in ext4_journal_get_write_access() if wb_err is different from the
   original one saved at mount time. Add this patch because patch 2
   could not fix all cases.
 - Patch 4-5: Remove partial fix <7963e5ac90125> and <9c83a923c67d>.

The above 5 patches are based on linux-5.8-rc1 and have been tested by
xfstests, no new failures.

Thanks,
Yi.

-----------------------

Original background
===================

This patch set point to fix the inconsistency problem which has been
discussed and partial fixed in [1].

Now, the problem is on the unstable storage which has a flaky transport
(e.g. iSCSI transport may disconnect few seconds and reconnect due to
the bad network environment), if we failed to async write metadata in
background, the end write routine in block layer will clear the buffer's
uptodate flag, but the data in such buffer is actually uptodate. Finally
we may read "old && inconsistent" metadata from the disk when we get the
buffer later because not only the uptodate flag was cleared but also we
do not check the write io error flag, or even worse the buffer has been
freed due to memory presure.

Fortunately, if the jbd2 do checkpoint after async IO error happens,
the checkpoint routine will check the write_io_error flag and abort the
the journal if detect IO error. And in the journal recover case, the
recover code will invoke sync_blockdev() after recover complete, it will
also detect IO error and refuse to mount the filesystem.

Current ext4 have already deal with this problem in __ext4_get_inode_loc()
and commit 7963e5ac90125 ("ext4: treat buffers with write errors as
containing valid data"), but it's not enough.

[1] https://lore.kernel.org/linux-ext4/20190823030207.GC8130@mit.edu/

zhangyi (F) (5):
  fs: add bdev writepage hook to block device
  ext4: mark filesystem error if failed to async write metadata
  ext4: detect metadata async write error when getting journal's write
    access
  ext4: remove ext4_buffer_uptodate()
  ext4: remove write io error check before read inode block

 fs/block_dev.c      |  5 ++++
 fs/ext4/ext4.h      | 24 +++++++++----------
 fs/ext4/ext4_jbd2.c | 34 +++++++++++++++++++++++----
 fs/ext4/inode.c     | 13 ++---------
 fs/ext4/page-io.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/super.c     | 32 ++++++++++++++++++++++++-
 include/linux/fs.h  |  1 +
 7 files changed, 136 insertions(+), 30 deletions(-)

-- 
2.25.4

