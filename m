Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE353F4D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiFGEJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFGEJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:09:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B8BCA3C6
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jknoJQ92h4cswHLsSG3/W6P6N2bECbisLr5tEqHbuA8=; b=eAk3TDMySklNvghehd/OZI44w+
        nBAAmbLWrcQ5SAm/Z9HbNUulYuUG398LkFJqlUK6FLJ6Sx9YmM4N0eoHaZAx+DKfpw6VFRqvuVsFX
        +QSV37y181fHFHUM2yD6zuIiIo43FZkRLDGt3q7fTE0lzrHqVMWEK+8jB/QdfmAfajBJ+2oU199xF
        i1RwumMMkVMFSfd+jsbHoTIwgRKx9pCbvVk+AORix+bocFuIW4PRnJKuzQPYe/jQtfqU8Mbd/142s
        NmScad2vt/T98+EbQ9GVhbvTD8B+VnEJ68aLogzNusmgsw1hBsfudI/daJfvpDMGCmF+nyTuhB0Je
        xk+wy8Iw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyQWx-004YjI-Om; Tue, 07 Jun 2022 04:09:23 +0000
Date:   Tue, 7 Jun 2022 04:09:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/9] No need of likely/unlikely on calls of check_copy_size()
Message-ID: <Yp7Pc2PFBke5FyWa@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

it's inline and unlikely() inside of it (including the implicit one
in WARN_ON_ONCE()) suffice to convince the compiler that getting
false from check_copy_size() is unlikely.

Spotted-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/include/asm/uaccess.h |  2 +-
 arch/s390/include/asm/uaccess.h    |  4 ++--
 include/linux/uaccess.h            |  4 ++--
 include/linux/uio.h                | 15 ++++++---------
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 9b82b38ff867..105f200b1e31 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -348,7 +348,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned long size)
 static inline unsigned long __must_check
 copy_mc_to_user(void __user *to, const void *from, unsigned long n)
 {
-	if (likely(check_copy_size(from, n, true))) {
+	if (check_copy_size(from, n, true)) {
 		if (access_ok(to, n)) {
 			allow_write_to_user(to, n);
 			n = copy_mc_generic((void *)to, from, n);
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index f4511e21d646..c2c9995466e0 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -39,7 +39,7 @@ _copy_from_user_key(void *to, const void __user *from, unsigned long n, unsigned
 static __always_inline unsigned long __must_check
 copy_from_user_key(void *to, const void __user *from, unsigned long n, unsigned long key)
 {
-	if (likely(check_copy_size(to, n, false)))
+	if (check_copy_size(to, n, false))
 		n = _copy_from_user_key(to, from, n, key);
 	return n;
 }
@@ -50,7 +50,7 @@ _copy_to_user_key(void __user *to, const void *from, unsigned long n, unsigned l
 static __always_inline unsigned long __must_check
 copy_to_user_key(void __user *to, const void *from, unsigned long n, unsigned long key)
 {
-	if (likely(check_copy_size(from, n, true)))
+	if (check_copy_size(from, n, true))
 		n = _copy_to_user_key(to, from, n, key);
 	return n;
 }
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 5a328cf02b75..47e5d374c7eb 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -148,7 +148,7 @@ _copy_to_user(void __user *, const void *, unsigned long);
 static __always_inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	if (likely(check_copy_size(to, n, false)))
+	if (check_copy_size(to, n, false))
 		n = _copy_from_user(to, from, n);
 	return n;
 }
@@ -156,7 +156,7 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	if (likely(check_copy_size(from, n, true)))
+	if (check_copy_size(from, n, true))
 		n = _copy_to_user(to, from, n);
 	return n;
 }
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285fe5a2f..76d305f3d4c2 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -156,19 +156,17 @@ static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, true)))
-		return 0;
-	else
+	if (check_copy_size(addr, bytes, true))
 		return _copy_to_iter(addr, bytes, i);
+	return 0;
 }
 
 static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, false)))
-		return 0;
-	else
+	if (check_copy_size(addr, bytes, false))
 		return _copy_from_iter(addr, bytes, i);
+	return 0;
 }
 
 static __always_inline __must_check
@@ -184,10 +182,9 @@ bool copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 static __always_inline __must_check
 size_t copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, false)))
-		return 0;
-	else
+	if (check_copy_size(addr, bytes, false))
 		return _copy_from_iter_nocache(addr, bytes, i);
+	return 0;
 }
 
 static __always_inline __must_check
-- 
2.30.2

