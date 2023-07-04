Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7611B7470BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGDMWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGDMWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBCA10DF;
        Tue,  4 Jul 2023 05:22:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 400E020560;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2SY6QPlffcgh0gowR8pwasHGSIzw4KM07IczP55TjY=;
        b=fZY/LzrH4k+8ljbltTCepKMSLMb+MQ/RkR3eRNsG7RXyN+nlaHu73U6xthgAJsWC9V31UM
        A0V+Sjb+jDPYKtDlMHSzbV9TQj1HTSND/CRhOfjHxQKpjpex/lZMFZ7c3vitB0bpfAazAl
        8YqT5rcR8V1kNQadprRbNfE8nNhsS9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2SY6QPlffcgh0gowR8pwasHGSIzw4KM07IczP55TjY=;
        b=8apgjGDLt65Wcs5TxRS/zRhPypSV5IYDvD/cVUa1ESM+S0dyxJlZl0hAB1j+vlAhDleDxT
        zHGj1wYYz7BG5mAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31459139ED;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wFvYCwEPpGQHMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A1231A0765; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/32] block: Use blkdev_get_handle_by_dev() in blkdev_open()
Date:   Tue,  4 Jul 2023 14:21:30 +0200
Message-Id: <20230704122224.16257-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=jack@suse.cz; h=from:subject; bh=ebMKNPq4wUto3kT8lFICPlCgPSRttVUzmloHjoqOnEY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7NHkiJiQTbEwwrtS9UJmE1ox2msxQtLvmK2F/c L/jKUSSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQOzQAKCRCcnaoHP2RA2femB/ 0c8zUIFvG+sSDkdoZjHNxF7aUkPk5GxlmsCaraIgFgWoAets3EFNiCGdKQAkjm9y9wT6XmIZfPd1FW b9QNgFheDcaHfHtOtLdBy84EkXbkiCZ1NJHeSjfUlL6+sOPynMUm62QvFXcJIgCusfPW72mP67H+/b DQPp753sp25D7RBY0BTmJ7pvzWJ9ZOMsDLdNX4lM0384ta5bto46YKfqIvl3BTTGE7k76QEyO2LvWU X7UOb9IvKgckj2SNEct/il3kT8GLBeCsH1+xleUD2wqI2NHCalAzfyBS3Rh5ooVptHLqly20dzGRDA fofjFEqydvsxwltJtv2/Sj+YO8io8S
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert blkdev_open() to use blkdev_get_handle_by_dev().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/fops.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b6aa470c09ae..d7f3b6e67a2f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -496,7 +496,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
 
 static int blkdev_open(struct inode *inode, struct file *filp)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 	blk_mode_t mode;
 
 	/*
@@ -509,24 +509,25 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	filp->f_mode |= FMODE_BUF_RASYNC;
 
 	mode = file_to_blk_mode(filp);
-	bdev = blkdev_get_by_dev(inode->i_rdev, mode,
-				 mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	handle = blkdev_get_handle_by_dev(inode->i_rdev, mode,
+			mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
 	if (mode & BLK_OPEN_EXCL)
 		filp->private_data = filp;
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
+	blkdev_handle_put(filp->private_data);
 	return 0;
 }
 
-- 
2.35.3

