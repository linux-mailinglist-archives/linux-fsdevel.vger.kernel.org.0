Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA263E98E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 07:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLAGDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 01:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLAGDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:03:41 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4CA9AE0A
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 22:03:40 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z15-20020a5e860f000000b006c09237cc06so715149ioj.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 22:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wW/1YFjNuWJqMOaVAW1RF7mU8QRa/BBJWE/WkYjZiWI=;
        b=1+KQn5WxTWQCXFrKoM2DY3JNwW2eE4t6Tw0qFVfMmQ8vMkxBtnbE3mb7Ef9c8cqhSE
         2bIgv5seYYRg7T1bQ+R+esVy3HJ9U2uk1NbcLMqSf3cdPtXDPdyLvB/drrHfW/tARNGj
         VeOjuGdsMFqeIC07ohcrbZWMnzAPjBtOhmph+ZAqtgM8iiHQeijE/B7uEWy75lwDxCpz
         3QwIN+kWeLtTpnBOn6OT7NADHrmK6JGPnQjWpHSJ8lkBJ1kHLlMcds4BSC/CvhmL1eoX
         TxWTYvu/Y0wu3pLHhAHRSPjOVqoeH32QWwcz/ZgwKhbi0guLmemIQ+nZIJ+OmzbjgKB+
         UpeQ==
X-Gm-Message-State: ANoB5pmgT1lMSRojolZc9uE162Uf+/O2KYKq2Zyi2x+qN1ZIKklURZdj
        gSdlpbLRc+yJDNNflVGghJff6rmtjWnlGZ9C0QT6gRNEVEeS
X-Google-Smtp-Source: AA0mqf7HkgEI5yQHduZ6SroHYd5tfoigh4aq/StabWuoQy7E50ivoM862JacjkAoJzgXvE5icymt8EzS1MXKcPjhbpk5EGMXmtfk
MIME-Version: 1.0
X-Received: by 2002:a92:c10f:0:b0:303:1f6a:b30c with SMTP id
 p15-20020a92c10f000000b003031f6ab30cmr6045067ile.254.1669874619783; Wed, 30
 Nov 2022 22:03:39 -0800 (PST)
Date:   Wed, 30 Nov 2022 22:03:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008821e805eebdfb07@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in kvmalloc_node
From:   syzbot <syzbot+11f0fdbd79dbdfdc5984@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1052b24b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=11f0fdbd79dbdfdc5984
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f9193d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155d363d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2bf7bb4ee195/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11f0fdbd79dbdfdc5984@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 00616161616161a1
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[00616161616161a1] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:

CPU: 0 PID: 3083 Comm: udevd Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kmem_cache_alloc_node+0x17c/0x350 mm/slub.c:3437
lr : slab_pre_alloc_hook mm/slab.h:712 [inline]
lr : slab_alloc_node mm/slub.c:3318 [inline]
lr : __kmem_cache_alloc_node+0x80/0x350 mm/slub.c:3437
sp : ffff80000fee3890
x29: ffff80000fee38a0
 x28: ffff0000c5718000 x27: ffff80000cf6f4f0
x26: ffff80000fee3a10 x25: 00000000ffffffff x24: ffff8000084360d4
x23: 0000000000000021 x22: 6161616161616161 x21: 0000000000000000
x20: 0000000000000cc0 x19: ffff0000c0001200 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000dbe6158 x15: ffff0000c5718000
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000c5718000
x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000040
x8 : 00000000000ae251 x7 : ffff8000084bf248 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 00000000000ae259
x2 : 0000000000000000 x1 : 0000000000000cc0 x0 : fffffc00032c8dc0
Call trace:
 next_tid mm/slub.c:2349 [inline]
 slab_alloc_node mm/slub.c:3382 [inline]
 __kmem_cache_alloc_node+0x17c/0x350 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc_node+0xbc/0x14c mm/slab_common.c:962
 kmalloc_node include/linux/slab.h:579 [inline]
 kvmalloc_node+0x84/0x1a4 mm/util.c:581
 kvmalloc include/linux/slab.h:706 [inline]
 simple_xattr_alloc+0x50/0x90 fs/xattr.c:1008
 shmem_initxattrs+0x44/0xf0 mm/shmem.c:3258
 security_inode_init_security+0x208/0x278 security/security.c:1119
 shmem_mknod+0xa0/0x13c mm/shmem.c:2915
 shmem_create+0x40/0x54 mm/shmem.c:2974
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3710
 do_filp_open+0xdc/0x1b8 fs/namei.c:3740
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 54000ee1 34000eeb b9402a69 91002103 (f8696ada) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	54000ee1 	b.ne	0x1dc  // b.any
   4:	34000eeb 	cbz	w11, 0x1e0
   8:	b9402a69 	ldr	w9, [x19, #40]
   c:	91002103 	add	x3, x8, #0x8
* 10:	f8696ada 	ldr	x26, [x22, x9] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
