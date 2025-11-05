Return-Path: <linux-fsdevel+bounces-67202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06327C37CB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 21:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84CEE34F78D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3492D8792;
	Wed,  5 Nov 2025 20:56:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B49277007
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376167; cv=none; b=N405GCZhMZYajUkBilL9ZxN5rUZCxdOoVh7tjbTvUNiVvYV9AIcZAIgvJgDZtzsj4WfwNHMzQOvoswHNlo5mPxaSM/6WSzOKnTec/wNzDDir/NgLz2EAQu5KjdSWus4ARuUPeVvwcpdLMbkCPJKUNAVmvQ4lmaKrXZGxKh+sOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376167; c=relaxed/simple;
	bh=hzBpjQv+o/DTCWMu5DBoc+BvgEjP1zhwMOs2yiBIAgw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qOVNrei4ZZiQ0v0IDpjZM4/f+vaNFQtAK6FGp7/biG20OMpARaJ5m2LLBcjpE87cbabqxYoafg9UHwU0RKNHEHeeRzdaTrxj+ip0TOZdu0HOCFZRaSQrQlzMr5BpQg0lqKqXe333/ZXto/1IvkeFNvI19347EExDulO4pjkXwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43331f93979so2967035ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 12:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762376163; x=1762980963;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3ADeQpiOp638EHQGkX4nAhqUuOM9S519pNeKBgwEtw=;
        b=VlZhYcw7DAtWNBrBI/jOniEMsGIGDUxPaEa/yJxkS1gTvJCeR+ltmPbrnsDt3PzT5B
         4nNb8+AkBmbVnP61xFy9IPFsGkzLE9K/pBzSvQBosWFN8aZ41C6P9WvYzT9llV1nT8+6
         dRoxtG/62Y0VoFKKVoehms0PhS6m+ceZeYir1ProOCL/x3EKn6KeQGoAPdBQU7KdD5UM
         oH9y/A3Pw6Ly3kxBiIIIcsSqF7XFeLhprewLnbhWKlxkAQ0zLDanEYIPxJcKvWBuTLHM
         /Z5hP4cFAOVymKDf3/ubmj4jRbUGKdmag13sM078NYMGjdmThl7ODi3kWWn3MvgkPZju
         yKlg==
X-Forwarded-Encrypted: i=1; AJvYcCVYRRXOzu2R9C16doHElTXJalJdMoF7wUKdMFvIkcK90GHu7TQoY9yUVdT7OcRwJxq5MbKBDc0C9QrEPuth@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/6Vosw+nU8+SjLge9B9TUDaFovw7Lha3XR6sPcOQs9+NbG4z
	VhmbSq5Dlcs9GSQOjrK1xNCdhEAQOiJe36LZpcPkRpz94gLspgdw8Lw5OOvKDp/YpMh7AFr26Bs
	BtyDBQ2wu8+5HFIhw1bPEpBp4IOvxQtgURjoZodzPYWSa5ZbFb0bbqukv+uY=
X-Google-Smtp-Source: AGHT+IGiah7ThoXyNFEfYoip3cikOQAREySwBKaKQy+xzpkpiT14araBKpr4synk9JGzeisDrHn24NyjFVbKiWAi6riZ4lBN93Af
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2503:b0:433:2d7d:b8d8 with SMTP id
 e9e14a558f8ab-4334ee298ecmr13672955ab.1.1762376163425; Wed, 05 Nov 2025
 12:56:03 -0800 (PST)
Date: Wed, 05 Nov 2025 12:56:03 -0800
In-Reply-To: <20251105193800.2340868-1-mic@digikod.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bb9e3.050a0220.3d0d33.009d.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, gnoack@google.com, hdanton@sina.com, 
	jack@suse.cz, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	m@maowtm.org, max.kellermann@ionos.com, mic@digikod.net, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

