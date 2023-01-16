Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8389A66D092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 21:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjAPUzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 15:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjAPUzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:55:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5A29E00;
        Mon, 16 Jan 2023 12:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NC9LhxlmAcfoz2BLlV8ZmsTc89YKJONOkmmDX2k8BvU=; b=qsXBwAWMEdMcf9PIGQgdhJ1hvN
        x/N7SHzvR7Z2eZqR7Lb+h0Y3KPH/n4LdHH1Gh8/WEnERsmyR34w4u71u2wOLLaE0zb+edHeA0O3AK
        pbtMYmtO756D1k6lNZRj0N9fMF34TwVS0gHIUBbeFvVHSex/cNQsUkrZWwDRgUBo/ddeOB0Sz3Fpv
        0iQfQwikv9C3TVamhj516w65HyfQjyCm3oWOrOUYGdny4TsMrgC7s4fhICS4udy0yiOKzde06Ilrf
        IY9Yco9cKhl3ckA7gmVNgXtKGxcf/SGfOw0CjrU7TZSAGoF9MithHprGxZuqGw9VB+05DC6s0T7qS
        S7ORRLIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHWVa-0093p1-Vb; Mon, 16 Jan 2023 20:55:11 +0000
Date:   Mon, 16 Jan 2023 20:55:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+0f7dd5852be940800ca4@syzkaller.appspotmail.com>,
        almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] stack segment fault in truncate_inode_pages_final
Message-ID: <Y8W5rjKdZ9erIF14@casper.infradead.org>
References: <000000000000baa88c05eaa934bb@google.com>
 <CACT4Y+bVtOb+CxiAKHaSsrym-4JKn-E8exY7aypfp_yGzkUGDQ@mail.gmail.com>
 <CAG48ez0fZm4CHoG2-Zup8z9XGk-+hfdet=YpnY003iJpQOaBHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0fZm4CHoG2-Zup8z9XGk-+hfdet=YpnY003iJpQOaBHg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:46:37PM +0100, Jann Horn wrote:
> On Mon, Oct 10, 2022 at 9:42 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, 10 Oct 2022 at 09:35, syzbot
> > <syzbot+0f7dd5852be940800ca4@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    833477fce7a1 Merge tag 'sound-6.1-rc1' of git://git.kernel..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17cae158880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=676645938ad4c02f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0f7dd5852be940800ca4
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/f66757bbae28/disk-833477fc.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/50ec5a2788dd/vmlinux-833477fc.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0f7dd5852be940800ca4@syzkaller.appspotmail.com
> >
> > +ntfs3 maintainers
> 
> There's something deeply wrong with this one; it looks like we're

There's often something deeply wrong with NTFS-related reports.  I've seen
lockdep reports which are clearly corrupt lockdep state, for example.
I suspect inadvertent stack smashing, but have done nothing to prove
that assumption.  I just ignore reports tagged as ntfs now.

