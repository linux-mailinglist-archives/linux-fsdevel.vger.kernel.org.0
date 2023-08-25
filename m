Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E7788407
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 11:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHYJpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbjHYJpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:45:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B2519A1;
        Fri, 25 Aug 2023 02:45:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B662220702;
        Fri, 25 Aug 2023 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692956709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Cr89KhDwlq733Agokzc5feg+gVzfabZs0ngAJoV2B8=;
        b=tXkzGYYyF8dTgTRV2OcUxY7YPJ7B81fASutLRVNhjm9cJTw8kpcG9q40T2B6txCxP8xf2K
        juK97e7Ue67XtTSBThYzKG568fUbMP2m0zD5h5i9ZmNaYDR1eHHL/+kiP1jPMolQ8RxNWE
        Uk8hpNyIyLJ4qxlVkOrfe6IqRSn550w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692956709;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Cr89KhDwlq733Agokzc5feg+gVzfabZs0ngAJoV2B8=;
        b=UEhSIq587DqSEIZRLu//AsWUpyZ50P8/7uJ/uTxE7s6tBD3YlqHU6r6wX/InYL7Vu7vnu3
        KnvzX9ZylnAaUdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A916C138F9;
        Fri, 25 Aug 2023 09:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p6ZCKSV46GSfDAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 25 Aug 2023 09:45:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1E657A0774; Fri, 25 Aug 2023 11:45:09 +0200 (CEST)
Date:   Fri, 25 Aug 2023 11:45:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <20230825094509.yarnl4jpayqqjk4c@quack3>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-2-jack@suse.cz>
 <20230825022826.GC95084@ZenIV>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="g54c2gfun6pzxbtx"
Content-Disposition: inline
In-Reply-To: <20230825022826.GC95084@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--g54c2gfun6pzxbtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 25-08-23 03:28:26, Al Viro wrote:
> On Wed, Aug 23, 2023 at 12:48:13PM +0200, Jan Kara wrote:
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index 648670ddb164..54c1e2f71031 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -582,7 +582,8 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
> >  {
> >  	struct block_device *bdev = I_BDEV(file->f_mapping->host);
> >  	void __user *argp = (void __user *)arg;
> > -	blk_mode_t mode = file_to_blk_mode(file);
> > +	struct bdev_handle *bdev_handle = file->private_data;
> > +	blk_mode_t mode = bdev_handle->mode;
> >  	int ret;
> >  
> >  	switch (cmd) {
> 
> 	Still the same bug as in v2 - you are missing the effects of
> fcntl(2) setting/clearing O_NDELAY and sd_ioctl() is sensitive to that.

Argh, indeed you are correct. I forgot about fcntl(2) modifying
file->f_flags. Attached is a version of the patch that I'm currently
testing.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--g54c2gfun6pzxbtx
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-block-Use-bdev_open_by_dev-in-blkdev_open.patch"

From 46df2340545e872d34cf824e0d33b9b00b91e32f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 21 Jun 2023 13:16:32 +0200
Subject: [PATCH] block: Use bdev_open_by_dev() in blkdev_open()

Convert blkdev_open() to use bdev_open_by_dev(). To be able to propagate
handle from blkdev_open() to blkdev_release() we need to stop using
existence of file->private_data to determine exclusive block device
opens. Use bdev_handle->mode for this purpose since file->f_flags
isn't usable for this (O_EXCL is cleared from the flags during open).

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           |  3 +++
 block/fops.c           | 35 +++++++++++++++++++----------------
 include/linux/blkdev.h |  1 +
 3 files changed, 23 insertions(+), 16 deletions(-)

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
diff --git a/block/fops.c b/block/fops.c
index a286bf3325c5..5b0e6899c5ad 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -473,12 +473,19 @@ static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
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
@@ -496,7 +503,8 @@ blk_mode_t file_to_blk_mode(struct file *file)
 
 static int blkdev_open(struct inode *inode, struct file *filp)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
+	blk_mode_t mode;
 
 	/*
 	 * Preserve backwards compatibility and allow large file access
@@ -507,29 +515,24 @@ static int blkdev_open(struct inode *inode, struct file *filp)
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


--g54c2gfun6pzxbtx--
