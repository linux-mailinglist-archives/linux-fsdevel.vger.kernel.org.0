Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3DC694B4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 16:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBMPfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 10:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjBMPep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB46166FC
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 07:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676302404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49IJ7O8KaG9bUjSCVtwVGeadJYJCODKyAnH6L7XF9aY=;
        b=FMdqJECeFlR+MfhJwHt4trfFDc2lzEeLfA8htH1TzMru94SXe4AOHjxviUXUh9z58Phkgp
        FH3GW4s4nHOa/0QzLZELKkxy13tnHNxXtTzLUm7MEodLnIBChP1jvp8l46a0XwuzkjNBDO
        L/lGq1sBuyOnFw1f4+OjO+0XBW3ZnuU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-1yMYszxON0mvnfJn-xDpZA-1; Mon, 13 Feb 2023 10:33:17 -0500
X-MC-Unique: 1yMYszxON0mvnfJn-xDpZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0864D18A6464;
        Mon, 13 Feb 2023 15:33:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1696CC16022;
        Mon, 13 Feb 2023 15:33:14 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 4/4] splice: Move filemap_read_splice() to mm/filemap.c
Date:   Mon, 13 Feb 2023 15:33:01 +0000
Message-Id: <20230213153301.2338806-5-dhowells@redhat.com>
In-Reply-To: <20230213153301.2338806-1-dhowells@redhat.com>
References: <20230213153301.2338806-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move filemap_read_splice() to mm/filemap.c and make filemap_get_pages()
static again.

Requested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/splice.c             | 127 -------------------------------------
 include/linux/pagemap.h |   2 -
 include/linux/splice.h  |   4 ++
 mm/filemap.c            | 137 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 135 insertions(+), 135 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 4ea63d6a9040..341cd8fb47a8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -375,133 +375,6 @@ static ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	return ret;
 }
 
