Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB46F424C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjEBLIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 07:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjEBLIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 07:08:10 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A71BF
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 04:08:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef31924c64so114711cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683025688; x=1685617688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUDcSuuwf99CjrFj0RS76HPcVODMt0PmeWJoCOYwgTE=;
        b=JVcxgWfBwSJLmLFXcV2UpK9oE6eAuKV2jxoH2bLjJ8FZyDthd7xCQBMNlkwlhWSTH+
         OMTXe6sn0Vateyfi73WoXkAHfikxK5ZpIN72T0bYXbjobQlGrsG2kMdd4IN57uPJfeXR
         S23KjpqcVCUhXNBFu8mKFoKy4LtteQFIiejCN4rgD8bvFXPsms3UTpHi01sS3c19zYg+
         j/Z4m8WVoHUCuEXeH8pUfk9jBKV6mzmxvHmTLX6wMu4FsitRteud0gG167j+A2zUrkE/
         iUDvWWEAYa5bmLOBdritazUyKXUdMv+RmdH7JaXilljfvttO8grzJBtjOyieyptxIrk9
         +qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025688; x=1685617688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUDcSuuwf99CjrFj0RS76HPcVODMt0PmeWJoCOYwgTE=;
        b=f7ntxiZCoWujzXqdiqsTkU6o5mepdqFzJeYVds8cmYGnuRe7XKpqnp8iZm1owPrdJE
         SI4BxYrJtbqYej8P+X+EzxIqUe3W+UqivECoTIrV0Nieq3X8Sra/ayBuR1uanKkeOyEb
         jV4Bp8uRlwSjZCTVvwWwmzT5I0t+4POPoKcli/sXkH3D53+QbvP3tHWCkg6BcAJwvJwH
         OmVU4OzGrzCCqX8dszL1t78lK6keEZj5NXePYeNM2sdDwXHofg0TdzoUMyIuKgVgWpAL
         g5yiQ1FE76ltxFvzuMeuN1m3782zLSn7y0jeHjobtCX+/5cGSCWfNFJpL+Tej5tbTQuo
         S4Mg==
X-Gm-Message-State: AC+VfDwGp9PmA0cGBxon6eQ6YCPA2Yv5RvdRBfUInkmpjaD3iSykJ+G3
        aUJPQiVN1M4jCGO94Lgx9ZsZ7Ryqld5BjtlVc8CvB+6UTaWmjy5Q/6o=
X-Google-Smtp-Source: ACHHUZ5VNbjfoop3PnLll3UVr7Gq+u54wz470Cs5Iae3izwjChmj/xvIAT34WYHo1SyIfmmuFJDRLswvr9cDBjt5ap4=
X-Received: by 2002:a05:622a:351:b0:3ef:a55:7f39 with SMTP id
 r17-20020a05622a035100b003ef0a557f39mr350770qtw.12.1683025687876; Tue, 02 May
 2023 04:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c5beb705faa6577d@google.com> <20230501212633.GN59213@frogsfrogsfrogs>
In-Reply-To: <20230501212633.GN59213@frogsfrogsfrogs>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 2 May 2023 13:07:56 +0200
Message-ID: <CANp29Y6YL8t6LMJRar7SMbaMU3ZCUMV1L_C7MFJm9MLLcy7omA@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xfs_getbmap
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     syzbot <syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Darrick,

On Mon, May 1, 2023 at 11:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, May 01, 2023 at 11:53:47AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://gi=
t.k..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11e6af2c280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5eadbf0d3c2=
ece89
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc103d3808a0de=
5faaf80
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12e25f2c2=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14945d10280=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/60130779f509/d=
isk-58390c8c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/d7f0cdd29b71/vmli=
nux-58390c8c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/de415ad52ae4=
/bzImage-58390c8c.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/c94bae2c=
94e1/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com
>
>
> #syz test: git://repo/address.git branch-or-commit-hash

FWIW it looks like you forgot to substitute the repo and branch,
therefore syzbot just ignored the patch testing request (it's taught
not to react on commands with sample arguments).

