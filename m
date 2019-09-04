Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FDBA7864
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfIDCK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59884 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727899AbfIDCK0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7F8A3CC9CCE41AD6FC5E;
        Wed,  4 Sep 2019 10:10:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:19 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 13/25] erofs: use dsb instead of layout for ondisk super_block
Date:   Wed, 4 Sep 2019 10:09:00 +0800
Message-ID: <20190904020912.63925-14-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Christoph pointed out [1], "Why is the variable name
for the on-disk subperblock layout? We usually still
calls this something with sb in the name, e.g. dsb.
for disksuper block. " Let's fix it.

[1] https://lore.kernel.org/r/20190829101545.GC20598@infradead.org/
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/super.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b8b0e35f6621..63cb17a4073b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -49,9 +49,9 @@ static void free_inode(struct inode *inode)
 }
 
 static bool check_layout_compatibility(struct super_block *sb,
-				       struct erofs_super_block *layout)
+				       struct erofs_super_block *dsb)
 {
-	const unsigned int feature = le32_to_cpu(layout->feature_incompat);
+	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
 
 	EROFS_SB(sb)->feature_incompat = feature;
 
@@ -68,7 +68,7 @@ static int superblock_read(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 	struct buffer_head *bh;
-	struct erofs_super_block *layout;
+	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
 	int ret;
 
@@ -80,16 +80,15 @@ static int superblock_read(struct super_block *sb)
 	}
 
 	sbi = EROFS_SB(sb);
-	layout = (struct erofs_super_block *)((u8 *)bh->b_data
-		 + EROFS_SUPER_OFFSET);
+	dsb = (struct erofs_super_block *)(bh->b_data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
-	if (le32_to_cpu(layout->magic) != EROFS_SUPER_MAGIC_V1) {
+	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		errln("cannot find valid erofs superblock");
 		goto out;
 	}
 
-	blkszbits = layout->blkszbits;
+	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
 		errln("blksize %u isn't supported on this platform",
@@ -97,25 +96,25 @@ static int superblock_read(struct super_block *sb)
 		goto out;
 	}
 
-	if (!check_layout_compatibility(sb, layout))
+	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
-	sbi->blocks = le32_to_cpu(layout->blocks);
-	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
+	sbi->blocks = le32_to_cpu(dsb->blocks);
+	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
-	sbi->xattr_blkaddr = le32_to_cpu(layout->xattr_blkaddr);
+	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
-	sbi->root_nid = le16_to_cpu(layout->root_nid);
-	sbi->inos = le64_to_cpu(layout->inos);
+	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+	sbi->inos = le64_to_cpu(dsb->inos);
 
-	sbi->build_time = le64_to_cpu(layout->build_time);
-	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
+	sbi->build_time = le64_to_cpu(dsb->build_time);
+	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
-	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
+	memcpy(&sb->s_uuid, dsb->uuid, sizeof(dsb->uuid));
 
-	ret = strscpy(sbi->volume_name, layout->volume_name,
-		      sizeof(layout->volume_name));
+	ret = strscpy(sbi->volume_name, dsb->volume_name,
+		      sizeof(dsb->volume_name));
 	if (ret < 0) {	/* -E2BIG */
 		errln("bad volume name without NIL terminator");
 		ret = -EFSCORRUPTED;
-- 
2.17.1

