Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3EE46FBB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhLJHkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:21 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45081 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237750AbhLJHkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-83nvA_1639121795;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-83nvA_1639121795)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:36 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 13/19] erofs: add bootstrap_path mount option
Date:   Fri, 10 Dec 2021 15:36:13 +0800
Message-Id: <20211210073619.21667-14-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Until then erofs is exactly blockdev based filesystem. In other using
scenarios (e.g. container image), erofs needs to run upon files.

This patch introduces a new mount option "bootstrap_path", which is used
to specify the bootstrap blob file containing the complete erofs image.
Then erofs could be mounted from the bootstrap blob file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 13 ++++++++++---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 40 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 477aaff0c832..cf71082bd52f 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -11,11 +11,18 @@
 
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 {
-	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space * mapping;
 	struct page *page;
 
-	page = read_cache_page_gfp(mapping, blkaddr,
-				   mapping_gfp_constraint(mapping, ~__GFP_FS));
+	if (sb->s_bdev) {
+		mapping = sb->s_bdev->bd_inode->i_mapping;
+		page = read_cache_page_gfp(mapping, blkaddr,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
+	} else {
+		/* TODO: fscache based data path */
+		page = ERR_PTR(-EINVAL);
+	}
+
 	/* should already be PageUptodate */
 	if (!IS_ERR(page))
 		lock_page(page);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 45fb6f5d11b5..cf69d9c9cbed 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -67,6 +67,7 @@ struct erofs_mount_opts {
 	unsigned int max_sync_decompress_pages;
 #endif
 	unsigned int mount_opt;
+	char *bootstrap_path;
 };
 
 struct erofs_dev_context {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6a969b1e0ee6..51695f6d4449 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -440,6 +440,7 @@ enum {
 	Opt_dax,
 	Opt_dax_enum,
 	Opt_device,
+	Opt_bootstrap_path,
 	Opt_err
 };
 
@@ -464,6 +465,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag("dax",             Opt_dax),
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
+	fsparam_string("bootstrap_path",Opt_bootstrap_path),
 	{}
 };
 
@@ -559,6 +561,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		}
 		++ctx->devs->extra_devices;
 		break;
+	case Opt_bootstrap_path:
+		kfree(ctx->opt.bootstrap_path);
+		ctx->opt.bootstrap_path = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.bootstrap_path)
+			return -ENOMEM;
+		infofc(fc, "RAFS bootstrap_path %s", ctx->opt.bootstrap_path);
+		break;
+
 	default:
 		return -ENOPARAM;
 	}
@@ -633,9 +643,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
 
-	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
+	if (sb->s_bdev && !sb_set_blocksize(sb, EROFS_BLKSIZ)) {
 		erofs_err(sb, "failed to set erofs blksize");
 		return -EINVAL;
+	} else {
+		sb->s_blocksize = EROFS_BLKSIZ;
+		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
 	}
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
@@ -644,16 +657,21 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
-	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
+	if (sb->s_bdev)
+		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
+	else
+		sbi->dax_dev = NULL;
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
 
 	if (test_opt(&sbi->opt, DAX_ALWAYS) &&
-	    !dax_supported(sbi->dax_dev, sb->s_bdev, EROFS_BLKSIZ, 0, bdev_nr_sectors(sb->s_bdev))) {
+	    (!sbi->dax_dev ||
+	     !dax_supported(sbi->dax_dev, sb->s_bdev, EROFS_BLKSIZ, 0, bdev_nr_sectors(sb->s_bdev)))) {
 		errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
 		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
@@ -701,6 +719,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
+	struct erofs_fs_context *ctx = fc->fs_private;
+
+	if (ctx->opt.bootstrap_path)
+		return get_tree_nodev(fc, erofs_fc_fill_super);
 	return get_tree_bdev(fc, erofs_fc_fill_super);
 }
 
@@ -749,6 +771,7 @@ static void erofs_fc_free(struct fs_context *fc)
 	struct erofs_fs_context *ctx = fc->fs_private;
 
 	erofs_free_dev_context(ctx->devs);
+	kfree(ctx->opt.bootstrap_path);
 	kfree(ctx);
 }
 
@@ -789,7 +812,10 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
-	kill_block_super(sb);
+	if (sb->s_bdev)
+		kill_block_super(sb);
+	else
+		generic_shutdown_super(sb);
 
 	sbi = EROFS_SB(sb);
 	if (!sbi)
@@ -889,7 +915,11 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
+	u64 id = 0;
+
+	/* TODO: fsid in nodev mode */
+	if (sb->s_bdev)
+		id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = EROFS_BLKSIZ;
-- 
2.27.0

