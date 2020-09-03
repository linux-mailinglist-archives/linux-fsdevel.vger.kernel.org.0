Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD725C336
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgICOrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgICOYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:24:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D4AC06123B;
        Thu,  3 Sep 2020 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DsUb6hfLeJUvA4GCxVVSz23IH1puKspKytCSglE7c2s=; b=LdRJc175F5A1pOcbnm1cLKFZlU
        ZWU8Ms6njxu8IGdDsuP6Xtf6gGdB1TXoO8O+jnMnwBOYHipnKu3MNZF9yCeopFU5o/EM+3MKdnvTN
        rupIWrHI6Ls/BCx4j3hhdamcbq8phYVNK5ud8/ptEEHdTR4iXZ1wNf8vFGgvvU0UEeuso2FSGiZuj
        AynpHzCxr7W78ExmgJvcBrkBdEyg+UodTDeIECsS7lDH9dIjMypmt8ilvWKv8hLTmI+ag7zWapcr8
        8prZMxYcoHUeZOkvoj/M4W9Xnt0H0kpSyMSyGCsfvZp3iEMfeWTGg/4D8rkCU6pza8Y0gTXauR8Sc
        1tjzf3NA==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDq8W-0004aY-QY; Thu, 03 Sep 2020 14:22:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/14] sysctl: Convert to iter interfaces
Date:   Thu,  3 Sep 2020 16:22:32 +0200
Message-Id: <20200903142242.925828-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Using the read_iter/write_iter interfaces allows for in-kernel users
to set sysctls without using set_fs().  Also, the buffer is a string,
so give it the real type of 'char *', not void *.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/proc_sysctl.c      | 46 ++++++++++++++++++--------------------
 include/linux/bpf-cgroup.h |  2 +-
 kernel/bpf/cgroup.c        |  2 +-
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c1166ccdaea57..a4a3122f8a584a 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -12,6 +12,7 @@
 #include <linux/cred.h>
 #include <linux/namei.h>
 #include <linux/mm.h>
+#include <linux/uio.h>
 #include <linux/module.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/mount.h>
@@ -540,13 +541,14 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
-		size_t count, loff_t *ppos, int write)
+static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
+		int write)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct ctl_table_header *head = grab_header(inode);
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
-	void *kbuf;
+	size_t count = iov_iter_count(iter);
+	char *kbuf;
 	ssize_t error;
 
 	if (IS_ERR(head))
@@ -569,32 +571,30 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 	error = -ENOMEM;
 	if (count >= KMALLOC_MAX_SIZE)
 		goto out;
+	kbuf = kzalloc(count + 1, GFP_KERNEL);
+	if (!kbuf)
+		goto out;
 
 	if (write) {
-		kbuf = memdup_user_nul(ubuf, count);
-		if (IS_ERR(kbuf)) {
-			error = PTR_ERR(kbuf);
-			goto out;
-		}
-	} else {
-		kbuf = kzalloc(count, GFP_KERNEL);
-		if (!kbuf)
-			goto out;
+		error = -EFAULT;
+		if (!copy_from_iter_full(kbuf, count, iter))
+			goto out_free_buf;
+		kbuf[count] = '\0';
 	}
 
 	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, &kbuf, &count,
-					   ppos);
+					   &iocb->ki_pos);
 	if (error)
 		goto out_free_buf;
 
 	/* careful: calling conventions are nasty here */
-	error = table->proc_handler(table, write, kbuf, &count, ppos);
+	error = table->proc_handler(table, write, kbuf, &count, &iocb->ki_pos);
 	if (error)
 		goto out_free_buf;
 
 	if (!write) {
 		error = -EFAULT;
-		if (copy_to_user(ubuf, kbuf, count))
+		if (copy_to_iter(kbuf, count, iter) < count)
 			goto out_free_buf;
 	}
 
@@ -607,16 +607,14 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 	return error;
 }
 
-static ssize_t proc_sys_read(struct file *filp, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t proc_sys_read(struct kiocb *iocb, struct iov_iter *iter)
 {
-	return proc_sys_call_handler(filp, (void __user *)buf, count, ppos, 0);
+	return proc_sys_call_handler(iocb, iter, 0);
 }
 
-static ssize_t proc_sys_write(struct file *filp, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t proc_sys_write(struct kiocb *iocb, struct iov_iter *iter)
 {
-	return proc_sys_call_handler(filp, (void __user *)buf, count, ppos, 1);
+	return proc_sys_call_handler(iocb, iter, 1);
 }
 
 static int proc_sys_open(struct inode *inode, struct file *filp)
@@ -853,8 +851,8 @@ static int proc_sys_getattr(const struct path *path, struct kstat *stat,
 static const struct file_operations proc_sys_file_operations = {
 	.open		= proc_sys_open,
 	.poll		= proc_sys_poll,
-	.read		= proc_sys_read,
-	.write		= proc_sys_write,
+	.read_iter	= proc_sys_read,
+	.write_iter	= proc_sys_write,
 	.llseek		= default_llseek,
 };
 
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 64f367044e25f4..82b26a1386d85e 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -136,7 +136,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
-				   void **buf, size_t *pcount, loff_t *ppos,
+				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum bpf_attach_type type);
 
 int __cgroup_bpf_run_filter_setsockopt(struct sock *sock, int *level,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index e21de4f1754c2c..6ec088a96302f9 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1226,7 +1226,7 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
  */
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
-				   void **buf, size_t *pcount, loff_t *ppos,
+				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum bpf_attach_type type)
 {
 	struct bpf_sysctl_kern ctx = {
-- 
2.28.0

