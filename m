Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E6A785B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfIDCKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727716AbfIDCKW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 60BE85B9F2CE80E7185B;
        Wed,  4 Sep 2019 10:10:20 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:11 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 06/25] erofs: use feature_incompat rather than requirements
Date:   Wed, 4 Sep 2019 10:08:53 +0800
Message-ID: <20190904020912.63925-7-gaoxiang25@huawei.com>
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

As Christoph said [1], "This is only cosmetic, why
not stick to feature_compat and feature_incompat?"

In my thought, requirements means "incompatible"
instead of "feature" though.

[1] https://lore.kernel.org/r/20190902125109.GA9826@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/decompressor.c |  3 ++-
 fs/erofs/erofs_fs.h     | 12 ++++++------
 fs/erofs/internal.h     |  2 +-
 fs/erofs/super.c        | 10 +++++-----
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index df349888f911..555c04730f87 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -129,7 +129,8 @@ static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	support_0padding = false;
 
 	/* decompression inplace is only safe when 0padding is enabled */
-	if (EROFS_SB(rq->sb)->requirements & EROFS_REQUIREMENT_LZ4_0PADDING) {
+	if (EROFS_SB(rq->sb)->feature_incompat &
+	    EROFS_FEATURE_INCOMPAT_LZ4_0PADDING) {
 		support_0padding = true;
 
 		while (!src[inputmargin & ~PAGE_MASK])
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 87d7ae82339a..b2aef3bc377d 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -11,17 +11,17 @@
 #define EROFS_SUPER_OFFSET      1024
 
 /*
- * Any bits that aren't in EROFS_ALL_REQUIREMENTS should be
- * incompatible with this kernel version.
+ * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
+ * be incompatible with this kernel version.
  */
-#define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
-#define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
+#define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
+#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
 
 /* 128-byte erofs on-disk super block */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c(super_block) */
-	__le32 features;        /* (aka. feature_compat) */
+	__le32 feature_compat;
 	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
 	__u8 reserved;
 
@@ -35,7 +35,7 @@ struct erofs_super_block {
 	__le32 xattr_blkaddr;	/* start block address of shared xattr area */
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
-	__le32 requirements;    /* (aka. feature_incompat) */
+	__le32 feature_incompat;
 
 	__u8 reserved2[44];
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 141ea424587d..7ff36f404ec3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -96,7 +96,7 @@ struct erofs_sb_info {
 
 	u8 uuid[16];                    /* 128-bit uuid for volume */
 	u8 volume_name[16];             /* volume name */
-	u32 requirements;
+	u32 feature_incompat;
 
 	unsigned int mount_opt;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6603f0ba8905..6a7ab194783c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -67,14 +67,14 @@ static void free_inode(struct inode *inode)
 static bool check_layout_compatibility(struct super_block *sb,
 				       struct erofs_super_block *layout)
 {
-	const unsigned int requirements = le32_to_cpu(layout->requirements);
+	const unsigned int feature = le32_to_cpu(layout->feature_incompat);
 
-	EROFS_SB(sb)->requirements = requirements;
+	EROFS_SB(sb)->feature_incompat = feature;
 
 	/* check if current kernel meets all mandatory requirements */
-	if (requirements & (~EROFS_ALL_REQUIREMENTS)) {
-		errln("unidentified requirements %x, please upgrade kernel version",
-		      requirements & ~EROFS_ALL_REQUIREMENTS);
+	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+		errln("unidentified incompatible feature %x, please upgrade kernel version",
+		      feature & ~EROFS_ALL_FEATURE_INCOMPAT);
 		return false;
 	}
 	return true;
-- 
2.17.1

