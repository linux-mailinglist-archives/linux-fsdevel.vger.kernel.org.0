Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116946F881A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjEERxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjEERwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 13:52:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D13588;
        Fri,  5 May 2023 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lDMC1lrlYmdpYq8a/9apcmwTdFEQ6B63P/EyMNUb9bo=; b=KGOBjob5BNDZGN+OXEXxQ0zucA
        VfOTnXx25OzjOkrlEZkUgwRkGobiJy+pX2vjjSqrjumN5QZ2/hj5weuF3rAhp1rz8yYtX35y/Jw2v
        GiSNPxwJf1RHPkamgJ2fY9U+TVl/T485cC429b6EbtlV9J/qDn4OHiDwmm3lrLiM64h3Gi6AwRCH9
        0n+Pa02rjkSqx3yhNwTtFBGthSuaC8nW8hzj7Kg3C4uxCc8L5YEjOo12QQn58YsYkqN2IkMRw61ck
        IQ0FaK/LMYUm9wrlYMi8M/ZUP99l7gDLDqr7rUvEnrwxt6djrJaiOkDk6KTOEglhAsT2ebq6lj1/E
        kiolEKtQ==;
Received: from 66-46-223-221.dedicated.allstream.net ([66.46.223.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puzax-00BSxb-23;
        Fri, 05 May 2023 17:51:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 4/9] block: turn bdev_lock into a mutex
Date:   Fri,  5 May 2023 13:51:27 -0400
Message-Id: <20230505175132.2236632-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505175132.2236632-1-hch@lst.de>
References: <20230505175132.2236632-1-hch@lst.de>
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
---
 block/bdev.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f2c7181b0bba7d..bad75f6cf8edcd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -308,7 +308,7 @@ EXPORT_SYMBOL(thaw_bdev);
  * pseudo-fs
  */
 
-static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(bdev_lock);
+static  __cacheline_aligned_in_smp DEFINE_MUTEX(bdev_lock);
 static struct kmem_cache * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
@@ -457,15 +457,14 @@ long nr_blockdev_pages(void)
  *
  * Test whether @bdev can be claimed by @holder.
  *
- * CONTEXT:
- * spin_lock(&bdev_lock).
- *
  * RETURNS:
  * %true if @bdev can be claimed, %false otherwise.
  */
 static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
 			 void *holder)
 {
+	lockdep_assert_held(&bdev_lock);
+
 	if (bdev->bd_holder == holder)
 		return true;	 /* already a holder */
 	else if (bdev->bd_holder != NULL)
@@ -500,10 +499,10 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 	if (WARN_ON_ONCE(!holder))
 		return -EINVAL;
 retry:
-	spin_lock(&bdev_lock);
+	mutex_lock(&bdev_lock);
 	/* if someone else claimed, fail */
 	if (!bd_may_claim(bdev, whole, holder)) {
-		spin_unlock(&bdev_lock);
+		mutex_unlock(&bdev_lock);
 		return -EBUSY;
 	}
 
@@ -513,7 +512,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 		DEFINE_WAIT(wait);
 
 		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
-		spin_unlock(&bdev_lock);
+		mutex_unlock(&bdev_lock);
 		schedule();
 		finish_wait(wq, &wait);
 		goto retry;
@@ -521,7 +520,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 
 	/* yay, all mine */
 	whole->bd_claiming = holder;
-	spin_unlock(&bdev_lock);
+	mutex_unlock(&bdev_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
@@ -547,7 +546,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
 
-	spin_lock(&bdev_lock);
+	mutex_lock(&bdev_lock);
 	BUG_ON(!bd_may_claim(bdev, whole, holder));
 	/*
 	 * Note that for a whole device bd_holders will be incremented twice,
@@ -558,7 +557,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
 	bdev->bd_holders++;
 	bdev->bd_holder = holder;
 	bd_clear_claiming(whole, holder);
-	spin_unlock(&bdev_lock);
+	mutex_unlock(&bdev_lock);
 }
 
 /**
@@ -572,9 +571,9 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
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
 
@@ -587,7 +586,7 @@ static void bd_end_claim(struct block_device *bdev)
 	 * Release a claim on the device.  The holder fields are protected with
 	 * bdev_lock.  open_mutex is used to synchronize disk_holder unlinking.
 	 */
-	spin_lock(&bdev_lock);
+	mutex_lock(&bdev_lock);
 	WARN_ON_ONCE(--bdev->bd_holders < 0);
 	WARN_ON_ONCE(--whole->bd_holders < 0);
 	if (!bdev->bd_holders) {
@@ -597,7 +596,7 @@ static void bd_end_claim(struct block_device *bdev)
 	}
 	if (!whole->bd_holders)
 		whole->bd_holder = NULL;
-	spin_unlock(&bdev_lock);
+	mutex_unlock(&bdev_lock);
 
 	/*
 	 * If this was the last claim, remove holder link and unblock evpoll if
-- 
2.39.2

