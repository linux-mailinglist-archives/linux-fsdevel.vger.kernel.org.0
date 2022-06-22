Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272C6554163
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356872AbiFVEQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356698AbiFVEP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8860164F2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EZJVKAFRPo6DTLZ4VzXnBiLtorgf9Z60bL9Bh97bIjQ=; b=Op34Ere/Z0IOtzifpoSlBjg8iz
        rQdt0jqfVultYIQyLTZUPAENf6RWC6G4vxnigKEAOduaad6ph0Qh3AAS3EDwVi1SZbZodetu5kNgf
        vnHmvssw8LaPYE9fZpsTtdu8giRkg9tsfubbNApHOgYQhyrg6OpClALOXpAiRXLzi+jjlRmMSfebU
        bPxYRpH2AxPf5Z7ke+FfIcGKaSkbClycGSJTZTrJN67pJAq8+/Y32LjXVTdIlpmZYtHO5fmFUs/nH
        XoraGUB4kRMvHD3kvdFiMBtSYV89NaCWfCzM3lV+YaDNRTZP0DaeJaISV1Hnyc0Q+HS1PR4cyD5Xs
        UFwrLlXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmT-0035vy-W6;
        Wed, 22 Jun 2022 04:15:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 08/44] copy_page_{to,from}_iter(): switch iovec variants to generic
Date:   Wed, 22 Jun 2022 05:15:16 +0100
Message-Id: <20220622041552.737754-8-viro@zeniv.linux.org.uk>
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

we can do copyin/copyout under kmap_local_page(); it shouldn't overflow
the kmap stack - the maximal footprint increase only by one here.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 191 ++-----------------------------------------------
 1 file changed, 4 insertions(+), 187 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..4c658a25e29c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -168,174 +168,6 @@ static int copyin(void *to, const void __user *from, size_t n)
 	return n;
 }
 
