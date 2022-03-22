Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D995C4E43BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiCVP7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiCVP7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369D770849;
        Tue, 22 Mar 2022 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Be2y/NPJFYfPMwGSE2g53TQnpfjOJ/SU6l24rLDwEWI=; b=ZNlr5MFRqgPDNcyE/uCWYnjyW0
        T55A60Q1nqJDGlCxUBjhbRs0TzWFjIUUyT9/AVfnLyb6/AQyXwx+nc+F0QuoxbJRMocvyUMcALPJK
        sPDnlgXy9TfP32PX5+pOr51jHot0NymreOGwlzg0+64qcMV44bRfSkoAqK0Rl5n21IyEnj3gl9v8I
        BFAz+Auc7RA8Myo0Sa7z5wCNzTz4QZxa5IKzLGSRo/jmi11qJKFX21YaON5QJO99EbPTgGJZ1a74d
        FlM/iZ9psmm72RB7MLYSeOLTcdsCu+quuFPrVdJOYbJ0gwLUZyfKEmDD4hvMWN7spw+RwSzA5UHlI
        cSIRyFxg==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgt1-00Bb3w-9m; Tue, 22 Mar 2022 15:57:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 32/40] iomap: optionally allocate dio bios from a file system bio_set
Date:   Tue, 22 Mar 2022 16:55:58 +0100
Message-Id: <20220322155606.1267165-33-hch@lst.de>
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

Allow the file system to provide a specific bio_set for allocating
direct I/O bios.  This will allow file systems that use the
->submit_io hook to stash away additional information for file system
use.

To make use of this additional space for information the file system
also needs to hook into the completion path and thus override
the ->bi_end_io callback.  Export iomap_dio_bio_end_io so that the
file system can call back into the core iomap direct I/O code after
doing so.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 18 ++++++++++++++----
 include/linux/iomap.h |  3 +++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 63ee37b40fd8f..392ee8fe1f8c3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -50,6 +50,15 @@ struct iomap_dio {
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
@@ -143,7 +152,7 @@ static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
 	cmpxchg(&dio->error, 0, ret);
 }
 
-static void iomap_dio_bio_end_io(struct bio *bio)
+void iomap_dio_bio_end_io(struct bio *bio)
 {
 	struct iomap_dio *dio = bio->bi_private;
 	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
@@ -175,15 +184,16 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		bio_put(bio);
 	}
 }
+EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
 static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
 	struct page *page = ZERO_PAGE(0);
-	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
-	bio = bio_alloc(iter->iomap.bdev, 1, REQ_OP_WRITE | flags, GFP_KERNEL);
+	bio = iomap_dio_alloc_bio(iter, dio, 1,
+			REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
@@ -307,7 +317,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			goto out;
 		}
 
-		bio = bio_alloc(iomap->bdev, nr_pages, bio_opf, GFP_KERNEL);
+		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 494f530aa8bf8..5648753973de0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -341,6 +341,8 @@ struct iomap_dio_ops {
 		      unsigned flags);
 	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
 		          loff_t file_offset);
+
+	struct bio_set *bio_set;
 };
 
 /*
@@ -370,6 +372,7 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, size_t done_before);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
+void iomap_dio_bio_end_io(struct bio *bio);
 
 #ifdef CONFIG_SWAP
 struct file;
-- 
2.30.2

