Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C0F7855F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjHWKth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjHWKt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:49:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1515F170F;
        Wed, 23 Aug 2023 03:49:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E9802074D;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XYZxNtC34lGlFe63Wtqi33jz6UUKNdpkCuGR1HdOSg=;
        b=rptHEC41T1HzGkwT1SV7EpKj9ADx+TLvWQSjiqd+I7ozCX+T5FUJIsUnBAIeGBK2KtWo1s
        EMeg1tAibSPr4bjRZldr3N4q+UrUeTdIV4+qglJWUIAGKUP/LnYp81nQAEZ07PzGfzx3mP
        KMzEsX9/W3R75rNjnYhOFRApeE8yxfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XYZxNtC34lGlFe63Wtqi33jz6UUKNdpkCuGR1HdOSg=;
        b=Re8DPWW9K21Terbhtc25uWEZg4lDhCG2Yhl7JeQEQcsMaQT8Fvk89mzDcFPekTdz4kLp8H
        fKnNB9TbK64vQuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CBFB139D0;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LnZsHhrk5WRGIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4A78AA078B; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/29] md: Convert to bdev_open_by_dev()
Date:   Wed, 23 Aug 2023 12:48:22 +0200
Message-Id: <20230823104857.11437-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=jack@suse.cz; h=from:subject; bh=cVz0uZ7R2L7regG23VnRBgqqO1W752jyfIvUc4wfwLw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP3q2wj4+gcehRhCiRJhgps6JS8hcXKSnbx6+ok lT2H1GuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj9wAKCRCcnaoHP2RA2UMmCA DTsoJIbQr5374tZ9q2geg9tB7cZUc9Yn8NNFxwSs1U3z0IAybntVaOVJCtdvMuQtPhJsEPv+cMVu7T hZoPFNYbbMuqUGtpq2L73O6WHYVsjtflC5NoBXmMDXobw0qSFGUJCJGYjFonYmAHmeoPLmHC9J+uNf Tl1mjwdWNzRZ4nkD2YdeKD8HXQHYYGhaCWvznWxSGy5zfNSLVuFt7zvhTsO8zo5i0hlP3PF4zM61uW 80nYjPM+c+ZlYwGLbcC3hJ1HqiSR1QStvX1lj4t63C4PKWcXZxPx6NhYRCBbaJ1G86+DcchQLBW3Nj ufHLn+How651VatlBTawJcbXI4dESQ
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
Acked-by: Song Liu <song@kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
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

