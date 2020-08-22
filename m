Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD124E50B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 06:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHVEVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 00:21:18 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14463 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgHVEVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:21:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f409cbe0000>; Fri, 21 Aug 2020 21:19:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 21:21:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Aug 2020 21:21:06 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Aug
 2020 04:21:05 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 22 Aug 2020 04:21:06 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.94.162]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f409d310007>; Fri, 21 Aug 2020 21:21:05 -0700
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
Subject: [PATCH 4/5] bio: introduce BIO_FOLL_PIN flag
Date:   Fri, 21 Aug 2020 21:20:58 -0700
Message-ID: <20200822042059.1805541-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822042059.1805541-1-jhubbard@nvidia.com>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598069950; bh=dStqadzdVyXdIQS1MKqVD7zok05od3X+Gm0e+Cu/ZoM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=C6LhBjw+fU0jybOfRmvr8dzUNMGe3gMPFtMhY/zJGfLrGkYwjh77m1Z9CLV3g0c9Z
         rtdepTOlTuyTasuYggwWRkvU1LaOHETQ5efA0k/s1rGynwLSVIPVoYJqoV6jh3Chdf
         cDyZ055a9lWQ2dELXyr60r1s1GO1MxUc4ES9iqrz4ajAtRO8u9giR6UXgq83cIVeDC
         7mBTH5htcBSA58XccKh1Zw/yBWBYC+gN+uB28k+TS8Fwxmjsh3xmR/vNoCQyKKXXpb
         NE8QoJtWCUzAKxljNycFQ6PkLjMuOt+rOUW/1ixH8hJ8A0SZn9MT8rBHf5AH3+8FlH
         cUJZncSTaQhxg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new BIO_FOLL_PIN flag to struct bio, whose "short int" flags field
was full, thuse triggering an expansion of the field from 16, to 32
bits. This allows for a nice assertion in bio_release_pages(), that the
bio page release mechanism matches the page acquisition mechanism.

Set BIO_FOLL_PIN whenever pin_user_pages_fast() is used, and check for
BIO_FOLL_PIN before using unpin_user_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/bio.c               | 9 +++++++--
 block/blk-map.c           | 3 ++-
 fs/direct-io.c            | 4 ++--
 include/linux/blk_types.h | 5 +++--
 include/linux/uio.h       | 5 +++--
 lib/iov_iter.c            | 9 +++++++--
 6 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 00d548e3c2b8..dd8e85618d5e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -952,6 +952,9 @@ void bio_release_pages(struct bio *bio, bool mark_dirty=
)
 	if (bio_flagged(bio, BIO_NO_PAGE_REF))
 		return;
