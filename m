Return-Path: <linux-fsdevel+bounces-7811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73D82B52F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD141C203A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B355786;
	Thu, 11 Jan 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IBMLR1cp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FB55769
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=1aClPF8NFde6vj1p83d9fRStlmOrQyle/sYQxH/POPg=; b=IBMLR1cpiXkGWSgkFTw9i6+m38
	A5qacrSg1XbR1AxZmIXtcccXLpbpKHm81e9Aq/tmZ68otUHYOFaSWsfC0afg71SZklPAgCximC78t
	BHGZ823T7vliTInEVC7HSDyNPJJn3+MNJhJh7NJpboQAhQvLhCnMWCzA10B304Ge6bNqOb0t/D9qu
	5898eQyrlo3PjqcH8k4O64h6AZz1/f7K30BlHkFW0HEqzgpOJlEakZKFsbazAQa04j+7ftw5kcNhv
	vJbYDq9kjIRR5GLX7csPhNEUOFffVD625Lt1z8CExGwC//FdDwjVIM+jkEOyeieOOWNEdPr+mKaFS
	ZYGM2C4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rO0fy-00Ei2l-UJ; Thu, 11 Jan 2024 19:25:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] filemap: Convert generic_perform_write() to support large folios
Date: Thu, 11 Jan 2024 19:25:13 +0000
Message-Id: <20240111192513.3505769-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modelled after the loop in iomap_write_iter(), copy larger chunks from
userspace if the filesystem has created large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 750e779c23db..964d5d7b9721 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3893,6 +3893,7 @@ EXPORT_SYMBOL(generic_file_direct_write);
 ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
+	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	loff_t pos = iocb->ki_pos;
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
@@ -3901,16 +3902,18 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 
 	do {
 		struct page *page;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
+		struct folio *folio;
+		size_t offset;		/* Offset into folio */
+		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 		void *fsdata = NULL;
 
-		offset = (pos & (PAGE_SIZE - 1));
-		bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_count(i));
+		bytes = iov_iter_count(i);
+retry:
+		offset = pos & (chunk - 1);
+		bytes = min(chunk - offset, bytes);
+		balance_dirty_pages_ratelimited(mapping);
 
-again:
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
@@ -3932,11 +3935,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		if (unlikely(status < 0))
 			break;
 
+		folio = page_folio(page);
+		offset = offset_in_folio(folio, pos);
+		if (bytes > folio_size(folio) - offset)
+			bytes = folio_size(folio) - offset;
+
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
-		flush_dcache_page(page);
+		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
+		flush_dcache_folio(folio);
 
 		status = a_ops->write_end(file, mapping, pos, bytes, copied,
 						page, fsdata);
@@ -3954,14 +3962,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			if (copied)
+			if (chunk > PAGE_SIZE)
+				chunk /= 2;
+			if (copied) {
 				bytes = copied;
-			goto again;
+				goto retry;
+			}
+		} else {
+			pos += status;
+			written += status;
 		}
-		pos += status;
-		written += status;
-
-		balance_dirty_pages_ratelimited(mapping);
 	} while (iov_iter_count(i));
 
 	if (!written)
-- 
2.43.0


