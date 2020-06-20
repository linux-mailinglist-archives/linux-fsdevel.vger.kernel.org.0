Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC6A202247
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgFTHQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgFTHQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:16:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9BFC0613EE;
        Sat, 20 Jun 2020 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yAauw132d1z1dCUNzdZdaqGWn2S6iQtXJ0jFFxx9V0M=; b=Y1PndM6QYAC2ft7iVATj3vQde4
        aJxbNskmHkFxKm6F2PDiSsqkWKfeZ+GVy5bm+gSe7wHTD1oAC8iVPfAB7efVYeYoE2eexQ6RNbQf/
        TOtSOfbyuPWHJiGBqfFcQce+KWb92T7q4DPNb+QQ6dWoGOJebtc19lD7uO2k0gR8Z7Oeh8M4BZrWS
        bU8tmTRvUIU0UnX3xi4R/lMfNqogS1K6fvOScZUjS30QWCZGHhtIDXk/aQ0QmGQcjXtqVQ5J55YYJ
        4sMyW+iK+ttmorXf6MaEi0C1S3JB0yZ1qyG4IEKtosiSHnZjy39/QncA+NcOogtzW0Ry9LO54CogV
        ZW2s7nnQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkC-0003r9-L3; Sat, 20 Jun 2020 07:16:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] block: mark bd_finish_claiming static
Date:   Sat, 20 Jun 2020 09:16:36 +0200
Message-Id: <20200620071644.463185-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
References: <20200620071644.463185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c     | 5 ++---
 include/linux/fs.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0ae656e022fd57..0e0d43dc27d331 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1187,8 +1187,8 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  * Finish exclusive open of a block device. Mark the device as exlusively
  * open by the holder and wake up all waiters for exclusive open to finish.
  */
-void bd_finish_claiming(struct block_device *bdev, struct block_device *whole,
-			void *holder)
+static void bd_finish_claiming(struct block_device *bdev,
+		struct block_device *whole, void *holder)
 {
 	spin_lock(&bdev_lock);
 	BUG_ON(!bd_may_claim(bdev, whole, holder));
@@ -1203,7 +1203,6 @@ void bd_finish_claiming(struct block_device *bdev, struct block_device *whole,
 	bd_clear_claiming(whole, holder);
 	spin_unlock(&bdev_lock);
 }
-EXPORT_SYMBOL(bd_finish_claiming);
 
 /**
  * bd_abort_claiming - abort claiming of a block device
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7f40dbafbf6d49..b1c960e9b84e3a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2646,8 +2646,6 @@ extern struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode,
 					      void *holder);
 extern struct block_device *bd_start_claiming(struct block_device *bdev,
 					      void *holder);
-extern void bd_finish_claiming(struct block_device *bdev,
-			       struct block_device *whole, void *holder);
 extern void bd_abort_claiming(struct block_device *bdev,
 			      struct block_device *whole, void *holder);
 extern void blkdev_put(struct block_device *bdev, fmode_t mode);
-- 
2.26.2

