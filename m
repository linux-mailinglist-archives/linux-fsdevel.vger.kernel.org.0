Return-Path: <linux-fsdevel+bounces-70617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7BCA20F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 01:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF1F3028589
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 00:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907E1917FB;
	Thu,  4 Dec 2025 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgPrUBCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1E27713
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809192; cv=none; b=EkL3/3DlM8vBdrrK0eDwPEdd20dkxbspqp8Qm2Nwle21Auc+D+ro1ENUo/Q5YFwKAYal5b8WvXMR3MW6an9rTXWPAM2zSJTDGEZIjuBP6YNlbMxI+wjueFtmcHYBPwYp4VqlW6awfNiMZh50zndXPn7An5YLq1yujCkg7uDTYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809192; c=relaxed/simple;
	bh=/Proxpje5Kq9U5+LGh9YjChxdtMfjcmxgnlDjrIvJaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA2KTKvHnUNqes5Sjn6pbms5rKyciV9HJpR3apYNlO0Kn/WmQwCfGOwDsZLTAPnmqHusIcGunFS/OEpeY8/NXUCM9FhE096EEoEIPROKc/gNZL5QGAaQDycfETvBy5zoztrxoNNqwrtRZxouIgMW7bR88hIZkIQrebrmObilNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgPrUBCM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso491407a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 16:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764809188; x=1765413988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3O7orj/gU5qxGlxOcOBJ9ZjiaJ1G9m77oYGF5XZ47E=;
        b=RgPrUBCMK2s5CtRGGb6eIqT63BM9RdRJUksx90tNPLLlvXGyV/y25GVHza2kRdb+kf
         fN6zU65/qEKZWxwKJg2fopgO8vk+2EHiNrmMG7zyqJArMbdqRB59Mh4+6bnQQjEc24KU
         bDl+llDN7UtxuKI+4ehZYTGY5z9nr+wYCMCb2KfIZnat9JDR9MteD+3DKuPNA7L8nRad
         kwfgNafktotR1cdzgeLWazm0aC13T28275IMph+WEm6QKP8JMVtmkMESWQzNPEt+hGOO
         5yfjClh5Il6qwZwGgIPkCf39IiuW/inc4rl+dIGAo2mKzP8ChXZtYOh0L+Z0at2sL8/4
         R3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764809188; x=1765413988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3O7orj/gU5qxGlxOcOBJ9ZjiaJ1G9m77oYGF5XZ47E=;
        b=pQMikzALBWOYMBYFlRkob1NuVkF5BOuHVh7EXnhpFri5hVqIdsC+TtukwrP6QCddMb
         B4KL/BJcnmkdMKiVBgJ4Wnq7FI9coiBKHYkEx2L34rcDBcAzRZS4LHAIwH14Edwt1fGH
         gW0T5KOlrLfm2wQJlfOvWyifOddb6ZCnSJbJVxHBi+3GeBUMUpZoCwSQL+fWuQNOWnPE
         uRTA1hkNPdPJmJ079O9JOGpE2fdTrjSIg5OfCrOVwfw65YzvvPch4QcqCe/J60ENsvIY
         jgAXS+9zTBD+XGw0H2YA1ObcdypuP1ENx0rFZkwDN53LO0DfNpdFv1mJX3WX74frxY+7
         PxOA==
X-Forwarded-Encrypted: i=1; AJvYcCX6bBG+dnJ5Ch65TbEqqa91zQH2lke7uAzn+KP14B30zgM24XvEafnxMf9STq76ZwU15A1Lr3ib4nzDYVOz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46uQHu3Jk83bzH/zf9zFbNkKCObZzVu+SPtPK7Ey+HKKwgnFC
	4sffTtR3WFnFW+uhNxs8lG66l2NsPjfPU0mkvSJxNaobJbxmxPYQQjny
X-Gm-Gg: ASbGncuT9x2dQzzhg8FE9XDxELwuiSQ8JFETQ5dRUVr3YBFdexK0/sbOdnDAfkdGBZE
	BN+jfgCrhBKJ1ATkPxdKv4Uuvj45uWd7x1RPim5s4Jm1ZbNOSe3de9LYHJnzpB8zRYgQN9Vs5QO
	l6nsYYYTFq1ykscyF7kqTbdk81sbUrONj0aZG62QRqIUEwPUzCw7xB1Yr49bpJLH7f7FDNb1G8E
	77+MgEjQiph6drixZjVAP1Ur0n4iOJKToctVAr1D2++lQrFoWuEKHrIrawlIjBDlc8ai6OPWZYN
	eVi6TULTfr4USsgqMkDwv6+I+dV02oZbclB0adr6qp1NOB2zQivcVaAUNaDEqYPy21UnjPJUb5T
	/Fx6BgK08nlsT7IaMAiW3HX19cb4djrFoBxvvVPNGuXtpiJchLJSINhHNvqRspidgSZbmppXpqn
	Qk6J63486KwfzBLeHjlSA//hScMaMTjvZlz2ri+oWGpXRZ13B2Go245Bn2
