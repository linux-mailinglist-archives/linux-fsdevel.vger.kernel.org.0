Return-Path: <linux-fsdevel+bounces-12620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8176861BA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 19:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259E01C2449B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1423143C54;
	Fri, 23 Feb 2024 18:29:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8768142636
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712966; cv=none; b=axTJaPLCOstxNOznuklnxkVubRSv8f/R4CY2E8UY2Tnwce8NvAYZFLZ5pY3T4Vxl2O8LszhxoGtCBk9416+fj9LoA6yfzgC1RFChJ3Y4ME/660Z8lyuptLGdI7XwKqjPw/bZ7XIJtERWHmFnZftQWujCr6E5HfgtUAv2d1d/qng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712966; c=relaxed/simple;
	bh=5wzVl9QGHYN/on13qUDPDDV9AgzVVcueuNiPyZ6NTTw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B2bgOGcnSESwBwH8Zesz7FtWldeU3y2scrjiouySAIPTQ6ojcB71wZE/C0/9SoEIIqQh1wh9oOcTE8Pal76fnQGblUK60r6Y1T02ll9tpY3nXcuzc0FDyQ1IJVrQ4v9BiwSD4b1BDxINGAW4z3Ln4Cif+ko16efIo5MZknywVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c0088dc494so80446939f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 10:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708712964; x=1709317764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ge1hRX1ECFlk43m9GAhc6uTPqn5oqnoXMgkOWLTUwl0=;
        b=LdHSlNMTtPXEsa187yUwGMUDWUvMUeFZWHkYv7DdKcuNS9PrvBLbHARx2/vOHlWSOg
         +8cBQmA6kVaFOZ3hduSRb1Its/hvnMvW5/CGbzuPtYSIazHn/TaJ/NbDA7HLIA1P92vI
         +BuGAiXP1Usky5wrgZtF26Oux6JMmQ3AKdTGn+RGIEBvK2pFE6nuyt0p1g0WSRtnhms5
         NUU3TXszXtuvhOVxQ0id0hfKt0T7Z9JKjTVmeQSZ+Kfw3bj/JujrijkKTwXirPGoIbdT
         4/5zrS4FPLXsMoRy/kZqxmLlh8s3by4P99zM+bu8OdGZ6aI7U61bTJTBq0ZzPky3ryM0
         YgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEeyoWEz7F9buyJhYS0L7b/V6pGFYkonotMsNYpFVfSZ7Dg1pTCJ7+QxCnAHj98jOlDqe92Ybero2D4rtZ51DJ34zCm0fqnrkYG3ih+Q==
X-Gm-Message-State: AOJu0Yx/R2GGdIxOY5kUd1HGBV4XVCReVEym2aL1f0bzRQ6flMT7Jf5S
	aS0TFplbORG1N46za0SWZ4u233f3JClmX/p5SHGJt8JiayYciMMV/zkYb2y//rM8iRjzrIgC2LB
	6mlK7Z6n3J1klrs1A1oE+xS/hzLCkAh6rPnnAtc8+FxFeZO8I9zZZ7KI=
X-Google-Smtp-Source: AGHT+IEI2T0MN0kQIAwFSw0qQiXNP5p7doqL2vMHiQLofiE/um/eUsWSJna0F+LP07r7n1tRH5sD9LoOB59+p/DQIC3zrd9UyrDV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:168a:b0:473:e341:43e2 with SMTP id
 f10-20020a056638168a00b00473e34143e2mr38967jat.0.1708712963989; Fri, 23 Feb
 2024 10:29:23 -0800 (PST)
Date: Fri, 23 Feb 2024 10:29:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003de699061210bdc4@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in __gfs2_glock_put
From: syzbot <syzbot+335b6972be76fa40c22f@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9abbc24128bc Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10af4008180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=335b6972be76fa40c22f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce13ec3ed5ad/disk-9abbc241.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/256cbd314121/vmlinux-9abbc241.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0af86fb52109/Image-9abbc241.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+335b6972be76fa40c22f@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: G:  s:UN n:2/819 f: t:UN d:EX/0 a:0 v:0 r:-128 m:20 p:1
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:282!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 7508 Comm: kworker/1:0H Tainted: G    B              6.8.0-rc5-syzkaller-g9abbc24128bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: glock_workqueue glock_work_func
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __gfs2_glock_put+0x3f4/0x4ec fs/gfs2/glock.c:282
lr : __gfs2_glock_put+0x3f4/0x4ec fs/gfs2/glock.c:282
sp : ffff8000a4737ac0
x29: ffff8000a4737ac0 x28: 1fffe0002666fd6e x27: dfff800000000000
x26: ffff0000c4ff6408 x25: 0000000000000140 x24: 1fffe00025410015
x23: ffff00012a080000 x22: dfff800000000000 x21: 0000000000000140
x20: ffff00013337ed30 x19: ffff00013337ea40 x18: 1fffe00036804796
x17: ffff80008ec8d000 x16: ffff80008ad5bbdc x15: 0000000000000001
x14: 1ffff000148e6e18 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 82bd4918e7193700
x8 : 82bd4918e7193700 x7 : 1fffe00036804797 x6 : ffff800080297af0
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800082f22fb0
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __gfs2_glock_put+0x3f4/0x4ec fs/gfs2/glock.c:282
 glock_work_func+0x2ac/0x440 fs/gfs2/glock.c:1109
 process_one_work+0x694/0x1204 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2787
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: aa1f03e0 aa1303e1 52800022 97fff7f7 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

