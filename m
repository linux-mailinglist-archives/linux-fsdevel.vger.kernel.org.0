Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3946CC56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhLHE0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbhLHE0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44D6C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FDCiLoAhGLqsIRLI+os8SCB3HaHnYoT1HRwaxkznZEo=; b=SUwz0gekB4isoCrRAe5K1ZGvSk
        OYuTW31exgXmtNmi9vW4IUW0++ptqAaP9fZkdGZfYkixDXZ3tcDh7/OtGSqzMGiYGRaxEm24M3Xrj
        DfHG/0gJuHAasLwTjvHs+pAZq+0CKLDIDPIZD0wHXxiNH1vqNzVX2X//wsBKygCgKOxUe0i4qU5Rg
        X5IInjCg+2jJ58TtlY2fknclLxAuoKJJ2vC0eaK6o3u+3ViB7SvpsbLUbjeQWzN+D0fVrkGd640lP
        Fup2dHKcWSEcw7WgvF1epiGeXjVmlE9opOyZEYFSBq1V6INxNpc/18dfwTL1GsCK0haFOre3HnzLy
        zHJaJbfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU2-0084X2-1I; Wed, 08 Dec 2021 04:23:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/48] iov_iter: Add copy_folio_to_iter()
Date:   Wed,  8 Dec 2021 04:22:14 +0000
Message-Id: <20211208042256.1923824-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This wrapper around copy_page_to_iter() works because copy_page_to_iter()
handles compound pages correctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/uio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6350354f97e9..8479cf46b5b1 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -10,6 +10,7 @@
 #include <uapi/linux/uio.h>
 
 struct page;
+struct folio;
 struct pipe_inode_info;
 
 struct kvec {
@@ -146,6 +147,12 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
 
+static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
+		size_t bytes, struct iov_iter *i)
+{
+	return copy_page_to_iter((struct page *)folio, offset, bytes, i);
+}
+
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
-- 
2.33.0

