Return-Path: <linux-fsdevel+bounces-48378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A6AADEC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7ED9A5C27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD225C6F0;
	Wed,  7 May 2025 12:14:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E417E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620091; cv=none; b=NZuDFM9oDXUjmlccDjVtFh04hWOqOrFX3mfRuAOJaDAMHNkK/PNGC4+mw9ESLOofF/MR+OfwPGjMaMMgHopQo7kdbPUKs69NNaXX+4Lm7ey4OwU3AYDTAU2Aw1dxJXYtiXgR++C6IINP2s93IuvrnNSS6pPGUXmeI797j0I+Frc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620091; c=relaxed/simple;
	bh=99ar2hiSFE1FYK0IBzA4cryB2kytRUvN/AFQ7Vg6Kus=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qpXKCqOxwk0Ygkk1X0XCVdB7OCZYKroUTJIpCdNcFXGKl6PQt+DrHUdYzArk0yVv6pPl8p+8nfR9c+22e7r/CL8msQQGCKk5PBJ5027OQ7BKE4FOx1x3ONVh9KxTVEvTuz2VLqexNlnoF5hk+sdWIeTMgNAkidWn2V5/ug95bqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d90a7e86f7so160473895ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 05:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746620089; x=1747224889;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rLfIe2cejsjjf4/WX/8dRCe0zcEB5QgvR8jfpBeFZE=;
        b=BEqSBTSe6jXZoRuKIbDLnyUeBDnFDE8dNdK6ATtjUdygTWD1tln022HXjZjtv3youp
         O8sgX8sTXcO6qYjV5NIeyfc1Q7JcOorIgHKmfEX2gGiKhC0SMJmczeyrsyJ+QKekYsxY
         Ofps3K6pgu0kK1O/zL7Xoxe8hbFVCF6ACeRQAO8CwFSzry6+9w32bSkrYXr4/JPIU1nK
         3JzaXJqPrdOPfWfSAqOo26UGWypSdNa8BYqLEZBeqDPuNA0WLSTsFQl2+IvBFwcepRxe
         NVjIHdeVJSL71UjOOdTqpNCWnRocMmr4zADOIqRmdzMWvz2NbjxrM6GDrGFI9aiEiRx7
         +xRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrXNR+W4TRqxWHKFiSIbh/jvmmTo0QPGeJZWQp1GQhaePFrWpbJ4/aS7bfkScn8vZMw+Qb5dGh8v+VCNtw@vger.kernel.org
X-Gm-Message-State: AOJu0YwJO4IlAT8kXhIIlt6wTK/hntRF7o80qUlV645aFfI3f1HWpzt7
	nWDiJNw5y9q9HgmmCOBcHI9Q665XmW42AE6BMbEqX/Q4k5XcGbZPGcPiDr3Z6xlRhri/9LoGnBq
	UQ9FyPeFZASYkSBtfJRTSYw9XN17dJY6tqf4OGZDzyvcvZ+hJnI45sRM=
X-Google-Smtp-Source: AGHT+IHAtmJvNVOpiltndBywucnawuMmrw3aeOzBTNyTpFfa4ZImJWJjijYnWqOyYjQzaEOFZwuv4kNlTdV7EIm17s4i9UbBw2PF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:3d8:1b25:cc2 with SMTP id
 e9e14a558f8ab-3da738f8468mr34427185ab.8.1746620078201; Wed, 07 May 2025
 05:14:38 -0700 (PDT)
Date: Wed, 07 May 2025 05:14:38 -0700
In-Reply-To: <680328c1.050a0220.243d89.0024.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681b4eae.050a0220.37980e.0404.GAE@google.com>
Subject: Re: [syzbot] [hfs?] WARNING in check_flush_dependency (4)
From: syzbot <syzbot+09455b3f0a89d685a9d3@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e0f4c8dd9d2d Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=107e84f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=868079b7b8989c3c
dashboard link: https://syzkaller.appspot.com/bug?extid=09455b3f0a89d685a9d3
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166538f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1028339b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/463c704c2ee6/disk-e0f4c8dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1bb99dd967d9/vmlinux-e0f4c8dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/505fe552b9a8/Image-e0f4c8dd.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9018fb7fad71/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09455b3f0a89d685a9d3@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: WQ_MEM_RECLAIM dio/loop0:dio_aio_complete_work is flushing !WQ_MEM_RECLAIM events_long:flush_mdb
WARNING: CPU: 1 PID: 1786 at kernel/workqueue.c:3721 check_flush_dependency+0x288/0x33c kernel/workqueue.c:3717
Modules linked in:
CPU: 1 UID: 0 PID: 1786 Comm: kworker/1:2 Not tainted 6.15.0-rc4-syzkaller-ge0f4c8dd9d2d #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: dio/loop0 dio_aio_complete_work
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_flush_dependency+0x288/0x33c kernel/workqueue.c:3717
lr : check_flush_dependency+0x288/0x33c kernel/workqueue.c:3717
sp : ffff80009f0f7730
x29: ffff80009f0f7740 x28: dfff800000000000 x27: ffff700013e1eef4
x26: ffff0000c1081408 x25: 0000000000000000 x24: ffff0000d7e64000
x23: dfff800000000000 x22: ffff8000812ac698 x21: ffff800092804000
x20: ffff0000cae4c218 x19: ffff0000c0029400 x18: 00000000ffffffff
x17: ffff800092f13000 x16: ffff80008ada5d6c x15: 0000000000000001
x14: 1fffe00036711ae2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff600036711ae3 x10: 0000000000ff0100 x9 : 88d2378845d08000
x8 : 88d2378845d08000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009f0f7078 x4 : ffff80008f3f4fa0 x3 : ffff8000807ab99c
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 check_flush_dependency+0x288/0x33c kernel/workqueue.c:3717 (P)
 start_flush_work kernel/workqueue.c:4171 [inline]
 __flush_work+0x220/0x8c0 kernel/workqueue.c:4208
 flush_work kernel/workqueue.c:4265 [inline]
 flush_delayed_work+0xcc/0xf8 kernel/workqueue.c:4287
 hfs_file_fsync+0xe8/0x144 fs/hfs/inode.c:680
 vfs_fsync_range+0x160/0x19c fs/sync.c:187
 generic_write_sync include/linux/fs.h:2976 [inline]
 dio_complete+0x510/0x6bc fs/direct-io.c:313
 dio_aio_complete_work+0x28/0x38 fs/direct-io.c:325
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
irq event stamp: 27154
hardirqs last  enabled at (27153): [<ffff800080415058>] flush_delayed_work+0xac/0xf8 kernel/workqueue.c:4286
hardirqs last disabled at (27154): [<ffff80008adc663c>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (27154): [<ffff80008adc663c>] _raw_spin_lock_irq+0x28/0x70 kernel/locking/spinlock.c:170
softirqs last  enabled at (27092): [<ffff80008978635c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (27090): [<ffff800089786328>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

