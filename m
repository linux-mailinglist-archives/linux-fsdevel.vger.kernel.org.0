Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8D73ACA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 00:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjFVWkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 18:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjFVWkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:40:02 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911EE1981
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 15:40:00 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77a0fd9d2eeso704842339f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 15:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687473600; x=1690065600;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbXwbc/DNJv21gmJh+eUzAbfweRF/Sji7X39qvzlZMg=;
        b=BeR5Ej+FHPdwHL1r7r8jzYEOXRuFcQuQ5cTfxjMHETwL6L2xI0cQszyOIPPfP/MVYa
         V/wnJ7geUSGNvTAVgg+CWUnA0fOqG5pkLxOl3c2X84eZgAbp0YhoGUwN5Mc0VLRDWPKE
         RaXCYOz1sY87Z4aU/N9Vlsa5n0qqP0j0siuVTcWg/49m0C8p58TCcbgD9f8XtfIj/cUD
         5p2OmmbMubA8TuM0gdK9AO8c9mpMVnyY7HuAcGCgMxe6JmxJUwEjq060wUC0kktapQ84
         RTfDNddIDx7S/25XSQOYGNvvqmsYS+hI4fdHko44hE+md3aWwypKv8nvnBhLCtPzf7Pt
         JKaQ==
X-Gm-Message-State: AC+VfDwtBG2lyCgqKWz5NQRbajQVN2a7+gchbe2qNaQku3q4C8rnimSW
        NNsBe2a56brqtGRYeuYJghsNER8mO2/eTf9iZTQi87FE5pLG
X-Google-Smtp-Source: ACHHUZ56rTEe1PI+50YECuv9tI3ImZ3C+TTBU+xkC6Jqb6YaaTQfSHb0TpkMowdi6POddJiJDwYDE2/yCPB4AM3Da+zfyDeW9Ucs
MIME-Version: 1.0
X-Received: by 2002:a5d:949a:0:b0:780:bfc8:ad12 with SMTP id
 v26-20020a5d949a000000b00780bfc8ad12mr1634392ioj.1.1687473599868; Thu, 22 Jun
 2023 15:39:59 -0700 (PDT)
Date:   Thu, 22 Jun 2023 15:39:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cfb2405febf9023@google.com>
Subject: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in attr_data_read_resident
From:   syzbot <syzbot+33a67f9990381cc8951c@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    177239177378 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10bfc2df280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8776b67768a3c9af
dashboard link: https://syzkaller.appspot.com/bug?extid=33a67f9990381cc8951c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139cebf7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cc2187280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c47a40dd633/disk-17723917.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ff319b6fb50/vmlinux-17723917.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ce1ea9e3b7e/Image-17723917.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/795c34a0a0d9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33a67f9990381cc8951c@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5970 'syz-executor312'
loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 5970 Comm: syz-executor312 Not tainted 6.4.0-rc5-syzkaller-g177239177378 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : attr_data_read_resident+0xb0/0x6c8 fs/ntfs3/attrib.c:1232
lr : attr_data_read_resident+0x8c/0x6c8 fs/ntfs3/attrib.c:1229
sp : ffff800096ba7620
x29: ffff800096ba7620 x28: 1ffff00012d74ee8 x27: ffff800096ba7740
x26: dfff800000000000 x25: ffff800096ba7730 x24: dfff800000000000
x23: ffff0000e05c7600 x22: 1ffff00012d74ee6 x21: 0000000000000020
x20: ffff0000c7576108 x19: 0000000000000000 x18: ffff800096ba7160
x17: 0000000000000001 x16: ffff80008026c4e4 x15: 000000000000be43
x14: 00000000ffffffff x13: dfff800000000000 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000004 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000080 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 attr_data_read_resident+0xb0/0x6c8 fs/ntfs3/attrib.c:1232
 ntfs_get_block_vbo+0x2b0/0xc14 fs/ntfs3/inode.c:572
 ntfs_get_block_bmap+0xa0/0xe0 fs/ntfs3/inode.c:686
 generic_block_bmap+0x11c/0x1bc fs/buffer.c:2718
 ntfs_bmap+0x30/0x40 fs/ntfs3/inode.c:693
 bmap+0xa8/0xe8 fs/inode.c:1798
 ioctl_fibmap fs/ioctl.c:77 [inline]
 file_ioctl fs/ioctl.c:327 [inline]
 do_vfs_ioctl+0x1eb0/0x26f8 fs/ioctl.c:849
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xe4/0x1c8 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 128002a0 1400011a 91008275 d343fea8 (38786908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	128002a0 	mov	w0, #0xffffffea            	// #-22
   4:	1400011a 	b	0x46c
   8:	91008275 	add	x21, x19, #0x20
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	38786908 	ldrb	w8, [x8, x24] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
