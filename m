Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032E5207B04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405830AbgFXR5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 13:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405788AbgFXR5D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:57:03 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA85C061573;
        Wed, 24 Jun 2020 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w4AZJMmMYWZQtMeVPmtNQXC222Ff2o+8BSja2FEVD40=; b=XsNANRZrjq73+ERCPtHR4olP+w
        i0WH79owheG0zMJNXJGL3NwEuu47tt7PyfVnpK1X1CUEaWIM0l199CYlrw4aikBw9vRuz9dbW0Vmu
        lKcs3cbyAjurLa43W4pWL3NyDais9Z+neApqFEa7OERk/lZdDq+m8w3Sg7uvg+Sp6EVOINRtL+a0g
        KLsdzDHjyrobmPoMGWZ2mAYkyF1owjTQYjWyEYsQ7foRFGK4iywaZ02x679LsJiglPYPYhDljHH1v
        5KPAgM2qFC5IicJ/tYi+yQgai18scfs/C1vUUxzcz6HupiTH6+gRZBIDeLxztM8tWyrn8V5kD4NcM
        ek60QRDw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo9dc-0002uq-3g; Wed, 24 Jun 2020 17:56:44 +0000
Date:   Wed, 24 Jun 2020 18:56:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624175644.GR21350@casper.infradead.org>
References: <20200624162901.1814136-1-hch@lst.de>
 <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:19:16AM -0700, Linus Torvalds wrote:
> On Wed, Jun 24, 2020 at 9:29 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add two new file operations that are identical to ->read and ->write
> > except that they can also safely take kernel pointers using the uptr_t
> > type.
> 
> Honestly, I think this is the wrong way to go.
> 
> All of this new complexity and messiness, just to remove a few
> unimportant final cases?
> 
> If somebody can't be bothered to convert a driver to
> iter_read/iter_write, why would they be bothered to convert it to
> read_uptr/write_uptr?
> 
> And this messiness will stay around for decades.
> 
> So let's not go down that path.
> 
> If you want to do "splice() and kernel_read() requires read_iter"
> (with a warning so that we find any cases), then that's fine. But
> let's not add yet _another_ read type.
> 
> Why did you care so much about sysctl, and why couldn't they use the iter ops?

Heh, when I saw patch 4, I started working on that.  It doesn't seem all
that bad, except I've never used the iov_iter before, so I have no idea
if I did this right.  Also, this fixes a bug if 'count' is too large,
which I should split out and send separately.

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 42c5128c7d1c..7a8c474bc196 100644
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
@@ -540,12 +541,13 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
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
+	size_t count = iov_iter_count(iter);
 	void *kbuf;
 	ssize_t error;
 
@@ -566,35 +568,32 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	/* don't even try if the size is too large */
+	error = -ENOMEM;
 	if (count > KMALLOC_MAX_SIZE)
-		return -ENOMEM;
+		goto out;
+	kbuf = kzalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		goto out;
 
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
+		error = -EFAULT;
+		if (!copy_from_iter_full(kbuf, count, iter))
 			goto out;
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
 
@@ -607,16 +606,14 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
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
@@ -853,8 +850,8 @@ static int proc_sys_getattr(const struct path *path, struct kstat *stat,
 static const struct file_operations proc_sys_file_operations = {
 	.open		= proc_sys_open,
 	.poll		= proc_sys_poll,
-	.read		= proc_sys_read,
-	.write		= proc_sys_write,
+	.read_iter	= proc_sys_read,
+	.write_iter	= proc_sys_write,
 	.llseek		= default_llseek,
 };
 
