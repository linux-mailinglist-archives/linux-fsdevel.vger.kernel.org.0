Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0221AB1E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441804AbgDOTgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 15:36:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48332 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438316AbgDOTgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:36:33 -0400
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jOnpV-0005cE-GL; Wed, 15 Apr 2020 19:36:13 +0000
Date:   Wed, 15 Apr 2020 21:36:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+d9ae59d4662c941e39c6@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        bernd.edlinger@hotmail.de, christian@brauner.io, guro@fb.com,
        kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [PATCH] proc: Handle umounts cleanly
Message-ID: <20200415193612.7cmmbwfpof6pvsqv@wittgenstein>
References: <0000000000001c5eaa05a357f2e1@google.com>
 <878siwioxj.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878siwioxj.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 01:28:24PM -0500, Eric W. Biederman wrote:
> syzbot writes:
> > KASAN: use-after-free Read in dput (2)
> >
> > proc_fill_super: allocate dentry failed
> > ==================================================================
> > BUG: KASAN: use-after-free in fast_dput fs/dcache.c:727 [inline]
> > BUG: KASAN: use-after-free in dput+0x53e/0xdf0 fs/dcache.c:846
> > Read of size 4 at addr ffff88808a618cf0 by task syz-executor.0/8426
> >
> > CPU: 0 PID: 8426 Comm: syz-executor.0 Not tainted 5.6.0-next-20200412-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >  print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
> >  __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
> >  kasan_report+0x33/0x50 mm/kasan/common.c:625
> >  fast_dput fs/dcache.c:727 [inline]
> >  dput+0x53e/0xdf0 fs/dcache.c:846
> >  proc_kill_sb+0x73/0xf0 fs/proc/root.c:195
> >  deactivate_locked_super+0x8c/0xf0 fs/super.c:335
> >  vfs_get_super+0x258/0x2d0 fs/super.c:1212
> >  vfs_get_tree+0x89/0x2f0 fs/super.c:1547
> >  do_new_mount fs/namespace.c:2813 [inline]
> >  do_mount+0x1306/0x1b30 fs/namespace.c:3138
> >  __do_sys_mount fs/namespace.c:3347 [inline]
> >  __se_sys_mount fs/namespace.c:3324 [inline]
> >  __x64_sys_mount+0x18f/0x230 fs/namespace.c:3324
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> > RIP: 0033:0x45c889
> > Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007ffc1930ec48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 0000000001324914 RCX: 000000000045c889
> > RDX: 0000000020000140 RSI: 0000000020000040 RDI: 0000000000000000
> > RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> > R13: 0000000000000749 R14: 00000000004ca15a R15: 0000000000000013
> 
> Looking at the code now that it the internal mount of proc is no
> longer used it is possible to unmount proc.   If proc is unmounted
> the fields of the pid namespace that were used for filesystem
> specific state are not reinitialized.
> 
> Which means that proc_self and proc_thread_self can be pointers to
> already freed dentries.
> 
> The reported user after free appears to be from mounting and
> unmounting proc followed by mounting proc again and using error
> injection to cause the new root dentry allocation to fail.  This in
> turn results in proc_kill_sb running with proc_self and
> proc_thread_self still retaining their values from the previous mount
> of proc.  Then calling dput on either proc_self of proc_thread_self
> will result in double put.  Which KASAN sees as a use after free.
> 
> Solve this by always reinitializing the filesystem state stored
> in the struct pid_namespace, when proc is unmounted.
> 
> Reported-by: syzbot+72868dd424eb66c6b95f@syzkaller.appspotmail.com
> Fixes: 69879c01a0c3 ("proc: Remove the now unnecessary internal mount of proc")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Was looking at that earlier right before eod briefly here as well.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!
Christian
