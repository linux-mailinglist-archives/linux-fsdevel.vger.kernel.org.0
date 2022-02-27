Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37504C5A3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiB0Jfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 04:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiB0Jf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:35:28 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8123B01C;
        Sun, 27 Feb 2022 01:34:51 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id e2so6512195qte.12;
        Sun, 27 Feb 2022 01:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKC7TKW5D2QOJ++xII+i0UjXczoG+fDp5qDZuDgW9Qg=;
        b=DKVgMJUowfllLYw+jZ6fwPSQE8pq7A4uDQIJeJ7SOJomkZ9wAOQ0ZqDC4ryiLeNc4m
         NM+kmzgnIO1+/FBuqY7m+xQSrVFmkgbdxCxi4osZzgjQNzLo65nXphdzKDuW08W6r66e
         1azwYOhdDT9APBqcsZBUI+0wvClodMIiHUFtTrRfnfqzCFExQk6OGo15/wHMkUAGT/ci
         zJAnK7wKqFGJp6RcocTrogSwe2ZeIOyrPp9nZa1SwWSJfdB7NVKXvFUKKNly46lOejCE
         nJoGmtM6ORxApH0P3P5SqxHt2B8kAYe57b+fnEqZdeW9jXkWABIY5u7F03dx0GDDdE5O
         K6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKC7TKW5D2QOJ++xII+i0UjXczoG+fDp5qDZuDgW9Qg=;
        b=P/EgBu4t3KMcu9iMVayd7LcVyHVoPcO5aLQihBu410X8KpPQ7hlrKo4pIFaMMSleIW
         zRTA5P72I3lti2uAhx4t/UVIZaE0MWYnTKD5KDmzLjamzF7Z/EWwYoFCZrNio6fmyWdG
         wjIrWVQzX/i3MNN7eb3Mvb7bNsRINNf2J1aHgGsrgH773rvOqRUxJ2Iy/ms7pi68gZf4
         rGmvtUqXaSWLL8NB1iUkm8YtQO7uqfvMSxczfevGjlG7tK0JJ1BgKzYBd7sCshVxnUo3
         oQHCZul/o3PYWAz1ZE0ut2st2JNfvlurkqrGzFkoHpB14ymjiN9dwLc8waE7qDFRzZMX
         YgIA==
X-Gm-Message-State: AOAM5337hlZr1MiZyt+Js7r8DM9C5LwfW2nkgevftI8FBUetQhbUPTf2
        jyS5eq4ubiuCyVKLfq82AXbJDsxlCOC9M5e2uw14OA==
X-Google-Smtp-Source: ABdhPJyfmd5ydQZXFebOoxbyj0eeWBFyyCNOd2/6AAPY8l/joK7YvF7bQZnGj3AW8Dd0Zdz58ckqIg==
X-Received: by 2002:ac8:5f0c:0:b0:2de:2dc9:24e5 with SMTP id x12-20020ac85f0c000000b002de2dc924e5mr13127891qta.535.1645954490427;
        Sun, 27 Feb 2022 01:34:50 -0800 (PST)
Received: from sandstorm.attlocal.net (76-242-90-12.lightspeed.sntcca.sbcglobal.net. [76.242.90.12])
        by smtp.gmail.com with ESMTPSA id h3-20020a05622a170300b002e008a93f8fsm469815qtk.91.2022.02.27.01.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 01:34:50 -0800 (PST)
From:   jhubbard.send.patches@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/6] block, bio, fs: convert most filesystems to pin_user_pages_fast()
Date:   Sun, 27 Feb 2022 01:34:32 -0800
Message-Id: <20220227093434.2889464-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227093434.2889464-1-jhubbard@nvidia.com>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Use pin_user_pages_fast(), pin_user_page(), and unpin_user_page() calls,
in place of get_user_pages_fast(), get_page() and put_page().

This converts the Direct IO parts of most filesystems over to using
FOLL_PIN (pin_user_page*()) page pinning.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/bio.c          | 25 ++++++++++++-------------
 block/blk-map.c      |  6 +++---
 fs/direct-io.c       | 26 +++++++++++++-------------
 fs/iomap/direct-io.c |  2 +-
 4 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4679d6539e2d..d078f992a9c9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1102,7 +1102,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		unpin_user_page(bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1130,10 +1130,9 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 
 static void bio_put_pages(struct page **pages, size_t size, size_t off)
 {
-	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
+	size_t nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
 
-	for (i = 0; i < nr; i++)
-		put_page(pages[i]);
+	unpin_user_pages(pages, nr);
 }
 
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
@@ -1144,9 +1143,9 @@ static void bio_put_pages(struct page **pages, size_t size, size_t off)
  * @iter: iov iterator describing the region to be mapped
  *
  * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
- * For multi-segment *iter, this function only adds pages from the
- * next non-empty segment of the iov iterator.
+ * pages will have to be released using unpin_user_page() when done. For
+ * multi-segment *iter, this function only adds pages from the next non-empty
+ * segment of the iov iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1169,7 +1168,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	WARN_ON_ONCE(!iter_is_iovec(iter));
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size = iov_iter_pin_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
@@ -1180,7 +1179,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 			if (same_page)
-				put_page(page);
+				unpin_user_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len))) {
 				bio_put_pages(pages + i, left, offset);
@@ -1221,7 +1220,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	WARN_ON_ONCE(!iter_is_iovec(iter));
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size = iov_iter_pin_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
@@ -1237,7 +1236,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 			break;
 		}
 		if (same_page)
