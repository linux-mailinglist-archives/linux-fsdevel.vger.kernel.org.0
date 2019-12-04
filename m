Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3BB112ABA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 12:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLDLvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 06:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfLDLvG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:51:06 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624C1207DD;
        Wed,  4 Dec 2019 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575460265;
        bh=KWJ6VaXyJRi7aLIoFas222RXaUVtq1fJ1fRD8kkdqHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emaZtOmSsHmqVv/uZNoYPTKW74YXbTH02wSByTkj/4Dn+VJXhdY2VVYNiyg4B8h07
         Vci9XB8t41t/UCM/ngCihAEsbe++6qUVXURZ25nY42Y3fEfcRniU5Hr2al4YTZshPw
         /7KyD5+fhTeM+7M8Ey771ORooWwZGSKQzVJXcp+M=
Date:   Wed, 4 Dec 2019 11:50:56 +0000
From:   Will Deacon <will@kernel.org>
To:     syzbot <syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        hdanton@sina.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org
Subject: Re: WARNING: refcount bug in cdev_get
Message-ID: <20191204115055.GA24783@willie-the-truck>
References: <000000000000bf410005909463ff@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000bf410005909463ff@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

[+Hillf, +akpm, +Greg]

On Tue, Aug 20, 2019 at 03:58:06PM -0700, syzbot wrote:
> syzbot found the following crash on:
> 
> HEAD commit:    2d63ba3e Merge tag 'pm-5.3-rc5' of git://git.kernel.org/pu..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=165d3302600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3ff364e429585cf2
> dashboard link: https://syzkaller.appspot.com/bug?extid=82defefbbd8527e1c2cb
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c8ab3c600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16be0c4c600000
> 
> Bisection is inconclusive: the bug happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11de3622600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15de3622600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> refcount_t: increment on 0; use-after-free.
> WARNING: CPU: 1 PID: 11828 at lib/refcount.c:156 refcount_inc_checked
> lib/refcount.c:156 [inline]
> WARNING: CPU: 1 PID: 11828 at lib/refcount.c:156
> refcount_inc_checked+0x61/0x70 lib/refcount.c:154
> Kernel panic - not syncing: panic_on_warn set ...

[...]

> RIP: 0010:refcount_inc_checked lib/refcount.c:156 [inline]
> RIP: 0010:refcount_inc_checked+0x61/0x70 lib/refcount.c:154
> Code: 1d 8e c6 64 06 31 ff 89 de e8 ab 9c 35 fe 84 db 75 dd e8 62 9b 35 fe
> 48 c7 c7 00 05 c6 87 c6 05 6e c6 64 06 01 e8 67 26 07 fe <0f> 0b eb c1 90 90
> 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41
> RSP: 0018:ffff8880907d78b8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff815c2466 RDI: ffffed10120faf09
> RBP: ffff8880907d78c8 R08: ffff8880a771a200 R09: fffffbfff134ae48
> R10: fffffbfff134ae47 R11: ffffffff89a5723f R12: ffff88809ea2bb80
> R13: 0000000000000000 R14: ffff88809ff6cd40 R15: ffff8880a1c56480
>  kref_get include/linux/kref.h:45 [inline]
>  kobject_get+0x66/0xc0 lib/kobject.c:644
>  cdev_get+0x60/0xb0 fs/char_dev.c:355
>  chrdev_open+0xb0/0x6b0 fs/char_dev.c:400
>  do_dentry_open+0x4df/0x1250 fs/open.c:797
>  vfs_open+0xa0/0xd0 fs/open.c:906
>  do_last fs/namei.c:3416 [inline]
>  path_openat+0x10e9/0x4630 fs/namei.c:3533
>  do_filp_open+0x1a1/0x280 fs/namei.c:3563
>  do_sys_open+0x3fe/0x5d0 fs/open.c:1089

FWIW, we've run into this same crash on arm64 so it would be nice to see it
fixed upstream. It looks like Hillf's reply (which included a patch) didn't
make it to the kernel mailing lists for some reason, but it is available
here:

https://groups.google.com/forum/#!original/syzkaller-bugs/PnQNxBrWv_8/X1ygj8d8DgAJ

A simpler fix would just be to use kobject_get_unless_zero() directly in
cdev_get(), but that looks odd in this specific case because chrdev_open()
holds the 'cdev_lock' and you'd hope that finding the kobject in the inode
with that held would mean that it's not being freed at the same time.

Cheers,

Will
