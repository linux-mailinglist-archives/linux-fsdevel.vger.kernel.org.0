Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17035F503
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351443AbhDNNkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:40:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16919 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351422AbhDNNkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:40:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FL3SV0hfJzjZSG;
        Wed, 14 Apr 2021 21:37:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 Apr 2021
 21:39:29 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC PATCH v2 5/7] ext4: use RCU to protect accessing superblock in blkdev_releasepage()
Date:   Wed, 14 Apr 2021 21:47:35 +0800
Message-ID: <20210414134737.2366971-6-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210414134737.2366971-1-yi.zhang@huawei.com>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In blkdev_releasepage() we access the superblock structure directly, it
could be raced by umount filesystem on destroy superblock in put_super(),
and end up triggering a use after free issue.

drop cache                  umount filesystem
bdev_try_to_free_page()
 get superblock
                             deactivate_locked_super()
                               ...
                               put_super() and free sb by destroy_work
 access superblock  <-- trigger use after free

This issue doesn't trigger easily in general because we get page locked
when invoking bdev_try_to_free_page(), and when umount filesystem the
kill_block_super()->..->kill_bdev()->truncate_inode_pages_range()
procedure wait on page unlock, but it's not a guarantee. Fix this race
by use RCU to protect superblock in blkdev_releasepage().

Fixes: 87d8fe1ee6b8 ("add releasepage hooks to block devices which can be used by file systems")
Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/block_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 5ed79a9063f6..cb84f347fb04 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1734,11 +1734,14 @@ EXPORT_SYMBOL_GPL(blkdev_read_iter);
  */
 static int blkdev_releasepage(struct page *page, gfp_t wait)
 {
-	struct super_block *super = BDEV_I(page->mapping->host)->bdev.bd_super;
+	struct super_block *super;
 	int ret = 0;
 
+	rcu_read_lock();
+	super = READ_ONCE(BDEV_I(page->mapping->host)->bdev.bd_super);
 	if (super && super->s_op->bdev_try_to_free_page)
 		ret = super->s_op->bdev_try_to_free_page(super, page, wait);
+	rcu_read_unlock();
 	if (!ret)
 		return try_to_free_buffers(page);
 	return 0;
-- 
2.25.4

