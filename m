Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE27B0724
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjI0Olh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjI0Olg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:41:36 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14DF9;
        Wed, 27 Sep 2023 07:41:35 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7a52a27fe03so4673484241.0;
        Wed, 27 Sep 2023 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695825694; x=1696430494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mdoGuuiZTcS/IHtakwNFgzhKSKxWpR+ML4xAmJhbGY=;
        b=dPuORG3ZqkLDPAV2w6p3u8h9CeLQ9sOA4uEqBVr2eY7pvWGFMeR5nYOgKrpos44l/c
         7NHfpAXANWa3QnNQ/L4MwHO4TV01JCJekErJ3Im5uS+/N1LzNNbXuo1lb14dKHwSQw2h
         B2sqUWwybYYVazx6yRgrsdE5IQ9q/QbgT11nYEXbxvpmCvLCUvHLQR+LM9tkf00NrW3H
         ZbxtQuAnJCcNl2aZX2reXzamx0B8r0Y583Ar17/WBGeePZCb/C69mOAbvD8TVASQLWVc
         E+2a+vE7plrp0ElOclqfKz44NhSQDA4aNF3UVxVEbyERwEsRxNbKFXKTlmJhmcr6Jnxa
         ARbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825694; x=1696430494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mdoGuuiZTcS/IHtakwNFgzhKSKxWpR+ML4xAmJhbGY=;
        b=H11yKzhq2kotmbvpikRrb8czbObYWF27FgoTQ4p6Di5+eSbV42FCukbjrMYIAorNk6
         Cz2EbTmPN3C91PiBhMJDcBPu2kbNpEpMBKpNQ5aYPcajpDH10fl9OqFvijpBLCD7384+
         3tMnb+goKc/2ZpudgdVukTNIQi2O9S/17Iy3Z0rSHC9pFwyvbANDRYqC8YJ70NiLhmZN
         ZPbygpUYARpykeAQfeZhjbgNdeRVlCLPPjE+nOFHbk1YeAGv39KBvwopi7sNAr545jDv
         UlQX6ZWaczRK4PI7/5Gz+S4wdGVMd3OHPlR06T7hZQh+RaY3ZBIp6ZPCQbj63LVOL07r
         lNdg==
X-Gm-Message-State: AOJu0Yz3+TUzdKP71ZOC2aKw/+w2NGfeehna7vNpor+6WhNk7M+EmF/f
        Cr3BrQEotSDinHuZbggphbS4pkXhO0pwLnbvx28=
X-Google-Smtp-Source: AGHT+IFJfXcobFCqLnK0J3r7KRILJgC/2Zi+VMchFVx/bwJFdp7B3FaQACAnnV5LiS4+9On22nRC0ibTFDdASAQDsUQ=
X-Received: by 2002:a67:ec0b:0:b0:44e:89bd:9a5c with SMTP id
 d11-20020a67ec0b000000b0044e89bd9a5cmr2049194vso.10.1695825694175; Wed, 27
 Sep 2023 07:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000021e24406063877ff@google.com>
