Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6242B6FCC28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjEIRAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjEIQ7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:59:08 -0400
Received: from out-50.mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4215461BA
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQzCDYvJ0lsDeSo/s7SzXt92I5sJ/6Jd0MY/kK+yD7U=;
        b=PHvXBmFrG1haHZH++ByGkbPhrVLFCqbuynFUtixhqKw8mL0m5MIf5c7OUEjz7eapdhaScW
        hCJHsByetQerY+RW9TsdnWKMQdY24yvdwZbxmirMlKSiBi5Di6g55JhMWL5pXOi8+suAQa
        Dg3gJDde1WSrFwgXqlCxQnFt2d4bGZY=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 23/32] iov_iter: copy_folio_from_iter_atomic()
Date:   Tue,  9 May 2023 12:56:48 -0400
Message-Id: <20230509165657.1735798-24-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a foliated version of copy_page_from_iter_atomic()

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 53 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27e3fd9429..b2c281cb10 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -154,6 +154,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 
 size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
+size_t copy_folio_from_iter_atomic(struct folio *folio, size_t offset,
+				   size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4ea..27ba7e9f9e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -800,18 +800,10 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
-size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
-				  struct iov_iter *i)
+static inline size_t __copy_page_from_iter_atomic(struct page *page, unsigned offset,
+						  size_t bytes, struct iov_iter *i)
 {
 	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
-	if (!page_copy_sane(page, offset, bytes)) {
-		kunmap_atomic(kaddr);
-		return 0;
-	}
-	if (WARN_ON_ONCE(!i->data_source)) {
-		kunmap_atomic(kaddr);
-		return 0;
-	}
 	iterate_and_advance(i, bytes, base, len, off,
 		copyin(p + off, base, len),
 		memcpy(p + off, base, len)
@@ -819,8 +811,49 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 	kunmap_atomic(kaddr);
 	return bytes;
 }
+
+size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
+				  struct iov_iter *i)
+{
+	if (!page_copy_sane(page, offset, bytes))
+		return 0;
+	if (WARN_ON_ONCE(!i->data_source))
+		return 0;
+	return __copy_page_from_iter_atomic(page, offset, bytes, i);
+}
 EXPORT_SYMBOL(copy_page_from_iter_atomic);
 
+size_t copy_folio_from_iter_atomic(struct folio *folio, size_t offset,
+				   size_t bytes, struct iov_iter *i)
+{
+	size_t ret = 0;
+
+	if (WARN_ON(offset + bytes > folio_size(folio)))
+		return 0;
+	if (WARN_ON_ONCE(!i->data_source))
+		return 0;
+
+#ifdef CONFIG_HIGHMEM
+	while (bytes) {
+		struct page *page = folio_page(folio, offset >> PAGE_SHIFT);
+		unsigned b = min(bytes, PAGE_SIZE - (offset & PAGE_MASK));
+		unsigned r = __copy_page_from_iter_atomic(page, offset, b, i);
+
+		offset	+= r;
+		bytes	-= r;
+		ret	+= r;
+
+		if (r != b)
+			break;
+	}
+#else
+	ret = __copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
+#endif
+
+	return ret;
+}
+EXPORT_SYMBOL(copy_folio_from_iter_atomic);
+
 static void pipe_advance(struct iov_iter *i, size_t size)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-- 
2.40.1