-			put_page(page);
+			unpin_user_page(page);
 		offset = 0;
 	}
 
@@ -1434,8 +1433,8 @@ void bio_set_pages_dirty(struct bio *bio)
  * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO from
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
+ * here on.  It will run one unpin_user_page() against each page and will run
+ * one bio_put() against the BIO.
  */
 
 static void bio_dirty_fn(struct work_struct *work);
diff --git a/block/blk-map.c b/block/blk-map.c
index c7f71d83eff1..ce450683994c 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -252,7 +252,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		size_t offs, added = 0;
 		int npages;
 
-		bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
+		bytes = iov_iter_pin_pages_alloc(iter, &pages, LONG_MAX, &offs);
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
@@ -275,7 +275,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
 						     max_sectors, &same_page)) {
 					if (same_page)
-						put_page(page);
+						unpin_user_page(page);
 					break;
 				}
 
@@ -289,7 +289,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		 * release the pages we didn't map into the bio, if any
 		 */
 		while (j < npages)
-			put_page(pages[j++]);
+			unpin_user_page(pages[j++]);
 		kvfree(pages);
 		/* couldn't stuff something into bio? */
 		if (bytes)
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 7dbbbfef300d..815407c26f57 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -171,7 +171,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 
 	WARN_ON_ONCE(!iter_is_iovec(sdio->iter));
 
-	ret = iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
+	ret = iov_iter_pin_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
 				&sdio->from);
 
 	if (ret < 0 && sdio->blocks_available && (dio->op == REQ_OP_WRITE)) {
@@ -183,7 +183,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		 */
 		if (dio->page_errors == 0)
 			dio->page_errors = ret;
-		get_page(page);
+		pin_user_page(page);
 		dio->pages[0] = page;
 		sdio->head = 0;
 		sdio->tail = 1;
@@ -452,7 +452,7 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
 {
 	while (sdio->head < sdio->tail)
-		put_page(dio->pages[sdio->head++]);
+		unpin_user_page(dio->pages[sdio->head++]);
 }
 
 /*
@@ -717,7 +717,7 @@ static inline int dio_bio_add_page(struct dio_submit *sdio)
 		 */
 		if ((sdio->cur_page_len + sdio->cur_page_offset) == PAGE_SIZE)
 			sdio->pages_in_io--;
-		get_page(sdio->cur_page);
+		pin_user_page(sdio->cur_page);
 		sdio->final_block_in_bio = sdio->cur_page_block +
 			(sdio->cur_page_len >> sdio->blkbits);
 		ret = 0;
@@ -832,13 +832,13 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 	 */
 	if (sdio->cur_page) {
 		ret = dio_send_cur_page(dio, sdio, map_bh);
-		put_page(sdio->cur_page);
+		unpin_user_page(sdio->cur_page);
 		sdio->cur_page = NULL;
 		if (ret)
 			return ret;
 	}
 
-	get_page(page);		/* It is in dio */
+	pin_user_page(page);		/* It is in dio */
 	sdio->cur_page = page;
 	sdio->cur_page_offset = offset;
 	sdio->cur_page_len = len;
@@ -853,7 +853,7 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 		ret = dio_send_cur_page(dio, sdio, map_bh);
 		if (sdio->bio)
 			dio_bio_submit(dio, sdio);
-		put_page(sdio->cur_page);
+		unpin_user_page(sdio->cur_page);
 		sdio->cur_page = NULL;
 	}
 	return ret;
@@ -953,7 +953,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				ret = get_more_blocks(dio, sdio, map_bh);
 				if (ret) {
-					put_page(page);
+					unpin_user_page(page);
 					goto out;
 				}
 				if (!buffer_mapped(map_bh))
@@ -998,7 +998,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				/* AKPM: eargh, -ENOTBLK is a hack */
 				if (dio->op == REQ_OP_WRITE) {
-					put_page(page);
+					unpin_user_page(page);
 					return -ENOTBLK;
 				}
 
@@ -1011,7 +1011,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 				if (sdio->block_in_file >=
 						i_size_aligned >> blkbits) {
 					/* We hit eof */
-					put_page(page);
+					unpin_user_page(page);
 					goto out;
 				}
 				zero_user(page, from, 1 << blkbits);
@@ -1051,7 +1051,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 						  sdio->next_block_for_io,
 						  map_bh);
 			if (ret) {
-				put_page(page);
+				unpin_user_page(page);
 				goto out;
 			}
 			sdio->next_block_for_io += this_chunk_blocks;
@@ -1067,7 +1067,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 		}
 
 		/* Drop the ref which was taken in get_user_pages() */
-		put_page(page);
+		unpin_user_page(page);
 	}
 out:
 	return ret;
@@ -1289,7 +1289,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		ret2 = dio_send_cur_page(dio, &sdio, &map_bh);
 		if (retval == 0)
 			retval = ret2;
-		put_page(sdio.cur_page);
+		unpin_user_page(sdio.cur_page);
 		sdio.cur_page = NULL;
 	}
 	if (sdio.bio)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 67cf9c16f80c..d0986a31a9d1 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -192,7 +192,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	get_page(page);
+	pin_user_page(page);
 	__bio_add_page(bio, page, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
-- 
2.35.1

