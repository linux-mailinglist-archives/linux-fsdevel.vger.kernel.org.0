Return-Path: <linux-fsdevel+bounces-77052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB8aOIMojmkMAQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:22:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C71130AC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE213078346
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC99299AB4;
	Thu, 12 Feb 2026 19:22:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DB26E70E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924156; cv=none; b=ja4OrsSYj/k1ZPcg9KBEYaudrbcTpPBwRb17UuYaZUqH+qJjFAjS9/FLKvZ9ZaHEAMR6kVRD6YOPiNGS2wPriKCTz4btuGPi+aAdUpjvPxk4CeDZyKM1fU+sIcs4pKJRvHBjO2O7vw1HnTiX0QDao/VcEDMAieAl+C9pU6z3d3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924156; c=relaxed/simple;
	bh=S8OoBISBizJg7F7k5CiKnBtA9jF49/0Dumxi22m6VsI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oq/7mCwNsUgr5HjOwC3yY51modWwpqHcIHZwYu7B/VF9CQ22Mx5wJydD+4JXCOh5iLxIuAPRy/xfqG7tORFHl4qz/SyO7RhyyL87v0phW0fSqyr5ozPuqxYXlmf/4K0PFePUEMyEhSpXNZjzV7xlhj+387wRpT9cNOXXD2vTRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-673e436f408so1506546eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 11:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770924154; x=1771528954;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9U1xTNe4CWOuUec/C6SZgDMnREzW4ls0e04WxYgjXQ4=;
        b=O42ThvQQZZFDzjlyKlQp+IwhxIjQKD+zLtv9Qn/mhvblRUHae7IyJ6O6Nh/rh8H1kW
         /7dQLRhHyPj7bu0eHe9wMhwmmWagIprS4yvrLvkc51aZEFYVPy7T0WQ1ZbtbxaDiR+G+
         QBRVzIkbMJefg1qcB1FtJsHlTjWWwH3WOHl8msLJr67bXan79jivZGaR2fUSTj+VsGrx
         MvylEVhoPOLaKwn8LsKdsNS4NBybfDwlVN3PslQgMu4tNg/SmIc9HSj/qzOLC+avGtD0
         6+ce+GwwZCD3Qczd4ESvSjA2kmMQ1KL/8gvYApWNJ8VvvWalnTmLLvDRMmiwYsrqGCgT
         ETfw==
X-Forwarded-Encrypted: i=1; AJvYcCXqNENGoeYgoO+/zdxSOJx1yZHEMr22km8HpkbdG3N96W9gU7M78vaoFgXvQZ28qIYCG5djxiI1gj8ZopYk@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeXbyIKMvXh4rQz31plwclgYHEfZanwdFf7MaCgSaZ6fdIf3T
	fKXPfMi+sJi1G2p2xkxzW/JEm3524nBD8MaFw1RwI4IaG6ssy1VfQORhu+1leRs9I1qAhg/QikE
	sxebMOn2hswgnDpotAkW3R5RY7R4Av3/Qip/x48FFDKB+CmdwlXwq/hBCPIg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1352:b0:675:2e2e:56a6 with SMTP id
 006d021491bc7-6759bba81e6mr1335065eaf.74.1770924154130; Thu, 12 Feb 2026
 11:22:34 -0800 (PST)
Date: Thu, 12 Feb 2026 11:22:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698e287a.a70a0220.2c38d7.009e.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in grab_requested_root
From: syzbot <syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=86c6013ce1247095];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77052-lists,linux-fsdevel=lfdr.de,9e03a9535ea65f687a44];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,appspotmail.com:email,storage.googleapis.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 45C71130AC2
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    dc855b77719f Merge tag 'irq-drivers-2026-02-09' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13136ae6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86c6013ce1247095
dashboard link: https://syzkaller.appspot.com/bug?extid=9e03a9535ea65f687a44
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15da0b3a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e28e5a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a31372ead89f/disk-dc855b77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/657357081566/vmlinux-dc855b77.xz
kernel image: https://storage.googleapis.com/syzbot-assets/278d7f265ba3/bzImage-dc855b77.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000001e: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000f0-0x00000000000000f7]
CPU: 0 UID: 0 PID: 5998 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:mnt_ns_empty fs/mount.h:197 [inline]
RIP: 0010:grab_requested_root+0xde/0x3c0 fs/namespace.c:5636
Code: 02 00 00 49 39 5d 18 0f 84 cd 01 00 00 e8 0a 10 78 ff 48 8d bb 08 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 82 02 00 00 48 8b 83 08 01 00 00 48 85 c0 0f 84
RSP: 0018:ffffc90003027d88 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffffffffffffea RCX: ffffffff828e8167
RDX: 000000000000001e RSI: ffffffff828e7fb6 RDI: 00000000000000f2
RBP: ffffc90003027db0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802b220000
R13: ffff88803156d4e0 R14: ffff88807b4d7028 R15: ffff88807b4d7010
FS:  000055555e0dd500(0000) GS:ffff8881245bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002c608000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_statmount fs/namespace.c:5699 [inline]
 __do_sys_statmount+0x359/0x2440 fs/namespace.c:5949
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f12d359bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd0e2fee68 EFLAGS: 00000246 ORIG_RAX: 00000000000001c9
RAX: ffffffffffffffda RBX: 00007f12d3815fa0 RCX: 00007f12d359bf79
RDX: 00000000000001fe RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f12d36327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f12d3815fac R14: 00007f12d3815fa0 R15: 00007f12d3815fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mnt_ns_empty fs/mount.h:197 [inline]
RIP: 0010:grab_requested_root+0xde/0x3c0 fs/namespace.c:5636
Code: 02 00 00 49 39 5d 18 0f 84 cd 01 00 00 e8 0a 10 78 ff 48 8d bb 08 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 82 02 00 00 48 8b 83 08 01 00 00 48 85 c0 0f 84
RSP: 0018:ffffc90003027d88 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffffffffffffea RCX: ffffffff828e8167
RDX: 000000000000001e RSI: ffffffff828e7fb6 RDI: 00000000000000f2
RBP: ffffc90003027db0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802b220000
R13: ffff88803156d4e0 R14: ffff88807b4d7028 R15: ffff88807b4d7010
FS:  000055555e0dd500(0000) GS:ffff8881245bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002c608000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	02 00                	add    (%rax),%al
   2:	00 49 39             	add    %cl,0x39(%rcx)
   5:	5d                   	pop    %rbp
   6:	18 0f                	sbb    %cl,(%rdi)
   8:	84 cd                	test   %cl,%ch
   a:	01 00                	add    %eax,(%rax)
   c:	00 e8                	add    %ch,%al
   e:	0a 10                	or     (%rax),%dl
  10:	78 ff                	js     0x11
  12:	48 8d bb 08 01 00 00 	lea    0x108(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 82 02 00 00    	jne    0x2b6
  34:	48 8b 83 08 01 00 00 	mov    0x108(%rbx),%rax
  3b:	48 85 c0             	test   %rax,%rax
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

