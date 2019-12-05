Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC9114243
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfLEOFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 09:05:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:44286 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfLEOFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:05:09 -0500
Received: by mail-il1-f199.google.com with SMTP id h87so2533982ild.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 06:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ss9QHvh6bNQSlbXU02gGCYN6VqUC/dATBxQ+4sZH7oc=;
        b=s/iUJ2VK7JaxPZRPbxysSLyRbjIllv6CAt/4SHwetm3FEVFtLxAZipJ6hDShQL57Nk
         EqgtPZZDh4ucosvMSdamwvjNj3Q/Re480k6MNk17dZowGFkYCU1fd3ug99uMBxTC2sVQ
         tuqDmNjR8eCdOSwlW/50nOBIGT6W2YcD6LgLYFksLCWuWoYBUo3OVh/4/qv3+W0xb2rE
         BJLJMIkaeDJz48r3+pf5ZaW9IuwWNtZP4am8/UefwOBhdxH20ev3B0D16YbeqgndUJIM
         C5f5ozhLahdox2p7k78KALHDnTLmG4ufg+VG8K9y5iZnPG0+/y/j93Nthmwyiksg3agI
         iglw==
X-Gm-Message-State: APjAAAVo8rNL/5sONvX9SY9+8O92RN4ilWYKcgoQh4ZkIKh2pWNizOKa
        SaBD8AIV85cD3m46LtKhayzQrG88/1Ryqyy8tgomQH1lUXWl
X-Google-Smtp-Source: APXvYqzVaAAEEkwExztMrYcWCc1C1sJMjFL6MkBBIp2KgIrn26dGmAA5uVGtmZfxuWphL3t1GILMa+cLy3Zx30WuI8vDJAJvNYI3
MIME-Version: 1.0
X-Received: by 2002:a92:178f:: with SMTP id 15mr8567561ilx.219.1575554708963;
 Thu, 05 Dec 2019 06:05:08 -0800 (PST)
Date:   Thu, 05 Dec 2019 06:05:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c091a20598f56a5a@google.com>
Subject: KASAN: slab-out-of-bounds Read in iov_iter_alignment
From:   syzbot <syzbot+0d37f4d2070ce20b19a7@syzkaller.appspotmail.com>
To:     darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1604be0ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
dashboard link: https://syzkaller.appspot.com/bug?extid=0d37f4d2070ce20b19a7
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b4ce96e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17310abce00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0d37f4d2070ce20b19a7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in iov_iter_alignment+0x6a1/0x7b0  
lib/iov_iter.c:1225
Read of size 4 at addr ffff8880a34b2f44 by task syz-executor324/8130

CPU: 0 PID: 8130 Comm: syz-executor324 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1fb/0x318 lib/dump_stack.c:118
  print_address_description+0x75/0x5c0 mm/kasan/report.c:374
  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:506
  kasan_report+0x26/0x50 mm/kasan/common.c:634
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:131
  iov_iter_alignment+0x6a1/0x7b0 lib/iov_iter.c:1225
  iomap_dio_bio_actor+0x1a7/0x11e0 fs/iomap/direct-io.c:203
  iomap_dio_actor+0x2b4/0x4a0 fs/iomap/direct-io.c:375
  iomap_apply+0x370/0x490 fs/iomap/apply.c:80
  iomap_dio_rw+0x8ad/0x1010 fs/iomap/direct-io.c:493
  ext4_dio_write_iter fs/ext4/file.c:438 [inline]
  ext4_file_write_iter+0x15a4/0x1f50 fs/ext4/file.c:545
  do_iter_readv_writev+0x651/0x8e0 include/linux/fs.h:1889
  do_iter_write+0x180/0x590 fs/read_write.c:970
  vfs_iter_write+0x7c/0xa0 fs/read_write.c:983
  iter_file_splice_write+0x703/0xe40 fs/splice.c:758
  do_splice_from fs/splice.c:861 [inline]
  direct_splice_actor+0xf7/0x130 fs/splice.c:1035
  splice_direct_to_actor+0x4d2/0xb90 fs/splice.c:990
  do_splice_direct+0x200/0x330 fs/splice.c:1078
  do_sendfile+0x7e4/0xfd0 fs/read_write.c:1464
  __do_sys_sendfile64 fs/read_write.c:1525 [inline]
  __se_sys_sendfile64 fs/read_write.c:1511 [inline]
  __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1511
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4467a9
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c47965da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006dbc58 RCX: 00000000004467a9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000006
RBP: 00000000006dbc50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 0000000020000800 R14: 00000000004ae6c8 R15: 20c49ba5e353f7cf

Allocated by task 8130:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc+0x11c/0x1b0 mm/kasan/common.c:510
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  __do_kmalloc mm/slab.c:3655 [inline]
  __kmalloc+0x254/0x340 mm/slab.c:3664
  kmalloc_array+0x32/0x60 include/linux/slab.h:618
  kcalloc include/linux/slab.h:629 [inline]
  iter_file_splice_write+0x15f/0xe40 fs/splice.c:702
  do_splice_from fs/splice.c:861 [inline]
  direct_splice_actor+0xf7/0x130 fs/splice.c:1035
  splice_direct_to_actor+0x4d2/0xb90 fs/splice.c:990
  do_splice_direct+0x200/0x330 fs/splice.c:1078
  do_sendfile+0x7e4/0xfd0 fs/read_write.c:1464
  __do_sys_sendfile64 fs/read_write.c:1525 [inline]
  __se_sys_sendfile64 fs/read_write.c:1511 [inline]
  __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1511
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4124:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x12a/0x1e0 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x115/0x200 mm/slab.c:3756
  smk_fetch security/smack/smack_lsm.c:302 [inline]
  smack_d_instantiate+0x7bb/0xd70 security/smack/smack_lsm.c:3416
  security_d_instantiate+0xa5/0x100 security/security.c:1874
  d_instantiate+0x55/0x90 fs/dcache.c:1952
  shmem_mknod+0x178/0x1c0 mm/shmem.c:2893
  shmem_create+0x2b/0x40 mm/shmem.c:2939
  lookup_open fs/namei.c:3228 [inline]
  do_last fs/namei.c:3318 [inline]
  path_openat+0x2236/0x44a0 fs/namei.c:3529
  do_filp_open+0x192/0x3d0 fs/namei.c:3559
  do_sys_open+0x29f/0x560 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x87/0x90 fs/open.c:1110
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a34b2e00
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 68 bytes to the right of
  256-byte region [ffff8880a34b2e00, ffff8880a34b2f00)
The buggy address belongs to the page:
page:ffffea00028d2c80 refcount:1 mapcount:0 mapping:ffff8880aa4008c0  
index:0x0
raw: 00fffe0000000200 ffffea00028d2dc8 ffffea0002897dc8 ffff8880aa4008c0
raw: 0000000000000000 ffff8880a34b2000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a34b2e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8880a34b2e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8880a34b2f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                            ^
  ffff8880a34b2f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a34b3000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
