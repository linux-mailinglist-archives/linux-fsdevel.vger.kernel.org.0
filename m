Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDBB711A45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 00:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbjEYWlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 18:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbjEYWlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 18:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD41B0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685054412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCC0sosk0Q9OchSk1Wd/PogJY3iRiwmEwElEkGvXYZE=;
        b=MDbCHnw5LrpRZAgYBMuKfJr+pKqkMYbfgTPPmlTAuUJ4GH2hsW44TP2L//t1SEGWEUXKG6
        P9cy0WAi69TTvi8k9zmxPNa5epUrjxNMNadYe/1U2m+2RISIMdbbDpC53mki/oHquhfoD3
        esJP+B0Vq85b5nFl1AC+vcvTJ/+RwSs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-_OlhGPMwOpeIMBefHaCpnA-1; Thu, 25 May 2023 18:40:08 -0400
X-MC-Unique: _OlhGPMwOpeIMBefHaCpnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E96918007D9;
        Thu, 25 May 2023 22:40:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9049E7AF5;
        Thu, 25 May 2023 22:40:05 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 3/3] block: Use iov_iter_extract_pages() and page pinning in direct-io.c
Date:   Thu, 25 May 2023 23:39:53 +0100
Message-Id: <20230525223953.225496-4-dhowells@redhat.com>
In-Reply-To: <20230525223953.225496-1-dhowells@redhat.com>
References: <20230525223953.225496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the old block-based direct-I/O code to use iov_iter_extract_pages()
to pin user pages or leave kernel pages unpinned rather than taking refs
when submitting bios.

This makes use of the preceding patches to not take pins on the zero page
(thereby allowing insertion of zero pages in with pinned pages) and to get
additional pins on pages, allowing an extracted page to be used in multiple
bios without having to re-extract it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: David Hildenbrand <david@redhat.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: Jason Gunthorpe <jgg@nvidia.com>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: Hillf Danton <hdanton@sina.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #2)
     - Need to set BIO_PAGE_PINNED conditionally, not BIO_PAGE_REFFED.

 fs/direct-io.c | 72 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index ad20f3428bab..5d4c5be0fb41 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -42,8 +42,8 @@
 #include "internal.h"
 
 /*
- * How many user pages to map in one call to get_user_pages().  This determines
- * the size of a structure in the slab cache
+ * How many user pages to map in one call to iov_iter_extract_pages().  This
+ * determines the size of a structure in the slab cache
  */
 #define DIO_PAGES	64
 
