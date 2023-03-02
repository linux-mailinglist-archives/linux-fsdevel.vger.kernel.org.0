Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277F46A8591
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 16:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCBPtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 10:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCBPtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:49:01 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBE838B51
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 07:48:59 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id i2-20020a5d9e42000000b0074cfcc4ed07so8504324ioi.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 07:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/n/K/3RHA4xTQoVXC4jaK6WOJ78Yt5GL4rZVXOaD90Q=;
        b=32gFcSVoIZuDQ0M63wYQWCdlsCne03MNgCKC0dTICgTBpgxVZumaAqrBQhd7xHopLC
         HuQqSEhwZoSRxy8muk0f0UcbHXToEeLlahsCcu1Brdcx/lzMZ5Zp7EnqpTFCJqFWjTap
         TzksZ0STVzyqeMaetPWpq+kxLhL5abucEjiohBj4j0gM6MqtWeVS2sSKRZ1/B4EPosAF
         tA2btup4neDfDeFIooigLaQvuHGMqKvFSbCfguuli8CE4DKlVZRBTWbJanhfL41i/Vdx
         7VVVnVz4ycDxJR6KsIPlLwf5x7ffuwOwLynlQ5UXUY+ERx7NTZGA2X9md8XSRwILuO20
         kpBQ==
X-Gm-Message-State: AO0yUKXv41zlGBWSSu30CoFpLwpnyjCI+Jr44OYq0nlBZmVSrY2AcyS5
        h/ozaPa71BrsrRp/X/X9cQUD7C2ym8lJtblGmH0ZukC2IlC+
X-Google-Smtp-Source: AK7set/znnO3YPzxVExuJmcztdQN+pgOa3zswTUqOVqNKOeXhuNuoBX4V/MbspPKMQlXP1igfFl0tyEvJwqmClChuztQ1+u+pJpr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11ad:b0:315:459e:177d with SMTP id
 13-20020a056e0211ad00b00315459e177dmr1173113ilj.2.1677772138620; Thu, 02 Mar
 2023 07:48:58 -0800 (PST)
Date:   Thu, 02 Mar 2023 07:48:58 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000562d8105f5ecc4ca@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end
From:   syzbot <syzbot+198e7455f3a4f38b838a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    2ebd1fbb946d Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13de1350c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3519974f3f27816d
dashboard link: https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160fccacc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e5963cc80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16985cc7a274/disk-2ebd1fbb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd3452567115/vmlinux-2ebd1fbb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c75510922212/Image-2ebd1fbb.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0427397bf5ad/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+198e7455f3a4f38b838a@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:226!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6191 Comm: syz-executor142 Not tainted 6.2.0-syzkaller-18300-g2ebd1fbb946d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ext4_write_inline_data fs/ext4/inline.c:226 [inline]
pc : ext4_write_inline_data_end+0xe28/0xf84 fs/ext4/inline.c:767
lr : ext4_write_inline_data fs/ext4/inline.c:226 [inline]
lr : ext4_write_inline_data_end+0xe28/0xf84 fs/ext4/inline.c:767
sp : ffff80001eac7520
x29: ffff80001eac7630 x28: ffff0000d7a63680 x27: dfff800000000000
x26: 0000000000000060 x25: ffff80001eac75c0 x24: 0000000040000000
x23: 000000000000006c x22: 0000000000000060 x21: 000000000000000c
x20: ffff0000de2e48e8 x19: 0000000000000000 x18: ffff80001eac70d8
x17: ffff800015b8d000 x16: ffff80001231393c x15: 00000000200002c0
x14: 1ffff00002b720af x13: 0000000000000007 x12: 0000000000000001
x11: ff80800008e4087c x10: 0000000000000000 x9 : ffff800008e4087c
x8 : ffff0000d7a63680 x7 : ffff800008de16f0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 00000000000008a5 x3 : ffff800008b36a88
x2 : 0000000000000001 x1 : 0000000000000060 x0 : 000000000000006c
Call trace:
 ext4_write_inline_data fs/ext4/inline.c:226 [inline]
 ext4_write_inline_data_end+0xe28/0xf84 fs/ext4/inline.c:767
 ext4_da_write_end+0x330/0x9fc fs/ext4/inode.c:3150
 generic_perform_write+0x384/0x55c mm/filemap.c:3784
 ext4_buffered_write_iter+0x2e0/0x538 fs/ext4/file.c:285
 ext4_file_write_iter+0x188/0x16c0
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x610/0x914 fs/read_write.c:584
 ksys_write+0x15c/0x26c fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:646
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 14000043 97db2731 d4210000 97db272f (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
