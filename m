Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B84207927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405123AbgFXQaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405017AbgFXQ3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:36 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27251C061796;
        Wed, 24 Jun 2020 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EBfONOMY9ii8aUk0u+XmJ5cXTI9HYeiCStmwDHUGa3I=; b=UcgHI197Wnq3bDYvHG8N72al3l
        iB/UodguMmn5YNn4A6Y1KFSvg6LBUUIUN3OHs7RgH0iU+uMjjFItSmbOxFxRpRz7OrrBfiY2BUOSi
        XAhuJyLy5iXdSbZ2c2n3GhNNicPUx5/g7WHGMbGEAzGon7vLS6WFLeAX6rTvolsWzMxoC5a/D1TlT
        bsAtq31gKvAu2/6x8jTmDLSwuCrXhEhZg4GdBWCKA4o3xeXejS2nttJco4QmtA1COXThLaZUY3tZt
        /CW5xD8DQfI7wypmzZiMd9+gsgT0ovvxz8D/jQGN1J5BFu1tCb9nSmIVgs/aztTMyuT3tViYjA4uP
        goO4sFlA==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Gz-0006pr-PS; Wed, 24 Jun 2020 16:29:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/11] fs: don't allow splice read/write without explicit ops
Date:   Wed, 24 Jun 2020 18:29:01 +0200
Message-Id: <20200624162901.1814136-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624162901.1814136-1-hch@lst.de>
References: <20200624162901.1814136-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that __kernel_write or __kernel_write don't just work on all
file operations instances there is not much of a point of providing
default splice methods.  Renamed the existing default ones to
simple_ and wire them up for the few instancas actually implementing
->read_uptr and ->write_uptr.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/proc_sysctl.c |  2 ++
 fs/splice.c           | 40 ++++++++++++++++++++++++++++------------
 include/linux/fs.h    |  5 ++++-
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index dd5eb693bd00df..5adbc1c8f899cd 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -856,6 +856,8 @@ static const struct file_operations proc_sys_file_operations = {
 	.poll		= proc_sys_poll,
 	.read_uptr	= proc_sys_read,
 	.write_uptr	= proc_sys_write,
+	.splice_read	= simple_splice_read,
+	.splice_write	= simple_splice_write,
 	.llseek		= default_llseek,
 };
 
diff --git a/fs/splice.c b/fs/splice.c
index d1efc53875bd93..d5bba2cd695b5d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -342,9 +342,8 @@ const struct pipe_buf_operations nosteal_pipe_buf_ops = {
 };
 EXPORT_SYMBOL(nosteal_pipe_buf_ops);
 
-static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
-				 struct pipe_inode_info *pipe, size_t len,
-				 unsigned int flags)
+ssize_t simple_splice_read(struct file *in, loff_t *ppos,
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags)
 {
 	struct iov_iter to;
 	struct page **pages;
@@ -779,9 +778,8 @@ static int write_pipe_buf(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 	return ret;
 }
 
-static ssize_t default_file_splice_write(struct pipe_inode_info *pipe,
-					 struct file *out, loff_t *ppos,
-					 size_t len, unsigned int flags)
+ssize_t simple_splice_write(struct pipe_inode_info *pipe, struct file *out,
+		loff_t *ppos, size_t len, unsigned int flags)
 {
 	ssize_t ret;
 
@@ -813,15 +811,30 @@ ssize_t generic_splice_sendpage(struct pipe_inode_info *pipe, struct file *out,
 
 EXPORT_SYMBOL(generic_splice_sendpage);
 
+static void warn_unsupported(struct file *file, const char *op)
+{
+	char pathname[128], *path;
+
+	path = file_path(file, pathname, sizeof(pathname));
+	if (IS_ERR(path))
+		path = "(unknown)";
+	pr_debug_ratelimited(
+		"splice %s not supported for file %s (pid: %d comm: %.20s)\n",
+		op, path, current->pid, current->comm);
+}
+
 /*
  * Attempt to initiate a splice from pipe to file.
  */
 static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 			   loff_t *ppos, size_t len, unsigned int flags)
 {
-	if (out->f_op->splice_write)
-		return out->f_op->splice_write(pipe, out, ppos, len, flags);
-	return default_file_splice_write(pipe, out, ppos, len, flags);
+	if (!out->f_op->splice_write) {
+		warn_unsupported(out, "write");
+		return -EINVAL;
+	}
+
+	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
 /*
@@ -843,9 +856,12 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 	if (unlikely(len > MAX_RW_COUNT))
 		len = MAX_RW_COUNT;
 
-	if (in->f_op->splice_read)
-		return in->f_op->splice_read(in, ppos, pipe, len, flags);
-	return default_file_splice_read(in, ppos, pipe, len, flags);
+	if (!in->f_op->splice_read) {
+		warn_unsupported(in, "read");
+		return -EINVAL;
+	}
+
+	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d0fea0281ef29b..64a6506cba0446 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3175,7 +3175,10 @@ extern ssize_t generic_splice_sendpage(struct pipe_inode_info *pipe,
 		struct file *out, loff_t *, size_t len, unsigned int flags);
 extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 		loff_t *opos, size_t len, unsigned int flags);
-
+ssize_t simple_splice_read(struct file *in, loff_t *ppos,
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags);
+ssize_t simple_splice_write(struct pipe_inode_info *pipe, struct file *out,
+		loff_t *ppos, size_t len, unsigned int flags);
 
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
-- 
2.26.2

