Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCE55030C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiFRFgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiFRFfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:51 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3D466AF4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wonYc+1DvJWdhIjTqWyF/JeL6EQkrqUVrhaJe6p/iVo=; b=mmGuJizTs4j48NmYTlF8ORlGw7
        6qV0nbyS4iMQ3a3ldjeTxjW77nsukTFDRd4ErQUI6D1pklhY4aLxXJ3qdzYPokk/eETJ2X7wjaWnK
        rAPJW/dYPE4JyHTEbUZcIpzv27FAEZSnkRprd5L95HZcCgBSrOktXoYmeUlnlZ2zIa7p2ddVmkRI6
        J1IT4tOyydguewXz/+xNLj1Dwsbvv7OQaGM8Ncaklqgv6N2rEJF6UvqW6V0LJtKPiW/BNVLXBc05J
        +ns5SS7kMatb/9yLB1AyLfEwuXFrPudkZ3NFdeCgqQFCwCrDlYDltPaB7BbC6kg9rHKkWfFGvKqUo
        PElNU16w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7V-001VQb-C9;
        Sat, 18 Jun 2022 05:35:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 15/31] unify xarray_get_pages() and xarray_get_pages_alloc()
Date:   Sat, 18 Jun 2022 06:35:22 +0100
Message-Id: <20220618053538.359065-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
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
index fb8a44f6c5a2..2240daf2280d 100644
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
@@ -1496,7 +1467,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 	if (iov_iter_is_pipe(i))
 		return pipe_get_pages(i, pages, maxsize, ~0U, start);
 	if (iov_iter_is_xarray(i))
-		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
+		return iter_xarray_get_pages(i, pages, maxsize, ~0U, start);
 	return -EFAULT;
 }
 
-- 
2.30.2

