Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA4707910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEREYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjEREX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C013AA1;
        Wed, 17 May 2023 21:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5iWXLribFSMk5YyBra23mYaQN0Hu+sN16ZJTU3OHREM=; b=ccKMwoFcMAzC2nlfS1cDS4S4zW
        VPtkNrAdPd+9AZAYo79Lln9z4PIm9RhT/V9Q6QG11LJ0Vm6TL2WdQ+wysqrIAU5AQpKKCf8ygJXjz
        RgT05HJJrA+TKXFtsPRSBIAreu6Bvdx2alVaPGcfciXcw7F/St1CuWHXxP50Yan0aNph9mX7PAuHK
        tc2f7hZkFsKOBvJmdBjxD8b0/gIdJV1OqKqT9GMMQ0hrdB2o+h0D14UzVQPPniYwUc/Lk7H/qMzV3
        8dC+Ebg1270RW4RTEXblNIpZP/hg3G3NKQw3IdZzgRoDJD/+9bprFHxrgjRQdxjjQ/o5WrR2O5bnA
        ADMNaXDw==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVBB-00BqS3-0n;
        Thu, 18 May 2023 04:23:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 11/13] fs: add a method to shut down the file system
Date:   Thu, 18 May 2023 06:23:20 +0200
Message-Id: <20230518042323.663189-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518042323.663189-1-hch@lst.de>
References: <20230518042323.663189-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new ->shutdown super operation that can be used to tell the file
system to shut down, and call it from newly created holder ops when the
block device under a file system shuts down.

This only covers the main block device for "simple" file systems using
get_tree_bdev / mount_bdev.  File systems their own get_tree method
or opening additional devices will need to set up their own
blk_holder_ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c         | 21 +++++++++++++++++++--
 include/linux/fs.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 012ce140080375..f127589700ab25 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1206,6 +1206,22 @@ int get_tree_keyed(struct fs_context *fc,
 EXPORT_SYMBOL(get_tree_keyed);
 
 #ifdef CONFIG_BLOCK
+static void fs_mark_dead(struct block_device *bdev)
+{
+	struct super_block *sb;
+
+	sb = get_super(bdev);
+	if (!sb)
+		return;
+
+	if (sb->s_op->shutdown)
+		sb->s_op->shutdown(sb);
+	drop_super(sb);
+}
+
+static const struct blk_holder_ops fs_holder_ops = {
+	.mark_dead		= fs_mark_dead,
+};
 
 static int set_bdev_super(struct super_block *s, void *data)
 {
@@ -1248,7 +1264,8 @@ int get_tree_bdev(struct fs_context *fc,
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
-	bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type, NULL);
+	bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type,
+				  &fs_holder_ops);
 	if (IS_ERR(bdev)) {
 		errorf(fc, "%s: Can't open blockdev", fc->source);
 		return PTR_ERR(bdev);
@@ -1333,7 +1350,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	if (!(flags & SB_RDONLY))
 		mode |= FMODE_WRITE;
 
-	bdev = blkdev_get_by_path(dev_name, mode, fs_type, NULL);
+	bdev = blkdev_get_by_path(dev_name, mode, fs_type, &fs_holder_ops);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a98168085641..cf3042641b9b30 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1932,6 +1932,7 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	void (*shutdown)(struct super_block *sb);
 };
 
 /*
-- 
2.39.2

