Return-Path: <linux-fsdevel+bounces-74178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FCD336BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88B4E30D6820
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6889828466D;
	Fri, 16 Jan 2026 16:13:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C226ED5C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580020; cv=none; b=plP8fngFuqxKvvrthjITaQekeItdT41I7QPafqR/Sp1czoZIeelF9I+M+YD48X3JRv8H7i1iV1yvLXjQTgfbduHrvPTztl/b7JKZwf7pZJwtjNWXMpLsg/VcAxV9q7rAL6BE2Xpx7NGc0syioDBI5YK9+SzFnGqpuy1SRlZu9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580020; c=relaxed/simple;
	bh=r3jjAh3mh60Ib3C96zJOKvhDAFHJMf1YaqAAQNpFF9o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=K8gDnYRa9FiqnnDinGn4vqgwr8Rb/dutOcF4p5ILeEivY7VsgnbzNfOdFvMd5zrfAPpLtPPICPenkk+HYm/XWyKGesxgv4CjZMUb7c/0V82yqxr78lDtRN5HelT2G0liu2yZ8XJmFYykmcdtqSUFi2DPPUyhXU61Am49oHbsMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66113da9a75so4344995eaf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 08:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768580017; x=1769184817;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW18BJd0jSvNLSBLK+5GeIvUMjj5PFq3we5kfaKyLBY=;
        b=E79F+eMlxTTlzE/ivo16nCdmCGdaxVsGU9V/+hlMktoR3aoDw/dKjd+e8zYmDPSToD
         nKCPDtiIl+SDGNqtHrlT3dICGq3v3Eh6xvjI/3qt+rpGPH2bqi70v0yvBp/nBQhCSxwD
         dToR5C1a9L0KeGBrtdpagD+MRZC0oq9+BN9dH5nbXZ/iKhQjH9mp5CTmaVL6XZROxsRC
         hS6Pw97PKdF3tA1NlS19JDZvJCaeLHoR35jri9712iEBNSIsDcvOI5BUjpI84SP2JFf0
         /YgKwLvddjwdx9CCZBtO+eD6Skain/JFsnql9bK8QenQh7+5n+yvB7Y+h9yK/iaeQ237
         NvmA==
X-Forwarded-Encrypted: i=1; AJvYcCWBV49RYXWq73/MWra2LUZejXB35UYuhef4Vu6cMx4thG5IUDSZT8JJcwD0B1BhJ11JVTzRBv36D8H3i7Oe@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQkmbk+ceWzxu8HAy8dxHCNMm5fxB0uKmObMkep3X2Zp6buE4
	/lxmXDZUq5aqyftZE3yoHsktf4DOxyf5CV+xtKDGl7PIysOz1CsmrUPibYpphSv+I2oyz8HqNT3
	BnysmC1yuaBxqg9OT2mBez7T4SJ0qaP0F2lN1PvakVKphMlMXNDn1u1/MEbQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:498e:b0:65b:2935:f935 with SMTP id
 006d021491bc7-661179c2396mr1433844eaf.44.1768580017428; Fri, 16 Jan 2026
 08:13:37 -0800 (PST)
Date: Fri, 16 Jan 2026 08:13:37 -0800
In-Reply-To: <20260116100818.7576-1-kundan.kumar@samsung.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696a63b1.050a0220.58bed.006b.GAE@google.com>
Subject: [syzbot ci] Re: AG aware parallel writeback for XFS
From: syzbot ci <syzbot+ci4e530c88485a9c60@syzkaller.appspotmail.com>
To: amir73il@gmail.com, anuj20.g@samsung.com, axboe@kernel.dk, 
	brauner@kernel.org, cem@kernel.org, clm@meta.com, dave@stgolabs.net, 
	david@fromorbit.com, djwong@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	jack@suse.cz, joshi.k@samsung.com, kundan.kumar@samsung.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	mcgrof@kernel.org, ritesh.list@gmail.com, viro@zeniv.linux.org.uk, 
	vishak.g@samsung.com, wangyufei@vivo.com, willy@infradead.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] AG aware parallel writeback for XFS
https://lore.kernel.org/all/20260116100818.7576-1-kundan.kumar@samsung.com
* [PATCH v3 1/6] iomap: add write ops hook to attach metadata to folios
* [PATCH v3 2/6] xfs: add helpers to pack AG prediction info for per-folio tracking
* [PATCH v3 3/6] xfs: add per-inode AG prediction map and dirty-AG bitmap
* [PATCH v3 4/6] xfs: tag folios with AG number during buffered write via iomap attach hook
* [PATCH v3 5/6] xfs: add per-AG writeback workqueue infrastructure
* [PATCH v3 6/6] xfs: offload writeback by AG using per-inode dirty bitmap and per-AG workers

