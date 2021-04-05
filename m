Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E38353B05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 05:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhDEDFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Apr 2021 23:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhDEDFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Apr 2021 23:05:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DBFC061756;
        Sun,  4 Apr 2021 20:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T4cf4ITid5Uw9btKpflcNe21wEChiEeglpEstacOk/Q=; b=gUuAnbQYjseOLeoHIILPujk6rJ
        QO/lsrfrY3OUtvpd5UK6mPpVRjKaRdiOlhy30zjz9jsU7QovUwQuRfGkEc2t7VRiiMkkxAjvIjL9D
        5yihykTM/M4LILUTMmNqbsw9VckhH1Kq82Pt41YV2WOmtvNSirSVUY163Ox+aF26Pvdb/rgsPo28X
        gAj6FnqPtL1U+L96xcHqa+hByfETERlTRJLa+gsRQPU63v0I+8naz+Vjxknieul40acPH0IgW3YqS
        Hxd/K3BzEHRCc8ygq9y25vJdOhWE1k3ZQr8s8+YuiI91w9OulBFdt9U4RWiutF4WwcmE8tWzQkDrI
        wqhWPv4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTFXi-00ArC6-E0; Mon, 05 Apr 2021 03:04:50 +0000
Date:   Mon, 5 Apr 2021 04:04:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+bdef67a6b28a89e6fe71@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] WARNING: suspicious RCU usage in dput
Message-ID: <20210405030446.GF2531743@casper.infradead.org>
References: <0000000000007a4aad05bf088d43@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007a4aad05bf088d43@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: WARNING: suspicious RCU usage in getname_flags

On Fri, Apr 02, 2021 at 07:52:17PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1e43c377 Merge tag 'xtensa-20210329' of git://github.com/j..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d76301d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
> dashboard link: https://syzkaller.appspot.com/bug?extid=bdef67a6b28a89e6fe71
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bdef67a6b28a89e6fe71@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 5.12.0-rc5-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 0
> no locks held by systemd-udevd/4825.
> 
> stack backtrace:
> CPU: 1 PID: 4825 Comm: systemd-udevd Not tainted 5.12.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
>  dput+0x4d/0xbc0 fs/dcache.c:870
>  step_into+0x2cf/0x1c80 fs/namei.c:1778
>  walk_component+0x171/0x6a0 fs/namei.c:1945
>  link_path_walk.part.0+0x712/0xc90 fs/namei.c:2266
>  link_path_walk fs/namei.c:2190 [inline]
>  path_lookupat+0xb7/0x830 fs/namei.c:2419
>  filename_lookup+0x19f/0x560 fs/namei.c:2453
>  do_readlinkat+0xcd/0x2f0 fs/stat.c:417
>  __do_sys_readlinkat fs/stat.c:444 [inline]
>  __se_sys_readlinkat fs/stat.c:441 [inline]
>  __x64_sys_readlinkat+0x93/0xf0 fs/stat.c:441
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fb5a7e200ba
> Code: 48 8b 0d e1 bd 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 0b 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ae bd 2b 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffc9c440e38 EFLAGS: 00000202 ORIG_RAX: 000000000000010b
> RAX: ffffffffffffffda RBX: 00005604089e4380 RCX: 00007fb5a7e200ba
> RDX: 00005604089e4380 RSI: 00007ffc9c440ec0 RDI: 00000000ffffff9c
> RBP: 0000000000000064 R08: 00007fb5a80dcbc8 R09: 0000000000000070
> R10: 0000000000000063 R11: 0000000000000202 R12: 00007ffc9c440ec0
> R13: 00000000ffffff9c R14: 00007ffc9c440e90 R15: 0000000000000063
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
