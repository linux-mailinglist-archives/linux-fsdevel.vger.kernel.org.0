Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39770A3A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 02:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjETADS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 20:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjETADQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 20:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B7810E3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 17:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684540884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUqjynheJXCaLvUnn68NO8vUOrcgRITgr951Lzay0lM=;
        b=hDg0/8V6n6kS0x7AtXtlphYjI3m7m7hsDrnaOL2ciOxe+UoQ1Pvwg10rOy/DNF23H3PmyM
        uA/6/+kvpCc8+ds97qdEMecuJUjJbbE2vsmA0ejCV6xUF3qJ9xei4T0T5ljJAl+DPxD/HT
        ypfo938SP4aFW1LoawW6nSuEJ5Uo7mM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-fz4w9rXNMyW2QIqeSZgthw-1; Fri, 19 May 2023 20:01:21 -0400
X-MC-Unique: fz4w9rXNMyW2QIqeSZgthw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E2BA185A78E;
        Sat, 20 May 2023 00:01:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03AF840CFD46;
        Sat, 20 May 2023 00:01:17 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v21 09/30] shmem: Implement splice-read
Date:   Sat, 20 May 2023 01:00:28 +0100
Message-Id: <20230520000049.2226926-10-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new filemap_splice_read() has an implicit expectation via
filemap_get_pages() that ->read_folio() exists if ->readahead() doesn't
fully populate the pagecache of the file it is reading from[1], potentially
leading to a jump to NULL if this doesn't exist.  shmem, however, (and by
extension, tmpfs, ramfs and rootfs), doesn't have ->read_folio(),

Work around this by equipping shmem with its own splice-read
implementation, based on filemap_splice_read(), but able to paste in
zero_page when there's a page missing.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Daniel Golle <daniel@makrotopia.org>
cc: Guenter Roeck <groeck7@gmail.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Hugh Dickins <hughd@google.com>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/Y+pdHFFTk1TTEBsO@makrotopia.org/ [1]
---

Notes:
    ver #19)
     - Remove a missed get_page() on the zero page.
    
    ver #18)
     - Don't take/release a ref on the zero page.

 mm/shmem.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e40a08c5c6d7..1f504ed982cf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2731,6 +2731,138 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return retval ? retval : error;
 }
 
+static bool zero_pipe_buf_get(struct pipe_inode_info *pipe,
+			      struct pipe_buffer *buf)
+{
+	return true;
+}
+
+static void zero_pipe_buf_release(struct pipe_inode_info *pipe,
+				  struct pipe_buffer *buf)
+{
+}
+
+static bool zero_pipe_buf_try_steal(struct pipe_inode_info *pipe,
+				    struct pipe_buffer *buf)
+{
+	return false;
+}
+
+static const struct pipe_buf_operations zero_pipe_buf_ops = {
+	.release	= zero_pipe_buf_release,
+	.try_steal	= zero_pipe_buf_try_steal,
+	.get		= zero_pipe_buf_get,
+};
+
+static size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe,
+					loff_t fpos, size_t size)
+{
+	size_t offset = fpos & ~PAGE_MASK;
+
+	size = min_t(size_t, size, PAGE_SIZE - offset);
+
+	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		struct pipe_buffer *buf = pipe_head_buf(pipe);
+
+		*buf = (struct pipe_buffer) {
+			.ops	= &zero_pipe_buf_ops,
+			.page	= ZERO_PAGE(0),
+			.offset	= offset,
+			.len	= size,
+		};
+		pipe->head++;
+	}
+
+	return size;
+}
+
+static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
+				      struct pipe_inode_info *pipe,
+				      size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio = NULL;
+	size_t total_spliced = 0, used, npages, n, part;
+	loff_t isize;
+	int error = 0;
+
+	/* Work out how much data we can actually add into the pipe */
+	used = pipe_occupancy(pipe->head, pipe->tail);
+	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	len = min_t(size_t, len, npages * PAGE_SIZE);
+
+	do {
+		if (*ppos >= i_size_read(inode))
+			break;
+
+		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio, SGP_READ);
+		if (error) {
+			if (error == -EINVAL)
+				error = 0;
+			break;
+		}
+		if (folio) {
+			folio_unlock(folio);
+
+			if (folio_test_hwpoison(folio)) {
+				error = -EIO;
+				break;
+			}
+		}
+
+		/*
+		 * i_size must be checked after we know the pages are Uptodate.
+		 *
+		 * Checking i_size after the check allows us to calculate
+		 * the correct value for "nr", which means the zero-filled
+		 * part of the page is not copied back to userspace (unless
+		 * another truncate extends the file - this is desired though).
+		 */
+		isize = i_size_read(inode);
+		if (unlikely(*ppos >= isize))
+			break;
+		part = min_t(loff_t, isize - *ppos, len);
+
+		if (folio) {
+			/*
+			 * If users can be writing to this page using arbitrary
+			 * virtual addresses, take care about potential aliasing
+			 * before reading the page on the kernel side.
+			 */
+			if (mapping_writably_mapped(mapping))
+				flush_dcache_folio(folio);
+			folio_mark_accessed(folio);
+			/*
+			 * Ok, we have the page, and it's up-to-date, so we can
+			 * now splice it into the pipe.
+			 */
+			n = splice_folio_into_pipe(pipe, folio, *ppos, part);
+			folio_put(folio);
+			folio = NULL;
+		} else {
+			n = splice_zeropage_into_pipe(pipe, *ppos, len);
+		}
+
+		if (!n)
+			break;
+		len -= n;
+		total_spliced += n;
+		*ppos += n;
+		in->f_ra.prev_pos = *ppos;
+		if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+			break;
+
+		cond_resched();
+	} while (len);
+
+	if (folio)
+		folio_put(folio);
+
+	file_accessed(in);
+	return total_spliced ? total_spliced : error;
+}
+
 static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct address_space *mapping = file->f_mapping;
@@ -3971,7 +4103,7 @@ static const struct file_operations shmem_file_operations = {
 	.read_iter	= shmem_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.fsync		= noop_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= shmem_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
 #endif

