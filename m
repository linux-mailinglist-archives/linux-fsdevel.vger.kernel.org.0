Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4C207BA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406117AbgFXShq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:37:46 -0400
Received: from verein.lst.de ([213.95.11.211]:45586 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405914AbgFXShq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:37:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A3C168B02; Wed, 24 Jun 2020 20:37:43 +0200 (CEST)
Date:   Wed, 24 Jun 2020 20:37:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624183743.GA26747@lst.de>
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175644.GR21350@casper.infradead.org> <20200624175905.GA25981@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624175905.GA25981@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:59:05PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 06:56:44PM +0100, Matthew Wilcox wrote:
> >  	/* don't even try if the size is too large */
> > +	error = -ENOMEM;
> >  	if (count > KMALLOC_MAX_SIZE)
> > -		return -ENOMEM;
> > +		goto out;
> > +	kbuf = kzalloc(count, GFP_KERNEL);
> > +	if (!kbuf)
> > +		goto out;
> >  
> >  	if (write) {
> > +		error = -EFAULT;
> > +		if (!copy_from_iter_full(kbuf, count, iter))
> >  			goto out;
> >  	}
> 
> The nul-termination for the write cases seems to be lost here.

Version with the count and termination fixed below.  Can I get your
signoff?  If testing passes that means I can go back to my
kernel_read/write version from the set_fs removal tree with it.

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 42c5128c7d1c76..36ac7b0e4ba80d 100644
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
 
@@ -566,35 +568,33 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	/* don't even try if the size is too large */
-	if (count > KMALLOC_MAX_SIZE)
-		return -ENOMEM;
+	error = -ENOMEM;
+	if (count + !!write > KMALLOC_MAX_SIZE)
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
+		((char *)kbuf)[count] = '\0';
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
 
-- 
2.26.2

