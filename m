Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609F5709105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjESHwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjESHwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C010F0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeaCD2UlGOxbB6KCWNh7uHI2oUW1y45K4W4A/6wlL3s=;
        b=aPC7ZJ4cco+T4l6XvkCmEMV8K/5Z0dJx5F02IBP/i9UnjGMGLNLJr8sX8q16MefxjE/4AR
        uSY9aZPxBtSqyu2W9MCK4PHt52lHfYWkgzIIEmG7M1LIHe90aO6skNqsugNqHKHFtg3DhI
        ljlEM7hwC5CwB1OBeHkAITrS0D9UZ9g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-oXYVwhe6PISPwOFbVlp0Kg-1; Fri, 19 May 2023 03:49:21 -0400
X-MC-Unique: oXYVwhe6PISPwOFbVlp0Kg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E867B2999B22;
        Fri, 19 May 2023 07:49:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97D5B4F2DE0;
        Fri, 19 May 2023 07:49:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] iov_iter: Add automatic-alloc for ITER_BVEC and use in direct_splice_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1740263.1684482558.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 19 May 2023 08:49:18 +0100
Message-ID: <1740264.1684482558@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If it's a problem that direct_splice_read() always allocates as much memor=
y as
is asked for and that will fit into the pipe when less could be allocated =
in
the case that, say, an O_DIRECT-read will hit a hole and do a short read o=
r a
socket will return less than was asked for, something like the attached
modification to ITER_BVEC could be made.

David
---
iov_iter: Add automatic-alloc for ITER_BVEC and use in direct_splice_read(=
)

Add a flag to the iov_iter struct that tells things that write to or allow
writing to a BVEC-type iterator that they should allocate pages to fill in
any slots in the bio_vec array that have null page pointers.  This allows
the bufferage in the bvec to be allocated on-demand.

Iterators of this type are initialised with iov_iter_bvec_autoalloc()
instead of iov_iter_bvec().  Only destination (ie. READ/ITER_DEST)
iterators may be used in this fashion.

An additional function, iov_iter_auto_alloc() is provided to perform the
allocation in the case that the caller wishes to make use of the bio_vec
array directly and the block layer is modified to use it.

direct_splice_read() is then modified to make use of this.  This is less
efficient if we know in advance that we want to allocate the full buffer a=
s
we can't so easily use bulk allocation, but it does mean in cases where we
might not want the full buffer (say we hit a hole in DIO), we don't have t=
o
allocate it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 block/bio.c         |    2 =

 fs/splice.c         |   36 ++++++-----------
 include/linux/uio.h |   13 ++++--
 lib/iov_iter.c      |  110 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 4 files changed, 133 insertions(+), 28 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 798cc4cf3bd2..72d5c1125df2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1330,6 +1330,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct i=
