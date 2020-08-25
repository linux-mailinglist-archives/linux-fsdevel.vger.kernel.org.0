Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0845A250E25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 03:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgHYBUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 21:20:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5098 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHYBUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:20:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4466ef0000>; Mon, 24 Aug 2020 18:18:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 18:20:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 18:20:38 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 01:20:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 25 Aug 2020 01:20:38 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.53.36]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4467660001>; Mon, 24 Aug 2020 18:20:38 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     <willy@infradead.org>, <jlayton@kernel.org>
CC:     <akpm@linux-foundation.org>, <axboe@kernel.dk>,
        <ceph-devel@vger.kernel.org>, <hch@infradead.org>,
        <idryomov@gmail.com>, <jhubbard@nvidia.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, <viro@zeniv.linux.org.uk>
Subject: [PATCH v2] fs/ceph: use pipe_get_pages_alloc() for pipe
Date:   Mon, 24 Aug 2020 18:20:34 -0700
Message-ID: <20200825012034.1962362-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824185400.GE17456@casper.infradead.org>
References: <20200824185400.GE17456@casper.infradead.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598318319; bh=LeU6AwNAplziQ2ZfUIYvJCauSoR/ekxkghoX0Pth920=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=dJbhxmWVHB+ywuKvGhuzf3w1LZCEDf94YUwqDRfe9Q2Hr5/ds8ADrW5U+JzneKhXj
         npXXJ055Qgt5hE0X44gz/QtrW2vXHRX9yuixWIiZnaM1olwc9O8Yj5U/4KTZmfiHeY
         L/FC1LzwJsP6oTtzCYXH7Db7JrI54OthDvtnrk9EEJyg0tFZEpjiCU63NhQ/VmmuLE
         uBZO7o5iBq6kpernShLqsNSEUmioemlhLvSfLCu2/2OAFEmodXF1Hn3H8cJaiEzrOx
         OJWeBkzB6k6g6xYbUbzW/gBylQgHQAh367suhEv6p2S93O5intO7INmut3vnXhXTAp
         IMSDCnFxRuYcw==
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

OK, here's a v2 that does EXPORT_SYMBOL_GPL, instead of EXPORT_SYMBOL,
that's the only change from v1. That should help give this patch a
clear bill of passage. :)

thanks,
John Hubbard
NVIDIA

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
index 3835a8a8e9ea..270a4dcf5453 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -226,7 +226,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i, struct p=
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
 static inline size_t iov_iter_count(const struct iov_iter *i)
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5e40786c8f12..6290998df480 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1355,9 +1355,8 @@ static struct page **get_pages_array(size_t n)
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
@@ -1387,6 +1386,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *=
i,
 		kvfree(p);
 	return n;
 }
+EXPORT_SYMBOL_GPL(pipe_get_pages_alloc);
=20
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
--=20
2.28.0

