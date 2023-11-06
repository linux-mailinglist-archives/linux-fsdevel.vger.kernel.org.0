Return-Path: <linux-fsdevel+bounces-2154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8237E2B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6C1C20CB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0E32C85C;
	Mon,  6 Nov 2023 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785102C851
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:58:32 +0000 (UTC)
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5351FD4C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 09:58:30 -0800 (PST)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1eb83f1d150so6306518fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 09:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293509; x=1699898309;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEwpAGHL4EI/McPACelobvea5qiK1E1BuwDNpbN5Cvw=;
        b=ohmG9/T90mgmYy8sBNh7fh3r9J+GctxigoAkyVF7oJf7uD8al9NpFvj6FcMuGB3kJF
         c6KlZerV/V8RRn1O526dtfBRficb/ats6fex46aGo1oKqcqVl05GRk9H7AKyOpuFAkAk
         a5GTTnyYAkYkmmvUNoDwBRg+nbDCh2/VDJWo73GmBVK1z57S7y+E0GT/2IHyeRgD2FRM
         0bGViNb/fKc46dNWHIpQo2TPwI6QqYvhkRUbRRcFFN3CfPVgQqv2nnD/0xuHQ01l0oym
         4mW6ylJ6OmZZ8CSIsTf5hcUTZ71uSxxV2nqSMyTJr7wyz/0ldIT6B3fiSylwqwlNtCHv
         z/bw==
X-Gm-Message-State: AOJu0YwCQsgjeb4U1pRF1VAOj/o33nntk28avm2oAhGwXMSuZdNBO7dE
	bsfpmpOa7SlcLmHVBKQXSRC0gzzKJ6InntQZxTF3HjXvsTPB
X-Google-Smtp-Source: AGHT+IFVdGyGw4V9NalCvcwOQMO5/jv1/gIhFzEs+6lpVCpt8jlug0h41Tj+reKtxIf2znLbcFPCjtySt2mvQ6TIbz6QBKuzPlFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9a19:b0:1dd:1837:c704 with SMTP id
 fo25-20020a0568709a1900b001dd1837c704mr226202oab.2.1699293509742; Mon, 06 Nov
 2023 09:58:29 -0800 (PST)
