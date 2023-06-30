Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9A743EDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjF3P2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF3P1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77274208
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3QvI++UbaCvzRYqDPfp6daxW4hAI54iCb+OZBSflyU=;
        b=GmU3Ty7NKBX1tJ9Ht/2Z5ByCIHyKeacZgUV+wdpdydszBGjYLF0KQuVwkn1ug0vm/8Qvcw
        EB94JGCMaTSbF9FckupFw/mzHbL7ZjA4VUsMgTGPvPG3zutxu4YCW0eQLzh3CtJNce91ed
        V/oP4hJjlALr5N2H8dgLgnSJnZLbYJY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-lk4SxSCmM8ygJqJYozNQNg-1; Fri, 30 Jun 2023 11:25:56 -0400
X-MC-Unique: lk4SxSCmM8ygJqJYozNQNg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F085D3C0F39A;
        Fri, 30 Jun 2023 15:25:55 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9061D48FB01;
        Fri, 30 Jun 2023 15:25:52 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: [RFC PATCH 09/11] iov_iter: Use I/O dir flags with iov_iter_extract_pages()
Date:   Fri, 30 Jun 2023 16:25:22 +0100
Message-ID: <20230630152524.661208-10-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define flags to pass into iov_iter_extract_pages() to indicate I/O
direction.  A warning is issued and the function fails if neither or both
flags are set.  The flag is also checked against the iterator's data_source
flag.

Also make extract_iter_to_sg() check the flags and propagate them to
iov_iter_extract_pages().

Finally, make the callers pass the flags into iov_iter_extract_pages() and
extract_iter_to_sg().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-crypto@vger.kernel.org
---
 block/bio.c         |  6 ++++++
 block/blk-map.c     |  3 +++
 crypto/af_alg.c     |  5 +++--
 crypto/algif_hash.c |  3 ++-
 fs/direct-io.c      |  6 +++++-
 include/linux/bio.h | 18 ++++++++++++++++--
 include/linux/uio.h |  5 ++++-
 lib/iov_iter.c      | 12 ++++++++++--
 lib/scatterlist.c   | 12 ++++++++++--
 9 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8672179213b9..440d4889ba13 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1242,6 +1242,8 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
  * will have to be cleaned up in the way indicated by the BIO_PAGE_PINNED flag.
  * For a multi-segment *iter, this function only adds pages from the next
  * non-empty segment of the iov iterator.
+ *
+ * The I/O direction is determined from the bio operation type.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1263,6 +1265,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
+	extraction_flags |= bio_is_write(bio) ? WRITE_FROM_ITER : READ_INTO_ITER;
+
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		extraction_flags |= ITER_ALLOW_P2PDMA;
 
@@ -1332,6 +1336,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
  * fit into the bio, or are requested in @iter, whatever is smaller. If
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
+ *
+ * The bio operation indicates the data direction.
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
diff --git a/block/blk-map.c b/block/blk-map.c
index f8fe114ae433..71de2cf9bf4e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -279,6 +279,9 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (bio == NULL)
 		return -ENOMEM;
 
