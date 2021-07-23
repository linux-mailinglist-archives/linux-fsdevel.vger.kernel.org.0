Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5189E3D41DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 22:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhGWUSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 16:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232073AbhGWUSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627073954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFei+s+fWvJWvz6iB+WUaD924M10iRi+eomBo7E3jgU=;
        b=Ab76SAg6sd/BkW6ovHhhyHqDekAW7WOddvNg2lDpQizXi1rCtxAu/GGfm4dIDclXbxpgUg
        rIo4+cXTTWSccSG8uP88+lfuHthVYw/tk53b47jJmCkUrHgRhJEZC1qwKVHeA9mtGkZ1h8
        TGRIAFBK0YJ0PZSw3ox7aGK7/sEGXI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-X45yxMnRO86KqkwtcPyfmg-1; Fri, 23 Jul 2021 16:59:10 -0400
X-MC-Unique: X45yxMnRO86KqkwtcPyfmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04261801A92;
        Fri, 23 Jul 2021 20:59:09 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E53CB10074FD;
        Fri, 23 Jul 2021 20:59:02 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 6/7] iov_iter: Introduce noio flag to disable page faults
Date:   Fri, 23 Jul 2021 22:58:39 +0200
Message-Id: <20210723205840.299280-7-agruenba@redhat.com>
In-Reply-To: <20210723205840.299280-1-agruenba@redhat.com>
References: <20210723205840.299280-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new noio flag to indicate to get_user_pages to use the
FOLL_FAST_ONLY flag.  This will cause get_user_pages to fail when it
would otherwise fault in a page.

Currently, the noio flag is only checked in iov_iter_get_pages and
iov_iter_get_pages_alloc.  This is enough for iomaop_dio_rw, but it
may make sense to check for this flag in other contexts as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 152b3605e86c..8de6354ade14 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,6 +29,7 @@ enum iter_type {
 
 struct iov_iter {
 	u8 iter_type;
+	bool noio;
 	bool data_source;
 	size_t iov_offset;
 	size_t count;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7221665f7ac4..a20426cedf60 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -509,6 +509,7 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_IOVEC,
+		.noio = false,
 		.data_source = direction,
 		.iov = iov,
 		.nr_segs = nr_segs,
@@ -1519,13 +1520,17 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		return 0;
 
 	if (likely(iter_is_iovec(i))) {
+		unsigned int gup_flags = 0;
 		unsigned long addr;
 
+		if (iov_iter_rw(i) != WRITE)
+			gup_flags |= FOLL_WRITE;
+		if (i->noio)
+			gup_flags |= FOLL_FAST_ONLY;
+
 		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		res = get_user_pages_fast(addr, n,
-				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0,
-				pages);
+		res = get_user_pages_fast(addr, n, gup_flags, pages);
 		if (unlikely(res <= 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
@@ -1641,15 +1646,20 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		return 0;
 
 	if (likely(iter_is_iovec(i))) {
+		unsigned int gup_flags = 0;
 		unsigned long addr;
 
+		if (iov_iter_rw(i) != WRITE)
+			gup_flags |= FOLL_WRITE;
+		if (i->noio)
+			gup_flags |= FOLL_FAST_ONLY;
+
 		addr = first_iovec_segment(i, &len, start, maxsize, ~0U);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
 		p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n,
-				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0, p);
+		res = get_user_pages_fast(addr, n, gup_flags, p);
 		if (unlikely(res <= 0)) {
 			kvfree(p);
 			*pages = ZERO_SIZE_PTR;
-- 
2.26.3

