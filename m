Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2618246997D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbhLFOzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhLFOzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:55:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B20DC0613F8;
        Mon,  6 Dec 2021 06:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zJSDgHcVkwdTY4GyE+bifc3raxsicDWiNn5636t5DJ8=; b=SZtbhx0ZhqPWB0gkVltrFtrK88
        UF9t+xZtmZNWb+fh5YfrqnLj+XT6pcgF9GQmlReNsHOWywUaMln20eOa/cOP2sG7IWxi1Z+ONclUm
        5kT6t6dyZWAtVw2enzcj6T9ZsBQ5awVwDi0hxq02mlkzbFujQpduu6CDcpmxduRhtu8+0epaxCEac
        IHBIFd/d2rXw4DQSdQnumlcE6gUpaZbc26wamYMVs8STpOo/o0Mao9m45G6PRX2i5N01PtxNSUnIv
        sIhRq3dybhu6wGTBMoGT5rj++AKQlTBEbsY0xQQ2jf7ZdWAhvdgWpe5KhSBe30/ovqixLY5hacO36
        LqEhL55w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFLp-004vkJ-MX; Mon, 06 Dec 2021 14:52:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] iov_iter: Add kernel-doc
Date:   Mon,  6 Dec 2021 14:52:19 +0000
Message-Id: <20211206145220.1175209-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206145220.1175209-1-willy@infradead.org>
References: <20211206145220.1175209-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document enum iter_type, copy_to_iter() and copy_from_iter()

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/uio.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6350354f97e9..9fbce8c92545 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -17,6 +17,15 @@ struct kvec {
 	size_t iov_len;
 };
 
+/**
+ * enum iter_type - The type of memory referred to by the iterator.
+ * @ITER_IOVEC: An array of ranges of userspace memory.
+ * @ITER_KVEC: An array of ranges of kernel memory.
+ * @ITER_BVEC: An array of &struct bio_vec.
+ * @ITER_PIPE: A pipe.
+ * @ITER_XARRAY: A &struct xarray of pages.
+ * @ITER_DISCARD: No memory here; discard all writes.
+ */
 enum iter_type {
 	/* iter types */
 	ITER_IOVEC,
@@ -146,6 +155,18 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
 
+/**
+ * copy_to_iter() - Copy from kernel memory to an iterator.
+ * @addr: Kernel memory address.
+ * @bytes: Number of bytes to copy.
+ * @i: Destination of copy.
+ *
+ * Copy @bytes from @addr to @i.  The region of memory pointed to by @i must
+ * not overlap the region pointed to by @addr.  @i may point to any kind
+ * of &enum iter_type memory.
+ *
+ * Return: Number of bytes successfully copied to the iterator.
+ */
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -155,6 +176,18 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return _copy_to_iter(addr, bytes, i);
 }
 
+/**
+ * copy_from_iter() - Copy from an iterator to kernel memory.
+ * @addr: Kernel memory address.
+ * @bytes: Number of bytes to copy.
+ * @i: Source of memory.
+ *
+ * Copy @bytes from @i to @addr.  The region of memory pointed to by @i must
+ * not overlap the region pointed to by @addr.  @i may point to any kind
+ * of &enum iter_type memory.
+ *
+ * Return: Number of bytes successfully copied from the iterator.
+ */
 static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-- 
2.33.0

