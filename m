Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55067855DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjHWKt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjHWKtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:49:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FB3E60;
        Wed, 23 Aug 2023 03:48:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC52B21EBC;
        Wed, 23 Aug 2023 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5NyQZfinBzDLZs9DG26KLGByvr6gwxKqNQmB6WlIrQ=;
        b=Y09gFVm2jPJH1lIJjNx/RvAGoagHbQzljGkqat0IqqLoasxQLBUgXk+jDVdeqypS1ckK1L
        Pj5wkOyOXbT1UX8Oa+C5Qmu0ChQZxW7NrwpB/I72behqfKh9ZoLHcQG1N7ajGryKCktfvj
        YmF093TxYWON2PwrPIr/y5/D7IXNo3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787737;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5NyQZfinBzDLZs9DG26KLGByvr6gwxKqNQmB6WlIrQ=;
        b=xkz74XymRJ5iEoy6JcHRNDGKHoijfK5ZHKB3cWyIP76Mzj1QqJr/QfAMM8f3iWe4XBDjh/
        ylgZihfy8obitiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF61513592;
        Wed, 23 Aug 2023 10:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bmyeMhnk5WQnIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1796DA0776; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Date:   Wed, 23 Aug 2023 12:48:13 +0200
Message-Id: <20230823104857.11437-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5911; i=jack@suse.cz; h=from:subject; bh=/PBkwz0H+WwAM2yBl9MyFct4P2zDBV6CSxl5ekSnNtw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5ePvoFLhCOXtHuMcB4JLKdI/5p+gTNLhKndrGxj2 FXSKBYCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj7wAKCRCcnaoHP2RA2XR/CA Df+m1Crf6jufWpzdRHpsMLjWMXZkI7T0wunNUs7yHJAL2U3bneeCwewx7OQ+aFJ5o6BczJ+fQ23l+4 r205i66aExQjmHDI7+cM3Su6e7+HF6U7ZHdtcrk+/9Xba8aXnH41wa4JydmVg9TB7IDWWFgi4YfkQZ apR91LTB/j6PWhvwjmxDXYO+wIGsZV3aJF+O3o0Aq1RYINbDz5dhXv8owgQNsV+lk0hOBiSDB0CsPB KedAejQwiq7uMY7cIfVhB7UV1un0Z177MIcrD9chvcKHkibgCx3Sl0InE2wINwdhIwy651QAYgXJHY OEKsB18ketd0XeqY2pZd0dkJKCLUnM
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           |  3 +++
 block/blk.h            |  1 -
 block/fops.c           | 34 ++++++++++++++++------------------
 block/ioctl.c          |  6 ++++--
 include/linux/blkdev.h |  1 +
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index fce150f9e66d..f1de1e65517b 100644
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
diff --git a/block/blk.h b/block/blk.h
index 608c5dcc516b..43b80dc78918 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -464,7 +464,6 @@ extern struct device_attribute dev_attr_events_poll_msecs;
 
 extern struct attribute_group blk_trace_attr_group;
 
-blk_mode_t file_to_blk_mode(struct file *file);
 int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 		loff_t lstart, loff_t lend);
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
diff --git a/block/fops.c b/block/fops.c
index a286bf3325c5..7261c27c7901 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -470,7 +470,7 @@ static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 	return error;
 }
 
-blk_mode_t file_to_blk_mode(struct file *file)
+static blk_mode_t file_to_blk_mode(struct file *file)
 {
 	blk_mode_t mode = 0;
 
@@ -478,7 +478,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
 		mode |= BLK_OPEN_READ;
 	if (file->f_mode & FMODE_WRITE)
 		mode |= BLK_OPEN_WRITE;
-	if (file->private_data)
+	if (file->f_flags & O_EXCL)
 		mode |= BLK_OPEN_EXCL;
 	if (file->f_flags & O_NDELAY)
 		mode |= BLK_OPEN_NDELAY;
@@ -496,7 +496,8 @@ blk_mode_t file_to_blk_mode(struct file *file)
 
 static int blkdev_open(struct inode *inode, struct file *filp)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
+	blk_mode_t mode;
 
 	/*
 	 * Preserve backwards compatibility and allow large file access
@@ -507,29 +508,24 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	filp->f_flags |= O_LARGEFILE;
 	filp->f_mode |= FMODE_BUF_RASYNC;
 
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
 
@@ -630,6 +626,8 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 {
 	struct inode *inode = bdev_file_inode(file);
 	struct block_device *bdev = I_BDEV(inode);
+	struct bdev_handle *bdev_handle = file->private_data;
+	blk_mode_t open_mode = bdev_handle->mode;
 	loff_t end = start + len - 1;
 	loff_t isize;
 	int error;
@@ -659,7 +657,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+	error = truncate_bdev_range(bdev, open_mode, start, end);
 	if (error)
 		goto fail;
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 648670ddb164..54c1e2f71031 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -582,7 +582,8 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	void __user *argp = (void __user *)arg;
-	blk_mode_t mode = file_to_blk_mode(file);
+	struct bdev_handle *bdev_handle = file->private_data;
+	blk_mode_t mode = bdev_handle->mode;
 	int ret;
 
 	switch (cmd) {
@@ -643,7 +644,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	void __user *argp = compat_ptr(arg);
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	struct gendisk *disk = bdev->bd_disk;
-	blk_mode_t mode = file_to_blk_mode(file);
+	struct bdev_handle *bdev_handle = file->private_data;
+	blk_mode_t mode = bdev_handle->mode;
 
 	switch (cmd) {
 	/* These need separate implementations for the data structure */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6a942ec773b6..ae741dec184b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1481,6 +1481,7 @@ extern const struct blk_holder_ops fs_holder_ops;
 struct bdev_handle {
 	struct block_device *bdev;
 	void *holder;
+	blk_mode_t mode;
 };
 
 struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-- 
2.35.3

