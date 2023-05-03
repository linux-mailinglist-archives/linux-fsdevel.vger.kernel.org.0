Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D56F606D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 23:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjECVId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjECVIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 17:08:32 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D57DB0
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 14:08:31 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-331514f5626so10318235ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 14:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683148110; x=1685740110;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWE1gUaPEDvuP8/sfMbQHu/lPf0Q2rOkFlhahb64iww=;
        b=XOhbqhz5sLuucG5nDWicLE5qdqXGoXMzFIk4pDT+96wA2VU/wCoOxR5uxuGqe919Oh
         9MBaN2Fg2HpcI1A84fbqiuDGjj0ojlVMzq1c5t617zdOg4h5a8TdN50gkL6LhnQ1MwcZ
         3mDBdQ8i1/Soq43k9at4+pIYUyztzYR6GUWFarBNmN/fZ2bleVAEiXcDgOg6c4SSsW0F
         G9u7MpfTBlNGbiZdXJVdG5hEcV8Q8zSRKq5Fr676F9EI6dKIrRcPkZMs3Qk5kxxnwUc/
         DEcrdlnzDopT9wT0xum3WuPwkQ4x//5dRnatvAA96oiZACw1zzyGeLuOEgKuFXjxIz15
         eMzQ==
X-Gm-Message-State: AC+VfDw8FHM0O5zmcLvY75aagIVZnwVHm7Jbsnuy6e+aSHIPmviMEoGG
        deKRNbS7wDm2H6Cibj5mwLmtDxd84zaqwFHzkPuP5TmcNN3x
X-Google-Smtp-Source: ACHHUZ4WpLZO2iMXuzM0V0IXlmGQCYHmfrK1UAGjTIIXWvC+8nje63WdB4rpHJsYrFY/EFNbKgQVwk4zDOAJ67ZGE6FzoWrCU6QC
MIME-Version: 1.0
X-Received: by 2002:a92:d94a:0:b0:331:310c:658b with SMTP id
 l10-20020a92d94a000000b00331310c658bmr4371363ilq.2.1683148110649; Wed, 03 May
 2023 14:08:30 -0700 (PDT)
Date:   Wed, 03 May 2023 14:08:30 -0700
In-Reply-To: <20230503202830.GA695988@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d606105fad075eb@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_block_set (2)
From:   syzbot <syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_xattr_block_set

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5863 at fs/ext4/xattr.c:2141 ext4_xattr_block_set+0x2ef2/0x3680
Modules linked in:
CPU: 1 PID: 5863 Comm: syz-executor.1 Not tainted 6.3.0-rc3-syzkaller-00111-gd4fab7b28e2f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:ext4_xattr_block_set+0x2ef2/0x3680 fs/ext4/xattr.c:2141
Code: da 3f ff 48 8b 7c 24 50 4c 89 ee e8 98 36 c2 ff 45 31 ed e9 86 f4 ff ff e8 2b da 3f ff 45 31 ed e9 79 f4 ff ff e8 1e da 3f ff <0f> 0b e9 5d f2 ff ff e8 12 da 3f ff 0f 0b 43 80 3c 26 00 0f 85 6f
RSP: 0018:ffffc900062df4a0 EFLAGS: 00010293
RAX: ffffffff824a9302 RBX: 1ffff92000c5bf11 RCX: ffff888077008000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc900062df6d0 R08: ffffffff82103f70 R09: ffffed100d986aae
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc900062df860
FS:  00007faf2d136700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1f5413f440 CR3: 000000006a2a8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_xattr_set_handle+0xcd4/0x15c0 fs/ext4/xattr.c:2458
 ext4_initxattrs+0xa3/0x110 fs/ext4/xattr_security.c:44
 security_inode_init_security+0x2df/0x3f0 security/security.c:1147
 __ext4_new_inode+0x341c/0x42e0 fs/ext4/ialloc.c:1322
 ext4_mkdir+0x425/0xce0 fs/ext4/namei.c:2991
 vfs_mkdir+0x29d/0x450 fs/namei.c:4038
 do_mkdirat+0x264/0x520 fs/namei.c:4061
 __do_sys_mkdirat fs/namei.c:4076 [inline]
 __se_sys_mkdirat fs/namei.c:4074 [inline]
 __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4074
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faf2c48c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faf2d136168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007faf2c5abf80 RCX: 00007faf2c48c0f9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 00007faf2c4e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd76b57a0f R14: 00007faf2d136300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         d4fab7b2 ext4: clean up error handling in __ext4_fill_..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
console output: https://syzkaller.appspot.com/x/log.txt?x=16366e18280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=6385d7d3065524c5ca6d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c9cef2280000

