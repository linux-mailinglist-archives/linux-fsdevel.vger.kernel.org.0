Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB235F4F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346950AbhDNNj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:39:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16998 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbhDNNjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:39:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FL3RC0bqmzPptn;
        Wed, 14 Apr 2021 21:36:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 Apr 2021
 21:39:26 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC PATCH v2 0/7]  ext4, jbd2: fix 3 issues about bdev_try_to_free_page()
Date:   Wed, 14 Apr 2021 21:47:30 +0800
Message-ID: <20210414134737.2366971-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Patch 1-2: fix a potential filesystem inconsistency problem.
Patch 3-7: fix two use after free problem.

Changes since v1:
 - Do not use j_checkpoint_mutex to fix the filesystem inconsistency
   problem, introduce a new mark instead.
 - Fix superblock use-after-free issue in blkdev_releasepage().
 - Avoid race between bdev_try_to_free_page() and ext4_put_super().

Zhang Yi (7):
  jbd2: remove the out label in __jbd2_journal_remove_checkpoint()
  jbd2: ensure abort the journal if detect IO error when writing
    original buffer back
  jbd2: don't abort the journal when freeing buffers
  jbd2: do not free buffers in jbd2_journal_try_to_free_buffers()
  ext4: use RCU to protect accessing superblock in blkdev_releasepage()
  fs: introduce a usage count into the superblock
  ext4: fix race between blkdev_releasepage() and ext4_put_super()

 fs/block_dev.c        | 13 ++++++----
 fs/ext4/inode.c       |  6 +++--
 fs/ext4/super.c       | 32 +++++++++++++++++++++----
 fs/jbd2/checkpoint.c  | 56 ++++++++++++++++++++++++-------------------
 fs/jbd2/journal.c     |  9 +++++++
 fs/jbd2/transaction.c | 32 ++++++-------------------
 include/linux/fs.h    | 29 ++++++++++++++++++++++
 include/linux/jbd2.h  |  7 ++++++
 8 files changed, 123 insertions(+), 61 deletions(-)

-- 
2.25.4