=20
+	if (WARN_ON_ONCE(!bio_flagged(bio, BIO_FOLL_PIN)))
+		return;
+
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
@@ -1009,7 +1012,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, =
struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
-	size =3D iov_iter_pin_user_pages(iter, pages, LONG_MAX, nr_pages, &offset=
);
+	size =3D iov_iter_pin_user_pages(bio, iter, pages, LONG_MAX, nr_pages,
+				       &offset);
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
@@ -1056,7 +1060,8 @@ static int __bio_iov_append_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
-	size =3D iov_iter_pin_user_pages(iter, pages, LONG_MAX, nr_pages, &offset=
);
+	size =3D iov_iter_pin_user_pages(bio, iter, pages, LONG_MAX, nr_pages,
+				       &offset);
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
diff --git a/block/blk-map.c b/block/blk-map.c
index 7a095b4947ea..ddfff2f0b1cb 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -275,7 +275,8 @@ static struct bio *bio_map_user_iov(struct request_queu=
e *q,
 		size_t offs, added =3D 0;
 		int npages;
=20
-		bytes =3D iov_iter_pin_user_pages_alloc(iter, &pages, LONG_MAX, &offs);
+		bytes =3D iov_iter_pin_user_pages_alloc(bio, iter, &pages,
+						      LONG_MAX, &offs);
 		if (unlikely(bytes <=3D 0)) {
 			ret =3D bytes ? bytes : -EFAULT;
 			goto out_unmap;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index b01c8d003bd3..4d0787ba85eb 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -170,8 +170,8 @@ static inline int dio_refill_pages(struct dio *dio, str=
uct dio_submit *sdio)
 {
 	ssize_t ret;
=20
-	ret =3D iov_iter_pin_user_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAG=
ES,
-				&sdio->from);
+	ret =3D iov_iter_pin_user_pages(sdio->bio, sdio->iter, dio->pages,
+				      LONG_MAX, DIO_PAGES, &sdio->from);
=20
 	if (ret < 0 && sdio->blocks_available && (dio->op =3D=3D REQ_OP_WRITE)) {
 		struct page *page =3D ZERO_PAGE(0);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4ecf4fed171f..d0e0da762af3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -188,7 +188,7 @@ struct bio {
 						 * top bits REQ_OP. Use
 						 * accessors.
 						 */
-	unsigned short		bi_flags;	/* status, etc and bvec pool number */
+	unsigned int		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
@@ -267,6 +267,7 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_FOLL_PIN,		/* must release pages via unpin_user_pages() */
 	BIO_FLAG_LAST
 };
=20
@@ -285,7 +286,7 @@ enum {
  * freed.
  */
 #define BVEC_POOL_BITS		(3)
-#define BVEC_POOL_OFFSET	(16 - BVEC_POOL_BITS)
+#define BVEC_POOL_OFFSET	(32 - BVEC_POOL_BITS)
 #define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)
 #if (1<< BVEC_POOL_BITS) < (BVEC_POOL_NR+1)
 # error "BVEC_POOL_BITS is too small"
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 29b0504a27cc..62bcf5e45f2b 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -209,6 +209,7 @@ size_t copy_to_iter_mcsafe(void *addr, size_t bytes, st=
ruct iov_iter *i)
 		return _copy_to_iter_mcsafe(addr, bytes, i);
 }
=20
+struct bio;
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
@@ -229,9 +230,9 @@ int iov_iter_npages(const struct iov_iter *i, int maxpa=
ges);
=20
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t fla=
gs);
=20
-ssize_t iov_iter_pin_user_pages(struct iov_iter *i, struct page **pages,
+ssize_t iov_iter_pin_user_pages(struct bio *bio, struct iov_iter *i, struc=
t page **pages,
 			size_t maxsize, unsigned int maxpages, size_t *start);
-ssize_t iov_iter_pin_user_pages_alloc(struct iov_iter *i, struct page ***p=
ages,
+ssize_t iov_iter_pin_user_pages_alloc(struct bio *bio, struct iov_iter *i,=
 struct page ***pages,
 			size_t maxsize, size_t *start);
=20
 static inline size_t iov_iter_count(const struct iov_iter *i)
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d818b16d136b..a4bc1b3a3fda 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -3,6 +3,7 @@
 #include <linux/export.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
+#include <linux/bio.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -1309,7 +1310,7 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, star=
t);
 }
=20
-ssize_t iov_iter_pin_user_pages(struct iov_iter *i,
+ssize_t iov_iter_pin_user_pages(struct bio *bio, struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned int maxpages,
 		   size_t *start)
 {
@@ -1335,6 +1336,8 @@ ssize_t iov_iter_pin_user_pages(struct iov_iter *i,
 		addr &=3D ~(PAGE_SIZE - 1);
 		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
=20
+		bio_set_flag(bio, BIO_FOLL_PIN);
+
 		res =3D pin_user_pages_fast(addr, n,
 				iov_iter_rw(i) !=3D WRITE ?  FOLL_WRITE : 0,
 				pages);
@@ -1426,7 +1429,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *=
i,
 	return n;
 }
=20
-ssize_t iov_iter_pin_user_pages_alloc(struct iov_iter *i,
+ssize_t iov_iter_pin_user_pages_alloc(struct bio *bio, struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
 {
@@ -1454,6 +1457,8 @@ ssize_t iov_iter_pin_user_pages_alloc(struct iov_iter=
 *i,
 		if (!p)
 			return -ENOMEM;
=20
+		bio_set_flag(bio, BIO_FOLL_PIN);
+
 		res =3D pin_user_pages_fast(addr, n,
 				iov_iter_rw(i) !=3D WRITE ?  FOLL_WRITE : 0, p);
 		if (unlikely(res < 0)) {
--=20
2.28.0

