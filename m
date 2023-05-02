Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28D96F43EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjEBMcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjEBMcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 08:32:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C94EDB
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 05:32:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4efea87c578so2259e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683030767; x=1685622767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b11YksFEu6PgjT+MJOW8bSJDjgzeS7/ur2nvzYYOxU4=;
        b=2ibLB0dKSgfI+tsQ10RqeRBoPLEfmYVZHdYboemLTAqY2NxWjkOY9efjyu7eprry8x
         wGaqyTcDuBELcazJAtsdsHLZlFpAMl6TMgGPCQN1g8B5ws4q5BkepUuKvfSkmS4M3SpH
         4EMzwpoIUAlvs/gVjv4LyN3mkY067p1bX6zWOhRB+zib9OsRHNx21lFLpILegltNRrp9
         2scxyeSc8xFWnPsBfhlyZP4XP3oo4tPfTq78eoqTLUrwvYh7HYUhzzn9l2Q1sS7Y4T0P
         BfcNPt8dRqdPEIht78vUSIJRWQeUkSHfr1rz5nn5a6datnNtV8fktjwRNeLhdS5z6AXs
         yRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683030767; x=1685622767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b11YksFEu6PgjT+MJOW8bSJDjgzeS7/ur2nvzYYOxU4=;
        b=W6X3UJdUiPoZRwaSeKkSPMNhJ95HXshyPnCpkRUjqQWHN3UxaVCN3RbCU8t4g6/icW
         a8Cs8zVgaAd03qY0e9t+R8a8+6H4tX5jbK4HTD/B2aHjvNQtSYt9bYFOuPI0O9xhL3aM
         136oMXZQIJ03brgq3EJkOSrY7+jDLyl5K3a57xcsp/IrBqSlLVp0PraZpMqeb3QY3gk1
         IM6jtkw/bDCT48inst9ooPGcs6HXTbCJ5p8+zei0htHWmvCp5m6zIx60QFpWt63FcC1J
         bC6pHd2e/D5aOI9HjkoTjbB/qw2+/ObtpTSCWRBdmzGUj0NMY/ulxOSDk54o7rwGuDq6
         ipmQ==
X-Gm-Message-State: AC+VfDzrWu2woWEjyrN1/a263350lI6sJapXIIatfHXsQWV4hXfXM0jA
        O7xvb8nZyqwjNUuJPkVoGlMLo8IIgTFKdJ9RFm5wUA==
X-Google-Smtp-Source: ACHHUZ591xXYVU3XxtWqFZU44CMN4U4rLIcjTZ2qy+f7mo1oVyfdcvRbKsvqu5s/60aSJyOQ9942jTDDARN17pkuy6w=
X-Received: by 2002:a05:6512:118d:b0:4e8:5117:71ae with SMTP id
 g13-20020a056512118d00b004e8511771aemr110789lfr.3.1683030766952; Tue, 02 May
 2023 05:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000084706805fab08e27@google.com> <CACT4Y+aGfOE7R+LoocX7aW2XObY4aCAsAydwvL+Ni_NUt6JfJA@mail.gmail.com>
 <83578cb3-2528-cfab-21bc-cfeccd8124dd@ghiti.fr>
In-Reply-To: <83578cb3-2528-cfab-21bc-cfeccd8124dd@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 May 2023 14:32:33 +0200
Message-ID: <CACT4Y+ZGsMCqsaV9DQDsTFWH7cCMY9GCtdZTGdVBPqOERPRQzw@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KASAN: stack-out-of-bounds Read in proc_pid_stack
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     syzbot <syzbot+01e9a564dc6b3289cea3@syzkaller.appspotmail.com>,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        alexghiti@rivosinc.com, Palmer Dabbelt <palmer@dabbelt.com>
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

