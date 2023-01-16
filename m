Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4066266D2E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjAPXQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjAPXPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:15:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0655301AF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YK/GsmtKWjs0Z6+QV9idzb2/DMCcKOjB4/+/VpYvNS4=;
        b=NG92XxWBbej9I4Iw+0p9xn5fWxdwzhLATEkIlFp0QGWksy3NfoQ9H2tdCRExLQJNs3X5LA
        IyUKins1qdeq1ZOQDjBad2EsTGQE7RG6tqi5QfxS1HTjLBEFRjWw5pV3Y4e+tsJ9IMgjbs
        IVe7SqqWuADrxRTPmb7rKzrhDSK13dc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-cmJBKWPzMk-bODE0brYFcw-1; Mon, 16 Jan 2023 18:10:50 -0500
X-MC-Unique: cmJBKWPzMk-bODE0brYFcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E5B3C0F42D;
        Mon, 16 Jan 2023 23:10:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1A8A1121315;
        Mon, 16 Jan 2023 23:10:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 23/34] cifs: Implement splice_read to pass down ITER_BVEC
 not ITER_PIPE
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:10:47 +0000
Message-ID: <167391064717.2311931.7504820268968962092.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide cifs_splice_read() to use a bvec rather than an pipe iterator as
the latter cannot so easily be split and advanced, which is necessary to
pass an iterator down to the bottom levels.  Upstream cifs gets around this
problem by using iov_iter_get_pages() to prefill the pipe and then passing
the list of pages down.

This is done by:

 (1) Bulk-allocate a bunch of pages to carry as much of the requested
     amount of data as possible, but without overrunning the available
     slots in the pipe and add them to an ITER_BVEC.

 (2) Synchronously call ->read_iter() to read into the buffer.

 (3) Discard any unused pages.

 (4) Load the remaining pages into the pipe in order and advance the head
     pointer.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-cifs@vger.kernel.org

Link: https://lore.kernel.org/r/166732028113.3186319.1793644937097301358.stgit@warthog.procyon.org.uk/ # rfc
---

 fs/cifs/cifsfs.c |   12 ++++---
 fs/cifs/cifsfs.h |    3 ++
 fs/cifs/file.c   |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/splice.c      |    1 +
 4 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 10e00c624922..3c57e8b11692 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1358,7 +1358,7 @@ const struct file_operations cifs_file_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1378,7 +1378,7 @@ const struct file_operations cifs_file_strict_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1398,7 +1398,7 @@ const struct file_operations cifs_file_direct_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
@@ -1416,7 +1416,7 @@ const struct file_operations cifs_file_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1434,7 +1434,7 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1452,7 +1452,7 @@ const struct file_operations cifs_file_direct_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 63a0ac2b9355..25decebbc478 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -100,6 +100,9 @@ extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
+extern ssize_t cifs_splice_read(struct file *in, loff_t *ppos,
+				struct pipe_inode_info *pipe, size_t len,
+				unsigned int flags);
 extern int cifs_flock(struct file *pfile, int cmd, struct file_lock *plock);
 extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, loff_t, loff_t, int);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d100b9cb8682..f1297386a185 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5273,3 +5273,95 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.launder_folio = cifs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 };
+
+/*
+ * Splice data from a file into a pipe.
+ */
+ssize_t cifs_splice_read(struct file *file, loff_t *ppos,
+			 struct pipe_inode_info *pipe, size_t len,
+			 unsigned int flags)
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
+	iov_iter_bvec(&to, READ, bv, npages, len);
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = *ppos;
+	ret = call_read_iter(file, &kiocb, &to);
+
+	reclaim = npages * PAGE_SIZE;
+	remain = 0;
+	if (ret > 0) {
+		reclaim -= ret;
+		remain = ret;
+		*ppos = kiocb.ki_pos;
+		file_accessed(file);
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
diff --git a/fs/splice.c b/fs/splice.c
index c3433266ba1b..1245ffb64414 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -330,6 +330,7 @@ const struct pipe_buf_operations default_pipe_buf_ops = {
 	.try_steal	= generic_pipe_buf_try_steal,
 	.get		= generic_pipe_buf_get,
 };
+EXPORT_SYMBOL(default_pipe_buf_ops);
 
 /* Pipe buffer operations for a socket and similar. */
 const struct pipe_buf_operations nosteal_pipe_buf_ops = {


