Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300D7090A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjESHns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjESHnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2A18F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5qDgkT4BMNnpU06yXa6htF6MTIyeI5iJgctjYsdWto=;
        b=Y5BH9WR+HbpyTBQ23maxkgk8LNdS2zRt5qF16bTWHhCJMVnpYzuHaZbYZ9BI1Hl5NSVxwA
        cB70opIeyxVcoRoee18y4/d9d1Hmnx4Y6Cm1pxzlLNqV51KZXidoP6Y5J/47plmTOUW77k
        VR2P9dNYiXyvmw89Yz5CLsjaE80LCrg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-UwmqYBTZNaOSEg7543TOgw-1; Fri, 19 May 2023 03:41:56 -0400
X-MC-Unique: UwmqYBTZNaOSEg7543TOgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABE8E1C04B50;
        Fri, 19 May 2023 07:41:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 367671121314;
        Fri, 19 May 2023 07:41:53 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v20 16/32] f2fs: Provide a splice-read stub
Date:   Fri, 19 May 2023 08:40:31 +0100
Message-Id: <20230519074047.1739879-17-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read stub for f2fs.  This does some checks and tracing
before proceeding and will switch from direct-I/O to buffered I/O if forced
or if misaligned.  It also updates the iostats after doing a buffered I/O.

[Note: I wonder if I should only do the tracing if I call
filemap_splice_read() as direct_splice_read() will call
f2fs_file_read_iter().]

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jaegeuk Kim <jaegeuk@kernel.org>
cc: Chao Yu <chao@kernel.org>
cc: linux-f2fs-devel@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/f2fs/file.c | 68 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5ac53d2627d2..3723387f4a87 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4367,22 +4367,23 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
-static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
+static void f2fs_trace_rw_file_path(struct file *file, loff_t pos, size_t count,
+				    int rw)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
+	struct inode *inode = file_inode(file);
 	char *buf, *path;
 
 	buf = f2fs_getname(F2FS_I_SB(inode));
 	if (!buf)
 		return;
-	path = dentry_path_raw(file_dentry(iocb->ki_filp), buf, PATH_MAX);
+	path = dentry_path_raw(file_dentry(file), buf, PATH_MAX);
 	if (IS_ERR(path))
 		goto free_buf;
 	if (rw == WRITE)
-		trace_f2fs_datawrite_start(inode, iocb->ki_pos, count,
+		trace_f2fs_datawrite_start(inode, pos, count,
 				current->pid, path, current->comm);
 	else
-		trace_f2fs_dataread_start(inode, iocb->ki_pos, count,
+		trace_f2fs_dataread_start(inode, pos, count,
 				current->pid, path, current->comm);
 free_buf:
 	f2fs_putname(buf);
@@ -4398,7 +4399,8 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return -EOPNOTSUPP;
 
 	if (trace_f2fs_dataread_start_enabled())
-		f2fs_trace_rw_file_path(iocb, iov_iter_count(to), READ);
+		f2fs_trace_rw_file_path(iocb->ki_filp, iocb->ki_pos,
+					iov_iter_count(to), READ);
 
 	if (f2fs_should_use_dio(inode, iocb, to)) {
 		ret = f2fs_dio_read_iter(iocb, to);
@@ -4413,6 +4415,55 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t f2fs_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	const loff_t pos = *ppos;
+	ssize_t ret;
+
+	if (!f2fs_is_compress_backend_ready(inode))
+		return -EOPNOTSUPP;
+
+	if (trace_f2fs_dataread_start_enabled())
+		f2fs_trace_rw_file_path(in, pos, len, READ);
+
+	if (in->f_flags & O_DIRECT) {
+		if (f2fs_force_buffered_io(inode, READ))
+			goto buffered;
+
+		/*
+		 * Direct I/O not aligned to the disk's logical_block_size will
+		 * be attempted, but will fail with -EINVAL.
+		 *
+		 * f2fs additionally requires that direct I/O be aligned to the
+		 * filesystem block size, which is often a stricter
+		 * requirement.  However, f2fs traditionally falls back to
+		 * buffered I/O on requests that are logical_block_size-aligned
+		 * but not fs-block aligned.
+		 *
+		 * The below logic implements this behavior.
+		 */
+		if (!IS_ALIGNED(pos, i_blocksize(inode)) &&
+		    IS_ALIGNED(pos, bdev_logical_block_size(inode->i_sb->s_bdev)))
+			goto buffered;
+		ret = direct_splice_read(in, ppos, pipe, len, flags);
+		goto done;
+	}
+
+buffered:
+	ret = filemap_splice_read(in, ppos, pipe, len, flags);
+	if (ret > 0)
+		f2fs_update_iostat(F2FS_I_SB(inode), inode,
+				   APP_BUFFERED_READ_IO, ret);
+
+done:
+	if (trace_f2fs_dataread_end_enabled())
+		trace_f2fs_dataread_end(inode, pos, ret);
+	return ret;
+}
+
 static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -4714,7 +4765,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = preallocated;
 	} else {
 		if (trace_f2fs_datawrite_start_enabled())
-			f2fs_trace_rw_file_path(iocb, orig_count, WRITE);
+			f2fs_trace_rw_file_path(iocb->ki_filp, iocb->ki_pos,
+						orig_count, WRITE);
 
 		/* Do the actual write. */
 		ret = dio ?
@@ -4919,7 +4971,7 @@ const struct file_operations f2fs_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= f2fs_compat_ioctl,
 #endif
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
 };