Date: Mon, 06 Nov 2023 09:58:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004769106097f9a34@google.com>
Subject: [syzbot] [btrfs?] memory leak in btrfs_add_delayed_tree_ref
From: syzbot <syzbot+d3ddc6dcc6386dea398b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6f76a6a29f Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15169b87680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ea2285f517f94d0
dashboard link: https://syzkaller.appspot.com/bug?extid=d3ddc6dcc6386dea398b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179c2ecf680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149dff40e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dfead0cc157b/disk-8f6f76a6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2ab876430bc/vmlinux-8f6f76a6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9cd314888e8/bzImage-8f6f76a6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4a497ff0ef1a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3ddc6dcc6386dea398b@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810891e940 (size 64):
  comm "syz-executor244", pid 5031, jiffies 4294941874 (age 13.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 e0 51 00 00 00 00 00  ..........Q.....
  backtrace:
    [<ffffffff816336ad>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816336ad>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816336ad>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816336ad>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e505>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff82135480>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82135480>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82135480>] btrfs_add_delayed_tree_ref+0x550/0x5b0 fs/btrfs/delayed-ref.c:1045
    [<ffffffff820874bb>] btrfs_alloc_tree_block+0x65b/0x7c0 fs/btrfs/extent-tree.c:5153
    [<ffffffff8206c15e>] btrfs_force_cow_block+0x1be/0xb30 fs/btrfs/ctree.c:563
    [<ffffffff8206cbf8>] btrfs_cow_block+0x128/0x3b0 fs/btrfs/ctree.c:741
    [<ffffffff82073609>] btrfs_search_slot+0xa49/0x1770 fs/btrfs/ctree.c:2095
    [<ffffffff82074fa3>] btrfs_insert_empty_items+0x43/0xc0 fs/btrfs/ctree.c:4285
    [<ffffffff820b8a34>] btrfs_create_new_inode+0x354/0xfe0 fs/btrfs/inode.c:6283
    [<ffffffff820b99e7>] btrfs_create_common+0xf7/0x190 fs/btrfs/inode.c:6511
    [<ffffffff820b9c12>] btrfs_create+0x72/0x90 fs/btrfs/inode.c:6551
    [<ffffffff816b673f>] lookup_open fs/namei.c:3477 [inline]
    [<ffffffff816b673f>] open_last_lookups fs/namei.c:3546 [inline]
    [<ffffffff816b673f>] path_openat+0x17df/0x1d60 fs/namei.c:3776
    [<ffffffff816b78e1>] do_filp_open+0xd1/0x1c0 fs/namei.c:3809
    [<ffffffff816906c4>] do_sys_openat2+0xf4/0x150 fs/open.c:1440
    [<ffffffff81690ec5>] do_sys_open fs/open.c:1455 [inline]
    [<ffffffff81690ec5>] __do_sys_open fs/open.c:1463 [inline]
    [<ffffffff81690ec5>] __se_sys_open fs/open.c:1459 [inline]
    [<ffffffff81690ec5>] __x64_sys_open+0xa5/0xf0 fs/open.c:1459
    [<ffffffff84b5dd4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b5dd4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82

BUG: memory leak
unreferenced object 0xffff88810891e980 (size 64):
  comm "syz-executor244", pid 5031, jiffies 4294941874 (age 13.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 69 00 00 00 00 00  ..........i.....
  backtrace:
    [<ffffffff816336ad>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816336ad>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816336ad>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816336ad>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e505>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff82135480>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82135480>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82135480>] btrfs_add_delayed_tree_ref+0x550/0x5b0 fs/btrfs/delayed-ref.c:1045
    [<ffffffff82083f81>] btrfs_free_tree_block+0x131/0x450 fs/btrfs/extent-tree.c:3432
    [<ffffffff8206c678>] btrfs_force_cow_block+0x6d8/0xb30 fs/btrfs/ctree.c:618
    [<ffffffff8206cbf8>] btrfs_cow_block+0x128/0x3b0 fs/btrfs/ctree.c:741
    [<ffffffff82073609>] btrfs_search_slot+0xa49/0x1770 fs/btrfs/ctree.c:2095
    [<ffffffff82074fa3>] btrfs_insert_empty_items+0x43/0xc0 fs/btrfs/ctree.c:4285
    [<ffffffff820b8a34>] btrfs_create_new_inode+0x354/0xfe0 fs/btrfs/inode.c:6283
    [<ffffffff820b99e7>] btrfs_create_common+0xf7/0x190 fs/btrfs/inode.c:6511
    [<ffffffff820b9c12>] btrfs_create+0x72/0x90 fs/btrfs/inode.c:6551
    [<ffffffff816b673f>] lookup_open fs/namei.c:3477 [inline]
    [<ffffffff816b673f>] open_last_lookups fs/namei.c:3546 [inline]
    [<ffffffff816b673f>] path_openat+0x17df/0x1d60 fs/namei.c:3776
    [<ffffffff816b78e1>] do_filp_open+0xd1/0x1c0 fs/namei.c:3809
    [<ffffffff816906c4>] do_sys_openat2+0xf4/0x150 fs/open.c:1440
    [<ffffffff81690ec5>] do_sys_open fs/open.c:1455 [inline]
    [<ffffffff81690ec5>] __do_sys_open fs/open.c:1463 [inline]
    [<ffffffff81690ec5>] __se_sys_open fs/open.c:1459 [inline]
    [<ffffffff81690ec5>] __x64_sys_open+0xa5/0xf0 fs/open.c:1459
    [<ffffffff84b5dd4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b5dd4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82

BUG: memory leak
unreferenced object 0xffff88810891ea00 (size 64):
  comm "syz-executor244", pid 5031, jiffies 4294941874 (age 13.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 f0 51 00 00 00 00 00  ..........Q.....
  backtrace:
    [<ffffffff816336ad>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816336ad>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816336ad>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816336ad>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e505>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff82135480>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82135480>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82135480>] btrfs_add_delayed_tree_ref+0x550/0x5b0 fs/btrfs/delayed-ref.c:1045
    [<ffffffff820874bb>] btrfs_alloc_tree_block+0x65b/0x7c0 fs/btrfs/extent-tree.c:5153
    [<ffffffff8206c15e>] btrfs_force_cow_block+0x1be/0xb30 fs/btrfs/ctree.c:563
    [<ffffffff8206cbf8>] btrfs_cow_block+0x128/0x3b0 fs/btrfs/ctree.c:741
    [<ffffffff82073609>] btrfs_search_slot+0xa49/0x1770 fs/btrfs/ctree.c:2095
    [<ffffffff82074fa3>] btrfs_insert_empty_items+0x43/0xc0 fs/btrfs/ctree.c:4285
    [<ffffffff820b8a34>] btrfs_create_new_inode+0x354/0xfe0 fs/btrfs/inode.c:6283
    [<ffffffff820b99e7>] btrfs_create_common+0xf7/0x190 fs/btrfs/inode.c:6511
    [<ffffffff820b9c12>] btrfs_create+0x72/0x90 fs/btrfs/inode.c:6551
    [<ffffffff816b673f>] lookup_open fs/namei.c:3477 [inline]
    [<ffffffff816b673f>] open_last_lookups fs/namei.c:3546 [inline]
    [<ffffffff816b673f>] path_openat+0x17df/0x1d60 fs/namei.c:3776
    [<ffffffff816b78e1>] do_filp_open+0xd1/0x1c0 fs/namei.c:3809
    [<ffffffff816906c4>] do_sys_openat2+0xf4/0x150 fs/open.c:1440
    [<ffffffff81690ec5>] do_sys_open fs/open.c:1455 [inline]
    [<ffffffff81690ec5>] __do_sys_open fs/open.c:1463 [inline]
    [<ffffffff81690ec5>] __se_sys_open fs/open.c:1459 [inline]
    [<ffffffff81690ec5>] __x64_sys_open+0xa5/0xf0 fs/open.c:1459
    [<ffffffff84b5dd4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b5dd4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

