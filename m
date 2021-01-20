Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B43A2FD4FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403780AbhATQIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 11:08:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:42852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391398AbhATQHB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:07:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA4F7AC85;
        Wed, 20 Jan 2021 16:06:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B0A311E082A; Wed, 20 Jan 2021 17:06:18 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] mm: Provide address_space operation for filling pages for read
Date:   Wed, 20 Jan 2021 17:06:10 +0100
Message-Id: <20210120160611.26853-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120160611.26853-1-jack@suse.cz>
References: <20210120160611.26853-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide an address_space operation for filling pages needed for read
into page cache. Filesystems can use this operation to seriealize
page cache filling with e.g. hole punching properly.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs.h |  5 +++++
 mm/filemap.c       | 32 ++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..1d3f963d0d99 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -381,6 +381,9 @@ struct address_space_operations {
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
 	void (*readahead)(struct readahead_control *);
+	/* Fill in uptodate pages for kiocb into page cache and pagep array */
+	int (*fill_pages)(struct kiocb *, size_t len, bool partial_page,
+			  struct page **pagep, unsigned int nr_pages);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
@@ -2962,6 +2965,8 @@ extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
+extern int generic_file_buffered_read_get_pages(struct kiocb *iocb, size_t len,
+		bool partial_page, struct page **pages, unsigned int nr);
 extern ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		struct iov_iter *to, ssize_t already_read);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 7029bada8e90..5b594dd245e0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2333,10 +2333,24 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb)
 	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
 }
 
-static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
-						size_t len, bool partial_page,
-						struct page **pages,
-						unsigned int nr)
+/**
+ * generic_file_buffered_read_get_pages - generic routine to fill in page cache
+ *	pages for a read
+ * @iocb:	the iocb to read
+ * @len:	number of bytes to read
+ * @partial_page:	are partially uptodate pages accepted by read?
+ * @pages:	array where to fill in found pages
+ * @nr:		number of pages in the @pages array
+ *
+ * Fill pages into page cache and @pages array needed for a read of length @len
+ * described by @iocb.
+ *
+ * Return:
+ * Number of pages filled in the array
+ */
+int generic_file_buffered_read_get_pages(struct kiocb *iocb, size_t len,
+					 bool partial_page,
+					 struct page **pages, unsigned int nr)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2419,6 +2433,7 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 	 */
 	goto find_page;
 }
+EXPORT_SYMBOL(generic_file_buffered_read_get_pages);
 
 /**
  * generic_file_buffered_read - generic file read routine
@@ -2447,6 +2462,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	unsigned int nr_pages = min_t(unsigned int, 512,
 			((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
 			(iocb->ki_pos >> PAGE_SHIFT));
+	int (*fill_pages)(struct kiocb *, size_t, bool, struct page **,
+			  unsigned int) = mapping->a_ops->fill_pages;
 	int i, pg_nr, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
@@ -2456,6 +2473,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	if (unlikely(!iov_iter_count(iter)))
 		return 0;
 
+	if (!fill_pages)
+		fill_pages = generic_file_buffered_read_get_pages;
+
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
 	if (nr_pages > ARRAY_SIZE(pages_onstack))
@@ -2478,8 +2498,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		i = 0;
-		pg_nr = generic_file_buffered_read_get_pages(iocb, iter->count,
-				!iov_iter_is_pipe(iter), pages, nr_pages);
+		pg_nr = fill_pages(iocb, iter->count, !iov_iter_is_pipe(iter),
+				   pages, nr_pages);
 		if (pg_nr < 0) {
 			error = pg_nr;
 			break;
-- 
2.26.2

