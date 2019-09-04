Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA406A7875
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfIDCKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727979AbfIDCKk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE6FA4F6F33C692D600A;
        Wed,  4 Sep 2019 10:10:38 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:26 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 19/25] erofs: kill all erofs specific fault injection
Date:   Wed, 4 Sep 2019 10:09:06 +0800
Message-ID: <20190904020912.63925-20-gaoxiang25@huawei.com>
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

As Christoph suggested [1], "Please just use plain kmalloc
everywhere and let the normal kernel error injection code
take care of injeting any errors."

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 Documentation/filesystems/erofs.txt |  5 ---
 fs/erofs/Kconfig                    |  7 ---
 fs/erofs/data.c                     |  7 ---
 fs/erofs/inode.c                    |  3 +-
 fs/erofs/internal.h                 | 65 ---------------------------
 fs/erofs/super.c                    | 70 -----------------------------
 fs/erofs/zdata.c                    |  8 +---
 7 files changed, 2 insertions(+), 163 deletions(-)

diff --git a/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
index 38aa9126ec98..c3b5f603b2b6 100644
--- a/Documentation/filesystems/erofs.txt
+++ b/Documentation/filesystems/erofs.txt
@@ -52,11 +52,6 @@ linux-erofs mailing list:
 Mount options
 =============
 
-fault_injection=%d     Enable fault injection in all supported types with
-                       specified injection rate. Supported injection type:
-                       Type_Name                Type_Value
-                       FAULT_KMALLOC            0x000000001
-                       FAULT_READ_IO            0x000000002
 (no)user_xattr         Setup Extended User Attributes. Note: xattr is enabled
                        by default if CONFIG_EROFS_FS_XATTR is selected.
 (no)acl                Setup POSIX Access Control List. Note: acl is enabled
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 16316d1adca3..9d634d3a1845 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -27,13 +27,6 @@ config EROFS_FS_DEBUG
 
 	  For daily use, say N.
 
-config EROFS_FAULT_INJECTION
-	bool "EROFS fault injection facility"
-	depends on EROFS_FS
-	help
-	  Test EROFS to inject faults such as ENOMEM, EIO, and so on.
-	  If unsure, say N.
-
 config EROFS_FS_XATTR
 	bool "EROFS extended attributes"
 	depends on EROFS_FS
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3ce87a88452a..b5f5b8592d14 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -11,16 +11,10 @@
 
 static void erofs_readendio(struct bio *bio)
 {
-	struct super_block *const sb = bio->bi_private;
 	struct bio_vec *bvec;
 	blk_status_t err = bio->bi_status;
 	struct bvec_iter_all iter_all;
 
-	if (time_to_inject(EROFS_SB(sb), FAULT_READ_IO)) {
-		erofs_show_injection_info(FAULT_READ_IO);
-		err = BLK_STS_IOERR;
-	}
-
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
 
@@ -48,7 +42,6 @@ static struct bio *erofs_grab_raw_bio(struct super_block *sb,
 	bio->bi_end_io = erofs_readendio;
 	bio_set_dev(bio, sb->s_bdev);
 	bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
-	bio->bi_private = sb;
 	if (ismeta)
 		bio->bi_opf = REQ_OP_READ | REQ_META;
 	else
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 384905e0677c..8e53765a532c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -131,7 +131,6 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	char *lnk;
 
 	/* if it cannot be handled with fast symlink scheme */
@@ -141,7 +140,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 		return 0;
 	}
 
-	lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
+	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
 	if (!lnk)
 		return -ENOMEM;
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 881eb2ee18b5..d659c1941f93 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -32,23 +32,6 @@
 #define DBG_BUGON(x)            ((void)(x))
 #endif	/* !CONFIG_EROFS_FS_DEBUG */
 
-enum {
-	FAULT_KMALLOC,
-	FAULT_READ_IO,
-	FAULT_MAX,
-};
-
-#ifdef CONFIG_EROFS_FAULT_INJECTION
-extern const char *erofs_fault_name[FAULT_MAX];
-#define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
-
-struct erofs_fault_info {
-	atomic_t inject_ops;
-	unsigned int inject_rate;
-	unsigned int inject_type;
-};
-#endif	/* CONFIG_EROFS_FAULT_INJECTION */
-
 /* EROFS_SUPER_MAGIC_V1 to represent the whole file system */
 #define EROFS_SUPER_MAGIC   EROFS_SUPER_MAGIC_V1
 
@@ -99,62 +82,14 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 
 	unsigned int mount_opt;
-
-#ifdef CONFIG_EROFS_FAULT_INJECTION
-	struct erofs_fault_info fault_info;	/* For fault injection */
-#endif
 };
 
