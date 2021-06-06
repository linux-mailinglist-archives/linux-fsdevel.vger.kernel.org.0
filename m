Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37E739D09C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhFFTMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhFFTMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046CC06178B;
        Sun,  6 Jun 2021 12:10:52 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAd-0056ZM-RU; Sun, 06 Jun 2021 19:10:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 09/37] iov_iter: switch ..._full() variants of primitives to use of iov_iter_revert()
Date:   Sun,  6 Jun 2021 19:10:23 +0000
Message-Id: <20210606191051.1216821-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use corresponding plain variants, revert on short copy.  That's the way it
should've been done from the very beginning, except that we didn't have
iov_iter_revert() back then...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/uio.h |  32 ++++++++++------
 lib/iov_iter.c      | 104 ----------------------------------------------------
 2 files changed, 21 insertions(+), 115 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 74a401f04bd3..c697c23138b5 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -132,9 +132,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
-bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
-bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i);
 
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
@@ -157,10 +155,11 @@ size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 static __always_inline __must_check
 bool copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, false)))
-		return false;
-	else
-		return _copy_from_iter_full(addr, bytes, i);
+	size_t copied = copy_from_iter(addr, bytes, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, bytes - copied);
+	return false;
 }
 
 static __always_inline __must_check
@@ -175,10 +174,11 @@ size_t copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 static __always_inline __must_check
 bool copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, false)))
-		return false;
-	else
-		return _copy_from_iter_full_nocache(addr, bytes, i);
+	size_t copied = copy_from_iter_nocache(addr, bytes, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, bytes - copied);
+	return false;
 }
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
@@ -278,7 +278,17 @@ struct csum_state {
 
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csstate, struct iov_iter *i);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
-bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+
+static __always_inline __must_check
+bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
+				  __wsum *csum, struct iov_iter *i)
+{
+	size_t copied = csum_and_copy_from_iter(addr, bytes, csum, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, bytes - copied);
+	return false;
+}
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index bdbe6691457d..ce9f8b9168ea 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -819,35 +819,6 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(_copy_from_iter);
 
-bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
-{
-	char *to = addr;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
-		return false;
-	}
-	if (unlikely(i->count < bytes))
-		return false;
-
-	if (iter_is_iovec(i))
-		might_fault();
-	iterate_all_kinds(i, bytes, v, ({
-		if (copyin((to += v.iov_len) - v.iov_len,
-				      v.iov_base, v.iov_len))
-			return false;
-		0;}),
-		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len)
-	)
-
-	iov_iter_advance(i, bytes);
-	return true;
-}
-EXPORT_SYMBOL(_copy_from_iter_full);
-
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
@@ -907,32 +878,6 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
 #endif
 
-bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
-{
-	char *to = addr;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
-		return false;
-	}
-	if (unlikely(i->count < bytes))
-		return false;
-	iterate_all_kinds(i, bytes, v, ({
-		if (__copy_from_user_inatomic_nocache((to += v.iov_len) - v.iov_len,
-					     v.iov_base, v.iov_len))
-			return false;
-		0;}),
-		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
-		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len)
-	)
-
-	iov_iter_advance(i, bytes);
-	return true;
-}
-EXPORT_SYMBOL(_copy_from_iter_full_nocache);
-
 static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 {
 	struct page *head;
@@ -1740,55 +1685,6 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter);
 
-bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
-			       struct iov_iter *i)
-{
-	char *to = addr;
-	__wsum sum, next;
-	size_t off = 0;
-	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
-		WARN_ON(1);
-		return false;
-	}
-	if (unlikely(i->count < bytes))
-		return false;
-	iterate_all_kinds(i, bytes, v, ({
-		next = csum_and_copy_from_user(v.iov_base,
-					       (to += v.iov_len) - v.iov_len,
-					       v.iov_len);
-		if (!next)
-			return false;
-		sum = csum_block_add(sum, next, off);
-		off += v.iov_len;
-		0;
-	}), ({
-		char *p = kmap_atomic(v.bv_page);
-		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
-				      p + v.bv_offset, v.bv_len,
-				      sum, off);
-		kunmap_atomic(p);
-		off += v.bv_len;
-	}),({
-		sum = csum_and_memcpy((to += v.iov_len) - v.iov_len,
-				      v.iov_base, v.iov_len,
-				      sum, off);
-		off += v.iov_len;
-	}), ({
-		char *p = kmap_atomic(v.bv_page);
-		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
-				      p + v.bv_offset, v.bv_len,
-				      sum, off);
-		kunmap_atomic(p);
-		off += v.bv_len;
-	})
-	)
-	*csum = sum;
-	iov_iter_advance(i, bytes);
-	return true;
-}
-EXPORT_SYMBOL(csum_and_copy_from_iter_full);
-
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 			     struct iov_iter *i)
 {
-- 
2.11.0

