Return-Path: <linux-fsdevel+bounces-71086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A4CB474B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84CBF3026AFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 01:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD023EAB3;
	Thu, 11 Dec 2025 01:45:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB101DE8BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765417518; cv=none; b=qo8JSsfxQ8gMXcQvkn+CXjKUo6d0jdcC1UGq/fuTGExqv7mYPCtB4ouhBN9GMbq+Yaul+R/KpKqAIILtDiOYkopfOAReZOVEVIeONXr0n7htczRSlP4KPZx4clq5yjrgjxDjfQaI4Vfvcpeg71X3e2VzGf3SAtYf2Kl1lDNbTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765417518; c=relaxed/simple;
	bh=sFfevH47nAA3uNZoIIinb48dl3PbNcWJRW/nIrNz2iQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Mzx9WvsSer3n1P9znNx+F973NB+fGM2r5coqYLDW0IEMlFZ/MkdttWU0m7J9gCBG6hPLvkuj+BJnZXEqW2/MrRpWuHgTYqtLmEGMQqKyYlaywKFLtsAWEPaOQusz3JoMK3o1GeNDaFDMnnEgbSYg2K1Epe6b4FdXCp5/SpIUxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7cacaa675feso1055830a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 17:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765417515; x=1766022315;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twbHvsNIdd4vriB4dwGKg2ADXOEGZn75T8QacUdy8c8=;
        b=muK3k5RPZb3IKsd8Eb7lHBKKYVp++bnsjsRvNzgd5Mw4Jikaa1D3PDy2jtYUUgqZex
         OXTg1ldEU8jbNd992nHqFMN8JEJqCuOZ0Hdw6yDrKNVAgvez0ymz/uyEmJbzRdmInJoT
         M6NbyFzS7hEpEzk+3N1AW+t91pIIkeV+89ndBxvIZ5MgUMrhgg+LwUvrRts4qb3ieYYC
         BbF0qAk6klM4UrebcecCD3tAa4WVg7p+w7UYMAQ2d0T0wFO6K6YkxnRf6SOpRB+JdxMi
         EWrm2mA0Nyc7OmE7YlGaTj7hguWRSe/Qt5GKwjBfLZHc6K7xHz+KBC/LlJEoC7i9sUjz
         gaKw==
X-Forwarded-Encrypted: i=1; AJvYcCUmd1p+mYUAuvsghxFINgWnCVbjp/coex99K9HRqX22PjEHdWBFWTPnZl+pyKTgz2bzV2Ca6LyZfrnYj7Em@vger.kernel.org
X-Gm-Message-State: AOJu0YzDs9Ft2mEy3jgsMYc983uT2B3ZRY2oqeKlum8rH0RLYTzGTuis
	sldV7aBaRDoWkUxHNOgvqs6rl3aPdGVkk7dj7+XG9DP6UPKg9jekWOigI51q06vODlgfi+V0ZKs
	lxttZuwL55cah6xDX7fmX/atMiS3sIgwv0adg1l7108HjeBWcRTLWRRZLFiw=
X-Google-Smtp-Source: AGHT+IGjvE+c5ibRffIRusCy9NOq+64mwwxJRF0VY89Rmte288kQPNDMvUJK6pewgKDocYDifGSDr2Szn6PT+/Dt973O0vQ0c8Zb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:5056:b0:65b:33a3:7c8 with SMTP id
 006d021491bc7-65b33a3095cmr844677eaf.30.1765417515744; Wed, 10 Dec 2025
 17:45:15 -0800 (PST)
Date: Wed, 10 Dec 2025 17:45:15 -0800
In-Reply-To: <20251210134303.1310039-1-mjguzik@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693a222b.a70a0220.33cd7b.0020.GAE@google.com>
Subject: [syzbot ci] Re: fs: warn on dirty inode in writeback paired with I_WILL_FREE
From: syzbot ci <syzbot+ci622fcbc9c29bc2f6@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] fs: warn on dirty inode in writeback paired with I_WILL_FREE
https://lore.kernel.org/all/20251210134303.1310039-1-mjguzik@gmail.com
* [PATCH] fs: warn on dirty inode in writeback paired with I_WILL_FREE

and found the following issues:
* SYZFAIL: failed to recv rpc
* WARNING in writeback_single_inode

Full report is available here:
https://ci.syzbot.org/series/c3a011ac-952a-4fbf-867d-b7f98dcaaf3a

***

SYZFAIL: failed to recv rpc

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      67a454e6b1c604555c04501c77b7fedc5d98a779
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/5b151469-2ba7-47b6-bf4b-00ea2f6df1d8/config
C repro:   https://ci.syzbot.org/findings/9adaaed3-7016-4f9d-9b65-1a4aa9a7a127/c_repro
syz repro: https://ci.syzbot.org/findings/9adaaed3-7016-4f9d-9b65-1a4aa9a7a127/syz_repro

SYZFAIL: failed to recv rpc


***

WARNING in writeback_single_inode

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      67a454e6b1c604555c04501c77b7fedc5d98a779
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/5b151469-2ba7-47b6-bf4b-00ea2f6df1d8/config
C repro:   https://ci.syzbot.org/findings/6a7382a1-4230-4aa8-8594-a23b2365ee14/c_repro
syz repro: https://ci.syzbot.org/findings/6a7382a1-4230-4aa8-8594-a23b2365ee14/syz_repro

EXT4-fs error (device loop0): ext4_clear_blocks:876: inode #13: comm syz.0.17: attempt to clear invalid blocks 2 len 1
EXT4-fs (loop0): Remounting filesystem read-only
------------[ cut here ]------------
WARNING: fs/fs-writeback.c:1870 at writeback_single_inode+0xa39/0xe40 fs/fs-writeback.c:1870, CPU#1: syz.0.17/5986
Modules linked in:
CPU: 1 UID: 0 PID: 5986 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:writeback_single_inode+0xa39/0xe40 fs/fs-writeback.c:1870
Code: 0f 0b 90 e9 25 f7 ff ff e8 64 8d 79 ff 90 0f 0b 90 e9 9c fb ff ff e8 56 8d 79 ff 90 0f 0b 90 e9 c1 fc ff ff e8 48 8d 79 ff 90 <0f> 0b 90 e9 54 fc ff ff e8 3a 8d 79 ff 90 0f 0b 90 e9 47 fd ff ff
RSP: 0018:ffffc900037c7558 EFLAGS: 00010293
RAX: ffffffff824823a8 RBX: dffffc0000000000 RCX: ffff8881113657c0
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: ffff888108eb4068 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006f8e9c R12: ffff8881b1810d08
R13: 0000000000000040 R14: ffff8881b1810c38 R15: 1ffff110363021a1
FS:  00005555567e1500(0000) GS:ffff8882a9e44000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67c0f73ea0 CR3: 000000017655e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2926
 iput_final fs/inode.c:1941 [inline]
 iput+0xa77/0x1030 fs/inode.c:2003
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:472
 __ext4_fill_super fs/ext4/super.c:5658 [inline]
 ext4_fill_super+0x58a1/0x6160 fs/ext4/super.c:5777
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f67c0f90f6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc812989c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc81298a50 RCX: 00007f67c0f90f6a
RDX: 0000200000000440 RSI: 0000200000000040 RDI: 00007ffc81298a10
RBP: 0000200000000440 R08: 00007ffc81298a50 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 0000200000000040
R13: 00007ffc81298a10 R14: 0000000000000450 R15: 000000000000002c
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