-#ifdef CONFIG_EROFS_FAULT_INJECTION
-#define erofs_show_injection_info(type)					\
-	infoln("inject %s in %s of %pS", erofs_fault_name[type],        \
-		__func__, __builtin_return_address(0))
-
-static inline bool time_to_inject(struct erofs_sb_info *sbi, int type)
-{
-	struct erofs_fault_info *ffi = &sbi->fault_info;
-
-	if (!ffi->inject_rate)
-		return false;
-
-	if (!IS_FAULT_SET(ffi, type))
-		return false;
-
-	atomic_inc(&ffi->inject_ops);
-	if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
-		atomic_set(&ffi->inject_ops, 0);
-		return true;
-	}
-	return false;
-}
-#else
-static inline bool time_to_inject(struct erofs_sb_info *sbi, int type)
-{
-	return false;
-}
-
-static inline void erofs_show_injection_info(int type)
-{
-}
-#endif	/* !CONFIG_EROFS_FAULT_INJECTION */
-
-static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
-					size_t size, gfp_t flags)
-{
-	if (time_to_inject(sbi, FAULT_KMALLOC)) {
-		erofs_show_injection_info(FAULT_KMALLOC);
-		return NULL;
-	}
-	return kmalloc(size, flags);
-}
-
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
 #define EROFS_I_SB(inode) ((struct erofs_sb_info *)(inode)->i_sb->s_fs_info)
 
 /* Mount flags set via mount options or defaults */
 #define EROFS_MOUNT_XATTR_USER		0x00000010
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
-#define EROFS_MOUNT_FAULT_INJECTION	0x00000040
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt |= EROFS_MOUNT_##option)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 36e569a79172..407c95854be1 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -126,63 +126,6 @@ static int erofs_read_superblock(struct super_block *sb)
 	return ret;
 }
 
-#ifdef CONFIG_EROFS_FAULT_INJECTION
-const char *erofs_fault_name[FAULT_MAX] = {
-	[FAULT_KMALLOC]		= "kmalloc",
-	[FAULT_READ_IO]		= "read IO error",
-};
-
-static void __erofs_build_fault_attr(struct erofs_sb_info *sbi,
-				     unsigned int rate)
-{
-	struct erofs_fault_info *ffi = &sbi->fault_info;
-
-	if (rate) {
-		atomic_set(&ffi->inject_ops, 0);
-		ffi->inject_rate = rate;
-		ffi->inject_type = (1 << FAULT_MAX) - 1;
-	} else {
-		memset(ffi, 0, sizeof(struct erofs_fault_info));
-	}
-
-	set_opt(sbi, FAULT_INJECTION);
-}
-
-static int erofs_build_fault_attr(struct erofs_sb_info *sbi,
-				  substring_t *args)
-{
-	int rate = 0;
-
-	if (args->from && match_int(args, &rate))
-		return -EINVAL;
-
-	__erofs_build_fault_attr(sbi, rate);
-	return 0;
-}
-
-static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
-{
-	return sbi->fault_info.inject_rate;
-}
-#else
-static void __erofs_build_fault_attr(struct erofs_sb_info *sbi,
-				     unsigned int rate)
-{
-}
-
-static int erofs_build_fault_attr(struct erofs_sb_info *sbi,
-				  substring_t *args)
-{
-	infoln("fault_injection options not supported");
-	return 0;
-}
-
-static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_EROFS_FS_ZIP
 static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
 				      substring_t *args)
@@ -237,7 +180,6 @@ enum {
 	Opt_nouser_xattr,
 	Opt_acl,
 	Opt_noacl,
-	Opt_fault_injection,
 	Opt_cache_strategy,
 	Opt_err
 };
@@ -247,7 +189,6 @@ static match_table_t erofs_tokens = {
 	{Opt_nouser_xattr, "nouser_xattr"},
 	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
-	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_cache_strategy, "cache_strategy=%s"},
 	{Opt_err, NULL}
 };
@@ -301,11 +242,6 @@ static int erofs_parse_options(struct super_block *sb, char *options)
 			infoln("noacl options not supported");
 			break;
 #endif
-		case Opt_fault_injection:
-			err = erofs_build_fault_attr(EROFS_SB(sb), args);
-			if (err)
-				return err;
-			break;
 		case Opt_cache_strategy:
 			err = erofs_build_cache_strategy(EROFS_SB(sb), args);
 			if (err)
@@ -593,9 +529,6 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	else
 		seq_puts(seq, ",noacl");
 #endif
-	if (test_opt(sbi, FAULT_INJECTION))
-		seq_printf(seq, ",fault_injection=%u",
-			   erofs_get_fault_rate(sbi));
 #ifdef CONFIG_EROFS_FS_ZIP
 	if (sbi->cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
 		seq_puts(seq, ",cache_strategy=disabled");
@@ -615,7 +548,6 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	unsigned int org_mnt_opt = sbi->mount_opt;
-	unsigned int org_inject_rate = erofs_get_fault_rate(sbi);
 	int err;
 
 	DBG_BUGON(!sb_rdonly(sb));
@@ -631,9 +563,7 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 	*flags |= SB_RDONLY;
 	return 0;
 out:
-	__erofs_build_fault_attr(sbi, org_inject_rate);
 	sbi->mount_opt = org_mnt_opt;
-
 	return err;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8587d6751c48..ff8ab444172d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -724,15 +724,9 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(!page->mapping);
 
-		if (!sbi && !z_erofs_page_is_staging(page)) {
+		if (!sbi && !z_erofs_page_is_staging(page))
 			sbi = EROFS_SB(page->mapping->host->i_sb);
 
-			if (time_to_inject(sbi, FAULT_READ_IO)) {
-				erofs_show_injection_info(FAULT_READ_IO);
-				err = BLK_STS_IOERR;
-			}
-		}
-
 		/* sbi should already be gotten if the page is managed */
 		if (sbi)
 			cachemngd = erofs_page_is_managed(sbi, page);
-- 
2.17.1

