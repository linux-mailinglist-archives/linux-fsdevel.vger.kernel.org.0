Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC986904D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 11:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBIKbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 05:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBIKaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:30:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48751AD35
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 02:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675938608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsYNekVz+lznQWi+DyiWbMmMgsK+xoFDa6MvvOVfs9k=;
        b=LfB3wO7Sikhc3XLw7SPcLcB7j+k08yNao8foid9fgCeHQjX8VLEjEpg8Rtvs5SaXlkPBOM
        3foSfHxLQ7sOc0ANzRDbstBhyVDt9XhrUm2j+w7sFzTsP6DyWazef3sIbQhu3BANt0Ow8G
        I4gh6XXNRZU4SgJy4hoq6EZIDb9KXNY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-svCu24HANLy3Imi4GjyZKQ-1; Thu, 09 Feb 2023 05:30:02 -0500
X-MC-Unique: svCu24HANLy3Imi4GjyZKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BAD52806041;
        Thu,  9 Feb 2023 10:30:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 849DB403D0C5;
        Thu,  9 Feb 2023 10:29:59 +0000 (UTC)
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
Subject: [PATCH v13 01/12] splice: Fix O_DIRECT file read splice to avoid reversion of ITER_PIPE
Date:   Thu,  9 Feb 2023 10:29:43 +0000
Message-Id: <20230209102954.528942-2-dhowells@redhat.com>
In-Reply-To: <20230209102954.528942-1-dhowells@redhat.com>
References: <20230209102954.528942-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the upcoming iov_iter_extract_pages() function, pages extracted from a
non-user-backed iterator such as ITER_PIPE aren't pinned.
__iomap_dio_rw(), however, calls iov_iter_revert() to shorten the iterator
to just the bufferage it is going to use - which has the side-effect of
freeing the excess pipe buffers, even though they're attached to a bio and
may get written to by DMA (thanks to Hillf Danton for spotting this[1]).

This then causes memory corruption that is particularly noticable when the
syzbot test[2] is run.  The test boils down to:

	out = creat(argv[1], 0666);
	ftruncate(out, 0x800);
	lseek(out, 0x200, SEEK_SET);
	in = open(argv[1], O_RDONLY | O_DIRECT | O_NOFOLLOW);
	sendfile(out, in, NULL, 0x1dd00);

run repeatedly in parallel.  What I think is happening is that ftruncate()
occasionally shortens the DIO read that's about to be made by sendfile's
splice core by reducing i_size.

Fix this by splitting the handling of a splice from an O_DIRECT file fd off
from that of non-DIO and in this case, replacing the use of an ITER_PIPE
iterator with an ITER_BVEC iterator for which reversion won't free the
buffers.  The DIO-specific code bulk allocates all the buffers it thinks it
is going to use in advance, does the read synchronously and only then trims
the buffer down.  The pages we did use get pushed into the pipe.

This should be more efficient for DIO read by virtue of doing a bulk page
allocation, but slightly less efficient by ignoring any partial page in the
pipe.

Fixes: 920756a3306a ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")
Reported-by: syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20230207094731.1390-1-hdanton@sina.com/ [1]
Link: https://lore.kernel.org/r/000000000000b0b3c005f3a09383@google.com/ [2]
---

Notes:
    ver #13)
     - Don't completely replace generic_file_splice_read(), but rather only use
       this if we're doing a splicing from an O_DIRECT file fd.

 fs/splice.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 5969b7a1d353..b4be6fc314a1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -282,6 +282,99 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
 	kfree(spd->partial);
 }
 
+/*
+ * Splice data from an O_DIRECT file into pages and then add them to the output
+ * pipe.
+ */
+static ssize_t generic_file_direct_splice_read(struct file *in, loff_t *ppos,
+					       struct pipe_inode_info *pipe,
+					       size_t len, unsigned int flags)
+{
+	LIST_HEAD(pages);
+	struct iov_iter to;
+	struct bio_vec *bv;
+	struct kiocb kiocb;
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
+
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
+	init_sync_kiocb(&kiocb, in);
+	kiocb.ki_pos = *ppos;
+	ret = call_read_iter(in, &kiocb, &to);
+
+	reclaim = npages * PAGE_SIZE;
+	remain = 0;
+	if (ret > 0) {
+		reclaim -= ret;
+		remain = ret;
+		*ppos = kiocb.ki_pos;
+		file_accessed(in);
+	} else if (ret < 0) {
+		/*
+		 * callers of ->splice_read() expect -EAGAIN on
+		 * "can't put anything in there", rather than -EFAULT.
+		 */
+		if (ret == -EFAULT)
+			ret = -EAGAIN;
+	}
+
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
+	return ret;
+}
+
 /**
  * generic_file_splice_read - splice data from file to a pipe
  * @in:		file to splice from
@@ -303,6 +396,9 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	struct kiocb kiocb;
 	int ret;
 
+	if (in->f_flags & O_DIRECT)
+		return generic_file_direct_splice_read(in, ppos, pipe, len, flags);
+
 	iov_iter_pipe(&to, ITER_DEST, pipe, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;

