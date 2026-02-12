Return-Path: <linux-fsdevel+bounces-77064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGZaOkZfjmm1BwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:16:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED2131B1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25CA4306B4C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254ED1D5147;
	Thu, 12 Feb 2026 23:15:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE2219FF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770938146; cv=none; b=bB2c7LLf7XY4LlHgbkijYGQC6u4AgmugDXt85Z2jsMPhWlGKDK8Fjxmb/IGS5mxmZfBfH08h6XNdrsgDVFXatp0Mo9ucc3Fem3R5Qw8dsiDcsEHjgOTzU+2gn9YV4Bm78ETYCC1tOAxRdw4G6Y32szxEV4uHxrjG01qS3RpLzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770938146; c=relaxed/simple;
	bh=xBzQzJmq14YXIxHtefoP8HVoVs+qDCcNJL8CgWa2Vlk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=arCeP8HidmOiZAgmAAGHkTeuQKcgXrzLzL9U4V5xiKJ9zEcb7cv3DxqH0Dormi7N/Wp/krwCnyQP3bNSHh/lAmnURnwmT6wrYZSi8BdpXpeOxqlvwjUwMijXcRhz6+pcI7C/ISZn2E4tuEQ7ffGoeqKdms5VKU6bQMwHF+jCoKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6744760f6daso1836845eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 15:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770938144; x=1771542944;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0lu37aLRPPLTFeHLhq/Qr8lpi3+g+Cq8dO+U82KwgA=;
        b=MwMTegFkCTGGbuKdyTO/SgPZt7UqwQ/LqehT3PR6h/7iGyWYe1tTvCJp5mQR/42yBU
         sX6GN1AGdcK7TB9tk5gaPxWpyRxGuP30hK+h0L+MpuVCnKNpIaWPMe0klXdPVYitCrRs
         yvMn4e7My90ve95gzCIruoPblSG6vtM1k87Q02LwK27uqSGpcKB+BvKq4HSxn8Lk/1k5
         myVdv7NcdEMmNBhKrLhNzUhEj83Uv6GexUR0SVBsVeP1V/ZjZo6Us33CFNMhN8onszME
         ZIItxJxi1ltaG7SizXZO0gvFZjV4HxmKio/MbeuQCtiV4rsr4/M8YOExSyYMPRjLrVM5
         CFyA==
X-Forwarded-Encrypted: i=1; AJvYcCWQmC8eUrLfRd98QxjuLuKBcbWNwewqh7ATG+KUYkIb12vm9VFXySGebclj1fr0wRf8whvp0c4IdaEDKttK@vger.kernel.org
X-Gm-Message-State: AOJu0YwVIIheMXkJJ1nSh41dUAZ1Zi1FedwnJgKy/6TwPeW3VKwP2m+1
	Ew4EozGduVMWilD7rqnzGfzZPsCoctARuiDyMsnwqXErqo58dFH5OeG8dKCezWXzWifbUokms3Q
	qj9qXcInIWFyN+9Ht4nXbBht8wE4koUWLbj5aNl7zItaqojamUt3Az1nsnhw=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160c:b0:674:a4e1:18e6 with SMTP id
 006d021491bc7-677216fc46bmr262479eaf.24.1770938144573; Thu, 12 Feb 2026
 15:15:44 -0800 (PST)
Date: Thu, 12 Feb 2026 15:15:44 -0800
In-Reply-To: <20260212170849.12455-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698e5f20.a70a0220.2c38d7.00a5.GAE@google.com>
Subject: [syzbot ci] Re: fs/ntfs3: add delayed-allocation (delalloc) support
From: syzbot ci <syzbot+cife27aa3114ea3df8@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,googlegroups.com:email,syzbot.org:url,googlesource.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77064-lists,linux-fsdevel=lfdr.de,cife27aa3114ea3df8];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 65ED2131B1A
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] fs/ntfs3: add delayed-allocation (delalloc) support
https://lore.kernel.org/all/20260212170849.12455-1-almaz.alexandrovich@paragon-software.com
* [PATCH] fs/ntfs3: add delayed-allocation (delalloc) support

and found the following issue:
WARNING in ntfs_extend_initialized_size

Full report is available here:
https://ci.syzbot.org/series/13e78e99-d298-48f9-b81b-be0931799244

***

WARNING in ntfs_extend_initialized_size

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      9152bc8cebcb14dc16b03ec81f2377ee8ce12268
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/b551b487-d04a-4a8a-89aa-575a75c69c23/config
C repro:   https://ci.syzbot.org/findings/c8966f1e-fd77-42d2-8f24-1e7b54ac54dd/c_repro
syz repro: https://ci.syzbot.org/findings/c8966f1e-fd77-42d2-8f24-1e7b54ac54dd/syz_repro

loop0: detected capacity change from 0 to 4096
------------[ cut here ]------------
is_compressed(ni)
WARNING: fs/ntfs3/file.c:236 at ntfs_extend_initialized_size+0x1dc/0x210 fs/ntfs3/file.c:236, CPU#1: syz.0.17/5975
Modules linked in:
CPU: 1 UID: 0 PID: 5975 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ntfs_extend_initialized_size+0x1dc/0x210 fs/ntfs3/file.c:236
Code: 0d ff 4c 89 33 31 ed eb 05 e8 70 8b a3 fe 89 e8 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 9b a6 8e 08 cc e8 55 8b a3 fe 90 <0f> 0b 90 e9 31 ff ff ff 89 d1 80 e1 07 80 c1 03 38 c1 0f 8c e1 fe
RSP: 0018:ffffc90004547c30 EFLAGS: 00010293
RAX: ffffffff8322128b RBX: ffff8881a8229670 RCX: ffff88810ba49d00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000800 R08: ffff8881a8229737 R09: 1ffff110350452e6
R10: dffffc0000000000 R11: ffffed10350452e7 R12: 0000000000000110
R13: 0000000000000ef0 R14: 1ffff110350452ce R15: 0000000000000000
FS:  000055555ee59500(0000) GS:ffff8882a9460000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f811e871980 CR3: 000000010f87c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ntfs_fallocate+0xf21/0x1220 fs/ntfs3/file.c:670
 vfs_fallocate+0x669/0x7e0 fs/open.c:340
 ksys_fallocate fs/open.c:364 [inline]
 __do_sys_fallocate fs/open.c:369 [inline]
 __se_sys_fallocate fs/open.c:367 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:367
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f811e99bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffecc78b558 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f811ec15fa0 RCX: 00007f811e99bf79
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f811ea327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f811ec15fac R14: 00007f811ec15fa0 R15: 00007f811ec15fa0
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

