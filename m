Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 580EC125076
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 19:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfLRSU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 13:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfLRSU3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:20:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48DD821D7D;
        Wed, 18 Dec 2019 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576693228;
        bh=r+Yhc2kGvqoCkOh2cwX+RFHO1GplnASB7rzCH+PXBKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v+14dStLOWlHFtGyqAuh62m2tf9bE5cAU/G+xt9brE51Id+NKRDy/A0BHvO97yYhF
         XJFeyfuhv60cHnhwCQT3MQflw+TEdbhhxiyNYykUbxUByW3bYrqr2rfCXyFOhpau0v
         AVkUKTw3kxCtPm08A18oObB6r1AsQa+F/9AH1xhU=
Date:   Wed, 18 Dec 2019 19:20:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     syzbot <syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        hdanton@sina.com, akpm@linux-foundation.org
Subject: Re: WARNING: refcount bug in cdev_get
Message-ID: <20191218182026.GB882018@kroah.com>
References: <000000000000bf410005909463ff@google.com>
 <20191204115055.GA24783@willie-the-truck>
 <20191204123148.GA3626092@kroah.com>
 <20191210114444.GA17673@willie-the-truck>
 <20191218170854.GC18440@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218170854.GC18440@willie-the-truck>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 05:08:55PM +0000, Will Deacon wrote:
