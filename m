Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E179A7B0076
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjI0JfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjI0Jev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F9A194;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 508FD1FD66;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4dB9ig4ggBCrP5xrdUKqzYP3gsOmFjqW6i32KzYP6A=;
        b=snoqKmlXC5YY8armbezrKIMHCNT8GpIjZ6rqyxymDgItE1Lb4PhyPPBD1E5heYU492k5ac
        +8k/zy+r3NhBf4gKmgCPccQAn/siG1oKYOpMkZh/3JjgJXBPZuRJm7zJi+VG5AMRzSWHB9
        29CJAqCO0E8PsN4tkUM5S/HclO8QcYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4dB9ig4ggBCrP5xrdUKqzYP3gsOmFjqW6i32KzYP6A=;
        b=8LyGifM76qH9SvqQ/7lx7SbKWlFMSFJ6KZT/hmLtcpsejcGg/lFfcGs97uXWLeB7rLR20S
        TiIVpOJGJqlAMjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E9C31338F;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cbxaDzT3E2UcEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 353DBA07DC; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/29] md: Convert to bdev_open_by_dev()
Date:   Wed, 27 Sep 2023 11:34:17 +0200
Message-Id: <20230927093442.25915-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2852; i=jack@suse.cz; h=from:subject; bh=iHmk7lxm2ajjhyf9s9kxjTX+VLWmyIDLO+LUGycrl+0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/catFvJOspSxxf9Vw/R71KwGi9Qg0LUG5wAlHnV gh0DaOqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3GgAKCRCcnaoHP2RA2TgUCA DFdiUWH8QHDhVg4ddp7fnDRFO2ToOULu3fT5If84ClTM6JkL9mEL6p7MaUVZ4FHjfGMahRCy/+TUKd iRBRM2m/wJgB/pXsStOKUCGAXJlS24aenxj61fFIfq86fnYLJT+EI5ML9MLAocGMdxe8PH9ar1l6/8 mMtuRZG7e7uD5iKrfzNXvtItTT++GTzHbTwn1wvQ+A9cpLZ4xJt/bsfVhwjMFHPhAymrdzQYn6+Yoa Xu/AEo3K/RxbYCKOwzEzSkBgQH+vkvmk+hRMItaZ4dul6zAuBaKIAic3JDFcjgsA4t60BYheL2rHMF vTztPXvejVXM58JAr1GVIZ1xcmGdLg
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

Convert md to use bdev_open_by_dev() and pass the handle around. We also
don't need the 'Holder' flag anymore so remove it.

CC: linux-raid@vger.kernel.org
CC: Song Liu <song@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/md/md.c | 22 ++++++++--------------
 drivers/md/md.h |  4 +---
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a104a025084d..5ed8cad3f4fa 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2452,8 +2452,7 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	blkdev_put(rdev->bdev,
-		   test_bit(Holder, &rdev->flags) ? rdev : &claim_rdev);
+	bdev_release(rdev->bdev_handle);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3648,21 +3647,16 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
-	if (super_format == -2) {
-		holder = &claim_rdev;
-	} else {
-		holder = rdev;
-		set_bit(Holder, &rdev->flags);
-	}
-
-	rdev->bdev = blkdev_get_by_dev(newdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				       holder, NULL);
-	if (IS_ERR(rdev->bdev)) {
+	rdev->bdev_handle = bdev_open_by_dev(newdev,
+			BLK_OPEN_READ | BLK_OPEN_WRITE,
+			super_format == -2 ? &claim_rdev : rdev, NULL);
+	if (IS_ERR(rdev->bdev_handle)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
-		err = PTR_ERR(rdev->bdev);
+		err = PTR_ERR(rdev->bdev_handle);
 		goto out_clear_rdev;
 	}
+	rdev->bdev = rdev->bdev_handle->bdev;
 
 	kobject_init(&rdev->kobj, &rdev_ktype);
 
@@ -3693,7 +3687,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	blkdev_put(rdev->bdev, holder);
+	bdev_release(rdev->bdev_handle);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 7c9c13abd7ca..274e7d61d19f 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -59,6 +59,7 @@ struct md_rdev {
 	 */
 	struct block_device *meta_bdev;
 	struct block_device *bdev;	/* block device handle */
+	struct bdev_handle *bdev_handle;	/* Handle from open for bdev */
 
 	struct page	*sb_page, *bb_page;
 	int		sb_loaded;
@@ -211,9 +212,6 @@ enum flag_bits {
 				 * check if there is collision between raid1
 				 * serial bios.
 				 */
-	Holder,			/* rdev is used as holder while opening
-				 * underlying disk exclusively.
-				 */
 };
 
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
-- 
2.35.3

