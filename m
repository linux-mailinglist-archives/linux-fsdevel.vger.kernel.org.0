Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E068C6757DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjATO6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjATO6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:58:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41FA4FAD2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 06:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=d+qxOFTo64MexSqtQ3SnPnYCe3GWPcwdD4xngzdKZlA=; b=Hyed/f0GU4ys5keUjxYlS1UGau
        k83DbyEH40qNuIFij0TWpQzFSqyQNAO55CU8F/h1YQPwHPcNET0NiZY2ET/VLhaw/dhYyrxfpsxD0
        y7L10XYeJm7LvQKCOgnChqakhCgkds5jsqpjRPIdjmN3bBcLhwzX+jtwMmEdN9RMZpR0VsdQFVCNw
        Bh7G863GDlB0kd1MSYXibhfLPOAaZLkoIiFyP6PGrp+oGKgyaYGfLDOH3fo11KI7a20svWqcT75NO
        qE3POwaiwFpJInt06LFF5M7GhrJ5NWas4k7jcQNcpu9qYf2moU7hzJOlCWF1N+0+JDBSw5UPASEJb
        3q9/xDaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIsq1-0022sG-Az; Fri, 20 Jan 2023 14:57:53 +0000
Date:   Fri, 20 Jan 2023 14:57:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RFC] memcpy_from_folio()
Message-ID: <Y8qr8c3+SJLGWhUo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think I have a good folio replacement for memcpy_from_page().  One of
the annoying things about dealing with multi-page folios is that you
can't kmap the entire folio, yet on systems without highmem, you don't
need to.  It's also somewhat annoying in the caller to keep track
of n/len/offset/pos/...

I think this is probably the best option.  We could have a loop that
kmaps each page in the folio, but that seems like excessive complexity.
I'm happy to have highmem systems be less efficient, since they are
anyway.  Another potential area of concern is that folios can be quite
large and maybe having preemption disabled while we copy 2MB of data
might be a bad thing.  If so, the API is fine with limiting the amount
of data we copy, we just need to find out that it is a problem and
decide what the correct limit is, if it's not folio_size().

 fs/ext4/verity.c           |   16 +++++++---------
 include/linux/highmem.h    |   29 +++++++++++++++++++++++++++++
 include/linux/page-flags.h |    1 +
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index e4da1704438e..afe847c967a4 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -42,18 +42,16 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 			  loff_t pos)
 {
 	while (count) {
-		size_t n = min_t(size_t, count,
-				 PAGE_SIZE - offset_in_page(pos));
-		struct page *page;
+		struct folio *folio;
+		size_t n;
 
-		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
+		folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT,
 					 NULL);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
-
-		memcpy_from_page(buf, page, offset_in_page(pos), n);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		put_page(page);
+		n = memcpy_from_file_folio(buf, folio, pos, count);
+		folio_put(folio);
 
 		buf += n;
 		pos += n;
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 9fa462561e05..9917357b9e8f 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -414,6 +414,35 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
 	kunmap_local(addr);
 }
 
+/**
+ * memcpy_from_file_folio - Copy some bytes from a file folio.
+ * @to: The destination buffer.
+ * @folio: The folio to copy from.
+ * @pos: The position in the file.
+ * @len: The maximum number of bytes to copy.
+ *
+ * Copy up to @len bytes from this folio.  This may be limited by PAGE_SIZE
+ * if the folio comes from HIGHMEM, and by the size of the folio.
+ *
+ * Return: The number of bytes copied from the folio.
+ */
+static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
+		loff_t pos, size_t len)
+{
+	size_t offset = offset_in_folio(folio, pos);
+	char *from = kmap_local_folio(folio, offset);
+
+	if (folio_test_highmem(folio))
+		len = min(len, PAGE_SIZE - offset);
+	else
+		len = min(len, folio_size(folio) - offset);
+
+	memcpy(to, from, len);
+	kunmap_local(from);
+
+	return len;
+}
+
 /**
  * folio_zero_segments() - Zero two byte ranges in a folio.
  * @folio: The folio to write to.
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index bc09194d372f..bba2a32031a2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -531,6 +531,7 @@ PAGEFLAG(Readahead, readahead, PF_NO_COMPOUND)
  * available at this point.
  */
 #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
+#define folio_test_highmem(__f)	is_highmem_idx(folio_zonenum(__f))
 #else
 PAGEFLAG_FALSE(HighMem, highmem)
 #endif

