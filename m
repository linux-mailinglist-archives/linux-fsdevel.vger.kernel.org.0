Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECD96ADA86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 10:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCGJkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 04:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCGJkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:40:49 -0500
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C238E89
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 01:40:48 -0800 (PST)
Received: by mail-io1-f79.google.com with SMTP id k13-20020a5d9d4d000000b0074caed3a2d2so6913826iok.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 01:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182047;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvbFoG9v2/yHE6QziVGs+IqGEwhK3oeHPZrzHiBqA8E=;
        b=ZBPXp4ylE24+lQE4SOjDySR4CLg6exm+JUclmh9GhQchOQGpo/N7Onoz+bKC2MrtWf
         h9pK//AuIrgpxeaJljP5V0MqCgOEGGc5WdxAGrzFtAl2A9FD9wH33ltT6qz4I5lk6K7N
         2i4Oz7H6Mzp0rJXM3usmQtV4mcAxna1PbnvG8ysaJkgNSzQEHCIFJUQguKGrqR9H6NcH
         LTeUsTn8IdS3zZM25cYw2Zz0OyZaf0eDGCmRhTzNIiNdaXMKULispZE9NWcpPzTikkDh
         27GdpuAGvjYWqjWdBWK7x0/i/7NQMXvTlF8vzMYppmR9sOskTA5a90hnScOSysoZ4xcG
         Lqsg==
X-Gm-Message-State: AO0yUKV047PKtpy2gHFObmwnRs4HXyOS2D5pF0cy3hWFspAdZ5omDWG4
        KAhgLaldOpJmDjv8DANMeoDMGB6AsLISVgyJwKdUGFCsAxmU
X-Google-Smtp-Source: AK7set8pbKSkqVoVVFBVTi66lhjFABa0+EALH2TkGSW3jXhBY45NLCY9YHSd6d4JTgYt2Q/kNi2+n4YvrwKGe2r8uujIphdrbd+g
MIME-Version: 1.0
X-Received: by 2002:a6b:ec09:0:b0:74d:4684:9dda with SMTP id
 c9-20020a6bec09000000b0074d46849ddamr6282528ioh.1.1678182047543; Tue, 07 Mar
 2023 01:40:47 -0800 (PST)
Date:   Tue, 07 Mar 2023 01:40:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cff89d05f64c34b6@google.com>
Subject: [syzbot] [fs?] KMSAN: uninit-value in vfs_write
From:   syzbot <syzbot+c9bfd85eca611ebf5db1@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, glider@google.com, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eda666ff2276 kmsan: silence -Wmissing-prototypes warnings
git tree:       https://github.com/google/kmsan.git master
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170c25d9480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f27365aeb365b358
dashboard link: https://syzkaller.appspot.com/bug?extid=c9bfd85eca611ebf5db1
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10825603480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cdabab480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6789c9ec45dd/disk-eda666ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb93f5d6b4fd/vmlinux-eda666ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b51c1727def7/bzImage-eda666ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9bfd85eca611ebf5db1@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in aio_rw_done fs/aio.c:1520 [inline]
BUG: KMSAN: uninit-value in aio_write+0x899/0x950 fs/aio.c:1600
 aio_rw_done fs/aio.c:1520 [inline]
 aio_write+0x899/0x950 fs/aio.c:1600
 io_submit_one+0x1d1c/0x3bf0 fs/aio.c:2019
 __do_sys_io_submit fs/aio.c:2078 [inline]
 __se_sys_io_submit+0x293/0x770 fs/aio.c:2048
 __x64_sys_io_submit+0x92/0xd0 fs/aio.c:2048
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:766 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x71f/0xce0 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0x11d/0x3b0 mm/slab_common.c:981
 kmalloc_array include/linux/slab.h:636 [inline]
 bcm_tx_setup+0x80e/0x29d0 net/can/bcm.c:930
 bcm_sendmsg+0x3a2/0xce0 net/can/bcm.c:1351
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 sock_write_iter+0x495/0x5e0 net/socket.c:1108
 call_write_iter include/linux/fs.h:2189 [inline]
 aio_write+0x63a/0x950 fs/aio.c:1600
 io_submit_one+0x1d1c/0x3bf0 fs/aio.c:2019
 __do_sys_io_submit fs/aio.c:2078 [inline]
 __se_sys_io_submit+0x293/0x770 fs/aio.c:2048
 __x64_sys_io_submit+0x92/0xd0 fs/aio.c:2048
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 1 PID: 5034 Comm: syz-executor350 Not tainted 6.2.0-rc6-syzkaller-80422-geda666ff2276 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
