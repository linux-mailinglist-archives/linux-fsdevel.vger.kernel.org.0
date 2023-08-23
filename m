Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52B78560C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjHWKuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjHWKtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:49:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C5CE52;
        Wed, 23 Aug 2023 03:49:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C902821F36;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcC0EL83glpqFDbzEQiEGRuj9oVraZEI6ONYuisPs8Y=;
        b=e7kPjcIb2jq2PqWjDqjZOYYBCYF1dJimouMNs4d4TrEftoNvnktZpQQhkfWNyI+myITXMn
        gLSp0FEDTyvKj3jE9W8UWPmyNmXnpL9/NVk091eKFoUFHVVpAM9r92PdYlakBe9cuxIn1C
        bwKp/Hur44WT/x5Rcq91FuDxgo8TUCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcC0EL83glpqFDbzEQiEGRuj9oVraZEI6ONYuisPs8Y=;
        b=F8t6q+PfCPRDnMUw79KtGajRcpQ4k1AfKKQ0KKZhHcnD+FQJC+pXRBV2+TEL/tzeH+0Tfn
        8qyqOHI2ez/Nh6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B477D13458;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y74PLBrk5WRPIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66AE3A0790; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 16/29] PM: hibernate: Convert to bdev_open_by_dev()
Date:   Wed, 23 Aug 2023 12:48:27 +0200
Message-Id: <20230823104857.11437-16-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=jack@suse.cz; h=from:subject; bh=CzYvUjHnfNvOx34IJDbRr1CNtryVES47+KFHB6AptJM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP8uJPZLTGrb/Kiwa7ycp+lBfDl3q71CJew7Ii2 NGr+FXSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj/AAKCRCcnaoHP2RA2clwB/ 9wP7WpBmSPuKu5demzFKsnepaPP6zn7KtCx6KErckwHAZif0E6q9v7bHFV487nvyl4+o0SH9IiJgEr PvATPANO/4r0EAZVzrIN0zC9HppkMbb+AJAk1QA1KWZidXwzjmRlIidSQ8rsdmB9jr5F5UvSCEhXUt 10EI2RD98jxv8j/zEPEdwjkDHYkp50oyhv+LE8XUdwmzMn89OFSV+G3umIMu0tSahWIdYy5auhNmAG QHshXwh0cc5hgOVNwFijtP0JPRnkt458byiUuOeQuf9ZQ7U7lJaYjISbK5yVdwU4IEsSHbaP/IjAhv YUGr9t8QHwl530MKxhT8nWtf/Wmg2m
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

Convert hibernation code to use bdev_open_by_dev().

CC: linux-pm@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/power/swap.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f6ebcd00c410..b475bee282ff 100644
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
+	hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
 			BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(hib_resume_bdev))
-		return PTR_ERR(hib_resume_bdev);
+	if (IS_ERR(hib_resume_bdev_handle))
+		return PTR_ERR(hib_resume_bdev_handle);
 
-	res = set_blocksize(hib_resume_bdev, PAGE_SIZE);
+	res = set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
 	if (res < 0)
-		blkdev_put(hib_resume_bdev, NULL);
+		bdev_release(hib_resume_bdev_handle);
 
 	return res;
 }
@@ -1521,10 +1522,10 @@ int swsusp_check(bool snapshot_test)
 	void *holder = snapshot_test ? &swsusp_holder : NULL;
 	int error;
 
-	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, BLK_OPEN_READ,
-					    holder, NULL);
-	if (!IS_ERR(hib_resume_bdev)) {
-		set_blocksize(hib_resume_bdev, PAGE_SIZE);
+	hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
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
+			bdev_release(hib_resume_bdev_handle);
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
+	bdev_release(hib_resume_bdev_handle);
 }
 
 /**
-- 
2.35.3

