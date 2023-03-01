Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2311E6A67A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 07:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCAGds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 01:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjCAGdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:33:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED720577;
        Tue, 28 Feb 2023 22:33:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id da10so49728251edb.3;
        Tue, 28 Feb 2023 22:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677652425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ0sHpV4kb5DdgjjP/PV/M8inC6CR4KXwXxthmVsans=;
        b=TWmQ68N45Nvy1HMOva1xF3Z00EpnEUFM6T1NFuhVVht9RGRfl1QWAb7IOROnUasff5
         4Gh5DJAHE1OJExWr1Ce71Zfjt5H1N0WaChm4IPEfbRApdg9FmZLbWhBO0DFSTvlhnVJE
         vdH4p4WlYzvW4vaB57EiaJL8iRjwJ9+l+uzMNo/NwXLhJkBoO1vST87GptDWpnzslyGR
         2gLdRX17iw1rB8hqjdfwmmtJVsa+B+nqHBQ1XGXCWMlUaAcXRox8PhSuzjmZRu77O/xw
         Wm9AsZwQ9dnfHgTCKHwewcFklzugF7/Rc4KoV2XONWYABCOSeu8CmFltOOEuD23mVWJI
         wq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677652425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ0sHpV4kb5DdgjjP/PV/M8inC6CR4KXwXxthmVsans=;
        b=U/BR4HkBCD7bs/6p5ebQBPBd6BL9huwnc9IFX0ijx6sgewduT5/ccEX8jcjd32u3mh
         eMgzmkzosAW4TvJhlaIxw8qCxeXQ71XSCClNwNjh9RPxXDpiYsoM8JBVSy5SJ0LmXIm1
         asYjYIA/OFmDGHEzB2Xu06rKRrAf9QS7oZRwVLm8Imoia9YM86liTzHyZZY3oDALdBkb
         qE4mOINFL5ZVRTIeLhfIclCDSm5AcXR5VwlLhsU0W17Fd+6GnX40cAlRHetmgIiaZEf9
         n36jg7A/ezZLja4M0nF+ELvco5aWPGjlJWLtuwbBZZwCkrV2HQqPP0zRtts2eq3ZtOkF
         02Jg==
X-Gm-Message-State: AO0yUKXl0SpZaNVNZgFA052YzMQyBCKOiUGLNFqcBR+HNbQkCXk2H6e8
        1CTk+6xH4XEyK+MDFSG4n5LFwz5lmLP4b5ek+jU=
X-Google-Smtp-Source: AK7set+rnDC9ynOKZs0lhc7UH7EVgGyjnzGB4eHESh9fYF/DWtFu68W4M2iRL1L30ZAIRXh8MatmzyuVJJgqaZHD+sI=
X-Received: by 2002:a17:907:a0e:b0:8f7:f3d4:942c with SMTP id
 bb14-20020a1709070a0e00b008f7f3d4942cmr4589201ejc.7.1677652424571; Tue, 28
 Feb 2023 22:33:44 -0800 (PST)
MIME-Version: 1.0
References: <CAGyP=7fWFjioc7ok0SZ7kBNh6_MAk1keL4BKPvUNdmpGjnsZOA@mail.gmail.com>
 <20230228124556.riiwwskbrh7lxogt@quack3>
