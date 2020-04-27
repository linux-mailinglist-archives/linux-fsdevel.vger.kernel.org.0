Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A330D1BA254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgD0LcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54642 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgD0LcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987129; x=1619523129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZlY2HnuJsRvH+R8sUQoVyJh5cKh0YcBb7C6VKw3R6Nw=;
  b=RE+bBCj9QnrCX2cr59XomqBqTPHlLwoFxVMzbrQeiN1ZZYM0RJegWr8B
   ZmGrLioeyFYFBBbGBvVeovKgO0MoqhJKhbVxYIU7A9zoXlwpTJnsQtjac
   Rj7AS9U6v4OW9yKRvhfeb+tv/zhIy1bOa4jwpawb2qzDCFKcSM0Mk9bjY
   g3hy2yHZRvxn1Lrk/lxnDVaFK7mIct2dM7fvetecJc/XX7jfR3mR1c5gs
   sk21eYZu+q52dmoosV/19v9IyHn4rrFIegGzwfOVbXzs8mDWMWEcFe9Ul
   S/LiSClsRLIoE/XJs/a2afXsZo2DgEbJYJx7+PbUbgabyqXQWlVhiOY0S
   Q==;
IronPort-SDR: qU/bfMf5e8b9aubFvJyEnAPeU8oFFIoEw/FQ1lFHf+0HAap7W/V5xMbSpO6bbVyi0iu2irQOmm
 v6wkLieAKmAu4YUIMZX6mtXqNjXqfIca2a39tvc7RPVE6TM7I9UbMcYrdagR5Eyu40+jELmige
 xITHm+fjlC0/kXROSfj6IeAK9PdJkwiH4RKteyuY2w/oTJzaQcqjN6I9g9wOyOGm0eoKB5KFgy
 ZEcqRg9Ab0thG4/9DIOmUqCBYiXsbxjsctd72R5b7UaPGiVjbL1j0es5kfK68Sc5FqJB72vJuP
 9v8=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136551990"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:08 +0800
IronPort-SDR: nUtQMcWbYMQ9te017QFynbPA4OGSrCuDBNA98iiCxN6DJN1xxEn3qnyKdedn/EEl2nT117Vwl4
 5BdY1VzHLwiaz7B06zqlfQrUqPOuSBDRo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:22:50 -0700
IronPort-SDR: VN+QhfIE3Qug/QcbH59Ao09OPgzvH1YEvxim+6hLC+cGCUKnukZyyFoX8cGbzWdkywUthVVu3v
 3HZguz40n/ZQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:07 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v8 03/11] block: rename __bio_add_pc_page to bio_add_hw_page
Date:   Mon, 27 Apr 2020 20:31:45 +0900
Message-Id: <20200427113153.31246-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Rename __bio_add_pc_page() to bio_add_hw_page() and explicitly pass in a
max_sectors argument.

This max_sectors argument can be used to specify constraints from the
hardware.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[ jth: rebased and made public for blk-map.c ]
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 block/bio.c     | 60 +++++++++++++++++++++++++++----------------------
 block/blk-map.c |  5 +++--
 block/blk.h     |  4 ++--
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 21cbaa6a1c20..0f0e337e46b4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -748,9 +748,14 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return true;
 }
 
-static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned len, unsigned offset,
-		bool *same_page)
+/*
+ * Try to merge a page into a segment, while obeying the hardware segment
+ * size limit.  This is not for normal read/write bios, but for passthrough
+ * or Zone Append operations that we can't split.
+ */
+static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
+				 struct page *page, unsigned len,
+				 unsigned offset, bool *same_page)
 {
 	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned long mask = queue_segment_boundary(q);
@@ -764,39 +769,24 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
 
-/**
- *	__bio_add_pc_page	- attempt to add page to passthrough bio
- *	@q: the target queue
- *	@bio: destination bio
- *	@page: page to add
- *	@len: vec entry length
- *	@offset: vec entry offset
- *	@same_page: return if the merge happen inside the same page
- *
- *	Attempt to add a page to the bio_vec maplist. This can fail for a
- *	number of reasons, such as the bio being full or target block device
- *	limitations. The target block device must allow bio's up to PAGE_SIZE,
- *	so it is always possible to add a single page to an empty bio.
- *
- *	This should only be used by passthrough bios.
+/*
+ * Add a page to a bio while respecting the hardware max_sectors, max_segment
+ * and gap limitations.
  */
-int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
-		bool *same_page)
+		unsigned int max_sectors, bool *same_page)
 {
 	struct bio_vec *bvec;
 
-	/*
-	 * cloned bio must not modify vec list
-	 */
-	if (unlikely(bio_flagged(bio, BIO_CLONED)))
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_pc_page(q, bio, page, len, offset, same_page))
+		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
 			return len;
 
 		/*
@@ -823,11 +813,27 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	return len;
 }
 
+/**
+ * bio_add_pc_page	- attempt to add page to passthrough bio
+ * @q: the target queue
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ *
+ * Attempt to add a page to the bio_vec maplist. This can fail for a
+ * number of reasons, such as the bio being full or target block device
+ * limitations. The target block device must allow bio's up to PAGE_SIZE,
+ * so it is always possible to add a single page to an empty bio.
+ *
+ * This should only be used by passthrough bios.
+ */
 int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset)
 {
 	bool same_page = false;
-	return __bio_add_pc_page(q, bio, page, len, offset, &same_page);
+	return bio_add_hw_page(q, bio, page, len, offset,
+			queue_max_hw_sectors(q), &same_page);
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
diff --git a/block/blk-map.c b/block/blk-map.c
index b6fa343fea9f..e3e4ac48db45 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -257,6 +257,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 static struct bio *bio_map_user_iov(struct request_queue *q,
 		struct iov_iter *iter, gfp_t gfp_mask)
 {
+	unsigned int max_sectors = queue_max_hw_sectors(q);
 	int j;
 	struct bio *bio;
 	int ret;
@@ -294,8 +295,8 @@ static struct bio *bio_map_user_iov(struct request_queue *q,
 				if (n > bytes)
 					n = bytes;
 
-				if (!__bio_add_pc_page(q, bio, page, n, offs,
-						&same_page)) {
+				if (!bio_add_hw_page(q, bio, page, n, offs,
+						     max_sectors, &same_page)) {
 					if (same_page)
 						put_page(page);
 					break;
diff --git a/block/blk.h b/block/blk.h
index 73bd3b1c6938..1ae3279df712 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -453,8 +453,8 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 
 struct request_queue *__blk_alloc_queue(int node_id);
 
-int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
-		bool *same_page);
+		unsigned int max_sectors, bool *same_page);
 
 #endif /* BLK_INTERNAL_H */
-- 
2.24.1

