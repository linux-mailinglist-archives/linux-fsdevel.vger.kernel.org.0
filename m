Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EAF9817D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfHURij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730087AbfHURi1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C90C91761;
        Wed, 21 Aug 2019 17:38:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F57416D41;
        Wed, 21 Aug 2019 17:38:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A400D223CFE; Wed, 21 Aug 2019 13:38:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
        dgilbert@redhat.com, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 02/13] fuse: Use default_file_splice_read for direct IO
Date:   Wed, 21 Aug 2019 13:37:31 -0400
Message-Id: <20190821173742.24574-3-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 21 Aug 2019 17:38:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

---
 fs/fuse/file.c     | 15 ++++++++++++++-
 fs/splice.c        |  3 ++-
 include/linux/fs.h |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5ae2828beb00..c45ffe6f1ecb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2172,6 +2172,19 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static ssize_t fuse_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe, size_t len,
+				     unsigned int flags)
+{
+	struct fuse_file *ff = in->private_data;
+
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		return default_file_splice_read(in, ppos, pipe, len, flags);
+	else
+		return generic_file_splice_read(in, ppos, pipe, len, flags);
+
+}
+
 static int convert_fuse_file_lock(struct fuse_conn *fc,
 				  const struct fuse_file_lock *ffl,
 				  struct file_lock *fl)
@@ -3228,7 +3241,7 @@ static const struct file_operations fuse_file_operations = {
 	.fsync		= fuse_fsync,
 	.lock		= fuse_file_lock,
 	.flock		= fuse_file_flock,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= fuse_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.unlocked_ioctl	= fuse_file_ioctl,
 	.compat_ioctl	= fuse_file_compat_ioctl,
diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..652f541d953d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -362,7 +362,7 @@ static ssize_t kernel_readv(struct file *file, const struct kvec *vec,
 	return res;
 }
 
-static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
+ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags)
 {
@@ -426,6 +426,7 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_advance(&to, copied);	/* truncates and discards */
 	return res;
 }
+EXPORT_SYMBOL(default_file_splice_read);
 
 /*
  * Send 'sd->len' bytes to socket from 'sd->file' at position 'sd->pos'
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 997a530ff4e9..15ae8f5dd24e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3062,6 +3062,8 @@ extern void block_sync_page(struct page *page);
 /* fs/splice.c */
 extern ssize_t generic_file_splice_read(struct file *, loff_t *,
 		struct pipe_inode_info *, size_t, unsigned int);
+extern ssize_t default_file_splice_read(struct file *, loff_t *,
+		struct pipe_inode_info *, size_t, unsigned int);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 		struct file *, loff_t *, size_t, unsigned int);
 extern ssize_t generic_splice_sendpage(struct pipe_inode_info *pipe,
-- 
2.20.1

