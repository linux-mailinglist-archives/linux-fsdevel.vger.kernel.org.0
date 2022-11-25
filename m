Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C077638687
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKYJrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiKYJqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:46:43 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6435D3C6D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:45:42 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so2600784ile.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJSMjFkkoYoWoxOf9TP0CnqnqKLajLSmNf328nPJR9k=;
        b=lAcNcChb6GcXx6vIf/o0PNTsuSiz7P/h/goV5J4A43BWRQmLxKkUSha4iIJloFin+j
         /qnLxAyv2G4Dqb/b2dYG6NIVle2A5D3ahHv/JVZO1hXCH+6AbEyVACfQjLJ6rg0ZVB53
         03C60K6562ZaPnNJ9jGvhMJsIqzWqVItO+LMyjFaoFwibQLpiDR4+xJPTWDPrJsyloOI
         vJ3wWcglUtF3xIwVVuWW562zSd2IQIt16e8M6gn8/sVp1P3j2Fx+BKSLudbA8K3vW5P1
         jTY+x7A8CwWTimmdcN1hFDhI/oxyi661/uOJ531W11kM+zDQZT3GqsssIGQZYX4P6LBy
         MjYw==
X-Gm-Message-State: ANoB5pkbbKemylYdUtK87DTW4AVTpzR73AH4ZZXVnAWXYkaQbmURXJke
        v5m5quw20S9HM4GASxLEyFDFf73GFGXgY6aD1i09vtH3DWWL
X-Google-Smtp-Source: AA0mqf66iybkLuYsp/1HxXiXdpfkL/nESD9cfnhOmz4UQHBC2eTZmAMGcU7jY5i3eGOlQ4H+goWIfWVVuy1JCTYaq539Hf5wYCW4
MIME-Version: 1.0
X-Received: by 2002:a5e:dd42:0:b0:6bf:df76:be13 with SMTP id
 u2-20020a5edd42000000b006bfdf76be13mr9048450iop.108.1669369541815; Fri, 25
 Nov 2022 01:45:41 -0800 (PST)
Date:   Fri, 25 Nov 2022 01:45:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089f55405ee486239@google.com>
Subject: [syzbot] kernel BUG in hfs_write_inode
From:   syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To:     damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    65762d97e6fa Merge branch 'for-next/perf' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14e324e3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56d0c7c3a2304e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10983553880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13315ebb880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52f702197b30/disk-65762d97.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72189c2789ce/vmlinux-65762d97.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec0349196c98/Image-65762d97.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6bfea2266b7f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/hfs/inode.c:446!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 347 Comm: kworker/u4:3 Not tainted 6.1.0-rc6-syzkaller-32653-g65762d97e6fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: writeback wb_workfn (flush-7:0)
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : hfs_write_inode+0x44c/0x450 fs/hfs/inode.c:446
lr : hfs_write_inode+0x44c/0x450 fs/hfs/inode.c:446
sp : ffff800012f9b960
x29: ffff800012f9ba10 x28: ffff0000cb9013e0 x27: ffff0000cb901358
x26: 0000000000000021 x25: 0000000000000007 x24: ffff0000cb9013e0
x23: 0000000000000003 x22: 0000000000000000 x21: ffff800012f9b9a0
x20: 0000000000000000 x19: ffff0000cb901358 x18: 00000000000000c0
x17: ffff80000dda8198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000004 x12: ffff80000d51b008
x11: ff80800008903460 x10: 0000000000000000 x9 : ffff800008903460
x8 : ffff0000c4048000 x7 : ffff80000862d114 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000d51afe0 x0 : 0000000000000000
Call trace:
 hfs_write_inode+0x44c/0x450 fs/hfs/inode.c:446
 write_inode fs/fs-writeback.c:1440 [inline]
 __writeback_single_inode+0x240/0x2e4 fs/fs-writeback.c:1652
 writeback_sb_inodes+0x3e4/0x85c fs/fs-writeback.c:1870
 wb_writeback+0x198/0x328 fs/fs-writeback.c:2044
 wb_do_writeback+0xc8/0x384 fs/fs-writeback.c:2187
 wb_workfn+0x70/0x15c fs/fs-writeback.c:2227
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
Code: d4210000 17ffff98 94ddff99 97e6893f (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
