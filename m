Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328D63A2A02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFJLR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:17:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3830 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFJLRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:17:51 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G11Vr1GmtzWskH;
        Thu, 10 Jun 2021 19:11:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 19:15:53 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <jack@suse.cz>, <tytso@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <david@fromorbit.com>,
        <hch@infradead.org>, <yi.zhang@huawei.com>
Subject: [RFC PATCH v4 7/8] ext4: remove bdev_try_to_free_page() callback
Date:   Thu, 10 Jun 2021 19:24:39 +0800
Message-ID: <20210610112440.3438139-8-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610112440.3438139-1-yi.zhang@huawei.com>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
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

After we introduce a jbd2 shrinker to release checkpointed buffer's
journal head, we could free buffer without bdev_try_to_free_page()
under memory pressure. So this patch remove the whole
bdev_try_to_free_page() callback directly. It also remove many
use-after-free issues relate to it together.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 80064e566f56..cff882cf0847 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1442,26 +1442,6 @@ static int ext4_nfs_commit_metadata(struct inode *inode)
 	return ext4_write_inode(inode, &wbc);
 }
 
-/*
- * Try to release metadata pages (indirect blocks, directories) which are
- * mapped via the block device.  Since these pages could have journal heads
- * which would prevent try_to_free_buffers() from freeing them, we must use
- * jbd2 layer's try_to_free_buffers() function to release them.
- */
-static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
-				 gfp_t wait)
-{
-	journal_t *journal = EXT4_SB(sb)->s_journal;
-
-	WARN_ON(PageChecked(page));
-	if (!page_has_buffers(page))
-		return 0;
-	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page);
-
-	return try_to_free_buffers(page);
-}
-
 #ifdef CONFIG_FS_ENCRYPTION
 static int ext4_get_context(struct inode *inode, void *ctx, size_t len)
 {
@@ -1656,7 +1636,6 @@ static const struct super_operations ext4_sops = {
 	.quota_write	= ext4_quota_write,
 	.get_dquots	= ext4_get_dquots,
 #endif
-	.bdev_try_to_free_page = bdev_try_to_free_page,
 };
 
 static const struct export_operations ext4_export_ops = {
-- 
2.31.1

