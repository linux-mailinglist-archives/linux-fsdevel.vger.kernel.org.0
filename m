Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA56C554160
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356768AbiFVEQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356544AbiFVEP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035E263
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QUDzf60Onc1SNFZ87AREnowp6ZnsYcKR6SjVT2XRbD4=; b=VVVRt94+3axDMjxuWHiTvrdp+C
        HTiX7gsAYQakYsOB1sWHLZ9RsITlWJ/RzLjVVT8dT7ypa+JntSQQtC/ryFD6+Te4eFS45K5CPM2ca
        ntMNqBomXcbmA83URzRwf4GMkGMBpK+sKIX/S2djA5q8Z4xnglw2IPTSQgUG/QYAjBrvchNmTweQ7
        lazAcyELm22aQdZjsWgC51I2M6I2tM3bG35Z8vLsQE1gpFSiKXvgZjBjyoVUR/94QqxKKh8L6ieIg
        9SKxajJR5jL6NuJIQ6942MzWfIhZS8Iwb8sah0iIGMrSiznoHD3HC85LEZd1CB3ne8C+gSD5IdH+q
        SnePNHGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmS-0035vP-My;
        Wed, 22 Jun 2022 04:15:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 02/44] No need of likely/unlikely on calls of check_copy_size()
Date:   Wed, 22 Jun 2022 05:15:10 +0100
Message-Id: <20220622041552.737754-2-viro@zeniv.linux.org.uk>
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

it's inline and unlikely() inside of it (including the implicit one
in WARN_ON_ONCE()) suffice to convince the compiler that getting
false from check_copy_size() is unlikely.

Spotted-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
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

