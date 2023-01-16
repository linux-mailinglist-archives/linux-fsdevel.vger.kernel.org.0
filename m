Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5366D2D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjAPXOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjAPXNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF112F792
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jarh3eMoc9hZrrF4c4ACwfJRYikpAl6+h2t1z40q5Pk=;
        b=VkqXekKWGlgvPHdiBnhSr1uO6KEveFBM2oxV/+dJjLq7rcsDU8WgiE/XuuYpnB2U5wi6Tk
        sf4JQ2BaOXhi+/H6xFaALl9VlwxArqsb++EzLwnRDzly840lvZpi2v+6TEPeSYiMKEdFO3
        U/2YIVeg8JDk2FTDC0eUWaQYniav/yQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-WvNlc5M6Mx-qoev1bLXoGA-1; Mon, 16 Jan 2023 18:10:13 -0500
X-MC-Unique: WvNlc5M6Mx-qoev1bLXoGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F0A42A59569;
        Mon, 16 Jan 2023 23:10:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B36BE53AA;
        Mon, 16 Jan 2023 23:10:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 18/34] dio: Pin pages rather than ref'ing if appropriate
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:10:11 +0000
Message-ID: <167391061117.2311931.16807283804788007499.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the generic direct-I/O code to use iov_iter_extract_pages() instead
of iov_iter_get_pages().  This will pin pages or leave them unaltered
rather than getting a ref on them as appropriate to the iterator.

