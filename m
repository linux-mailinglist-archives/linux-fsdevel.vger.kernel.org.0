Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9CA21145C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGAUXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGAUXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB17C08C5C1;
        Wed,  1 Jul 2020 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jlXrr1b8urlbr9PamhblsvEHUflz9FDOmmp8LAbhvP8=; b=PZpbJzpMhp7D76hGAi0SBT0pzU
        bR6KGAKFozdL4MWglLb//XLIoDQw2ROu8LeDDBrZfnaRsUJ5evv780xdcShgfsZqlf66HLruDPHvX
        qXN5TXRtXJEp8SROvYqLN6qmPMe6H9LsX+MhOVIRzojuQMChryo98IYD5oef3Zp+L1beJJ+IO4wi/
        gCq/pPhh13lKnJccRwJR1gl+K4MkK9ol5nP4VXdY36Q03EzxebcG2ShyWCLRczqpzbHJ9DZp+B5QP
        mBlQIbeSJpbq0Sl9hHhxA6++akccrijHjTAAHaW4iyRXkrgXkfapPw3CfUINtnS6nfuUwt4IdJhfn
        WsUtgldA==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjGJ-0002SQ-5D; Wed, 01 Jul 2020 20:23:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/23] proc: add a read_iter method to proc proc_ops
Date:   Wed,  1 Jul 2020 22:09:45 +0200
Message-Id: <20200701200951.3603160-18-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701200951.3603160-1-hch@lst.de>
References: <20200701200951.3603160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow proc files to implement iter read semantics.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/inode.c         | 28 ++++++++++++++++++++++++++++
 include/linux/proc_fs.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 28d6105e908e4c..fa86619cebc2be 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -297,6 +297,29 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
 	return rv;
 }
 
+static ssize_t pde_read_iter(struct proc_dir_entry *pde, struct kiocb *iocb,
+		struct iov_iter *iter)
+{
+	if (!pde->proc_ops->proc_read_iter)
+		return -EINVAL;
+	return pde->proc_ops->proc_read_iter(iocb, iter);
+}
+
+static ssize_t proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct proc_dir_entry *pde = PDE(file_inode(iocb->ki_filp));
+	ssize_t ret;
+
+	if (pde_is_permanent(pde))
+		return pde_read_iter(pde, iocb, iter);
+
+	if (!use_pde(pde))
+		return -EIO;
+	ret = pde_read_iter(pde, iocb, iter);
+	unuse_pde(pde);
+	return ret;
+}
+
 static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	typeof_member(struct proc_ops, proc_read) read;
@@ -312,6 +335,9 @@ static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count,
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	ssize_t rv = -EIO;
 
+	if (pde->proc_ops->proc_read_iter)
+		return iter_read(file, buf, count, ppos, proc_reg_read_iter);
+
 	if (pde_is_permanent(pde)) {
 		return pde_read(pde, file, buf, count, ppos);
 	} else if (use_pde(pde)) {
@@ -569,6 +595,7 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 static const struct file_operations proc_reg_file_ops = {
 	.llseek		= proc_reg_llseek,
 	.read		= proc_reg_read,
+	.read_iter	= proc_reg_read_iter,
 	.write		= proc_reg_write,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
@@ -585,6 +612,7 @@ static const struct file_operations proc_reg_file_ops = {
 static const struct file_operations proc_reg_file_ops_no_compat = {
 	.llseek		= proc_reg_llseek,
 	.read		= proc_reg_read,
+	.read_iter	= proc_reg_read_iter,
 	.write		= proc_reg_write,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index d1eed1b4365172..97b3f5f06db9d8 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -30,6 +30,7 @@ struct proc_ops {
 	unsigned int proc_flags;
 	int	(*proc_open)(struct inode *, struct file *);
 	ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);
+	ssize_t (*proc_read_iter)(struct kiocb *, struct iov_iter *);
 	ssize_t	(*proc_write)(struct file *, const char __user *, size_t, loff_t *);
 	loff_t	(*proc_lseek)(struct file *, loff_t, int);
 	int	(*proc_release)(struct inode *, struct file *);
-- 
2.26.2

