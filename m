Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65F747101
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjGDMXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGDMWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBDC10D8;
        Tue,  4 Jul 2023 05:22:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5883020568;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQxTCSeTg6wagW5tuWFhLvswNFlZbpUek4rOSe5trrE=;
        b=C7Ch1FdLD4xgCfVB82D/Pjj8dtKMxh2T0JXylFKzB7VijdCP9rpjJrwz1AoVaD3iTx2QTN
        d10QCWFioSaQfHm1DL44YuQ7qp46/w3yrbyLlpn95xxy7sG/hiLoMpqjvGZ9355JyxLNMK
        OrX5bDJEbEEWi4cdlXq+F1qHlc2gA/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQxTCSeTg6wagW5tuWFhLvswNFlZbpUek4rOSe5trrE=;
        b=kkwyLW8Z43c1K3AUAfFJBhL2dW39UMnhvBzHTBPV1OYVyCcCfUGLw1zKNRTIKqSwHRKWm2
        7wo1ScOPy0m6S1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 489AB1346D;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Msu2EQIPpGRBMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0059AA0776; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH 17/32] PM: hibernate: Convert to blkdev_get_handle_by_dev()
Date:   Tue,  4 Jul 2023 14:21:44 +0200
Message-Id: <20230704122224.16257-17-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125; i=jack@suse.cz; h=from:subject; bh=ou4xyOI12JhBNyr0TQRO/mOTZ4/nsdMmvIuW5W7Bk/4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7Zj/XDAC5VAg2XWqfvTw6JJlt/lNEIu3iYQkMa cX4ejhmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO2QAKCRCcnaoHP2RA2TYyB/ 9r0zspSMI9y3P9YTw8G+43irxTgZcyCBFkjnJxTVtd712SFi233iJyFwVmklUzIySemrw8UNhG/Csp YJAtfj2WX5ErVJN2HgmmBPJaT+PDmusZ+AHUScM2YLKbooi4xmpDFjIkKBOH/S12tr+tFr7z1A+lPG lpnjVCJ8VxnknewcLN/xaxiHVhjK2QbRnKVKGf14vSb7PPRVRvXC7Nnkogx0gZlD/Uqea/xe3cdSEb 3gWvYzkN/s3bnQ3QJy2wAmxGq/TPLgzlJ1et54mH4ZVBA9+J5b3wcDpxLHQMYVC95POBojgC2JGe/9 zUUDuYZiJYz+VDviRPyoP9NXITfc6D
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

Convert hibernation code to use blkdev_get_handle_by_dev().

CC: linux-pm@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/power/swap.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f6ebcd00c410..fd90ecf15ee1 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -222,7 +222,7 @@ int swsusp_swap_in_use(void)
  */
 
 static unsigned short root_swap = 0xffff;
-static struct block_device *hib_resume_bdev;
+static struct bdev_handle *hib_resume_bdev_handle;
 
 struct hib_bio_batch {
 	atomic_t		count;
@@ -276,7 +276,8 @@ static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
 	struct bio *bio;
 	int error = 0;
 
-	bio = bio_alloc(hib_resume_bdev, 1, opf, GFP_NOIO | __GFP_HIGH);
+	bio = bio_alloc(hib_resume_bdev_handle->bdev, 1, opf,
+			GFP_NOIO | __GFP_HIGH);
 	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
@@ -356,14 +357,14 @@ static int swsusp_swap_check(void)
 		return res;
 	root_swap = res;
 
-	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
+	hib_resume_bdev_handle = blkdev_get_handle_by_dev(swsusp_resume_device,
 			BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(hib_resume_bdev))
-		return PTR_ERR(hib_resume_bdev);
+	if (IS_ERR(hib_resume_bdev_handle))
+		return PTR_ERR(hib_resume_bdev_handle);
 
-	res = set_blocksize(hib_resume_bdev, PAGE_SIZE);
+	res = set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
 	if (res < 0)
-		blkdev_put(hib_resume_bdev, NULL);
+		blkdev_handle_put(hib_resume_bdev_handle);
 
 	return res;
 }
@@ -1521,10 +1522,10 @@ int swsusp_check(bool snapshot_test)
 	void *holder = snapshot_test ? &swsusp_holder : NULL;
 	int error;
 
-	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, BLK_OPEN_READ,
-					    holder, NULL);
-	if (!IS_ERR(hib_resume_bdev)) {
-		set_blocksize(hib_resume_bdev, PAGE_SIZE);
+	hib_resume_bdev_handle = blkdev_get_handle_by_dev(swsusp_resume_device,
+				BLK_OPEN_READ, holder, NULL);
+	if (!IS_ERR(hib_resume_bdev_handle)) {
+		set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
 		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
 					swsusp_header, NULL);
@@ -1549,11 +1550,11 @@ int swsusp_check(bool snapshot_test)
 
 put:
 		if (error)
-			blkdev_put(hib_resume_bdev, holder);
+			blkdev_handle_put(hib_resume_bdev_handle);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
-		error = PTR_ERR(hib_resume_bdev);
+		error = PTR_ERR(hib_resume_bdev_handle);
 	}
 
 	if (error)
@@ -1568,12 +1569,12 @@ int swsusp_check(bool snapshot_test)
 
 void swsusp_close(bool snapshot_test)
 {
-	if (IS_ERR(hib_resume_bdev)) {
+	if (IS_ERR(hib_resume_bdev_handle)) {
 		pr_debug("Image device not initialised\n");
 		return;
 	}
 
-	blkdev_put(hib_resume_bdev, snapshot_test ? &swsusp_holder : NULL);
+	blkdev_handle_put(hib_resume_bdev_handle);
 }
 
 /**
-- 
2.35.3

