Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74948744A41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGAP3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAP3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:29:04 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F912686;
        Sat,  1 Jul 2023 08:29:02 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7673180224bso227524285a.0;
        Sat, 01 Jul 2023 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688225341; x=1690817341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnNzK0gcLhdk7+1QqOQy43AVinh7QwNlHxtbGqrRBuc=;
        b=pap8qWR74dXqxWn6FQeFI3pdTeUi0m3Fl6A+CigdLzqZvRCZ2iZUGCV0RMHm/BRZKi
         cTpD4luE8a2uLVHSWInLfyilyHKKPnmrYVgiB17a2kQlq2cE3muO4hZCRRO5F8k4NzAD
         GRHp8ulAm5qOuIV8BT9QskgzurZspXs7Mu3wGrvXRmsSu70ctd36CUggw4hrZbp+Szqf
         0V7MQ1AflGEdQ2oyWxr+aYR/9HK1MsdZ1P7Vnyjwc/G/Cpncun48mwZC8BUn7v34aZVU
         AqRB6egEcDBcsKvO4J3Bjui+3R9QhF4GM1UbrkdAOkWL+gyKT3yD452/+i22PveWk8Ny
         PBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688225341; x=1690817341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnNzK0gcLhdk7+1QqOQy43AVinh7QwNlHxtbGqrRBuc=;
        b=Fo1akEsCuISrf0WFnXMgnzEj4yEOGoneSZENxdYMsRwKZUwN2Bg0FG+k1aA7ATy3F0
         CynACqIFYIeJdf2Ft9ZFYCSxP7th69K5xVosqCTRMUYAk4mv++22TTnUZM1Qd3kUI8oC
         tI7wltkpB5+PRUttlOh3YeHhY9SFNh8wvtYh/rVqKjTpuub5FoZ+NF/zZULv0doPDNtD
         6+m+c1T3dchwRqTOG42Za+vqoNH4Lf7K6/a9h/5K5XdRm9IYF8CkswO22pNqHTadoMz/
         /jvCK1/DwqvOJMzPArNZgLsrtJtbgHBUAXk0M1Qi593r+SGhnzseEmmZFmve+Drzsve7
         dMjA==
X-Gm-Message-State: AC+VfDzq+en9PTFgPfVci39z5RFtLpIhKQ5VKYa1s2zsCgcb6vtIrNsJ
        OFjyuZsxJtus9vFWzHGe/0cXXHCDSBsmS5/EkcE=
X-Google-Smtp-Source: ACHHUZ6YBzIclo7TEG7+dFbhzHg9+2G0s3PXVypcpJ5IeL7RdU6mqzJxqrcN+5K/hzsuAHk4dexr5CMN67Qtg4o17e4=
X-Received: by 2002:a05:620a:28d4:b0:767:3e6e:3c6c with SMTP id
 l20-20020a05620a28d400b007673e6e3c6cmr7421464qkp.12.1688225341113; Sat, 01
 Jul 2023 08:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b7a0c305ff6da727@google.com>