> Hi all,
> 
> On Tue, Dec 10, 2019 at 11:44:45AM +0000, Will Deacon wrote:
> > On Wed, Dec 04, 2019 at 01:31:48PM +0100, Greg KH wrote:
> > > But I thought we had a lock in play here, so why would changing this
> > > actually fix anything?
> > 
> > I don't think the lock is always used. For example, look at chrdev_open(),
> > which appears in the backtrace; the locked code is:
> > 
> > 	spin_lock(&cdev_lock);
> > 	p = inode->i_cdev;
> > 	if (!p) {
> > 		struct kobject *kobj;
> > 		int idx;
> > 		spin_unlock(&cdev_lock);
> > 		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
> > 		if (!kobj)
> > 			return -ENXIO;
> > 		new = container_of(kobj, struct cdev, kobj);
> > 		spin_lock(&cdev_lock);
> > 		/* Check i_cdev again in case somebody beat us to it while
> > 		   we dropped the lock. */
> > 		p = inode->i_cdev;
> > 		if (!p) {
> > 			inode->i_cdev = p = new;
> > 			list_add(&inode->i_devices, &p->list);
> > 			new = NULL;
> > 		} else if (!cdev_get(p))
> > 			ret = -ENXIO;
> > 	} else if (!cdev_get(p))
> > 		ret = -ENXIO;
> > 	spin_unlock(&cdev_lock);
> > 	cdev_put(new);
> > 
> > So the idea is that multiple threads serialise on the 'cdev_lock' and then
> > check 'inode->i_cdev' to figure out if the device has already been probed,
> > taking a reference to it if it's available or probing it via kobj_lookup()
> > otherwise. I think that's backwards with respect to things like cdev_put(),
> > where the refcount is dropped *before* 'inode->i_cdev' is cleared to NULL.
> > In which case, if a concurrent call to cdev_put() can drop the refcount
> > to zero without 'cdev_lock' held, then you could get a use-after-free on
> > this path thanks to a dangling pointer in 'inode->i_cdev'..
> > 
> > Looking slightly ahead in this same function, there are error paths which
> > appear to do exactly that:
> > 
> > 	fops = fops_get(p->ops);
> > 	if (!fops)
> > 		goto out_cdev_put;
> > 
> > 	replace_fops(filp, fops);
> > 	if (filp->f_op->open) {
> > 		ret = filp->f_op->open(inode, filp);
> > 		if (ret)
> > 			goto out_cdev_put;
> > 	}
> > 
> > 	return 0;
> > 
> >  out_cdev_put:
> > 	cdev_put(p);
> > 	return ret;
> > 
> > In which case the thread which installed 'inode->i_cdev' earlier on can
> > now drop its refcount to zero without the lock held if, for example, the
> > filp->f_op->open() call fails.
> > 
> > But note, this is purely based on code inspection -- the C reproducer from
> > syzkaller doesn't work for me, so I've not been able to test any fixes either.
> > It's also worth noting that cdev_put() is called from __fput(), but I think the
> > reference counting on the file means we're ok there.
> > 
> > > This code hasn't changed in 15+ years, what suddenly changed that causes
> > > problems here?
> > 
> > I suppose one thing to consider is that the refcount code is relatively new,
> > so it could be that the actual use-after-free is extremely rare, but we're
> > now seeing that it's at least potentially an issue.
> > 
> > Thoughts?
> 
> FWIW, I added some mdelay()s to make this race more likely, and I can now
> trigger it reasonably reliably. See below.
> 
> Will
> 
> --->8
> 
> [   89.512353] ------------[ cut here ]------------
> [   89.513350] refcount_t: addition on 0; use-after-free.
> [   89.513977] WARNING: CPU: 2 PID: 6385 at lib/refcount.c:25 refcount_warn_saturate+0x6d/0xf0
> [   89.514943] Modules linked in:
> [   89.515307] CPU: 2 PID: 6385 Comm: repro Not tainted 5.5.0-rc2+ #22
> [   89.516039] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   89.517047] RIP: 0010:refcount_warn_saturate+0x6d/0xf0
> [   89.517647] Code: 05 55 9a 15 01 01 e8 9d aa c8 ff 0f 0b c3 80 3d 45 9a 15 01 00 75 ce 48 c7 c7 00 9c 62 b3 c6 08
> [   89.519749] RSP: 0018:ffffb524c1b9bc70 EFLAGS: 00010282
> [   89.520353] RAX: 0000000000000000 RBX: ffff9e9da1f71390 RCX: 0000000000000000
> [   89.521184] RDX: ffff9e9dbbd27618 RSI: ffff9e9dbbd18798 RDI: ffff9e9dbbd18798
> [   89.522020] RBP: 0000000000000000 R08: 000000000000095f R09: 0000000000000039
> [   89.522854] R10: 0000000000000000 R11: ffffb524c1b9bb20 R12: ffff9e9da1e8c700
> [   89.523689] R13: ffffffffb25ee8b0 R14: 0000000000000000 R15: ffff9e9da1e8c700
> [   89.524512] FS:  00007f3b87d26700(0000) GS:ffff9e9dbbd00000(0000) knlGS:0000000000000000
> [   89.525439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   89.526105] CR2: 00007fc16909c000 CR3: 000000012df9c000 CR4: 00000000000006e0
> [   89.526937] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   89.527759] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   89.528587] Call Trace:
> [   89.528889]  kobject_get+0x5c/0x60
> [   89.529290]  cdev_get+0x2b/0x60
> [   89.529656]  chrdev_open+0x55/0x220
> [   89.530060]  ? cdev_put.part.3+0x20/0x20
> [   89.530515]  do_dentry_open+0x13a/0x390
> [   89.530961]  path_openat+0x2c8/0x1470
> [   89.531383]  do_filp_open+0x93/0x100
> [   89.531797]  ? selinux_file_ioctl+0x17f/0x220
> [   89.532297]  do_sys_open+0x186/0x220
> [   89.532708]  do_syscall_64+0x48/0x150
> [   89.533129]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   89.533704] RIP: 0033:0x7f3b87efcd0e
> [   89.534115] Code: 89 54 24 08 e8 a3 f4 ff ff 8b 74 24 0c 48 8b 3c 24 41 89 c0 44 8b 54 24 08 b8 01 01 00 00 89 f4
> [   89.536227] RSP: 002b:00007f3b87d259f0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> [   89.537085] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3b87efcd0e
> [   89.537891] RDX: 0000000000000000 RSI: 00007f3b87d25a80 RDI: 00000000ffffff9c
> [   89.538693] RBP: 00007f3b87d25e90 R08: 0000000000000000 R09: 0000000000000000
> [   89.539493] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffe188f504e
> [   89.540291] R13: 00007ffe188f504f R14: 00007f3b87d26700 R15: 0000000000000000
> [   89.541090] ---[ end trace 24f53ca58db8180a ]---

No hint as to _where_ you put the mdelay()?  :)


