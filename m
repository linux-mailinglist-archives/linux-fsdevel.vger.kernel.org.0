Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FDA24E513
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 06:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHVEVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 00:21:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4500 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHVEVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:21:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f409cf60000>; Fri, 21 Aug 2020 21:20:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 21:21:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Aug 2020 21:21:06 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Aug
 2020 04:21:05 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 22 Aug 2020 04:21:05 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.94.162]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f409d310006>; Fri, 21 Aug 2020 21:21:05 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/5] bio: convert get_user_pages_fast() --> pin_user_pages_fast()
Date:   Fri, 21 Aug 2020 21:20:57 -0700
Message-ID: <20200822042059.1805541-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822042059.1805541-1-jhubbard@nvidia.com>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598070006; bh=W3aFSTwxcsXnvQDT0rb9ATUk6+FImoLZnNsgZkjkrP4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=rgGKXhOLVHjC224uNFOv6QV+3giMdke2C5sWlrh0oH5CHu6Mw8nrMdtoCLrZlZ+FM
         CoJWh4JHw/Q89QXMOGHuOtyRRZRERP3hS6MXjsGQOi9udrkOPWbZReXbxF2DtI3697
         1OrRLuzpCLfFXBaEDZ67JAz2zwQO0KCFC2EIz2cl9xo6hv7xT2OhaUGJQwRhgFwbI2
         wt2/OXPDcuuCnXULtHHo7OROsK9KJOl+wZ7R1+7Da5UqsxcP03qdEmqcH/O6vMe4O4
         S4UY9rcNoK7LOGqE3NmjNUESeq/2L0d5P1GGP4PpY2Eay/1XWpI5+E+oCTANzmE00i
         QT4OCoyqIYHxw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change generic block/bio Direct IO routines, to acquire FOLL_PIN user
pages via the recently added routines:

    iov_iter_pin_user_pages()
    iov_iter_pin_user_pages_alloc()
    pin_user_page()

This effectively converts several file systems (ext4, for example) that
use the common Direct IO routines.

Change the corresponding page release calls from put_page() to
unpin_user_page().

Change bio_release_pages() to handle FOLL_PIN pages. In fact, that
is now the *only* type of pages it handles now.

Design notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Quite a few approaches have been considered over the years. This one is
inspired by Christoph Hellwig's July, 2019 observation that there are
only 5 ITER_ types, and we can simplify handling of them for Direct IO
[1]. Accordingly, this patch implements the following pseudocode:

Direct IO behavior:

    ITER_IOVEC:
        pin_user_pages_fast();
        break;

    ITER_KVEC:    // already elevated page refcount, leave alone
    ITER_BVEC:    // already elevated page refcount, leave alone
    ITER_PIPE:    // just, no :)
    ITER_DISCARD: // discard
        return -EFAULT or -ENVALID;

...which works for callers that already have sorted out which case they
are in. Such as, Direct IO in the block/bio layers.

Now, this does leave ITER_KVEC and ITER_BVEC unconverted, but on the
other hand, it's not clear that these are actually affected in the real
world, by the get_user_pages()+filesystem interaction problems of [2].
If it turns out to matter, then those can be handled too, but it's just
more refactoring and surgery to do so.

Page acquisition: The iov_iter_get_pages*() routines
above are at just the right level in the call stack: the callers already
know which system to use, and so it's a small change to just drop in the
replacement routines. And it's a fan-in/fan-out point: block/bio call
sites for Direct IO funnel their page acquisitions through the
iov_iter_get_pages*() routines, and there are many other callers of
those. And we can't convert all of the callers at once--too many
subsystems are involved, and it would be a too large and too risky
patch.

Page release: there are already separate release routines: put_page()
vs. unpin_user_page(), so it's already done there.

[1] https://lore.kernel.org/kvm/20190724061750.GA19397@infradead.org/

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/bio.c          | 24 ++++++++++++------------
 block/blk-map.c      |  6 +++---
 fs/direct-io.c       | 28 ++++++++++++++--------------
 fs/iomap/direct-io.c |  2 +-
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c63ba04bd629..00d548e3c2b8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -955,7 +955,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty=
)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		unpin_user_page(bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(bio_release_pages);
@@ -986,9 +986,9 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, st=
ruct iov_iter *iter)
  * @iter: iov iterator describing the region to be mapped
  *
  * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
