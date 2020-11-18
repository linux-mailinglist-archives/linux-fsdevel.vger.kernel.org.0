Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602D72B7918
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgKRIs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgKRIs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F846C0613D4;
        Wed, 18 Nov 2020 00:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AuzCwkw90Oy6IPNhoiC+qBglSTsZM+HyoDoCPgOfof0=; b=YtHXD8P3bl/ZEagDvWBMs7HUMz
        zdBwVpVtkLRztaIitYOD+jnHVbFQ6nJ8vuy+RLNNTKM13Op/plycZzjy+O4m3LWRxyGds3Zqm8uXL
        0XuTVrpZcPUDGwu7KtN8TqRfLjbMNJ84KtyxsgxJmnWMTEPOjVTiAMZb5/WgHNDE+x7H3rKLRuDmH
        S0COUGr4VfDChivd1zEu5OgZhhAocAq3rfUghhZiWVdd7wm1RQ+tppv9VJnogHVF5m81oV1c+2vot
        cs+KiVe+jSmoJYHNAdtCaO4J/3LKZi6FdgQumaduslpItNE93jCeXFM/TwIDIwiBiRp2E9vOvb5No
        1S1bNtVg==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8O-0007lA-RG; Wed, 18 Nov 2020 08:48:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 06/20] block: change the hash used for looking up block devices
Date:   Wed, 18 Nov 2020 09:47:46 +0100
Message-Id: <20201118084800.2339180-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding the minor to the major creates tons of pointless conflicts. Just
use the dev_t itself, which is 32-bits and thus is guaranteed to fit
into ino_t.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d8664f5c1ff669..29db12c3bb501c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -870,35 +870,12 @@ void __init bdev_cache_init(void)
 	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
 }
 
-/*
- * Most likely _very_ bad one - but then it's hardly critical for small
- * /dev and can be fixed when somebody will need really large one.
- * Keep in mind that it will be fed through icache hash function too.
- */
-static inline unsigned long hash(dev_t dev)
-{
-	return MAJOR(dev)+MINOR(dev);
-}
-
-static int bdev_test(struct inode *inode, void *data)
-{
-	return BDEV_I(inode)->bdev.bd_dev == *(dev_t *)data;
-}
-
-static int bdev_set(struct inode *inode, void *data)
-{
-	BDEV_I(inode)->bdev.bd_dev = *(dev_t *)data;
-	return 0;
-}
-
 static struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
 
-	inode = iget5_locked(blockdev_superblock, hash(dev),
-			bdev_test, bdev_set, &dev);
-
+	inode = iget_locked(blockdev_superblock, dev);
 	if (!inode)
 		return NULL;
 
@@ -910,6 +887,7 @@ static struct block_device *bdget(dev_t dev)
 		bdev->bd_super = NULL;
 		bdev->bd_inode = inode;
 		bdev->bd_part_count = 0;
+		bdev->bd_dev = dev;
 		inode->i_mode = S_IFBLK;
 		inode->i_rdev = dev;
 		inode->i_bdev = bdev;
-- 
2.29.2

