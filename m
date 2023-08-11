Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89280778CE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjHKLFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbjHKLFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06162E65;
        Fri, 11 Aug 2023 04:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0CAA1F894;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sq/65j+CY9i3t8hL9bwXc39jHO7aQnHuaT66ofTFDw=;
        b=1l25YOx6rv1s9C4rI0idkwKYVX2TInbGaE93NvGTkM6IGlqrAryuj7jdLsWE1dFt3W7FXK
        VRkIM8aV3chI0DoxCMXjzKGVrzLViHa6tpQe0eFWv2gQkm/G6gb+JJg1hFFnvXcUN6Mg8R
        0fRbMAr9j8S7T5CeZNd8KbgiRH8HIYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sq/65j+CY9i3t8hL9bwXc39jHO7aQnHuaT66ofTFDw=;
        b=2/GRkkpP3FwV4zjlG58lb/M/n1gWj2Vk86fjJLulfRdqNWWIXfnsC1exIDihwIcDI9F9DQ
        ol83lAvNFovsk0CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0D6F138E3;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SFsQL+EV1mRNRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 036D1A0789; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>
Subject: [PATCH 11/29] md: Convert to bdev_open_by_dev()
Date:   Fri, 11 Aug 2023 13:04:42 +0200
Message-Id: <20230811110504.27514-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=jack@suse.cz; h=from:subject; bh=B0+iSj9jsLp41usXiwKwpFGHgEtk6xuIxKa3VQkGjLo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXMG0hnHADMBdqV1Vbg/Q26yvvdN7RwrInxb4di dKrx4y+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYVzAAKCRCcnaoHP2RA2TgICA CWls3FPaqpXOzqMN4ezha85vqO0oTO5QKnXy+co7t//8/85YDV3bKzgwZrEP1e5kunrWyHC5lpb/mp Gk7/0ldBWyNjLsYO3kwzu4sK+NZdCowreYfPonRvYSplDNuPpwaDEG5jGU9iLhfy5tKtgoiJLUtxjx OPtr+a8dL8+2HuEEnSl1c6xZt/yooDkK5OddGPgzsf9ux/ptaPPnpWQgpGtzltlS0sh66WootqQ04a yZbTbtN7nMkDh0oTFCTtr3tqPnxhqPf8QNyJQRk38zb0TBcHqdQW7GePPpgXXMIQZu3jvk2M9nILXL xnPM+L0fxWk61luymUc6iUrgfcIUv9
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

Convert md to use bdev_open_by_dev() and pass the handle around.

CC: linux-raid@vger.kernel.org
CC: Song Liu <song@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/md/md.c | 12 +++++++-----
 drivers/md/md.h |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 78be7811a89f..20d6cefda3e8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2450,7 +2450,7 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	blkdev_put(rdev->bdev, mddev->external ? &claim_rdev : rdev);
+	bdev_release(rdev->bdev_handle);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3644,14 +3644,16 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
-	rdev->bdev = blkdev_get_by_dev(newdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+	rdev->bdev_handle = bdev_open_by_dev(newdev,
+			BLK_OPEN_READ | BLK_OPEN_WRITE,
 			super_format == -2 ? &claim_rdev : rdev, NULL);
-	if (IS_ERR(rdev->bdev)) {
+	if (IS_ERR(rdev->bdev_handle)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
-		err = PTR_ERR(rdev->bdev);
+		err = PTR_ERR(rdev->bdev_handle);
 		goto out_clear_rdev;
 	}
+	rdev->bdev = rdev->bdev_handle->bdev;
 
 	kobject_init(&rdev->kobj, &rdev_ktype);
 
@@ -3682,7 +3684,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	blkdev_put(rdev->bdev, super_format == -2 ? &claim_rdev : rdev);
+	bdev_release(rdev->bdev_handle);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1aef86bf3fc3..e8108845157b 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -59,6 +59,7 @@ struct md_rdev {
 	 */
 	struct block_device *meta_bdev;
 	struct block_device *bdev;	/* block device handle */
+	struct bdev_handle *bdev_handle;	/* Handle from open for bdev */
 
 	struct page	*sb_page, *bb_page;
 	int		sb_loaded;
-- 
2.35.3

