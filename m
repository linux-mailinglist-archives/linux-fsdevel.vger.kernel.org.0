Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4BE3A29F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFJLRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:17:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9066 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhFJLRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:17:48 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G11Y750PlzYsRj;
        Thu, 10 Jun 2021 19:12:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 19:15:50 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <jack@suse.cz>, <tytso@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <david@fromorbit.com>,
        <hch@infradead.org>, <yi.zhang@huawei.com>
Subject: [RFC PATCH v4 0/8] ext4, jbd2: fix 3 issues about bdev_try_to_free_page()
Date:   Thu, 10 Jun 2021 19:24:32 +0800
Message-ID: <20210610112440.3438139-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset fix a potential filesystem inconsistency problem and two
use-after-free problems about bdev_try_to_free_page().

Patch 1-4: Fix a potential filesystem inconsistency problem caused by
           freeing buffers and doing umount concurrently, and also do
           some cleanup.
Patch 5-8: Add a shrinker to release journal_head of checkpoint buffers
           and remove the buggy bdev_try_to_free_page() at all.

Changes since v3:
 - Patch 2: Fix one spelling mistake.
 - Patch 3: Drop unnecessary 'result' check codes.
 - Patch 5, declare static for jbd2_journal_shrink_[scan|count](),
   and use percpu_counter_read_positive() to calculate the number of
   shrinkable journal heads.
 - Add 'Reviewed-by' tag from Jan besides the fifth patch.


Hi Jan,
 
I modify the fifth patch as Dave suggested, please give a look at this
patch again.

Thanks,
Yi.

------------------

Changes since v2:
 - Fix some comments and spelling mistakes on patch 2 and 3.
 - Give up the solution of add refcount on super_block and fix the
   use-after-free issue in bdev_try_to_free_page(), switch to introduce
   a shrinker to free checkpoint buffers' journal_head and remove the
   whole callback at all.

Changes since v1:
 - Do not use j_checkpoint_mutex to fix the filesystem inconsistency
   problem, introduce a new mark instead.
 - Fix superblock use-after-free issue in blkdev_releasepage().
 - Avoid race between bdev_try_to_free_page() and ext4_put_super().


Zhang Yi (8):
  jbd2: remove the out label in __jbd2_journal_remove_checkpoint()
  jbd2: ensure abort the journal if detect IO error when writing
    original buffer back
  jbd2: don't abort the journal when freeing buffers
  jbd2: remove redundant buffer io error checks
  jbd2,ext4: add a shrinker to release checkpointed buffers
  jbd2: simplify journal_clean_one_cp_list()
  ext4: remove bdev_try_to_free_page() callback
  fs: remove bdev_try_to_free_page callback

 fs/block_dev.c              |  15 ---
 fs/ext4/super.c             |  29 ++---
 fs/jbd2/checkpoint.c        | 206 +++++++++++++++++++++++++++++-------
 fs/jbd2/journal.c           | 101 ++++++++++++++++++
 fs/jbd2/transaction.c       |  17 ---
 include/linux/fs.h          |   1 -
 include/linux/jbd2.h        |  37 +++++++
 include/trace/events/jbd2.h | 101 ++++++++++++++++++
 8 files changed, 414 insertions(+), 93 deletions(-)

-- 
2.31.1

