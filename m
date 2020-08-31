Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB24C25741E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgHaHOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 03:14:53 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9940 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgHaHOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:14:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4ca3580001>; Mon, 31 Aug 2020 00:14:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 00:14:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 00:14:46 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 07:14:46 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 07:14:46 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.61.194]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4ca3650001>; Mon, 31 Aug 2020 00:14:45 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 2/3] iov_iter: introduce iov_iter_pin_pages*() routines
Date:   Mon, 31 Aug 2020 00:14:38 -0700
Message-ID: <20200831071439.1014766-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831071439.1014766-1-jhubbard@nvidia.com>
References: <20200831071439.1014766-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598858072; bh=jwmL5keCSRb4i6VwRyMsY8w6+RTlVx/GVzSIN4vBl1c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=gZ5aXiKzWb1rph5HyaTU2oQ4pZjqhZjGAyR3CpFbituOa9DwbPmr3czx7HpCKchSz
         iaEHyv4dFg0qcZy50p+FgJwZ2vQ78uJb3zCYhnBwgKru6V+fT+2zbx21Thg+2Rhgjy
         EC0Su/BJzkNVBQnPVT2D3wtWUoo+k99FY1I3M0k22ul//4mahapV7lsQLnj1iJY9iA
         BcjIJN9ukogJhsnggVHSijdmBNbkOcAzZ1meU5vf1LRpbm7uL1MmiYRSnoaz5isLlj
         XIoKT9nri8bmhnGqCMdZzRJIyCF7nklluAVAqEyA+DhqkM6HhTnOEkfY9Ts/SXlckk
         7oMHomzU3RZ2A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new routines are:
    iov_iter_pin_pages()
    iov_iter_pin_pages_alloc()

and those correspond to these pre-existing routines:
    iov_iter_get_pages()
    iov_iter_get_pages_alloc()

Also, pipe_get_pages() and related are changed so as to pass
down a "use_pup" (use pin_page() instead of get_page()) bool
argument.

Unlike the iov_iter_get_pages*() routines, the iov_iter_pin_pages*()
routines assert that only ITER_IOVEC or ITER_PIPE items are passed in.
They then call pin_user_pages_fast() or pin_page(), instead of
get_user_pages_fast() or get_page().

Why: In order to incrementally change Direct IO callers from calling
get_user_pages_fast() and put_page(), over to calling
pin_user_pages_fast() and unpin_user_page(), there need to be mid-level
routines that specifically call one or the other systems, for both page
acquisition and page release.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/uio.h |   5 ++
 lib/iov_iter.c      | 113 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 3835a8a8e9ea..e44eed12afdf 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -229,6 +229,11 @@ int iov_iter_npages(const struct iov_iter *i, int maxp=
ages);
=20
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t fla=
gs);
=20
+ssize_t iov_iter_pin_pages(struct iov_iter *i, struct page **pages,
+			size_t maxsize, unsigned int maxpages, size_t *start);
+ssize_t iov_iter_pin_pages_alloc(struct iov_iter *i, struct page ***pages,
+			size_t maxsize, size_t *start);
+
 static inline size_t iov_iter_count(const struct iov_iter *i)
 {
 	return i->count;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5e40786c8f12..2dc1f4812fa9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1269,7 +1269,8 @@ static inline ssize_t __pipe_get_pages(struct iov_ite=
r *i,
 				size_t maxsize,
 				struct page **pages,
 				int iter_head,
-				size_t *start)
+				size_t *start,
+				bool use_pup)
 {
 	struct pipe_inode_info *pipe =3D i->pipe;
 	unsigned int p_mask =3D pipe->ring_size - 1;
@@ -1280,7 +1281,14 @@ static inline ssize_t __pipe_get_pages(struct iov_it=
er *i,
 	maxsize =3D n;
 	n +=3D *start;
 	while (n > 0) {
-		get_page(*pages++ =3D pipe->bufs[iter_head & p_mask].page);
+		struct page *page =3D pipe->bufs[iter_head & p_mask].page;
+
+		if (use_pup)
+			pin_page(page);
+		else
+			get_page(page);
+
+		*pages++ =3D page;
 		iter_head++;
 		n -=3D PAGE_SIZE;
 	}
@@ -1290,7 +1298,7 @@ static inline ssize_t __pipe_get_pages(struct iov_ite=
r *i,
=20
 static ssize_t pipe_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start)
+		   size_t *start, bool use_pup)
 {
 	unsigned int iter_head, npages;
 	size_t capacity;
@@ -1306,9 +1314,52 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	npages =3D pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
 	capacity =3D min(npages, maxpages) * PAGE_SIZE - *start;
=20
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, star=
t);
+	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head,
+				start, use_pup);
 }