-static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
-			 struct iov_iter *i)
-{
-	size_t skip, copy, left, wanted;
-	const struct iovec *iov;
-	char __user *buf;
-	void *kaddr, *from;
-
-	if (unlikely(bytes > i->count))
-		bytes = i->count;
-
-	if (unlikely(!bytes))
-		return 0;
-
-	might_fault();
-	wanted = bytes;
-	iov = i->iov;
-	skip = i->iov_offset;
-	buf = iov->iov_base + skip;
-	copy = min(bytes, iov->iov_len - skip);
-
-	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_writeable(buf, copy)) {
-		kaddr = kmap_atomic(page);
-		from = kaddr + offset;
-
-		/* first chunk, usually the only one */
-		left = copyout(buf, from, copy);
-		copy -= left;
-		skip += copy;
-		from += copy;
-		bytes -= copy;
-
-		while (unlikely(!left && bytes)) {
-			iov++;
-			buf = iov->iov_base;
-			copy = min(bytes, iov->iov_len);
-			left = copyout(buf, from, copy);
-			copy -= left;
-			skip = copy;
-			from += copy;
-			bytes -= copy;
-		}
-		if (likely(!bytes)) {
-			kunmap_atomic(kaddr);
-			goto done;
-		}
-		offset = from - kaddr;
-		buf += copy;
-		kunmap_atomic(kaddr);
-		copy = min(bytes, iov->iov_len - skip);
-	}
-	/* Too bad - revert to non-atomic kmap */
-
-	kaddr = kmap(page);
-	from = kaddr + offset;
-	left = copyout(buf, from, copy);
-	copy -= left;
-	skip += copy;
-	from += copy;
-	bytes -= copy;
-	while (unlikely(!left && bytes)) {
-		iov++;
-		buf = iov->iov_base;
-		copy = min(bytes, iov->iov_len);
-		left = copyout(buf, from, copy);
-		copy -= left;
-		skip = copy;
-		from += copy;
-		bytes -= copy;
-	}
-	kunmap(page);
-
-done:
-	if (skip == iov->iov_len) {
-		iov++;
-		skip = 0;
-	}
-	i->count -= wanted - bytes;
-	i->nr_segs -= iov - i->iov;
-	i->iov = iov;
-	i->iov_offset = skip;
-	return wanted - bytes;
-}
-
-static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t bytes,
-			 struct iov_iter *i)
-{
-	size_t skip, copy, left, wanted;
-	const struct iovec *iov;
-	char __user *buf;
-	void *kaddr, *to;
-
-	if (unlikely(bytes > i->count))
-		bytes = i->count;
-
-	if (unlikely(!bytes))
-		return 0;
-
-	might_fault();
-	wanted = bytes;
-	iov = i->iov;
-	skip = i->iov_offset;
-	buf = iov->iov_base + skip;
-	copy = min(bytes, iov->iov_len - skip);
-
-	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_readable(buf, copy)) {
-		kaddr = kmap_atomic(page);
-		to = kaddr + offset;
-
-		/* first chunk, usually the only one */
-		left = copyin(to, buf, copy);
-		copy -= left;
-		skip += copy;
-		to += copy;
-		bytes -= copy;
-
-		while (unlikely(!left && bytes)) {
-			iov++;
-			buf = iov->iov_base;
-			copy = min(bytes, iov->iov_len);
-			left = copyin(to, buf, copy);
-			copy -= left;
-			skip = copy;
-			to += copy;
-			bytes -= copy;
-		}
-		if (likely(!bytes)) {
-			kunmap_atomic(kaddr);
-			goto done;
-		}
-		offset = to - kaddr;
-		buf += copy;
-		kunmap_atomic(kaddr);
-		copy = min(bytes, iov->iov_len - skip);
-	}
-	/* Too bad - revert to non-atomic kmap */
-
-	kaddr = kmap(page);
-	to = kaddr + offset;
-	left = copyin(to, buf, copy);
-	copy -= left;
-	skip += copy;
-	to += copy;
-	bytes -= copy;
-	while (unlikely(!left && bytes)) {
-		iov++;
-		buf = iov->iov_base;
-		copy = min(bytes, iov->iov_len);
-		left = copyin(to, buf, copy);
-		copy -= left;
-		skip = copy;
-		to += copy;
-		bytes -= copy;
-	}
-	kunmap(page);
-
-done:
-	if (skip == iov->iov_len) {
-		iov++;
-		skip = 0;
-	}
-	i->count -= wanted - bytes;
-	i->nr_segs -= iov - i->iov;
-	i->iov = iov;
-	i->iov_offset = skip;
-	return wanted - bytes;
-}
-
 #ifdef PIPE_PARANOIA
 static bool sanity(const struct iov_iter *i)
 {
@@ -848,24 +680,14 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 static size_t __copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-	if (likely(iter_is_iovec(i)))
-		return copy_page_to_iter_iovec(page, offset, bytes, i);
-	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
+		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	} else {
 		void *kaddr = kmap_local_page(page);
 		size_t wanted = _copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_local(kaddr);
 		return wanted;
 	}
-	if (iov_iter_is_pipe(i))
-		return copy_page_to_iter_pipe(page, offset, bytes, i);
-	if (unlikely(iov_iter_is_discard(i))) {
-		if (unlikely(i->count < bytes))
-			bytes = i->count;
-		i->count -= bytes;
-		return bytes;
-	}
-	WARN_ON(1);
-	return 0;
 }
 
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
@@ -896,17 +718,12 @@ EXPORT_SYMBOL(copy_page_to_iter);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-	if (unlikely(!page_copy_sane(page, offset, bytes)))
-		return 0;
-	if (likely(iter_is_iovec(i)))
-		return copy_page_from_iter_iovec(page, offset, bytes, i);
-	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
+	if (page_copy_sane(page, offset, bytes)) {
 		void *kaddr = kmap_local_page(page);
 		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_local(kaddr);
 		return wanted;
 	}
-	WARN_ON(1);
 	return 0;
 }
 EXPORT_SYMBOL(copy_page_from_iter);
-- 
2.30.2