The pages need to be pinned for DIO-read rather than having refs taken on
them to prevent VM copy-on-write from malfunctioning during a concurrent
fork() (the result of the I/O would otherwise end up only visible to the
child process and not the parent).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jan Kara <jack@suse.cz>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
---

 fs/direct-io.c |   57 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b1e26a706e31..b4d2c9f85a5b 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -142,9 +142,11 @@ struct dio {
 
 	/*
 	 * pages[] (and any fields placed after it) are not zeroed out at
-	 * allocation time.  Don't add new fields after pages[] unless you
-	 * wish that they not be zeroed.
+	 * allocation time.  Don't add new fields after pages[] unless you wish
+	 * that they not be zeroed.  Pages may have a ref taken, a pin emplaced
+	 * or no retention measures.
 	 */
+	unsigned int cleanup_mode;	/* How pages should be cleaned up (0/FOLL_GET/PIN) */
 	union {
 		struct page *pages[DIO_PAGES];	/* page buffer */
 		struct work_struct complete_work;/* deferred AIO completion */
@@ -167,12 +169,13 @@ static inline unsigned dio_pages_present(struct dio_submit *sdio)
 static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 {
 	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
+	unsigned int gup_flags =
+		op_is_write(dio_op) ? FOLL_SOURCE_BUF : FOLL_DEST_BUF;
+	struct page **pages = dio->pages;
 	ssize_t ret;
 
-	ret = iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
-				 &sdio->from,
-				 op_is_write(dio_op) ?
-				 FOLL_SOURCE_BUF : FOLL_DEST_BUF);
+	ret = iov_iter_extract_pages(sdio->iter, &pages, LONG_MAX, DIO_PAGES,
+				     gup_flags, &sdio->from);
 
 	if (ret < 0 && sdio->blocks_available && dio_op == REQ_OP_WRITE) {
 		struct page *page = ZERO_PAGE(0);
@@ -183,7 +186,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		 */
 		if (dio->page_errors == 0)
 			dio->page_errors = ret;
-		get_page(page);
+		dio->cleanup_mode = 0;
 		dio->pages[0] = page;
 		sdio->head = 0;
 		sdio->tail = 1;
@@ -197,6 +200,8 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		sdio->head = 0;
 		sdio->tail = (ret + PAGE_SIZE - 1) / PAGE_SIZE;
 		sdio->to = ((ret - 1) & (PAGE_SIZE - 1)) + 1;
+		dio->cleanup_mode =
+			iov_iter_extract_mode(sdio->iter, gup_flags);
 		return 0;
 	}
 	return ret;	
@@ -400,6 +405,10 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	 * we request a valid number of vectors.
 	 */
 	bio = bio_alloc(bdev, nr_vecs, dio->opf, GFP_KERNEL);
+	if (!(dio->cleanup_mode & FOLL_GET))
+		bio_clear_flag(bio, BIO_PAGE_REFFED);
+	if (dio->cleanup_mode & FOLL_PIN)
+		bio_set_flag(bio, BIO_PAGE_PINNED);
 	bio->bi_iter.bi_sector = first_sector;
 	if (dio->is_async)
 		bio->bi_end_io = dio_bio_end_aio;
@@ -443,13 +452,18 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 	sdio->logical_offset_in_bio = 0;
 }
 
+static void dio_cleanup_page(struct dio *dio, struct page *page)
+{
+	page_put_unpin(page, dio->cleanup_mode);
+}
+
 /*
  * Release any resources in case of a failure
  */
 static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
 {
 	while (sdio->head < sdio->tail)
-		put_page(dio->pages[sdio->head++]);
+		dio_cleanup_page(dio, dio->pages[sdio->head++]);
 }
 
 /*
@@ -704,7 +718,7 @@ static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
  *
  * Return zero on success.  Non-zero means the caller needs to start a new BIO.
  */
-static inline int dio_bio_add_page(struct dio_submit *sdio)
+static inline int dio_bio_add_page(struct dio *dio, struct dio_submit *sdio)
 {
 	int ret;
 
@@ -771,11 +785,11 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
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
@@ -832,13 +846,16 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 	 */
 	if (sdio->cur_page) {
 		ret = dio_send_cur_page(dio, sdio, map_bh);
-		put_page(sdio->cur_page);
+		dio_cleanup_page(dio, sdio->cur_page);
 		sdio->cur_page = NULL;
 		if (ret)
 			return ret;
 	}
 
-	get_page(page);		/* It is in dio */
+	ret = try_grab_page(page, dio->cleanup_mode);		/* It is in dio */
+	if (ret < 0)
+		return ret;
+
 	sdio->cur_page = page;
 	sdio->cur_page_offset = offset;
 	sdio->cur_page_len = len;
@@ -853,7 +870,7 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 		ret = dio_send_cur_page(dio, sdio, map_bh);
 		if (sdio->bio)
 			dio_bio_submit(dio, sdio);
-		put_page(sdio->cur_page);
+		dio_cleanup_page(dio, sdio->cur_page);
 		sdio->cur_page = NULL;
 	}
 	return ret;
@@ -954,7 +971,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				ret = get_more_blocks(dio, sdio, map_bh);
 				if (ret) {
-					put_page(page);
+					dio_cleanup_page(dio, page);
 					goto out;
 				}
 				if (!buffer_mapped(map_bh))
@@ -999,7 +1016,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				/* AKPM: eargh, -ENOTBLK is a hack */
 				if (dio_op == REQ_OP_WRITE) {
-					put_page(page);
+					dio_cleanup_page(dio, page);
 					return -ENOTBLK;
 				}
 
@@ -1012,7 +1029,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 				if (sdio->block_in_file >=
 						i_size_aligned >> blkbits) {
 					/* We hit eof */
-					put_page(page);
+					dio_cleanup_page(dio, page);
 					goto out;
 				}
 				zero_user(page, from, 1 << blkbits);
@@ -1052,7 +1069,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 						  sdio->next_block_for_io,
 						  map_bh);
 			if (ret) {
-				put_page(page);
+				dio_cleanup_page(dio, page);
 				goto out;
 			}
 			sdio->next_block_for_io += this_chunk_blocks;
@@ -1068,7 +1085,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 		}
 
 		/* Drop the ref which was taken in get_user_pages() */
-		put_page(page);
+		dio_cleanup_page(dio, page);
 	}
 out:
 	return ret;
@@ -1288,7 +1305,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		ret2 = dio_send_cur_page(dio, &sdio, &map_bh);
 		if (retval == 0)
 			retval = ret2;
-		put_page(sdio.cur_page);
+		dio_cleanup_page(dio, sdio.cur_page);
 		sdio.cur_page = NULL;
 	}
 	if (sdio.bio)


