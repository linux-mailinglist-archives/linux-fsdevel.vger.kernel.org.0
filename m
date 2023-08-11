Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8040778CE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjHKLFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjHKLFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF7E10C9;
        Fri, 11 Aug 2023 04:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D62621880;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxcAzzD+Uyye6qjjVVcqoAgSgsS8B+BvpQl4uroL/p4=;
        b=UfLc/kvaQVRluoWTmPGAQrSqxXK8dQnKKaN1pkarO69aTnznWAZsqMwuoauiVv31nLrMtX
        wF8rV+yetP+zQuaGhOpDx6rYvlHkRzJZldFd4RKw/Y/RoB92UDRCYE1WewkQzsYZjkI3xr
        uXmSid0sxidMQKO9Q/Nz18nSYtlIg6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxcAzzD+Uyye6qjjVVcqoAgSgsS8B+BvpQl4uroL/p4=;
        b=XU2xPpP6S2ppAm6IQSk6w5oc41GYALuZTxpzlRlafMYomHz5nlFXFJCQ0tz29zy0BysmNA
        N0xSyS8/7SJEjTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22452138E3;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JPpRCOIV1mRcRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1FA5CA078F; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH 16/29] PM: hibernate: Convert to bdev_open_by_dev()
Date:   Fri, 11 Aug 2023 13:04:47 +0200
Message-Id: <20230811110504.27514-16-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3086; i=jack@suse.cz; h=from:subject; bh=gHRpjpEOsJl1nkmTzeoLxPEEw/WCLHXfkHcdzoKJwjw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXQ4OczpzJX8G4+68Yl6+VrCj6JyNam5hshjuFc a9M++HCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV0AAKCRCcnaoHP2RA2YjZB/ 0fUUUmmAgt3XVjXh8Cy0RuahYZ18A/bH531q2MqfRMz7ANRKFT2d1eNapi0/DnQLi54DhT8O6as0ly JV0r2+GizKfh2gUBQ6oMJg5Di2H1Y8Vf5KZmMKp/ic1XQTgmZoJpWqWgX/TbzfB6uhO+VIzFYbwq// 2AEPM6hZ/7efSqdUgWCvE58bZ0o7PO9+gC4PQfWtItqIjGBiHRSbfzTES+inXRoXur4djMwigd4iEd 1mQyR6geMQ8X1OhHbg4RmaoHO/uo2LM4ZXfqHJmMHS1cYj4s0vTxlUZxLGgeLfPHWa3kjaWbj+6YBz sgmliYID/ZuLdnSkTNmw0kZnzcy6XI
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert hibernation code to use bdev_open_by_dev().

CC: linux-pm@vger.kernel.org
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

