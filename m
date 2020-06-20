Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2AB201FE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 04:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbgFTCxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 22:53:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732006AbgFTCx3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:53:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5016D6C9B5FF326A0C16;
        Sat, 20 Jun 2020 10:53:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 10:53:20 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 0/5] ext4: fix inconsistency since async write metadata buffer error
Date:   Sat, 20 Jun 2020 10:54:22 +0800
Message-ID: <20200620025427.1756360-1-yi.zhang@huawei.com>
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

Changes since v2:
 - Christoph against the solution of adding callback in the block layer
   that could let ext4 handle write error. So for simplicity, switch to
   check the bdev mapping->wb_err when ext4 getting journal write access
   as Jan suggested now. Maybe we could implement the callback through
   introduce a special inode (e.g. a meta inode) for ext4 in the future.
 - Patch 1: Add mapping->wb_err check and invoke ext4_error_err() in
   ext4_journal_get_write_access() if wb_err is different from the
   original one saved at mount time.
 - Patch 2-3: Remove partial fix <7963e5ac90125> and <9c83a923c67d>.
 - Patch 4: Fix another inconsistency problem since we may bypass the
   journal's checkpoint procedure if we free metadata buffers which
   were failed to async write out.
 - Patch 5: Just a cleanup patch.
   
The above 5 patches are based on linux-5.8-rc1 and have been tested by
xfstests, no newly increased failures.

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
  ext4: abort the filesystem if failed to async write metadata buffer
  ext4: remove ext4_buffer_uptodate()
  ext4: remove write io error check before read inode block
  jbd2: abort journal if free a async write error metadata buffer
  jbd2: remove unused parameter in jbd2_journal_try_to_free_buffers()

 fs/ext4/ext4.h        | 16 +++-------------
 fs/ext4/ext4_jbd2.c   | 25 +++++++++++++++++++++++++
 fs/ext4/inode.c       | 15 +++------------
 fs/ext4/super.c       | 23 ++++++++++++++++++++---
 fs/jbd2/transaction.c | 20 ++++++++++++++------
 include/linux/jbd2.h  |  2 +-
 6 files changed, 66 insertions(+), 35 deletions(-)

-- 
2.25.4