ov_iter *iter)
 	int ret =3D 0;
 =

 	if (iov_iter_is_bvec(iter)) {
+		if (!iov_iter_auto_alloc(iter, iov_iter_count(iter)))
+			return -ENOMEM;
 		bio_iov_bvec_set(bio, iter);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 		return 0;
diff --git a/fs/splice.c b/fs/splice.c
index 56d9802729d0..30e7a31c5ada 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -310,10 +310,8 @@ ssize_t direct_splice_read(struct file *in, loff_t *p=
pos,
 	struct iov_iter to;
 	struct bio_vec *bv;
 	struct kiocb kiocb;
-	struct page **pages;
 	ssize_t ret;
-	size_t used, npages, chunk, remain, keep =3D 0;
-	int i;
+	size_t used, npages, chunk, remain, keep =3D 0, i;
 =

 	if (!len)
 		return 0;
@@ -334,30 +332,14 @@ ssize_t direct_splice_read(struct file *in, loff_t *=
ppos,
 	len =3D min_t(size_t, len, npages * PAGE_SIZE);
 	npages =3D DIV_ROUND_UP(len, PAGE_SIZE);
 =

-	bv =3D kzalloc(array_size(npages, sizeof(bv[0])) +
-		     array_size(npages, sizeof(struct page *)), GFP_KERNEL);
+	bv =3D kzalloc(array_size(npages, sizeof(bv[0])), GFP_KERNEL);
 	if (!bv)
 		return -ENOMEM;
 =

-	pages =3D (struct page **)(bv + npages);
-	npages =3D alloc_pages_bulk_array(GFP_USER, npages, pages);
-	if (!npages) {
-		kfree(bv);
-		return -ENOMEM;
-	}
-
 	remain =3D len =3D min_t(size_t, len, npages * PAGE_SIZE);
 =

-	for (i =3D 0; i < npages; i++) {
-		chunk =3D min_t(size_t, PAGE_SIZE, remain);
-		bv[i].bv_page =3D pages[i];
-		bv[i].bv_offset =3D 0;
-		bv[i].bv_len =3D chunk;
-		remain -=3D chunk;
-	}
-
 	/* Do the I/O */
-	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
+	iov_iter_bvec_autoalloc(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos =3D *ppos;
 	ret =3D call_read_iter(in, &kiocb, &to);
@@ -376,8 +358,16 @@ ssize_t direct_splice_read(struct file *in, loff_t *p=
pos,
 	}
 =

 	/* Free any pages that didn't get touched at all. */
-	if (keep < npages)
-		release_pages(pages + keep, npages - keep);
+	if (keep < npages) {
+		struct page **pages =3D (struct page **)&bv[keep];
+		size_t j =3D 0;
+
+		for (i =3D keep; i < npages; i++)
+			if (bv[i].bv_page)
+				pages[j++] =3D bv[i].bv_page;
+		if (j)
+			release_pages(pages, j);
+	}
 =

 	/* Push the remaining pages into the pipe. */
 	remain =3D ret;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 60c342bb7ab8..6bc2287021d9 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -40,10 +40,11 @@ struct iov_iter_state {
 =

 struct iov_iter {
 	u8 iter_type;
-	bool copy_mc;
-	bool nofault;
-	bool data_source;
-	bool user_backed;
+	bool copy_mc:1;
+	bool nofault:1;
+	bool data_source:1;
+	bool user_backed:1;
+	bool auto_alloc:1;	/* Automatically alloc pages into a bvec */
 	union {
 		size_t iov_offset;
 		int last_offset;
@@ -263,6 +264,7 @@ static inline bool iov_iter_is_copy_mc(const struct io=
v_iter *i)
 }
 #endif
 =

+bool iov_iter_auto_alloc(struct iov_iter *iter, size_t count);
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
 bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
 			unsigned len_mask);
@@ -274,6 +276,9 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int di=
rection, const struct kvec
 			unsigned long nr_segs, size_t count);
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const stru=
ct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
+void iov_iter_bvec_autoalloc(struct iov_iter *i, unsigned int direction,
+			     const struct bio_vec *bvec, unsigned long nr_segs,
+			     size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t =
count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct x=
array *xarray,
 		     loff_t start, size_t count);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f18138e0292a..3643f9d80ecc 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -52,7 +52,11 @@
 	while (n) {						\
 		unsigned offset =3D p->bv_offset + skip;		\
 		unsigned left;					\
-		void *kaddr =3D kmap_local_page(p->bv_page +	\
+		void *kaddr;					\
+								\
+		if (!p->bv_page)				\
+			break;					\
+		kaddr =3D kmap_local_page(p->bv_page +		\
 					offset / PAGE_SIZE);	\
 		base =3D kaddr + offset % PAGE_SIZE;		\
 		len =3D min(min(n, (size_t)(p->bv_len - skip)),	\
@@ -159,6 +163,49 @@ __out:								\
 #define iterate_and_advance(i, n, base, len, off, I, K) \
 	__iterate_and_advance(i, n, base, len, off, I, ((void)(K),0))
 =

+/*
+ * Preallocate pages into the bvec sufficient to store count bytes.
+ */
+static bool bvec_auto_alloc(struct iov_iter *iter, size_t count)
+{
+	struct bio_vec *bvec =3D (struct bio_vec *)iter->bvec;
+	int j;
+
+	if (!count)
+		return true;
+
+	count +=3D iter->iov_offset;
+	for (j =3D 0; j < iter->nr_segs; j++) {
+		if (!bvec[j].bv_page) {
+			bvec[j].bv_page =3D alloc_page(GFP_KERNEL);
+			if (!bvec[j].bv_page)
+				return false;
+		}
+		if (bvec[j].bv_len >=3D count)
+			break;
+		count -=3D bvec[j].bv_len;
+	}
+
+	return true;
+}
+
+/**
+ * iov_iter_auto_alloc - Perform auto-alloc for an iterator
+ * @iter: The iterator to do the allocation for
+ * @count: The number of bytes we need to store
+ *
+ * Perform auto-allocation on a iterator.  This only works with ITER_BVEC=
-type
+ * iterators.  It will make sure that pages are allocated sufficient to s=
tore
+ * the specified number of bytes.  Returns true if sufficient pages are p=
resent
+ * in the bvec and false if an allocation failure occurs.
+ */
+bool iov_iter_auto_alloc(struct iov_iter *iter, size_t count)
+{
+	return !iov_iter_is_bvec(iter) || !iter->auto_alloc ||
+		bvec_auto_alloc(iter, count);
+}
+EXPORT_SYMBOL_GPL(iov_iter_auto_alloc);
+
 static int copyout(void __user *to, const void *from, size_t n)
 {
 	if (should_fail_usercopy())
@@ -313,6 +360,8 @@ size_t _copy_to_iter(const void *addr, size_t bytes, s=
truct iov_iter *i)
 		return 0;
 	if (user_backed_iter(i))
 		might_fault();
+	if (!iov_iter_auto_alloc(i, bytes))
+		return 0;
 	iterate_and_advance(i, bytes, base, len, off,
 		copyout(base, addr + off, len),
 		memcpy(base, addr + off, len)
@@ -362,6 +411,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes=
, struct iov_iter *i)
 		return 0;
 	if (user_backed_iter(i))
 		might_fault();
+	if (!iov_iter_auto_alloc(i, bytes))
+		return 0;
 	__iterate_and_advance(i, bytes, base, len, off,
 		copyout_mc(base, addr + off, len),
 		copy_mc_to_kernel(base, addr + off, len)
@@ -503,6 +554,8 @@ size_t copy_page_to_iter_nofault(struct page *page, un=
signed offset, size_t byte
 		return 0;
 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
+	if (!iov_iter_auto_alloc(i, bytes))
+		return 0;
 	page +=3D offset / PAGE_SIZE; // first subpage
 	offset %=3D PAGE_SIZE;
 	while (1) {
@@ -557,6 +610,8 @@ EXPORT_SYMBOL(copy_page_from_iter);
 =

 size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 {
+	if (!iov_iter_auto_alloc(i, bytes))
+		return -ENOMEM;
 	iterate_and_advance(i, bytes, base, len, count,
 		clear_user(base, len),
 		memset(base, 0, len)
@@ -598,6 +653,7 @@ static void iov_iter_bvec_advance(struct iov_iter *i, =
size_t size)
 	size +=3D i->iov_offset;
 =

 	for (bvec =3D i->bvec, end =3D bvec + i->nr_segs; bvec < end; bvec++) {
+		BUG_ON(!bvec->bv_page);
 		if (likely(size < bvec->bv_len))
 			break;
 		size -=3D bvec->bv_len;
@@ -740,6 +796,51 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int d=
irection,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 =

+/**
+ * iov_iter_bvec_autoalloc - Initialise a BVEC-type I/O iterator with aut=
omatic alloc
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @bvec: The array of bio_vecs listing the buffer segments
+ * @nr_segs: The number of segments in @bvec[].
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator to insert pages into a bvec as data is written =
into
+ * it where NULL pointers exist in the bvec array (if a pointer isn't NUL=
L, the
+ * page it points to will just be used).  No more than @nr_segs pages wil=
l be
+ * filled in.  Empty slots will have bv_offset set to 0 and bv_len to
+ * PAGE_SIZE.
+ *
+ * If the iterator is reverted, excess pages will be left for the
+ * caller to clean up.
+ */
+void iov_iter_bvec_autoalloc(struct iov_iter *i, unsigned int direction,
+			     const struct bio_vec *bvec, unsigned long nr_segs,
+			     size_t count)
+{
+	struct bio_vec *bv =3D (struct bio_vec *)bvec;
+	unsigned long j;
+
+	BUG_ON(direction !=3D READ);
+	*i =3D (struct iov_iter){
+		.iter_type =3D ITER_BVEC,
+		.copy_mc =3D false,
+		.data_source =3D direction,
+		.auto_alloc =3D true,
+		.bvec =3D bvec,
+		.nr_segs =3D nr_segs,
+		.iov_offset =3D 0,
+		.count =3D count
+	};
+
+	for (j =3D 0; j < nr_segs; j++) {
+		if (!bv[j].bv_page) {
+			bv[j].bv_offset =3D 0;
+			bv[j].bv_len =3D PAGE_SIZE;
+		}
+	}
+}
+EXPORT_SYMBOL(iov_iter_bvec_autoalloc);
+
 /**
  * iov_iter_xarray - Initialise an I/O iterator to use the pages in an xa=
rray
  * @i: The iterator to initialise.
@@ -1122,6 +1223,8 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov=
_iter *i,
 		struct page **p;
 		struct page *page;
 =

+		if (!iov_iter_auto_alloc(i, maxsize))
+			return -ENOMEM;
 		page =3D first_bvec_segment(i, &maxsize, start);
 		n =3D want_pages_array(pages, maxsize, *start, maxpages);
 		if (!n)
@@ -1226,6 +1329,8 @@ size_t csum_and_copy_to_iter(const void *addr, size_=
t bytes, void *_csstate,
 		csstate->off +=3D bytes;
 		return bytes;
 	}
+	if (!iov_iter_auto_alloc(i, bytes))
+		return -ENOMEM;
 =

 	sum =3D csum_shift(csstate->csum, csstate->off);
 	iterate_and_advance(i, bytes, base, len, off, ({
@@ -1664,6 +1769,9 @@ static ssize_t iov_iter_extract_bvec_pages(struct io=
v_iter *i,
 	size_t skip =3D i->iov_offset, offset;
 	int k;
 =

+	if (!iov_iter_auto_alloc(i, maxsize))
+		return -ENOMEM;
+
 	for (;;) {
 		if (i->nr_segs =3D=3D 0)
 			return 0;

