Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048A868D98C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 14:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjBGNkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 08:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjBGNkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:40:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541821A3F
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 05:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675777170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tPGOe6bSrGHTjccXGBH/EOWbIxN9iyO0od7H26UWmA=;
        b=cdC17vr6e2m+Fp5KSncfW6L2GdUMrbuBm6P+XRy+Rw9wNlGg9WP+ya9Fm0dMTDMauZm0/l
        /vX7vPbMfj+4T0R3zRoPQoV9Jl5cta7Oi+febOmxUrwCxQWtr47rybnD2LUN8eBQq8rhpc
        T3ZNBwjc8oTFLLVtw9HUhA00HPl03D0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-hT7oMmRJOGWd-P2mMPAR5g-1; Tue, 07 Feb 2023 08:39:26 -0500
X-MC-Unique: hT7oMmRJOGWd-P2mMPAR5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 287881C02D26;
        Tue,  7 Feb 2023 13:39:26 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27F79400DFDB;
        Tue,  7 Feb 2023 13:39:24 +0000 (UTC)
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
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] vfs, iomap: Fix generic_file_splice_read() to avoid reversion of ITER_PIPE
Date:   Tue,  7 Feb 2023 13:39:15 +0000
Message-Id: <20230207133916.3109147-2-dhowells@redhat.com>
In-Reply-To: <20230207133916.3109147-1-dhowells@redhat.com>
References: <20230207133916.3109147-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the new iov_iter_extract_pages() function, pages extracted from a
non-user-backed iterator, such as ITER_PIPE, aren't pinned.
__iomap_dio_rw(), however, calls iov_iter_revert() to shorten the iterator
to just the data it is going to use - which causes the pipe buffers to be
freed, even though they're attached to a bio and may get written to by DMA
(thanks to Hillf Danton for spotting this[1]).

This then causes massive memory corruption that is particularly noticable
when the syzbot test[2] is run.  The test boils down to:

	out = creat(argv[1], 0666);
	ftruncate(out, 0x800);
	lseek(out, 0x200, SEEK_SET);
	in = open(argv[1], O_RDONLY | O_DIRECT | O_NOFOLLOW);
	sendfile(out, in, NULL, 0x1dd00);

run repeatedly in parallel.  What I think is happening is that ftruncate()
occasionally shortens the DIO read that's about to be made by sendfile's
splice core by reducing i_size.

Fix this by replacing the use of an ITER_PIPE iterator with an ITER_BVEC
iterator for which reversion won't free the buffers.  Bulk allocate all the
buffers we think we're going to use in advance, do the read synchronously
and only then trim the buffer down.  The pages we did use get pushed into
the pipe.

This is more efficient by virtue of doing a bulk page allocation, but
slightly less efficient by ignoring any partial page in the pipe.

Note that this removes the only user of ITER_PIPE.

Fixes: 920756a3306a ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")
Reported-by: syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Hillf Danton <hdanton@sina.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20230207094731.1390-1-hdanton@sina.com/ [1]
Link: https://lore.kernel.org/r/000000000000b0b3c005f3a09383@google.com/ [2]
---
 fs/splice.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 5969b7a1d353..51778437f31f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -295,24 +295,62 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
  *    used as long as it has more or less sane ->read_iter().
  *
  */
-ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
+ssize_t generic_file_splice_read(struct file *file, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags)
 {
+	LIST_HEAD(pages);
 	struct iov_iter to;
+	struct bio_vec *bv;
 	struct kiocb kiocb;
-	int ret;
+	struct page *page;
+	unsigned int head;
+	ssize_t ret;
+	size_t used, npages, chunk, remain, reclaim;
+	int i;
+
+	/* Work out how much data we can actually add into the pipe */
+	used = pipe_occupancy(pipe->head, pipe->tail);
+	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	len = min_t(size_t, len, npages * PAGE_SIZE);
+	npages = DIV_ROUND_UP(len, PAGE_SIZE);
+
+	bv = kmalloc(array_size(npages, sizeof(bv[0])), GFP_KERNEL);
+	if (!bv)
+		return -ENOMEM;
+
+	npages = alloc_pages_bulk_list(GFP_USER, npages, &pages);
+	if (!npages) {
+		kfree(bv);
+		return -ENOMEM;
+	}
 
-	iov_iter_pipe(&to, ITER_DEST, pipe, len);
-	init_sync_kiocb(&kiocb, in);
+	remain = len = min_t(size_t, len, npages * PAGE_SIZE);
+
+	for (i = 0; i < npages; i++) {
+		chunk = min_t(size_t, PAGE_SIZE, remain);
+		page = list_first_entry(&pages, struct page, lru);
+		list_del_init(&page->lru);
+		bv[i].bv_page = page;
+		bv[i].bv_offset = 0;
+		bv[i].bv_len = chunk;
+		remain -= chunk;
+	}
+
+	/* Do the I/O */
+	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
+	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
+	ret = call_read_iter(file, &kiocb, &to);
+
+	reclaim = npages * PAGE_SIZE;
+	remain = 0;
 	if (ret > 0) {
+		reclaim -= ret;
+		remain = ret;
 		*ppos = kiocb.ki_pos;
-		file_accessed(in);
+		file_accessed(file);
 	} else if (ret < 0) {
-		/* free what was emitted */
-		pipe_discard_from(pipe, to.start_head);
 		/*
 		 * callers of ->splice_read() expect -EAGAIN on
 		 * "can't put anything in there", rather than -EFAULT.
@@ -321,6 +359,28 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 			ret = -EAGAIN;
 	}
 
+	/* Free any pages that didn't get touched at all. */
+	for (; reclaim >= PAGE_SIZE; reclaim -= PAGE_SIZE)
+		__free_page(bv[--npages].bv_page);
+
+	/* Push the remaining pages into the pipe. */
+	head = pipe->head;
+	for (i = 0; i < npages; i++) {
+		struct pipe_buffer *buf = &pipe->bufs[head & (pipe->ring_size - 1)];
+
+		chunk = min_t(size_t, remain, PAGE_SIZE);
+		*buf = (struct pipe_buffer) {
+			.ops	= &default_pipe_buf_ops,
+			.page	= bv[i].bv_page,
+			.offset	= 0,
+			.len	= chunk,
+		};
+		head++;
+		remain -= chunk;
+	}
+	pipe->head = head;
+
+	kfree(bv);
 	return ret;
 }
 EXPORT_SYMBOL(generic_file_splice_read);

