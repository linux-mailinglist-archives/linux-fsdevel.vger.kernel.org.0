Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DFD511D84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiD0PZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbiD0PZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:25:58 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8149D2EC358
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 08:22:44 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so409827oos.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LkjVPDOiEi4meWnVCOnPPZfr6BqIOIsxQZpQxugMKk=;
        b=RxoY0pozp1BnomRGYZiQKaxeYAUriSS+5F5woi/HEvE0ZiIoAdCmIlqGkjCZiEm0+O
         5U4U43iBktiFFD2nOOLLgnhBRgwO+cz/oqA5yB7Zof8BB2FzgbAXMnnvYCpNYW3KsSup
         nnRbR/kCgQXIrYOKdu93wgPN/90DGW2m0II+bsKzV/KRpCid61hAe1FN6f1XejXdBInz
         RPUg/MfDaHqVpyqlZX0Ut3FQmANm6qQdjfucg4ASE2h/HES0+b5nw6Nuw7mjBJa/+lyM
         G07k+8/SznROKg61Poat2+nkUHxgIUPn5mATZmks7JxCwyLUaruo8mhXZYcjVW/88JnY
         BkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LkjVPDOiEi4meWnVCOnPPZfr6BqIOIsxQZpQxugMKk=;
        b=S15ftBXoz5Cz4oNnZBcUTK+KafPj+SSbDCxTeVj28G0VqfVX/bmO24mbn0qe4WF/Rd
         dwZWYYpwbci2BnTSlmP1R9JzVmXYP3k62b3Pmw73ml+eOKQPc6T3qvhxDuh8bmNZ7cto
         3DenjrL5fQUkfD8WgfA+6zrTTtmh/fGAuxfWoUEzoAD9x8ekYyv0lhxEmy0q4sWR4aAW
         HH9nipvSXT/AIKGwaZ9cPtct3F7qHRbPimoDGfSHs2gbuqDBC2luQW9yX2SFJhDlYc91
         MzQgu7kofsAie+fWQxByp7clpSbqX5JgffTTKTMKJr3gsJbyEZwL1RF+a2Wox+eHBx7o
         kkVQ==
X-Gm-Message-State: AOAM5301C7rMs0FjCsUz5fJWYjiP2iNb7yW1WoGxk6/Wf1aPhtgvoAOY
        feX4T91rcj0/CowKa1rS/92jQIZpjP7vdzjnOd58ZQ==
X-Google-Smtp-Source: ABdhPJxLqowgoY8LWmzr3eO4ytry4shHpRdNQ2yJDrRp0sz5NW9frNeQnwtTMVEsqXffueErDY1eZLeYlTCaSABdrrM=
X-Received: by 2002:a4a:ad0a:0:b0:35e:79da:30c7 with SMTP id
 r10-20020a4aad0a000000b0035e79da30c7mr4521080oon.53.1651072963424; Wed, 27
 Apr 2022 08:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009ecbf205dda227bd@google.com> <20220427125558.5cx4iv3mgjqi36ld@wittgenstein>
 <YmlaCVrwvZBlOWGO@casper.infradead.org> <20220427151715.544aa2om5o7pp77n@revolver>
In-Reply-To: <20220427151715.544aa2om5o7pp77n@revolver>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Apr 2022 17:22:31 +0200
Message-ID: <CACT4Y+bCyji6yxtOgJg05pkiNnqUAptW4Qdc5EAZW9uCUfjwCw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in mas_next_nentry
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 27 Apr 2022 at 17:17, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Matthew Wilcox <willy@infradead.org> [220427 10:58]:
> > On Wed, Apr 27, 2022 at 02:55:58PM +0200, Christian Brauner wrote:
> > > [+Cc Willy]
> >
> > I read fsdevel.  Not sure Liam does though.
>
> I do not.  Thank you for sending it along.
>
> Here is a patch that should fix the issue.  I will ask AKPM to include
> it for tomorrow.

Please add the reported tag:

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com