f
[  104.167925][ T5820]  ? clear_bhb_loop+0x60/0xb0
[  104.167948][ T5820]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  104.167967][ T5820] RIP: 0033:0x7f9a9fef16c5
[  104.167983][ T5820] Code: Unable to access opcode bytes at 0x7f9a9fef169=
b.
[  104.167993][ T5820] RSP: 002b:00007fff0fc3e0f8 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000e7
[  104.168021][ T5820] RAX: ffffffffffffffda RBX: 00005583ec761b10 RCX: 000=
07f9a9fef16c5
[  104.168036][ T5820] RDX: 00000000000000e7 RSI: fffffffffffffe68 RDI: 000=
0000000000000
[  104.168048][ T5820] RBP: 00005583ec738910 R08: 0000000000000000 R09: 000=
0000000000000
[  104.168060][ T5820] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
[  104.168071][ T5820] R13: 00007fff0fc3e140 R14: 0000000000000000 R15: 000=
0000000000000
[  104.168101][ T5820]  </TASK>
2025/11/05 20:54:56 parsed 1 programs
[  105.509351][ T5829] BUG: sleeping function called from invalid context a=
t fs/inode.c:1920
[  105.518601][ T5829] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 5829, name: syz-execprog
[  105.528439][ T5829] preempt_count: 1, expected: 0
[  105.533521][ T5829] RCU nest depth: 0, expected: 0
[  105.538811][ T5829] 1 lock held by syz-execprog/5829:
[  105.544194][ T5829]  #0: ffff88807e6f68d8 (&sb->s_type->i_lock_key#9){+.=
+.}-{3:3}, at: iput+0x2db/0x1050
[  105.554222][ T5829] Preemption disabled at:
[  105.554232][ T5829] [<0000000000000000>] 0x0
[  105.564065][ T5829] CPU: 0 UID: 0 PID: 5829 Comm: syz-execprog Tainted: =
G        W           syzkaller #0 PREEMPT(full)=20
[  105.564091][ T5829] Tainted: [W]=3DWARN
[  105.564096][ T5829] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[  105.564105][ T5829] Call Trace:
[  105.564114][ T5829]  <TASK>
[  105.564121][ T5829]  dump_stack_lvl+0x189/0x250
[  105.564144][ T5829]  ? __pfx_dump_stack_lvl+0x10/0x10
[  105.564160][ T5829]  ? __pfx__printk+0x10/0x10
[  105.564176][ T5829]  ? call_rcu+0x6ff/0x9c0
[  105.564197][ T5829]  ? print_lock_name+0xde/0x100
[  105.564218][ T5829]  __might_resched+0x495/0x610
[  105.564241][ T5829]  ? __pfx___might_resched+0x10/0x10
[  105.564258][ T5829]  ? do_raw_spin_lock+0x121/0x290
[  105.564286][ T5829]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  105.564320][ T5829]  iput+0x741/0x1050
[  105.564352][ T5829]  __dentry_kill+0x209/0x660
[  105.564371][ T5829]  ? dput+0x37/0x2b0
[  105.564389][ T5829]  dput+0x19f/0x2b0
[  105.564406][ T5829]  __fput+0x68e/0xa70
[  105.564431][ T5829]  fput_close_sync+0x113/0x220
[  105.564450][ T5829]  ? __pfx_fput_close_sync+0x10/0x10
[  105.564470][ T5829]  ? do_raw_spin_unlock+0x122/0x240
[  105.564495][ T5829]  __x64_sys_close+0x7f/0x110
[  105.564517][ T5829]  do_syscall_64+0xfa/0xfa0
[  105.564541][ T5829]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  105.564558][ T5829]  ? clear_bhb_loop+0x60/0xb0
[  105.564577][ T5829]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  105.564593][ T5829] RIP: 0033:0x40dd0e
[  105.564610][ T5829] Code: 24 28 44 8b 44 24 2c e9 70 ff ff ff cc cc cc c=
c cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0=
f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
[  105.564625][ T5829] RSP: 002b:000000c002db1760 EFLAGS: 00000212 ORIG_RAX=
: 0000000000000003
[  105.564688][ T5829] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000=
000000040dd0e
[  105.564701][ T5829] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000003
[  105.564711][ T5829] RBP: 000000c002db17a0 R08: 0000000000000000 R09: 000=
0000000000000
[  105.564723][ T5829] R10: 0000000000000000 R11: 0000000000000212 R12: 000=
000c002db18c0
[  105.564735][ T5829] R13: 00000000000007ff R14: 000000c000002380 R15: 000=
000c0008937c0
[  105.564765][ T5829]  </TASK>
[  107.337546][ T5837] BUG: sleeping function called from invalid context a=
t fs/inode.c:1920
[  107.347227][ T5837] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 5837, name: dhcpcd
[  107.356267][ T5837] preempt_count: 1, expected: 0
[  107.361915][ T5837] RCU nest depth: 0, expected: 0
[  107.367125][ T5837] 1 lock held by dhcpcd/5837:
[  107.373083][ T5837]  #0: ffff88807e6fa3d8 (&sb->s_type->i_lock_key#9){+.=
+.}-{3:3}, at: iput+0x2db/0x1050
[  107.384068][ T5837] Preemption disabled at:
[  107.384082][ T5837] [<0000000000000000>] 0x0
[  107.393377][ T5837] CPU: 1 UID: 0 PID: 5837 Comm: dhcpcd Tainted: G     =
   W           syzkaller #0 PREEMPT(full)=20
