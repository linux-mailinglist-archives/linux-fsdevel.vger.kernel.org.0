Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA6A699F47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjBPVtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBPVtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DDD3B3C2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hl97XF3hOliR+/qiliOpOdWdf+h1RkO7skZ504Yz8AE=;
        b=i2j3XsWYzY/S8K7USi890A8RDxnUMp7BevPotXYYS6MvUX6qMxk5d++Vc80pSH+S7VMNRN
        1QdZNzM3SkoD4zWlYSlcooXJqQ3qui003KX7ByctsEBgLFrY9riirudVFSkFd+JX1wV66p
        ONFqk7D+A6wuu7BV/l3flHqKq5CYp44=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-ugZV4pIFMu6kB63jpxbEvQ-1; Thu, 16 Feb 2023 16:48:28 -0500
X-MC-Unique: ugZV4pIFMu6kB63jpxbEvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FA0B38123AF;
        Thu, 16 Feb 2023 21:48:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7765640C10FA;
        Thu, 16 Feb 2023 21:48:25 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: [PATCH 07/17] cifs: Implement splice_read to pass down ITER_BVEC not ITER_PIPE
Date:   Thu, 16 Feb 2023 21:47:35 +0000
Message-Id: <20230216214745.3985496-8-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
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
 fs/cifs/cifsfs.c | 12 ++++++------
 fs/cifs/cifsfs.h |  3 +++
 fs/cifs/file.c   | 16 ++++++++++++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 10e00c624922..4f1afcd3f8be 100644
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
+	.splice_read = direct_splice_read,
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
+	.splice_read = direct_splice_read,
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
index e216bc9b7abf..ddf6f572af81 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5275,3 +5275,19 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.launder_folio = cifs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 };
+
+/*
+ * Splice data from a file into a pipe.
+ */
+ssize_t cifs_splice_read(struct file *in, loff_t *ppos,
+			 struct pipe_inode_info *pipe, size_t len,
+			 unsigned int flags)
+{
+	if (unlikely(*ppos >= file_inode(in)->i_sb->s_maxbytes))
+		return 0;
+	if (unlikely(!len))
+		return 0;
+	if (in->f_flags & O_DIRECT)
+		return direct_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}

