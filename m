Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DF06FED1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbjEKHr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 03:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjEKHrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 03:47:24 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ECB469F;
        Thu, 11 May 2023 00:47:22 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4501f454581so3810522e0c.3;
        Thu, 11 May 2023 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683791241; x=1686383241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJGEJSekjBhNo2PY1J/pLosNGvv6qeF1YSP7iH0GfZE=;
        b=UKOLm7icvGsH69TydLHKymXCgpPMw8w6UB9vWqn8h4DrdBMMVyGHIXQHernNS21wmF
         6WuI7IkLrDle+wGC43s7CYcub9CSYsyqNFGh5rK5WBkw83ZDxannERL7lNL89B8FrgJt
         /qQUAWOdbgVfE38Mol2f3uJ/5vT6ZnzjKoS3K16hNlnhVgJZHoeuZsfn4GUmggPY/L9p
         6S9wRDfpKzikRmwU61qwrwD5ZoHB9DLGmTorchKFSf5nYHtEbbrwSPBVgrMD+GVGpkEm
         8sFO+TmqAQQvT2RWLoQJpj5Oj9jdBijgZ4eEG461Q3ABQ4aB2zaO9eb91EIgJdsTUPfs
         SC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791241; x=1686383241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJGEJSekjBhNo2PY1J/pLosNGvv6qeF1YSP7iH0GfZE=;
        b=MlEli4TjRidxaOJ43f8z+lRxyWqRA8rr7fJU7sI7buIHa5yjc+eoO3aLzKx3a91ZGE
         p2cAe2TVzcnKj1h+9kL0YrVJEfOVFuBZZYTueHNF3GJqTO6lkrhSuHZLLz9AeMfEzJeE
         quL9d7fcP2ytVjjdYm9K4FGSmy39MnKLuyDaeZc0butIcgrBqHqoecdBH59hKV5FQ8iu
         85MYBlZM04DsbO/ETmC+D0/fVFIrVW2SB7ezHxL8gG+QVwcD83+8QtlRT8pjKiyz1iF0
         lnsoLUdJAb0HGj8wZH/93+8+hrJRkjV6AHpBz3nJJB2fsQnW7bC5k0hYY1fMQKxre5dT
         kN1A==
X-Gm-Message-State: AC+VfDzSo7jya53luHQKOubKZBof2Hr2Q/ik69TMCDfNIvhnlnhHSghx
        g02DqDJZseNU09UG9O1lwjASvTIQqbkEjxmlbX8=
X-Google-Smtp-Source: ACHHUZ52ou12cO+6aPU99Fur80wnrgYKsux1HjiWRjJ1qe4mx9lhbCaRlVVL1JsJ82sSB/ZWL3jO9dn/lnnwXmj59Tw=
X-Received: by 2002:a1f:5e81:0:b0:44f:eae4:da84 with SMTP id
 s123-20020a1f5e81000000b0044feae4da84mr6127807vkb.5.1683791240949; Thu, 11
 May 2023 00:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001acf0205fb65a210@google.com>
