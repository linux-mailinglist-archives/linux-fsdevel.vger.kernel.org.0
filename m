Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77492FD514
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391254AbhATQIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 11:08:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:42854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391399AbhATQHB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:07:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA3A0AC7B;
        Wed, 20 Jan 2021 16:06:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ADEC41E07FD; Wed, 20 Jan 2021 17:06:18 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] mm: Do not pass iter into generic_file_buffered_read_get_pages()
Date:   Wed, 20 Jan 2021 17:06:09 +0100
Message-Id: <20210120160611.26853-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120160611.26853-1-jack@suse.cz>
References: <20210120160611.26853-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

generic_file_buffered_read_get_pages() needs to only know the length we
want to read and whether partially uptodate pages are accepted. Also
principially this function just loads pages into page cache so it does
not need to know about user buffers to copy data to. Pass the length and
whether partially uptodate pages are acceptable into
generic_file_buffered_read_get_pages() instead of iter.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/filemap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5c9d564317a5..7029bada8e90 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2235,7 +2235,7 @@ generic_file_buffered_read_readpage(struct kiocb *iocb,
 static struct page *
 generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 					   struct file *filp,
-					   struct iov_iter *iter,
+					   bool partial_page,
 					   struct page *page,
 					   loff_t pos, loff_t count)
 {
@@ -2264,8 +2264,8 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 	if (inode->i_blkbits == PAGE_SHIFT ||
 			!mapping->a_ops->is_partially_uptodate)
 		goto page_not_up_to_date;
-	/* pipes can't handle partially uptodate pages */
-	if (unlikely(iov_iter_is_pipe(iter)))
+	/* Some reads (e.g. pipes) don't accept partially uptodate pages */
+	if (unlikely(!partial_page))
 		goto page_not_up_to_date;
 	if (!trylock_page(page))
 		goto page_not_up_to_date;
@@ -2304,8 +2304,7 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 }
 
 static struct page *
-generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
-					  struct iov_iter *iter)
+generic_file_buffered_read_no_cached_page(struct kiocb *iocb)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2335,7 +2334,7 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 }
 
 static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
-						struct iov_iter *iter,
+						size_t len, bool partial_page,
 						struct page **pages,
 						unsigned int nr)
 {
@@ -2343,7 +2342,7 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 	struct address_space *mapping = filp->f_mapping;
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
+	pgoff_t last_index = (iocb->ki_pos + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	int i, j, nr_got, err = 0;
 
 	nr = min_t(unsigned long, last_index - index, nr);
@@ -2364,7 +2363,7 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 	if (nr_got)
 		goto got_pages;
 
-	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
+	pages[0] = generic_file_buffered_read_no_cached_page(iocb);
 	err = PTR_ERR_OR_ZERO(pages[0]);
 	if (!IS_ERR_OR_NULL(pages[0]))
 		nr_got = 1;
@@ -2374,7 +2373,7 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 		pgoff_t pg_index = index + i;
 		loff_t pg_pos = max(iocb->ki_pos,
 				    (loff_t) pg_index << PAGE_SHIFT);
-		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
+		loff_t pg_count = iocb->ki_pos + len - pg_pos;
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
@@ -2399,7 +2398,8 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 			}
 
 			page = generic_file_buffered_read_pagenotuptodate(iocb,
-					filp, iter, page, pg_pos, pg_count);
+					filp, partial_page, page, pg_pos,
+					pg_count);
 			if (IS_ERR_OR_NULL(page)) {
 				for (j = i + 1; j < nr_got; j++)
 					put_page(pages[j]);
@@ -2478,8 +2478,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		i = 0;
-		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
-							     pages, nr_pages);
+		pg_nr = generic_file_buffered_read_get_pages(iocb, iter->count,
+				!iov_iter_is_pipe(iter), pages, nr_pages);
 		if (pg_nr < 0) {
 			error = pg_nr;
 			break;
-- 
2.26.2

