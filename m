Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696A54E43B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiCVP7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiCVP7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7F70879;
        Tue, 22 Mar 2022 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zY1mEnuG2qPjr4O7mm+6d1dIBQfBceN99V8poas0YSE=; b=GAO3XvUOkWOgcoiiHIT2cAOlpA
        AlNYuKRX0GE7tGSAmDqzxFKxek/L5dFOdjfIjn8L4zjiLmTD2MPSaugHXXTCc5oW5JvBpzJykD/Sk
        JjIBISNGhZXySs6bsoM6jZYILI2JyGbvcG7c2ncPqJZIbh2s4NbNc+8byEazrwM8cJLQ2pM6p/1Y7
        URCvDYOQa1evAKKNDxA8lviX+cyIlUMmsy73zYRvK47AKsVo1zEBkicc7cWeCIcfyY0SmiViMZKrC
        wKTed2i49zoIE5zpurT3f8Bou1dIQhWmoqn72k3y32S/0LcqSxvxpTG38VB0aQd7NkJ7vUzFh3I40
        yEKC/0SQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgt3-00Bb55-SV; Tue, 22 Mar 2022 15:57:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 33/40] iomap: add a hint to ->submit_io if there is more I/O coming
Date:   Tue, 22 Mar 2022 16:55:59 +0100
Message-Id: <20220322155606.1267165-34-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
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

Btrfs would like to optimize checksum offloading to threads depending on
if there is more I/O to come.  Pass that information to the ->submit_io
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c      | 2 +-
 fs/iomap/direct-io.c  | 8 ++++----
 include/linux/iomap.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 70d82effe5e37..2eb7e730c2afc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7917,7 +7917,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 }
 
 static void btrfs_submit_direct(const struct iomap_iter *iter,
-		struct bio *dio_bio, loff_t file_offset)
+		struct bio *dio_bio, loff_t file_offset, bool more)
 {
 	struct inode *inode = iter->inode;
 	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 392ee8fe1f8c3..3f18b04d73cde 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -60,7 +60,7 @@ static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
 }
 
 static void iomap_dio_submit_bio(const struct iomap_iter *iter,
-		struct iomap_dio *dio, struct bio *bio, loff_t pos)
+		struct iomap_dio *dio, struct bio *bio, loff_t pos, bool more)
 {
 	atomic_inc(&dio->ref);
 
@@ -70,7 +70,7 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
 	}
 
 	if (dio->dops && dio->dops->submit_io)
-		dio->dops->submit_io(iter, bio, pos);
+		dio->dops->submit_io(iter, bio, pos, more);
 	else
 		submit_bio(bio);
 }
@@ -200,7 +200,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
-	iomap_dio_submit_bio(iter, dio, bio, pos);
+	iomap_dio_submit_bio(iter, dio, bio, pos, false);
 }
 
 /*
@@ -353,7 +353,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		 */
 		if (nr_pages)
 			dio->iocb->ki_flags &= ~IOCB_HIPRI;
-		iomap_dio_submit_bio(iter, dio, bio, pos);
+		iomap_dio_submit_bio(iter, dio, bio, pos, nr_pages);
 		pos += n;
 	} while (nr_pages);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5648753973de0..c4a2fa441e4f9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -340,7 +340,7 @@ struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
 		      unsigned flags);
 	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
-		          loff_t file_offset);
+		          loff_t file_offset, bool more);
 
 	struct bio_set *bio_set;
 };
-- 
2.30.2