+	extraction_flags |=
+		bio_is_write(bio) ? WRITE_FROM_ITER : READ_INTO_ITER;
+
 	if (blk_queue_pci_p2pdma(rq->q))
 		extraction_flags |= ITER_ALLOW_P2PDMA;
 	if (iov_iter_extract_will_pin(iter))
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 6218c773d71c..c62ac5e32aeb 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1042,7 +1042,8 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			};
 
 			plen = extract_iter_to_sg(&msg->msg_iter, len, &sgtable,
-						  MAX_SGL_ENTS - sgl->cur, 0);
+						  MAX_SGL_ENTS - sgl->cur,
+						  WRITE_FROM_ITER);
 			if (plen < 0) {
 				err = plen;
 				goto unlock;
@@ -1247,7 +1248,7 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 
 		sg_init_table(rsgl->sgl.sgt.sgl, ALG_MAX_PAGES);
 		err = extract_iter_to_sg(&msg->msg_iter, seglen, &rsgl->sgl.sgt,
-					 ALG_MAX_PAGES, 0);
+					 ALG_MAX_PAGES, READ_INTO_ITER);
 		if (err < 0) {
 			rsgl->sg_num_bytes = 0;
 			return err;
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 0ab43e149f0e..b343c4973dbf 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -115,7 +115,8 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
 		ctx->sgl.need_unpin = iov_iter_extract_will_pin(&msg->msg_iter);
 
 		err = extract_iter_to_sg(&msg->msg_iter, LONG_MAX,
-					 &ctx->sgl.sgt, npages, 0);
+					 &ctx->sgl.sgt, npages,
+					 WRITE_FROM_ITER);
 		if (err < 0)
 			goto unlock_free;
 		len = err;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 2b517cc5b32d..3316d2f8f21c 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -168,10 +168,14 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 {
 	struct page **pages = dio->pages;
 	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
+	unsigned int extraction_flags;
 	ssize_t ret;
 
+	extraction_flags =
+		op_is_write(dio_op) ? WRITE_FROM_ITER : READ_INTO_ITER;
+
 	ret = iov_iter_extract_pages(sdio->iter, &pages, LONG_MAX,
-				     DIO_PAGES, 0, &sdio->from);
+				     DIO_PAGES, extraction_flags, &sdio->from);
 
 	if (ret < 0 && sdio->blocks_available && dio_op == REQ_OP_WRITE) {
 		/*
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c4f5b5228105..d4b4c477e69b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -42,11 +42,25 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 #define bio_sectors(bio)	bvec_iter_sectors((bio)->bi_iter)
 #define bio_end_sector(bio)	bvec_iter_end_sector((bio)->bi_iter)
 
+/**
+ * bio_is_write - Query if the I/O direction is towards the disk
+ * @bio: The bio to query
+ *
+ * Return true if this is some sort of write operation - ie. the data is going
+ * towards the disk.
+ */
+static inline bool bio_is_write(const struct bio *bio)
+{
+	return op_is_write(bio_op(bio));
+}
+
 /*
  * Return the data direction, READ or WRITE.
  */
-#define bio_data_dir(bio) \
-	(op_is_write(bio_op(bio)) ? WRITE : READ)
+static inline int bio_data_dir(const struct bio *bio)
+{
+	return bio_is_write(bio) ? WRITE : READ;
+}
 
 /*
  * Check whether this bio carries any data or not. A NULL bio is allowed.
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 70e12f536f8f..6ea7c1b589c1 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -379,8 +379,11 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	};
 }
 /* Flags for iov_iter_get/extract_pages*() */
+/* Indicate if we are going to be writing from the buffer or reading into it. */
+#define WRITE_FROM_ITER		((__force iov_iter_extraction_t)0x01) // == WRITE
+#define READ_INTO_ITER		((__force iov_iter_extraction_t)0x02)
 /* Allow P2PDMA on the extracted pages */
-#define ITER_ALLOW_P2PDMA	((__force iov_iter_extraction_t)0x01)
+#define ITER_ALLOW_P2PDMA	((__force iov_iter_extraction_t)0x04)
 
 ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
 			       size_t maxsize, unsigned int maxpages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b8c52231a6ff..d31f40b69da5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1791,8 +1791,10 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
  * that the caller allocated a page list at least @maxpages in size and this
  * will be filled in.
  *
- * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA
- * be allowed on the pages extracted.
+ * @extraction_flags should have either WRITE_FROM_ITER or READ_INTO_ITER to
+ * indicate the direction the data is intended to flow to/from the buffer and
+ * can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be allowed on the
+ * pages extracted.
  *
  * The iov_iter_extract_will_pin() function can be used to query how cleanup
  * should be performed.
@@ -1823,6 +1825,12 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 			       iov_iter_extraction_t extraction_flags,
 			       size_t *offset0)
 {
+	unsigned int dir = extraction_flags & (READ_INTO_ITER | WRITE_FROM_ITER);
+
+	if (WARN_ON_ONCE(dir != READ_INTO_ITER && dir != WRITE_FROM_ITER) ||
+	    WARN_ON_ONCE((dir & WRITE) != i->data_source))
+		return -EFAULT;
+
 	maxsize = min_t(size_t, min_t(size_t, maxsize, i->count), MAX_RW_COUNT);
 	if (!maxsize)
 		return 0;
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e97d7060329e..116ce320eb36 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1326,8 +1326,10 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
  *
  * No end mark is placed on the scatterlist; that's left to the caller.
  *
- * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA
- * be allowed on the pages extracted.
+ * @extraction_flags should have either WRITE_FROM_ITER or READ_INTO_ITER to
+ * indicate the direction the data is intended to flow to/from the buffer and
+ * can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be allowed on the
+ * pages extracted.
  *
  * If successful, @sgtable->nents is updated to include the number of elements
  * added and the number of bytes added is returned.  @sgtable->orig_nents is
@@ -1340,6 +1342,12 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
 			   struct sg_table *sgtable, unsigned int sg_max,
 			   iov_iter_extraction_t extraction_flags)
 {
+	unsigned int dir = extraction_flags & (READ_INTO_ITER | WRITE_FROM_ITER);
+
+	if (WARN_ON_ONCE(dir != READ_INTO_ITER && dir != WRITE_FROM_ITER) ||
+	    WARN_ON_ONCE((dir & WRITE) != iter->data_source))
+		return -EFAULT;
+
 	if (maxsize == 0)
 		return 0;
 

