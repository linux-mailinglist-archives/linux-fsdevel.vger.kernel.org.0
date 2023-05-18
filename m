Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353367078F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjEREXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjEREXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD4115;
        Wed, 17 May 2023 21:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Gz4yC3Stvw1RiajpLPjxfqT9qrTt5nqXEtmmWJNVot4=; b=MLgX4K1AqQKeK7TZ4COPSW6Ujt
        fY/9fO898DKOBVykm1UGxo/9r+hdTTCdKTKsJ//Bprx8iNG3kGjNZZFBfq1NIJJg7FgQGQz1IRuK1
        xAJfg2f1s/ZYkf3ZW25iaQrgI92F9TtboESuzNrnzt8Y0Alob+sUQ8NTeDyxG5eRumN8GI68PcCDQ
        6JmemAExml/C39zKJ91sfiwo2NmTX0Xxnvkc7+GrvnXe12Hb3Zqp9BhZS8ki76XZkX++53y4ilGsW
        GiHLpZYiZ5J0EWUQWZlJIqbcrZyLi4vFuHTJStJ3ofjQzEfim3lAfbxNyGwbluJ1Bekmx0jJJ3Y53
        Ivf9rvLA==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVAn-00BqNh-2v;
        Thu, 18 May 2023 04:23:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 02/13] block: refactor bd_may_claim
Date:   Thu, 18 May 2023 06:23:11 +0200
Message-Id: <20230518042323.663189-3-hch@lst.de>
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

The long if/else chain obsfucates the actual logic.  Tidy it up to be
more structured.  Also drop the whole argument, as it can be trivially
derived from bdev using bdev_whole, and having the bdev_whole in the
function makes it easier to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 317bfd9cba40fa..080b5c83bfbc72 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -463,7 +463,6 @@ long nr_blockdev_pages(void)
 /**
  * bd_may_claim - test whether a block device can be claimed
  * @bdev: block device of interest
- * @whole: whole block device containing @bdev, may equal @bdev
  * @holder: holder trying to claim @bdev
  *
  * Test whether @bdev can be claimed by @holder.
@@ -474,22 +473,27 @@ long nr_blockdev_pages(void)
  * RETURNS:
  * %true if @bdev can be claimed, %false otherwise.
  */
-static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
-			 void *holder)
+static bool bd_may_claim(struct block_device *bdev, void *holder)
 {
-	if (bdev->bd_holder == holder)
-		return true;	 /* already a holder */
-	else if (bdev->bd_holder != NULL)
-		return false; 	 /* held by someone else */
-	else if (whole == bdev)
-		return true;  	 /* is a whole device which isn't held */
-
-	else if (whole->bd_holder == bd_may_claim)
-		return true; 	 /* is a partition of a device that is being partitioned */
-	else if (whole->bd_holder != NULL)
-		return false;	 /* is a partition of a held device */
-	else
-		return true;	 /* is a partition of an un-held device */
+	struct block_device *whole = bdev_whole(bdev);
+
+	if (bdev->bd_holder) {
+		/*
+		 * The same holder can always re-claim.
+		 */
+		if (bdev->bd_holder == holder)
+			return true;
+		return false;
+	}
+
+	/*
+	 * If the whole devices holder is set to bd_may_claim, a partition on
+	 * the device is claimed, but not the whole device.
+	 */
+	if (whole != bdev &&
+	    whole->bd_holder && whole->bd_holder != bd_may_claim)
+		return false;
+	return true;
 }
 
 /**
@@ -513,7 +517,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 retry:
 	spin_lock(&bdev_lock);
 	/* if someone else claimed, fail */
-	if (!bd_may_claim(bdev, whole, holder)) {
+	if (!bd_may_claim(bdev, holder)) {
 		spin_unlock(&bdev_lock);
 		return -EBUSY;
 	}
@@ -559,7 +563,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
 	struct block_device *whole = bdev_whole(bdev);
 
 	spin_lock(&bdev_lock);
-	BUG_ON(!bd_may_claim(bdev, whole, holder));
+	BUG_ON(!bd_may_claim(bdev, holder));
 	/*
 	 * Note that for a whole device bd_holders will be incremented twice,
 	 * and bd_holder will be set to bd_may_claim before being set to holder
-- 
2.39.2

