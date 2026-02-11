Return-Path: <linux-fsdevel+bounces-76929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKlaCz1KjGmukgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 10:22:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D344122AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75B083013725
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016535504F;
	Wed, 11 Feb 2026 09:22:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73886338581
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801721; cv=none; b=AYJKlm2mHMSVCNWA5l4NJzAbqjkRblNP7HSJxoYvedpYNNiIQMfaAiQbX3+wAP7L+nyA20ygijkQ+8GkxsktEdPPRwKGw8XTJt9h0KNjAaxzvgOU4NtFFtp8r+P/Csqi6sZlIZyQPL1n5U6kcqt/LhhwQWtHNZ/VJ27nb1W+tWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801721; c=relaxed/simple;
	bh=MSqL1ZyaIykl9zpKptOa2oOvMZPan/dlvNlJqzDlQ5o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rD18TkntIb/+AZ47OqMSA2nblD0YEZZI2QVsF4wGxZ+mZvE09VQCr3/xvYnhT8LMWGKgLoIjnUVTYU/qqmcy04kkfxVYPy/tWJrMnj8gPAQzGZwxapvQKBOsuAPN2mX8HpEkBJZP9ONZDoemHHZ17vrIJEtYVadfzrsvQxsWGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6640dc1ca05so28952648eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 01:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770801719; x=1771406519;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AJjhKGhhW4FdBTgRWWtAXXQ/PC3aGbikg+UWIUmUtA=;
        b=V5lJRHrMtDHtiARonI3g5Rv2uZch/2RlPAwaM9E8/RTW0wNRpoCXLPFJ9O9XPl3mVO
         71Gs4LxqoGGbKSrOrOfOGqr9SIFzMOQQ6F4o3cQRXveS/AoR78xKTdXSqLWYu9V+CyjR
         hRqt25ymQsCeb0Mt8YkTVp6RFEtgkIvB6QVHr6azagGLWLaY2n0F4BEUBN7462cwUdiQ
         nVcKIs76wj8yOa38dpDz4P3uGQXOuTGEsU3K0OHdP6bdIS9HLatdcb8p2HRes7QrbkiC
         CMTmTQtjmWBdMC9Mn0E3QKXqDpqvT3RL8K/ngfe1Dt2ssKRA34ZGtmDr1be3rAsVxuoX
         i+9w==
X-Forwarded-Encrypted: i=1; AJvYcCUg6/LiXYXwbcaSn716xrWY/T31ToKJ5nvrSUGLf0WVIkYmD/Y25SWzCxMbUOClgpfSEBikU8w9Yw8tsyX3@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzt8SwtoiQzlcgJmm+iP7VDMW7/g26xcso+4GWcQm7hNY166Q
	U3igZBc+f7WtxzGaXiX6trt8hPvtTKEHgEisbiDxemLVjtyqUFkN0BcYEcJN5D9Ai8rxpsX0GH5
	TVcqak1ZlQ0DXZBrLvKV9Q9VUk14nKXIKAB4JnK8Bkf5/KqOtilxxcWICSrc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:99b:b0:663:5b9:a586 with SMTP id
 006d021491bc7-674852c3877mr546315eaf.72.1770801719382; Wed, 11 Feb 2026
 01:21:59 -0800 (PST)
Date: Wed, 11 Feb 2026 01:21:59 -0800
In-Reply-To: <20260210222310.357755-1-ethan.ferguson@zetier.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698c4a37.050a0220.2eeac1.0097.GAE@google.com>
Subject: [syzbot ci] Re: fat: Add FS_IOC_GETFSLABEL / FS_IOC_SETFSLABEL ioctls
From: syzbot ci <syzbot+cie82dc2645e529670@syzkaller.appspotmail.com>
To: ethan.ferguson@zetier.com, hirofumi@mail.parknet.co.jp, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76929-lists,linux-fsdevel=lfdr.de,cie82dc2645e529670];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 7D344122AC2
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] fat: Add FS_IOC_GETFSLABEL / FS_IOC_SETFSLABEL ioctls
https://lore.kernel.org/all/20260210222310.357755-1-ethan.ferguson@zetier.com
* [PATCH 1/2] fat: Add FS_IOC_GETFSLABEL ioctl
* [PATCH 2/2] fat: Add FS_IOC_SETFSLABEL ioctl

