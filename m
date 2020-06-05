Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33B61EF05A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 06:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgFEEYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 00:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgFEEYE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 00:24:04 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C98CA206E6;
        Fri,  5 Jun 2020 04:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591331044;
        bh=Ger2JKf4foukIoxJhsp2lpcdnsKngWBWA02v1OQp51Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0wRsVBPYDfhuBPXJhNEprgX7yrwQg0lkOBlGoz4O9jEC+lVNlLQWhfMSciuYkRSKF
         tR2wZxyLj9N1kziXCwugwlLQRH47af8NFACLXOevvhB6Wi/eonfPM8oDsgehwYXdGg
         XThOmBu1ey/i1g9+k9IDIgZUxKvQoijjfHVxPMfY=
Date:   Thu, 4 Jun 2020 21:24:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     kvm@vger.kernel.org
Cc:     syzbot <syzbot+f196caa45793d6374707@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: memory leak in do_eventfd
Message-ID: <20200605042402.GO2667@sol.localdomain>
References: <0000000000001daa8d05a61e3440@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001daa8d05a61e3440@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Cc kvm mailing list]

On Wed, May 20, 2020 at 06:12:17PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    5a9ffb95 Merge tag '5.7-rc5-smb3-fixes' of git://git.samba..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b72a02100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8295ae5b3f8268d
> dashboard link: https://syzkaller.appspot.com/bug?extid=f196caa45793d6374707
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17585b76100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12500a02100000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f196caa45793d6374707@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888117169ac0 (size 64):
>   comm "syz-executor012", pid 6609, jiffies 4294942172 (age 13.720s)
>   hex dump (first 32 bytes):
>     01 00 00 00 ff ff ff ff 00 00 00 00 00 c9 ff ff  ................
>     d0 9a 16 17 81 88 ff ff d0 9a 16 17 81 88 ff ff  ................
>   backtrace:
>     [<00000000351bb234>] kmalloc include/linux/slab.h:555 [inline]
>     [<00000000351bb234>] do_eventfd+0x35/0xf0 fs/eventfd.c:418
>     [<00000000c2f69a77>] __do_sys_eventfd fs/eventfd.c:443 [inline]
>     [<00000000c2f69a77>] __se_sys_eventfd fs/eventfd.c:441 [inline]
>     [<00000000c2f69a77>] __x64_sys_eventfd+0x14/0x20 fs/eventfd.c:441
>     [<0000000086d6f989>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
>     [<000000006c5bcb63>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> BUG: memory leak
> unreferenced object 0xffff888117169100 (size 64):
>   comm "syz-executor012", pid 6609, jiffies 4294942172 (age 13.720s)
>   hex dump (first 32 bytes):
>     e8 99 dd 00 00 c9 ff ff e8 99 dd 00 00 c9 ff ff  ................
>     00 00 00 20 00 00 00 00 00 00 00 00 00 00 00 00  ... ............
>   backtrace:
>     [<00000000436d2955>] kmalloc include/linux/slab.h:555 [inline]
>     [<00000000436d2955>] kzalloc include/linux/slab.h:669 [inline]
>     [<00000000436d2955>] kvm_assign_ioeventfd_idx+0x4f/0x270 arch/x86/kvm/../../../virt/kvm/eventfd.c:798
>     [<00000000e89390cc>] kvm_assign_ioeventfd arch/x86/kvm/../../../virt/kvm/eventfd.c:934 [inline]
>     [<00000000e89390cc>] kvm_ioeventfd+0xbb/0x194 arch/x86/kvm/../../../virt/kvm/eventfd.c:961
>     [<00000000ba9f6732>] kvm_vm_ioctl+0x1e6/0x1030 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3670
>     [<000000005da94937>] vfs_ioctl fs/ioctl.c:47 [inline]
>     [<000000005da94937>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:771
>     [<00000000a583d097>] __do_sys_ioctl fs/ioctl.c:780 [inline]
>     [<00000000a583d097>] __se_sys_ioctl fs/ioctl.c:778 [inline]
>     [<00000000a583d097>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:778
>     [<0000000086d6f989>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
>     [<000000006c5bcb63>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000001daa8d05a61e3440%40google.com.