@@ -121,12 +121,13 @@ struct dio {
 	struct inode *inode;
 	loff_t i_size;			/* i_size when submitted */
 	dio_iodone_t *end_io;		/* IO completion function */
+	bool need_unpin;		/* T if we need to unpin the pages */
 
 	void *private;			/* copy from map_bh.b_private */
 
 	/* BIO completion state */
 	spinlock_t bio_lock;		/* protects BIO fields below */
-	int page_errors;		/* errno from get_user_pages() */
+	int page_errors;		/* err from iov_iter_extract_pages() */
 	int is_async;			/* is IO async ? */
 	bool defer_completion;		/* defer AIO completion to workqueue? */
 	bool should_dirty;		/* if pages should be dirtied */
@@ -165,14 +166,14 @@ static inline unsigned dio_pages_present(struct dio_submit *sdio)
  */
 static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 {
+	struct page **pages = dio->pages;
 	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
 	ssize_t ret;
 
-	ret = iov_iter_get_pages2(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
-				&sdio->from);
+	ret = iov_iter_extract_pages(sdio->iter, &pages, LONG_MAX,
+				     DIO_PAGES, 0, &sdio->from);
 
 	if (ret < 0 && sdio->blocks_available && dio_op == REQ_OP_WRITE) {
-		struct page *page = ZERO_PAGE(0);
 		/*
 		 * A memory fault, but the filesystem has some outstanding
 		 * mapped blocks.  We need to use those blocks up to avoid
@@ -180,8 +181,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		 */
 		if (dio->page_errors == 0)
 			dio->page_errors = ret;
-		get_page(page);
-		dio->pages[0] = page;
+		dio->pages[0] = ZERO_PAGE(0);
 		sdio->head = 0;
 		sdio->tail = 1;
 		sdio->from = 0;
@@ -201,9 +201,9 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 
 /*
  * Get another userspace page.  Returns an ERR_PTR on error.  Pages are
- * buffered inside the dio so that we can call get_user_pages() against a
- * decent number of pages, less frequently.  To provide nicer use of the
- * L1 cache.
+ * buffered inside the dio so that we can call iov_iter_extract_pages()
+ * against a decent number of pages, less frequently.  To provide nicer use of
+ * the L1 cache.
  */
 static inline struct page *dio_get_page(struct dio *dio,
 					struct dio_submit *sdio)
@@ -219,6 +219,18 @@ static inline struct page *dio_get_page(struct dio *dio,
 	return dio->pages[sdio->head];
 }
 
+static void dio_pin_page(struct dio *dio, struct page *page)
+{
+	if (dio->need_unpin)
+		page_get_additional_pin(page);
+}
+
+static void dio_unpin_page(struct dio *dio, struct page *page)
+{
+	if (dio->need_unpin)
+		unpin_user_page(page);
+}
+
 /*
  * dio_complete() - called when all DIO BIO I/O has been completed
  *
@@ -402,8 +414,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 		bio->bi_end_io = dio_bio_end_aio;
 	else
 		bio->bi_end_io = dio_bio_end_io;
-	/* for now require references for all pages */
-	bio_set_flag(bio, BIO_PAGE_REFFED);
+	if (dio->need_unpin)
+		bio_set_flag(bio, BIO_PAGE_PINNED);
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
@@ -444,8 +456,9 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
  */
 static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
 {
-	while (sdio->head < sdio->tail)
-		put_page(dio->pages[sdio->head++]);
+	if (dio->need_unpin)
+		unpin_user_pages(dio->pages + sdio->head,
+				 sdio->tail - sdio->head);
 }
 
 /*
@@ -676,7 +689,7 @@ static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
  *
  * Return zero on success.  Non-zero means the caller needs to start a new BIO.
  */
-static inline int dio_bio_add_page(struct dio_submit *sdio)
+static inline int dio_bio_add_page(struct dio *dio, struct dio_submit *sdio)
 {
 	int ret;
 
@@ -688,7 +701,7 @@ static inline int dio_bio_add_page(struct dio_submit *sdio)
 		 */
 		if ((sdio->cur_page_len + sdio->cur_page_offset) == PAGE_SIZE)
 			sdio->pages_in_io--;
-		get_page(sdio->cur_page);
+		dio_pin_page(dio, sdio->cur_page);
 		sdio->final_block_in_bio = sdio->cur_page_block +
 			(sdio->cur_page_len >> sdio->blkbits);
 		ret = 0;
@@ -743,11 +756,11 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 			goto out;
 	}
 
-	if (dio_bio_add_page(sdio) != 0) {
+	if (dio_bio_add_page(dio, sdio) != 0) {
 		dio_bio_submit(dio, sdio);
 		ret = dio_new_bio(dio, sdio, sdio->cur_page_block, map_bh);
 		if (ret == 0) {
-			ret = dio_bio_add_page(sdio);
+			ret = dio_bio_add_page(dio, sdio);
 			BUG_ON(ret != 0);
 		}
 	}
@@ -804,13 +817,13 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 	 */
 	if (sdio->cur_page) {
 		ret = dio_send_cur_page(dio, sdio, map_bh);
-		put_page(sdio->cur_page);
+		dio_unpin_page(dio, sdio->cur_page);
 		sdio->cur_page = NULL;
 		if (ret)
 			return ret;
 	}
 
-	get_page(page);		/* It is in dio */
+	dio_pin_page(dio, page);		/* It is in dio */
 	sdio->cur_page = page;
 	sdio->cur_page_offset = offset;
 	sdio->cur_page_len = len;
@@ -825,7 +838,7 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 		ret = dio_send_cur_page(dio, sdio, map_bh);
 		if (sdio->bio)
 			dio_bio_submit(dio, sdio);
-		put_page(sdio->cur_page);
+		dio_unpin_page(dio, sdio->cur_page);
 		sdio->cur_page = NULL;
 	}
 	return ret;
@@ -926,7 +939,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				ret = get_more_blocks(dio, sdio, map_bh);
 				if (ret) {
-					put_page(page);
+					dio_unpin_page(dio, page);
 					goto out;
 				}
 				if (!buffer_mapped(map_bh))
@@ -971,7 +984,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				/* AKPM: eargh, -ENOTBLK is a hack */
 				if (dio_op == REQ_OP_WRITE) {
-					put_page(page);
+					dio_unpin_page(dio, page);
 					return -ENOTBLK;
 				}
 
@@ -984,7 +997,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 				if (sdio->block_in_file >=
 						i_size_aligned >> blkbits) {
 					/* We hit eof */
-					put_page(page);
+					dio_unpin_page(dio, page);
 					goto out;
 				}
 				zero_user(page, from, 1 << blkbits);
@@ -1024,7 +1037,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 						  sdio->next_block_for_io,
 						  map_bh);
 			if (ret) {
-				put_page(page);
+				dio_unpin_page(dio, page);
 				goto out;
 			}
 			sdio->next_block_for_io += this_chunk_blocks;
@@ -1039,8 +1052,8 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 				break;
 		}
 
-		/* Drop the ref which was taken in get_user_pages() */
-		put_page(page);
+		/* Drop the pin which was taken in get_user_pages() */
+		dio_unpin_page(dio, page);
 	}
 out:
 	return ret;
@@ -1135,6 +1148,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		/* will be released by direct_io_worker */
 		inode_lock(inode);
 	}
+	dio->need_unpin = iov_iter_extract_will_pin(iter);
 
 	/* Once we sampled i_size check for reads beyond EOF */
 	dio->i_size = i_size_read(inode);
@@ -1259,7 +1273,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		ret2 = dio_send_cur_page(dio, &sdio, &map_bh);
 		if (retval == 0)
 			retval = ret2;
-		put_page(sdio.cur_page);
+		dio_unpin_page(dio, sdio.cur_page);
 		sdio.cur_page = NULL;
 	}
 	if (sdio.bio)