> > > On Wed, Apr 27, 2022 at 05:43:22AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    f02ac5c95dfd Add linux-next specific files for 20220427
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14bd8db2f00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e9256c70f586da8a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7170d66493145b71afd4
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113b4252f00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1174bcbaf00000
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in mas_safe_min lib/maple_tree.c:715 [inline]
> > > > BUG: KASAN: use-after-free in mas_next_nentry+0x997/0xaa0 lib/maple_tree.c:4546
> > > > Read of size 8 at addr ffff88807811e418 by task syz-executor361/3593
> > > >
> > > > CPU: 1 PID: 3593 Comm: syz-executor361 Not tainted 5.18.0-rc4-next-20220427-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > > >  print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
> > > >  print_report mm/kasan/report.c:429 [inline]
> > > >  kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
> > > >  mas_safe_min lib/maple_tree.c:715 [inline]
> > > >  mas_next_nentry+0x997/0xaa0 lib/maple_tree.c:4546
> > > >  mas_next_entry lib/maple_tree.c:4636 [inline]
> > > >  mas_next+0x1eb/0xc40 lib/maple_tree.c:5723
> > > >  userfaultfd_register fs/userfaultfd.c:1468 [inline]
> > > >  userfaultfd_ioctl+0x2527/0x40f0 fs/userfaultfd.c:1993
> > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> > > >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> > > >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > RIP: 0033:0x7f4e5785d939
> > > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007ffff7501a18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > > > RAX: ffffffffffffffda RBX: 0000000000000031 RCX: 00007f4e5785d939
> > > > RDX: 00000000200001c0 RSI: 00000000c020aa00 RDI: 0000000000000003
> > > > RBP: 00007ffff7501b10 R08: 00007ffff7501a72 R09: 00007ffff7501a72
> > > > R10: 00007ffff7501a72 R11: 0000000000000246 R12: 00007ffff7501ae0
> > > > R13: 00007f4e578e14e0 R14: 0000000000000003 R15: 00007ffff7501a72
> > > >  </TASK>
> > > >
> > > > Allocated by task 3592:
> > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > >  kasan_set_track mm/kasan/common.c:45 [inline]
> > > >  set_alloc_info mm/kasan/common.c:436 [inline]
> > > >  __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
> > > >  kasan_slab_alloc include/linux/kasan.h:224 [inline]
> > > >  slab_post_alloc_hook mm/slab.h:750 [inline]
> > > >  kmem_cache_alloc_bulk+0x39f/0x720 mm/slub.c:3728
> > > >  mt_alloc_bulk lib/maple_tree.c:151 [inline]
> > > >  mas_alloc_nodes+0x1df/0x6b0 lib/maple_tree.c:1244
> > > >  mas_node_count+0x101/0x130 lib/maple_tree.c:1303
> > > >  mas_split lib/maple_tree.c:3406 [inline]
> > > >  mas_commit_b_node lib/maple_tree.c:3508 [inline]
> > > >  mas_wr_modify+0x2505/0x5ac0 lib/maple_tree.c:4251
> > > >  mas_wr_store_entry.isra.0+0x66e/0x10f0 lib/maple_tree.c:4289
> > > >  mas_store+0xac/0xf0 lib/maple_tree.c:5523
> > > >  dup_mmap+0x845/0x1030 kernel/fork.c:687
> > > >  dup_mm+0x91/0x370 kernel/fork.c:1516
> > > >  copy_mm kernel/fork.c:1565 [inline]
> > > >  copy_process+0x3b07/0x6fd0 kernel/fork.c:2226
> > > >  kernel_clone+0xe7/0xab0 kernel/fork.c:2631
> > > >  __do_sys_clone+0xc8/0x110 kernel/fork.c:2748
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > >
> > > > Freed by task 3593:
> > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > >  kasan_set_track+0x21/0x30 mm/kasan/common.c:45
> > > >  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
> > > >  ____kasan_slab_free mm/kasan/common.c:366 [inline]
> > > >  ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
> > > >  kasan_slab_free include/linux/kasan.h:200 [inline]
> > > >  slab_free_hook mm/slub.c:1727 [inline]
> > > >  slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
> > > >  slab_free mm/slub.c:3507 [inline]
> > > >  kmem_cache_free_bulk mm/slub.c:3654 [inline]
> > > >  kmem_cache_free_bulk+0x2c0/0xb60 mm/slub.c:3641
> > > >  mt_free_bulk lib/maple_tree.c:157 [inline]
> > > >  mas_destroy+0x394/0x5c0 lib/maple_tree.c:5685
> > > >  mas_store_prealloc+0xec/0x150 lib/maple_tree.c:5567
> > > >  vma_mas_store mm/internal.h:482 [inline]
> > > >  __vma_adjust+0x6ba/0x18f0 mm/mmap.c:811
> > > >  vma_adjust include/linux/mm.h:2654 [inline]
> > > >  __split_vma+0x443/0x530 mm/mmap.c:2259
> > > >  split_vma+0x9f/0xe0 mm/mmap.c:2292
> > > >  userfaultfd_register fs/userfaultfd.c:1444 [inline]
> > > >  userfaultfd_ioctl+0x39f4/0x40f0 fs/userfaultfd.c:1993
> > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> > > >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> > > >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > >
> > > > The buggy address belongs to the object at ffff88807811e400
> > > >  which belongs to the cache maple_node of size 256
> > > > The buggy address is located 24 bytes inside of
> > > >  256-byte region [ffff88807811e400, ffff88807811e500)
> > > >
> > > > The buggy address belongs to the physical page:
> > > > page:ffffea0001e04780 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7811e
> > > > head:ffffea0001e04780 order:1 compound_mapcount:0 compound_pincount:0
> > > > flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> > > > raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888010c4fdc0
> > > > raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> > > > page dumped because: kasan: bad access detected
> > > > page_owner tracks the page as allocated
> > > > page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3286, tgid 3286 (dhcpcd-run-hook), ts 27966983290, free_ts 22717162691
> > > >  prep_new_page mm/page_alloc.c:2431 [inline]
> > > >  get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4172
> > > >  __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5393
> > > >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2281
> > > >  alloc_slab_page mm/slub.c:1797 [inline]
> > > >  allocate_slab+0x26c/0x3c0 mm/slub.c:1942
> > > >  new_slab mm/slub.c:2002 [inline]
> > > >  ___slab_alloc+0x985/0xd90 mm/slub.c:3002
> > > >  kmem_cache_alloc_bulk+0x21c/0x720 mm/slub.c:3704
> > > >  mt_alloc_bulk lib/maple_tree.c:151 [inline]
> > > >  mas_alloc_nodes+0x2b0/0x6b0 lib/maple_tree.c:1244
> > > >  mas_preallocate+0xfb/0x270 lib/maple_tree.c:5581
> > > >  __vma_adjust+0x226/0x18f0 mm/mmap.c:742
> > > >  vma_adjust include/linux/mm.h:2654 [inline]
> > > >  __split_vma+0x443/0x530 mm/mmap.c:2259
> > > >  do_mas_align_munmap+0x4f5/0xe80 mm/mmap.c:2375
> > > >  do_mas_munmap+0x202/0x2c0 mm/mmap.c:2499
> > > >  mmap_region+0x219/0x1c70 mm/mmap.c:2547
> > > >  do_mmap+0x825/0xf60 mm/mmap.c:1471
> > > >  vm_mmap_pgoff+0x1b7/0x290 mm/util.c:488
> > > >  ksys_mmap_pgoff+0x40d/0x5a0 mm/mmap.c:1517
> > > > page last free stack trace:
> > > >  reset_page_owner include/linux/page_owner.h:24 [inline]
> > > >  free_pages_prepare mm/page_alloc.c:1346 [inline]
> > > >  free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1396
> > > >  free_unref_page_prepare mm/page_alloc.c:3318 [inline]
> > > >  free_unref_page+0x19/0x6a0 mm/page_alloc.c:3413
> > > >  __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2521
> > > >  qlink_free mm/kasan/quarantine.c:168 [inline]
> > > >  qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
> > > >  kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
> > > >  __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
> > > >  kasan_slab_alloc include/linux/kasan.h:224 [inline]
> > > >  slab_post_alloc_hook mm/slab.h:750 [inline]
> > > >  slab_alloc_node mm/slub.c:3214 [inline]
> > > >  slab_alloc mm/slub.c:3222 [inline]
> > > >  __kmalloc+0x200/0x350 mm/slub.c:4415
> > > >  kmalloc include/linux/slab.h:593 [inline]
> > > >  tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
> > > >  tomoyo_realpath_nofollow+0xc8/0xe0 security/tomoyo/realpath.c:309
> > > >  tomoyo_find_next_domain+0x280/0x1f80 security/tomoyo/domain.c:727
> > > >  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:101 [inline]
> > > >  tomoyo_bprm_check_security+0x121/0x1a0 security/tomoyo/tomoyo.c:91
> > > >  security_bprm_check+0x45/0xa0 security/security.c:865
> > > >  search_binary_handler fs/exec.c:1718 [inline]
> > > >  exec_binprm fs/exec.c:1771 [inline]
> > > >  bprm_execve fs/exec.c:1840 [inline]
> > > >  bprm_execve+0x732/0x1970 fs/exec.c:1802
> > > >  do_execveat_common+0x727/0x890 fs/exec.c:1945
> > > >  do_execve fs/exec.c:2015 [inline]
> > > >  __do_sys_execve fs/exec.c:2091 [inline]
> > > >  __se_sys_execve fs/exec.c:2086 [inline]
> > > >  __x64_sys_execve+0x8f/0xc0 fs/exec.c:2086
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >
> > > > Memory state around the buggy address:
> > > >  ffff88807811e300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > >  ffff88807811e380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > >ffff88807811e400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >                             ^
> > > >  ffff88807811e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >  ffff88807811e500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > ==================================================================
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > syzbot can test patches for this issue, for details see:
> > > > https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20220427151715.544aa2om5o7pp77n%40revolver.
