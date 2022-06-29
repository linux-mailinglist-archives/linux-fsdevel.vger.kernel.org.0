Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B445605D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiF2Qaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiF2Qav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:30:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A0344CC
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 09:30:49 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p128so16562928iof.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urSCakkuKR1dt/ZcgxiRZK1VHLhZ1Vgqb0nqcHcJeAo=;
        b=CylnOPyYtqAtDcxsdxMkimwon6DQm10OXv8wgLqgxgbvq+wMS1q7f3TxdB0N3DUhnc
         IdYczx1tYxzyeD39MFhPrg6/GsWlhYdsduh4S/ScolbgbezPYuUrpfN/+Ab4A6sB4dP6
         s6Sd1+UihVHIJDW6jSc1w1ANRJk8xbPm1QHknRuN6FxqHsHGQDshD6xWB17pNxbsoOLS
         VaWkVyjBwhw86DNC9KjGcrL1J10urNJAzjKFvWx3Bm8YkeoEUjx6+HBUFb6FSRKdbqLg
         p8+Mu+7CTD4Yyp126t4I0i6PVidhl7JNWGFFtak0/b0NTF5tz9tyUEQOM6eByCIt1Y2z
         v/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urSCakkuKR1dt/ZcgxiRZK1VHLhZ1Vgqb0nqcHcJeAo=;
        b=MhrPPgoCzETqYn97GeamFwp0CQvMqfTWmmhVcmkpkUn9qmSQlGUqz+BI3uekqsc6FI
         hza2Vg3n8STms1wKpY7qOsen5/IoYvmKd1CbeqojAln00j7ULCWhZU1WthMEor6cd69K
         883YkNYwuxw+FdPYTUq5e8Pd9ybAeyi/2GaKXYkz3ZPQN3Zv5lmMgi0/0BWJjfLRrmSl
         sBq7TtPBETVnWs6S+izST3OdofP+gU4Ro+yqY4R68FwVXq8RtB02WN68ugDT1C4n3ZI1
         BBniljA3AA4WBl7Bp1GR5mh4dVkJBowhyPyECLkDDhL/EvXv322nbgCpUVjM3dq1p0t8
         49Lg==
X-Gm-Message-State: AJIora87P6ER423ndcR1nTdb8uIP3j9u1foeZBhOtwdSOocozN+VJtVw
        JPtQ3GVx/BmHFqTTSDy8bZI8IDdXjcXa8enPcgWOgw==
X-Google-Smtp-Source: AGRyM1viihcd3UtQWMr7sk/0qehuojqPYfOkQU8D4Pz3Rzuar8kTHP2ia3rPvD1ZBUR3eag3RO1NwZIR2/gkWHJxOfQ=
X-Received: by 2002:a05:6638:25cd:b0:33c:b17e:d621 with SMTP id
 u13-20020a05663825cd00b0033cb17ed621mr2342529jat.61.1656520249163; Wed, 29
 Jun 2022 09:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f94c4805e289fc47@google.com> <YrvYEdTNWcvhIE7U@sol.localdomain>
