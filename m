Return-Path: <linux-fsdevel+bounces-18722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B343F8BBA71
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AEC1F21DE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5AC1AACA;
	Sat,  4 May 2024 10:09:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2891799B
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714817366; cv=none; b=dOkAk2dyDb0MagOnK1YyAC/zV6PihmOQ2A1JTgRjyXhZVFhOFgAnxeytwWX2SeERvpk1PTgYQnhbd70B2Ci98nKJa+AzQNzMcf/yAwROxbxxyaWcFVNCpkuwMXkwFrCs3FT0+7ggrfKmlZdczFLjKwsC7WLQJC56MeKNOCrv9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714817366; c=relaxed/simple;
	bh=9NBJ3QtWR1LDEZiKWzsHBfaMtVGq2Qq/cEZ+nOwNHVo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pmSn1jkTkwb7rM6JXbWMYd+1O5QkLN/KCC1nVbYU3WwpTETxczzP5BUSywDg0/pDqSxDY6Q8bMoGkbQNrZjjJ9j/i502oFIII8lR6fW3Smm2BGq4xUiGEYpCILjWyho+yN8WwemQoI0lRMt1HFaRxlsr1PVO6vdiT5NsaWUHBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da41da873bso68109939f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 03:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714817364; x=1715422164;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYawzRlSkA3jyqMHG4isuhTN3CTRnAsDTimGrTSgN0w=;
        b=raj459nl266Ewdd3Zk9lReypNUVtSBy4ksXFvCRyFkxLHqZ+zOwlMYiZlO7aZHp5k1
         ScBZcYtckkyT1TbZaFJzAZG1YiOmtP1SHbhnA9wmZChP49vEjQEXikR4uHACQTmGjQGw
         gMAsPjRSVyCDS29mNvXuvmprV1XYuETvu/otPkBwFPrAK9r3qY80dt/e1j1/HhfIVv7x
         fObPl4BjK6A0Da7ipOxhbxRinTC9TBuHzBvGtSoRZ+bblMsOyN9R7hPvunLpAu3fC1GP
         3qK5rq3x9yKU95HvHZn/yu+8z5nM9cKrVlO27GxewSf5krUQ1P8W+f7jpCxWpqMudDTQ
         ANcA==
X-Forwarded-Encrypted: i=1; AJvYcCWZoajfICjDsCwQ9upI+VxNlnTZLyKB9yC5XxWaT4ZN+TnXpgLYMT9t/JA2lqxjv8wMnmSAUnkxorEpxM97v+UlxhIfN2774uCJmghupQ==
X-Gm-Message-State: AOJu0Yxs1RsS5ZggsdZyh2dl4WL4QWXFp2UxCVfUucUT8fbXCx02ALrG
	z9vgUkfimUifvQrjM3QXJzZl+tpuSgO+xR+qvhy9Bs4mvk3wePNePUiROzXs8yjTS2iDX0xm18M
	g9M+vtg2kiCwvA1VvRmM2QcetKTlTVDGM7X4MX+iTEkJfbW7r/xSsjZA=
X-Google-Smtp-Source: AGHT+IEPiZy3lsXbFvcLtsfTCQh6QFDxmtkygcIWK6C67XOj4v6rbn9uPtAcfM9/bl8KcBQ8V3x3IVWZpdi9ieprSHWBN6RYIVFT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:36b:f8:e87e with SMTP id
 h4-20020a056e021d8400b0036b00f8e87emr379373ila.1.1714817363756; Sat, 04 May
 2024 03:09:23 -0700 (PDT)
Date: Sat, 04 May 2024 03:09:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d258a006179e07df@google.com>
Subject: [syzbot] [bcachefs?] WARNING in srcu_check_nmi_safety
From: syzbot <syzbot+62be362ff074b84ca393@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, kvm@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1143ae60980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45d8db3acdc1ccc6
dashboard link: https://syzkaller.appspot.com/bug?extid=62be362ff074b84ca393
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49d9f26b0beb/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2c424c14fff/bzImage-3d25a941.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62be362ff074b84ca393@syzkaller.appspotmail.com

------------[ cut here ]------------
CPU 0 old state 2 new state 1
WARNING: CPU: 0 PID: 110 at kernel/rcu/srcutree.c:702 srcu_check_nmi_safety+0x10e/0x130 kernel/rcu/srcutree.c:702
Modules linked in:
CPU: 0 PID: 110 Comm: kswapd0 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:srcu_check_nmi_safety+0x10e/0x130 kernel/rcu/srcutree.c:702
Code: c0 74 11 3c 03 7f 0d 89 54 24 04 e8 8c 9e 76 00 8b 54 24 04 8b b3 c8 01 00 00 44 89 e1 48 c7 c7 e0 40 0e 8b e8 23 c4 dc ff 90 <0f> 0b 90 90 e9 7b ff ff ff e8 64 9e 76 00 e9 65 ff ff ff e8 8a 9e
RSP: 0018:ffffc90000e4ee00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffe8ffad288000 RCX: ffffffff815139f9
RDX: ffff888019e54880 RSI: ffffffff81513a06 RDI: 0000000000000001
RBP: ffffc9000334a890 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000005 R12: 0000000000000001
R13: ffff888014c79c80 R14: ffffc9000334a890 R15: ffffc9000334a810
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f73ac1bc CR3: 000000004dd50000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 srcu_read_lock include/linux/srcu.h:213 [inline]
 __kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:614 [inline]
 kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:687 [inline]
 kvm_mmu_notifier_clear_flush_young+0x12f/0x700 arch/x86/kvm/../../../virt/kvm/kvm_main.c:912
 __mmu_notifier_clear_flush_young+0x110/0x1e0 mm/mmu_notifier.c:377
 mmu_notifier_clear_flush_young include/linux/mmu_notifier.h:421 [inline]
 folio_referenced_one+0x5d2/0xf60 mm/rmap.c:881
 rmap_walk_anon+0x226/0x580 mm/rmap.c:2599
 rmap_walk mm/rmap.c:2676 [inline]
 rmap_walk mm/rmap.c:2671 [inline]
 folio_referenced+0x288/0x4b0 mm/rmap.c:990
 folio_check_references mm/vmscan.c:835 [inline]
 shrink_folio_list+0x1a8a/0x3f00 mm/vmscan.c:1168
 evict_folios+0x6e6/0x1bb0 mm/vmscan.c:4537
 try_to_shrink_lruvec+0x618/0x9b0 mm/vmscan.c:4733
 shrink_one+0x3f8/0x7c0 mm/vmscan.c:4772
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
 shrink_node mm/vmscan.c:5894 [inline]
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

