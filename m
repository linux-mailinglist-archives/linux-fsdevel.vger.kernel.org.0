Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAA27470BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGDMWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGDMWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC910E4;
        Tue,  4 Jul 2023 05:22:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C7B022866;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/9tNwICvUuoTLkA/Gy/9VS1sV+XMpAvoque5APHO+Y=;
        b=hIvXKyHLGq6INpq/5ZMcv1D8Go7SKKHbVm9SfbLZHD7E5lLf6RRKJSA6PiZUZA6xXo5pRk
        yjZ6P2CXMd0gPQ/kslbbPX5vRbX7bI/+v1O62x3UCQ0f2S1hhVrpbCmYasCbTbJkx943Pj
        6xKFsURWFEdrTynKCTY+QJhqw1Jq+QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/9tNwICvUuoTLkA/Gy/9VS1sV+XMpAvoque5APHO+Y=;
        b=6EqbD6Z4X0yzKMBmMUuaoRqAyFEwmgpyS6su6syRsBMdNf6YnzxtPX+Qmh22k+p4/YIVc7
        GlGT/YB0Yo/hPhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BB4013A90;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xSONDgEPpGQPMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9C1D2A0764; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 02/32] block: Use file->f_flags for determining exclusive opens in file_to_blk_mode()
Date:   Tue,  4 Jul 2023 14:21:29 +0200
Message-Id: <20230704122224.16257-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=jack@suse.cz; h=from:subject; bh=PTBdwG8gfONrGSEGa9q/ZP/2NSFGyJEWjshLi4HwM8M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7MZiGCgbc9cMHyz7m328ACV4/6aSDyLe/6pWD6 8KPnwoiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQOzAAKCRCcnaoHP2RA2WRVB/ wLMkALrjdQvw8JJ1YAIkFbjrSf7wmZ1fGYCYGg/i/x3LV8xPntNWlBqLbselAg2rRiIeA8HEKEL3y8 R8GLzy4LHb1a59QE7GHtoVL89o9azj2ZvFo9B5I973lqbPJSq6Hdz9ThhvQUaagClKEut/R5IS82oJ pG6JtIbE3bB/r2fbgT5v0LBAJW1ngMmwUKTkB/mIx7KQaM6PMxhGVuNydOnDrHh/xR7yzIqxBlQGjH RZsmxP62TR8VwiEnfpP+spmhZgUFjDBGCABEl4Ie/Iodt5gNJXQLjFiO3WiEgdza6vp0soCyEAab9M zJtR5ybhQRE6gT8krJiE9Bv4mlbbrJ
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

Use file->f_flags instead of file->private_data for determining whether
we should set BLK_OPEN_EXCL flag. This allows us to remove somewhat
awkward setting of file->private_data before calling file_to_blk_mode()
and it also makes following conversion to blkdev_get_handle_by_dev()
simpler.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/fops.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index a286bf3325c5..b6aa470c09ae 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -478,7 +478,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
 		mode |= BLK_OPEN_READ;
 	if (file->f_mode & FMODE_WRITE)
 		mode |= BLK_OPEN_WRITE;
-	if (file->private_data)
+	if (file->f_flags & O_EXCL)
 		mode |= BLK_OPEN_EXCL;
 	if (file->f_flags & O_NDELAY)
 		mode |= BLK_OPEN_NDELAY;
@@ -497,6 +497,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
 static int blkdev_open(struct inode *inode, struct file *filp)
 {
 	struct block_device *bdev;
+	blk_mode_t mode;
 
 	/*
 	 * Preserve backwards compatibility and allow large file access
@@ -507,18 +508,14 @@ static int blkdev_open(struct inode *inode, struct file *filp)
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
+	mode = file_to_blk_mode(filp);
+	bdev = blkdev_get_by_dev(inode->i_rdev, mode,
+				 mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
+	if (mode & BLK_OPEN_EXCL)
+		filp->private_data = filp;
 	if (bdev_nowait(bdev))
 		filp->f_mode |= FMODE_NOWAIT;
 
-- 
2.35.3

