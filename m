Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43E5661E58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjAIFS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjAIFSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8AD127;
        Sun,  8 Jan 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=k+ZZta1I7fiddKSuD0VDKROProxG+mv989F2OQevFVE=; b=DoU3MBHwJXeUVlXpjR6BahDygE
        rEByLa9Kflz15xo39pKdfYcKiETrJxGAkDDIbdIRjAGz/2E2RS4zEGILLyeqi9+0oACdLFofz2Eyi
        s6f9m61E66DO+xVmMf8K2EY5OIGT2ttz5Q/c+eaMDstvvR5SvYWv5iL99XYnfo0i+EZw8gogjFn6/
        3CyvkQspNvX+c3ppbQ0JYxfo6J8koDQa9sFSx6I/T6fXMY28OQdYc1E8eM/bKizrOzUkkjPnOplht
        +UMBnwvIz/lKlPh5NwijUi27DC/U4yD7F7LdoRBlZnWa00pQ/DnconPqvKN98qR+aN5WcURO4Hv27
        J0LlnnNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYD-0020xB-Nx; Mon, 09 Jan 2023 05:18:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/11] filemap: Convert filemap_fdatawait_range() to errseq
Date:   Mon,  9 Jan 2023 05:18:19 +0000
Message-Id: <20230109051823.480289-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This removes the unwelcome behaviour of clearing the
errors in the address space, which is the same behaviour as
filemap_fdatawait_range_keep_errors(), so unify the two functions.
We can also get rid of filemap_fdatawait_keep_errors() as it is now the
same as filemap_fdatawait()

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  7 +++---
 mm/filemap.c            | 51 +----------------------------------------
 2 files changed, 5 insertions(+), 53 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 29e1f9e76eb6..985fd47739f4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -33,16 +33,17 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
 int filemap_flush(struct address_space *);
-int filemap_fdatawait_keep_errors(struct address_space *mapping);
 int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t lend);
-int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
-		loff_t start_byte, loff_t end_byte);
 
 static inline int filemap_fdatawait(struct address_space *mapping)
 {
 	return filemap_fdatawait_range(mapping, 0, LLONG_MAX);
 }
 
+#define filemap_fdatawait_range_keep_errors(mapping, start, end)	\
+	filemap_fdatawait_range(mapping, start, end)
+#define filemap_fdatawait_keep_errors(mapping)	filemap_fdatawait(mapping)
+
 bool filemap_range_has_page(struct address_space *, loff_t lstart, loff_t lend);
 int filemap_write_and_wait_range(struct address_space *mapping,
 		loff_t lstart, loff_t lend);
diff --git a/mm/filemap.c b/mm/filemap.c
index c72b2e1140d7..887520db115a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -526,43 +526,17 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
  * in the given range and wait for all of them.  Check error status of
  * the address space and return it.
  *
- * Since the error status of the address space is cleared by this function,
- * callers are responsible for checking the return value and handling and/or
- * reporting the error.
- *
  * Return: error status of the address space.
  */
 int filemap_fdatawait_range(struct address_space *mapping, loff_t start_byte,
 			    loff_t end_byte)
-{
-	__filemap_fdatawait_range(mapping, start_byte, end_byte);
-	return filemap_check_errors(mapping);
-}
-EXPORT_SYMBOL(filemap_fdatawait_range);
-
-/**
- * filemap_fdatawait_range_keep_errors - wait for writeback to complete
- * @mapping:		address space structure to wait for
- * @start_byte:		offset in bytes where the range starts
- * @end_byte:		offset in bytes where the range ends (inclusive)
- *
- * Walk the list of under-writeback pages of the given address space in the
- * given range and wait for all of them.  Unlike filemap_fdatawait_range(),
- * this function does not clear error status of the address space.
- *
- * Use this function if callers don't handle errors themselves.  Expected
- * call sites are system-wide / filesystem-wide data flushers: e.g. sync(2),
- * fsfreeze(8)
- */
-int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
-		loff_t start_byte, loff_t end_byte)
 {
 	errseq_t since = filemap_sample_wb_err(mapping);
 
 	__filemap_fdatawait_range(mapping, start_byte, end_byte);
 	return filemap_check_wb_err(mapping, since);
 }
-EXPORT_SYMBOL(filemap_fdatawait_range_keep_errors);
+EXPORT_SYMBOL(filemap_fdatawait_range);
 
 /**
  * file_fdatawait_range - wait for writeback to complete
@@ -589,29 +563,6 @@ int file_fdatawait_range(struct file *file, loff_t start_byte, loff_t end_byte)
 }
 EXPORT_SYMBOL(file_fdatawait_range);
 
-/**
- * filemap_fdatawait_keep_errors - wait for writeback without clearing errors
- * @mapping: address space structure to wait for
- *
- * Walk the list of under-writeback pages of the given address space
- * and wait for all of them.  Unlike filemap_fdatawait(), this function
- * does not clear error status of the address space.
- *
- * Use this function if callers don't handle errors themselves.  Expected
- * call sites are system-wide / filesystem-wide data flushers: e.g. sync(2),
- * fsfreeze(8)
- *
- * Return: error status of the address space.
- */
-int filemap_fdatawait_keep_errors(struct address_space *mapping)
-{
-	errseq_t since = filemap_sample_wb_err(mapping);
-
-	__filemap_fdatawait_range(mapping, 0, LLONG_MAX);
-	return filemap_check_wb_err(mapping, since);
-}
-EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
-
 /* Returns true if writeback might be needed or already in progress. */
 static bool mapping_needs_writeback(struct address_space *mapping)
 {
-- 
2.35.1