- * For multi-segment *iter, this function only adds pages from the
- * next non-empty segment of the iov iterator.
+ * pages will have to be released using put_page() or unpin_user_page() wh=
en
+ * done. For multi-segment *iter, this function only adds pages from the n=
ext
+ * non-empty segment of the iov iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter=
)
 {
@@ -1009,7 +1009,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, =
struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
-	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size =3D iov_iter_pin_user_pages(iter, pages, LONG_MAX, nr_pages, &offset=
);
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
@@ -1020,7 +1020,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, =
struct iov_iter *iter)
=20
 		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 			if (same_page)
-				put_page(page);
+				unpin_user_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len)))
                                 return -EINVAL;
@@ -1056,7 +1056,7 @@ static int __bio_iov_append_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
-	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size =3D iov_iter_pin_user_pages(iter, pages, LONG_MAX, nr_pages, &offset=
);
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
@@ -1069,7 +1069,7 @@ static int __bio_iov_append_get_pages(struct bio *bio=
, struct iov_iter *iter)
 				max_append_sectors, &same_page) !=3D len)
 			return -EINVAL;
 		if (same_page)
-			put_page(page);
+			unpin_user_page(page);
 		offset =3D 0;
 	}
=20
@@ -1113,8 +1113,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct io=
v_iter *iter)
 		} else {
 			if (is_bvec)
 				ret =3D __bio_iov_bvec_add_pages(bio, iter);
-			else
-				ret =3D __bio_iov_iter_get_pages(bio, iter);
+		else
+			ret =3D __bio_iov_iter_get_pages(bio, iter);
 		}
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
@@ -1326,8 +1326,8 @@ void bio_set_pages_dirty(struct bio *bio)
  * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO fro=
m
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
+ * here on.  It will run one unpin_user_page() against each page
+ * and will run one bio_put() against the BIO.
  */
=20
 static void bio_dirty_fn(struct work_struct *work);