-/*
- * Splice subpages from a folio into a pipe.
- */
-static size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-				     struct folio *folio,
-				     loff_t fpos, size_t size)
-{
-	struct page *page;
-	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
-
-	page = folio_page(folio, offset / PAGE_SIZE);
-	size = min(size, folio_size(folio) - offset);
-	offset %= PAGE_SIZE;
-
-	while (spliced < size &&
-	       !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
-		struct pipe_buffer *buf = pipe_head_buf(pipe);
-		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
-
-		*buf = (struct pipe_buffer) {
-			.ops	= &page_cache_pipe_buf_ops,
-			.page	= page,
-			.offset	= offset,
-			.len	= part,
-		};
-		folio_get(folio);
-		pipe->head++;
-		page++;
-		spliced += part;
-		offset = 0;
-	}
-
-	return spliced;
-}
-
-/*
- * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file into
- * a pipe.
- */
-static ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
-				   struct pipe_inode_info *pipe,
-				   size_t len, unsigned int flags)
-{
-	struct folio_batch fbatch;
-	struct kiocb iocb;
-	size_t total_spliced = 0, used, npages;
-	loff_t isize, end_offset;
-	bool writably_mapped;
-	int i, error = 0;
-
-	init_sync_kiocb(&iocb, in);
-	iocb.ki_pos = *ppos;
-
-	/* Work out how much data we can actually add into the pipe */
-	used = pipe_occupancy(pipe->head, pipe->tail);
-	npages = max_t(ssize_t, pipe->max_usage - used, 0);
-	len = min_t(size_t, len, npages * PAGE_SIZE);
-
-	folio_batch_init(&fbatch);
-
-	do {
-		cond_resched();
-
-		if (*ppos >= i_size_read(file_inode(in)))
-			break;
-
-		iocb.ki_pos = *ppos;
-		error = filemap_get_pages(&iocb, len, &fbatch, true);
-		if (error < 0)
-			break;
-
-		/*
-		 * i_size must be checked after we know the pages are Uptodate.
-		 *
-		 * Checking i_size after the check allows us to calculate
-		 * the correct value for "nr", which means the zero-filled
-		 * part of the page is not copied back to userspace (unless
-		 * another truncate extends the file - this is desired though).
-		 */
-		isize = i_size_read(file_inode(in));
-		if (unlikely(*ppos >= isize))
-			break;
-		end_offset = min_t(loff_t, isize, *ppos + len);
-
-		/*
-		 * Once we start copying data, we don't want to be touching any
-		 * cachelines that might be contended:
-		 */
-		writably_mapped = mapping_writably_mapped(in->f_mapping);
-
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			struct folio *folio = fbatch.folios[i];
-			size_t n;
-
-			if (folio_pos(folio) >= end_offset)
-				goto out;
-			folio_mark_accessed(folio);
-
-			/*
-			 * If users can be writing to this folio using arbitrary
-			 * virtual addresses, take care of potential aliasing
-			 * before reading the folio on the kernel side.
-			 */
-			if (writably_mapped)
-				flush_dcache_folio(folio);
-
-			n = splice_folio_into_pipe(pipe, folio, *ppos, len);
-			if (!n)
-				goto out;
-			len -= n;
-			total_spliced += n;
-			*ppos += n;
-			in->f_ra.prev_pos = *ppos;
-			if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
-				goto out;
-		}
-
-		folio_batch_release(&fbatch);
-	} while (len);
-
-out:
-	folio_batch_release(&fbatch);
-	file_accessed(in);
-
-	return total_spliced ? total_spliced : error;
-}
-
 /**
  * generic_file_splice_read - splice data from file to a pipe
  * @in:		file to splice from
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3a7bdb35acff..29e1f9e76eb6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -748,8 +748,6 @@ struct page *read_cache_page(struct address_space *, pgoff_t index,
 		filler_t *filler, struct file *file);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
-int filemap_get_pages(struct kiocb *iocb, size_t count,
-		      struct folio_batch *fbatch, bool need_uptodate);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, struct file *file)
diff --git a/include/linux/splice.h b/include/linux/splice.h
index a55179fd60fc..691c44ef5c0b 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -67,6 +67,10 @@ typedef int (splice_actor)(struct pipe_inode_info *, struct pipe_buffer *,
 typedef int (splice_direct_actor)(struct pipe_inode_info *,
 				  struct splice_desc *);
 
+ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
+			    struct pipe_inode_info *pipe,
+			    size_t len, unsigned int flags);
+
 extern ssize_t splice_from_pipe(struct pipe_inode_info *, struct file *,
 				loff_t *, size_t, unsigned int,
 				splice_actor *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 6970be64a3e0..e1ee267675d2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -42,6 +42,8 @@
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
 #include <linux/migrate.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/splice.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2576,12 +2578,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 	return 0;
 }
 
-/*
- * Extract some folios from the pagecache of a file, reading those pages from
- * the backing store if necessary and waiting for them.
- */
-int filemap_get_pages(struct kiocb *iocb, size_t count,
-		      struct folio_batch *fbatch, bool need_uptodate)
+static int filemap_get_pages(struct kiocb *iocb, size_t count,
+		struct folio_batch *fbatch, bool need_uptodate)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2845,6 +2843,133 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
+/*
+ * Splice subpages from a folio into a pipe.
+ */
+static size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+				     struct folio *folio,
+				     loff_t fpos, size_t size)
+{
+	struct page *page;
+	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
+
+	page = folio_page(folio, offset / PAGE_SIZE);
+	size = min(size, folio_size(folio) - offset);
+	offset %= PAGE_SIZE;
+
+	while (spliced < size &&
+	       !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		struct pipe_buffer *buf = pipe_head_buf(pipe);
+		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
+
+		*buf = (struct pipe_buffer) {
+			.ops	= &page_cache_pipe_buf_ops,
+			.page	= page,
+			.offset	= offset,
+			.len	= part,
+		};
+		folio_get(folio);
+		pipe->head++;
+		page++;
+		spliced += part;
+		offset = 0;
+	}
+
+	return spliced;
+}
+
+/*
+ * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file into
+ * a pipe.
+ */
+ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
+			    struct pipe_inode_info *pipe,
+			    size_t len, unsigned int flags)
+{
+	struct folio_batch fbatch;
+	struct kiocb iocb;
+	size_t total_spliced = 0, used, npages;
+	loff_t isize, end_offset;
+	bool writably_mapped;
+	int i, error = 0;
+
+	init_sync_kiocb(&iocb, in);
+	iocb.ki_pos = *ppos;
+
+	/* Work out how much data we can actually add into the pipe */
+	used = pipe_occupancy(pipe->head, pipe->tail);
+	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	len = min_t(size_t, len, npages * PAGE_SIZE);
+
+	folio_batch_init(&fbatch);
+
+	do {
+		cond_resched();
+
+		if (*ppos >= i_size_read(file_inode(in)))
+			break;
+
+		iocb.ki_pos = *ppos;
+		error = filemap_get_pages(&iocb, len, &fbatch, true);
+		if (error < 0)
+			break;
+
+		/*
+		 * i_size must be checked after we know the pages are Uptodate.
+		 *
+		 * Checking i_size after the check allows us to calculate
+		 * the correct value for "nr", which means the zero-filled
+		 * part of the page is not copied back to userspace (unless
+		 * another truncate extends the file - this is desired though).
+		 */
+		isize = i_size_read(file_inode(in));
+		if (unlikely(*ppos >= isize))
+			break;
+		end_offset = min_t(loff_t, isize, *ppos + len);
+
+		/*
+		 * Once we start copying data, we don't want to be touching any
+		 * cachelines that might be contended:
+		 */
+		writably_mapped = mapping_writably_mapped(in->f_mapping);
+
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
+			size_t n;
+
+			if (folio_pos(folio) >= end_offset)
+				goto out;
+			folio_mark_accessed(folio);
+
+			/*
+			 * If users can be writing to this folio using arbitrary
+			 * virtual addresses, take care of potential aliasing
+			 * before reading the folio on the kernel side.
+			 */
+			if (writably_mapped)
+				flush_dcache_folio(folio);
+
+			n = splice_folio_into_pipe(pipe, folio, *ppos, len);
+			if (!n)
+				goto out;
+			len -= n;
+			total_spliced += n;
+			*ppos += n;
+			in->f_ra.prev_pos = *ppos;
+			if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+				goto out;
+		}
+
+		folio_batch_release(&fbatch);
+	} while (len);
+
+out:
+	folio_batch_release(&fbatch);
+	file_accessed(in);
+
+	return total_spliced ? total_spliced : error;
+}
+
 static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 		struct address_space *mapping, struct folio *folio,
 		loff_t start, loff_t end, bool seek_data)

