Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82285202230
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgFTHRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgFTHRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:17:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1685AC06174E;
        Sat, 20 Jun 2020 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PWoaAGkD37V49a5XO/d4L2SpxpwdiJM61vBFK3z1jao=; b=ILYf7Jofs+8veCFsDguNebS2Gq
        +A8el1OsLv4tV1VEKZuWT1XW/oOJVB8piETb5Tu0Lh209/BsOV52f3Djhvt/QfrXYrvYvjIAYhv/m
        zJBpxQQIZOIH8cYc0tf/x6Rs7Qfrtc/7KagJ4CqJUWPpxya2LaRdweibOKrS9UNuURKS+nXLUaY5+
        y+lmuZfbAFjg44baawJdLeM2xqG7Wr7G5f59kmfcnJ45Gig6kIM4c5HZeq6h+qdkEdhgAXSrCGMEX
        r7h2YEfJMhyOpEVjVHuDvxXigKaxzY2uj86VeyNtcksn0irpLKEhNYngU3Uz5oP4I/wGbF7Xxw/IX
        di6yldeQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkO-0003sC-7C; Sat, 20 Jun 2020 07:17:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] block: simplify sb_is_blkdev_sb
Date:   Sat, 20 Jun 2020 09:16:40 +0200
Message-Id: <20200620071644.463185-7-hch@lst.de>
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

Just use IS_ENABLED instead of providing a stub for !CONFIG_BLOCK.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ee09e2b5a9716..7f3ae38335d4b3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2557,6 +2557,12 @@ extern struct kmem_cache *names_cachep;
 #define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
 #define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
 
+extern struct super_block *blockdev_superblock;
+static inline bool sb_is_blkdev_sb(struct super_block *sb)
+{
+	return IS_ENABLED(CONFIG_BLOCK) && sb == blockdev_superblock;
+}
+
 #ifdef CONFIG_BLOCK
 extern int register_blkdev(unsigned int, const char *);
 extern void unregister_blkdev(unsigned int, const char *);
@@ -2572,13 +2578,6 @@ extern struct super_block *freeze_bdev(struct block_device *);
 extern void emergency_thaw_bdev(struct super_block *sb);
 extern int thaw_bdev(struct block_device *bdev, struct super_block *sb);
 extern int fsync_bdev(struct block_device *);
-
-extern struct super_block *blockdev_superblock;
-
-static inline bool sb_is_blkdev_sb(struct super_block *sb)
-{
-	return sb == blockdev_superblock;
-}
 #else
 static inline void bd_forget(struct inode *inode) {}
 static inline int sync_blockdev(struct block_device *bdev) { return 0; }
@@ -2602,11 +2601,6 @@ static inline int emergency_thaw_bdev(struct super_block *sb)
 static inline void iterate_bdevs(void (*f)(struct block_device *, void *), void *arg)
 {
 }
-
-static inline bool sb_is_blkdev_sb(struct super_block *sb)
-{
-	return false;
-}
 #endif
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
-- 
2.26.2

