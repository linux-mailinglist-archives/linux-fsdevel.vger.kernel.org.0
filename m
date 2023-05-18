Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EC7078F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjEREXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEREXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2D127;
        Wed, 17 May 2023 21:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0gTLAUlFe0DX2eUG/rV5llfv74gR91AkuRTXQ7aAQuQ=; b=vpKun/M7D8fB+iq2ZKgwFAQ4p2
        pNP3Tg+9axrBNEubJQg3m+gmQmpPnkfnQcFCOYA2sHZsQgFMQ4t2ghibVnovVdw2HwaFSoa7SCQgD
        pumoqJ5nIqTSGrI6nhZ6dsFy53+HlFvD5VhoTB7dGw69iuHd0CuWYsrueshMbxjc9gDjsolAL93Ae
        LG4FApY/eymdtrqH8djMeWvw87kx7FL/kcQD4Zb9Z3Azz7zgliDMcXEJGLMJjnFlZfrqFxvHSAzDg
        iDjIwQeRFDCx0goyiNikg5LfXTottVh1GWPLUj7wamvbiDY0GocUY0vaUtiFlCRpbQaw8Mk3SbQfO
        fUKMkKrg==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVAq-00BqNr-2V;
        Thu, 18 May 2023 04:23:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 03/13] block: turn bdev_lock into a mutex
Date:   Thu, 18 May 2023 06:23:12 +0200
Message-Id: <20230518042323.663189-4-hch@lst.de>
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

There is no reason for this lock to spin, and being able to sleep under
it will come in handy soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 080b5c83bfbc72..f5ffcac762e0cd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -308,7 +308,7 @@ EXPORT_SYMBOL(thaw_bdev);
  * pseudo-fs
  */
 
-static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(bdev_lock);
+static  __cacheline_aligned_in_smp DEFINE_MUTEX(bdev_lock);
 static struct kmem_cache * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
@@ -467,9 +467,6 @@ long nr_blockdev_pages(void)
  *
  * Test whether @bdev can be claimed by @holder.
  *
- * CONTEXT:
- * spin_lock(&bdev_lock).
- *
  * RETURNS:
  * %true if @bdev can be claimed, %false otherwise.
  */
@@ -477,6 +474,8 @@ static bool bd_may_claim(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
 
+	lockdep_assert_held(&bdev_lock);
+
 	if (bdev->bd_holder) {
 		/*
 		 * The same holder can always re-claim.
@@ -515,10 +514,10 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 	if (WARN_ON_ONCE(!holder))
 		return -EINVAL;
 retry:
-	spin_lock(&bdev_lock);
+	mutex_lock(&bdev_lock);
 	/* if someone else claimed, fail */
 	if (!bd_may_claim(bdev, holder)) {
-		spin_unlock(&bdev_lock);
+		mutex_unlock(&bdev_lock);
 		return -EBUSY;
 	}
 
@@ -528,7 +527,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 		DEFINE_WAIT(wait);
 
 		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
-		spin_unlock(&bdev_lock);
+		mutex_unlock(&bdev_lock);
 		schedule();
 		finish_wait(wq, &wait);
 		goto retry;
@@ -536,7 +535,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 
 	/* yay, all mine */
 	whole->bd_claiming = holder;
-	spin_unlock(&bdev_lock);
+	mutex_unlock(&bdev_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
@@ -562,7 +561,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
 
-	spin_lock(&bdev_lock);
+	mutex_lock(&bdev_lock);
 	BUG_ON(!bd_may_claim(bdev, holder));
 	/*
 	 * Note that for a whole device bd_holders will be incremented twice,
@@ -573,7 +572,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
 	bdev->bd_holders++;
 	bdev->bd_holder = holder;
 	bd_clear_claiming(whole, holder);
-	spin_unlock(&bdev_lock);
+	mutex_unlock(&bdev_lock);
 }
 
 /**
@@ -587,9 +586,9 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
  */
 void bd_abort_claiming(struct block_device *bdev, void *holder)
 {
-	spin_lock(&bdev_lock);
+	mutex_lock(&bdev_lock);
 	bd_clear_claiming(bdev_whole(bdev), holder);
-	spin_unlock(&bdev_lock);
+	mutex_unlock(&bdev_lock);
 }
 EXPORT_SYMBOL(bd_abort_claiming);
 
@@ -602,7 +601,7 @@ static void bd_end_claim(struct block_device *bdev)
 	 * Release a claim on the device.  The holder fields are protected with
 	 * bdev_lock.  open_mutex is used to synchronize disk_holder unlinking.
 	 */
-	spin_lock(&bdev_lock);
+	mutex_lock(&bdev_lock);
 	WARN_ON_ONCE(--bdev->bd_holders < 0);
 	WARN_ON_ONCE(--whole->bd_holders < 0);
 	if (!bdev->bd_holders) {
@@ -612,7 +611,7 @@ static void bd_end_claim(struct block_device *bdev)
 	}
 	if (!whole->bd_holders)
 		whole->bd_holder = NULL;
-	spin_unlock(&bdev_lock);
+	mutex_unlock(&bdev_lock);
 
 	/*
 	 * If this was the last claim, remove holder link and unblock evpoll if
-- 
2.39.2

