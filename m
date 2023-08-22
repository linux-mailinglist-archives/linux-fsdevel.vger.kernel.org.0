Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF2784B28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjHVUKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 16:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHVUKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:10:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8FE60
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YP/7sStZVRPbg6FP6eEoLgCPnD2XJcRwLuSTXEuB6pY=; b=nk/et57DYpZJD5JB9+4IyB5L8j
        vW9CQl2p9yLfZ07LoxkicQtsTk+XgVmOLul8E0BNP5SD6St5bp/IDKreccZGUjPN9ca+NY0m3h0tI
        jzliYQeyWZnOsn/t6GMYwQkaPnzU6bXsGGpnd2XpsaWeZ7ZO5jIVWTzdTdlKDKA5T7o0Wqdm31pFP
        m4CE++DOAIZwm+t1b43DvMdg2mzGnXhHH1DURuncTYuKm4QtGIvFe+8dAG9qpu7M2dI78CL3rbOyF
        vFvy/D/WZao1q59HO7+jLs8xo46rDV+hwXmApvhdx+zzssf23J5Ds4qu+o4/8zSlgtfnD0sucg4tL
        jt6YvN0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYXh8-000fbz-3i; Tue, 22 Aug 2023 20:09:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [RFC PATCH] filemap: Convert generic_perform_write() to support large folios
Date:   Tue, 22 Aug 2023 21:09:37 +0100
Message-Id: <20230822200937.159934-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modelled after the loop in iomap_write_iter(), copy larger chunks from
userspace if the filesystem has created large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
This patch dependss on patches currently in the iomap tree.  Sending it
out now for feedback, but I'll resend it after rc1.

 mm/filemap.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index bf6219d9aaac..fd28767c760a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3908,6 +3908,7 @@ EXPORT_SYMBOL(generic_file_direct_write);
 ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
+	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	loff_t pos = iocb->ki_pos;
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
@@ -3916,16 +3917,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 
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
+		offset = pos & (chunk - 1);
+		bytes = min(chunk - offset, iov_iter_count(i));
+		balance_dirty_pages_ratelimited(mapping);
 
-again:
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
@@ -3947,11 +3948,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
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
@@ -3971,12 +3977,12 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			 */
 			if (copied)
 				bytes = copied;
-			goto again;
+			if (chunk > PAGE_SIZE)
+				chunk /= 2;
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
2.40.1

