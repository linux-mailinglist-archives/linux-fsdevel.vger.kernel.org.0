Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21BFCAFB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 21:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbfJCT7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 15:59:18 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50482 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbfJCT7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:59:09 -0400
Received: by mail-io1-f71.google.com with SMTP id f5so6992282iob.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 12:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nk67c/1XiJvvCr7lH+tigw1xQQrdQdPfq1HiTbDZaP4=;
        b=nxsORn7VxMyIiUMxW+Ff8C/enPpd47qZ8NqGVPSg//MYvsPVc/Et/z2x0xkmYZrbDL
         55rMU/AJJXxjeDjk5sVgKaCig7RB8SoYYywVdLqRQ8PE5hiYo7ALh8zC2uh4Vj7/Bslt
         j7E+KYipfiZmE7QNKGMN7gADeh3ejIVqznLartuh+BVAKcOvE8UjOWptIjBsRfi3u49M
         EdquWF44Pb9PUMppwoob7VKh0AphPmULkhsnHDCDzSHiv4Y1imBtb2vuD0oeyNiQfxcx
         jvHuuiMLeVb00Rkx9nXjWGORT0DRCKX8n1+RVVBgeRN6R4mx/UjisllHceRIb9o2IL8O
         ODkQ==
X-Gm-Message-State: APjAAAX1achwQa2KV+4m37S5+sjOBqOobOEql4i51Ria8YEqGNi+BYxi
        8LbAj6lfuXrXOsBb/dgkOQifnh+7gvko+tJMbT7nglKvR+hw
X-Google-Smtp-Source: APXvYqxpmYR8n+dwXhic99PAr7TYlnMq5Xw2s/VJa9GyNPCBnJzeka7e9ZM9i1qfEyI7/lXL4/DDP4KTn5v5ssVj8x1DLllVE1o9
MIME-Version: 1.0
X-Received: by 2002:a92:60b:: with SMTP id x11mr11449655ilg.212.1570132748783;
 Thu, 03 Oct 2019 12:59:08 -0700 (PDT)
Date:   Thu, 03 Oct 2019 12:59:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdee330594070441@google.com>
Subject: memory leak in cap_inode_getsecurity
From:   syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0f1a7b3f timer-of: don't use conditional expression with m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1329640d600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d66badf12ef344c
dashboard link: https://syzkaller.appspot.com/bug?extid=942d5390db2d9624ced8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1107b513600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com

2019/10/03 14:00:37 executed programs: 36
2019/10/03 14:00:43 executed programs: 44
2019/10/03 14:00:49 executed programs: 63
BUG: memory leak
unreferenced object 0xffff8881202cb480 (size 32):
   comm "syz-executor.0", pid 7246, jiffies 4294946879 (age 14.010s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a8379648>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000a8379648>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000a8379648>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000a8379648>] __do_kmalloc mm/slab.c:3653 [inline]
     [<00000000a8379648>] __kmalloc_track_caller+0x165/0x300 mm/slab.c:3670
     [<000000008858463c>] __do_krealloc mm/slab_common.c:1638 [inline]
     [<000000008858463c>] krealloc+0x7f/0xb0 mm/slab_common.c:1689
     [<0000000057f9eb8e>] vfs_getxattr_alloc+0x100/0x180 fs/xattr.c:289
     [<00000000c2154e30>] cap_inode_getsecurity+0x9c/0x2c0  
security/commoncap.c:389
     [<00000000b2664a09>] security_inode_getsecurity+0x4c/0x90  
security/security.c:1314
     [<00000000921624c0>] xattr_getsecurity fs/xattr.c:244 [inline]
     [<00000000921624c0>] vfs_getxattr+0xf2/0x1a0 fs/xattr.c:332
     [<000000001ff6977b>] getxattr+0x97/0x240 fs/xattr.c:538
     [<00000000b945681f>] path_getxattr+0x6b/0xc0 fs/xattr.c:566
     [<000000001a9d3fce>] __do_sys_getxattr fs/xattr.c:578 [inline]
     [<000000001a9d3fce>] __se_sys_getxattr fs/xattr.c:575 [inline]
     [<000000001a9d3fce>] __x64_sys_getxattr+0x28/0x30 fs/xattr.c:575
     [<000000002e998337>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000f252aa21>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
