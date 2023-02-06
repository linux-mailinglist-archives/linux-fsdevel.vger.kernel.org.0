Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D868BC41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 13:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjBFMFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 07:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBFMFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:05:50 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309F12F1D
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 04:05:48 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso7834008ilq.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 04:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc5TaIw9e/++YKxo1Lt6L/DeNw+M003kD9JJ5QRXvXE=;
        b=jMoElF/uS6F7dH1I9VX60ZRw4JdWctwWx4S4O4NDipZAun4XwFb37o8qZ+Wu3NDDq7
         dUsgW9ELhoj0klac8oG8kTtKN3drudfer+dkAPhfTKFBYqPDzqeFO/Nw06rvJyyBjML8
         2BPx8WGw5YwUyW0ufkq5eFigqCFgDbLhHweC/56rcy99PTjpohhd+0Yv5JDPp0Om/bIA
         btmtMf4AxHirsFeAyN0IAiF5UHDEnA7fWiam6fDY7R4ohi4OIBdPykuga/vJkknmG0/m
         Lshmra2Gcr6s1VnLkG8PaAhSBr3c5xLU2yMtb0eZqTd6MYCE0PDMUmNe+GsVKE713NO1
         aeFA==
X-Gm-Message-State: AO0yUKUJgY2mA4kWJt5uUsnSfkCP5J2dXNx51Vst58rnLM4TlUPEn6Cp
        pT7X/Uwqz6TSe4K98HW1UeSD2735b8TgKots11XLQEUeNdQU
X-Google-Smtp-Source: AK7set/dPyvOs92oygtpg+rFekRsU13zRFjJQ8iXuQiUWttVgG53X9wmWd1NcMn2VZ9uOOp6CjTDGqMSeQLMXYTF3Kgli5ZaW1pH
MIME-Version: 1.0
X-Received: by 2002:a92:7011:0:b0:310:a12c:7898 with SMTP id
 l17-20020a927011000000b00310a12c7898mr4056030ilc.24.1675685148369; Mon, 06
 Feb 2023 04:05:48 -0800 (PST)
Date:   Mon, 06 Feb 2023 04:05:48 -0800
In-Reply-To: <00000000000043c9a105ef4cccf7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000062d6005f406daa8@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_brec_find
From:   syzbot <syzbot+5ce571007a695806e949@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    eda666ff2276 kmsan: silence -Wmissing-prototypes warnings
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17bbb96b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f27365aeb365b358
dashboard link: https://syzkaller.appspot.com/bug?extid=5ce571007a695806e949
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ac6175480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e00d23480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc16035efde4/disk-eda666ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/084efc06a321/vmlinux-eda666ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35c07fcfcbf2/bzImage-eda666ff.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0f9e3b43e8ac/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ce571007a695806e949@syzkaller.appspotmail.com

WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
hfs: keylen 9474 too large
=====================================================
BUG: KMSAN: uninit-value in hfs_brec_find+0x671/0x9b0 fs/hfs/bfind.c:141
 hfs_brec_find+0x671/0x9b0 fs/hfs/bfind.c:141
 hfs_brec_read+0x3b/0x190 fs/hfs/bfind.c:165
 hfs_cat_find_brec+0xfb/0x450 fs/hfs/catalog.c:194
 hfs_fill_super+0x1f49/0x2400 fs/hfs/super.c:419
 mount_bdev+0x508/0x840 fs/super.c:1359
 hfs_mount+0x49/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x10c/0x280 fs/fs_context.c:610
 vfs_get_tree+0xa1/0x500 fs/super.c:1489
 do_new_mount+0x694/0x1580 fs/namespace.c:3145
 path_mount+0x71a/0x1eb0 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3674
 __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3674
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable fd created at:
 hfs_fill_super+0x5e/0x2400 fs/hfs/super.c:381
 mount_bdev+0x508/0x840 fs/super.c:1359

CPU: 0 PID: 4991 Comm: syz-executor151 Not tainted 6.2.0-rc6-syzkaller-80422-geda666ff2276 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
=====================================================

