Return-Path: <linux-fsdevel+bounces-79708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 26AvDRzxrGk/wQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 04:46:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D445822E70C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 04:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C6DE301C939
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3015B971;
	Sun,  8 Mar 2026 03:46:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16062C86D
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772941588; cv=none; b=J0br3tgmgaiYRg9rLptxZlFxUr7OPiF4IPZVR3qkLZNDkS5rruGoOaiveFSaWeykcQCJJA4UFowSNSPDERbBnGLfVVwp2g8GImaeC5MDVyQN6pVhxNSjSo3jVwP66L5su1tum4/7lic61Q4UGxgeOD2fHIPoztnVoA+Ft87APi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772941588; c=relaxed/simple;
	bh=kpVVg4A0p360lD2PEuuW/TzE2gArTFNJacIClykQFKs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JnWReAeiOG3Emr0SdS+5QT51j2Xk1s89Jg6o07I96RXbTyBouVlb7AA8r/Wb65pT9Uz6QA2h2Cmod7iP3cGdgAhgy6GPV7TBf8d5JaxjRIqYhu/hBGWy2rLCk4SIu4RS9yooWQXBgeoAyiwhURIt2iVuZ0OS08uFZvmqdg6fpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679a409a175so164321201eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 19:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772941586; x=1773546386;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8wk8zid47gA2M0j21Iv8olCGdRRUe6HZ57CArxCQlg=;
        b=vmZNJJU/AEyGj6urMQudLuwD0RxlU2x7HlLZb2bN7SrkY0no5p6fJ6gm6KTo7ZeP2z
         SutIDTocJM9emVGJ4eeYEbLlds5TMND4FERd1SAlgcYCOl2hbxugvIIfh5IWnMTruADF
         b20sQRANrc7NzV8KphGesGDTHfTcfeaezWsNtseAg+7nH0+dr/wkY5WpLfnOoBwEE0GQ
         haF30OEcOvP4uTiuOZ7iniy5lxJ+Rz0MAdOmkbF/bb/7ZDt8uvijdgLi3q/RehO7Qnfd
         9o/w8cmLTHdYX5nZe4qU5q6K5Uu5ppk48wuNNZaGfUdRHUx9fI1Q2OmC0fQ7YfmeSAfc
         BEeg==
X-Forwarded-Encrypted: i=1; AJvYcCV6rmp7UQuiTx+T2eDKOrMZVeP5Dqhd2RccYQ2V3p1eR4Aju5OPXUmrC3yC5uic00xYtsS2h2eiHpVpsgOs@vger.kernel.org
X-Gm-Message-State: AOJu0YybyEf1ydayO/Egx75GjF/+9oIGuv1lhsfqByRQKlDCbyxC3Ojr
	7c/ZanM4+CASTmK2pYvsOuBThrZgm/k+9YVbqMStv7Dr1EiuLvXAExxK/jvWGeCvRKEMyCAWEWD
	WMTeVD6tIRi4cyk8hW7hsKqnhynz5TF6qNcr7JqnJE9gKoLGCXs2bDcllx1Y=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f034:b0:679:e68b:f956 with SMTP id
 006d021491bc7-67b9bca1364mr4573230eaf.17.1772941585900; Sat, 07 Mar 2026
 19:46:25 -0800 (PST)
