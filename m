Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE75F7470C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjGDMWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGDMWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FD510C1;
        Tue,  4 Jul 2023 05:22:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D4C9620563;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4ZZpynsMXSzcX6pYVrB5JPrTQ8oOCKP2EsdhUI35MU=;
        b=ffixtoaNAa5sui4tgGULLSCCz3CxlbmMyh8pqSFXXF626BZqKOj0d7wU4LbZ16d0w/YSZw
        wmBq/CjqSjBsKDNSkdLiDm4F1FEEZXvnl7/Io+mNjL2p8ZneAeYCLfypZzlPkrVpCbVlaB
        EayIyJpL+s/T/WfrHtKjizYfiPZ9ZWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4ZZpynsMXSzcX6pYVrB5JPrTQ8oOCKP2EsdhUI35MU=;
        b=CyWUVZnrrRqDZZBYx87VgrbOiv6iAcStuR9VLruMUVgZKQ0dpE1/fm4MfmxHy/ZuMz6/ro
        Y/s4hHYYMMDAHUCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3BF113A90;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7uPGLwEPpGQlMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D6F2FA076F; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>
Subject: [PATCH 12/32] md: Convert to blkdev_get_handle_by_dev()
Date:   Tue,  4 Jul 2023 14:21:39 +0200
Message-Id: <20230704122224.16257-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=jack@suse.cz; h=from:subject; bh=k7EUTlcj0/xAfmBVYDqN6uh8tD9JtPWYDpj301l/NNU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7VQerrWBOzeanCEtAI2rYQbvus/Kjwg+hh2BW/ 0nunTi+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO1QAKCRCcnaoHP2RA2XBVB/ 9H30pBnUTePA7IbKOMTN/nstgWX75nmhACMXoOvCq1GaCG4y1x5L54y9PkKeKMWXG993bOK+G6kcMG ym4BaQa9mdJJ7WZB2w5ux7nRdiDFQMrJjFS8mVPNEZ0WU+rUjigLtvhWrcREYrW/be8yQXkprxX22/ IkTZI0DmM34Ctmq0dN4W4uTUDH+u1dnSO6p6xV475j1Bjpx4w+yDWHyp7+uOdiTGtn7bLjtgz0r8kU YtJYwQGuDmz+P5p7Dnlxx+VW2fVZCscud39MQzRQlmEZ3l4zWd3HsKluoZ8fNcboeMw7aqxehMz+Vl MnBmFebIZkE67h8wSsrAitXDAZGL0m
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

Convert md to use blkdev_get_handle_by_dev() and pass the handle around.

CC: linux-raid@vger.kernel.org
CC: Song Liu <song@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/md/md.c | 12 +++++++-----
 drivers/md/md.h |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index cf3733c90c47..bed142ee6f1f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2458,7 +2458,7 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	blkdev_put(rdev->bdev, mddev->major_version == -2 ? &claim_rdev : rdev);
+	blkdev_handle_put(rdev->bdev_handle);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3654,14 +3654,16 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
-	rdev->bdev = blkdev_get_by_dev(newdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+	rdev->bdev_handle = blkdev_get_handle_by_dev(newdev,
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
 
@@ -3692,7 +3694,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	blkdev_put(rdev->bdev, super_format == -2 ? &claim_rdev : rdev);
+	blkdev_handle_put(rdev->bdev_handle);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
diff --git a/drivers/md/md.h b/drivers/md/md.h
index bfd2306bc750..04d71ea2d98f 100644
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

