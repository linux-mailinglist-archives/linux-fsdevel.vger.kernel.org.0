Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34626ACBFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 19:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjCFSHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 13:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCFSHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:07:21 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0E3B3DF
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 10:06:58 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id b26-20020a5d805a000000b0074cfe3a44aeso5730681ior.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 10:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678126007;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PS5zKcv0bdF/YqmRX0D6jlNyrLAj3CPuJJ06SOooIbc=;
        b=ZuYfaLxmlmx3haRw8Qi+MUkhLq+S4lSGrteZW+YpyRHqToarD4eFtrc5uVN14K7zSH
         2FrekLdI0sZwqm4IKTYW1HtEH0qhlpj1gUb8bRu40em6JwgDTGcsGv9gSQAhtAOZ81Ka
         LFzV67qTk8nDB62yl7qFUBO2Du6DFqoB0ca0CZHphhTkxIZX2NLAaoX9AfqQlicqSkIH
         oiU+X0EHqDaPMELH5jg0ECGk6jdvt2u1KIKVEasp3zezTKOU1gXamMT7p37buOPfsEX6
         +DUDEcqnWGwUpU32Imlsofcd7ZXdOglw1vSzuZnP6UBQPuU+407/ZVVB6vZ7bn2B7NTe
         6tZA==
X-Gm-Message-State: AO0yUKV6PTYpz+sYYoj5ne0nEAazcvT4fGVJPtQa3+nU8GNoZh3HpV0B
        rmrXGkP82WmesD30Tyn+R0r/L6hc8Z68igIfBRDWIMkPJQBN
X-Google-Smtp-Source: AK7set+acBv1PAuRD2nBVSCOP39aE7sDGCiYO7vVZtf7iCBfDhbHd8rSIIutYhyiOGugWnd8HrBz3bWvijaFMVxA/7GkwC7sRbsK
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c03:b0:319:34bf:dbef with SMTP id
 d3-20020a056e020c0300b0031934bfdbefmr5557165ile.0.1678126007447; Mon, 06 Mar
 2023 10:06:47 -0800 (PST)
Date:   Mon, 06 Mar 2023 10:06:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ffa2505f63f2875@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_listxattr
From:   syzbot <syzbot+92ef9ee419803871020e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, glider@google.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    80383273f7a0 kmsan: silence -Wmissing-prototypes warnings
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17960fd6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63e082c4fda2e77
dashboard link: https://syzkaller.appspot.com/bug?extid=92ef9ee419803871020e
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f76b21f14e30/disk-80383273.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac1c985c1983/vmlinux-80383273.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d6710cffdb38/bzImage-80383273.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92ef9ee419803871020e@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in strncmp+0x11b/0x180 lib/string.c:307
 strncmp+0x11b/0x180 lib/string.c:307
 hfsplus_listxattr+0x996/0x1aa0
 vfs_listxattr fs/xattr.c:472 [inline]
 listxattr+0x703/0x780 fs/xattr.c:820
 path_listxattr fs/xattr.c:844 [inline]
 __do_sys_llistxattr fs/xattr.c:862 [inline]
 __se_sys_llistxattr fs/xattr.c:859 [inline]
 __ia32_sys_llistxattr+0x16d/0x300 fs/xattr.c:859
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:766 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x71f/0xce0 mm/slub.c:3491
 kmalloc_trace+0x4d/0x1f0 mm/slab_common.c:1062
 kmalloc include/linux/slab.h:580 [inline]
 hfsplus_listxattr+0x4dc/0x1aa0 fs/hfsplus/xattr.c:702
 vfs_listxattr fs/xattr.c:472 [inline]
 listxattr+0x703/0x780 fs/xattr.c:820
 path_listxattr fs/xattr.c:844 [inline]
 __do_sys_llistxattr fs/xattr.c:862 [inline]
 __se_sys_llistxattr fs/xattr.c:859 [inline]
 __ia32_sys_llistxattr+0x16d/0x300 fs/xattr.c:859
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 1 PID: 11511 Comm: syz-executor.4 Not tainted 6.2.0-rc3-syzkaller-79341-g80383273f7a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