and found the following issue:
WARNING in xfs_init_ag_writeback

Full report is available here:
https://ci.syzbot.org/series/0e34236b-3594-400f-b9cd-6f59b196014f

***

WARNING in xfs_init_ag_writeback

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      eeb33083cc4749bdb61582eaeb5c200702607703
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/f21aae46-4d21-4410-9132-190ad8ae3994/config
C repro:   https://ci.syzbot.org/findings/24ec6312-5e15-4750-aa2a-08d381daca26/c_repro
syz repro: https://ci.syzbot.org/findings/24ec6312-5e15-4750-aa2a-08d381daca26/syz_repro

loop2: detected capacity change from 0 to 32768
------------[ cut here ]------------
kmem_cache of name 'xfs_ag_wb_task' already exists
WARNING: mm/slab_common.c:110 at kmem_cache_sanity_check mm/slab_common.c:109 [inline], CPU#1: syz.2.19/6098
WARNING: mm/slab_common.c:110 at __kmem_cache_create_args+0x99/0x310 mm/slab_common.c:310, CPU#1: syz.2.19/6098
Modules linked in:
CPU: 1 UID: 0 PID: 6098 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:109 [inline]
RIP: 0010:__kmem_cache_create_args+0x9c/0x310 mm/slab_common.c:310
Code: 43 8e 4d 8b 24 24 49 81 fc b8 78 43 8e 74 20 49 8b 7c 24 f8 48 89 de e8 f2 c0 67 09 85 c0 75 e2 48 8d 3d f7 ca bc 0d 48 89 de <67> 48 0f b9 3a 48 89 df be 20 00 00 00 e8 92 c2 67 09 48 85 c0 0f
RSP: 0018:ffffc90003817a08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff8bc734a0 RCX: 0000000000000007
RDX: 000000008bc73406 RSI: ffffffff8bc734a0 RDI: ffffffff8fc6ee40
RBP: 0000000000080000 R08: ffffffff8fc26e77 R09: 1ffffffff1f84dce
R10: dffffc0000000000 R11: fffffbfff1f84dcf R12: ffff88810b7a7300
R13: ffff888115440000 R14: ffffc90003817aa0 R15: 0000000000000190
FS:  0000555567cf7500(0000) GS:ffff8882a9a05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f049ffff000 CR3: 00000001b9726000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __kmem_cache_create include/linux/slab.h:384 [inline]
 xfs_init_ag_writeback+0x41b/0x570 fs/xfs/xfs_aops.c:890
 xfs_fs_fill_super+0x7e3/0x1640 fs/xfs/xfs_super.c:1759
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1691
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x329/0xa50 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f32c139bf4a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd30494b68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd30494bf0 RCX: 00007f32c139bf4a
RDX: 0000200000009740 RSI: 0000200000009780 RDI: 00007ffd30494bb0
RBP: 0000200000009740 R08: 00007ffd30494bf0 R09: 0000000000004010
R10: 0000000000004010 R11: 0000000000000246 R12: 0000200000009780
R13: 00007ffd30494bb0 R14: 0000000000009768 R15: 0000200000000300
 </TASK>
----------------
Code disassembly (best guess):
   0:	43 8e 4d 8b          	rex.XB mov -0x75(%r13),%cs
   4:	24 24                	and    $0x24,%al
   6:	49 81 fc b8 78 43 8e 	cmp    $0xffffffff8e4378b8,%r12
   d:	74 20                	je     0x2f
   f:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
  14:	48 89 de             	mov    %rbx,%rsi
  17:	e8 f2 c0 67 09       	call   0x967c10e
  1c:	85 c0                	test   %eax,%eax
  1e:	75 e2                	jne    0x2
  20:	48 8d 3d f7 ca bc 0d 	lea    0xdbccaf7(%rip),%rdi        # 0xdbccb1e
  27:	48 89 de             	mov    %rbx,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	be 20 00 00 00       	mov    $0x20,%esi
  37:	e8 92 c2 67 09       	call   0x967c2ce
  3c:	48 85 c0             	test   %rax,%rax
  3f:	0f                   	.byte 0xf


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

