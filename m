Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D8614F61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiKAQdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKAQcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5DE1C923
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667320289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81o0xglTJlmj/I4frcFyAC/3LDg30Msuad1PhRl7GPQ=;
        b=aHevDInM7FQ5wVbfSns//JBK6mfLUQJ3QgYADs4jSv26RgwcWvKhNhgF9DKSzJA2rxRbiE
        U+q8HE8f7b7OGCVl5KR3or2cI5wPTjd2ACuQ3eKaGjBB1stqy6eiVK8vitklHBGkIP6EIb
        mlTkXKVIjyEjyY7K7x+Ks2mtQzS9mYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-SAZDWvRpPE6_a181gjmXQQ-1; Tue, 01 Nov 2022 12:31:28 -0400
X-MC-Unique: SAZDWvRpPE6_a181gjmXQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40ED6833A06;
        Tue,  1 Nov 2022 16:31:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4B2E2166B2D;
        Tue,  1 Nov 2022 16:31:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 05/12] cifs: Implement splice_read to pass down ITER_BVEC
 not ITER_PIPE
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Nov 2022 16:31:21 +0000
Message-ID: <166732028113.3186319.1793644937097301358.stgit@warthog.procyon.org.uk>
In-Reply-To: <166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk>
References: <166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
---

 fs/cifs/cifsfs.c |   12 ++++---
 fs/cifs/cifsfs.h |    3 ++
 fs/cifs/file.c   |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index d0b9fec111aa..f7ea7870ed6f 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1328,7 +1328,7 @@ const struct file_operations cifs_file_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1348,7 +1348,7 @@ const struct file_operations cifs_file_strict_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1368,7 +1368,7 @@ const struct file_operations cifs_file_direct_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
@@ -1386,7 +1386,7 @@ const struct file_operations cifs_file_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1404,7 +1404,7 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1422,7 +1422,7 @@ const struct file_operations cifs_file_direct_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = cifs_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 388b745a978e..c0b5e861771f 100644
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
index 21d41b3c1882..cd72736c19a6 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5258,3 +5258,95 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.invalidate_folio = cifs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
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
+	len = min(len, npages * PAGE_SIZE);
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
+	remain = len = min(len, npages * PAGE_SIZE);
+
+	for (i = 0; i < npages; i++) {
+		chunk = min(PAGE_SIZE, remain);
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
+		chunk = min(remain, PAGE_SIZE);
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


