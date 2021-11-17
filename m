Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F98454508
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhKQKfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 05:35:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236396AbhKQKfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637145137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MZpcj2Z8HdqZb1jgsG7GAEGnobLmuYt+4j5fMfR9g4Q=;
        b=e7OKBqLZAOrjJ5RIN12vumwdEutbsXfjgsSDZ4LM/x8YQmQddYRPJBgwpjoi7RNkL2d+iM
        Gr6+evBlqm4aki5BMJxj7/Tjsqkb753BZMwpVQJmv/h+K2/FFCipDEXxVeU5wd3wZZUXeS
        qSv96ITakHnaYAmUFQeXfDFlgsP0j30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-YA-Jy2PFOpqgfJtDqLitkQ-1; Wed, 17 Nov 2021 05:32:14 -0500
X-MC-Unique: YA-Jy2PFOpqgfJtDqLitkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09CBC8190A6;
        Wed, 17 Nov 2021 10:32:13 +0000 (UTC)
Received: from max.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A5C65DEFA;
        Wed, 17 Nov 2021 10:32:03 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] iomap: iomap_read_inline_data cleanup
Date:   Wed, 17 Nov 2021 11:32:02 +0100
Message-Id: <20211117103202.44346-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change iomap_read_inline_data to return 0 or an error code; this
simplifies the callers.  Add a description.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fe10d8a30f6b..f1bc9a35184d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,7 +205,15 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
+/**
+ * iomap_read_inline_data - copy inline data into the page cache
+ * @iter: iteration structure
+ * @page: page to copy to
+ *
+ * Copy the inline data in @iter into @page and zero out the rest of the page.
+ * Only a single IOMAP_INLINE extent is allowed at the end of each file.
+ */
+static int iomap_read_inline_data(const struct iomap_iter *iter,
 		struct page *page)
 {
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
@@ -214,7 +222,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 	void *addr;
 
 	if (PageUptodate(page))
-		return PAGE_SIZE - poff;
+		return 0;
 
 	if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
 		return -EIO;
@@ -231,7 +239,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
 	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
-	return PAGE_SIZE - poff;
+	return 0;
 }
 
 static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
@@ -256,13 +264,8 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	unsigned poff, plen;
 	sector_t sector;
 
-	if (iomap->type == IOMAP_INLINE) {
-		loff_t ret = iomap_read_inline_data(iter, page);
-
-		if (ret < 0)
-			return ret;
-		return 0;
-	}
+	if (iomap->type == IOMAP_INLINE)
+		return iomap_read_inline_data(iter, page);
 
 	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(iter->inode, page);
@@ -587,15 +590,10 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
 		struct page *page)
 {
-	int ret;
-
 	/* needs more work for the tailpacking case; disable for now */
 	if (WARN_ON_ONCE(iomap_iter_srcmap(iter)->offset != 0))
 		return -EIO;
-	ret = iomap_read_inline_data(iter, page);
-	if (ret < 0)
-		return ret;
-	return 0;
+	return iomap_read_inline_data(iter, page);
 }
 
 static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
-- 
2.31.1