X-Google-Smtp-Source: AGHT+IEykNwKbWaUQatJwFBnfSp0CrUndnWOa9ZCgPdLibCDsOt+oD+Hxo9T9dKfLs1QBkCyItPdAw==
X-Received: by 2002:a05:6402:2352:b0:63b:feb1:3288 with SMTP id 4fb4d7f45d1cf-647abdd9a77mr740678a12.25.1764809188215;
        Wed, 03 Dec 2025 16:46:28 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6eca9sm19293843a12.1.2025.12.03.16.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 16:46:27 -0800 (PST)
Date: Thu, 4 Dec 2025 01:46:20 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
Message-ID: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
References: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>

On Wed, Dec 03, 2025 at 04:07:27PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1612b912580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
> dashboard link: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172c8192580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c3b0c2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90de/disk-7d31f578.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/vmlinux-7d31f578.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab2411/bzImage-7d31f578.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/ec39deb2cf11/mount_0.gz
>   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=12c3b0c2580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
> 
> VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) encountered for inode ffff88805618b338
> fs ocfs2 mode 100000 opflags 0x2 flags 0x20 state 0x0 count 2
> ------------[ cut here ]------------
> kernel BUG at fs/namei.c:630!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6303 Comm: syz.0.92 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:lookup_inode_permission_may_exec fs/namei.c:630 [inline]
> RIP: 0010:may_lookup fs/namei.c:1900 [inline]
> RIP: 0010:link_path_walk+0x18cb/0x18d0 fs/namei.c:2537
> Code: e8 5a 1f ea fe 90 0f 0b e8 b2 96 83 ff 44 89 fd e9 6a fd ff ff e8 a5 96 83 ff 48 89 ef 48 c7 c6 40 d8 79 8b e8 36 1f ea fe 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55
> RSP: 0018:ffffc900046ef8a0 EFLAGS: 00010282
> RAX: 000000000000008e RBX: ffffc900046efc58 RCX: f91f6529a96d0200
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffff88805618b338 R08: ffffc900046ef567 R09: 1ffff920008ddeac
> R10: dffffc0000000000 R11: fffff520008ddead R12: 0000000000008000
> R13: ffffc900046efc20 R14: 0000000000008000 R15: ffff88802509b320
> FS:  000055555cffa500(0000) GS:ffff888125e4f000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc32730f000 CR3: 0000000072f4e000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  path_openat+0x2b3/0x3dd0 fs/namei.c:4783
>  do_filp_open+0x1fa/0x410 fs/namei.c:4814
>  do_sys_openat2+0x121/0x200 fs/open.c:1430
>  do_sys_open fs/open.c:1436 [inline]
>  __do_sys_open fs/open.c:1444 [inline]
>  __se_sys_open fs/open.c:1440 [inline]
>  __x64_sys_open+0x11e/0x150 fs/open.c:1440
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4644d8f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe02ccf2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 00007f4644fe5fa0 RCX: 00007f4644d8f749
> RDX: 0000000000000000 RSI: 0000000000145142 RDI: 0000200000000240
> RBP: 00007f4644e13f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f4644fe5fa0 R14: 00007f4644fe5fa0 R15: 0000000000000003
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:lookup_inode_permission_may_exec fs/namei.c:630 [inline]
> RIP: 0010:may_lookup fs/namei.c:1900 [inline]
> RIP: 0010:link_path_walk+0x18cb/0x18d0 fs/namei.c:2537
> Code: e8 5a 1f ea fe 90 0f 0b e8 b2 96 83 ff 44 89 fd e9 6a fd ff ff e8 a5 96 83 ff 48 89 ef 48 c7 c6 40 d8 79 8b e8 36 1f ea fe 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55
> RSP: 0018:ffffc900046ef8a0 EFLAGS: 00010282
> RAX: 000000000000008e RBX: ffffc900046efc58 RCX: f91f6529a96d0200
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffff88805618b338 R08: ffffc900046ef567 R09: 1ffff920008ddeac
> R10: dffffc0000000000 R11: fffff520008ddead R12: 0000000000008000
> R13: ffffc900046efc20 R14: 0000000000008000 R15: ffff88802509b320
> FS:  000055555cffa500(0000) GS:ffff888125e4f000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc32730f000 CR3: 0000000072f4e000 CR4: 00000000003526f0
> 
> 
> ---


this is probably mine, but first some extra debug:


#syz test

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..0df3bd2b947d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1896,6 +1896,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 {
 	int err, mask;
 
+	VFS_BUG_ON(!d_can_lookup(nd->path.dentry));
 	mask = nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
 	err = lookup_inode_permission_may_exec(idmap, nd->inode, mask);
 	if (likely(!err))
@@ -2527,6 +2528,9 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		return 0;
 	}
 
+	VFS_BUG_ON(!d_can_lookup(nd->path.dentry));
+	VFS_BUG_ON(!S_ISDIR(nd->path.dentry->d_inode->i_mode));
+
 	/* At this point we know we have a real path component. */
 	for(;;) {
 		struct mnt_idmap *idmap;

