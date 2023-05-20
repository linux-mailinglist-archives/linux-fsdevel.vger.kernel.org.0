Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4576770A393
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 02:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjETACl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 20:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjETACg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 20:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D1E76
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684540871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+CzZRPIOEI63Yig5Ocd0qzQo9k6vKIgNZsTOkrOnGQ=;
        b=DN5ckemPDS5614CFyCUX+eRrEZQXmHExnJ8kRvYM7+hyjsB7pLPZb/dSJs9EF9TQQj2S4h
        iNc+hHRKQ+eimBxEoqgs3ExZYI2tnAE+j/Y1LLdSDyuYClsZphExLwbCEvwrzMKyuDeYU1
        QGFo5iElc/snwpG0EwjOpGI3CL8vg0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-YEHt9biKO1iJWTOezthP0Q-1; Fri, 19 May 2023 20:01:03 -0400
X-MC-Unique: YEHt9biKO1iJWTOezthP0Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CA87811E86;
        Sat, 20 May 2023 00:01:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 614E94F2DE6;
        Sat, 20 May 2023 00:01:00 +0000 (UTC)
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
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Subject: [PATCH v21 03/30] splice: Rename direct_splice_read() to copy_splice_read()
Date:   Sat, 20 May 2023 01:00:22 +0100
Message-Id: <20230520000049.2226926-4-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename direct_splice_read() to copy_splice_read() to better reflect as to
what it does.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Steve French <sfrench@samba.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cifs/cifsfs.c   |  4 ++--
 fs/cifs/file.c     |  2 +-
 fs/splice.c        | 11 +++++------
 include/linux/fs.h |  6 +++---
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 43a4d8603db3..fa2477bbcc86 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1416,7 +1416,7 @@ const struct file_operations cifs_file_direct_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_mmap,
-	.splice_read = direct_splice_read,
+	.splice_read = copy_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
@@ -1470,7 +1470,7 @@ const struct file_operations cifs_file_direct_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_mmap,
-	.splice_read = direct_splice_read,
+	.splice_read = copy_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index c5fcefdfd797..023496207c18 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5091,6 +5091,6 @@ ssize_t cifs_splice_read(struct file *in, loff_t *ppos,
 	if (unlikely(!len))
 		return 0;
 	if (in->f_flags & O_DIRECT)
-		return direct_splice_read(in, ppos, pipe, len, flags);
+		return copy_splice_read(in, ppos, pipe, len, flags);
 	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae..2478e065bc53 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -300,12 +300,11 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
 }
 
 /*
- * Splice data from an O_DIRECT file into pages and then add them to the output
- * pipe.
+ * Copy data from a file into pages and then splice those into the output pipe.
  */
-ssize_t direct_splice_read(struct file *in, loff_t *ppos,
-			   struct pipe_inode_info *pipe,
-			   size_t len, unsigned int flags)
+ssize_t copy_splice_read(struct file *in, loff_t *ppos,
+			 struct pipe_inode_info *pipe,
+			 size_t len, unsigned int flags)
 {
 	struct iov_iter to;
 	struct bio_vec *bv;
@@ -390,7 +389,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	kfree(bv);
 	return ret;
 }
-EXPORT_SYMBOL(direct_splice_read);
+EXPORT_SYMBOL(copy_splice_read);
 
 /**
  * generic_file_splice_read - splice data from file to a pipe
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..e3c22efa413e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2752,9 +2752,9 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			    struct pipe_inode_info *pipe,
 			    size_t len, unsigned int flags);
-ssize_t direct_splice_read(struct file *in, loff_t *ppos,
-			   struct pipe_inode_info *pipe,
-			   size_t len, unsigned int flags);
+ssize_t copy_splice_read(struct file *in, loff_t *ppos,
+			 struct pipe_inode_info *pipe,
+			 size_t len, unsigned int flags);
 extern ssize_t generic_file_splice_read(struct file *, loff_t *,
 		struct pipe_inode_info *, size_t, unsigned int);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,

