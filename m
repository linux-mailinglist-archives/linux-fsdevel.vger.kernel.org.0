Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62AC1186D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 12:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfLJLow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 06:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbfLJLov (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:44:51 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C2D2077B;
        Tue, 10 Dec 2019 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575978290;
        bh=YOujrXl73e6+aFeoX4p52tGgaTv9XddjcJSq7ucWiqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18m2L8qbAzR6HbzKts9WV9nLbZ/kjxTHEWwzlwF63Oi2zdRySHUhYvaE6PZueWzYY
         ZQdHcF6yTsvYvekH+jjWjiX1vlga4ENXLC6ROvyog4mTBTBYIqiaab69Vrvr4y8Uyn
         NjO7hW5hNdNItKaTzO+agIY9rpwAnmFO+nXDgcHU=
Date:   Tue, 10 Dec 2019 11:44:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        hdanton@sina.com, akpm@linux-foundation.org
Subject: Re: WARNING: refcount bug in cdev_get
Message-ID: <20191210114444.GA17673@willie-the-truck>
References: <000000000000bf410005909463ff@google.com>
 <20191204115055.GA24783@willie-the-truck>
 <20191204123148.GA3626092@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204123148.GA3626092@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On Wed, Dec 04, 2019 at 01:31:48PM +0100, Greg KH wrote:
> On Wed, Dec 04, 2019 at 11:50:56AM +0000, Will Deacon wrote:
> > On Tue, Aug 20, 2019 at 03:58:06PM -0700, syzbot wrote:
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    2d63ba3e Merge tag 'pm-5.3-rc5' of git://git.kernel.org/pu..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=165d3302600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3ff364e429585cf2
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=82defefbbd8527e1c2cb
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c8ab3c600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16be0c4c600000
> > > 
> > > Bisection is inconclusive: the bug happens on the oldest tested release.
> > > 
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11de3622600000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15de3622600000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com
> > > 
> > > ------------[ cut here ]------------
> > > refcount_t: increment on 0; use-after-free.
> > > WARNING: CPU: 1 PID: 11828 at lib/refcount.c:156 refcount_inc_checked
> > > lib/refcount.c:156 [inline]
> > > WARNING: CPU: 1 PID: 11828 at lib/refcount.c:156
> > > refcount_inc_checked+0x61/0x70 lib/refcount.c:154
> > > Kernel panic - not syncing: panic_on_warn set ...
> > 
> > [...]
> > 
> > > RIP: 0010:refcount_inc_checked lib/refcount.c:156 [inline]
> > > RIP: 0010:refcount_inc_checked+0x61/0x70 lib/refcount.c:154
> > > Code: 1d 8e c6 64 06 31 ff 89 de e8 ab 9c 35 fe 84 db 75 dd e8 62 9b 35 fe
> > > 48 c7 c7 00 05 c6 87 c6 05 6e c6 64 06 01 e8 67 26 07 fe <0f> 0b eb c1 90 90
> > > 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41
> > > RSP: 0018:ffff8880907d78b8 EFLAGS: 00010282
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > RDX: 0000000000000000 RSI: ffffffff815c2466 RDI: ffffed10120faf09
> > > RBP: ffff8880907d78c8 R08: ffff8880a771a200 R09: fffffbfff134ae48
> > > R10: fffffbfff134ae47 R11: ffffffff89a5723f R12: ffff88809ea2bb80
> > > R13: 0000000000000000 R14: ffff88809ff6cd40 R15: ffff8880a1c56480
> > >  kref_get include/linux/kref.h:45 [inline]
> > >  kobject_get+0x66/0xc0 lib/kobject.c:644
> > >  cdev_get+0x60/0xb0 fs/char_dev.c:355
> > >  chrdev_open+0xb0/0x6b0 fs/char_dev.c:400
> > >  do_dentry_open+0x4df/0x1250 fs/open.c:797
> > >  vfs_open+0xa0/0xd0 fs/open.c:906
> > >  do_last fs/namei.c:3416 [inline]
> > >  path_openat+0x10e9/0x4630 fs/namei.c:3533
> > >  do_filp_open+0x1a1/0x280 fs/namei.c:3563
> > >  do_sys_open+0x3fe/0x5d0 fs/open.c:1089
> > 
> > FWIW, we've run into this same crash on arm64 so it would be nice to see it
> > fixed upstream. It looks like Hillf's reply (which included a patch) didn't
> > make it to the kernel mailing lists for some reason, but it is available
> > here:
> > 
> > https://groups.google.com/forum/#!original/syzkaller-bugs/PnQNxBrWv_8/X1ygj8d8DgAJ
> 
> No one is going to go and dig a patch out of google groups :(

Sure, just thought it was worth mentioning after digging up the history.

> > A simpler fix would just be to use kobject_get_unless_zero() directly in
> > cdev_get(), but that looks odd in this specific case because chrdev_open()
> > holds the 'cdev_lock' and you'd hope that finding the kobject in the inode
> > with that held would mean that it's not being freed at the same time.
> 
> When using kref_get_unless_zero() that implies that a lock is not being
> used and you are relying on the kobject only instead.
> 
> But I thought we had a lock in play here, so why would changing this
> actually fix anything?

I don't think the lock is always used. For example, look at chrdev_open(),
which appears in the backtrace; the locked code is:

	spin_lock(&cdev_lock);
	p = inode->i_cdev;
	if (!p) {
		struct kobject *kobj;
		int idx;
		spin_unlock(&cdev_lock);
		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
		if (!kobj)
			return -ENXIO;
		new = container_of(kobj, struct cdev, kobj);
		spin_lock(&cdev_lock);
		/* Check i_cdev again in case somebody beat us to it while
		   we dropped the lock. */
		p = inode->i_cdev;
		if (!p) {
			inode->i_cdev = p = new;
			list_add(&inode->i_devices, &p->list);
			new = NULL;
		} else if (!cdev_get(p))
			ret = -ENXIO;
	} else if (!cdev_get(p))
		ret = -ENXIO;
	spin_unlock(&cdev_lock);
	cdev_put(new);

So the idea is that multiple threads serialise on the 'cdev_lock' and then
check 'inode->i_cdev' to figure out if the device has already been probed,
taking a reference to it if it's available or probing it via kobj_lookup()
otherwise. I think that's backwards with respect to things like cdev_put(),
where the refcount is dropped *before* 'inode->i_cdev' is cleared to NULL.
In which case, if a concurrent call to cdev_put() can drop the refcount
to zero without 'cdev_lock' held, then you could get a use-after-free on
this path thanks to a dangling pointer in 'inode->i_cdev'..

Looking slightly ahead in this same function, there are error paths which
appear to do exactly that:

	fops = fops_get(p->ops);
	if (!fops)
		goto out_cdev_put;

	replace_fops(filp, fops);
	if (filp->f_op->open) {
		ret = filp->f_op->open(inode, filp);
		if (ret)
			goto out_cdev_put;
	}

	return 0;

 out_cdev_put:
	cdev_put(p);
	return ret;

In which case the thread which installed 'inode->i_cdev' earlier on can
now drop its refcount to zero without the lock held if, for example, the
filp->f_op->open() call fails.

But note, this is purely based on code inspection -- the C reproducer from
syzkaller doesn't work for me, so I've not been able to test any fixes either.
It's also worth noting that cdev_put() is called from __fput(), but I think the
reference counting on the file means we're ok there.

> This code hasn't changed in 15+ years, what suddenly changed that causes
> problems here?

I suppose one thing to consider is that the refcount code is relatively new,
so it could be that the actual use-after-free is extremely rare, but we're
now seeing that it's at least potentially an issue.

Thoughts?

Will
