Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38193699F46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjBPVtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjBPVt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237DB4C3C6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aTLk2eEjUUGfJZpasC0aeUIJz1OFiWbQqwHM/iVEKgQ=;
        b=Z/9fqueIA82bb/Hvq1DBniyB7tuqC+jiIWQ7T6HcInZv0A4G/lGtC3W9D8WzX4gorYsMqH
        Ivw76a92RlX+46bzKWa5Jqa4bGBGdbyu5raaARCft8QMNhWChUbhGFNSkrKPlfSz3G8mgo
        hCHY16RH/PRhdAbaLo6BKwylk12ORUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-PfIjLxiFPsiEdCok_9z79A-1; Thu, 16 Feb 2023 16:48:14 -0500
X-MC-Unique: PfIjLxiFPsiEdCok_9z79A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51530811E9C;
        Thu, 16 Feb 2023 21:48:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3518A492B10;
        Thu, 16 Feb 2023 21:48:11 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 02/17] splice: Add a func to do a splice from a buffered file without ITER_PIPE
Date:   Thu, 16 Feb 2023 21:47:30 +0000
Message-Id: <20230216214745.3985496-3-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
Reviewed-by: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
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