and found the following issue:
WARNING in __brelse

Full report is available here:
https://ci.syzbot.org/series/2497ea10-8eee-4346-a692-2f79990b4572

***

WARNING in __brelse

tree:      bpf
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf.git
base:      9f2693489ef8558240d9e80bfad103650daed0af
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/1d8ee174-a672-4f80-98f2-369e5475eb4f/config
C repro:   https://ci.syzbot.org/findings/4c8d33e8-6c68-4ab8-ab0c-7be7952f7dcf/c_repro
syz repro: https://ci.syzbot.org/findings/4c8d33e8-6c68-4ab8-ab0c-7be7952f7dcf/syz_repro

loop0: detected capacity change from 0 to 8192
------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: fs/buffer.c:1237 at __brelse+0x6a/0x90 fs/buffer.c:1237, CPU#1: syz.0.17/5957
Modules linked in:
CPU: 1 UID: 0 PID: 5957 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__brelse+0x6a/0x90 fs/buffer.c:1237
Code: 75 72 ff 85 ed 74 17 e8 c4 70 72 ff 48 89 df be 04 00 00 00 e8 27 c3 da ff f0 ff 0b eb 11 e8 ad 70 72 ff 48 8d 3d d6 ff a2 0d <67> 48 0f b9 3a 5b 5d c3 cc cc cc cc cc 89 d9 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90003f07b48 EFLAGS: 00010293
RAX: ffffffff825206a3 RBX: ffff8881b6fd5d10 RCX: ffff888177b557c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8ff50680
RBP: 0000000000000000 R08: ffff8881b6fd5d13 R09: 1ffff11036dfaba2
R10: dffffc0000000000 R11: ffffed1036dfaba3 R12: ffffc90003f07b78
R13: ffffc90003f07b70 R14: ffff8881bba28db0 R15: ffffc90003f07b68
FS:  0000555560eae500(0000) GS:ffff8882a96f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000080 CR3: 000000010b660000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 brelse include/linux/buffer_head.h:324 [inline]
 fat_rename_volume_label_dentry+0x11f/0x1c0 fs/fat/dir.c:1444
 fat_ioctl_set_volume_label fs/fat/file.c:174 [inline]
 fat_generic_ioctl+0x751/0xfe0 fs/fat/file.c:195
 fat_dir_ioctl+0x166/0x320 fs/fat/dir.c:816
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fce15b9bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe48117898 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fce15e15fa0 RCX: 00007fce15b9bf79
RDX: 00002000000004c0 RSI: 0000000041009432 RDI: 0000000000000004
RBP: 00007fce15c327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fce15e15fac R14: 00007fce15e15fa0 R15: 00007fce15e15fa0
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	72 ff                	jb     0x1
   2:	85 ed                	test   %ebp,%ebp
   4:	74 17                	je     0x1d
   6:	e8 c4 70 72 ff       	call   0xff7270cf
   b:	48 89 df             	mov    %rbx,%rdi
   e:	be 04 00 00 00       	mov    $0x4,%esi
  13:	e8 27 c3 da ff       	call   0xffdac33f
  18:	f0 ff 0b             	lock decl (%rbx)
  1b:	eb 11                	jmp    0x2e
  1d:	e8 ad 70 72 ff       	call   0xff7270cf
  22:	48 8d 3d d6 ff a2 0d 	lea    0xda2ffd6(%rip),%rdi        # 0xda2ffff
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	5b                   	pop    %rbx
  2f:	5d                   	pop    %rbp
  30:	c3                   	ret
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	89 d9                	mov    %ebx,%ecx
  38:	80 e1 07             	and    $0x7,%cl
  3b:	80 c1 03             	add    $0x3,%cl
  3e:	38                   	.byte 0x38


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