Date: Sat, 07 Mar 2026 19:46:25 -0800
In-Reply-To: <69abb4e3.050a0220.13f275.003d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69acf111.050a0220.310d8.0003.GAE@google.com>
Subject: Re: [syzbot] [fuse?] general protection fault in task_work_cancel
From: syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
To: gnoack@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mic@digikod.net, miklos@szeredi.hu, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D445822E70C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=779072223d02a312];
	MID_RHS_MATCH_TO(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-79708-lists,linux-fsdevel=lfdr.de,741e2278ef71fef03a10];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.896];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,storage.googleapis.com:url]
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    4ae12d8bd9a8 Merge tag 'kbuild-fixes-7.0-2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dc475a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
dashboard link: https://syzkaller.appspot.com/bug?extid=741e2278ef71fef03a10
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130b075a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/010ac4052aed/disk-4ae12d8b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2aad8bef9031/vmlinux-4ae12d8b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd350ec4896a/bzImage-4ae12d8b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000013c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000009e0-0x00000000000009e7]
CPU: 1 UID: 0 PID: 13249 Comm: syz.1.1775 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:task_work_pending include/linux/task_work.h:26 [inline]
RIP: 0010:task_work_cancel_match kernel/task_work.c:124 [inline]
RIP: 0010:task_work_cancel+0x8a/0x220 kernel/task_work.c:187
Code: b8 f1 f1 f1 f1 f8 f3 f3 f3 4b 89 44 25 00 e8 ad b9 35 00 43 c6 44 25 04 00 49 89 de 48 81 c3 e0 09 00 00 49 89 df 49 c1 ef 03 <43> 80 3c 27 00 74 08 48 89 df e8 17 fe 9f 00 48 83 3b 00 75 51 e8
RSP: 0018:ffffc9000ddffb20 EFLAGS: 00010216
RAX: ffffffff818fdfc3 RBX: 00000000000009e0 RCX: ffff88805d5c3d00
RDX: 0000000000000000 RSI: ffff888032f5c540 RDI: 0000000000000000
RBP: ffffc9000ddffbd0 R08: ffffc9000ddffc97 R09: 1ffff92001bbff92
R10: dffffc0000000000 R11: fffff52001bbff93 R12: dffffc0000000000
R13: 1ffff92001bbff68 R14: 0000000000000000 R15: 000000000000013c
FS:  00007f9c8a1cb6c0(0000) GS:ffff888125561000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 0000000059bf0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 cancel_tsync_works security/landlock/tsync.c:415 [inline]
 landlock_restrict_sibling_threads+0xdc4/0x11f0 security/landlock/tsync.c:533
 __do_sys_landlock_restrict_self security/landlock/syscalls.c:574 [inline]
 __se_sys_landlock_restrict_self+0x540/0x810 security/landlock/syscalls.c:482
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c8939c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c8a1cb028 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
RAX: ffffffffffffffda RBX: 00007f9c89616180 RCX: 00007f9c8939c799
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000003
RBP: 00007f9c89432bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9c89616218 R14: 00007f9c89616180 R15: 00007ffee5d65d48
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:task_work_pending include/linux/task_work.h:26 [inline]
RIP: 0010:task_work_cancel_match kernel/task_work.c:124 [inline]
RIP: 0010:task_work_cancel+0x8a/0x220 kernel/task_work.c:187
Code: b8 f1 f1 f1 f1 f8 f3 f3 f3 4b 89 44 25 00 e8 ad b9 35 00 43 c6 44 25 04 00 49 89 de 48 81 c3 e0 09 00 00 49 89 df 49 c1 ef 03 <43> 80 3c 27 00 74 08 48 89 df e8 17 fe 9f 00 48 83 3b 00 75 51 e8
RSP: 0018:ffffc9000ddffb20 EFLAGS: 00010216
RAX: ffffffff818fdfc3 RBX: 00000000000009e0 RCX: ffff88805d5c3d00
RDX: 0000000000000000 RSI: ffff888032f5c540 RDI: 0000000000000000
RBP: ffffc9000ddffbd0 R08: ffffc9000ddffc97 R09: 1ffff92001bbff92
R10: dffffc0000000000 R11: fffff52001bbff93 R12: dffffc0000000000
R13: 1ffff92001bbff68 R14: 0000000000000000 R15: 000000000000013c
FS:  00007f9c8a1cb6c0(0000) GS:ffff888125561000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f810d34da08 CR3: 0000000059bf0000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	b8 f1 f1 f1 f1       	mov    $0xf1f1f1f1,%eax
   5:	f8                   	clc
   6:	f3 f3 f3 4b 89 44 25 	repz repz xrelease mov %rax,0x0(%r13,%r12,1)
   d:	00
   e:	e8 ad b9 35 00       	call   0x35b9c0
  13:	43 c6 44 25 04 00    	movb   $0x0,0x4(%r13,%r12,1)
  19:	49 89 de             	mov    %rbx,%r14
  1c:	48 81 c3 e0 09 00 00 	add    $0x9e0,%rbx
  23:	49 89 df             	mov    %rbx,%r15
  26:	49 c1 ef 03          	shr    $0x3,%r15
* 2a:	43 80 3c 27 00       	cmpb   $0x0,(%r15,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 17 fe 9f 00       	call   0x9ffe50
  39:	48 83 3b 00          	cmpq   $0x0,(%rbx)
  3d:	75 51                	jne    0x90
  3f:	e8                   	.byte 0xe8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

