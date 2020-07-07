Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B4217575
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgGGRsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgGGRsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7443C061755;
        Tue,  7 Jul 2020 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EnavTkgxyxgyyAtAribcKqVL9aBK4q+saHxSi5sRM4k=; b=lVbi0VKHr3xM2aqKT0GJByTECH
        UOBgMbcnBwcyRtMA+Wm2nyda/T5ij03HR5gomWIbj4jlPkhjOaRmFahHja+A59HgzRD+Z+tttb5p1
        PXAKQ6RwngSMUuLzRvTWq5JYxaOEK5Talu7PQhO4Jx23WW6b1li8pPXgXXuMobmQYcoqibvegiQsz
        3zV99vFFyfxLcam10qK36w/WATF105PWlc/2VkLNmtjxpRNaYCkwgJx6jIZrxiRgzmGZZVbR4GHs+
        XzgZIlEPzHwuHkx4O+z/r2W/6A6eFMOX3iWJy2mLiNcMQ68AVjM+vnZv50zwvz+oF3KQIuZpCJKox
        D1c4lyTg==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhl-0003M6-UG; Tue, 07 Jul 2020 17:48:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/23] proc: add a read_iter method to proc proc_ops
Date:   Tue,  7 Jul 2020 19:47:56 +0200
Message-Id: <20200707174801.4162712-19-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
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
 fs/proc/inode.c         | 53 ++++++++++++++++++++++++++++++++++++++---
 include/linux/proc_fs.h |  1 +
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 93dd2045737504..58c075e2a452d6 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -297,6 +297,21 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
 	return rv;
 }
 
+static ssize_t proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct proc_dir_entry *pde = PDE(file_inode(iocb->ki_filp));
+	ssize_t ret;
+
+	if (pde_is_permanent(pde))
+		return pde->proc_ops->proc_read_iter(iocb, iter);
+
+	if (!use_pde(pde))
+		return -EIO;
+	ret = pde->proc_ops->proc_read_iter(iocb, iter);
+	unuse_pde(pde);
+	return ret;
+}
+
 static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	typeof_member(struct proc_ops, proc_read) read;
@@ -578,6 +593,18 @@ static const struct file_operations proc_reg_file_ops = {
 	.release	= proc_reg_release,
 };
 
+static const struct file_operations proc_iter_file_ops = {
+	.llseek		= proc_reg_llseek,
+	.read_iter	= proc_reg_read_iter,
+	.write		= proc_reg_write,
+	.poll		= proc_reg_poll,
+	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
+	.mmap		= proc_reg_mmap,
+	.get_unmapped_area = proc_reg_get_unmapped_area,
+	.open		= proc_reg_open,
+	.release	= proc_reg_release,
+};
+
 #ifdef CONFIG_COMPAT
 static const struct file_operations proc_reg_file_ops_compat = {
 	.llseek		= proc_reg_llseek,
@@ -591,6 +618,19 @@ static const struct file_operations proc_reg_file_ops_compat = {
 	.open		= proc_reg_open,
 	.release	= proc_reg_release,
 };
+
+static const struct file_operations proc_iter_file_ops_compat = {
+	.llseek		= proc_reg_llseek,
+	.read_iter	= proc_reg_read_iter,
+	.write		= proc_reg_write,
+	.poll		= proc_reg_poll,
+	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
+	.compat_ioctl	= proc_reg_compat_ioctl,
+	.mmap		= proc_reg_mmap,
+	.get_unmapped_area = proc_reg_get_unmapped_area,
+	.open		= proc_reg_open,
+	.release	= proc_reg_release,
+};
 #endif
 
 static void proc_put_link(void *p)
@@ -642,10 +682,17 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = de->proc_iops;
-		inode->i_fop = &proc_reg_file_ops;
+		if (de->proc_ops->proc_read_iter)
+			inode->i_fop = &proc_iter_file_ops;
+		else
+			inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-		if (de->proc_ops->proc_compat_ioctl)
-			inode->i_fop = &proc_reg_file_ops_compat;
+		if (de->proc_ops->proc_compat_ioctl) {
+			if (de->proc_ops->proc_read_iter)
+				inode->i_fop = &proc_iter_file_ops_compat;
+			else
+				inode->i_fop = &proc_reg_file_ops_compat;
+		}
 #endif
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = de->proc_iops;
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

