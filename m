Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1E126167
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 12:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfLSL7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 06:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfLSL7Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:59:16 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124FC222C2;
        Thu, 19 Dec 2019 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576756754;
        bh=sNA/zIIMyWs0gUjqN3eQcOoJpsDRPdHySKA92c6MGHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DR7ofkYyDAUVfj3X63e71Ot1+Q7iX3+hjVknWIKnvbCwe0xdIUKnfaBPYXW9OoS2a
         y7mKJVNEKFZg07XJ4v9llRE1gfN0VYyJxoyGQ5h+baeZVUx8NNOb8qHM8RdePpBvNG
         0qiIvuqOyVT8zTMDHhFQ/3/NLJZHOOO2DaoeCCus=
Date:   Thu, 19 Dec 2019 11:59:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        hdanton@sina.com, akpm@linux-foundation.org
Subject: Re: WARNING: refcount bug in cdev_get
Message-ID: <20191219115909.GA32361@willie-the-truck>
References: <000000000000bf410005909463ff@google.com>
 <20191204115055.GA24783@willie-the-truck>
 <20191204123148.GA3626092@kroah.com>
 <20191210114444.GA17673@willie-the-truck>
 <20191218170854.GC18440@willie-the-truck>
 <20191218182026.GB882018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218182026.GB882018@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 07:20:26PM +0100, Greg KH wrote:
> On Wed, Dec 18, 2019 at 05:08:55PM +0000, Will Deacon wrote:
> > On Tue, Dec 10, 2019 at 11:44:45AM +0000, Will Deacon wrote:
> > > On Wed, Dec 04, 2019 at 01:31:48PM +0100, Greg KH wrote:
> > > > This code hasn't changed in 15+ years, what suddenly changed that causes
> > > > problems here?
> > > 
> > > I suppose one thing to consider is that the refcount code is relatively new,
> > > so it could be that the actual use-after-free is extremely rare, but we're
> > > now seeing that it's at least potentially an issue.
> > > 
> > > Thoughts?
> > 
> > FWIW, I added some mdelay()s to make this race more likely, and I can now
> > trigger it reasonably reliably. See below.
> > 
> > --->8
> > 
> > [   89.512353] ------------[ cut here ]------------
> > [   89.513350] refcount_t: addition on 0; use-after-free.
> > [   89.513977] WARNING: CPU: 2 PID: 6385 at lib/refcount.c:25 refcount_warn_saturate+0x6d/0xf0

[...]

> No hint as to _where_ you put the mdelay()?  :)

I threw it in the release function to maximise the period where the refcount
is 0 but the inode 'i_cdev' pointer is non-NULL. I also hacked chrdev_open()
so that the fops->open() call appears to fail most of the time (I guess
syzkaller uses error injection to do something similar). Nasty hack below.

I'll send a patch, given that I've managed to "reproduce" this.

Will

--->8

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 00dfe17871ac..e2e48fcd0435 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -375,7 +375,7 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 	const struct file_operations *fops;
 	struct cdev *p;
 	struct cdev *new = NULL;
-	int ret = 0;
+	int ret = 0, first = 0;
 
 	spin_lock(&cdev_lock);
 	p = inode->i_cdev;
@@ -395,6 +395,7 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 			inode->i_cdev = p = new;
 			list_add(&inode->i_devices, &p->list);
 			new = NULL;
+			first = 1;
 		} else if (!cdev_get(p))
 			ret = -ENXIO;
 	} else if (!cdev_get(p))
@@ -411,6 +412,10 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 
 	replace_fops(filp, fops);
 	if (filp->f_op->open) {
+		if (first && (get_cycles() & 0x3)) {
+			ret = -EINTR;
+			goto out_cdev_put;
+		}
 		ret = filp->f_op->open(inode, filp);
 		if (ret)
 			goto out_cdev_put;
@@ -594,12 +599,14 @@ void cdev_del(struct cdev *p)
 	kobject_put(&p->kobj);
 }
 
+#include <linux/delay.h>
 
 static void cdev_default_release(struct kobject *kobj)
 {
 	struct cdev *p = container_of(kobj, struct cdev, kobj);
 	struct kobject *parent = kobj->parent;
 
+	mdelay(50);
 	cdev_purge(p);
 	kobject_put(parent);
 }