On Tue, 2 May 2023 at 14:02, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> On 5/2/23 09:15, Dmitry Vyukov wrote:
> > On Tue, 2 May 2023 at 09:05, syzbot
> > <syzbot+01e9a564dc6b3289cea3@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    950b879b7f02 riscv: Fixup race condition on PG_dcache_clea..
> >> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=10c4c1f7c80000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=ecebece1b90c0342
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=01e9a564dc6b3289cea3
> >> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >> userspace arch: riscv64
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+01e9a564dc6b3289cea3@syzkaller.appspotmail.com
> >>
> >> ==================================================================
> >> BUG: KASAN: stack-out-of-bounds in walk_stackframe+0x128/0x2fe arch/riscv/kernel/stacktrace.c:58
> >> Read of size 8 at addr ff200000030a79b0 by task syz-executor.1/7894
> >>
> >> CPU: 0 PID: 7894 Comm: syz-executor.1 Tainted: G        W          6.2.0-rc1-syzkaller #0
> >> Hardware name: riscv-virtio,qemu (DT)
> >> Call Trace:
> >> [<ffffffff8000b9ea>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:121
> >> [<ffffffff83402b96>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:127
> >> [<ffffffff83442726>] __dump_stack lib/dump_stack.c:88 [inline]
> >> [<ffffffff83442726>] dump_stack_lvl+0xe0/0x14c lib/dump_stack.c:106
> >> [<ffffffff83409674>] print_address_description mm/kasan/report.c:306 [inline]
> >> [<ffffffff83409674>] print_report+0x1e4/0x4c0 mm/kasan/report.c:417
> >> [<ffffffff804ead14>] kasan_report+0xb8/0xe6 mm/kasan/report.c:517
> >> [<ffffffff804ebea4>] check_region_inline mm/kasan/generic.c:183 [inline]
> >> [<ffffffff804ebea4>] __asan_load8+0x7e/0xa6 mm/kasan/generic.c:256
> >> [<ffffffff8000b782>] walk_stackframe+0x128/0x2fe arch/riscv/kernel/stacktrace.c:58
> > +riscv maintainers
> >
> > I think this is an issue in riscv stack walking.
> > If it's imprecise or walks stacks of running tasks, it needs to use
> > READ_ONCE_NOCHECK.
> >
> > #syz set subsystems: riscv
>
>
> This fix was merged in 6.3: commit 76950340cf03 ("riscv: Use
> READ_ONCE_NOCHECK in imprecise unwinding stack mode").

Oh, I see, syzbot riscv build is still broken due to:
https://syzkaller.appspot.com/bug?id=502e4cca2c3c985c2125ffa945b8e636b7b100d7
https://lore.kernel.org/all/00000000000049382505ebef4a0c@google.com/T/#md2075a04dd463fefe31f73e098672a69d948a1ce

so it still tests an older build.

#syz fix:
riscv: Use READ_ONCE_NOCHECK in imprecise unwinding stack mode

> >> [<ffffffff8000bc66>] arch_stack_walk+0x2c/0x3c arch/riscv/kernel/stacktrace.c:154
> >> [<ffffffff80190822>] stack_trace_save_tsk+0x14a/0x1bc kernel/stacktrace.c:150
> >> [<ffffffff80697822>] proc_pid_stack+0x146/0x1ee fs/proc/base.c:456
> >> [<ffffffff80698bb0>] proc_single_show+0x9c/0x148 fs/proc/base.c:777
> >> [<ffffffff805af580>] traverse.part.0+0x74/0x2ca fs/seq_file.c:111
> >> [<ffffffff805aff02>] traverse fs/seq_file.c:101 [inline]
> >> [<ffffffff805aff02>] seq_read_iter+0x72c/0x934 fs/seq_file.c:195
> >> [<ffffffff805b0224>] seq_read+0x11a/0x16e fs/seq_file.c:162
> >> [<ffffffff805453ea>] do_loop_readv_writev fs/read_write.c:756 [inline]
> >> [<ffffffff805453ea>] do_loop_readv_writev fs/read_write.c:743 [inline]
> >> [<ffffffff805453ea>] do_iter_read+0x324/0x3c2 fs/read_write.c:798
> >> [<ffffffff805455f8>] vfs_readv+0xfe/0x166 fs/read_write.c:916
> >> [<ffffffff80549c66>] do_preadv fs/read_write.c:1008 [inline]
> >> [<ffffffff80549c66>] __do_sys_preadv fs/read_write.c:1058 [inline]
> >> [<ffffffff80549c66>] sys_preadv+0x182/0x1fa fs/read_write.c:1053
> >> [<ffffffff80005ff6>] ret_from_syscall+0x0/0x2
> >>
> >> The buggy address belongs to the virtual mapping at
> >>   [ff200000030a0000, ff200000030a9000) created by:
> >>   kernel_clone+0xee/0x914 kernel/fork.c:2681
> >>
> >> The buggy address belongs to the physical page:
> >> page:ff1c0000024e5f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9397c
> >> memcg:ff6000000ffd7202
> >> flags: 0xffe000000000000(node=0|zone=0|lastcpupid=0x7ff)
> >> raw: 0ffe000000000000 0000000000000000 0000000000000122 0000000000000000
> >> raw: 0000000000000000 0000000000000000 00000001ffffffff ff6000000ffd7202
> >> page dumped because: kasan: bad access detected
> >> page_owner tracks the page as allocated
> >> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 7873, tgid 7873 (syz-executor.1), ts 4012100669800, free_ts 4010400733200
> >>   __set_page_owner+0x32/0x182 mm/page_owner.c:190
> >>   set_page_owner include/linux/page_owner.h:31 [inline]
> >>   post_alloc_hook+0xf8/0x11a mm/page_alloc.c:2524
> >>   prep_new_page mm/page_alloc.c:2531 [inline]
> >>   get_page_from_freelist+0xc0e/0x1118 mm/page_alloc.c:4283
> >>   __alloc_pages+0x1b0/0x165a mm/page_alloc.c:5549
> >>   alloc_pages+0x132/0x25e mm/mempolicy.c:2286
> >>   vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
> >>   __vmalloc_area_node mm/vmalloc.c:3057 [inline]
> >>   __vmalloc_node_range+0x81c/0xdb4 mm/vmalloc.c:3227
> >>   alloc_thread_stack_node kernel/fork.c:311 [inline]
> >>   dup_task_struct kernel/fork.c:987 [inline]
> >>   copy_process+0x210e/0x4068 kernel/fork.c:2097
> >>   kernel_clone+0xee/0x914 kernel/fork.c:2681
> >>   __do_sys_clone+0xec/0x120 kernel/fork.c:2822
> >>   sys_clone+0x32/0x44 kernel/fork.c:2790
> >>   ret_from_syscall+0x0/0x2
> >> page last free stack trace:
> >>   __reset_page_owner+0x4a/0xf8 mm/page_owner.c:148
> >>   reset_page_owner include/linux/page_owner.h:24 [inline]
> >>   free_pages_prepare mm/page_alloc.c:1446 [inline]
> >>   free_pcp_prepare+0x254/0x48e mm/page_alloc.c:1496
> >>   free_unref_page_prepare mm/page_alloc.c:3369 [inline]
> >>   free_unref_page_list+0x11e/0x736 mm/page_alloc.c:3510
> >>   release_pages+0x85a/0xbb2 mm/swap.c:1076
> >>   free_pages_and_swap_cache+0x76/0x88 mm/swap_state.c:311
> >>   tlb_batch_pages_flush+0x86/0x10c mm/mmu_gather.c:97
> >>   tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
> >>   tlb_flush_mmu mm/mmu_gather.c:299 [inline]
> >>   tlb_finish_mmu+0xcc/0x280 mm/mmu_gather.c:391
> >>   exit_mmap+0x190/0x686 mm/mmap.c:3096
> >>   __mmput+0x98/0x290 kernel/fork.c:1207
> >>   mmput+0x74/0x88 kernel/fork.c:1229
> >>   exit_mm kernel/exit.c:563 [inline]
> >>   do_exit+0x602/0x17be kernel/exit.c:854
> >>   do_group_exit+0x8e/0x15e kernel/exit.c:1012
> >>   __do_sys_exit_group kernel/exit.c:1023 [inline]
> >>   __wake_up_parent+0x0/0x4a kernel/exit.c:1021
> >>   ret_from_syscall+0x0/0x2
> >>
> >> Memory state around the buggy address:
> >>   ff200000030a7880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>   ff200000030a7900: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 f2 f2
> >>> ff200000030a7980: 00 00 00 f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00
> >>                                       ^
> >>   ff200000030a7a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>   ff200000030a7a80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
> >> ==================================================================
> >>
> >>
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>
> >> If the bug is already fixed, let syzbot know by replying with:
> >> #syz fix: exact-commit-title
> >>
> >> If you want to change bug's subsystems, reply with:
> >> #syz set subsystems: new-subsystem
> >> (See the list of subsystem names on the web dashboard)
> >>
> >> If the bug is a duplicate of another bug, reply with:
> >> #syz dup: exact-subject-of-another-report
> >>
> >> If you want to undo deduplication, reply with:
> >> #syz undup
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000084706805fab08e27%40google.com.
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