[  107.393403][ T5837] Tainted: [W]=3DWARN
[  107.393408][ T5837] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[  107.393417][ T5837] Call Trace:
[  107.393424][ T5837]  <TASK>
[  107.393430][ T5837]  dump_stack_lvl+0x189/0x250
[  107.393456][ T5837]  ? __pfx_dump_stack_lvl+0x10/0x10
[  107.393480][ T5837]  ? __pfx__printk+0x10/0x10
[  107.393503][ T5837]  ? print_lock_name+0xde/0x100
[  107.393526][ T5837]  __might_resched+0x495/0x610
[  107.393553][ T5837]  ? __pfx___might_resched+0x10/0x10
[  107.393570][ T5837]  ? do_raw_spin_lock+0x121/0x290
[  107.393597][ T5837]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  107.393632][ T5837]  iput+0x741/0x1050
[  107.393662][ T5837]  __dentry_kill+0x209/0x660
[  107.393681][ T5837]  ? dput+0x37/0x2b0
[  107.393699][ T5837]  dput+0x19f/0x2b0
[  107.393717][ T5837]  __fput+0x68e/0xa70
[  107.393749][ T5837]  fput_close_sync+0x113/0x220
[  107.393768][ T5837]  ? __pfx_fput_close_sync+0x10/0x10
[  107.393790][ T5837]  ? do_raw_spin_unlock+0x122/0x240
[  107.393819][ T5837]  __x64_sys_close+0x7f/0x110
[  107.393843][ T5837]  do_syscall_64+0xfa/0xfa0
[  107.393871][ T5837]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  107.393890][ T5837]  ? clear_bhb_loop+0x60/0xb0
[  107.393915][ T5837]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  107.393933][ T5837] RIP: 0033:0x7fc58c16c407
[  107.393950][ T5837] Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 0=
0 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0=
f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  107.393968][ T5837] RSP: 002b:00007ffc1197cc80 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000003
[  107.393988][ T5837] RAX: ffffffffffffffda RBX: 00007fc58c0e2740 RCX: 000=
07fc58c16c407
[  107.394002][ T5837] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000003
[  107.394014][ T5837] RBP: 000055fc7ab074b0 R08: 0000000000000000 R09: 000=
0000000000000
[  107.394026][ T5837] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
0000000000000
[  107.394038][ T5837] R13: 000055fc83902290 R14: 0000000000000000 R15: 000=
055fc7ab1cac0
[  107.394071][ T5837]  </TASK>
[  108.750656][ T5835] cgroup: Unknown subsys name 'net'
[  108.759273][ T5835] BUG: sleeping function called from invalid context a=
t fs/inode.c:1920
[  108.769492][ T5835] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 5835, name: syz-executor
[  108.782190][ T5835] preempt_count: 1, expected: 0
[  108.787683][ T5835] RCU nest depth: 0, expected: 0
[  108.792976][ T5835] 2 locks held by syz-executor/5835:
[  108.799370][ T5835]  #0: ffff8880340e80e0 (&type->s_umount_key#44){+.+.}=
-{4:4}, at: deactivate_super+0xa9/0xe0
[  108.811870][ T5835]  #1: ffff888077e41970 (&sb->s_type->i_lock_key#33){+=
.+.}-{3:3}, at: iput+0x2db/0x1050
[  108.822811][ T5835] Preemption disabled at:
[  108.822824][ T5835] [<0000000000000000>] 0x0
[  108.833460][ T5835] CPU: 1 UID: 0 PID: 5835 Comm: syz-executor Tainted: =
G        W           syzkaller #0 PREEMPT(full)=20
[  108.833488][ T5835] Tainted: [W]=3DWARN
[  108.833493][ T5835] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[  108.833502][ T5835] Call Trace:
[  108.833508][ T5835]  <TASK>
[  108.833515][ T5835]  dump_stack_lvl+0x189/0x250
[  108.833542][ T5835]  ? __pfx_dump_stack_lvl+0x10/0x10
[  108.833561][ T5835]  ? __pfx__printk+0x10/0x10
[  108.833580][ T5835]  ? print_lock_name+0xde/0x100
[  108.833601][ T5835]  __might_resched+0x495/0x610
[  108.833625][ T5835]  ? __pfx___might_resched+0x10/0x10
[  108.833642][ T5835]  ? do_raw_spin_lock+0x121/0x290
[  108.833666][ T5835]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  108.833699][ T5835]  iput+0x741/0x1050
[  108.833731][ T5835]  __dentry_kill+0x209/0x660
[  108.833751][ T5835]  ? dput+0x37/0x2b0
[  108.833770][ T5835]  dput+0x19f/0x2b0
[  108.833789][ T5835]  shrink_dcache_for_umount+0xa0/0x170
[  108.833815][ T5835]  generic_shutdown_super+0x67/0x2c0
[  108.833843][ T5835]  kill_anon_super+0x3b/0x70
[  108.833868][ T5835]  kernfs_kill_sb+0x161/0x180
[  108.833895][ T5835]  deactivate_locked_super+0xbc/0x130
[  108.833920][ T5835]  cleanup_mnt+0x425/0x4c0
[  108.833943][ T5835]  ? lockdep_hardirqs_on+0x9c/0x150
[  108.833970][ T5835]  task_work_run+0x1d4/0x260
[  108.833998][ T5835]  ? __pfx_task_work_run+0x10/0x10
[  108.834027][ T5835]  ? exit_to_user_mode_loop+0x55/0x4f0
[  108.834058][ T5835]  exit_to_user_mode_loop+0xff/0x4f0
[  108.834084][ T5835]  ? rcu_is_watching+0x15/0xb0
[  108.834109][ T5835]  do_syscall_64+0x2e9/0xfa0
[  108.834135][ T5835]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  108.834152][ T5835]  ? clear_bhb_loop+0x60/0xb0
[  108.834175][ T5835]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  108.834192][ T5835] RIP: 0033:0x7f2c235901f7
[  108.834208][ T5835] Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1=
f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
[  108.834224][ T5835] RSP: 002b:00007ffeee90f4f8 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000a6
[  108.834244][ T5835] RAX: 0000000000000000 RBX: 00007ffeee90f5f0 RCX: 000=
07f2c235901f7
[  108.834256][ T5835] RDX: 00007f2c23623d15 RSI: 0000000000000000 RDI: 000=
07f2c236125ca
[  108.834266][ T5835] RBP: 00007f2c236125ca R08: 00007f2c236128ae R09: 000=
0000000000000
[  108.834277][ T5835] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07f2c23612844
[  108.834287][ T5835] R13: 00007f2c23623d15 R14: 00007ffeee90f608 R15: 000=
07ffeee90f500
[  108.834313][ T5835]  </TASK>
[  109.214905][ T5835] cgroup: Unknown subsys name 'cpuset'
[  109.226104][ T5835] cgroup: Unknown subsys name 'rlimit'
[  110.666383][ T5835] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[  110.845546][ T5195] BUG: sleeping function called from invalid context a=
t fs/inode.c:1920
[  110.854984][ T5195] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 5195, name: udevd
[  110.865089][ T5195] preempt_count: 1, expected: 0
[  110.870130][ T5195] RCU nest depth: 0, expected: 0
[  110.875858][ T5195] 2 locks held by udevd/5195:
[  110.881834][ T5195]  #0: ffff88802feb6420 (sb_writers#5){.+.+}-{0:0}, at=
: mnt_want_write+0x41/0x90
[  110.893073][ T5195]  #1: ffff8880306928e8 (&sb->s_type->i_lock_key){+.+.=
}-{3:3}, at: iput+0x2db/0x1050
[  110.903490][ T5195] Preemption disabled at:
[  110.903505][ T5195] [<0000000000000000>] 0x0
[  110.912829][ T5195] CPU: 1 UID: 0 PID: 5195 Comm: udevd Tainted: G      =
  W           syzkaller #0 PREEMPT(full)=20