In-Reply-To: <0000000000001acf0205fb65a210@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 11 May 2023 16:47:04 +0900
Message-ID: <CAKFNMokUu=QUAyO-xOictMD9zYoJCqPc1dLRJ_Z-5cC-B-Mbyg@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] KASAN: slab-use-after-free Write in nilfs_inode_sub_blocks
To:     syzbot <syzbot+9e707f43f54a997a3d24@syzkaller.appspotmail.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11, 2023 at 4:06=E2=80=AFPM syzbot
<syzbot+9e707f43f54a997a3d24@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusi=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14d4918e28000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D38526bf24c8d9=
61b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9e707f43f54a997=
a3d24
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3ce65c9fe5fa/dis=
k-16a88291.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3b31187819e4/vmlinu=
x-16a88291.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bf345be82c12/b=
zImage-16a88291.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9e707f43f54a997a3d24@syzkaller.appspotmail.com
>
> NILFS (loop2): discard dirty block: blocknr=3D18446744073709551615, size=
=3D1024
> NILFS (loop2): discard dirty block: blocknr=3D18446744073709551615, size=
=3D1024
> NILFS (loop2): discard dirty block: blocknr=3D18446744073709551615, size=
=3D1024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/l=
inux/instrumented.h:96 [inline]
> BUG: KASAN: slab-use-after-free in atomic64_sub include/linux/atomic/atom=
ic-instrumented.h:764 [inline]
> BUG: KASAN: slab-use-after-free in nilfs_inode_sub_blocks+0x97/0xe0 fs/ni=
lfs2/inode.c:61
> Write of size 8 at addr ffff88807abb5240 by task syz-executor.2/5038
>
> CPU: 0 PID: 5038 Comm: syz-executor.2 Not tainted 6.4.0-rc1-syzkaller-000=
12-g16a8829130ca #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/14/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:351 [inline]
>  print_report+0x163/0x540 mm/kasan/report.c:462
>  kasan_report+0x176/0x1b0 mm/kasan/report.c:572
>  kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic64_sub include/linux/atomic/atomic-instrumented.h:764 [inline]
>  nilfs_inode_sub_blocks+0x97/0xe0 fs/nilfs2/inode.c:61
>  nilfs_direct_delete+0x27e/0x310 fs/nilfs2/direct.c:159
>  nilfs_bmap_do_delete fs/nilfs2/bmap.c:184 [inline]
>  nilfs_bmap_do_truncate fs/nilfs2/bmap.c:272 [inline]
>  nilfs_bmap_truncate+0x300/0x560 fs/nilfs2/bmap.c:305
>  nilfs_truncate_bmap+0x207/0x3d0 fs/nilfs2/inode.c:846
>  nilfs_evict_inode+0x17c/0x420 fs/nilfs2/inode.c:933
>  evict+0x2a4/0x620 fs/inode.c:665
>  nilfs_dispose_list+0x51d/0x5c0 fs/nilfs2/segment.c:816
>  nilfs_detach_log_writer+0xaf1/0xbb0 fs/nilfs2/segment.c:2852
>  nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:477
>  generic_shutdown_super+0x134/0x340 fs/super.c:500
>  kill_block_super+0x84/0xf0 fs/super.c:1407
>  deactivate_locked_super+0xa4/0x110 fs/super.c:331
>  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
>  task_work_run+0x24a/0x300 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
>  exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>  syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f545728d5d7
> Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 0=
9 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff87fdfd18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f545728d5d7
> RDX: 00007fff87fdfdeb RSI: 000000000000000a RDI: 00007fff87fdfde0
> RBP: 00007fff87fdfde0 R08: 00000000ffffffff R09: 00007fff87fdfbb0
> R10: 00005555563268b3 R11: 0000000000000246 R12: 00007f54572e6cdc
> R13: 00007fff87fe0ea0 R14: 0000555556326810 R15: 00007fff87fe0ee0
>  </TASK>
>
> Allocated by task 13219:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
>  kmalloc include/linux/slab.h:559 [inline]
>  kzalloc include/linux/slab.h:680 [inline]
>  nilfs_find_or_create_root+0x137/0x4e0 fs/nilfs2/the_nilfs.c:810
>  nilfs_attach_checkpoint+0x123/0x4d0 fs/nilfs2/super.c:529
>  nilfs_fill_super+0x321/0x600 fs/nilfs2/super.c:1074
>  nilfs_mount+0x67d/0x9a0 fs/nilfs2/super.c:1326
>  legacy_get_tree+0xef/0x190 fs/fs_context.c:610
>  vfs_get_tree+0x8c/0x270 fs/super.c:1510
>  do_new_mount+0x28f/0xae0 fs/namespace.c:3039
>  do_mount fs/namespace.c:3382 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Freed by task 5038:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
>  ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>  kasan_slab_free include/linux/kasan.h:162 [inline]
>  slab_free_hook mm/slub.c:1781 [inline]
>  slab_free_freelist_hook mm/slub.c:1807 [inline]
>  slab_free mm/slub.c:3786 [inline]
>  __kmem_cache_free+0x264/0x3c0 mm/slub.c:3799
>  nilfs_evict_inode+0x103/0x420 fs/nilfs2/inode.c:925
>  evict+0x2a4/0x620 fs/inode.c:665
>  nilfs_dispose_list+0x51d/0x5c0 fs/nilfs2/segment.c:816
>  nilfs_detach_log_writer+0xaf1/0xbb0 fs/nilfs2/segment.c:2852
>  nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:477
>  generic_shutdown_super+0x134/0x340 fs/super.c:500
>  kill_block_super+0x84/0xf0 fs/super.c:1407
>  deactivate_locked_super+0xa4/0x110 fs/super.c:331
>  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
>  task_work_run+0x24a/0x300 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
>  exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>  syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff88807abb5200
>  which belongs to the cache kmalloc-256 of size 256
> The buggy address is located 64 bytes inside of
>  freed 256-byte region [ffff88807abb5200, ffff88807abb5300)
>
> The buggy address belongs to the physical page:
> page:ffffea0001eaed00 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x7abb4
> head:ffffea0001eaed00 order:1 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
> flags: 0xfff00000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000010200 ffff888012441b40 ffffea0000a82100 dead000000000004
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d2040=
(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARD=
WALL), pid 5142, tgid 5142 (udevd), ts 305278177864, free_ts 305225685128
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
>  prep_new_page mm/page_alloc.c:1738 [inline]
>  get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
>  __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
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
>  smk_fetch+0x92/0x140 security/smack/smack_lsm.c:291
>  smack_d_instantiate+0x868/0xb40 security/smack/smack_lsm.c:3512
>  security_d_instantiate+0x9b/0xf0 security/security.c:3760
>  d_instantiate+0x55/0x90 fs/dcache.c:2034
>  shmem_symlink+0x5a6/0x750 mm/shmem.c:3195
>  vfs_symlink+0x12f/0x2a0 fs/namei.c:4475
>  do_symlinkat+0x201/0x610 fs/namei.c:4501
>  __do_sys_symlink fs/namei.c:4522 [inline]
>  __se_sys_symlink fs/namei.c:4520 [inline]
>  __x64_sys_symlink+0x7e/0x90 fs/namei.c:4520
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1302 [inline]
>  free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
>  free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
>  qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
>  kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
>  __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
>  kasan_slab_alloc include/linux/kasan.h:186 [inline]
>  slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
>  slab_alloc_node mm/slub.c:3451 [inline]
>  __kmem_cache_alloc_node+0x14c/0x290 mm/slub.c:3490
>  __do_kmalloc_node mm/slab_common.c:965 [inline]
>  __kmalloc+0xa8/0x230 mm/slab_common.c:979
>  kmalloc include/linux/slab.h:563 [inline]
>  tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_check_open_permission+0x254/0x4e0 security/tomoyo/file.c:771
>  security_file_open+0x63/0xa0 security/security.c:2797
>  do_dentry_open+0x308/0x10f0 fs/open.c:907
>  do_open fs/namei.c:3636 [inline]
>  path_openat+0x27b3/0x3170 fs/namei.c:3791
>  do_filp_open+0x234/0x490 fs/namei.c:3818
>  do_sys_openat2+0x13f/0x500 fs/open.c:1356
>  do_sys_open fs/open.c:1372 [inline]
>  __do_sys_openat fs/open.c:1388 [inline]
>  __se_sys_openat fs/open.c:1383 [inline]
>  __x64_sys_openat+0x247/0x290 fs/open.c:1383
>
> Memory state around the buggy address:
>  ffff88807abb5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88807abb5180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88807abb5200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                            ^
>  ffff88807abb5280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88807abb5300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

According to the call trace, this issue hits an issue with the same
root cause as reported by "[syzbot] [nilfs?] KASAN:
slab-use-after-free Read in nilfs_load_inode_block", and will be fixed
by the on-going patch below:

#syz fix: nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode=
()

Ryusuke Konishi
