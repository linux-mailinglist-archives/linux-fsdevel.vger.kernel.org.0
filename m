Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A09E554184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356939AbiFVEQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356796AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22D764C
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t+ZhgCyfjPqW81eYAJou5jvuXDlrzrNGX9oqhs/L/dg=; b=KzSVaG30mWIDlNSlGlbZ5+X3MW
        L1i8B0Z3UUaPvb3cmLzJbpAve9c8zqYRHkerL1A4z2vm9wL9XDfRmT6xgE30/BC6BZUKiqDhPT/02
        4GLMpx9b4sI3+KSqTLaFBW7Z3dFU5kp3HsMu+qKVr8LaZvh/PM4cnPL8KaAP8Iqk2BMLCdEMxP1rM
        YjWMNfo/3UkuNUhhnpQ7EpRhRNLATpPmbs0MYcZVW+Ju3AEtSkEinziLZf4lRnrYVzF3TnGyA7rp0
        p9J1zKGmAtJLWXBEmKszRkgNjWVRZRkEqcCLAlMCAQXdPv7t+fcuDAPyccP61Oh2UcUzRLDgLAW8z
        is5uhj1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmX-0035yA-3t;
        Wed, 22 Jun 2022 04:15:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 27/44] unify xarray_get_pages() and xarray_get_pages_alloc()
Date:   Wed, 22 Jun 2022 05:15:35 +0100
Message-Id: <20220622041552.737754-27-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

same as for pipes

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 49 ++++++++++---------------------------------------
 1 file changed, 10 insertions(+), 39 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1c98f2f3a581..07dacb274ba5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1276,7 +1276,7 @@ static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa
 }
 
 static ssize_t iter_xarray_get_pages(struct iov_iter *i,
-				     struct page **pages, size_t maxsize,
+				     struct page ***pages, size_t maxsize,
 				     unsigned maxpages, size_t *_start_offset)
 {
 	unsigned nr, offset;
@@ -1301,7 +1301,13 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	if (count > maxpages)
 		count = maxpages;
 
-	nr = iter_xarray_populate_pages(pages, i->xarray, index, count);
+	if (!*pages) {
+		*pages = get_pages_array(count);
+		if (!*pages)
+			return -ENOMEM;
+	}
+
+	nr = iter_xarray_populate_pages(*pages, i->xarray, index, count);
 	if (nr == 0)
 		return 0;
 
@@ -1409,46 +1415,11 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	if (iov_iter_is_pipe(i))
 		return pipe_get_pages(i, &pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
-		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
+		return iter_xarray_get_pages(i, &pages, maxsize, maxpages, start);
 	return -EFAULT;
 }
 EXPORT_SYMBOL(iov_iter_get_pages);
 
-static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
-					   struct page ***pages, size_t maxsize,
-					   size_t *_start_offset)
-{
-	struct page **p;
-	unsigned nr, offset;
-	pgoff_t index, count;
-	size_t size = maxsize;
-	loff_t pos;
-
-	pos = i->xarray_start + i->iov_offset;
-	index = pos >> PAGE_SHIFT;
-	offset = pos & ~PAGE_MASK;
-	*_start_offset = offset;
-
-	count = 1;
-	if (size > PAGE_SIZE - offset) {
-		size -= PAGE_SIZE - offset;
-		count += size >> PAGE_SHIFT;
-		size &= ~PAGE_MASK;
-		if (size)
-			count++;
-	}
-
-	*pages = p = get_pages_array(count);
-	if (!p)
-		return -ENOMEM;
-
-	nr = iter_xarray_populate_pages(p, i->xarray, index, count);
-	if (nr == 0)
-		return 0;
-
-	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
-}
-
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1498,7 +1469,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 	if (iov_iter_is_pipe(i))
 		return pipe_get_pages(i, pages, maxsize, ~0U, start);
 	if (iov_iter_is_xarray(i))
-		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
+		return iter_xarray_get_pages(i, pages, maxsize, ~0U, start);
 	return -EFAULT;
 }
 
-- 
2.30.2