In-Reply-To: <YrvYEdTNWcvhIE7U@sol.localdomain>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 29 Jun 2022 09:30:12 -0700
Message-ID: <CAJHvVcgoeKhqFTN5aGfQ53GbRDYJsfkRjeUM-yO5AROC0A8ekQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in truncate_inode_partial_folio
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:41 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 03:59:26PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    941e3e791269 Merge tag 'for_linus' of git://git.kernel.org..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1670ded4080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9bd2b7adbd34b30b87e4
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140f9ba8080000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15495188080000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
> >
> > BUG: unable to handle page fault for address: ffff888021f7e005
> > #PF: supervisor write access in kernel mode
> > #PF: error_code(0x0002) - not-present page
> > PGD 11401067 P4D 11401067 PUD 11402067 PMD 21f7d063 PTE 800fffffde081060
> > Oops: 0002 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 3761 Comm: syz-executor281 Not tainted 5.19.0-rc4-syzkaller-00014-g941e3e791269 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
> > Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> > RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
> > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
> > RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
> > RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
> > R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
> > R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
> > FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  zero_user_segments include/linux/highmem.h:272 [inline]
> >  folio_zero_range include/linux/highmem.h:428 [inline]
> >  truncate_inode_partial_folio+0x76a/0xdf0 mm/truncate.c:237
> >  truncate_inode_pages_range+0x83b/0x1530 mm/truncate.c:381
> >  truncate_inode_pages mm/truncate.c:452 [inline]
> >  truncate_pagecache+0x63/0x90 mm/truncate.c:753
> >  simple_setattr+0xed/0x110 fs/libfs.c:535
> >  secretmem_setattr+0xae/0xf0 mm/secretmem.c:170
> >  notify_change+0xb8c/0x12b0 fs/attr.c:424
> >  do_truncate+0x13c/0x200 fs/open.c:65
> >  do_sys_ftruncate+0x536/0x730 fs/open.c:193
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7fb29d900899
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fb29d8b2318 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> > RAX: ffffffffffffffda RBX: 00007fb29d988408 RCX: 00007fb29d900899
> > RDX: 00007fb29d900899 RSI: 0000000000000005 RDI: 0000000000000003
> > RBP: 00007fb29d988400 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb29d98840c
> > R13: 00007ffca01a23bf R14: 00007fb29d8b2400 R15: 0000000000022000
> >  </TASK>
> > Modules linked in:
> > CR2: ffff888021f7e005
> > ---[ end trace 0000000000000000 ]---
>
> I think this is a bug in memfd_secret.  secretmem_setattr() can race with a page
> being faulted in by secretmem_fault().  Specifically, a page can be faulted in
> after secretmem_setattr() has set i_size but before it zeroes out the partial
> page past i_size.  memfd_secret pages aren't mapped in the kernel direct map, so
> the crash occurs when the kernel tries to zero out the partial page.
>
> I don't know what the best solution is -- maybe a rw_semaphore protecting
> secretmem_fault() and secretmem_setattr()?  Or perhaps secretmem_setattr()
> should avoid the call to truncate_setsize() by not using simple_setattr(), given
> that secretmem_setattr() only supports the size going from zero to nonzero.

From my perspective the rw_semaphore approach sounds reasonable.

simple_setattr() and the functions it calls to do the actual work
isn't a tiny amount of code, it would be a shame to reimplement it in
secretmem.c.

For the rwsem, I guess the idea is setattr will take it for write, and
fault will take it for read? Since setattr is a very infrequent
operation - a typical use case is you'd do it exactly once right after
opening the memfd_secret - this seems like it wouldn't make fault
significantly less performant. It's also a pretty small change I
think, just a few lines.

>
> The following commit tried to fix a similar bug, but it wasn't enough:
>
>         commit f9b141f93659e09a52e28791ccbaf69c273b8e92
>         Author: Axel Rasmussen <axelrasmussen@google.com>
>         Date:   Thu Apr 14 19:13:31 2022 -0700
>
>             mm/secretmem: fix panic when growing a memfd_secret
>
>
> Here's a simplified reproducer.  Note, for memfd_secret to be supported, the
> kernel config must contain CONFIG_SECRETMEM=y and the kernel command line must
> contain secretmem.enable=1.
>
> #include <pthread.h>
> #include <setjmp.h>
> #include <signal.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <unistd.h>
>
> static volatile int fd;
> static jmp_buf jump_buf;
>
> static void *truncate_thread(void *arg)
> {
>         for (;;)
>                 ftruncate(fd, 1000);
> }
>
> static void handle_sigbus(int sig)
> {
>         longjmp(jump_buf, 1);
> }
>
> int main(void)
> {
>         struct sigaction act = {
>                 .sa_handler = handle_sigbus,
>                 .sa_flags = SA_NODEFER,
>         };
>         pthread_t t;
>         void *addr;
>
>         sigaction(SIGBUS, &act, NULL);
>
>         pthread_create(&t, NULL, truncate_thread, NULL);
>         for (;;) {
>                 fd = syscall(__NR_memfd_secret, 0);
>                 addr = mmap(NULL, 8192, PROT_WRITE, MAP_SHARED, fd, 0);
>                 if (setjmp(jump_buf) == 0)
>                         *(unsigned int *)addr = 0;
>                 munmap(addr, 8192);
>                 close(fd);
>         }
> }
