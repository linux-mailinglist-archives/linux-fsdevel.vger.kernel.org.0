Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF39696B00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 18:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjBNROm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 12:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjBNROf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:14:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97B8A41
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676394827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0CTUnwfVEWUZBHu5fA2fJ8y0quxYsONFQfvaH+Rj5U=;
        b=IeE5caQjEzM4YFxp4tRjTPIMDypF9Cfmau4EWGt8t2rxEyR2xfqyCyoI5Kt3YVaJq6tvy+
        WaGc7Mw02rBTGrjdFcxOl2j8QC+rZOrAMWHopWM/krBbVwe4vQRw0Jh8VE1eUzhuac/93c
        qYZep4C7qEtHfT7MwslNjoX8jIaJw5A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-fW_ij3QZO56kIwrqyILfmQ-1; Tue, 14 Feb 2023 12:13:42 -0500
X-MC-Unique: fW_ij3QZO56kIwrqyILfmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9D5F1C08796;
        Tue, 14 Feb 2023 17:13:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1699140EBF6;
        Tue, 14 Feb 2023 17:13:38 +0000 (UTC)
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
Subject: [PATCH v14 02/17] splice: Add a func to do a splice from a buffered file without ITER_PIPE
Date:   Tue, 14 Feb 2023 17:13:15 +0000
Message-Id: <20230214171330.2722188-3-dhowells@redhat.com>
In-Reply-To: <20230214171330.2722188-1-dhowells@redhat.com>
References: <20230214171330.2722188-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function to do splice read from a buffered file, pulling the
folios out of the pagecache directly by calling filemap_get_pages() to do
any required reading and then pasting the returned folios into the pipe.

A helper function is provided to do the actual folio pasting and will
handle multipage folios by splicing as many of the relevant subpages as
will fit into the pipe.

The code is loosely based on filemap_read() and might belong in
mm/filemap.c with that as it needs to use filemap_get_pages().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    ver #14)
     - Rename to filemap_splice_read().
     - Create a helper, pipe_head_buf(), to get the head buffer.
     - Use init_sync_kiocb().
     - Move to mm/filemap.c.
     - Split the implementation of filemap_splice_read() from the patch to
       make generic_file_splice_read() use it and direct_splice_read().

 include/linux/fs.h |   3 ++
 mm/filemap.c       | 128 +++++++++++++++++++++++++++++++++++++++++++++
 mm/internal.h      |   6 +++
 3 files changed, 137 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..28743e38df91 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3163,6 +3163,9 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 			    struct iov_iter *iter);
 
 /* fs/splice.c */
+ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
+			    struct pipe_inode_info *pipe,
+			    size_t len, unsigned int flags);
 extern ssize_t generic_file_splice_read(struct file *, loff_t *,
 		struct pipe_inode_info *, size_t, unsigned int);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
diff --git a/mm/filemap.c b/mm/filemap.c
index 876e77278d2a..8c7b135c8e23 100644
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
@@ -2842,6 +2844,132 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
+/*
+ * Splice subpages from a folio into a pipe.
+ */
+size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			      struct folio *folio, loff_t fpos, size_t size)
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
diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..6d4ca98f3844 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -794,6 +794,12 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
+/*
+ * mm/filemap.c
+ */
+size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			      struct folio *folio, loff_t fpos, size_t size);
+
 /*
  * mm/vmalloc.c
  */