[  110.912861][ T5195] Tainted: [W]=3DWARN
[  110.912867][ T5195] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[  110.912878][ T5195] Call Trace:
[  110.912886][ T5195]  <TASK>
[  110.912894][ T5195]  dump_stack_lvl+0x189/0x250
[  110.912924][ T5195]  ? __pfx_dump_stack_lvl+0x10/0x10
[  110.912946][ T5195]  ? __pfx__printk+0x10/0x10
[  110.912969][ T5195]  ? print_lock_name+0xde/0x100
[  110.912994][ T5195]  __might_resched+0x495/0x610
[  110.913020][ T5195]  ? __pfx___might_resched+0x10/0x10
[  110.913036][ T5195]  ? do_raw_spin_lock+0x121/0x290
[  110.913063][ T5195]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  110.913095][ T5195]  iput+0x741/0x1050
[  110.913122][ T5195]  do_unlinkat+0x39f/0x560
[  110.913155][ T5195]  ? __pfx_do_unlinkat+0x10/0x10
[  110.913182][ T5195]  ? strncpy_from_user+0x150/0x2c0
[  110.913209][ T5195]  ? getname_flags+0x1e5/0x540
[  110.913232][ T5195]  __x64_sys_unlink+0x47/0x50
[  110.913267][ T5195]  do_syscall_64+0xfa/0xfa0
[  110.913295][ T5195]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  110.913313][ T5195]  ? clear_bhb_loop+0x60/0xb0
[  110.913335][ T5195]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  110.913354][ T5195] RIP: 0033:0x7f9a9ff15937
[  110.913371][ T5195] Code: 00 00 e9 a9 fd ff ff 66 2e 0f 1f 84 00 00 00 0=
0 00 66 90 b8 5f 00 00 00 0f 05 c3 0f 1f 84 00 00 00 00 00 b8 57 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 91 b4 0d 00 f7 d8 64 89 02 b8
[  110.913387][ T5195] RSP: 002b:00007fff0fc3e2a8 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000057
[  110.913408][ T5195] RAX: ffffffffffffffda RBX: 0000000000000bb8 RCX: 000=
07f9a9ff15937
[  110.913422][ T5195] RDX: ffffffffffffffff RSI: 000000000000000b RDI: 000=
05583c5bc802e
[  110.913434][ T5195] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
0000000000000
[  110.913445][ T5195] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
0000000000000
[  110.913456][ T5195] R13: 00005583c5be3100 R14: 0000000000000000 R15: 000=
0000000000000
[  110.913486][ T5195]  </TASK>


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2124321294=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 7e2882b3269
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D7e2882b32698b70f3149aee00c41e3d2d941dca3 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251007-152513"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D7e2882b32698b70f3149aee00c41e3d2d941dca3 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251007-152513"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D7e2882b32698b70f3149aee00c41e3d2d941dca3 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251007-152513"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"7e2882b32698b70f3149aee00c41e3d2d9=
41dca3\"
/usr/bin/ld: /tmp/ccT2jI60.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11651084580000


Tested on:

commit:         84d39fb9 Add linux-next specific files for 20251105
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbebc0cb9c2989b8=
1
dashboard link: https://syzkaller.appspot.com/bug?extid=3D12479ae15958fc3f5=
4ec
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D139f532f9800=
00


