Return-Path: <linux-fsdevel+bounces-77235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BxBFrb1kGkCeAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 23:22:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C713DB5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 23:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6131301C895
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B81314D1D;
	Sat, 14 Feb 2026 22:22:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E36303A18
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771107754; cv=none; b=CnKJivY5E+ilFi32hkNgzZmPGKxet+IwlDWTKLYUadazjXif0LKwgHe4MpXn4t3DNm8XmeGFnl5JnCzsyXmvUoGRCRCEP7nFxCuTQ5RXRUYw7p74uzBw+pIsVu5+0oN7pB6exr4pM8jAg9SYy0X7icVA30+29uhnOCz2wjwsEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771107754; c=relaxed/simple;
	bh=cY9EDC0bLiBjmY8V6AKr0uVLs1BH4/jLkBnenjlMrjs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rSlW4FgcD+nW36B3j2w5/hHuoUWm1elbSa2luOfvY0/FFiZII/AlPa+11ksZ2j8Sx/UMA5ot0759tTIfZIYiFYve6aK5L+iam7Yc734Db5RfU8ekNaVYrKkOMEW9uH6idNWraVYSK5bpnpo1qXqeQghRsSqeJqjLTjno8RW7dek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-409698ea4dbso19869049fac.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 14:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771107752; x=1771712552;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQvXiZ3bvjTqq9MfSaAXTHZyzhEp1Dv5jw/IRy11WWY=;
        b=fzHbYTSb1oUZJwOoGqzN7v9h7hTEndBM6g4eYC28ndN/7mgiKlC0QHytiUus4mekvI
         D8F9xMeiZDzFE0Y1TuxQx77JbwzFLFc6q813M23MqQZhfobTafZZMYuBr2YnEiAu9YOr
         oTJkB5NwrabMBgYPL+Tj7weZ4PCBIMd2ybfSgECaocoAb9C51f9vHVB0YvIGb9/aFTZx
         KP+UWMRo484/kzJDPbWHXqJu4bMLn6r0aOvI4RtPLd236vTqATGC+hOe2mUasJHpxoAc
         ol6q/Wm2x0tQvyQ49+yfvJIyTyyPJA11IEUa5Gkou0o/EJrkMZ/07pYCkPwArF3rmH44
         UVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMhionSNT5AYG+ui3wQCfail0xC/XPxZ5GvQ9tXFt76Xv2eybXBU8AfsOsNm4D3fkFjM4x0ztD/yl50CHt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo50V+npCyoXRvH7WnGB1ppHVa4JtR6Eferhrq2znpUikf0N9t
	Z12en2Yix+X8dGHh87DP2PP354Dfx9oTNMQlZB3veyzsqBaCNLbZ+jrWpsZtrcsP7XTf5elzf4/
	4/TqwRIOAgpXvpUyR9vTQakh3wKyPx+xCpc0cQkzLkTNMzcSTp8nRzAwj4pk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2283:b0:66a:e8cd:4954 with SMTP id
 006d021491bc7-6781fff0e52mr2384339eaf.7.1771107751898; Sat, 14 Feb 2026
 14:22:31 -0800 (PST)
Date: Sat, 14 Feb 2026 14:22:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6990f5a7.050a0220.3a4a67.018e.GAE@google.com>
Subject: [syzbot] [mm?] [block?] INFO: rcu detected stall in sendfile64
From: syzbot <syzbot+8b65a69dedebce19fd11@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77235-lists,linux-fsdevel=lfdr.de,8b65a69dedebce19fd11];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url]
X-Rspamd-Queue-Id: AE7C713DB5B
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    e98f34af6116 Merge tag 'i2c-for-6.19-final' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14abe7fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
dashboard link: https://syzkaller.appspot.com/bug?extid=8b65a69dedebce19fd11
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/495818579ef6/disk-e98f34af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a07da13c17ca/vmlinux-e98f34af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b38fd29e4a16/bzImage-e98f34af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b65a69dedebce19fd11@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6857/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=14329, q=377 ncpus=2)
task:syz.2.237       state:R  running task     stack:26360 pid:6857  tgid:6845  ppid:5832   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0x1522/0x51d0 kernel/sched/core.c:6867
 preempt_schedule_irq+0x4d/0xa0 kernel/sched/core.c:7194
 irqentry_exit+0x597/0x620 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_is_held_type+0x106/0x150 kernel/locking/lockdep.c:5945
