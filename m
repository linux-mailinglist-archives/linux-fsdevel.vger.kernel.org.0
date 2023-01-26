Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3634967C8A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 11:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbjAZKep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 05:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbjAZKej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074115619C
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674729239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqDrgvW0/XSyvREeFRhVWr1s+J3PuS70wJQAmFfHvFE=;
        b=bf1Arg5/mx2e8hhclxNPdlIlIJQ49Cl3Kt8Sd4ea4dfbzel4QisYzOhJs09PKHGzd68rQj
        IZaZn/EApNooMxx07nxN+0b9+vwW65SlO0xa1yW2hJixJObdhmVAfZrVde3daq4sGKnTls
        paFyDO6Jn8fverwP+F37ho3p+RxC00w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-vC3dEYFRPuSe4qxu2tWBmA-1; Thu, 26 Jan 2023 05:33:54 -0500
X-MC-Unique: vC3dEYFRPuSe4qxu2tWBmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DD55801779;
        Thu, 26 Jan 2023 10:33:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E2E2492C14;
        Thu, 26 Jan 2023 10:33:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com>
References: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com> <af0e448a-9559-32c0-cc59-10b159459495@redhat.com> <20230125210657.2335748-1-dhowells@redhat.com> <20230125210657.2335748-2-dhowells@redhat.com> <2613249.1674726566@warthog.procyon.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] iov_iter: Use __bitwise with the extraction_flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2638927.1674729230.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 26 Jan 2023 10:33:50 +0000
Message-ID: <2638928.1674729230@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

X-Mailer: MH-E 8.6+git; nmh 1.7.1; GNU Emacs 28.2
--------
David Hildenbrand <david@redhat.com> wrote:

> >> Just a note that the usage of new __bitwise types instead of "unsigne=
d" is
> >> encouraged for flags.

Something like the attached?

> $ git grep "typedef int" | grep __bitwise | wc -l
> 27
> $ git grep "typedef unsigned" | grep __bitwise | wc -l
> 23

git grep __bitwise | grep typedef | grep __u | wc -l
62

*shrug*

Interestingly, things like __be32 are __bitwise.  I wonder if that actuall=
y
makes sense or if it was just convenient so stop people doing arithmetic o=
n
them.  I guess doing AND/OR/XOR on them isn't a problem provided both
arguments are appropriately byte-swapped.

David
---
 block/bio.c         |    2 +-
 block/blk-map.c     |    2 +-
 include/linux/uio.h |   13 ++++++++-----
 lib/iov_iter.c      |   14 +++++++-------
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 466956779d2c..fc57f0aa098e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1244,11 +1244,11 @@ static int bio_iov_add_zone_append_page(struct bio=
 *bio, struct page *page,
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *ite=
r)
 {
+	iov_iter_extraction_t extraction_flags =3D 0;
 	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
-	unsigned int extraction_flags =3D 0;
 	ssize_t size, left;
 	unsigned len, i =3D 0;
 	size_t offset, trim;
diff --git a/block/blk-map.c b/block/blk-map.c
index 9c7ccea3f334..0f1593e144da 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -265,9 +265,9 @@ static struct bio *blk_rq_map_bio_alloc(struct request=
 *rq,
 static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		gfp_t gfp_mask)
 {
+	iov_iter_extraction_t extraction_flags =3D 0;
 	unsigned int max_sectors =3D queue_max_hw_sectors(rq->q);
 	unsigned int nr_vecs =3D iov_iter_npages(iter, BIO_MAX_VECS);
-	unsigned int extraction_flags =3D 0;
 	struct bio *bio;
 	int ret;
 	int j;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 47ebb59a0202..b1be128bb2fa 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -13,6 +13,8 @@
 struct page;
 struct pipe_inode_info;
 =

+typedef unsigned int iov_iter_extraction_t;
+
 struct kvec {
 	void *iov_base; /* and that should *never* hold a userland pointer */
 	size_t iov_len;
@@ -252,12 +254,12 @@ void iov_iter_xarray(struct iov_iter *i, unsigned in=
t direction, struct xarray *
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 		size_t maxsize, unsigned maxpages, size_t *start,
-		unsigned extraction_flags);
+		iov_iter_extraction_t extraction_flags);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		struct page ***pages, size_t maxsize, size_t *start,
-		unsigned extraction_flags);
+		iov_iter_extraction_t extraction_flags);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***page=
s,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
@@ -359,13 +361,14 @@ static inline void iov_iter_ubuf(struct iov_iter *i,=
 unsigned int direction,
 		.count =3D count
 	};
 }