In-Reply-To: <000000000000b7a0c305ff6da727@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Jul 2023 18:28:49 +0300
Message-ID: <CAOQ4uxirxK6ts20Ri97pMstcJYrTW8PbgYML057Uj0MBoySeGg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in init_file
To:     syzbot <syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 1, 2023 at 5:21=E2=80=AFPM syzbot
<syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1ef6663a587b Merge tag 'tag-chrome-platform-for-v6.5' of =
g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D120fd3a8a8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D33c8c2baba1cf=
c7e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dada42aab05cf51b=
00e98
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D130a5670a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11aac680a8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6561f5e7c861/dis=
k-1ef6663a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aed67f7d3a9d/vmlinu=
x-1ef6663a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/baa651e2ed8e/b=
zImage-1ef6663a.xz
>
> The issue was bisected to:
>
> commit 62d53c4a1dfe347bd87ede46ffad38c9a3870338
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Jun 15 11:22:28 2023 +0000
>
>     fs: use backing_file container for internal files with "fake" f_path
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D156341e0a8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D176341e0a8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D136341e0a8000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com
> Fixes: 62d53c4a1dfe ("fs: use backing_file container for internal files w=
ith "fake" f_path")
>
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbb808467a9
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
> RBP: 00007ffdc0c78ff0 R08: 0000000000000001 R09: 00007fbb80800034
> R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000006
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: invalid-free in init_file+0x195/0x200 fs/file_table.c:163
> Free of addr ffff88801ea5a800 by task syz-executor145/4991
>
> CPU: 0 PID: 4991 Comm: syz-executor145 Not tainted 6.4.0-syzkaller-01224-=
g1ef6663a587b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:351 [inline]
>  print_report+0x163/0x540 mm/kasan/report.c:462
>  kasan_report_invalid_free+0xeb/0x100 mm/kasan/report.c:537
>  ____kasan_slab_free+0xfb/0x120
>  kasan_slab_free include/linux/kasan.h:162 [inline]
>  slab_free_hook mm/slub.c:1781 [inline]
>  slab_free_freelist_hook mm/slub.c:1807 [inline]
>  slab_free mm/slub.c:3786 [inline]
>  kmem_cache_free+0x297/0x520 mm/slub.c:3808
>  init_file+0x195/0x200 fs/file_table.c:163
>  alloc_empty_backing_file+0x67/0xd0 fs/file_table.c:267
>  backing_file_open+0x26/0x100 fs/open.c:1166
>  ovl_open_realfile+0x1f6/0x350 fs/overlayfs/file.c:64
>  ovl_real_fdget_meta fs/overlayfs/file.c:122 [inline]
>  ovl_real_fdget fs/overlayfs/file.c:143 [inline]
>  ovl_splice_read+0x7cc/0x8c0 fs/overlayfs/file.c:430
>  splice_direct_to_actor+0x2a8/0x9a0 fs/splice.c:961
>  do_splice_direct+0x286/0x3d0 fs/splice.c:1070
>  do_sendfile+0x623/0x1070 fs/read_write.c:1254
>  __do_sys_sendfile64 fs/read_write.c:1322 [inline]
>  __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fbb808467a9
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdc0c78fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbb808467a9
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
> RBP: 00007ffdc0c78ff0 R08: 0000000000000001 R09: 00007fbb80800034
> R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000006
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>
> Allocated by task 4991:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
>  kmalloc include/linux/slab.h:559 [inline]
>  kzalloc include/linux/slab.h:680 [inline]
>  alloc_empty_backing_file+0x52/0xd0 fs/file_table.c:263
>  backing_file_open+0x26/0x100 fs/open.c:1166
>  ovl_open_realfile+0x1f6/0x350 fs/overlayfs/file.c:64
>  ovl_real_fdget_meta fs/overlayfs/file.c:122 [inline]
>  ovl_real_fdget fs/overlayfs/file.c:143 [inline]
>  ovl_splice_read+0x7cc/0x8c0 fs/overlayfs/file.c:430
>  splice_direct_to_actor+0x2a8/0x9a0 fs/splice.c:961
>  do_splice_direct+0x286/0x3d0 fs/splice.c:1070
>  do_sendfile+0x623/0x1070 fs/read_write.c:1254
>  __do_sys_sendfile64 fs/read_write.c:1322 [inline]
>  __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff88801ea5a800
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 0 bytes inside of
>  480-byte region [ffff88801ea5a800, ffff88801ea5a9e0)
>
> The buggy address belongs to the physical page:
> page:ffffea00007a9600 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x1ea58
> head:ffffea00007a9600 order:2 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
> anon flags: 0xfff00000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7=
ff)
> page_type: 0xffffffff()
> raw: 00fff00000010200 ffff888012441c80 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(=
__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), =
pid 733, tgid 733 (kworker/u4:0), ts 6534177535, free_ts 0
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1744
>  prep_new_page mm/page_alloc.c:1751 [inline]
>  get_page_from_freelist+0x320e/0x3390 mm/page_alloc.c:3523
>  __alloc_pages+0x255/0x670 mm/page_alloc.c:4794
>  alloc_slab_page+0x6a/0x160 mm/slub.c:1851
>  allocate_slab mm/slub.c:1998 [inline]
>  new_slab+0x84/0x2f0 mm/slub.c:2051
>  ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
>  __slab_alloc mm/slub.c:3291 [inline]
>  __slab_alloc_node mm/slub.c:3344 [inline]
>  slab_alloc_node mm/slub.c:3441 [inline]
>  __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3490
>  kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1057
>  kmalloc include/linux/slab.h:559 [inline]
>  kzalloc include/linux/slab.h:680 [inline]
>  alloc_bprm+0x56/0x900 fs/exec.c:1512
>  kernel_execve+0x96/0xa10 fs/exec.c:1987
>  call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> page_owner free stack trace missing
>
> Memory state around the buggy address:
>  ffff88801ea5a700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88801ea5a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88801ea5a800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>                    ^
>  ffff88801ea5a880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88801ea5a900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

#syz test https://github.com/amir73il/linux.git ovl-fixes

Thanks,
Amir.