In-Reply-To: <00000000000021e24406063877ff@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Sep 2023 17:41:23 +0300
Message-ID: <CAOQ4uxjssgw1tZrUQvtHHVacSgR9NE0yF8DA3+R5LNFAocCvVQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in ovl_copy_up_one
To:     syzbot <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 3:50=E2=80=AFAM syzbot
<syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    940fcc189c51 Add linux-next specific files for 20230921
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D158b942468000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1f140ae6e669a=
c24
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D477d8d8901756d1=
cbba1
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D120e0dba680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12f3767a68000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b8921b235c24/dis=
k-940fcc18.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c80a9f6bcdd4/vmlinu=
x-940fcc18.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ed10a4df6950/b=
zImage-940fcc18.xz
>
> The issue was bisected to:
>
> commit 44ef23e481b02df2f17599a24f81cf0045dc5256
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Wed Aug 16 13:47:59 2023 +0000
>
>     ovl: do not encode lower fh with upper sb_writers held
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1364cda668=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10e4cda668=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1764cda668000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com
> Fixes: 44ef23e481b0 ("ovl: do not encode lower fh with upper sb_writers h=
eld")
>
> RAX: ffffffffffffffda RBX: 00007ffd8d25ca30 RCX: 00007f15a9d353e9
> RDX: 00007f15a9d344b0 RSI: 00007ffd8d25ca30 RDI: 0000000020000200
> RBP: 0000000000000002 R08: 00007ffd8d25c7a6 R09: 00007ffd8d2d51a0
> R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffd8d25ca2c
> R13: 00007ffd8d25ca70 R14: 00007ffd8d25ca50 R15: 0000000000000002
>  </TASK>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: invalid-free in slab_free mm/slub.c:3809 [inline]
> BUG: KASAN: invalid-free in __kmem_cache_free+0xb8/0x2d0 mm/slub.c:3822
> Free of addr ffff888078b14650 by task syz-executor360/5060
>
> CPU: 0 PID: 5060 Comm: syz-executor360 Not tainted 6.6.0-rc2-next-2023092=
1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/04/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc4/0x620 mm/kasan/report.c:475
>  kasan_report_invalid_free+0xab/0xd0 mm/kasan/report.c:550
>  ____kasan_slab_free+0x1a0/0x1b0 mm/kasan/common.c:216
>  kasan_slab_free include/linux/kasan.h:164 [inline]
>  slab_free_hook mm/slub.c:1800 [inline]
>  slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
>  slab_free mm/slub.c:3809 [inline]
>  __kmem_cache_free+0xb8/0x2d0 mm/slub.c:3822
>  ovl_do_copy_up fs/overlayfs/copy_up.c:973 [inline]
>  ovl_copy_up_one+0x15ac/0x3250 fs/overlayfs/copy_up.c:1137
>  ovl_copy_up_flags+0x189/0x200 fs/overlayfs/copy_up.c:1192
>  ovl_nlink_start+0x391/0x470 fs/overlayfs/util.c:1144
>  ovl_do_remove+0x16d/0xd50 fs/overlayfs/dir.c:893
>  vfs_unlink+0x2f1/0x900 fs/namei.c:4313
>  do_unlinkat+0x3da/0x6d0 fs/namei.c:4379
>  __do_sys_unlink fs/namei.c:4427 [inline]
>  __se_sys_unlink fs/namei.c:4425 [inline]
>  __x64_sys_unlink+0xc8/0x110 fs/namei.c:4425
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f15a9d353e9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd8d25ca08 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
> RAX: ffffffffffffffda RBX: 00007ffd8d25ca30 RCX: 00007f15a9d353e9
> RDX: 00007f15a9d344b0 RSI: 00007ffd8d25ca30 RDI: 0000000020000200
> RBP: 0000000000000002 R08: 00007ffd8d25c7a6 R09: 00007ffd8d2d51a0
> R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffd8d25ca2c
> R13: 00007ffd8d25ca70 R14: 00007ffd8d25ca50 R15: 0000000000000002
>  </TASK>
>
> Allocated by task 5060:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:188 [inline]
>  slab_post_alloc_hook mm/slab.h:762 [inline]
>  slab_alloc_node mm/slub.c:3478 [inline]
>  slab_alloc mm/slub.c:3486 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>  kmem_cache_alloc_lru+0x215/0x670 mm/slub.c:3509
>  __d_alloc+0x32/0xac0 fs/dcache.c:1768
>  d_alloc+0x4e/0x220 fs/dcache.c:1848
>  lookup_one_qstr_excl+0xc7/0x180 fs/namei.c:1604
>  do_unlinkat+0x294/0x6d0 fs/namei.c:4365
>  __do_sys_unlink fs/namei.c:4427 [inline]
>  __se_sys_unlink fs/namei.c:4425 [inline]
>  __x64_sys_unlink+0xc8/0x110 fs/namei.c:4425
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
>  __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
>  dentry_free+0xc2/0x160 fs/dcache.c:377
>  __dentry_kill+0x4c1/0x640 fs/dcache.c:621
>  dentry_kill fs/dcache.c:745 [inline]
>  dput+0x6de/0xf80 fs/dcache.c:913
>  handle_mounts fs/namei.c:1554 [inline]
>  step_into+0x1192/0x2230 fs/namei.c:1839
>  walk_component+0xfc/0x5a0 fs/namei.c:2007
>  lookup_last fs/namei.c:2458 [inline]
>  path_lookupat+0x17f/0x770 fs/namei.c:2482
>  filename_lookup+0x1e7/0x5b0 fs/namei.c:2511
>  vfs_statx+0x160/0x430 fs/stat.c:240
>  vfs_fstatat+0xb3/0x140 fs/stat.c:295
>  __do_sys_newfstatat+0x98/0x110 fs/stat.c:459
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff888078b145e0
>  which belongs to the cache dentry of size 312
> The buggy address is located 112 bytes inside of
>  312-byte region [ffff888078b145e0, ffff888078b14718)
>
> The buggy address belongs to the physical page:
> page:ffffea0001e2c500 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x78b14
> head:ffffea0001e2c500 order:1 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
> ksm flags: 0xfff00000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7f=
f)
> page_type: 0xffffffff()
> raw: 00fff00000000840 ffff88814000a8c0 ffffea0001e2d080 dead000000000003
> raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d=
0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|=
__GFP_RECLAIMABLE), pid 4515, tgid 4515 (udevd), ts 47959600386, free_ts 28=
011797989
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1530
>  prep_new_page mm/page_alloc.c:1537 [inline]
>  get_page_from_freelist+0xf17/0x2e50 mm/page_alloc.c:3200
>  __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4456
>  alloc_pages+0x1a9/0x270 mm/mempolicy.c:2305
>  alloc_slab_page mm/slub.c:1870 [inline]
>  allocate_slab+0x251/0x380 mm/slub.c:2017
>  new_slab mm/slub.c:2070 [inline]
>  ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
>  __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
>  __slab_alloc_node mm/slub.c:3375 [inline]
>  slab_alloc_node mm/slub.c:3468 [inline]
>  slab_alloc mm/slub.c:3486 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>  kmem_cache_alloc_lru+0x4e1/0x670 mm/slub.c:3509
>  __d_alloc+0x32/0xac0 fs/dcache.c:1768
>  d_alloc+0x4e/0x220 fs/dcache.c:1848
>  d_alloc_parallel+0xe9/0x12d0 fs/dcache.c:2637
>  lookup_open.isra.0+0xaa4/0x13b0 fs/namei.c:3401
>  open_last_lookups fs/namei.c:3544 [inline]
>  path_openat+0x931/0x29c0 fs/namei.c:3774
>  do_filp_open+0x1de/0x430 fs/namei.c:3804
>  do_sys_openat2+0x176/0x1e0 fs/open.c:1422
>  do_sys_open fs/open.c:1437 [inline]
>  __do_sys_openat fs/open.c:1453 [inline]
>  __se_sys_openat fs/open.c:1448 [inline]
>  __x64_sys_openat+0x175/0x210 fs/open.c:1448
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1130 [inline]
>  free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2342
>  free_unref_page+0x33/0x3b0 mm/page_alloc.c:2435
>  free_contig_range+0xb6/0x190 mm/page_alloc.c:6372
>  destroy_args+0x7c9/0xa10 mm/debug_vm_pgtable.c:1028
>  debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
>  do_one_initcall+0x11c/0x640 init/main.c:1232
>  do_initcall_level init/main.c:1294 [inline]
>  do_initcalls init/main.c:1310 [inline]
>  do_basic_setup init/main.c:1329 [inline]
>  kernel_init_freeable+0x5c2/0x8f0 init/main.c:1547
>  kernel_init+0x1c/0x2a0 init/main.c:1437
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
> Memory state around the buggy address:
>  ffff888078b14500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888078b14580: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
> >ffff888078b14600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>                                                  ^
>  ffff888078b14680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888078b14700: 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>

#syz test: https://github.com/amir73il/linux.git ovl_want_write
