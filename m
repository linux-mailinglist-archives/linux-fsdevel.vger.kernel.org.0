Return-Path: <linux-fsdevel+bounces-71987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2462CDA2F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 18:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48357304FE9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71634D90F;
	Tue, 23 Dec 2025 17:47:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B634C137
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512022; cv=none; b=jz7SYe9k8pBcRAjR4wNCVD15ROVc/d3lVpJQnsupKDGFRt16gxM9R5B3/G3c1NFvrMtKRlAAdHnrrYtGnggmvr4fLHydbbqpFwW/TzQPWh1YkcClYB7Z2WTVtGwKstVW/fO52r1ijJdq8/O2B5zGL65hOrBsArdmcXtDfpTWqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512022; c=relaxed/simple;
	bh=XlPzG42srC8UNGssLCPJU3ppN1rvUXtFkLgyMxG8m48=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=iTfSQTKZo/uXmfpO7g1n3furP5CVGs81W88gtA+JUpCJJE0pStylKdOXR6i9r/f20uSNwrUgde5L3BoUdVTS3ys/NRe0EF1Ngp2yJ9KQuKS3bDIOwe9PyBt0oz23RQdHvi3Kc49bjH0CAB3Bp0cp/6Rbi2+Y6v2e3wR5aX7Kmd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c72ccd60f5so11350766a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 09:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766512019; x=1767116819;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hBk4iaPspfRfvqQEzn6T9NmRJB56To3aNFXWiUGJUo=;
        b=MNlEy9G7Ib2NFSy2RejslVnq9tjBK3ORgs2y9rIs8nZKjAATjK3JTW8KdqWWzbVJB+
         rTGvBEVf53MCtEqd7j6ztYdzFMx9gDmylA51/nQ3ys1B16GpwoIVWJRsAknywSknThtj
         xcnAQLMB/mxOMhQWZ0U0dp2Cc/Nbmh8L3om0f0g2kXwPctvwhZLr8SAr2BfRIi+STABR
         J66HTm8aSt4tWcoSSDk6eabDcaOOrPQYtgz+HjBwuNV9AXv1l0Zulh00F33VlHkzReh1
         irYsOJi5iNokeF8TCj0MlMxvZaOH6CLvF/db0WClCIgrXmz5b2aOBQGqT35S1AC5uTrv
         Z94w==
X-Forwarded-Encrypted: i=1; AJvYcCWEm2CA7pGF6sOnM5p6sDOmuF8Mu/ZdwlYRYWZtKvGdU7baK1WhNbWZy8r6lRdoKo+Mg2vMfzYFFnqyubAa@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjzUzRvGSkt39wCbzHnLcYx309RYO+n8HYSymlR0QQlmDVop4
	sb69p/HgKuQgXHIVIk82HsZ6O23BWAMCiakbxh3zAJ6F66Un2DwJLE0xXgto6ROUuWl3UgN32Ic
	wLgWr0EHOoru2Oi6ZtiHYokylY5xuHa0U/hAmvei7y/6+5ynuLssxAKyHH9o=
X-Google-Smtp-Source: AGHT+IFR7CgjvJHnZYoJTKyatw+9aGBWpdHNb75GdoRVddD+n2lpbn92mYhfanXRPSOawIpSQIRFPHePtnIAuXCYRzy3pGzvHrUN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2c93:b0:65c:f046:bb6f with SMTP id
 006d021491bc7-65d0eae70dfmr4794995eaf.68.1766512019078; Tue, 23 Dec 2025
 09:46:59 -0800 (PST)
Date: Tue, 23 Dec 2025 09:46:59 -0800
In-Reply-To: <20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694ad593.050a0220.35954c.0003.GAE@google.com>
Subject: [syzbot ci] Re: fuse: compound commands
From: syzbot ci <syzbot+cid3a9cf23e911d362@syzkaller.appspotmail.com>
To: bschubert@ddn.com, hbirthelmer@ddn.com, hbirthelmer@googlemail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] fuse: compound commands
https://lore.kernel.org/all/20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com
* [PATCH RFC 1/2] fuse: add compound command to combine multiple requests
* [PATCH RFC 2/2] fuse: add an implementation of open+getattr

