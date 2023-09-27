Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B87B0039
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjI0Jew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjI0Jer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E5F3;
        Wed, 27 Sep 2023 02:34:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BA8E21923;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJahATwxr9VZcdOvUMcI9efm5A4a21UZKaIArhmnL5I=;
        b=XNCfzwklSl82zqH3bLkdyNXMdA6nH7NYuhkuOEQz/JJj0D/8AXgvn1Y9EldxRo60fqAZMn
        qbU05a38Oh9D2I+RwMNfHg2zCndXTYNnLz5T/aFaGhKJuObyDuNb7pqYD16mVbh0Eqeans
        YVaqPwhmQJNQ8lP/0rYx+bordzmpQmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJahATwxr9VZcdOvUMcI9efm5A4a21UZKaIArhmnL5I=;
        b=WtOJR2euAe6vDeQWOeX1BQ0D4aM5FQc4z7REO1RPTaJXeFxFbZzDpu5b1+x//JrbYTPx3s
        D2/3qeSz0L1On4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 860691338F;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tnAmIDP3E2UEEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E5EF4A07CC; Wed, 27 Sep 2023 11:34:42 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Date:   Wed, 27 Sep 2023 11:34:08 +0200
Message-Id: <20230927093442.25915-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4325; i=jack@suse.cz; h=from:subject; bh=ZaCPAqbvKT9GgwXa8PL7frDsi6A0NM+2seWGXEak4nM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cSa4bIr3tfY4rouIR87095UDKovPpwyjE1633Z /W4bQeKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3EgAKCRCcnaoHP2RA2fV9B/ 0YhTFgWHFLBHjl9+g/mMV2BqORT9UReAiUk2lLaJQAKGgEWf1P8qWR6hC+oSZp0cTugPMPDE9BKf66 4ksqM0JB1w1ALWy/wpqgFRmrNmkgty93+Da7wC6RtilmZv+qTT7gPpd21m+V9L88ngNcnsDz5JeVtl uXC+b7LD19mSasDggJLlhT6oqyYPy/JZjzkA0nPw4nNnkb+if+dctdhNgoHIL8wXIKBBu0Uov/M/6C d7Xa6eebTR0lTUf8juyCaoE9j1KqznGayKVrcHYdFbs51TsyGRBAOqKSG7oQFgPimM/tlaH1pelPMJ eGtbfOSTo/z8CIUx1VxcDfwol3wkNu
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert blkdev_open() to use bdev_open_by_dev(). To be able to propagate
handle from blkdev_open() to blkdev_release() we need to stop using
existence of file->private_data to determine exclusive block device
opens. Use bdev_handle->mode for this purpose since file->f_flags
isn't usable for this (O_EXCL is cleared from the flags during open).

Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           |  3 +++
 block/fops.c           | 44 +++++++++++++++++++++++++++---------------
 include/linux/blkdev.h |  1 +
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index bdc7d739882b..4628dcb1da8a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -844,6 +844,9 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	}
 	handle->bdev = bdev;
 	handle->holder = holder;
+	if (holder)
+		mode |= BLK_OPEN_EXCL;
+	handle->mode = mode;
 	return handle;
 }
 EXPORT_SYMBOL(bdev_open_by_dev);
diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..91e9cf2fca24 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -542,15 +542,31 @@ static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 	return error;
 }
 
+/**
+ * file_to_blk_mode - get block open flags from file flags
+ * @file: file whose open flags should be converted
+ *
+ * Look at file open flags and generate corresponding block open flags from
+ * them. The function works both for file just being open (e.g. during ->open
+ * callback) and for file that is already open. This is actually non-trivial
+ * (see comment in the function).
+ */
 blk_mode_t file_to_blk_mode(struct file *file)
 {
 	blk_mode_t mode = 0;
+	struct bdev_handle *handle = file->private_data;
 
 	if (file->f_mode & FMODE_READ)
 		mode |= BLK_OPEN_READ;
 	if (file->f_mode & FMODE_WRITE)
 		mode |= BLK_OPEN_WRITE;
-	if (file->private_data)
+	/*
+	 * do_dentry_open() clears O_EXCL from f_flags, use handle->mode to
+	 * determine whether the open was exclusive for already open files.
+	 */
+	if (handle)
+		mode |= handle->mode & BLK_OPEN_EXCL;
+	else if (file->f_flags & O_EXCL)
 		mode |= BLK_OPEN_EXCL;
 	if (file->f_flags & O_NDELAY)
 		mode |= BLK_OPEN_NDELAY;
@@ -568,7 +584,8 @@ blk_mode_t file_to_blk_mode(struct file *file)
 
 static int blkdev_open(struct inode *inode, struct file *filp)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
+	blk_mode_t mode;
 
 	/*
 	 * Preserve backwards compatibility and allow large file access
@@ -579,29 +596,24 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	filp->f_flags |= O_LARGEFILE;
 	filp->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
 
-	/*
-	 * Use the file private data to store the holder for exclusive openes.
-	 * file_to_blk_mode relies on it being present to set BLK_OPEN_EXCL.
-	 */
-	if (filp->f_flags & O_EXCL)
-		filp->private_data = filp;
-
-	bdev = blkdev_get_by_dev(inode->i_rdev, file_to_blk_mode(filp),
-				 filp->private_data, NULL);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	mode = file_to_blk_mode(filp);
+	handle = bdev_open_by_dev(inode->i_rdev, mode,
+			mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
-	if (bdev_nowait(bdev))
+	if (bdev_nowait(handle->bdev))
 		filp->f_mode |= FMODE_NOWAIT;
 
-	filp->f_mapping = bdev->bd_inode->i_mapping;
+	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
+	filp->private_data = handle;
 	return 0;
 }
 
 static int blkdev_release(struct inode *inode, struct file *filp)
 {
-	blkdev_put(I_BDEV(filp->f_mapping->host), filp->private_data);
+	bdev_release(filp->private_data);
 	return 0;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 03d3adc3ff34..51fa7ffdee83 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1482,6 +1482,7 @@ extern const struct blk_holder_ops fs_holder_ops;
 struct bdev_handle {
 	struct block_device *bdev;
 	void *holder;
+	blk_mode_t mode;
 };
 
 struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-- 
2.35.3

