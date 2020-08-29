Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3892D2565CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgH2IJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 04:09:03 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6398 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgH2II4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:08:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4a0d090000>; Sat, 29 Aug 2020 01:08:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 29 Aug 2020 01:08:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 29 Aug 2020 01:08:55 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 29 Aug
 2020 08:08:54 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 29 Aug 2020 08:08:54 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.50.252]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4a0d160002>; Sat, 29 Aug 2020 01:08:54 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 2/3] iov_iter: introduce iov_iter_pin_user_pages*() routines
Date:   Sat, 29 Aug 2020 01:08:52 -0700
Message-ID: <20200829080853.20337-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829080853.20337-1-jhubbard@nvidia.com>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598688521; bh=Vy/aicbsaikOMN7ktN/NsGfhFPk9fOg1k934MsKFztI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=IkHoOYwMr+a3rkYodr7JMkibHrLP5gB6QnWW58BFLudMDnkVIVKMkG3++1GuG+rml
         nTlpsQtrq34EDfvVMEOmS30XkqnbTeEBJA1401I/Suloe8fnOTn2AiDbinkuNajMlR
         iMRgDyIgGlxp9X+SJc2JrIbSvsjEejN66a6JV0fNVz7uYLlbHlIM8olv9XW87WswZ1
         7sezpbZfoH1N69FsPFNqYttCo43H+hplqf5TXajBOd0ziKnLHbFZrMOvw2v0mNraep
         CYVJAlxCAIX/ZGsZ80xzC9r0bGFnG5CDSpXp+kSNvH+AryxkoJIoCtfm9V5mhECa1M
         BP4yGPU1yiOlA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new routines are:
    iov_iter_pin_user_pages()
    iov_iter_pin_user_pages_alloc()

and those correspond to these pre-existing routines:
    iov_iter_get_pages()
    iov_iter_get_pages_alloc()

Also, pipe_get_pages() and related are changed so as to pass
down a "use_pup" (use pin_user_page() instead of get_page()) bool
argument.

Unlike the iov_iter_get_pages*() routines, the
iov_iter_pin_user_pages*() routines assert that only ITER_IOVEC or
ITER_PIPE items are passed in. They then call pin_user_page*(), instead
of get_user_pages_fast() or get_page().

Why: In order to incrementally change Direct IO callers from calling
get_user_pages_fast() and put_page(), over to calling
pin_user_pages_fast() and unpin_user_page(), there need to be mid-level
routines that specifically call one or the other systems, for both page
acquisition and page release.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/uio.h |   5 ++
 lib/iov_iter.c      | 110 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 3835a8a8e9ea..29b0504a27cc 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -229,6 +229,11 @@ int iov_iter_npages(const struct iov_iter *i, int maxp=
ages);
=20
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t fla=
gs);
=20
+ssize_t iov_iter_pin_user_pages(struct iov_iter *i, struct page **pages,
+			size_t maxsize, unsigned int maxpages, size_t *start);
+ssize_t iov_iter_pin_user_pages_alloc(struct iov_iter *i, struct page ***p=
ages,
+			size_t maxsize, size_t *start);
+
 static inline size_t iov_iter_count(const struct iov_iter *i)
 {
 	return i->count;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5e40786c8f12..f25555eb3279 100644
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
@@ -1280,7 +1281,11 @@ static inline ssize_t __pipe_get_pages(struct iov_it=
er *i,
 	maxsize =3D n;
 	n +=3D *start;
 	while (n > 0) {
-		get_page(*pages++ =3D pipe->bufs[iter_head & p_mask].page);
+		if (use_pup)
+			pin_user_page(*pages++ =3D pipe->bufs[iter_head & p_mask].page);
+		else
+			get_page(*pages++ =3D pipe->bufs[iter_head & p_mask].page);
+
 		iter_head++;
 		n -=3D PAGE_SIZE;
 	}
@@ -1290,7 +1295,7 @@ static inline ssize_t __pipe_get_pages(struct iov_ite=
r *i,
=20
 static ssize_t pipe_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start)
+		   size_t *start, bool use_pup)
 {
 	unsigned int iter_head, npages;
 	size_t capacity;
@@ -1306,8 +1311,51 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	npages =3D pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
 	capacity =3D min(npages, maxpages) * PAGE_SIZE - *start;
=20
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, star=
t);
+	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head,
+				start, use_pup);
+}
+
+ssize_t iov_iter_pin_user_pages(struct iov_iter *i,
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
 }
+EXPORT_SYMBOL(iov_iter_pin_user_pages);
=20
 ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
@@ -1317,7 +1365,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		maxsize =3D i->count;
=20
 	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+		return pipe_get_pages(i, pages, maxsize, maxpages, start, false);
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
=20
@@ -1357,7 +1405,7 @@ static struct page **get_pages_array(size_t n)
=20
 static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   size_t *start)
+		   size_t *start, bool use_pup)
 {
 	struct page **p;
 	unsigned int iter_head, npages;
@@ -1380,7 +1428,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *=
i,
 	p =3D get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n =3D __pipe_get_pages(i, maxsize, p, iter_head, start);
+	n =3D __pipe_get_pages(i, maxsize, p, iter_head, start, use_pup);
 	if (n > 0)
 		*pages =3D p;
 	else
@@ -1388,6 +1436,52 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter =
*i,
 	return n;
 }
=20
+ssize_t iov_iter_pin_user_pages_alloc(struct iov_iter *i,
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
+EXPORT_SYMBOL(iov_iter_pin_user_pages_alloc);
+
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1398,7 +1492,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
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

