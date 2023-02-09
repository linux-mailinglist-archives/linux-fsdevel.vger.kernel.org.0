Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62736904DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 11:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBIKb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 05:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjBIKbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CECE14223
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 02:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675938622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZh4MABlkpe6ltIe1JtsGk3eMjQ687XGJ1n+AAo3k5s=;
        b=Gnmw+O+w5azoxSzKyjkmrcKszrp8LUwFOnN6VXi5j+Hpeqm1Ab3dJmsXV/zclzfVlKXe6M
        9/yqQlN5QZsCW7kgxgfBJYQEwPHApdu+WYwNbmwyxyCwBBSwP5jfBRBhh0qdgsX4prcqOq
        68vZxAZRi67uAzBBKdNEgiaHW1mS0io=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-mHs8wxQ_M9q60lEOpooSWQ-1; Thu, 09 Feb 2023 05:30:19 -0500
X-MC-Unique: mHs8wxQ_M9q60lEOpooSWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFC1D100F83C;
        Thu,  9 Feb 2023 10:30:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC3E7C16022;
        Thu,  9 Feb 2023 10:30:04 +0000 (UTC)
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
Subject: [PATCH v13 03/12] splice: Do splice read from a buffered file without using ITER_PIPE
Date:   Thu,  9 Feb 2023 10:29:45 +0000
Message-Id: <20230209102954.528942-4-dhowells@redhat.com>
In-Reply-To: <20230209102954.528942-1-dhowells@redhat.com>
References: <20230209102954.528942-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

The ITER_BVEC-based splicing previously added is then only used for
splicing from O_DIRECT files.

The code is loosely based on filemap_read() and might belong in
mm/filemap.c with that as it needs to use filemap_get_pages().

With this, ITER_PIPE is no longer used.

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
 fs/splice.c | 159 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 135 insertions(+), 24 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index b4be6fc314a1..963cbf20abc8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/splice.h>
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
@@ -375,6 +376,135 @@ static ssize_t generic_file_direct_splice_read(struct file *in, loff_t *ppos,
 	return ret;
 }
 
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
+		struct pipe_buffer *buf = &pipe->bufs[pipe->head & (pipe->ring_size - 1)];
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
+static ssize_t generic_file_buffered_splice_read(struct file *in, loff_t *ppos,
+						 struct pipe_inode_info *pipe,
+						 size_t len,
+						 unsigned int flags)
+{
+	struct folio_batch fbatch;
+	size_t total_spliced = 0, used, npages;
+	loff_t isize, end_offset;
+	bool writably_mapped;
+	int i, error = 0;
+
+	struct kiocb iocb = {
+		.ki_filp	= in,
+		.ki_pos		= *ppos,
+	};
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
 /**
  * generic_file_splice_read - splice data from file to a pipe
  * @in:		file to splice from
@@ -392,32 +522,13 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags)
 {
-	struct iov_iter to;
-	struct kiocb kiocb;
-	int ret;
-
+	if (unlikely(*ppos >= file_inode(in)->i_sb->s_maxbytes))
+		return 0;
+	if (unlikely(!len))
+		return 0;
 	if (in->f_flags & O_DIRECT)
 		return generic_file_direct_splice_read(in, ppos, pipe, len, flags);
-
-	iov_iter_pipe(&to, ITER_DEST, pipe, len);
-	init_sync_kiocb(&kiocb, in);
-	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
-	if (ret > 0) {
-		*ppos = kiocb.ki_pos;
-		file_accessed(in);
-	} else if (ret < 0) {
-		/* free what was emitted */
-		pipe_discard_from(pipe, to.start_head);
-		/*
-		 * callers of ->splice_read() expect -EAGAIN on
-		 * "can't put anything in there", rather than -EFAULT.
-		 */
-		if (ret == -EFAULT)
-			ret = -EAGAIN;
-	}
-
-	return ret;
+	return generic_file_buffered_splice_read(in, ppos, pipe, len, flags);
 }
 EXPORT_SYMBOL(generic_file_splice_read);
 