and found the following issue:
general protection fault in fuse_dir_open

Full report is available here:
https://ci.syzbot.org/series/11a1edb1-479b-4bb9-a173-a5aef4cc9455

***

general protection fault in fuse_dir_open

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      9094662f6707d1d4b53d18baba459604e8bb0783
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/0d046766-2385-4f04-bae0-5a8d6df01c3a/config
C repro:   https://ci.syzbot.org/findings/027737d8-b067-4bd4-90f6-5b236fb8420b/c_repro
syz repro: https://ci.syzbot.org/findings/027737d8-b067-4bd4-90f6-5b236fb8420b/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 1 UID: 0 PID: 5985 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:fuse_dir_open+0x14e/0x220 fs/fuse/dir.c:1900
Code: eb a7 4d 8d 7e 58 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 e0 77 f3 fe 4d 8b 3f 49 83 c7 2c 4d 89 fc 49 c1 ec 03 <43> 0f b6 04 2c 84 c0 0f 85 82 00 00 00 41 8b 2f 89 ee 83 e6 14 31
RSP: 0018:ffffc90003907860 EFLAGS: 00010203
RAX: 1ffff11022f0688b RBX: ffff8881b9320000 RCX: 0000000000000000
RDX: ffff88810afbba80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f822b77 R09: 1ffffffff1f0456e
R10: dffffc0000000000 R11: fffffbfff1f0456f R12: 000000000000000b
R13: dffffc0000000000 R14: ffff888117834400 R15: 000000000000005c
FS:  00007fa1fc9506c0(0000) GS:ffff8882a9e1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa1fb1fdfc8 CR3: 000000016abde000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 do_dentry_open+0x7ce/0x1420 fs/open.c:962
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:4628 [inline]
 path_openat+0x340e/0x3dd0 fs/namei.c:4787
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1fbb8e010
Code: 48 89 44 24 20 75 93 44 89 54 24 0c e8 69 95 02 00 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 bc 95 02 00 8b 44
RSP: 002b:00007fa1fc94fdf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007fa1fbb8e010
RDX: 0000000000010000 RSI: 00002000000000c0 RDI: 00000000ffffff9c
RBP: 00002000000000c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00002000000000c0
R13: 00007fa1fc94feb0 R14: 0000000000000000 R15: 0000200000002280
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fuse_dir_open+0x14e/0x220 fs/fuse/dir.c:1900
Code: eb a7 4d 8d 7e 58 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 e0 77 f3 fe 4d 8b 3f 49 83 c7 2c 4d 89 fc 49 c1 ec 03 <43> 0f b6 04 2c 84 c0 0f 85 82 00 00 00 41 8b 2f 89 ee 83 e6 14 31
RSP: 0018:ffffc90003907860 EFLAGS: 00010203
RAX: 1ffff11022f0688b RBX: ffff8881b9320000 RCX: 0000000000000000
RDX: ffff88810afbba80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f822b77 R09: 1ffffffff1f0456e
R10: dffffc0000000000 R11: fffffbfff1f0456f R12: 000000000000000b
R13: dffffc0000000000 R14: ffff888117834400 R15: 000000000000005c
FS:  00007fa1fc9506c0(0000) GS:ffff8882a9e1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa1fb1fdfc8 CR3: 000000016abde000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	eb a7                	jmp    0xffffffa9
   2:	4d 8d 7e 58          	lea    0x58(%r14),%r15
   6:	4c 89 f8             	mov    %r15,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	4c 89 ff             	mov    %r15,%rdi
  17:	e8 e0 77 f3 fe       	call   0xfef377fc
  1c:	4d 8b 3f             	mov    (%r15),%r15
  1f:	49 83 c7 2c          	add    $0x2c,%r15
  23:	4d 89 fc             	mov    %r15,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	43 0f b6 04 2c       	movzbl (%r12,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 82 00 00 00    	jne    0xb9
  37:	41 8b 2f             	mov    (%r15),%ebp
  3a:	89 ee                	mov    %ebp,%esi
  3c:	83 e6 14             	and    $0x14,%esi
  3f:	31                   	.byte 0x31


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

