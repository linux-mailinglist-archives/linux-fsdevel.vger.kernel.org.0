Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB5469981
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344642AbhLFOzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344574AbhLFOzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:55:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84789C061354;
        Mon,  6 Dec 2021 06:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aTX+GBheE+5rfH17iX8gNpId+mdnU8gPL4X6MEzfC+8=; b=E6vwOnNHKBEoc1va/tvLA68UM8
        KfnYs+cSe8YbLZmTgkga719UdkowD4fjC+lX5oGzLFG1GMMCtywmuM0nHOxfL3FWDenPoN7Skg/Gy
        rfITOofauLgS69jl8lBaj0DhMgHXfzSJboHZWl+i2u2psJQlv7T8rfLxHPnuMwvcueqUzVmp1Fy+l
        x/pcK+f1eIK04tXMz9Z3cVXv0OOWF/9C9rl5w82rKsDR+Cta6DDw56RxbiA9dYP9TPVDzeYVoh5DJ
        NVpKYHgleMyaU8PEcYmHAZQ3l4yo19nYW+zAqZRPU4beUZ1Y1ONT3eIVkTkNFV0Jst9qE2SMvJHbI
        +akQNTlg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFLp-004vkS-RR; Mon, 06 Dec 2021 14:52:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] iov_iter: Move internal documentation
Date:   Mon,  6 Dec 2021 14:52:20 +0000
Message-Id: <20211206145220.1175209-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206145220.1175209-1-willy@infradead.org>
References: <20211206145220.1175209-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the interfaces we want users to call (ie copy_mc_to_iter()
and copy_from_iter_flushcache()), not the internal interfaces.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/uio.h | 41 +++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c      | 41 -----------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 9fbce8c92545..4e5ad9053c97 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -244,6 +244,22 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 #define _copy_mc_to_iter _copy_to_iter
 #endif
 
+/**
+ * copy_from_iter_flushcache() - Write destination through cpu cache.
+ * @addr: destination kernel address
+ * @bytes: total transfer length
+ * @i: source iterator
+ *
+ * The pmem driver arranges for filesystem-dax to use this facility via
+ * dax_copy_from_iter() for ensuring that writes to persistent memory
+ * are flushed through the CPU cache. It is differentiated from
+ * _copy_from_iter_nocache() in that guarantees all data is flushed for
+ * all iterator types. The _copy_from_iter_nocache() only attempts to
+ * bypass the cache for the ITER_IOVEC case, and on some archs may use
+ * instructions that strand dirty-data in the cache.
+ *
+ * Return: Number of bytes copied (may be %0).
+ */
 static __always_inline __must_check
 size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -253,6 +269,31 @@ size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 		return _copy_from_iter_flushcache(addr, bytes, i);
 }
 
+/**
+ * copy_mc_to_iter() - Copy to iter with source memory error exception handling.
+ * @addr: source kernel address
+ * @bytes: total transfer length
+ * @i: destination iterator
+ *
+ * The pmem driver deploys this for the dax operation
+ * (dax_copy_to_iter()) for dax reads (bypass page-cache and the
+ * block-layer). Upon #MC read(2) aborts and returns EIO or the bytes
+ * successfully copied.
+ *
+ * The main differences between this and typical _copy_to_iter().
+ *
+ * * Typical tail/residue handling after a fault retries the copy
+ *   byte-by-byte until the fault happens again. Re-triggering machine
+ *   checks is potentially fatal so the implementation uses source
+ *   alignment and poison alignment assumptions to avoid re-triggering
+ *   hardware exceptions.
+ *
+ * * ITER_KVEC, ITER_PIPE, and ITER_BVEC can return short copies.
+ *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
+ *   a short copy.
+ *
+ * Return: Number of bytes copied (may be %0).
+ */
 static __always_inline __must_check
 size_t copy_mc_to_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 66a740e6e153..03b0e1dac27e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -715,31 +715,6 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
 	return xfer;
 }
 
-/**
- * _copy_mc_to_iter - copy to iter with source memory error exception handling
- * @addr: source kernel address
- * @bytes: total transfer length
- * @i: destination iterator
- *
- * The pmem driver deploys this for the dax operation
- * (dax_copy_to_iter()) for dax reads (bypass page-cache and the
- * block-layer). Upon #MC read(2) aborts and returns EIO or the bytes
- * successfully copied.
- *
- * The main differences between this and typical _copy_to_iter().
- *
- * * Typical tail/residue handling after a fault retries the copy
- *   byte-by-byte until the fault happens again. Re-triggering machine
- *   checks is potentially fatal so the implementation uses source
- *   alignment and poison alignment assumptions to avoid re-triggering
- *   hardware exceptions.
- *
- * * ITER_KVEC, ITER_PIPE, and ITER_BVEC can return short copies.
- *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
- *   a short copy.
- *
- * Return: number of bytes copied (may be %0)
- */
 size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
@@ -789,22 +764,6 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL(_copy_from_iter_nocache);
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
-/**
- * _copy_from_iter_flushcache - write destination through cpu cache
- * @addr: destination kernel address
- * @bytes: total transfer length
- * @i: source iterator
- *
- * The pmem driver arranges for filesystem-dax to use this facility via
- * dax_copy_from_iter() for ensuring that writes to persistent memory
- * are flushed through the CPU cache. It is differentiated from
- * _copy_from_iter_nocache() in that guarantees all data is flushed for
- * all iterator types. The _copy_from_iter_nocache() only attempts to
- * bypass the cache for the ITER_IOVEC case, and on some archs may use
- * instructions that strand dirty-data in the cache.
- *
- * Return: number of bytes copied (may be %0)
- */
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i))) {
-- 
2.33.0