Code: 18 00 00 b8 ff ff ff ff 65 0f c1 05 74 f3 5b 07 83 f8 01 75 25 9c 58 a9 00 02 00 00 75 39 41 f7 c4 00 02 00 00 74 01 fb 89 d8 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 a6 1e 79 f5 cc 90 0f 0b 90 48 c7
RSP: 0018:ffffc900037df408 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000046
RDX: ffff88802afdbd00 RSI: ffffffff8df35112 RDI: ffffffff8c073b00
RBP: 00000000ffffffff R08: ffffea0001dfa1c7 R09: 1ffffd40003bf438
R10: dffffc0000000000 R11: fffff940003bf439 R12: 0000000000000246
R13: ffff88802afdbd00 R14: ffffffff8e55a360 R15: 0000000000000000
 xa_entry include/linux/xarray.h:1226 [inline]
 xas_next include/linux/xarray.h:1912 [inline]
 filemap_get_read_batch+0x642/0x970 mm/filemap.c:2457
 filemap_get_pages+0x351/0x1ec0 mm/filemap.c:2680
 filemap_splice_read+0x5cd/0xd10 mm/filemap.c:3079
 do_splice_read fs/splice.c:982 [inline]
 splice_direct_to_actor+0x478/0xc70 fs/splice.c:1086
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x195/0x290 fs/splice.c:1230
 do_sendfile+0x535/0x7d0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1425 [inline]
 __se_sys_sendfile64+0xdf/0x1a0 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd7a899aeb9
RSP: 002b:00007fd7a9835028 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fd7a8c16180 RCX: 00007fd7a899aeb9
RDX: 0000200000000080 RSI: 0000000000000007 RDI: 0000000000000007
RBP: 00007fd7a8a08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 000000004d9b6eaf R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd7a8c16218 R14: 00007fd7a8c16180 R15: 00007ffc22589c58
 </TASK>
rcu: rcu_preempt kthread starved for 10431 jiffies! g14329 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28000 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0x1522/0x51d0 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:6964
 schedule_timeout+0x158/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x312/0x1560 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x9d/0x3b0 kernel/rcu/tree.c:2285
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 6846 Comm: syz.0.238 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0xcea/0x1270 kernel/smp.c:877
Code: 89 ee 83 e6 01 31 ff e8 c4 db 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 6f d7 0b 00 eb 38 f3 90 42 0f b6 04 2b <84> c0 75 11 41 f7 04 24 01 00 00 00 74 1e e8 53 d7 0b 00 eb e4 44
RSP: 0018:ffffc900038cf4a0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff110170e8129 RCX: ffff88801aba3d00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900038cf5c8 R08: ffff8880249a3047 R09: 1ffff11004934608
R10: dffffc0000000000 R11: ffffffff81778480 R12: ffff8880b8740948
R13: dffffc0000000000 R14: ffff8880b863bb00 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881256f3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b06ff8 CR3: 0000000075c65000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1043
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1382 [inline]
 flush_tlb_mm_range+0x5c3/0x10c0 arch/x86/mm/tlb.c:1472
 tlb_flush arch/x86/include/asm/tlb.h:23 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:506 [inline]
 zap_pte_range mm/memory.c:1885 [inline]
 zap_pmd_range mm/memory.c:1950 [inline]
 zap_pud_range mm/memory.c:1978 [inline]
 zap_p4d_range mm/memory.c:1999 [inline]
 unmap_page_range+0x3780/0x4030 mm/memory.c:2020
 unmap_single_vma mm/memory.c:2062 [inline]
 unmap_vmas+0x3c0/0x5c0 mm/memory.c:2104
 exit_mmap+0x251/0xb30 mm/mmap.c:1277
 __mmput+0x118/0x430 kernel/fork.c:1173
 exit_mm+0x168/0x220 kernel/exit.c:581
 do_exit+0x62e/0x2310 kernel/exit.c:959
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 __do_sys_exit_group kernel/exit.c:1123 [inline]
 __se_sys_exit_group kernel/exit.c:1121 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
 x64_sys_call+0x2210/0x2210 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f986059aeb9
Code: Unable to access opcode bytes at 0x7f986059ae8f.
RSP: 002b:00007ffd0f27cf08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f986059aeb9
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffd0f27cf6c R08: 0000000000000000 R09: 00000000000927c0
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000023
R13: 00000000000927c0 R14: 000000000003162f R15: 00007ffd0f27cfc0
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

