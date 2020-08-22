Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB75124E515
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 06:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHVEVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 00:21:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7898 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgHVEVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:21:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f409d230001>; Fri, 21 Aug 2020 21:20:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 21:21:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Aug 2020 21:21:06 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Aug
 2020 04:21:05 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 22 Aug 2020 04:21:05 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.94.162]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f409d310003>; Fri, 21 Aug 2020 21:21:05 -0700
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
Subject: [PATCH 1/5] iov_iter: introduce iov_iter_pin_user_pages*() routines
Date:   Fri, 21 Aug 2020 21:20:55 -0700
Message-ID: <20200822042059.1805541-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822042059.1805541-1-jhubbard@nvidia.com>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598070052; bh=ahW3iV5UoriqVpODE9/Ro7q37g3MhHBoUKpL3N8V2b0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=SzgUaIbUNUj2QzuM+W+c7fFbR3BisP4W1tqgKFyByO8AfSF0ecFRGQVml+rFq1xTM
         dDyBINByC5SMRgk7d1Tss5Ul2xta/r8hzvVaeepBYFojeL+3CrWFhVuozK+EqSe53J
         B3WohMzk3+RG0Hrkyv+AR5J68jXvS4bdmXNGIknhMwDMDV9Zk/0OrYqKP2NVuOoLiE
         cB0Zcr6KjTCVwQEZbXAIlmxaudTHkJZZ6ZzY6ywW0L049JTjBMGxIouUa07AKt6To8
         eZ62LMA4L5yAOtdGHGqxqR67KIA+RrlMDYpyZ1g6G37LqSa/hb8dgzoq20ycscYoCE
         LJDEeB/c3NR+A==
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

Unlike the iov_iter_get_pages*() routines, the
iov_iter_pin_user_pages*() routines assert that only ITER_IOVEC items
are passed in. They then call pin_user_pages_fast(), instead of
get_user_pages_fast().

Why: In order to incrementally change Direct IO callers from calling
get_user_pages_fast() and put_page(), over to calling
pin_user_pages_fast() and unpin_user_page(), there need to be mid-level
routines that specifically call one or the other systems, for both page
acquisition and page release.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/uio.h |  5 +++
 lib/iov_iter.c      | 80 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

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
index 5e40786c8f12..d818b16d136b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1309,6 +1309,44 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, star=
t);
 }
=20
+ssize_t iov_iter_pin_user_pages(struct iov_iter *i,
+		   struct page **pages, size_t maxsize, unsigned int maxpages,
+		   size_t *start)
+{
+	size_t skip =3D i->iov_offset;
+	const struct iovec *iov;
+	struct iovec v;
+
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
+EXPORT_SYMBOL(iov_iter_pin_user_pages);
+
 ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
@@ -1388,6 +1426,48 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter =
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
--=20
2.28.0

