Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150FB743E8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjF3PT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjF3PTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF4544A9
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIKi0zHLnu1hjZ3YJMMoOoPZaQGGpdOq8FelXRkEWEM=;
        b=Zwg0MAZRJ6m7poTmjNLIJjJ5HmB0zEIFaBHiSlKleYyU+WLMtGsa9Eyx7YJqoc3qFwtCWs
        CqieLpn1trG0OI5ApCOxSGg8XJo9/geITWf+4fcXtf1aAwLnQ/vUgK3sdRpOlGc8GmNNHs
        kYSL0RNHRCTgD50gKU0fruastvWButE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-_LC-zIbSMR-X7w2nKGx5pA-1; Fri, 30 Jun 2023 11:17:08 -0400
X-MC-Unique: _LC-zIbSMR-X7w2nKGx5pA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C049800B35;
        Fri, 30 Jun 2023 15:17:07 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6E71121314;
        Fri, 30 Jun 2023 15:16:57 +0000 (UTC)
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
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC PATCH 02/11] vfs: Set IOCB_WRITE in iocbs that we're going to write from
Date:   Fri, 30 Jun 2023 16:16:19 +0100
Message-ID: <20230630151628.660343-3-dhowells@redhat.com>
In-Reply-To: <20230630151628.660343-1-dhowells@redhat.com>
References: <20230630151628.660343-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IOCB_WRITE is set by aio, io_uring and cachefiles before submitting a write
operation to the VFS, but it isn't set by, say, the write() system call.

Fix this by adding an extra argument to init_sync_kiocb() to indicate the
direction and setting that to READ or WRITE, which will cause IOCB_WRITE to
be set as appropriate.

Whilst we're at it, rename init_sync_kiocb() to init_kiocb().

This will allow drivers to use IOCB_WRITE instead of the iterator data
source to determine the I/O direction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/btrfs/ioctl.c   |  4 ++--
 fs/read_write.c    | 10 +++++-----
 fs/seq_file.c      |  2 +-
 fs/splice.c        |  2 +-
 include/linux/fs.h |  6 +++++-
 mm/filemap.c       |  2 +-
 mm/page_io.c       |  4 ++--
 7 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a895d105464b..15870337dd26 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4422,7 +4422,7 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 	if (ret < 0)
 		goto out_iov;
 
-	init_sync_kiocb(&kiocb, file);
+	init_kiocb(&kiocb, file, READ);
 	kiocb.ki_pos = pos;
 
 	ret = btrfs_encoded_read(&kiocb, &iter, &args);
@@ -4523,7 +4523,7 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 	if (ret < 0)
 		goto out_end_write;
 
-	init_sync_kiocb(&kiocb, file);
+	init_kiocb(&kiocb, file, WRITE);
 	ret = kiocb_set_rw_flags(&kiocb, 0);
 	if (ret)
 		goto out_end_write;
diff --git a/fs/read_write.c b/fs/read_write.c
index b07de77ef126..6fe517047095 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -382,7 +382,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	struct iov_iter iter;
 	ssize_t ret;
 
-	init_sync_kiocb(&kiocb, filp);
+	init_kiocb(&kiocb, filp, READ);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_ubuf(&iter, ITER_DEST, buf, len);
 
@@ -422,7 +422,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 	if (unlikely(!file->f_op->read_iter || file->f_op->read))
 		return warn_unsupported(file, "read");
 
-	init_sync_kiocb(&kiocb, file);
+	init_kiocb(&kiocb, file, READ);
 	kiocb.ki_pos = pos ? *pos : 0;
 	iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
 	ret = file->f_op->read_iter(&kiocb, &iter);
@@ -484,7 +484,7 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	struct iov_iter iter;
 	ssize_t ret;
 
-	init_sync_kiocb(&kiocb, filp);
+	init_kiocb(&kiocb, filp, WRITE);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_ubuf(&iter, ITER_SOURCE, (void __user *)buf, len);
 
@@ -512,7 +512,7 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 	if (unlikely(!file->f_op->write_iter || file->f_op->write))
 		return warn_unsupported(file, "write");
 
-	init_sync_kiocb(&kiocb, file);
+	init_kiocb(&kiocb, file, WRITE);
 	kiocb.ki_pos = pos ? *pos : 0;
 	ret = file->f_op->write_iter(&kiocb, from);
 	if (ret > 0) {
@@ -723,7 +723,7 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	struct kiocb kiocb;
 	ssize_t ret;
 
-	init_sync_kiocb(&kiocb, filp);
+	init_kiocb(&kiocb, filp, type);
 	ret = kiocb_set_rw_flags(&kiocb, flags);
 	if (ret)
 		return ret;
diff --git a/fs/seq_file.c b/fs/seq_file.c
index f5fdaf3b1572..1ee6ffc630da 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -155,7 +155,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	struct iov_iter iter;
 	ssize_t ret;
 
-	init_sync_kiocb(&kiocb, file);
+	init_kiocb(&kiocb, file, READ);
 	iov_iter_init(&iter, ITER_DEST, &iov, 1, size);
 
 	kiocb.ki_pos = *ppos;
diff --git a/fs/splice.c b/fs/splice.c
index 004eb1c4ce31..867357ebb2c3 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -362,7 +362,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 
 	/* Do the I/O */
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
-	init_sync_kiocb(&kiocb, in);
+	init_kiocb(&kiocb, in, READ);
 	kiocb.ki_pos = *ppos;
 	ret = call_read_iter(in, &kiocb, &to);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d4b67bdeb53e..466eba253502 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2017,13 +2017,17 @@ static inline bool HAS_UNMAPPED_ID(struct mnt_idmap *idmap,
 	       !vfsgid_valid(i_gid_into_vfsgid(idmap, inode));
 }
 
-static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
+static inline void init_kiocb(struct kiocb *kiocb, struct file *filp,
+			      unsigned int rw)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = filp->f_iocb_flags,
 		.ki_ioprio = get_current_ioprio(),
 	};
+
+	if (rw == WRITE)
+		kiocb->ki_flags |= IOCB_WRITE;
 }
 
 static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
diff --git a/mm/filemap.c b/mm/filemap.c
index 9e44a49bbd74..cd763122d2a2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2905,7 +2905,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 	if (unlikely(*ppos >= in->f_mapping->host->i_sb->s_maxbytes))
 		return 0;
 
-	init_sync_kiocb(&iocb, in);
+	init_kiocb(&iocb, in, READ);
 	iocb.ki_pos = *ppos;
 
 	/* Work out how much data we can actually add into the pipe */
diff --git a/mm/page_io.c b/mm/page_io.c
index 684cd3c7b59b..85cbadaf7395 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -312,7 +312,7 @@ static void swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 	}
 	if (!sio) {
 		sio = mempool_alloc(sio_pool, GFP_NOIO);
-		init_sync_kiocb(&sio->iocb, swap_file);
+		init_kiocb(&sio->iocb, swap_file, WRITE);
 		sio->iocb.ki_complete = sio_write_complete;
 		sio->iocb.ki_pos = pos;
 		sio->pages = 0;
@@ -443,7 +443,7 @@ static void swap_readpage_fs(struct page *page,
 	}
 	if (!sio) {
 		sio = mempool_alloc(sio_pool, GFP_KERNEL);
-		init_sync_kiocb(&sio->iocb, sis->swap_file);
+		init_kiocb(&sio->iocb, sis->swap_file, READ);
 		sio->iocb.ki_pos = pos;
 		sio->iocb.ki_complete = sio_read_complete;
 		sio->pages = 0;

