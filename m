Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9B7B0035
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjI0Jeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjI0Jer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B17A194;
        Wed, 27 Sep 2023 02:34:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A935A2195F;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6vdFMu54hcy8kVfOzk2s3fK2p7wmNvWqgyO2kKPKgk=;
        b=S69tpaJ8kO4e2+MLb8oh/lzG1p4misWVs/xjUnc2Vx0axsFfAiRud1XQqQAFiW3d1B420x
        fyRQJbAZPNn9FnnuUEQis0F3TqRa7fwZoY+0+C8otGoyFIIfy0CkRusrkNrDFOW52s1JfG
        gZgIEPwAv2qcmUDE7w64+gCopMec//s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6vdFMu54hcy8kVfOzk2s3fK2p7wmNvWqgyO2kKPKgk=;
        b=+cgTChSNYRxlzcQvo5QVxrkC6uQiadE2hGV9fDg/JymBp2Z40OALi6JhSUaTt0pWDyGqz+
        mMlp7b+N8dfvpCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 960CB13A74;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZvGeJDT3E2UlEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5CD8DA07E6; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 16/29] PM: hibernate: Convert to bdev_open_by_dev()
Date:   Wed, 27 Sep 2023 11:34:22 +0200
Message-Id: <20230927093442.25915-16-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3203; i=jack@suse.cz; h=from:subject; bh=0BnssG6LUA6Teyfes5myOAc1zf8i56lDBWDFNSXFylo=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGFKFv8v/U1EUfjBDtoYnZHp78I3geTGLZq53zON9esrelv1H V6FxJ6MxCwMjB4OsmCLL6siL2tfmGXVtDdWQgRnEygQyhYGLUwAmct2f/a/wuoOfElTa9bfkl/7//P TipILXfiXxc52cal/M67IWENyWsXa3mNdjhV8WqSfk7Vw2KPWeFuW4+uV+pLbItdiwFOvarNCD5Zal a9yKHG5U5IdacJQJl/6/f/CoaVLJqUVXZT7PPGY0ZULlpoM1q3QmRC2tsL34nq10b1uQ39LZAkFFhV mpXfc+5jwsMdPVDe7U9v+XVn/Iju3t9u7ZIT61C00kWBYv8grwUj9b8X7rPsGKiTeXvHA9fGHvu9NZ sgITIiWlFStLahcW+epap/remhK//KtW8dMJq4/z+pVf0Sr5krM30beAt3a3hsOcT8/7qr84V12LY3 y2eZadDcta6cuavBWLpBPSeEMsAA==
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

Convert hibernation code to use bdev_open_by_dev().

CC: linux-pm@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/power/swap.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 74edbce2320b..095a263da7c4 100644
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
@@ -1522,10 +1523,10 @@ int swsusp_check(bool exclusive)
 	void *holder = exclusive ? &swsusp_holder : NULL;
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
@@ -1550,11 +1551,11 @@ int swsusp_check(bool exclusive)
 
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
@@ -1570,12 +1571,12 @@ int swsusp_check(bool exclusive)
 
 void swsusp_close(bool exclusive)
 {
-	if (IS_ERR(hib_resume_bdev)) {
+	if (IS_ERR(hib_resume_bdev_handle)) {
 		pr_debug("Image device not initialised\n");
 		return;
 	}
 
-	blkdev_put(hib_resume_bdev, exclusive ? &swsusp_holder : NULL);
+	bdev_release(hib_resume_bdev_handle);
 }
 
 /**
-- 
2.35.3

