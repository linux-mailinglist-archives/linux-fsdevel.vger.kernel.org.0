Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA8778CB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjHKLFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjHKLFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C7E62;
        Fri, 11 Aug 2023 04:05:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B68C1F74A;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P91/7PXjk8qpW2tGxnZDHj+FKwlkN7CdxtfxWkw2p3s=;
        b=B9YrhSDYDQgMoud8oGt82MprAnYXxtv3G1r0P7ahKD5LpkSW04VC7IdPiyxbRgS9qu094o
        rNmKQICk5XP1f0GGsmQwbc/nFnAeNwM/nXjMb8NJMMJKFOcC4AseAp94rIypFBG7xruTHh
        6iCFWUr/rngITbAP5ol5s5vF7mPHzVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P91/7PXjk8qpW2tGxnZDHj+FKwlkN7CdxtfxWkw2p3s=;
        b=wAHhhaJg9mHchHW7YfbKiwLm9RJJFfA1Vx2EfL5+R6X5JQ3Wz9//QIb5tpsX9KXCRdTSCn
        EXpqCCEbpmp5s3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E1D613592;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BTc/C+EV1mQqRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CB86BA0776; Fri, 11 Aug 2023 13:05:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/29] block: Use bdev_open_by_dev() in disk_scan_partitions() and blkdev_bszset()
Date:   Fri, 11 Aug 2023 13:04:34 +0200
Message-Id: <20230811110504.27514-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=jack@suse.cz; h=from:subject; bh=E2hZ00UmvBKVSG0oLPFrljvxVDoXMyLD+mAS4JFe+gI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXFSgY69SkAO62bEgSlAULPNJueUjvdnZ4Q92kZ J6Z85jWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYVxQAKCRCcnaoHP2RA2frTB/ 9Of3kCg4yXJSlRMdLNZkuJFF67YvB2jF4VJmVxb6BNcAyFVgdTNZZE2CPV4APm3AAFOo2oIjC+hMs/ 2j/b2v5kS+DUs9OuK12WS5BpFp8RXCfXEZMZQT62fYGCO6wY7nYiK4W25GNxp/SByxhTEePkme0EdX KaIe9LojhYmmk/gh5wZtwwBG0licnLoDzUTe/pF7ES1Y35eHa9AroJUDg7xWEp0lNw5bDRYxhDrdO8 2w7m2F/GkEvmW+IUncb3XFf2dtJExins6HaGSFTKZGQ5UU34Y+qi3weLRSeKnIjcYCiYT063wXu+ia skSJHh3tb1GGnA0GlDyUvTsUtfN8eO
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

Convert disk_scan_partitions() and blkdev_bszset() to use
bdev_open_by_dev().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 12 ++++++------
 block/ioctl.c |  6 ++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 3d287b32d50d..ebb9cd3ec8c2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 	int ret = 0;
 
 	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
@@ -366,12 +366,12 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
-				 NULL);
-	if (IS_ERR(bdev))
-		ret =  PTR_ERR(bdev);
+	handle = bdev_open_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
+				  NULL);
+	if (IS_ERR(handle))
+		ret = PTR_ERR(handle);
 	else
-		blkdev_put(bdev, NULL);
+		bdev_release(handle);
 
 	/*
 	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
diff --git a/block/ioctl.c b/block/ioctl.c
index 47f216d8697f..e53a23007073 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -458,6 +458,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 		int __user *argp)
 {
 	int ret, n;
+	struct bdev_handle *handle;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -469,10 +470,11 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
-	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode, &bdev, NULL)))
+	handle = bdev_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
+	if (IS_ERR(handle))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	blkdev_put(bdev, &bdev);
+	bdev_release(handle);
 
 	return ret;
 }
-- 
2.35.3

