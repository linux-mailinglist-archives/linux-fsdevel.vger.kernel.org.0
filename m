Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103B91CEFAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgELI4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:56:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16012 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgELI4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589273768; x=1620809768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=310oifaEsgscOtS7gBBrXefIuiyMnrBkU90sLOB8m90=;
  b=QZ9Z0lInsLe4gM/Jj4f+AZ2BQhx6nvfVsFkc4doLMa201NOWgr0XPU7O
   Fg4BWJ5pwLMtTO8iSf+QeBegYpdgnXEvJr62OGFMZsYSzCsOo2k6GAPJx
   pTiEzaZjUDI8Xj0jHASHwjANy0Ts3LDZTC7mO9hVJwbhsqpHNyagrAFPO
   lI5kNW+Ss7geel+akiVw4xEAu4e6g2psBv2ONO7CDUmjsvhEZuMykltDd
   x19A4gNkVdLrsmnjcjHVZryiVEwKIIt67SataG1TeP9tpGIRJR4xEFrjG
   6J+aOa9znvaCk4gB+7GR6o2JTGUEpkQ+Tzd1Ss4qLPQpMVWAf5YOU/2uk
   Q==;
IronPort-SDR: T3Ymlyt1GkM5WY9+Q7AO8BBO9e/pNOnRW4mpaqJP8gYej2n6FaKhGgfAsJjeXR+lGPnqsu8qBj
 bjgMbmv6ILTSDOtHhe0NnvUY+HgJOdCPbGBlnKZvml1QomtjyOfc/uPB19rkNbsKxI7WsaFKHu
 WnBMAcZgdTg50x88brEEU37XZYdaD9wra2m5uHo6UH+8H8JQRhBsnl45oScoF3XDJy87LmfUkV
 VQsbU3O5UezO++BYHARiB1/IMEI94l6+2c5pAXjQJHqEDGJ0ymTZdaQK/9ErRnI69pA+eK+g2i
 cXQ=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="141823535"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:56:07 +0800
IronPort-SDR: XGmSTRMzjUdb3Dax8Eb9WBhu/X8o01vvXMxFGXq4/18DDvTPN+gAS9Ipbu/D4pOppuJGSanguw
 fv1PZLkiPYwgcU2Ze8t0ughaJ/dDWHi4o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:45:49 -0700
IronPort-SDR: mJhEXX3nQ+FL2UhHRYlr2qlY7kmHpyoWDy5tTwnPxleg79GENqORTexK9ACgF3FRYBjaQ1bzB/
 QoQpr1fSgxFw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 01:56:04 -0700
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
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v11 02/10] block: rename __bio_add_pc_page to bio_add_hw_page
Date:   Tue, 12 May 2020 17:55:46 +0900
Message-Id: <20200512085554.26366-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/bio.c     | 65 ++++++++++++++++++++++++++++++-------------------
 block/blk-map.c |  5 ++--
 block/blk.h     |  4 +--
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 21cbaa6a1c20..aad0a6dad4f9 100644
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
@@ -765,38 +770,32 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
 }
 
 /**
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
+ * bio_add_hw_page - attempt to add a page to a bio with hw constraints
+ * @q: the target queue
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ * @max_sectors: maximum number of sectors that can be added
+ * @same_page: return if the segment has been merged inside the same page
  *
- *	This should only be used by passthrough bios.
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
@@ -823,11 +822,27 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
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

