Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA732FE088
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbhAUEWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbhAUETc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:19:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F51C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CeaRo8c6b/tUy7+5q7QCW6FJs2iUrrBOGyex33Gpwzg=; b=aX9axA7Wt9qmMjkSbwq775kQhn
        Sq/B3Kd7H9NLH4PealQQOnu2LIV8HaVcSn+6BvjhQa9PpB0NMUzcxpUvLQbEHbq4l+m2t0Sp/7JYs
        YRO0AdYJj241TrwIpZjK7y4xllvQoA6i9HjFNNe9mm5eXClm/2zAvNdYxal3R2CEPstrM8iyOKw7L
        Zr21MSbEHEBscAjMBT3JZXLWt+Jr34xSOXrZsMyYBkd06RbggALPumbVZzzVaWwtr8D2f6BtzK/Be
        Sx7e6SrfVEjlWTh1GenyvcQhnOrpoWcvRitr6xEjq5vkYwITk0cOhKAgvaqWGKj9alLD2jxxqgaW0
        /zGrTqkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RPK-00GbBT-PW; Thu, 21 Jan 2021 04:17:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 02/18] mm/filemap: Remove dynamically allocated array from filemap_read
Date:   Thu, 21 Jan 2021 04:16:00 +0000
Message-Id: <20210121041616.3955703-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Increasing the batch size runs into diminishing returns.  It's probably
better to make, eg, three calls to filemap_get_pages() than it is to
call into kmalloc().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 934e04f1760ef..5dec04c8e16b0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2421,8 +2421,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
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
@@ -2433,14 +2433,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		return 0;
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
 
@@ -2525,9 +2517,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	file_accessed(filp);
 
-	if (pages != pages_onstack)
-		kfree(pages);
-
 	return written ? written : error;
 }
 EXPORT_SYMBOL_GPL(generic_file_buffered_read);
-- 
2.29.2

