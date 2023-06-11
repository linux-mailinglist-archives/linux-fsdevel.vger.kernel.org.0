Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D51A72AFF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 04:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjFKCCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 22:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjFKCCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 22:02:10 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78665173A
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 19:02:08 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-33b4cbdd21aso33977105ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 19:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686448928; x=1689040928;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpII4Bfe57dn9nuKVaPGfYaTqGD4QFjQiwpbINU+W+8=;
        b=KxIO9lTmHbh0PGncVjSvRL1hk1I5V4Z/2DjiyOSXhilt2JtCYfi0ig8i4BuZbeIDvD
         7FdqOPz28s/rE08on6ICYL/lwfkaO82OlvpSI8TDAzk3xHo3pem/Gbhnh8MTNivR3Kpn
         64V/Q4UX/q0d1u2waF9JdTo+8vFc8r9esVjA1okT4deTD0NGuBM6hA+lERmTdGizy56L
         IL4iw9bKfYC6TJrNpF3sXKDeUNlEbe0gxxc6vrE/NS7gH0RKzbL7NRhnPblNYCiaMtvy
         ejBTdW51uAj2V/EjmvOEqSe58YOcaoVDDjpxokwYoJo9XUhJ07GGeWF1cfGh23X6qkrV
         y8uQ==
X-Gm-Message-State: AC+VfDxiUdtcY9U7lPyQ3h1uxXk1xbF4o0ieAMjnEeNzWcAiHQzCEjd+
        l3o0/mLnSowvrbl1cnXHqv1kRBScUG70BTGP4hHw8iTIs0an
X-Google-Smtp-Source: ACHHUZ5iWhJhLL+4nWkhhe23qDyFivueyJlcUSIdHpk2meCQJSr6USy+PIt1IMOZAL3RLrA4om5BggrM/Hr9MWFzYWOssS9tr93R
MIME-Version: 1.0
X-Received: by 2002:a92:ce04:0:b0:335:908b:8f9 with SMTP id
 b4-20020a92ce04000000b00335908b08f9mr2481753ilo.1.1686448927847; Sat, 10 Jun
 2023 19:02:07 -0700 (PDT)
Date:   Sat, 10 Jun 2023 19:02:07 -0700
In-Reply-To: <000000000000e55d2005fd59d6c9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046becb05fdd0fdef@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_move_extents
From:   syzbot <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    d8b213732169 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15e74543280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd4213541e5ab26f
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139801f1280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a928ab280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d15de852c90/disk-d8b21373.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca6234ed6efc/vmlinux-d8b21373.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0fc706ec33bb/Image-d8b21373.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a5ab37037d85/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
------------[ cut here ]------------
Looking for class "&ei->i_data_sem" with key init_once.__key.775, but found a different class "&ei->i_data_sem" with the same key
WARNING: CPU: 0 PID: 6198 at kernel/locking/lockdep.c:941 look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:938
Modules linked in:
CPU: 0 PID: 6198 Comm: syz-executor258 Not tainted 6.4.0-rc5-syzkaller-gd8b213732169 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:938
lr : look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:938
sp : ffff800097187040
x29: ffff800097187040 x28: dfff800000000000 x27: ffff800080edb4a4
x26: ffff80009222c6e0 x25: ffff80009222c000 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000000 x21: ffff8000923bfc61
x20: ffff0000e0293488 x19: ffff800090e7b1c0 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a43bfbc x15: 0000000000000002
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 5933e84718dc2000
x8 : 5933e84718dc2000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800097186938 x4 : ffff80008df9ee80 x3 : ffff8000805974f4
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:938
 register_lock_class+0x8c/0x6a4 kernel/locking/lockdep.c:1290
 __lock_acquire+0x184/0x7604 kernel/locking/lockdep.c:4965
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
 down_write_nested+0x58/0xcc kernel/locking/rwsem.c:1689
 ext4_double_down_write_data_sem+0x3c/0x4c
 ext4_move_extents+0x2b0/0xb44 fs/ext4/move_extent.c:621
 __ext4_ioctl fs/ext4/ioctl.c:1352 [inline]
 ext4_ioctl+0x3eb4/0x6910 fs/ext4/ioctl.c:1608
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 6053
hardirqs last  enabled at (6053): [<ffff80008099851c>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:240
hardirqs last disabled at (6052): [<ffff8000809983b4>] kasan_quarantine_put+0x38/0x1c8 mm/kasan/quarantine.c:213
softirqs last  enabled at (4378): [<ffff80008003437c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (4376): [<ffff800080034348>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
