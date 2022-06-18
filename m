Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C21550309
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiFRFg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiFRFfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192ED67D36
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=q4c53P2dKvWbLaH7KCZ9/oQs6Go6Z4nL8+gVRbhEjWc=; b=EPbRC0koutJvJ5RV3lRDFy9SPg
        lMMxpoHrhvQaJORZ8y9ujFyFKPIDG7x584abvCKayoXvyIGDMY21sFSdIDBPPzzfaYPXai7y++N7x
        LZxE3XDotUoaGO012JcK8bWObUUqtGfNLXssmc9Dd9vRS6UsbfXNOOg2dkZdmJ71XA1AbW6WP71dn
        4dCZmnPSeXsMgn5d98Kf8SZnAxXAcE2LXJzTWArn/L+TTm4kawwjTWMDnGYQmnmP+z9BDsfJF/rmV
        YXuoF41bOTwusaw4lYdvjQe+kguwGOux1lz3vdeIQGfX1QxaXB6efcfQgId1XM5K7qTKe4Y6+Agfg
        5Usl4ukw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7W-001VR2-83;
        Sat, 18 Jun 2022 05:35:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 20/31] found_iovec_segment(): just return address
Date:   Sat, 18 Jun 2022 06:35:27 +0100
Message-Id: <20220618053538.359065-21-viro@zeniv.linux.org.uk>
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

... and calculate the offset in the caller

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1a30783e2b60..96cf7a05946d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1306,34 +1306,23 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 }
 
-static unsigned long found_ubuf_segment(unsigned long addr,
-					size_t *start)
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
@@ -1377,7 +1366,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
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

