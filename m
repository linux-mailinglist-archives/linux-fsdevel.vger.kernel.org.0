Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED8554182
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356922AbiFVEQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356835AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B78EB1C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6mqxTMoe5FWZMpdVAJw5cA30N8xjSVczJ7xJ4VOscU0=; b=Gckg4A67efp2WoqiO4wz7Ms6iy
        OCXLWHqB20bX3j3YH8TkiHwOVHadQ5MY5Yg67fHGKQhghX11RfZaGOUJS7v7ut2p1mQUoW5X2t65Q
        txuO3mtELr1Wsyo15MsrAUm9kNYvjcfE8zL2XQKxnBO5eRf38EVRRadCK4AlmSK4laRo6xjuaVy4j
        0npBIJExuLp1zQPst6GxK4yKiqPAubAIVMZwuf7dQ2Cyybx/N2ZEma03vr0C9oJT23jxB+EHakMW3
        Ylw0ljHApntfVWjOJc5S6MjgwGSjuiRojKUtZptlCvo7+pQugJk/ukdF1V/gYwqjo2jdj7kNBtHr2
        Inv4jBiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmY-0035yz-BN;
        Wed, 22 Jun 2022 04:15:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 33/44] found_iovec_segment(): just return address
Date:   Wed, 22 Jun 2022 05:15:41 +0100
Message-Id: <20220622041552.737754-33-viro@zeniv.linux.org.uk>
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

... and calculate the offset in the caller

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fca66ecce7a0..f455b8ee0d76 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1306,33 +1306,23 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 }
 
-static unsigned long found_ubuf_segment(unsigned long addr, size_t *start)
-{
-	*start = addr % PAGE_SIZE;
-	return addr & PAGE_MASK;
-}
-
 /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
 static unsigned long first_iovec_segment(const struct iov_iter *i,
-					 size_t *size, size_t *start)
+					 size_t *size)
 {
 	size_t skip;
 	long k;
 
-	if (iter_is_ubuf(i)) {
-		unsigned long addr = (unsigned long)i->ubuf + i->iov_offset;
-		return found_ubuf_segment(addr, start);
-	}
+	if (iter_is_ubuf(i))
+		return (unsigned long)i->ubuf + i->iov_offset;
 
 	for (k = 0, skip = i->iov_offset; k < i->nr_segs; k++, skip = 0) {
-		unsigned long addr = (unsigned long)i->iov[k].iov_base + skip;
 		size_t len = i->iov[k].iov_len - skip;
-
 		if (unlikely(!len))
 			continue;
 		if (*size > len)
 			*size = len;
-		return found_ubuf_segment(addr, start);
+		return (unsigned long)i->iov[k].iov_base + skip;
 	}
 	BUG(); // if it had been empty, we wouldn't get called
 }
@@ -1375,7 +1365,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		if (i->nofault)
 			gup_flags |= FOLL_NOFAULT;
 
-		addr = first_iovec_segment(i, &maxsize, start);
+		addr = first_iovec_segment(i, &maxsize);
+		*start = addr % PAGE_SIZE;
+		addr &= PAGE_MASK;
 		n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
 		if (n > maxpages)
 			n = maxpages;
-- 
2.30.2