In-Reply-To: <20230228124556.riiwwskbrh7lxogt@quack3>
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Tue, 28 Feb 2023 22:33:32 -0800
Message-ID: <CAGyP=7f5mtWWhXF58-HaEmq=3Pba1EU83KKxwVXCe8tv9cARZQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in inode_cgwb_move_to_attached
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Tue, Feb 28, 2023 at 4:45=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 21-02-23 21:09:23, Palash Oswal wrote:
> > Hello,
> > I found the following issue using syzkaller on:
> > HEAD commit : e60276b8c11ab4a8be23807bc67b04
> > 8cfb937dfa (v6.0.8)
> > git tree: stable
> >
> > C Reproducer : https://gist.github.com/oswalpalash/bed0eba75def3cdd34a2=
85428e9bcdc4
> > Kernel .config :
> > https://gist.github.com/oswalpalash/0962c70d774e5ec736a047bba917cecb
> >
> > Console log :
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: use-after-free in __list_del_entry_valid+0xf2/0x110
> > Read of size 8 at addr ffff8880273c4358 by task syz-executor.1/6475
>
> OK, so FAT inode was on writeback list (through inode->i_io_list) when
> being freed. This should be fixed by commit 4e3c51f4e805 ("fs: do not
> update freeing inode i_io_list"). Can you check please?
>
>                                                                 Honza
>

I have verified that the commit fixes the bug. Tested against v6.0.11
on the stable tree.
Thanks

> >
> > CPU: 0 PID: 6475 Comm: syz-executor.1 Not tainted 6.0.8-pasta #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0xcd/0x134
> >  print_report.cold+0xe5/0x63a
> >  kasan_report+0x8a/0x1b0
> >  __list_del_entry_valid+0xf2/0x110
> >  inode_cgwb_move_to_attached+0x2ee/0x4e0
> >  writeback_single_inode+0x3fa/0x510
> >  write_inode_now+0x16a/0x1e0
> >  blkdev_flush_mapping+0x168/0x220
> >  blkdev_put_whole+0xd1/0xf0
> >  blkdev_put+0x29b/0x700
> >  deactivate_locked_super+0x8c/0xf0
> >  deactivate_super+0xad/0xd0
> >  cleanup_mnt+0x347/0x4b0
> >  task_work_run+0xe0/0x1a0
> >  exit_to_user_mode_prepare+0x25d/0x270
> >  syscall_exit_to_user_mode+0x19/0x50
> >  do_syscall_64+0x42/0xb0
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f22bd29143b
> > Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6
> > e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffe505103b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f22bd29143b
> > RDX: 00007f22bd228a90 RSI: 000000000000000a RDI: 00007ffe50510480
> > RBP: 00007ffe50510480 R08: 00007f22bd2fba1f R09: 00007ffe50510240
> > R10: 00000000fffffffb R11: 0000000000000246 R12: 00007f22bd2fb9f8
> > R13: 00007ffe50511520 R14: 0000555556f4bd90 R15: 0000000000000032
> >  </TASK>
> >
> > Allocated by task 7810:
> >  kasan_save_stack+0x1e/0x40
> >  __kasan_slab_alloc+0x85/0xb0
> >  kmem_cache_alloc_lru+0x25b/0xfb0
> >  fat_alloc_inode+0x23/0x1e0
> >  alloc_inode+0x61/0x1e0
> >  new_inode_pseudo+0x13/0x80
> >  new_inode+0x1b/0x40
> >  fat_build_inode+0x146/0x2d0
> >  vfat_create+0x249/0x390
> >  lookup_open+0x10bc/0x1640
> >  path_openat+0xa42/0x2840
> >  do_filp_open+0x1ca/0x2a0
> >  do_sys_openat2+0x61b/0x990
> >  do_sys_open+0xc3/0x140
> >  do_syscall_64+0x35/0xb0
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > Freed by task 16:
> >  kasan_save_stack+0x1e/0x40
> >  kasan_set_track+0x21/0x30
> >  kasan_set_free_info+0x20/0x30
> >  __kasan_slab_free+0xf5/0x180
> >  kmem_cache_free.part.0+0xfc/0x4a0
> >  i_callback+0x3f/0x70
> >  rcu_core+0x785/0x1720
> >  __do_softirq+0x1d0/0x908
> >
> > Last potentially related work creation:
> >  kasan_save_stack+0x1e/0x40
> >  __kasan_record_aux_stack+0x7e/0x90
> >  call_rcu+0x99/0x740
> >  destroy_inode+0x129/0x1b0
> >  iput.part.0+0x5cd/0x800
> >  iput+0x58/0x70
> >  dentry_unlink_inode+0x2e2/0x4a0
> >  __dentry_kill+0x374/0x5e0
> >  dput+0x656/0xbe0
> >  __fput+0x3cc/0xa90
> >  task_work_run+0xe0/0x1a0
> >  exit_to_user_mode_prepare+0x25d/0x270
> >  syscall_exit_to_user_mode+0x19/0x50
> >  do_syscall_64+0x42/0xb0
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > The buggy address belongs to the object at ffff8880273c4080
> >  which belongs to the cache fat_inode_cache of size 1488
> > The buggy address is located 728 bytes inside of
> >  1488-byte region [ffff8880273c4080, ffff8880273c4650)
> >
> > The buggy address belongs to the physical page:
> > page:ffffea00009cf100 refcount:1 mapcount:0 mapping:0000000000000000
> > index:0xffff8880273c4ffe pfn:0x273c4
> > flags: 0xfff00000000200(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > raw: 00fff00000000200 ffffea00009cf0c8 ffff88801820e450 ffff888103e00e0=
0
> > raw: ffff8880273c4ffe ffff8880273c4080 0000000100000002 000000000000000=
0
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Reclaimable, gfp_mask
> > 0x242050(__GFP_IO|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE|__GFP_RECLAIMA=
BLE),
> > pid 7810, tgid 7808 (syz-executor.1), ts 50543388569, free_ts
> > 21285403579
> >  prep_new_page+0x2c6/0x350
> >  get_page_from_freelist+0xae9/0x3a80
> >  __alloc_pages+0x321/0x710
> >  cache_grow_begin+0x75/0x360
> >  kmem_cache_alloc_lru+0xe72/0xfb0
> >  fat_alloc_inode+0x23/0x1e0
> >  alloc_inode+0x61/0x1e0
> >  new_inode_pseudo+0x13/0x80
> >  new_inode+0x1b/0x40
> >  fat_fill_super+0x1c37/0x3710
> >  mount_bdev+0x34d/0x410
> >  legacy_get_tree+0x105/0x220
> >  vfs_get_tree+0x89/0x2f0
> >  path_mount+0x121b/0x1cb0
> >  do_mount+0xf3/0x110
> >  __x64_sys_mount+0x18f/0x230
> > page last free stack trace:
> >  free_pcp_prepare+0x5ab/0xd00
> >  free_unref_page+0x19/0x410
> >  slab_destroy+0x14/0x50
> >  slabs_destroy+0x6a/0x90
> >  ___cache_free+0x1e3/0x3b0
> >  qlist_free_all+0x51/0x1c0
> >  kasan_quarantine_reduce+0x13d/0x180
> >  __kasan_slab_alloc+0x97/0xb0
> >  kmem_cache_alloc+0x204/0xcc0
> >  getname_flags+0xd2/0x5b0
> >  vfs_fstatat+0x73/0xb0
> >  __do_sys_newlstat+0x8b/0x110
> >  do_syscall_64+0x35/0xb0
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > Memory state around the buggy address:
> >  ffff8880273c4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8880273c4280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff8880273c4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                     ^
> >  ffff8880273c4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8880273c4400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
