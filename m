Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C998FBD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfHPHM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 03:12:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfHPHM2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:12:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0B2F5E6B3FC0967671C6;
        Fri, 16 Aug 2019 15:12:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 16 Aug
 2019 15:12:16 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: use common file type conversion
Date:   Fri, 16 Aug 2019 15:11:42 +0800
Message-ID: <20190816071142.8633-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deduplicate the EROFS file type conversion implementation and
remove EROFS_FT_* definitions since it's the same as defined
by POSIX, let's follow ext2 as Linus pointed out [1]
commit e10892189428 ("ext2: use common file type conversion").

[1] https://lore.kernel.org/r/CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com/

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/dir.c      | 16 +---------------
 drivers/staging/erofs/erofs_fs.h | 17 +++++------------
 drivers/staging/erofs/namei.c    |  2 +-
 3 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index 01efc96e1212..5f38382637e6 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -8,17 +8,6 @@
  */
 #include "internal.h"
 
-static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
-	[EROFS_FT_UNKNOWN]	= DT_UNKNOWN,
-	[EROFS_FT_REG_FILE]	= DT_REG,
-	[EROFS_FT_DIR]		= DT_DIR,
-	[EROFS_FT_CHRDEV]	= DT_CHR,
-	[EROFS_FT_BLKDEV]	= DT_BLK,
-	[EROFS_FT_FIFO]		= DT_FIFO,
-	[EROFS_FT_SOCK]		= DT_SOCK,
-	[EROFS_FT_SYMLINK]	= DT_LNK,
-};
-
 static void debug_one_dentry(unsigned char d_type, const char *de_name,
 			     unsigned int de_namelen)
 {
@@ -46,10 +35,7 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		unsigned int de_namelen;
 		unsigned char d_type;
 
-		if (de->file_type < EROFS_FT_MAX)
-			d_type = erofs_filetype_table[de->file_type];
-		else
-			d_type = DT_UNKNOWN;
+		d_type = fs_ftype_to_dtype(de->file_type);
 
 		nameoff = le16_to_cpu(de->nameoff);
 		de_name = (char *)dentry_blk + nameoff;
diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 8dc2a75e478f..6db70f395937 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -282,18 +282,11 @@ struct erofs_dirent {
 	__u8 reserved;  /* 11, reserved */
 } __packed;
 
-/* file types used in inode_info->flags */
-enum {
-	EROFS_FT_UNKNOWN,
-	EROFS_FT_REG_FILE,
-	EROFS_FT_DIR,
-	EROFS_FT_CHRDEV,
-	EROFS_FT_BLKDEV,
-	EROFS_FT_FIFO,
-	EROFS_FT_SOCK,
-	EROFS_FT_SYMLINK,
-	EROFS_FT_MAX
-};
+/*
+ * EROFS file types should match generic FT_* types and
+ * it seems no need to add BUILD_BUG_ONs since potential
+ * unmatchness will break other fses as well...
+ */
 
 #define EROFS_NAME_LEN      255
 
diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index c0963f5a2d22..8334a910acef 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -237,7 +237,7 @@ static struct dentry *erofs_lookup(struct inode *dir,
 	} else {
 		debugln("%s, %s (nid %llu) found, d_type %u", __func__,
 			dentry->d_name.name, nid, d_type);
-		inode = erofs_iget(dir->i_sb, nid, d_type == EROFS_FT_DIR);
+		inode = erofs_iget(dir->i_sb, nid, d_type == FT_DIR);
 	}
 	return d_splice_alias(inode, dentry);
 }
-- 
2.17.1

