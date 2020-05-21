Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD81DC477
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 03:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgEUBMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 21:12:21 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48321 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgEUBMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 21:12:19 -0400
Received: by mail-io1-f69.google.com with SMTP id c15so3555181iom.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 18:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=h/j6wGDGkA5f0OpUNBT2fc6Kw0541ZjHnj629UyszkE=;
        b=c0mSIuq2Ye5TwYSmbL1Cmf0KOzrZT09FmoZd0M+U1GVvNm+7BAn14sG+7RPOj/IPvE
         qFIP49L+ujGNxOLZIFmU/2HLhy7D0h+VLcRt1s07UbXSg+s4FePMcGGc93s6twQLp5xB
         xooXQ48F7oPrp1FhjrU57YJvb7RhYZ5LurLx/5LKSTM0Gr8rSPKAlJMJRjeTjcVXBjNp
         mpUAsqxMEB89RStPYh/8RKIYCnV4Ktv9G8vvRNUgUzQZW3BVOfb2ODlsAYeV56ICRwCB
         kR3GXk9auOEndaK3hA+0b8+1NAVz8S3Om1vGXfbjQoBJcH4T9cc+PoIoFYq4riIeb7VV
         jr8g==
X-Gm-Message-State: AOAM532IYDLJyDdQy9FR4P3TXcqgPOB4K63n9QJb6gsEqkGM15cHg6ga
        8VojsgiMTu8Tzlf1bKCybHHsKWDJ7y9JhZP62Ye3o9sRRySt
X-Google-Smtp-Source: ABdhPJyOjchKzarFV0Phiwdbzhuhy+0JRjUwdIIfTpsgXO57OEYaks2BV8xLQH3h769qm6iu1ciqsnmPU5pz+Za9ON750NhH3F3z
MIME-Version: 1.0
X-Received: by 2002:a92:2ca:: with SMTP id 193mr6088947ilc.35.1590023537140;
 Wed, 20 May 2020 18:12:17 -0700 (PDT)
Date:   Wed, 20 May 2020 18:12:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001daa8d05a61e3440@google.com>
Subject: memory leak in do_eventfd
From:   syzbot <syzbot+f196caa45793d6374707@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5a9ffb95 Merge tag '5.7-rc5-smb3-fixes' of git://git.samba..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b72a02100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8295ae5b3f8268d
dashboard link: https://syzkaller.appspot.com/bug?extid=f196caa45793d6374707
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17585b76100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12500a02100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f196caa45793d6374707@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888117169ac0 (size 64):
  comm "syz-executor012", pid 6609, jiffies 4294942172 (age 13.720s)
  hex dump (first 32 bytes):
    01 00 00 00 ff ff ff ff 00 00 00 00 00 c9 ff ff  ................
    d0 9a 16 17 81 88 ff ff d0 9a 16 17 81 88 ff ff  ................
  backtrace:
    [<00000000351bb234>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000351bb234>] do_eventfd+0x35/0xf0 fs/eventfd.c:418
    [<00000000c2f69a77>] __do_sys_eventfd fs/eventfd.c:443 [inline]
    [<00000000c2f69a77>] __se_sys_eventfd fs/eventfd.c:441 [inline]
    [<00000000c2f69a77>] __x64_sys_eventfd+0x14/0x20 fs/eventfd.c:441
    [<0000000086d6f989>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<000000006c5bcb63>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888117169100 (size 64):
  comm "syz-executor012", pid 6609, jiffies 4294942172 (age 13.720s)
  hex dump (first 32 bytes):
    e8 99 dd 00 00 c9 ff ff e8 99 dd 00 00 c9 ff ff  ................
    00 00 00 20 00 00 00 00 00 00 00 00 00 00 00 00  ... ............
  backtrace:
    [<00000000436d2955>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000436d2955>] kzalloc include/linux/slab.h:669 [inline]
    [<00000000436d2955>] kvm_assign_ioeventfd_idx+0x4f/0x270 arch/x86/kvm/../../../virt/kvm/eventfd.c:798
    [<00000000e89390cc>] kvm_assign_ioeventfd arch/x86/kvm/../../../virt/kvm/eventfd.c:934 [inline]
    [<00000000e89390cc>] kvm_ioeventfd+0xbb/0x194 arch/x86/kvm/../../../virt/kvm/eventfd.c:961
    [<00000000ba9f6732>] kvm_vm_ioctl+0x1e6/0x1030 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3670
    [<000000005da94937>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<000000005da94937>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:771
    [<00000000a583d097>] __do_sys_ioctl fs/ioctl.c:780 [inline]
    [<00000000a583d097>] __se_sys_ioctl fs/ioctl.c:778 [inline]
    [<00000000a583d097>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:778
    [<0000000086d6f989>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<000000006c5bcb63>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
