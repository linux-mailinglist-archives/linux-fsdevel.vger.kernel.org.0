Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEAE639EFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 02:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiK1Bgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 20:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiK1Bgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 20:36:41 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86730B854
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Nov 2022 17:36:35 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id w9-20020a056e021c8900b0030247910269so7470762ill.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Nov 2022 17:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHbFXNbfQJo0etgll7PK/wANb1syjZtzK5qI4dznE7w=;
        b=ZY11pYROPWXS9T/40dpu45JdolaM9iOdan2MaMj0izbjbUnfW0bQ8HcP0ZgdunJHn/
         LLvbP4yIcUnYxfIkQBUj9aZVFZBL9K31vWh5pb5NbrpTeggzXJ+Gd8OmUCYd6jVyNK2P
         nF537dZN96h1LT0v6UyXzDsr/uBElZPMt4HukNk3iU00Ij15oIHqJ/bdt6ou8XGgYUGr
         AtOGcG/Wzs/ktikZYKUADmdQ9hfTFApGnkElq1mqpuqiHD07het40Y0d4dnifv/r9ey4
         v5kn1wv+ctfniyNHxbZRV0XQfSeKF46JTC1bu4u9pRrxeyiuiMlt37VlNX5XrocIAjFy
         +Bog==
X-Gm-Message-State: ANoB5pkLM7VgYyeJcULdnLbN6YWoDjA2v4MIEIze3lJuwmHbHPYoZD1m
        eK9O8hb520Fqa9gJePomHHK5gptz6mtKjR3Wrs7BlfiKA8V+
X-Google-Smtp-Source: AA0mqf68WiRHMAkun+P/xHmfORlQS01dTBout9CInD2zsm2OywEdK4y54zBCrpTEVSTT+UMXeuGkL04CKfgswxTVg/GaGCTgcu4J
MIME-Version: 1.0
X-Received: by 2002:a02:6d13:0:b0:374:ff83:34b8 with SMTP id
 m19-20020a026d13000000b00374ff8334b8mr14099890jac.60.1669599394907; Sun, 27
 Nov 2022 17:36:34 -0800 (PST)
Date:   Sun, 27 Nov 2022 17:36:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9caec05ee7de65e@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in get_super
From:   syzbot <syzbot+cf2fe6054f356fc11d49@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12cff0ad880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=cf2fe6054f356fc11d49
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135b9a87880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d865c8fd3706/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf2fe6054f356fc11d49@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000180
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010bce7000
[0000000000000180] pgd=0800000111ba7003, p4d=0800000111ba7003, pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3102 Comm: syz-executor.4 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : hlist_unhashed include/linux/list.h:854 [inline]
pc : get_super+0x4c/0x144 fs/super.c:790
lr : get_super+0x7c/0x144 fs/super.c:789
sp : ffff800010fb3b40
x29: ffff800010fb3b40 x28: ffff0000c5400000 x27: 0000000000000000
x26: 00000000000000c0 x25: ffff0000c58c9500 x24: ffff800009ab2ee0
x23: ffff80000d4e4400 x22: 0000000000000001 x21: ffff80000d4e43c0
x20: 0000000000000000 x19: ffff0000c58c9500 x18: 000000000000035c
x17: ffff80000c0cd83c x16: ffff80000dbe6158 x15: ffff0000c5400000
x14: 0000000000000008 x13: 00000000ffffffff x12: ffff0000c5400000
x11: ff808000085c1d08 x10: 0000000000000000 x9 : ffff8000085c1d08
x8 : ffff0000c5400000 x7 : ffff8000085c1cbc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 get_super+0x4c/0x144
 __invalidate_device+0x28/0xb8 block/bdev.c:1003
 disk_force_media_change+0xf0/0x198 block/disk-events.c:310
 __loop_clr_fd+0x164/0x2a0 drivers/block/loop.c:1174
 lo_release+0xb4/0xc8 drivers/block/loop.c:1745
 blkdev_put_whole block/bdev.c:695 [inline]
 blkdev_put+0x200/0x284 block/bdev.c:953
 kill_block_super+0x58/0x78 fs/super.c:1431
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: eb17029f 54000620 f0027915 910f02b5 (f940c288) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	eb17029f 	cmp	x20, x23
   4:	54000620 	b.eq	0xc8  // b.none
   8:	f0027915 	adrp	x21, 0x4f23000
   c:	910f02b5 	add	x21, x21, #0x3c0
* 10:	f940c288 	ldr	x8, [x20, #384] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
