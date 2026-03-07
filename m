Return-Path: <linux-fsdevel+bounces-79683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIGgJmjWq2n6hAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 08:40:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B36122AA18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 08:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8782301938B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE337C11C;
	Sat,  7 Mar 2026 07:40:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B137AA8D
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772869205; cv=none; b=ksD7h+cyyR8Yk5P65lCti8BjPZ3wU7c76eRwOGlxQCztPgQKrQ7W4VPlOSc5f9krzvO1nHfzE7LVLRIHAJZDoyDLPU7EQkjK1dZZbUpd9Z1Su9iP5BStrezlngqvxpEZRvfu15yl+ZUWHwHn9OkRD2YGhzL+k0P+5qVn9i9zcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772869205; c=relaxed/simple;
	bh=7d8xXkRHbp7AGgyAKujJfBWcaTQ8Y2/aB4Dufx+bUrA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eEOxPxu7inXhc7p48z/A0fvMinAw+8XxWFk0Nlio819oSnJABLoex5Wt2LHcTxX70BUZKrEYcYH6XJTc7FSBNZDB41+tWuVxh7Zuot8ueYLCf7w26tvomq7vJH9ecCPLLv49l1ennNVqWCkcyfIF6JuDGM58bpTNI4GRLXcLcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67ba8d8546cso85098eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 23:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772869203; x=1773474003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s54ZIRp1Zm/GdN2LwjSQDuvysuLG2BhkNXS3/XGuhRk=;
        b=qPaWqvHMWeI9lhFxH8rKKpH4X4YYJ0r5WOoiL+VPJFHPLey2ruKSQr43Z8/ELsKPYf
         lNggtCrz9s0jE/HREZCG7CRgdqBUSlweJxe5L5iBJb+PPmlW/uWxWPU8xiT1FqIOzDba
         +WpUQHE7CUIBBC4VkaZSZTWv7iahpcTpifJaCpYzVVUF550f+2QVPW9i5CQRT8hDmmwU
         3J8s49Kh272PUX1Z5anQT3l7d2DevfCoCAnQWy/ETDrX9zV8sQaQnz5Eexi7vjweFzUq
         HQShrfLFVQCoYTp2mTKBpw/68VZdfwNWZb75BnC8uq10k3d+vF2HEi0byjOahgvxCVws
         T88Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlNvpCpRsAGNK5WgQGhxM4sZ0N94AN8ZJ59FdzSOWxRqCMsM/aoGO7crUdq/Iau8aueYimmBAoHltQn109@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDb7R1SJtslIQFFq2uq3BAc8UNpI4nEUYKznJ7UF1H5Yu+rfn
	XgQvADabaDdJtAolZarJGsr1gFglZhjU+emrVRE7uHGvivnA6oFXD0yZiVveBrk/WdFc3seyDRi
	UlDE+ifVKzjVmoUbWEh+zhvFzJPJ9B3L3N1shI0DKymSOje+sqn1gPfM68m4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2297:b0:67a:555:f8b4 with SMTP id
 006d021491bc7-67b9bcc7005mr3068349eaf.34.1772869202834; Fri, 06 Mar 2026
 23:40:02 -0800 (PST)
Date: Fri, 06 Mar 2026 23:40:02 -0800
In-Reply-To: <675769.1772868400@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69abd652.050a0220.13f275.0041.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in netfs_limit_iter
From: syzbot <syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com>
To: dhowells@redhat.com, kartikey406@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9B36122AA18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79683-lists,linux-fsdevel=lfdr.de,9c058f0d63475adc97fd];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,manguebit.org,googlegroups.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.871];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in netfs_limit_iter

------------[ cut here ]------------
kernel BUG at fs/netfs/iterator.c:248!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 6595 Comm: syz.0.28 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:netfs_limit_iter+0x100d/0x1100 fs/netfs/iterator.c:248
Code: ff e9 a4 f4 ff ff 48 89 de 48 c7 c7 a0 db ab 8e e8 d8 3d 74 fe e9 59 f6 ff ff e8 8e e6 b1 ff e9 6f f6 ff ff e8 64 69 45 ff 90 <0f> 0b e8 ec e5 b1 ff e9 cd f9 ff ff 4c 89 f6 48 c7 c7 20 dc ab 8e
RSP: 0018:ffffc90003c16c70 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82c33b2b
RDX: ffff88802b2aa4c0 RSI: ffffffff82c34a5c RDI: ffff88802b2aa4c0
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000005
R10: 0000000000000003 R11: 0000000000000012 R12: 000000007fffffff
R13: 1ffff92000782d94 R14: ffff88802222ef60 R15: ffff8880224b2580
FS:  00007ffbb60b56c0(0000) GS:ffff8880d6444000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffea0531a80 CR3: 000000002ff66000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 netfs_unbuffered_write+0x2bb/0x2290 fs/netfs/direct_write.c:128
 netfs_unbuffered_write_iter_locked+0x801/0xab0 fs/netfs/direct_write.c:295
 netfs_unbuffered_write_iter+0x40c/0x710 fs/netfs/direct_write.c:385
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 __kernel_write_iter+0x2ac/0x920 fs/read_write.c:621
 __kernel_write+0xf6/0x140 fs/read_write.c:641
 __dump_emit fs/coredump.c:1221 [inline]
 dump_emit+0x21f/0x330 fs/coredump.c:1259
 elf_core_dump+0x2127/0x3d10 fs/binfmt_elf.c:2062
 coredump_write fs/coredump.c:1050 [inline]
 do_coredump fs/coredump.c:1127 [inline]
 vfs_coredump+0x27bc/0x5570 fs/coredump.c:1201
 get_signal+0x1f2a/0x21e0 kernel/signal.c:3019
 arch_do_signal_or_restart+0x91/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:98 [inline]
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
 irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
 irqentry_exit+0x1f8/0x670 kernel/entry/common.c:219
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:0000200000000088 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007ffbb5415fa0 RCX: 00007ffbb519c799
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000008000
RBP: 00007ffbb5232bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffbb5416038 R14: 00007ffbb5415fa0 R15: 00007ffea05320b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_limit_iter+0x100d/0x1100 fs/netfs/iterator.c:248
Code: ff e9 a4 f4 ff ff 48 89 de 48 c7 c7 a0 db ab 8e e8 d8 3d 74 fe e9 59 f6 ff ff e8 8e e6 b1 ff e9 6f f6 ff ff e8 64 69 45 ff 90 <0f> 0b e8 ec e5 b1 ff e9 cd f9 ff ff 4c 89 f6 48 c7 c7 20 dc ab 8e
RSP: 0018:ffffc90003c16c70 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82c33b2b
RDX: ffff88802b2aa4c0 RSI: ffffffff82c34a5c RDI: ffff88802b2aa4c0
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000005
R10: 0000000000000003 R11: 0000000000000012 R12: 000000007fffffff
R13: 1ffff92000782d94 R14: ffff88802222ef60 R15: ffff8880224b2580
FS:  00007ffbb60b56c0(0000) GS:ffff8880d6644000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffea0530cd0 CR3: 000000002ff66000 CR4: 0000000000352ef0


Tested on:

commit:         c107785c Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=103ad8d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=9c058f0d63475adc97fd
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131ad8d6580000