-
 /* Flags for iov_iter_get/extract_pages*() */
-#define ITER_ALLOW_P2PDMA	0x01	/* Allow P2PDMA on the extracted pages */
+/* Allow P2PDMA on the extracted pages */
+#define ITER_ALLOW_P2PDMA	((__force iov_iter_extraction_t)0x01)
 =

 ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
 			       size_t maxsize, unsigned int maxpages,
-			       unsigned int extraction_flags, size_t *offset0);
+			       iov_iter_extraction_t extraction_flags,
+			       size_t *offset0);
 =

 /**
  * iov_iter_extract_will_pin - Indicate how pages from the iterator will =
be retained
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index cea503b2ec30..d70496019b1d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1432,7 +1432,7 @@ static struct page *first_bvec_segment(const struct =
iov_iter *i,
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   unsigned int maxpages, size_t *start,
-		   unsigned int extraction_flags)
+		   iov_iter_extraction_t extraction_flags)
 {
 	unsigned int n, gup_flags =3D 0;
 =

@@ -1929,7 +1929,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov=
_iter_state *state)
 static ssize_t iov_iter_extract_pipe_pages(struct iov_iter *i,
 					   struct page ***pages, size_t maxsize,
 					   unsigned int maxpages,
-					   unsigned int extraction_flags,
+					   iov_iter_extraction_t extraction_flags,
 					   size_t *offset0)
 {
 	unsigned int nr, offset, chunk, j;
@@ -1971,7 +1971,7 @@ static ssize_t iov_iter_extract_pipe_pages(struct io=
v_iter *i,
 static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 					     struct page ***pages, size_t maxsize,
 					     unsigned int maxpages,
-					     unsigned int extraction_flags,
+					     iov_iter_extraction_t extraction_flags,
 					     size_t *offset0)
 {
 	struct page *page, **p;
@@ -2017,7 +2017,7 @@ static ssize_t iov_iter_extract_xarray_pages(struct =
iov_iter *i,
 static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 					   struct page ***pages, size_t maxsize,
 					   unsigned int maxpages,
-					   unsigned int extraction_flags,
+					   iov_iter_extraction_t extraction_flags,
 					   size_t *offset0)
 {
 	struct page **p, *page;
@@ -2060,7 +2060,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct io=
v_iter *i,
 static ssize_t iov_iter_extract_kvec_pages(struct iov_iter *i,
 					   struct page ***pages, size_t maxsize,
 					   unsigned int maxpages,
-					   unsigned int extraction_flags,
+					   iov_iter_extraction_t extraction_flags,
 					   size_t *offset0)
 {
 	struct page **p, *page;
@@ -2125,7 +2125,7 @@ static ssize_t iov_iter_extract_user_pages(struct io=
v_iter *i,
 					   struct page ***pages,
 					   size_t maxsize,
 					   unsigned int maxpages,
-					   unsigned int extraction_flags,
+					   iov_iter_extraction_t extraction_flags,
 					   size_t *offset0)
 {
 	unsigned long addr;
@@ -2207,7 +2207,7 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 			       struct page ***pages,
 			       size_t maxsize,
 			       unsigned int maxpages,
-			       unsigned int extraction_flags,
+			       iov_iter_extraction_t extraction_flags,
 			       size_t *offset0)
 {
 	maxsize =3D min_t(size_t, min_t(size_t, maxsize, i->count), MAX_RW_COUNT=
);