--=20
Aleksandr
>
> --D
>
>
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-out-of-bounds in xfs_getbmap+0x1c06/0x1c90 fs/xfs/xfs_=
bmap_util.c:561
> > Read of size 4 at addr ffff88801872aa78 by task syz-executor294/5000
> >
> > CPU: 1 PID: 5000 Comm: syz-executor294 Not tainted 6.3.0-syzkaller-1204=
9-g58390c8ce1bd #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 04/14/2023
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:351 [inline]
> >  print_report+0x163/0x540 mm/kasan/report.c:462
> >  kasan_report+0x176/0x1b0 mm/kasan/report.c:572
> >  xfs_getbmap+0x1c06/0x1c90 fs/xfs/xfs_bmap_util.c:561
> >  xfs_ioc_getbmap+0x243/0x7a0 fs/xfs/xfs_ioctl.c:1481
> >  xfs_file_ioctl+0xbf5/0x16a0 fs/xfs/xfs_ioctl.c:1949
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fc886bade49
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fc87f738208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007fc886c3c7b8 RCX: 00007fc886bade49
> > RDX: 0000000020000140 RSI: 00000000c0205826 RDI: 0000000000000005
> > RBP: 00007fc886c3c7b0 R08: 00007fc87f738700 R09: 0000000000000000
> > R10: 00007fc87f738700 R11: 0000000000000246 R12: 00007fc886c3c7bc
> > R13: 00007ffdc483022f R14: 00007fc87f738300 R15: 0000000000022000
> >  </TASK>
> >
> > Allocated by task 4450:
> >  kasan_save_stack mm/kasan/common.c:45 [inline]
> >  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
> >  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
> >  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
> >  kasan_kmalloc include/linux/kasan.h:196 [inline]
> >  __do_kmalloc_node mm/slab_common.c:966 [inline]
> >  __kmalloc_node+0xb8/0x230 mm/slab_common.c:973
> >  kmalloc_node include/linux/slab.h:579 [inline]
> >  kvmalloc_node+0x72/0x180 mm/util.c:604
> >  kvmalloc include/linux/slab.h:697 [inline]
> >  simple_xattr_alloc+0x43/0xa0 fs/xattr.c:1073
> >  shmem_initxattrs+0x8e/0x1e0 mm/shmem.c:3290
> >  security_inode_init_security+0x2df/0x3f0 security/security.c:1630
> >  shmem_mknod+0xba/0x1c0 mm/shmem.c:2947
> >  lookup_open fs/namei.c:3492 [inline]
> >  open_last_lookups fs/namei.c:3560 [inline]
> >  path_openat+0x13df/0x3170 fs/namei.c:3788
> >  do_filp_open+0x234/0x490 fs/namei.c:3818
> >  do_sys_openat2+0x13f/0x500 fs/open.c:1356
> >  do_sys_open fs/open.c:1372 [inline]
> >  __do_sys_openat fs/open.c:1388 [inline]
> >  __se_sys_openat fs/open.c:1383 [inline]
> >  __x64_sys_openat+0x247/0x290 fs/open.c:1383
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > The buggy address belongs to the object at ffff88801872aa00
> >  which belongs to the cache kmalloc-64 of size 64
> > The buggy address is located 79 bytes to the right of
> >  allocated 41-byte region [ffff88801872aa00, ffff88801872aa29)
> >
> > The buggy address belongs to the physical page:
> > page:ffffea000061ca80 refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x1872a
> > flags: 0xfff00000000200(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: 0xffffffff()
> > raw: 00fff00000000200 ffff888012441640 ffffea0000ad39c0 dead00000000000=
2
> > raw: 0000000000000000 0000000080200020 00000001ffffffff 000000000000000=
0
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc=
0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4439, tgid 4439 (S02sysctl), =
ts 15189537421, free_ts 15177747790
> >  set_page_owner include/linux/page_owner.h:31 [inline]
> >  post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1722
> >  prep_new_page mm/page_alloc.c:1729 [inline]
> >  get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3493
> >  __alloc_pages+0x255/0x670 mm/page_alloc.c:4759
> >  alloc_slab_page+0x6a/0x160 mm/slub.c:1851
> >  allocate_slab mm/slub.c:1998 [inline]
> >  new_slab+0x84/0x2f0 mm/slub.c:2051
> >  ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
> >  __slab_alloc mm/slub.c:3291 [inline]
> >  __slab_alloc_node mm/slub.c:3344 [inline]
> >  slab_alloc_node mm/slub.c:3441 [inline]
> >  __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3490
> >  kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1057
> >  kmalloc include/linux/slab.h:559 [inline]
> >  load_elf_binary+0x1cdb/0x2830 fs/binfmt_elf.c:910
> >  search_binary_handler fs/exec.c:1737 [inline]
> >  exec_binprm fs/exec.c:1779 [inline]
> >  bprm_execve+0x90e/0x1740 fs/exec.c:1854
> >  do_execveat_common+0x580/0x720 fs/exec.c:1962
> >  do_execve fs/exec.c:2036 [inline]
> >  __do_sys_execve fs/exec.c:2112 [inline]
> >  __se_sys_execve fs/exec.c:2107 [inline]
> >  __x64_sys_execve+0x92/0xa0 fs/exec.c:2107
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > page last free stack trace:
> >  reset_page_owner include/linux/page_owner.h:24 [inline]
> >  free_pages_prepare mm/page_alloc.c:1302 [inline]
> >  free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2555
> >  free_unref_page_list+0x596/0x830 mm/page_alloc.c:2696
> >  release_pages+0x2193/0x2470 mm/swap.c:1042
> >  tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
> >  tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
> >  tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
> >  tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
> >  exit_mmap+0x3da/0xaf0 mm/mmap.c:3123
> >  __mmput+0x115/0x3c0 kernel/fork.c:1351
> >  exec_mmap+0x672/0x700 fs/exec.c:1035
> >  begin_new_exec+0x665/0xf10 fs/exec.c:1294
> >  load_elf_binary+0x95d/0x2830 fs/binfmt_elf.c:1001
> >  search_binary_handler fs/exec.c:1737 [inline]
> >  exec_binprm fs/exec.c:1779 [inline]
> >  bprm_execve+0x90e/0x1740 fs/exec.c:1854
> >  do_execveat_common+0x580/0x720 fs/exec.c:1962
> >  do_execve fs/exec.c:2036 [inline]
> >  __do_sys_execve fs/exec.c:2112 [inline]
> >  __se_sys_execve fs/exec.c:2107 [inline]
> >  __x64_sys_execve+0x92/0xa0 fs/exec.c:2107
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > Memory state around the buggy address:
> >  ffff88801872a900: 00 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc
> >  ffff88801872a980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > >ffff88801872aa00: 00 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc
> >                                                                 ^
> >  ffff88801872aa80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> >  ffff88801872ab00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to change bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the bug is a duplicate of another bug, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20230501212633.GN59213%40frogsfrogsfrogs.
