Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30565742A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjF2Pzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjF2Pzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C235A3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688054102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eueBEW3aL+xqYTSeuQ3xb53C/MZpWPSC4TMM2avShg=;
        b=I2ypApkPFVwjxXcOxtxmhcyIKu80XUau7MdGxQntVLqvONwyAoX7atY9X5NZGwbHH8m1kA
        rwQDMhJXzuY+ZjJUfGnY0D5iQ6h2OlXggvjT6J/XOJQaR5y6AI4/cNLinh9+CbnV/KQXsL
        2T+H1UaM5OVrykYxatXxmdC44VG9/j0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-pxvax7y_Nu26XJJKh4xM3A-1; Thu, 29 Jun 2023 11:54:59 -0400
X-MC-Unique: pxvax7y_Nu26XJJKh4xM3A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66B8A280AA42;
        Thu, 29 Jun 2023 15:54:39 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EF7D4CD0C3;
        Thu, 29 Jun 2023 15:54:37 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 1/4] splice: Fix corruption of spliced data after splice() returns
Date:   Thu, 29 Jun 2023 16:54:30 +0100
Message-ID: <20230629155433.4170837-2-dhowells@redhat.com>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Splicing data from, say, a file into a pipe currently leaves the source
pages in the pipe after splice() returns - but this means that those pages
can be subsequently modified by shared-writable mmap(), write(),
fallocate(), etc. before they're consumed.

Fix this by stealing the pages in splice() before they're added to the pipe
if no one else is using them or has them mapped and copying them otherwise.

Reported-by: Matt Whitlock <kernel@mattwhitlock.name>
Link: https://lore.kernel.org/r/ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Dave Chinner <david@fromorbit.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-fsdevel@vger.kernel.org
---
 mm/filemap.c  | 92 ++++++++++++++++++++++++++++++++++++++++++++++++---
 mm/internal.h |  4 +--
 mm/shmem.c    |  8 +++--
 3 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9e44a49bbd74..a002df515966 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2838,15 +2838,87 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
+static inline void copy_folio_to_folio(struct folio *src, size_t src_offset,
+				       struct folio *dst, size_t dst_offset,
+				       size_t size)
+{
+	void *p, *q;
+
+	while (size > 0) {
+		size_t part = min3(PAGE_SIZE - src_offset % PAGE_SIZE,
+				   PAGE_SIZE - dst_offset % PAGE_SIZE,
+				   size);
+
+		p = kmap_local_folio(src, src_offset);
+		q = kmap_local_folio(dst, dst_offset);
+		memcpy(q, p, part);
+		kunmap_local(p);
+		kunmap_local(q);
+		src_offset += part;
+		dst_offset += part;
+		size -= part;
+	}
+}
+
 /*
- * Splice subpages from a folio into a pipe.
+ * Splice data from a folio into a pipe.  The folio is stolen if no one else is
+ * using it and copied otherwise.  We can't put the folio into the pipe still
+ * attached to the pagecache as that allows someone to modify it after the
+ * splice.
  */
-size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-			      struct folio *folio, loff_t fpos, size_t size)
+ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			       struct folio *folio, loff_t fpos, size_t size)
 {
+	struct address_space *mapping;
+	struct folio *copy = NULL;
 	struct page *page;
+	unsigned int flags = 0;
+	ssize_t ret;
 	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
 
+	folio_lock(folio);
+
+	mapping = folio_mapping(folio);
+	ret = -ENODATA;
+	if (!folio->mapping)
+		goto err_unlock; /* Truncated */
+	ret = -EIO;
+	if (!folio_test_uptodate(folio))
+		goto err_unlock;
+
+	/*
+	 * At least for ext2 with nobh option, we need to wait on writeback
+	 * completing on this folio, since we'll remove it from the pagecache.
+	 * Otherwise truncate wont wait on the folio, allowing the disk blocks
+	 * to be reused by someone else before we actually wrote our data to
+	 * them. fs corruption ensues.
+	 */
+	folio_wait_writeback(folio);
+
+	if (folio_has_private(folio) &&
+	    !filemap_release_folio(folio, GFP_KERNEL))
+		goto need_copy;
+
+	/* If we succeed in removing the mapping, set LRU flag and add it. */
+	if (remove_mapping(mapping, folio)) {
+		folio_unlock(folio);
+		flags = PIPE_BUF_FLAG_LRU;
+		goto add_to_pipe;
+	}
+
+need_copy:
+	folio_unlock(folio);
+
+	copy = folio_alloc(GFP_KERNEL, 0);
+	if (!copy)
+		return -ENOMEM;
+
+	size = min(size, PAGE_SIZE - offset % PAGE_SIZE);
+	copy_folio_to_folio(folio, offset, copy, 0, size);
+	folio = copy;
+	offset = 0;
+
+add_to_pipe:
 	page = folio_page(folio, offset / PAGE_SIZE);
 	size = min(size, folio_size(folio) - offset);
 	offset %= PAGE_SIZE;
@@ -2861,6 +2933,7 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 			.page	= page,
 			.offset	= offset,
 			.len	= part,
+			.flags	= flags,
 		};
 		folio_get(folio);
 		pipe->head++;
@@ -2869,7 +2942,13 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 		offset = 0;
 	}
 
+	if (copy)
+		folio_put(copy);
 	return spliced;
+
+err_unlock:
+	folio_unlock(folio);
+	return ret;
 }
 
 /**
@@ -2947,7 +3026,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
-			size_t n;
+			ssize_t n;
 
 			if (folio_pos(folio) >= end_offset)
 				goto out;
@@ -2963,8 +3042,11 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 			n = min_t(loff_t, len, isize - *ppos);
 			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
-			if (!n)
+			if (n <= 0) {
+				if (n < 0)
+					error = n;
 				goto out;
+			}
 			len -= n;
 			total_spliced += n;
 			*ppos += n;
diff --git a/mm/internal.h b/mm/internal.h
index a7d9e980429a..ae395e0f31d5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -881,8 +881,8 @@ struct migration_target_control {
 /*
  * mm/filemap.c
  */
-size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-			      struct folio *folio, loff_t fpos, size_t size);
+ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			       struct folio *folio, loff_t fpos, size_t size);
 
 /*
  * mm/vmalloc.c
diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..969931b0f00e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2783,7 +2783,8 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 	struct inode *inode = file_inode(in);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio = NULL;
-	size_t total_spliced = 0, used, npages, n, part;
+	ssize_t n;
+	size_t total_spliced = 0, used, npages, part;
 	loff_t isize;
 	int error = 0;
 
@@ -2844,8 +2845,11 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			n = splice_zeropage_into_pipe(pipe, *ppos, len);
 		}
 
-		if (!n)
+		if (n <= 0) {
+			if (n < 0)
+				error = n;
 			break;
+		}
 		len -= n;
 		total_spliced += n;
 		*ppos += n;

