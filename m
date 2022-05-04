Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D251A569
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353399AbiEDQ12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiEDQ1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 12:27:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20D45AC4;
        Wed,  4 May 2022 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NUkZqAWhGiclxUCt/aQAB87+vXSMe5Vh5EDsntJyPOk=; b=4VEjFxqLQHvU9DpjO0J9wc1EXG
        M6LY4JQcVEAQaGuBqIrAbCH36KjTyphQpgST0pMt45NtNwJxeWosI/bo1FM0VnXFrnAtM6VjPyM5G
        4qt3HszxC+Eic7M5D70DV3Pg0uuhA6i1SZrOpLfdH1LMwKxvRJaW5t1hhg0S68JQFTne/TdnPwGzk
        kMqmqHuvLW44s+L4uZKMQNYnbbqOPU2NJNI7D1CWINk9WDwl8uuCZ3bVBrENN7lswmbOeN8YfANEy
        Y6DmYpL9sn3cUBA/7nhQkYKRYQSZd2HD7S3tTJczYEech4VvJq7XQQV0TeHt0hq+Rm2dNzOOlmPhL
        uwL9mQkg==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmHmx-00BeD5-4E; Wed, 04 May 2022 16:23:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] iomap: allow the file system to provide a bio_set for direct I/O
Date:   Wed,  4 May 2022 09:23:38 -0700
Message-Id: <20220504162342.573651-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504162342.573651-1-hch@lst.de>
References: <20220504162342.573651-1-hch@lst.de>
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

Allow the file system to provide a specific bio_set for allocating
direct I/O bios.  This will allow file systems that use the
->submit_io hook to stash away additional information for file system
use.

To make use of this additional space for information in the completion
path, the file system needs to override the ->bi_end_io callback and
then call back into iomap, so export iomap_dio_bio_end_io for that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 18 ++++++++++++++----
 include/linux/iomap.h |  3 +++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b08f5dc31780d..15929690d89e3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -51,6 +51,15 @@ struct iomap_dio {
 	};
 };
 
+static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
+		struct iomap_dio *dio, unsigned short nr_vecs, unsigned int opf)
+{
+	if (dio->dops && dio->dops->bio_set)
+		return bio_alloc_bioset(iter->iomap.bdev, nr_vecs, opf,
+					GFP_KERNEL, dio->dops->bio_set);
+	return bio_alloc(iter->iomap.bdev, nr_vecs, opf, GFP_KERNEL);
+}
+
 static void iomap_dio_submit_bio(const struct iomap_iter *iter,
 		struct iomap_dio *dio, struct bio *bio, loff_t pos)
 {
@@ -144,7 +153,7 @@ static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
 	cmpxchg(&dio->error, 0, ret);
 }
 
-static void iomap_dio_bio_end_io(struct bio *bio)
+void iomap_dio_bio_end_io(struct bio *bio)
 {
 	struct iomap_dio *dio = bio->bi_private;
 	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
@@ -176,16 +185,17 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		bio_put(bio);
 	}
 }
+EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
 static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct page *page = ZERO_PAGE(0);
-	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
-	bio = bio_alloc(iter->iomap.bdev, 1, REQ_OP_WRITE | flags, GFP_KERNEL);
+	bio = iomap_dio_alloc_bio(iter, dio, 1,
+			REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
@@ -311,7 +321,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			goto out;
 		}
 
-		bio = bio_alloc(iomap->bdev, nr_pages, bio_opf, GFP_KERNEL);
+		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b76f0dd149fb4..a5483020dad41 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -320,6 +320,8 @@ struct iomap_dio_ops {
 		      unsigned flags);
 	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
 		          loff_t file_offset);
+
+	struct bio_set *bio_set;
 };
 
 /*
@@ -349,6 +351,7 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, size_t done_before);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
+void iomap_dio_bio_end_io(struct bio *bio);
 
 #ifdef CONFIG_SWAP
 struct file;
-- 
2.30.2