> trying to execute from an RIP that is not aligned to a full
> instruction. RIP points to the last byte of a CALL instruction. It
> looks like, somehow, while we were somewhere inside
> _raw_spin_unlock_irq, something stomped over RIP. Note how the "Code
> starting with the faulting instruction" section shows an instruction
> that's not visible in the "All code" dump above.
> 
> Code: 48 c7 c0 40 e8 ca 8d 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03
> 80 3c 10 00 0f 85 e0 01 00 00 48 8b 05 65 42 6d 0c e8 80 2e 06 <00> 85
> c0 74 17 65 ff 0d 55 c9 a4 7e 0f 85 3e fb ff ff e8 ec ce a2
> All code
> ========
>    0: 48 c7 c0 40 e8 ca 8d mov    $0xffffffff8dcae840,%rax
>    7: 48 ba 00 00 00 00 00 movabs $0xdffffc0000000000,%rdx
>    e: fc ff df
>   11: 48 c1 e8 03          shr    $0x3,%rax
>   15: 80 3c 10 00          cmpb   $0x0,(%rax,%rdx,1)
>   19: 0f 85 e0 01 00 00    jne    0x1ff
>   1f: 48 8b 05 65 42 6d 0c mov    0xc6d4265(%rip),%rax        # 0xc6d428b
>   26:* e8 80 2e 06 00        call   0x62eab <-- trapping instruction
>   2b: 85 c0                test   %eax,%eax
>   2d: 74 17                je     0x46
>   2f: 65 ff 0d 55 c9 a4 7e decl   %gs:0x7ea4c955(%rip)        # 0x7ea4c98b
>   36: 0f 85 3e fb ff ff    jne    0xfffffffffffffb7a
>   3c: e8                    .byte 0xe8
>   3d: ec                    in     (%dx),%al
>   3e: ce                    (bad)
>   3f: a2                    .byte 0xa2
> 
> Code starting with the faulting instruction
> ===========================================
>    0: 00 85 c0 74 17 65    add    %al,0x651774c0(%rbp)
>    6: ff 0d 55 c9 a4 7e    decl   0x7ea4c955(%rip)        # 0x7ea4c961
>    c: 0f 85 3e fb ff ff    jne    0xfffffffffffffb50
>   12: e8                    .byte 0xe8
>   13: ec                    in     (%dx),%al
>   14: ce                    (bad)
>   15: a2                    .byte 0xa2
> 
> We're interpreting unaligned instruction bytes as "add
> %al,0x651774c0(%rbp)", and RBP is non-canonical (1ffff92000a6cf44), so
> we get a Stack Segment fault.
> 
> Unless this is some kind of asynchronous stack UAF decrement, I think
> this might not be NTFS's fault.
> 
> > > stack segment: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 1 PID: 22407 Comm: syz-executor.5 Not tainted 6.0.0-syzkaller-05118-g833477fce7a1 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > > RIP: 0010:trace_lock_release include/trace/events/lock.h:69 [inline]
> > > RIP: 0010:lock_release+0x55f/0x780 kernel/locking/lockdep.c:5677
> > > Code: 48 c7 c0 40 e8 ca 8d 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 e0 01 00 00 48 8b 05 65 42 6d 0c e8 80 2e 06 <00> 85 c0 74 17 65 ff 0d 55 c9 a4 7e 0f 85 3e fb ff ff e8 ec ce a2
> > > RSP: 0018:ffffc90005367a10 EFLAGS: 00010002
> > > RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000001
> > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> > > RBP: 1ffff92000a6cf44 R08: 0000000000000000 R09: ffffffff8ddf9957
> > > R10: fffffbfff1bbf32a R11: 0000000000000000 R12: ffff888093973498
> > > R13: ffff888093973278 R14: ffffffff8a22b140 R15: ffff8880478d8a00
> > > FS:  00007f9ae3bb2700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000001b2e927000 CR3: 000000003f6b9000 CR4: 00000000003506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:157 [inline]
> > >  _raw_spin_unlock_irq+0x12/0x40 kernel/locking/spinlock.c:202
> > >  spin_unlock_irq include/linux/spinlock.h:399 [inline]
> > >  truncate_inode_pages_final+0x5f/0x80 mm/truncate.c:484
> > >  ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1741
> > >  evict+0x2ed/0x6b0 fs/inode.c:665
> > >  iput_final fs/inode.c:1748 [inline]
> > >  iput.part.0+0x55d/0x810 fs/inode.c:1774
> > >  iput+0x58/0x70 fs/inode.c:1764
> > >  ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
> > >  get_tree_bdev+0x440/0x760 fs/super.c:1323
> > >  vfs_get_tree+0x89/0x2f0 fs/super.c:1530
> > >  do_new_mount fs/namespace.c:3040 [inline]
> > >  path_mount+0x1326/0x1e20 fs/namespace.c:3370
> > >  do_mount fs/namespace.c:3383 [inline]
> > >  __do_sys_mount fs/namespace.c:3591 [inline]
> > >  __se_sys_mount fs/namespace.c:3568 [inline]
> > >  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7f9ae2a8bada
> > > Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f9ae3bb1f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> > > RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f9ae2a8bada
> > > RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f9ae3bb1fe0
> > > RBP: 00007f9ae3bb2020 R08: 00007f9ae3bb2020 R09: 0000000020000000
> > > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
> > > R13: 0000000020000100 R14: 00007f9ae3bb1fe0 R15: 0000000020000140
> > >  </TASK>
> > > Modules linked in:
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:trace_lock_release include/trace/events/lock.h:69 [inline]
> > > RIP: 0010:lock_release+0x55f/0x780 kernel/locking/lockdep.c:5677
> > > Code: 48 c7 c0 40 e8 ca 8d 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 e0 01 00 00 48 8b 05 65 42 6d 0c e8 80 2e 06 <00> 85 c0 74 17 65 ff 0d 55 c9 a4 7e 0f 85 3e fb ff ff e8 ec ce a2
> > > RSP: 0018:ffffc90005367a10 EFLAGS: 00010002
> > > RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000001
> > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> > > RBP: 1ffff92000a6cf44 R08: 0000000000000000 R09: ffffffff8ddf9957
> > > R10: fffffbfff1bbf32a R11: 0000000000000000 R12: ffff888093973498
> > > R13: ffff888093973278 R14: ffffffff8a22b140 R15: ffff8880478d8a00
> > > FS:  00007f9ae3bb2700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000001b2e927000 CR3: 000000003f6b9000 CR4: 00000000003506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000baa88c05eaa934bb%40google.com.
> >
