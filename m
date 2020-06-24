Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B170120791B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405025AbgFXQ3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404833AbgFXQ31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:27 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A12C061798;
        Wed, 24 Jun 2020 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2HvZhOUeF9FDVyXb54Pz1N0sRkDLIwNnoR/STkbBseI=; b=DcTcPMHn3/rJewMozHZFNKVYdM
        Y1kb+6nBjEQdRJu32NwJA7MDexPZ1wLpJWq8BoSNtXEEvIRm3GFf1mN+oy19oDUMUITMHjO+0vZGa
        m9ApZHQq5C/AU4VMTc89L18igA+ZrWZXIlj8TDNGG1ouHSZddAZeZMrl+mc+A/uENcUnyjq8TVYm3
        0qiZiVg1ujK0pfVcDSEbxT2n2Ropj4fUdtilZsuzMsLvjKgn5SwQ0J9FThJBFXE96/uBfFCaCuICu
        OlFbejHbwAB2QrMRcbhGUhvuIVwYbfaFksLl7bipA0i3X5LncABo28fKgYMq/2UuzU0OGbxpIoKe2
        GD1UtjAA==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Gq-0006oi-Mj; Wed, 24 Jun 2020 16:29:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] sysctl: switch to ->{read,write}_uptr
Date:   Wed, 24 Jun 2020 18:28:54 +0200
Message-Id: <20200624162901.1814136-5-hch@lst.de>
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

This allows the sysctl handler to safely take kernel space pointers,
as required for the new code to set sysctl parameters at boot time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/proc_sysctl.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 42c5128c7d1c76..dd5eb693bd00df 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -540,7 +540,7 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
+static ssize_t proc_sys_call_handler(struct file *filp, uptr_t buf,
 		size_t count, loff_t *ppos, int write)
 {
 	struct inode *inode = file_inode(filp);
@@ -566,20 +566,21 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	/* don't even try if the size is too large */
-	if (count > KMALLOC_MAX_SIZE)
+	if (count >= KMALLOC_MAX_SIZE)
 		return -ENOMEM;
 
+	error = -ENOMEM;
+
+	/* allow for NULL termination on writes */
+	kbuf = kzalloc(count + (write ? 1 : 0), GFP_KERNEL);
+	if (!kbuf)
+		goto out;
+
 	if (write) {
-		kbuf = memdup_user_nul(ubuf, count);
-		if (IS_ERR(kbuf)) {
-			error = PTR_ERR(kbuf);
-			goto out;
-		}
-	} else {
-		error = -ENOMEM;
-		kbuf = kzalloc(count, GFP_KERNEL);
-		if (!kbuf)
-			goto out;
+		error = -EFAULT;
+		if (copy_from_uptr(kbuf, buf, count))
+			goto out_free_buf;
+		((char *)kbuf)[count] = '\0';
 	}
 
 	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, &kbuf, &count,
@@ -594,7 +595,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 
 	if (!write) {
 		error = -EFAULT;
-		if (copy_to_user(ubuf, kbuf, count))
+		if (copy_to_uptr(buf, kbuf, count))
 			goto out_free_buf;
 	}
 
@@ -607,16 +608,16 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 	return error;
 }
 
-static ssize_t proc_sys_read(struct file *filp, char __user *buf,
+static ssize_t proc_sys_read(struct file *filp, uptr_t buf,
 				size_t count, loff_t *ppos)
 {
-	return proc_sys_call_handler(filp, (void __user *)buf, count, ppos, 0);
+	return proc_sys_call_handler(filp, buf, count, ppos, 0);
 }
 
-static ssize_t proc_sys_write(struct file *filp, const char __user *buf,
+static ssize_t proc_sys_write(struct file *filp, uptr_t buf,
 				size_t count, loff_t *ppos)
 {
-	return proc_sys_call_handler(filp, (void __user *)buf, count, ppos, 1);
+	return proc_sys_call_handler(filp, buf, count, ppos, 1);
 }
 
 static int proc_sys_open(struct inode *inode, struct file *filp)
@@ -853,8 +854,8 @@ static int proc_sys_getattr(const struct path *path, struct kstat *stat,
 static const struct file_operations proc_sys_file_operations = {
 	.open		= proc_sys_open,
 	.poll		= proc_sys_poll,
-	.read		= proc_sys_read,
-	.write		= proc_sys_write,
+	.read_uptr	= proc_sys_read,
+	.write_uptr	= proc_sys_write,
 	.llseek		= default_llseek,
 };
 
-- 
2.26.2

