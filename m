Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F29554177
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356975AbiFVEQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356822AbiFVEQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC769FEC
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7IzDSm8tRO3+5esG+C7nReWEXcnk7GKepoB+cwWuyTE=; b=gIU4wl2LI7qwYqjplX6Bb+hzdE
        jctKsyyl9M4lzRd8Qr8sucsJswj/aQqLK6sGOWFuJnhqZMXK7Sa8GWreIXEH3k78vx5ny8+M8Ju5N
        Ie5f+U0x+MU/oixRKpjgLE2mgBOMlEFidZ3aix6VCEv8releOJEYL1DIw+GR/yUCsMsCTTwl0ONTP
        Kdhadpx2+CiC2+xUBpWvZXKNNbr7H9I9htS+8GOipwWaeBc0CPngJh5cpMI9AkF9u+FEVxv9bLIxV
        7tc4MzkzSAJvO1ZlKPFCoPDq/0mpbXNLd/d30RoR8MKEcY5e7Tlj7f3pFdL2Rkys8GXxrJABvbfzP
        gvVZbsbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmX-0035yg-Vj;
        Wed, 22 Jun 2022 04:15:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 31/44] iov_iter: first_{iovec,bvec}_segment() - simplify a bit
Date:   Wed, 22 Jun 2022 05:15:39 +0100
Message-Id: <20220622041552.737754-31-viro@zeniv.linux.org.uk>
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

We return length + offset in page via *size.  Don't bother - the caller
can do that arithmetics just as well; just report the length to it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9ef671b101dc..0bed684d91d0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1310,7 +1310,7 @@ static unsigned long found_ubuf_segment(unsigned long addr,
 					size_t len,
 					size_t *size, size_t *start)
 {
-	len += (*start = addr % PAGE_SIZE);
+	*start = addr % PAGE_SIZE;
 	*size = len;
 	return addr & PAGE_MASK;
 }
@@ -1354,7 +1354,7 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 		len = maxsize;
 	skip += i->bvec->bv_offset;
 	page = i->bvec->bv_page + skip / PAGE_SIZE;
-	len += (*start = skip % PAGE_SIZE);
+	*start = skip % PAGE_SIZE;
 	*size = len;
 	return page;
 }
@@ -1383,9 +1383,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 			gup_flags |= FOLL_NOFAULT;
 
 		addr = first_iovec_segment(i, &len, start, maxsize);
-		if (len > maxpages * PAGE_SIZE)
-			len = maxpages * PAGE_SIZE;
-		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		n = DIV_ROUND_UP(len + *start, PAGE_SIZE);
+		if (n > maxpages)
+			n = maxpages;
 		if (!*pages) {
 			*pages = get_pages_array(n);
 			if (!*pages)
@@ -1394,25 +1394,25 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
 		if (unlikely(res <= 0))
 			return res;
-		return (res == n ? len : res * PAGE_SIZE) - *start;
+		return min_t(size_t, len, res * PAGE_SIZE - *start);
 	}
 	if (iov_iter_is_bvec(i)) {
 		struct page **p;
 		struct page *page;
 
 		page = first_bvec_segment(i, &len, start, maxsize);
-		if (len > maxpages * PAGE_SIZE)
-			len = maxpages * PAGE_SIZE;
-		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		n = DIV_ROUND_UP(len + *start, PAGE_SIZE);
+		if (n > maxpages)
+			n = maxpages;
 		p = *pages;
 		if (!p) {
 			*pages = p = get_pages_array(n);
 			if (!p)
 				return -ENOMEM;
 		}
-		while (n--)
+		for (int k = 0; k < n; k++)
 			get_page(*p++ = page++);
-		return len - *start;
+		return min_t(size_t, len, n * PAGE_SIZE - *start);
 	}
 	if (iov_iter_is_pipe(i))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
-- 
2.30.2

