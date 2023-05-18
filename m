Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610F97078EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjEREXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjEREXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CA35BC;
        Wed, 17 May 2023 21:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HIEuDOPmFIS+iShTM0mpdBmHQefNMWjqF+6tGPSU4L4=; b=a8i1yGb0OVZkD+P0aDTNQp2sOv
        0fQLUMmF/ItMJowNaqF5RZm+yq4rRb74V6HwdsbjWuVSvDQmismNt5gJCdyrfTqj13bEN6173u6Lg
        cnEYiLxhJGKN+n+IFQ7X9GnMLderqCYFQbjzXE4PdaNa3TcMXDZSQufQxD9gEQvHq76+wfrzxFDeN
        vC8LjHoOTvsVjiUFnDGj5V4P3s26MqankZ9SPVnUWs8byMDS8vT+mv2eHb+Arr+xQ1xc8d0dH/N7h
        9bclHQOQYct3XMe9NGOqJIikcmQfEP4MCvYEgYFX1PWLuvYY7xNR75TSq+fQosajRFduotirtStcH
        JMaSzOrw==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVAl-00BqNW-1O;
        Thu, 18 May 2023 04:23:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 01/13] block: factor out a bd_end_claim helper from blkdev_put
Date:   Thu, 18 May 2023 06:23:10 +0200
Message-Id: <20230518042323.663189-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518042323.663189-1-hch@lst.de>
References: <20230518042323.663189-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move all the logic to release an exclusive claim into a helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 63 +++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 21c63bfef3237a..317bfd9cba40fa 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -589,6 +589,37 @@ void bd_abort_claiming(struct block_device *bdev, void *holder)
 }
 EXPORT_SYMBOL(bd_abort_claiming);
 
+static void bd_end_claim(struct block_device *bdev)
+{
+	struct block_device *whole = bdev_whole(bdev);
+	bool unblock = false;
+
+	/*
+	 * Release a claim on the device.  The holder fields are protected with
+	 * bdev_lock.  open_mutex is used to synchronize disk_holder unlinking.
+	 */
+	spin_lock(&bdev_lock);
+	WARN_ON_ONCE(--bdev->bd_holders < 0);
+	WARN_ON_ONCE(--whole->bd_holders < 0);
+	if (!bdev->bd_holders) {
+		bdev->bd_holder = NULL;
+		if (bdev->bd_write_holder)
+			unblock = true;
+	}
+	if (!whole->bd_holders)
+		whole->bd_holder = NULL;
+	spin_unlock(&bdev_lock);
+
+	/*
+	 * If this was the last claim, remove holder link and unblock evpoll if
+	 * it was a write holder.
+	 */
+	if (unblock) {
+		disk_unblock_events(bdev->bd_disk);
+		bdev->bd_write_holder = false;
+	}
+}
+
 static void blkdev_flush_mapping(struct block_device *bdev)
 {
 	WARN_ON_ONCE(bdev->bd_holders);
@@ -843,36 +874,8 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	if (mode & FMODE_EXCL) {
-		struct block_device *whole = bdev_whole(bdev);
-		bool bdev_free;
-
-		/*
-		 * Release a claim on the device.  The holder fields
-		 * are protected with bdev_lock.  open_mutex is to
-		 * synchronize disk_holder unlinking.
-		 */
-		spin_lock(&bdev_lock);
-
-		WARN_ON_ONCE(--bdev->bd_holders < 0);
-		WARN_ON_ONCE(--whole->bd_holders < 0);
-
-		if ((bdev_free = !bdev->bd_holders))
-			bdev->bd_holder = NULL;
-		if (!whole->bd_holders)
-			whole->bd_holder = NULL;
-
-		spin_unlock(&bdev_lock);
-
-		/*
-		 * If this was the last claim, remove holder link and
-		 * unblock evpoll if it was a write holder.
-		 */
-		if (bdev_free && bdev->bd_write_holder) {
-			disk_unblock_events(disk);
-			bdev->bd_write_holder = false;
-		}
-	}
+	if (mode & FMODE_EXCL)
+		bd_end_claim(bdev);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
-- 
2.39.2