=20
+ssize_t iov_iter_pin_pages(struct iov_iter *i,
+		   struct page **pages, size_t maxsize, unsigned int maxpages,
+		   size_t *start)
+{
+	size_t skip =3D i->iov_offset;
+	const struct iovec *iov;
+	struct iovec v;
+
+	if (unlikely(iov_iter_is_pipe(i)))
+		return pipe_get_pages(i, pages, maxsize, maxpages, start, true);
+	if (unlikely(iov_iter_is_discard(i)))
+		return -EFAULT;
+	if (WARN_ON_ONCE(!iter_is_iovec(i)))
+		return -EFAULT;
+
+	if (unlikely(!maxsize))
+		return 0;
+	maxsize =3D min(maxsize, i->count);
+
+	iterate_iovec(i, maxsize, v, iov, skip, ({
+		unsigned long addr =3D (unsigned long)v.iov_base;
+		size_t len =3D v.iov_len + (*start =3D addr & (PAGE_SIZE - 1));
+		int n;
+		int res;
+
+		if (len > maxpages * PAGE_SIZE)
+			len =3D maxpages * PAGE_SIZE;
+		addr &=3D ~(PAGE_SIZE - 1);
+		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
+
+		res =3D pin_user_pages_fast(addr, n,
+				iov_iter_rw(i) !=3D WRITE ?  FOLL_WRITE : 0,
+				pages);
+		if (unlikely(res < 0))
+			return res;
+		return (res =3D=3D n ? len : res * PAGE_SIZE) - *start;
+		0;
+	}))
+	return 0;
+}
+EXPORT_SYMBOL(iov_iter_pin_pages);
+
 ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
@@ -1317,7 +1368,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		maxsize =3D i->count;
=20
 	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+		return pipe_get_pages(i, pages, maxsize, maxpages, start, false);
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
=20
@@ -1357,7 +1408,7 @@ static struct page **get_pages_array(size_t n)
=20
 static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   size_t *start)
+		   size_t *start, bool use_pup)
 {
 	struct page **p;
 	unsigned int iter_head, npages;
@@ -1380,7 +1431,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *=
i,
 	p =3D get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n =3D __pipe_get_pages(i, maxsize, p, iter_head, start);
+	n =3D __pipe_get_pages(i, maxsize, p, iter_head, start, use_pup);
 	if (n > 0)
 		*pages =3D p;
 	else
@@ -1388,6 +1439,52 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter =
*i,
 	return n;
 }
=20
+ssize_t iov_iter_pin_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   size_t *start)
+{
+	struct page **p;
+	size_t skip =3D i->iov_offset;
+	const struct iovec *iov;
+	struct iovec v;
+
+	if (unlikely(iov_iter_is_pipe(i)))
+		return pipe_get_pages_alloc(i, pages, maxsize, start, true);
+	if (unlikely(iov_iter_is_discard(i)))
+		return -EFAULT;
+	if (WARN_ON_ONCE(!iter_is_iovec(i)))
+		return -EFAULT;
+
+	if (unlikely(!maxsize))
+		return 0;
+	maxsize =3D min(maxsize, i->count);
+
+	iterate_iovec(i, maxsize, v, iov, skip, ({
+		unsigned long addr =3D (unsigned long)v.iov_base;
+		size_t len =3D v.iov_len + (*start =3D addr & (PAGE_SIZE - 1));
+		int n;
+		int res;
+
+		addr &=3D ~(PAGE_SIZE - 1);
+		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
+		p =3D get_pages_array(n);
+		if (!p)
+			return -ENOMEM;
+
+		res =3D pin_user_pages_fast(addr, n,
+				iov_iter_rw(i) !=3D WRITE ?  FOLL_WRITE : 0, p);
+		if (unlikely(res < 0)) {
+			kvfree(p);
+			return res;
+		}
+		*pages =3D p;
+		return (res =3D=3D n ? len : res * PAGE_SIZE) - *start;
+		0;
+	}))
+	return 0;
+}
+EXPORT_SYMBOL(iov_iter_pin_pages_alloc);
+
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1398,7 +1495,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		maxsize =3D i->count;
=20
 	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_get_pages_alloc(i, pages, maxsize, start);
+		return pipe_get_pages_alloc(i, pages, maxsize, start, false);
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
=20
--=20
2.28.0

