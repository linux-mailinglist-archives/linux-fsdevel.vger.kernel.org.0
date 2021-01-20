Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C22FCE4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbhATKX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 05:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbhATJLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:11:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678E7C061575;
        Wed, 20 Jan 2021 01:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QpKIHOu+0ftGyh0rhFMgW7Ru/eWQHtz/uPpaeBV+9Tg=; b=uuP8R+x4VHRgBlkf3bLk7tDMe2
        MCavNmul1/R+vwoa+wmZPHxDXOkNdMliMgjOaOI1JRkT21488icN8T2eVclGn+EgS1Q53VcE5JFZp
        TXe+O/s19ybSx0QQ4i5y6KgrEZOVroJIj9jAh0B5jS/IeeREfgqLFHy8qTTpzpKsbwMDgfzrX+K9S
        dpBNyyNBZiu/sxWj7ZULRQJDgCzxN2tkia97D65DwKGQrFu3Zutp5R3O3MsqwX8QiyLrzi7DxjuYk
        aekYthJ31GhcYz+1wUg4KDZZ7EkvGLTxNcuGXuakplMkkTJ5oPzL6VYpsJ4+jlUrYIEvVTJD0Me7U
        dvVr1T2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l29VZ-00FSSx-1e; Wed, 20 Jan 2021 09:10:36 +0000
Date:   Wed, 20 Jan 2021 09:10:33 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>
Subject: Re: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
Message-ID: <20210120091033.GA3683647@infradead.org>
References: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can you give this patch a spin?


diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f277d023ebcd14..4b5833b3059f9c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/sched/mm.h>
 #include <linux/fsnotify.h>
+#include <linux/uio.h>
 
 #include "kernfs-internal.h"
 
@@ -180,11 +181,10 @@ static const struct seq_operations kernfs_seq_ops = {
  * it difficult to use seq_file.  Implement simplistic custom buffering for
  * bin files.
  */
-static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
-				       char __user *user_buf, size_t count,
-				       loff_t *ppos)
+static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	ssize_t len = min_t(size_t, count, PAGE_SIZE);
+	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
+	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
 	char *buf;
 
@@ -210,7 +210,7 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
 	of->event = atomic_read(&of->kn->attr.open->event);
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
-		len = ops->read(of, buf, len, *ppos);
+		len = ops->read(of, buf, len, iocb->ki_pos);
 	else
 		len = -EINVAL;
 
@@ -220,12 +220,12 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
 	if (len < 0)
 		goto out_free;
 
-	if (copy_to_user(user_buf, buf, len)) {
+	if (copy_to_iter(buf, len, iter) != len) {
 		len = -EFAULT;
 		goto out_free;
 	}
 
-	*ppos += len;
+	iocb->ki_pos += len;
 
  out_free:
 	if (buf == of->prealloc_buf)
@@ -235,31 +235,14 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
 	return len;
 }
 
-/**
- * kernfs_fop_read - kernfs vfs read callback
- * @file: file pointer
- * @user_buf: data to write
- * @count: number of bytes
- * @ppos: starting offset
- */
-static ssize_t kernfs_fop_read(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t kernfs_fop_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct kernfs_open_file *of = kernfs_of(file);
-
-	if (of->kn->flags & KERNFS_HAS_SEQ_SHOW)
-		return seq_read(file, user_buf, count, ppos);
-	else
-		return kernfs_file_direct_read(of, user_buf, count, ppos);
+	if (kernfs_of(iocb->ki_filp)->kn->flags & KERNFS_HAS_SEQ_SHOW)
+		return seq_read_iter(iocb, iter);
+	return kernfs_file_read_iter(iocb, iter);
 }
 
-/**
- * kernfs_fop_write - kernfs vfs write callback
- * @file: file pointer
- * @user_buf: data to write
- * @count: number of bytes
- * @ppos: starting offset
- *
+/*
  * Copy data in from userland and pass it to the matching kernfs write
  * operation.
  *
@@ -269,20 +252,18 @@ static ssize_t kernfs_fop_read(struct file *file, char __user *user_buf,
  * modify only the the value you're changing, then write entire buffer
  * back.
  */
-static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct kernfs_open_file *of = kernfs_of(file);
+	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
+	ssize_t len = iov_iter_count(iter);
 	const struct kernfs_ops *ops;
-	ssize_t len;
 	char *buf;
 
 	if (of->atomic_write_len) {
-		len = count;
 		if (len > of->atomic_write_len)
 			return -E2BIG;
 	} else {
-		len = min_t(size_t, count, PAGE_SIZE);
+		len = min_t(size_t, len, PAGE_SIZE);
 	}
 
 	buf = of->prealloc_buf;
@@ -293,7 +274,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, user_buf, len)) {
+	if (copy_from_iter(buf, len, iter) != len) {
 		len = -EFAULT;
 		goto out_free;
 	}
@@ -312,7 +293,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
 
 	ops = kernfs_ops(of->kn);
 	if (ops->write)
-		len = ops->write(of, buf, len, *ppos);
+		len = ops->write(of, buf, len, iocb->ki_pos);
 	else
 		len = -EINVAL;
 
@@ -320,7 +301,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
 	mutex_unlock(&of->mutex);
 
 	if (len > 0)
-		*ppos += len;
+		iocb->ki_pos += len;
 
 out_free:
 	if (buf == of->prealloc_buf)
@@ -960,14 +941,16 @@ void kernfs_notify(struct kernfs_node *kn)
 EXPORT_SYMBOL_GPL(kernfs_notify);
 
 const struct file_operations kernfs_file_fops = {
-	.read		= kernfs_fop_read,
-	.write		= kernfs_fop_write,
+	.read_iter	= kernfs_fop_read_iter,
+	.write_iter	= kernfs_fop_write_iter,
 	.llseek		= generic_file_llseek,
 	.mmap		= kernfs_fop_mmap,
 	.open		= kernfs_fop_open,
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
 	.fsync		= noop_fsync,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
 };
 
 /**
