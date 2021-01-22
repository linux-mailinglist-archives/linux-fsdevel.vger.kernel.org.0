Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F6130082D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbhAVQEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbhAVQEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:04:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653DDC0613D6;
        Fri, 22 Jan 2021 08:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bJrHcc3TRuo3zacTOm7nFFwlB8n6a0vSf1BsFy5yvWQ=; b=UKPS+BewMN+ObHxdDV7pNY8in4
        d9ph4PhrCy1FYoao5Lt9YvjBfIYfrHSEGPWJj5E9L9MqjqtRwEjM/ExkPiDCNm2Iz3kEYRU4oMpTF
        Bh206af6zhRXC8+wx7nYXN6SP3Ve3EiviJFg1ykq+SVM+jtVamePjfj5weYJDZYOgpXTa2fRcI+dB
        oU0g91XHwKHqpQ2mDQztKYZ1B3Jjh29uPgGR8Id45+TdAm/32EKm9715xAh/u3/DjrrzaAwFmJsbE
        +kIe6kkJZ6JqiFpGYQJlh0s4tFyqSWDzqI+mPBiplMywYnHsIIDzUZuJSfpSdVSMFhZ8RxrPbcUr9
        9ZJlmsRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2ytq-000wAw-An; Fri, 22 Jan 2021 16:03:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v5 02/18] mm/filemap: Remove dynamically allocated array from filemap_read
Date:   Fri, 22 Jan 2021 16:01:24 +0000
Message-Id: <20210122160140.223228-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Increasing the batch size runs into diminishing returns.  It's probably
better to make, eg, three calls to filemap_get_pages() than it is to
call into kmalloc().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/filemap.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index afc0f674f2242..a5c4f7ddfc40c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2444,8 +2444,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct page *pages_onstack[PAGEVEC_SIZE], **pages = NULL;
-	unsigned int nr_pages = min_t(unsigned int, 512,
+	struct page *pages[PAGEVEC_SIZE];
+	unsigned int nr_pages = min_t(unsigned int, PAGEVEC_SIZE,
 			((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
 			(iocb->ki_pos >> PAGE_SHIFT));
 	int i, pg_nr, error = 0;
@@ -2459,14 +2459,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
-	if (nr_pages > ARRAY_SIZE(pages_onstack))
-		pages = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
-
-	if (!pages) {
-		pages = pages_onstack;
-		nr_pages = min_t(unsigned int, nr_pages, ARRAY_SIZE(pages_onstack));
-	}
-
 	do {
 		cond_resched();
 
@@ -2551,9 +2543,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	file_accessed(filp);
 
-	if (pages != pages_onstack)
-		kfree(pages);
-
 	return written ? written : error;
 }
 EXPORT_SYMBOL_GPL(generic_file_buffered_read);
-- 
2.29.2

