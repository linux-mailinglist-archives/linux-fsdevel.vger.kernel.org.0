Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5D24E520
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 06:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgHVEVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 00:21:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14468 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgHVEVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:21:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f409cbe0001>; Fri, 21 Aug 2020 21:19:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 21:21:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Aug 2020 21:21:06 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Aug
 2020 04:21:05 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 22 Aug 2020 04:21:05 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.94.162]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f409d310009>; Fri, 21 Aug 2020 21:21:05 -0700
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
Subject: [PATCH 5/5] fs/ceph: use pipe_get_pages_alloc() for pipe
Date:   Fri, 21 Aug 2020 21:20:59 -0700
Message-ID: <20200822042059.1805541-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822042059.1805541-1-jhubbard@nvidia.com>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598069950; bh=GTzFC9ZKOy1JQWqhGPPFcWCorren+4pNfhyF1KWKP8Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=cPZpvrnaH6BmFX+0zBe5QqRgPZb3Bv5dZIEekgu75/v14xpqNha+eLqoiJrBPN0dg
         Mg+SnzuYzkTwf3CnmMIg5OVHtiSSdm9/oHAouzCKWDeWxZSBswlxT4l3Y8IzXkoNrI
         7BBsJTt2r+aBzUT+2iv8WQdn8QHM/47iNyfVRQhKfzra+iv60Bz5dV11jUHACvkrZZ
         JDttpGrJI9IhTQLIgLOzkjmIMg5qDIJBEeTN7U0DF7hGUxRv+1QVdE+Md6tXkWPy5z
         LXh1eEAZVp0Eu8SpU1XUq80eRjHVJeQHufNH4dEwk1S5D7fFveGe30EBHmCU/hHNVX
         WuELYtuojJ9IA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reduces, by one, the number of callers of iov_iter_get_pages().
That's helpful because these calls are being audited and converted over
to use iov_iter_pin_user_pages(), where applicable. And this one here is
already known by the caller to be only for ITER_PIPE, so let's just
simplify it now.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/ceph/file.c      | 3 +--
 include/linux/uio.h | 3 ++-
 lib/iov_iter.c      | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d51c3f2fdca0..d3d7dd957390 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -879,8 +879,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struc=
t iov_iter *to,
 		more =3D len < iov_iter_count(to);
=20
 		if (unlikely(iov_iter_is_pipe(to))) {
-			ret =3D iov_iter_get_pages_alloc(to, &pages, len,
-						       &page_off);
+			ret =3D pipe_get_pages_alloc(to, &pages, len, &page_off);
 			if (ret <=3D 0) {
 				ceph_osdc_put_request(req);
 				ret =3D -ENOMEM;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 62bcf5e45f2b..76cd47ab3dfd 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -227,7 +227,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i, struct p=
age **pages,
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
-
+ssize_t pipe_get_pages_alloc(struct iov_iter *i, struct page ***pages,
+			     size_t maxsize, size_t *start);
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t fla=
gs);
=20
 ssize_t iov_iter_pin_user_pages(struct bio *bio, struct iov_iter *i, struc=
t page **pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a4bc1b3a3fda..f571fe3ddbe8 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1396,9 +1396,8 @@ static struct page **get_pages_array(size_t n)
 	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
 }
=20
-static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
-		   struct page ***pages, size_t maxsize,
-		   size_t *start)
+ssize_t pipe_get_pages_alloc(struct iov_iter *i, struct page ***pages,
+			     size_t maxsize, size_t *start)
 {
 	struct page **p;
 	unsigned int iter_head, npages;
@@ -1428,6 +1427,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *=
i,
 		kvfree(p);
 	return n;
 }
+EXPORT_SYMBOL(pipe_get_pages_alloc);
=20
 ssize_t iov_iter_pin_user_pages_alloc(struct bio *bio, struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
--=20
2.28.0