diff --git a/block/blk-map.c b/block/blk-map.c
index 6e804892d5ec..7a095b4947ea 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -275,7 +275,7 @@ static struct bio *bio_map_user_iov(struct request_queu=
e *q,
 		size_t offs, added =3D 0;
 		int npages;
=20
-		bytes =3D iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
+		bytes =3D iov_iter_pin_user_pages_alloc(iter, &pages, LONG_MAX, &offs);
 		if (unlikely(bytes <=3D 0)) {
 			ret =3D bytes ? bytes : -EFAULT;
 			goto out_unmap;
@@ -298,7 +298,7 @@ static struct bio *bio_map_user_iov(struct request_queu=
e *q,
 				if (!bio_add_hw_page(q, bio, page, n, offs,
 						     max_sectors, &same_page)) {
 					if (same_page)
-						put_page(page);
+						unpin_user_page(page);
 					break;
 				}
=20
@@ -312,7 +312,7 @@ static struct bio *bio_map_user_iov(struct request_queu=
e *q,
 		 * release the pages we didn't map into the bio, if any
 		 */
 		while (j < npages)
-			put_page(pages[j++]);
+			unpin_user_page(pages[j++]);
 		kvfree(pages);
 		/* couldn't stuff something into bio? */
 		if (bytes)
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 183299892465..b01c8d003bd3 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -170,7 +170,7 @@ static inline int dio_refill_pages(struct dio *dio, str=
uct dio_submit *sdio)
 {
 	ssize_t ret;
=20
-	ret =3D iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
+	ret =3D iov_iter_pin_user_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAG=
ES,
 				&sdio->from);
=20
 	if (ret < 0 && sdio->blocks_available && (dio->op =3D=3D REQ_OP_WRITE)) {
@@ -182,7 +182,7 @@ static inline int dio_refill_pages(struct dio *dio, str=
uct dio_submit *sdio)
 		 */
 		if (dio->page_errors =3D=3D 0)
 			dio->page_errors =3D ret;
-		get_page(page);
+		pin_user_page(page);
 		dio->pages[0] =3D page;
 		sdio->head =3D 0;
 		sdio->tail =3D 1;
@@ -472,7 +472,7 @@ static inline void dio_bio_submit(struct dio *dio, stru=
ct dio_submit *sdio)
 static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
 {
 	while (sdio->head < sdio->tail)
-		put_page(dio->pages[sdio->head++]);
+		unpin_user_page(dio->pages[sdio->head++]);
 }
=20
 /*
@@ -739,7 +739,7 @@ static inline int dio_bio_add_page(struct dio_submit *s=
dio)
 		 */
 		if ((sdio->cur_page_len + sdio->cur_page_offset) =3D=3D PAGE_SIZE)
 			sdio->pages_in_io--;
-		get_page(sdio->cur_page);
+		pin_user_page(sdio->cur_page);
 		sdio->final_block_in_bio =3D sdio->cur_page_block +
 			(sdio->cur_page_len >> sdio->blkbits);
 		ret =3D 0;
@@ -853,13 +853,13 @@ submit_page_section(struct dio *dio, struct dio_submi=
t *sdio, struct page *page,
 	 */
 	if (sdio->cur_page) {
 		ret =3D dio_send_cur_page(dio, sdio, map_bh);
-		put_page(sdio->cur_page);
+		unpin_user_page(sdio->cur_page);
 		sdio->cur_page =3D NULL;
 		if (ret)
 			return ret;
 	}
=20
-	get_page(page);		/* It is in dio */
+	pin_user_page(page);		/* It is in dio */
 	sdio->cur_page =3D page;
 	sdio->cur_page_offset =3D offset;
 	sdio->cur_page_len =3D len;
@@ -874,7 +874,7 @@ submit_page_section(struct dio *dio, struct dio_submit =
*sdio, struct page *page,
 		ret =3D dio_send_cur_page(dio, sdio, map_bh);
 		if (sdio->bio)
 			dio_bio_submit(dio, sdio);
-		put_page(sdio->cur_page);
+		unpin_user_page(sdio->cur_page);
 		sdio->cur_page =3D NULL;
 	}
 	return ret;
@@ -974,7 +974,7 @@ static int do_direct_IO(struct dio *dio, struct dio_sub=
mit *sdio,
=20
 				ret =3D get_more_blocks(dio, sdio, map_bh);
 				if (ret) {
-					put_page(page);
+					unpin_user_page(page);
 					goto out;
 				}
 				if (!buffer_mapped(map_bh))
@@ -1019,7 +1019,7 @@ static int do_direct_IO(struct dio *dio, struct dio_s=
ubmit *sdio,
=20
 				/* AKPM: eargh, -ENOTBLK is a hack */
 				if (dio->op =3D=3D REQ_OP_WRITE) {
-					put_page(page);
+					unpin_user_page(page);
 					return -ENOTBLK;
 				}
=20
@@ -1032,7 +1032,7 @@ static int do_direct_IO(struct dio *dio, struct dio_s=
ubmit *sdio,
 				if (sdio->block_in_file >=3D
 						i_size_aligned >> blkbits) {
 					/* We hit eof */
-					put_page(page);
+					unpin_user_page(page);
 					goto out;
 				}
 				zero_user(page, from, 1 << blkbits);
@@ -1072,7 +1072,7 @@ static int do_direct_IO(struct dio *dio, struct dio_s=
ubmit *sdio,
 						  sdio->next_block_for_io,
 						  map_bh);
 			if (ret) {
-				put_page(page);
+				unpin_user_page(page);
 				goto out;
 			}
 			sdio->next_block_for_io +=3D this_chunk_blocks;
@@ -1087,8 +1087,8 @@ static int do_direct_IO(struct dio *dio, struct dio_s=
ubmit *sdio,
 				break;
 		}
=20
-		/* Drop the ref which was taken in get_user_pages() */
-		put_page(page);
+		/* Drop the ref which was taken in pin_user_pages() */
+		unpin_user_page(page);
 	}
 out:
 	return ret;
@@ -1327,7 +1327,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inod=
e *inode,
 		ret2 =3D dio_send_cur_page(dio, &sdio, &map_bh);
 		if (retval =3D=3D 0)
 			retval =3D ret2;
-		put_page(sdio.cur_page);
+		unpin_user_page(sdio.cur_page);
 		sdio.cur_page =3D NULL;
 	}
 	if (sdio.bio)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..390f611528ea 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -194,7 +194,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iom=
ap, loff_t pos,
 	bio->bi_private =3D dio;
 	bio->bi_end_io =3D iomap_dio_bio_end_io;
=20
-	get_page(page);
+	pin_user_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
 	iomap_dio_submit_bio(dio, iomap, bio, pos);
--=20
2.28.0

