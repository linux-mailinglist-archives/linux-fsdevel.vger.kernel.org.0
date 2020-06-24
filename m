Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A33207BB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406131AbgFXSn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405581AbgFXSn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:43:57 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76403C061573;
        Wed, 24 Jun 2020 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zg92tDS6FDjCP4scuZwVVlfnJ/vZaSsy9tayc8dvtt4=; b=dVBeegFqlQeXHW8DJ+0JOtHGky
        3dJ+09TpI7Xxa8lEVDGwTtPWSP2N3p787HLsfspZO05G/oaAKqFrVj2qHVgBbd1YCaLvHZeMczq37
        /RnhiEdFL7+pEhj11pXdrRS1QahDnfJC1UKVn/CE/85s6snGc4/yl0aQneqs3Go44xGX/Pk0Jqi8L
        mo88KhKoKU3UUGih/jCNthzscWQfhgKb4Ej7dAYKShkR3/tsn6iJ0GTylvXul3fUa8JkW1NzxgHY1
        f0q3sQqdbYv7tOIIGZUYhf+/KOD4leWGQ30avUPjK55UJ+ZrUQXSaP54NnVIYvXpoTdBvOUceVsSm
        nerjS4ag==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joAMz-0004wj-AA; Wed, 24 Jun 2020 18:43:37 +0000
Date:   Wed, 24 Jun 2020 19:43:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624184337.GV21350@casper.infradead.org>
References: <20200624162901.1814136-1-hch@lst.de>
 <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175644.GR21350@casper.infradead.org>
 <20200624175905.GA25981@lst.de>
 <20200624183743.GA26747@lst.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200624183743.GA26747@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 08:37:43PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 07:59:05PM +0200, Christoph Hellwig wrote:
> > On Wed, Jun 24, 2020 at 06:56:44PM +0100, Matthew Wilcox wrote:
> > >  	/* don't even try if the size is too large */
> > > +	error = -ENOMEM;
> > >  	if (count > KMALLOC_MAX_SIZE)
> > > -		return -ENOMEM;
> > > +		goto out;
> > > +	kbuf = kzalloc(count, GFP_KERNEL);
> > > +	if (!kbuf)
> > > +		goto out;
> > >  
> > >  	if (write) {
> > > +		error = -EFAULT;
> > > +		if (!copy_from_iter_full(kbuf, count, iter))
> > >  			goto out;
> > >  	}
> > 
> > The nul-termination for the write cases seems to be lost here.
> 
> Version with the count and termination fixed below.  Can I get your
> signoff?  If testing passes that means I can go back to my
> kernel_read/write version from the set_fs removal tree with it.

Sure!

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I went with some slightly different fixes, but I'm having trouble
sending email (the new infradead.org is not quite set up right yet).
I've attached the two fixes to this email in case you want to
incorporate them in some way.

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-sysctl-Call-sysctl_head_finish-on-error.patch"

From 3c68e4efcc50192962a8cd18c67fb6fad2493713 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 24 Jun 2020 14:12:02 -0400
Subject: [PATCH 1/2] sysctl: Call sysctl_head_finish on error
To: hch@lst.de

This error path returned directly instead of calling sysctl_head_finish().

Fixes: ef9d965bc8b6 ("sysctl: reject gigantic reads/write to sysctl files")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/proc_sysctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 42c5128c7d1c..6c1166ccdaea 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -566,8 +566,9 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	/* don't even try if the size is too large */
-	if (count > KMALLOC_MAX_SIZE)
-		return -ENOMEM;
+	error = -ENOMEM;
+	if (count >= KMALLOC_MAX_SIZE)
+		goto out;
 
 	if (write) {
 		kbuf = memdup_user_nul(ubuf, count);
@@ -576,7 +577,6 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 			goto out;
 		}
 	} else {
-		error = -ENOMEM;
 		kbuf = kzalloc(count, GFP_KERNEL);
 		if (!kbuf)
 			goto out;
-- 
2.27.0


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-sysctl-Convert-to-iter-interfaces.patch"

From 93775b67bbc3e4f761808b216bc76127f89f9ad7 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 24 Jun 2020 14:31:08 -0400
Subject: [PATCH 2/2] sysctl: Convert to iter interfaces
To: hch@lst.de

Using the read_iter/write_iter interfaces allows for in-kernel users
to set sysctls without using set_fs().  Also, the buffer is a string,
so give it the real type of 'char *', not void *.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/proc_sysctl.c      | 44 ++++++++++++++++++--------------------
 include/linux/bpf-cgroup.h |  2 +-
 kernel/bpf/cgroup.c        |  2 +-
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c1166ccdaea..9f6b9c3e3fda 100644
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
+		error = -EFAULT;
+		if (!copy_from_iter_full(kbuf, count, iter))
 			goto out;
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
index c66c545e161a..f81d3b3752f9 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -132,7 +132,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
-				   void **buf, size_t *pcount, loff_t *ppos,
+				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum bpf_attach_type type);
 
 int __cgroup_bpf_run_filter_setsockopt(struct sock *sock, int *level,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4d76f16524cc..45a918fc573d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1202,7 +1202,7 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
  */
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
-				   void **buf, size_t *pcount, loff_t *ppos,
+				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum bpf_attach_type type)
 {
 	struct bpf_sysctl_kern ctx = {
-- 
2.27.0


--wRRV7LY7NUeQGEoC--
