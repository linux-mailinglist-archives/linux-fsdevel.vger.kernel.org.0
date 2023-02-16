Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B9699F31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBPVtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPVtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA5F41B54
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQdifRk6LoRlY8bBJqWjSiNz8KoUNxlUmZ1XJ6Y/O6c=;
        b=Anktt0syfY83u4a0xf9kNHlmevDTERd8pim1uVTCED8YSR/XhdjgqL29Sc1FLdLci1EWG2
        XGoMPx94qks9mZaMMFxjcybu/CakUK+NCvjrMU01QtKuGT0ZPE52REayl1ds173oYalwEl
        D3DZOw+n8Sjkl6Da2O0pcn+FBSGihEQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-TZxIysogMpWNukeCTYhZIA-1; Thu, 16 Feb 2023 16:48:19 -0500
X-MC-Unique: TZxIysogMpWNukeCTYhZIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DF2F3C10146;
        Thu, 16 Feb 2023 21:48:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6ECD1121314;
        Thu, 16 Feb 2023 21:48:16 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 04/17] iov_iter: Define flags to qualify page extraction.
Date:   Thu, 16 Feb 2023 21:47:32 +0000
Message-Id: <20230216214745.3985496-5-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define flags to qualify page extraction to pass into iov_iter_*_pages*()
rather than passing in FOLL_* flags.

For now only a flag to allow peer-to-peer DMA is supported.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
---
 block/bio.c         |  6 +++---
 block/blk-map.c     |  8 ++++----
 include/linux/uio.h | 10 ++++++++--
 lib/iov_iter.c      | 14 ++++++++------
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ab59a491a883..b97f3991c904 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1245,11 +1245,11 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
+	iov_iter_extraction_t extraction_flags = 0;
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
-	unsigned int gup_flags = 0;
 	ssize_t size, left;
 	unsigned len, i = 0;
 	size_t offset, trim;
@@ -1264,7 +1264,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
-		gup_flags |= FOLL_PCI_P2PDMA;
+		extraction_flags |= ITER_ALLOW_P2PDMA;
 
 	/*
 	 * Each segment in the iov is required to be a block size multiple.
@@ -1275,7 +1275,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 */
 	size = iov_iter_get_pages(iter, pages,
 				  UINT_MAX - bio->bi_iter.bi_size,
-				  nr_pages, &offset, gup_flags);
+				  nr_pages, &offset, extraction_flags);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
diff --git a/block/blk-map.c b/block/blk-map.c
index 19940c978c73..080dd60485be 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -265,9 +265,9 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		gfp_t gfp_mask)
 {
+	iov_iter_extraction_t extraction_flags = 0;
 	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
 	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
-	unsigned int gup_flags = 0;
 	struct bio *bio;
 	int ret;
 	int j;
@@ -280,7 +280,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		return -ENOMEM;
 
 	if (blk_queue_pci_p2pdma(rq->q))
-		gup_flags |= FOLL_PCI_P2PDMA;
+		extraction_flags |= ITER_ALLOW_P2PDMA;
 
 	while (iov_iter_count(iter)) {
 		struct page **pages, *stack_pages[UIO_FASTIOV];
@@ -291,10 +291,10 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
 			pages = stack_pages;
 			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
-						   nr_vecs, &offs, gup_flags);
+						   nr_vecs, &offs, extraction_flags);
 		} else {
 			bytes = iov_iter_get_pages_alloc(iter, &pages,
-						LONG_MAX, &offs, gup_flags);
+						LONG_MAX, &offs, extraction_flags);
 		}
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 9f158238edba..eec6ed8a627a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -13,6 +13,8 @@
 struct page;
 struct pipe_inode_info;
 
+typedef unsigned int __bitwise iov_iter_extraction_t;
+
 struct kvec {
 	void *iov_base; /* and that should *never* hold a userland pointer */
 	size_t iov_len;
@@ -252,12 +254,12 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 		size_t maxsize, unsigned maxpages, size_t *start,
-		unsigned gup_flags);
+		iov_iter_extraction_t extraction_flags);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		struct page ***pages, size_t maxsize, size_t *start,
-		unsigned gup_flags);
+		iov_iter_extraction_t extraction_flags);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
@@ -360,4 +362,8 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	};
 }
 
+/* Flags for iov_iter_get/extract_pages*() */
+/* Allow P2PDMA on the extracted pages */
+#define ITER_ALLOW_P2PDMA	((__force iov_iter_extraction_t)0x01)
+
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 47c484551c59..9d4949ea9b27 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1426,9 +1426,9 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   unsigned int maxpages, size_t *start,
-		   unsigned int gup_flags)
+		   iov_iter_extraction_t extraction_flags)
 {
-	unsigned int n;
+	unsigned int n, gup_flags = 0;
 
 	if (maxsize > i->count)
 		maxsize = i->count;
@@ -1436,6 +1436,8 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		return 0;
 	if (maxsize > MAX_RW_COUNT)
 		maxsize = MAX_RW_COUNT;
+	if (extraction_flags & ITER_ALLOW_P2PDMA)
+		gup_flags |= FOLL_PCI_P2PDMA;
 
 	if (likely(user_backed_iter(i))) {
 		unsigned long addr;
@@ -1489,14 +1491,14 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 
 ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start, unsigned gup_flags)
+		   size_t *start, iov_iter_extraction_t extraction_flags)
 {
 	if (!maxpages)
 		return 0;
 	BUG_ON(!pages);
 
 	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
-					  start, gup_flags);
+					  start, extraction_flags);
 }
 EXPORT_SYMBOL_GPL(iov_iter_get_pages);
 
@@ -1509,14 +1511,14 @@ EXPORT_SYMBOL(iov_iter_get_pages2);
 
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   size_t *start, unsigned gup_flags)
+		   size_t *start, iov_iter_extraction_t extraction_flags)
 {
 	ssize_t len;
 
 	*pages = NULL;
 
 	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
-					 gup_flags);
+					 extraction_flags);
 	if (len <= 0) {
 		kvfree(*pages);
 		*pages = NULL;

