Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD7742A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 17:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjF2P4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjF2P4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC901FD7
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688054114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlZE9cCK+MsXM3xyy8z+SEcTpg9WUnrn3xFqBWWAVgI=;
        b=hw4pABhX6UvKgb/BkB8l4buROX18eB23zJltUCUXYFpezatFq9SacFtxa7mEzdHqbIfwTV
        pmVscEk8Pqkryzf5qcwuwZMQDAHERzcxXRy1P6CjlDZsSxm/5mS/dgQky2IG2l1dMgG57O
        SI+pJ3exWSEbQhmYTwTDxq69yYZDHf4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-GQN9IkHCNG6moXhhB7DL1w-1; Thu, 29 Jun 2023 11:55:05 -0400
X-MC-Unique: GQN9IkHCNG6moXhhB7DL1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6212C8A5150;
        Thu, 29 Jun 2023 15:54:41 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1DA41121315;
        Thu, 29 Jun 2023 15:54:39 +0000 (UTC)
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
Subject: [RFC PATCH 2/4] splice: Make vmsplice() steal or copy
Date:   Thu, 29 Jun 2023 16:54:31 +0100
Message-ID: <20230629155433.4170837-3-dhowells@redhat.com>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make vmsplice()-to-pipe try to steal gifted data or else copy the source
data immediately before adding it to the pipe.  This prevents the data
added to the pipe from being modified by write(), by shared-writable mmap
and by fallocate().

[!] Note: I'm using unmap_mapping_folio() and remove_mapping() to steal a
    gifted page on behalf of vmsplice().  It works partly, but after a
    large batch of stealing, it will oops, but I can't tell why as it dies
    in the middle of a huge chunk of macro-generated interval tree code.

[!] Note: I'm only allowing theft of pages with refcount <= 4.  refcount == 3
    would actually seem to be the right thing (one for the caller, one for the
    pagecache and one for our page table), but sometimes a fourth ref is held
    transiently (possibly deferred put from page-in).

Reported-by:  Matt Whitlock <kernel@mattwhitlock.name>
Link: https://lore.kernel.org/r/ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Dave Chinner <david@fromorbit.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-fsdevel@vger.kernel.org
---
 fs/splice.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 10 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 004eb1c4ce31..42af642c0ff8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -37,6 +37,7 @@
 #include <linux/socket.h>
 #include <linux/sched/signal.h>
 
+#include "../mm/internal.h"
 #include "internal.h"
 
 /*
@@ -1382,14 +1383,117 @@ static long __do_splice(struct file *in, loff_t __user *off_in,
 	return ret;
 }
 
+static void copy_folio_to_folio(struct folio *src, size_t src_offset,
+				struct folio *dst, size_t dst_offset,
+				size_t size)
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
+static int splice_try_to_steal_page(struct pipe_inode_info *pipe,
+				    struct page *page, size_t offset,
+				    size_t size, unsigned int splice_flags)
+{
+	struct folio *folio = page_folio(page), *copy;
+	unsigned int flags = 0;
+	size_t fsize = folio_size(folio), spliced = 0;
+
+	if (!(splice_flags & SPLICE_F_GIFT) ||
+	    fsize != PAGE_SIZE || offset != 0 || size != fsize)
+		goto need_copy;
+
+	/*
+	 * For a folio to be stealable, the caller holds a ref, the mapping
+	 * holds a ref and the page tables hold a ref; it may or may not also
+	 * be on the LRU.  Anything else and someone else has access to it.
+	 */
+	if (folio_ref_count(folio) > 4 || folio_mapcount(folio) != 1 ||
+	    folio_maybe_dma_pinned(folio))
+		goto need_copy;
+
+	/* Try to steal. */
+	folio_lock(folio);
+
+	if (folio_ref_count(folio) > 4 || folio_mapcount(folio) != 1 ||
+	    folio_maybe_dma_pinned(folio))
+		goto need_copy_unlock;
+	if (!folio->mapping)
+		goto need_copy_unlock; /* vmsplice race? */
+
+	/*
+	 * Remove the folio from the process VM and then try to remove
+	 * it from the mapping.  It we can't remove it, we'll have to
+	 * copy it instead.
+	 */
+	unmap_mapping_folio(folio);
+	if (remove_mapping(folio->mapping, folio)) {
+		folio_clear_mappedtodisk(folio);
+		flags |= PIPE_BUF_FLAG_LRU;
+		goto add_to_pipe;
+	}
+
+need_copy_unlock:
+	folio_unlock(folio);
+need_copy:
+
+	copy = folio_alloc(GFP_KERNEL, 0);
+	if (!copy)
+		return -ENOMEM;
+
+	size = min(size, PAGE_SIZE - offset % PAGE_SIZE);
+	copy_folio_to_folio(folio, offset, copy, 0, size);
+	folio_mark_uptodate(copy);
+	folio_put(folio);
+	folio = copy;
+	offset = 0;
+
+add_to_pipe:
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
+			.ops	= &default_pipe_buf_ops,
+			.page	= page,
+			.offset	= offset,
+			.len	= part,
+			.flags	= flags,
+		};
+		folio_get(folio);
+		pipe->head++;
+		page++;
+		spliced += part;
+		offset = 0;
+	}
+
+	folio_put(folio);
+	return spliced;
+}
+
 static int iter_to_pipe(struct iov_iter *from,
 			struct pipe_inode_info *pipe,
 			unsigned flags)
 {
-	struct pipe_buffer buf = {
-		.ops = &user_page_pipe_buf_ops,
-		.flags = flags
-	};
 	size_t total = 0;
 	int ret = 0;
 
@@ -1407,12 +1511,11 @@ static int iter_to_pipe(struct iov_iter *from,
 
 		n = DIV_ROUND_UP(left + start, PAGE_SIZE);
 		for (i = 0; i < n; i++) {
-			int size = min_t(int, left, PAGE_SIZE - start);
+			size_t part = min_t(size_t, left,
+					    PAGE_SIZE - start % PAGE_SIZE);
 
-			buf.page = pages[i];
-			buf.offset = start;
-			buf.len = size;
-			ret = add_to_pipe(pipe, &buf);
+			ret = splice_try_to_steal_page(pipe, pages[i], start,
+						       part, flags);
 			if (unlikely(ret < 0)) {
 				iov_iter_revert(from, left);
 				// this one got dropped by add_to_pipe()
@@ -1421,7 +1524,7 @@ static int iter_to_pipe(struct iov_iter *from,
 				goto out;
 			}
 			total += ret;
-			left -= size;
+			left -= part;
 			start = 0;
 		}
 	}

