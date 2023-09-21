Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C627A9DE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjIUTu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjIUTul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:50:41 -0400
Received: from mail-qv1-f80.google.com (mail-qv1-f80.google.com [209.85.219.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5923B1A2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:34:55 -0700 (PDT)
Received: by mail-qv1-f80.google.com with SMTP id 6a1803df08f44-6562177e2fcso11736106d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321295; x=1695926095;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8QGzJrCYmfRoQWsGWPX3YB4TdmaJK4nkiaW/u7OvpQ=;
        b=gTUVRmXOooAbEZQtGbky/VL5U4yaZXUz5kGxm0s2mzXbXik2wdNKV3j1sYPCDunY/g
         sLBwmIjWhJy3wOql85DhGqPAcqJfXnHqZp30zZBzDRCsJRhm5DbgFDcXVlg+pUoQRvcG
         6Ranb5+tMpWgnlcqNhX4bOAgFAfa8se0f60suoySQVC9+PEL/fkMtL42utYcTe5hEEV7
         StMEo+HTR1l2VAB/2VcEKO+LJz2sU8zBORpWXs/uzDWw3q1mUe122sCWm1PM7+ellW7t
         4iCvrKSW7pp1UWn3/P0hIq1RkZgOjyDN7mquLnpqz4uSICISRGPpaD6EvdVzYKNeZkVg
         4AjQ==
X-Gm-Message-State: AOJu0YwtOHQirKC2hm96tIa7nUfFca0DRBKGFST0Nu6W3h0YnzeCHQZ4
        m6RzhKNrQsGjQVgm4Cqj5uYVVoWdzFDHB8y6Owk/qgUYbSUL
X-Google-Smtp-Source: AGHT+IFoyeGVbYSzKAxaDLyuyOwlz508qpLzWfyhPCZ3y9wOAy8KeYkmHzCKyH5GTD96J8br4EqL9ptVl+lVf8ueSyqZHoEldRjv
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b7a5:b0:1d6:6040:7c7 with SMTP id
 ed37-20020a056870b7a500b001d6604007c7mr1971375oab.9.1695279168613; Wed, 20
 Sep 2023 23:52:48 -0700 (PDT)
Date:   Wed, 20 Sep 2023 23:52:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3f3d40605d8f0f8@google.com>
Subject: [syzbot] [fs?] memory leak in fasync_helper (2)
From:   syzbot <syzbot+5f1acda7e06a2298fae6@syzkaller.appspotmail.com>
To:     brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f0b0d403eabb Merge tag 'kbuild-fixes-v6.6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e498c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=943a94479fa8e863
dashboard link: https://syzkaller.appspot.com/bug?extid=5f1acda7e06a2298fae6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161ac702680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16515418680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47695e593bcd/disk-f0b0d403.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/306f9aca0df9/vmlinux-f0b0d403.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25549b4deb42/bzImage-f0b0d403.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f1acda7e06a2298fae6@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888114ac69c0 (size 48):
  comm "syz-executor199", pid 5124, jiffies 4294947402 (age 21.830s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 81 0f 09 81 88 ff ff  ................
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114a7ecf0 (size 48):
  comm "syz-executor199", pid 5133, jiffies 4294947484 (age 21.010s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 21 ac 14 81 88 ff ff  .........!......
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114eec180 (size 48):
  comm "syz-executor199", pid 5138, jiffies 4294947529 (age 20.560s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 7a 51 09 81 88 ff ff  .........zQ.....
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114ac69c0 (size 48):
  comm "syz-executor199", pid 5124, jiffies 4294947402 (age 25.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 81 0f 09 81 88 ff ff  ................
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114a7ecf0 (size 48):
  comm "syz-executor199", pid 5133, jiffies 4294947484 (age 24.480s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 21 ac 14 81 88 ff ff  .........!......
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114eec180 (size 48):
  comm "syz-executor199", pid 5138, jiffies 4294947529 (age 24.030s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 7a 51 09 81 88 ff ff  .........zQ.....
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114ac69c0 (size 48):
  comm "syz-executor199", pid 5124, jiffies 4294947402 (age 26.490s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 81 0f 09 81 88 ff ff  ................
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114a7ecf0 (size 48):
  comm "syz-executor199", pid 5133, jiffies 4294947484 (age 25.670s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 21 ac 14 81 88 ff ff  .........!......
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114eec180 (size 48):
  comm "syz-executor199", pid 5138, jiffies 4294947529 (age 25.220s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 7a 51 09 81 88 ff ff  .........zQ.....
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881145bba00 (size 512):
  comm "kworker/0:4", pid 5093, jiffies 4294947640 (age 24.110s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 0b 25 86 ff ff ff ff  ..........%.....
    80 f7 54 12 81 88 ff ff c8 9b ff ff 00 00 00 00  ..T.............
  backtrace:
    [<ffffffff815744cb>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815744cb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff83ef17b2>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff83ef17b2>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83ef17b2>] neigh_alloc net/core/neighbour.c:486 [inline]
    [<ffffffff83ef17b2>] ___neigh_create+0xf2/0xe10 net/core/neighbour.c:640
    [<ffffffff8434480b>] ip6_finish_output2+0x73b/0x980 net/ipv6/ip6_output.c:126
    [<ffffffff84349c21>] __ip6_finish_output net/ipv6/ip6_output.c:196 [inline]
    [<ffffffff84349c21>] ip6_finish_output+0x291/0x510 net/ipv6/ip6_output.c:207
    [<ffffffff84349f41>] NF_HOOK_COND include/linux/netfilter.h:293 [inline]
    [<ffffffff84349f41>] ip6_output+0xa1/0x1c0 net/ipv6/ip6_output.c:228
    [<ffffffff84399fd9>] dst_output include/net/dst.h:458 [inline]
    [<ffffffff84399fd9>] NF_HOOK.constprop.0+0x49/0x110 include/linux/netfilter.h:304
    [<ffffffff8439a2c3>] mld_sendpack+0x223/0x350 net/ipv6/mcast.c:1818
    [<ffffffff8439add5>] mld_send_initial_cr.part.0.isra.0+0x75/0x80 net/ipv6/mcast.c:2237
    [<ffffffff8439dae9>] mld_send_initial_cr net/ipv6/mcast.c:2225 [inline]
    [<ffffffff8439dae9>] mld_dad_work+0x59/0x220 net/ipv6/mcast.c:2260
    [<ffffffff812c8edd>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c9a87>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c9a87>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6f5b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149e95>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff888114169600 (size 512):
  comm "kworker/1:7", pid 5101, jiffies 4294947640 (age 24.110s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 0b 25 86 ff ff ff ff  ..........%.....
    c0 99 e3 12 81 88 ff ff c8 9b ff ff 00 00 00 00  ................
  backtrace:
    [<ffffffff815744cb>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815744cb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff83ef17b2>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff83ef17b2>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83ef17b2>] neigh_alloc net/core/neighbour.c:486 [inline]
    [<ffffffff83ef17b2>] ___neigh_create+0xf2/0xe10 net/core/neighbour.c:640
    [<ffffffff8434480b>] ip6_finish_output2+0x73b/0x980 net/ipv6/ip6_output.c:126
    [<ffffffff84349c21>] __ip6_finish_output net/ipv6/ip6_output.c:196 [inline]
    [<ffffffff84349c21>] ip6_finish_output+0x291/0x510 net/ipv6/ip6_output.c:207
    [<ffffffff84349f41>] NF_HOOK_COND include/linux/netfilter.h:293 [inline]
    [<ffffffff84349f41>] ip6_output+0xa1/0x1c0 net/ipv6/ip6_output.c:228
    [<ffffffff843836f9>] dst_output include/net/dst.h:458 [inline]
    [<ffffffff843836f9>] NF_HOOK.constprop.0+0x49/0x110 include/linux/netfilter.h:304
    [<ffffffff84383a09>] ndisc_send_skb+0x249/0x3c0 net/ipv6/ndisc.c:509
    [<ffffffff843886e5>] ndisc_send_ns+0x85/0xf0 net/ipv6/ndisc.c:667
    [<ffffffff8435cd0e>] addrconf_dad_work+0x67e/0x980 net/ipv6/addrconf.c:4213
    [<ffffffff812c8edd>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c9a87>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c9a87>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6f5b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149e95>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff888114ac69c0 (size 48):
  comm "syz-executor199", pid 5124, jiffies 4294947402 (age 27.680s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 81 0f 09 81 88 ff ff  ................
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114a7ecf0 (size 48):
  comm "syz-executor199", pid 5133, jiffies 4294947484 (age 26.860s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 21 ac 14 81 88 ff ff  .........!......
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114eec180 (size 48):
  comm "syz-executor199", pid 5138, jiffies 4294947529 (age 26.410s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
    00 00 00 00 00 00 00 00 00 7a 51 09 81 88 ff ff  .........zQ.....
  backtrace:
    [<ffffffff816b06bd>] fasync_alloc fs/fcntl.c:892 [inline]
    [<ffffffff816b06bd>] fasync_add_entry fs/fcntl.c:950 [inline]
    [<ffffffff816b06bd>] fasync_helper+0x3d/0xc0 fs/fcntl.c:979
    [<ffffffff83e8f2cb>] sock_fasync+0x4b/0xa0 net/socket.c:1427
    [<ffffffff816b18d6>] ioctl_fioasync fs/ioctl.c:380 [inline]
    [<ffffffff816b18d6>] do_vfs_ioctl+0x306/0xe80 fs/ioctl.c:792
    [<ffffffff816b27d5>] __do_sys_ioctl fs/ioctl.c:869 [inline]
    [<ffffffff816b27d5>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b27d5>] __x64_sys_ioctl+0xb5/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881141b9600 (size 512):
  comm "kworker/1:7", pid 5101, jiffies 4294947640 (age 25.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 0b 25 86 ff ff ff ff  ..........%.....
    00 00 95 12 81 88 ff ff c8 9b ff ff 00 00 00 00  ................
  backtrace:
    [<ffffffff815744cb>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815744cb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff83ef17b2>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff83ef17b2>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83ef17b2>] neigh_alloc net/core/neighbour.c:486 [inline]
    [<ffffffff83ef17b2>] ___neigh_create+0xf2/0xe10 net/core/neighbour.c:640
    [<ffffffff8434480b>] ip6_finish_output2+0x73b/0x980 net/ipv6/ip6_output.c:126
    [<ffffffff84349c21>] __ip6_finish_output net/ipv6/ip6_output.c:196 [inline]
    [<ffffffff84349c21>] ip6_finish_output+0x291/0x510 net/ipv6/ip6_output.c:207
    [<ffffffff84349f41>] NF_HOOK_COND include/linux/netfilter.h:293 [inline]
    [<ffffffff84349f41>] ip6_output+0xa1/0x1c0 net/ipv6/ip6_output.c:228
    [<ffffffff84399fd9>] dst_output include/net/dst.h:458 [inline]
    [<ffffffff84399fd9>] NF_HOOK.constprop.0+0x49/0x110 include/linux/netfilter.h:304
    [<ffffffff8439a2c3>] mld_sendpack+0x223/0x350 net/ipv6/mcast.c:1818
    [<ffffffff8439add5>] mld_send_initial_cr.part.0.isra.0+0x75/0x80 net/ipv6/mcast.c:2237
    [<ffffffff843a16b9>] mld_send_initial_cr net/ipv6/mcast.c:2225 [inline]
    [<ffffffff843a16b9>] ipv6_mc_dad_complete+0x79/0x190 net/ipv6/mcast.c:2245
    [<ffffffff8435c4b1>] addrconf_dad_completed+0x4d1/0x6b0 net/ipv6/addrconf.c:4271
    [<ffffffff8435cac0>] addrconf_dad_work+0x430/0x980 net/ipv6/addrconf.c:4199
    [<ffffffff812c8edd>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c9a87>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c9a87>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6f5b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149e95>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff88811418a000 (size 512):
  comm "kworker/1:7", pid 5101, jiffies 4294947640 (age 25.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 0b 25 86 ff ff ff ff  ..........%.....
    00 00 95 12 81 88 ff ff c8 9b ff ff 00 00 00 00  ................
  backtrace:
    [<ffffffff815744cb>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815744cb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff83ef17b2>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff83ef17b2>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83ef17b2>] neigh_alloc net/core/neighbour.c:486 [inline]
    [<ffffffff83ef17b2>] ___neigh_create+0xf2/0xe10 net/core/neighbour.c:640
    [<ffffffff8434480b>] ip6_finish_output2+0x73b/0x980 net/ipv6/ip6_output.c:126
    [<ffffffff84349c21>] __ip6_finish_output net/ipv6/ip6_output.c:196 [inline]
    [<ffffffff84349c21>] ip6_finish_output+0x291/0x510 net/ipv6/ip6_output.c:207
    [<ffffffff84349f41>] NF_HOOK_COND include/linux/netfilter.h:293 [inline]
    [<ffffffff84349f41>] ip6_output+0xa1/0x1c0 net/ipv6/ip6_output.c:228
    [<ffffffff843836f9>] dst_output include/net/dst.h:458 [inline]
    [<ffffffff843836f9>] NF_HOOK.constprop.0+0x49/0x110 include/linux/netfilter.h:304
    [<ffffffff84383a09>] ndisc_send_skb+0x249/0x3c0 net/ipv6/ndisc.c:509
    [<ffffffff8438897a>] ndisc_send_rs+0x7a/0x290 net/ipv6/ndisc.c:719
    [<ffffffff8435c198>] addrconf_dad_completed+0x1b8/0x6b0 net/ipv6/addrconf.c:4291
    [<ffffffff8435cac0>] addrconf_dad_work+0x430/0x980 net/ipv6/addrconf.c:4199
    [<ffffffff812c8edd>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c9a87>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c9a87>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6f5b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149e95>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

executing program
executing program
executing program
executing program


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
