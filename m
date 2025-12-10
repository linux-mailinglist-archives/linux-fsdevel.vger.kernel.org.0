Return-Path: <linux-fsdevel+bounces-71052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D008ACB2CDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7842300A6EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E523F439;
	Wed, 10 Dec 2025 11:19:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4439239E9D
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365545; cv=none; b=oqAIf1f4UtvFThi8agKe10uD1BMDrqCfcEujLakuXlnumPESJz4RdV18Yz1Xcyvk1IrKfu/lzcIHESE5FlsZTVm7hevqdg5W9P+gIP4030LnzsDkM2ItuyWVqkl4rbifTThpo9B+M9cSTzfRQ59Ql5nXEMbeFua/pECBGdNHu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365545; c=relaxed/simple;
	bh=/4yRP8S2H0mIy7v6M0HeEvjtN/4b5GJXjrPFgEYTpak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YwshaIWIPxMHvRHRBVJEcGTMlEnBac+XUmLl+BwlCVsGE84OWK8AIoO4Jiq1+2qbBUmHN2T8bG6TtlbIGqKJbaI1T5CzggWIL7LcS21ICK/OFXnyyN0XwOULxtyOV41ZMSzpWDB7aM3PZbXlU/85hjLn3S2n3pz1Kiszab6bArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c7028db074so13152658a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 03:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365543; x=1765970343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Dsj09u9tVJLdfpzSygt1jYHqgAQ/031OzwPBZjj44o=;
        b=D5uHA20QXen/4IWTTbAc0dBKMcNUG3xtsqXEwbwAjW08dAsQmKVQlRy9hc5bNjBecs
         V68Yi1yIZkYGdkUn79c6/XXd6GdCsYolXRkmoEdaMEcrlSc45QiAXgElc141Ynr7VKsl
         lonsFXEUPGNTUylLpWUYuaJAVOzKau7wCAMBEkoS5HuAPAsx7cIb603852T5YliAbJLr
         vTjXhB3uRJbrY0AsLDQvVR1Z43ljrjGNoZdhfWAzHZaF3S1lxAS2ES2eg4J0ifNxLiyq
         OozZ4TsN/IKEvPYaG8iEQJRo6Y+NJsXr8zLNbO4FT8vXyB3+F2HF7vIR0ORLFX3tHaqt
         nhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUORt2Q+ssT1z75okZs/5bQ/m47efxY3h3H35p2aToblwK6ydNx/V9EcH/B2qwNU+55iEpiPAuHU9ve8Nh3@vger.kernel.org
X-Gm-Message-State: AOJu0YzygNPyShpfrkN+GWxoQpGbvWnq/gYBQKg7p7ilk7MhKSIuGNaq
	ESGnX1/Y5AjAFabHs/sclPJujkeoLSlkm5du1PtnaawXcRv8mdUaLcJkvsJXXJs8+gNAMBoA1cT
	+Iw9RH4Q1ytwp+e2kbkpE/OZYK/gPKtiDhk3fN5JWoQ3iPfHVgafyRuPN9sM=
X-Google-Smtp-Source: AGHT+IH1tLgyp1YnsKZcvhSBaqDlUOWb9kKVCbPR78rRVhYedFD8Sp7Pnlki1uWmsjRygW4hHMHFDAkWswj84yp/tzHQ0z68TIYq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3084:b0:659:9a49:8f0e with SMTP id
 006d021491bc7-65b2acc9210mr1293060eaf.31.1765365542894; Wed, 10 Dec 2025
 03:19:02 -0800 (PST)
Date: Wed, 10 Dec 2025 03:19:02 -0800
In-Reply-To: <f2ui7rofuos4vcuj7t7pa5tcyq5m3agm44ouk7hcdl7opiwmwd@dyctf7rrsuqw>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69395726.a70a0220.33cd7b.0006.GAE@google.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
From: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mjguzik@gmail.com, ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_journal_toggle_dirty

(syz.0.554,7359,0):ocfs2_assign_bh:2417 ERROR: status = -30
(syz.0.554,7359,0):ocfs2_inode_lock_full_nested:2512 ERROR: status = -30
(syz.0.554,7359,0):ocfs2_shutdown_local_alloc:412 ERROR: status = -30
------------[ cut here ]------------
kernel BUG at fs/ocfs2/journal.c:1027!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 7359 Comm: syz.0.554 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_journal_toggle_dirty+0x33f/0x350 fs/ocfs2/journal.c:1027
Code: ff ff e8 44 bf b0 07 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 4e fe ff ff 48 89 df e8 fc 5a 7d fe e9 41 fe ff ff e8 f2 7e 15 fe 90 <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000d436fc0 EFLAGS: 00010293
RAX: ffffffff83ac415e RBX: 00000000ffffffff RCX: ffff88803ae90000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000d437070 R08: ffffffff8fa21977 R09: 1ffffffff1f4432e
R10: dffffc0000000000 R11: fffffbfff1f4432f R12: 1ffff110024dca22
R13: ffff88804353b600 R14: ffff888011a24000 R15: ffff8880126e5110
FS:  00007ff6959f66c0(0000) GS:ffff88808d22f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3a33db2000 CR3: 000000005209e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ocfs2_journal_shutdown+0x524/0xab0 fs/ocfs2/journal.c:1109
 ocfs2_mount_volume fs/ocfs2/super.c:1785 [inline]
 ocfs2_fill_super+0x5574/0x63a0 fs/ocfs2/super.c:1083
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
RIP: 0033:0x7ff696390f6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff6959f5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ff6959f5ef0 RCX: 00007ff696390f6a
RDX: 0000200000004440 RSI: 0000200000000040 RDI: 00007ff6959f5eb0
RBP: 0000200000004440 R08: 00007ff6959f5ef0 R09: 00000000000008c0
R10: 00000000000008c0 R11: 0000000000000246 R12: 0000200000000040
R13: 00007ff6959f5eb0 R14: 0000000000004421 R15: 0000200000000080
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_journal_toggle_dirty+0x33f/0x350 fs/ocfs2/journal.c:1027
Code: ff ff e8 44 bf b0 07 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 4e fe ff ff 48 89 df e8 fc 5a 7d fe e9 41 fe ff ff e8 f2 7e 15 fe 90 <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000d436fc0 EFLAGS: 00010293
RAX: ffffffff83ac415e RBX: 00000000ffffffff RCX: ffff88803ae90000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000d437070 R08: ffffffff8fa21977 R09: 1ffffffff1f4432e
R10: dffffc0000000000 R11: fffffbfff1f4432f R12: 1ffff110024dca22
R13: ffff88804353b600 R14: ffff888011a24000 R15: ffff8880126e5110
FS:  00007ff6959f66c0(0000) GS:ffff88808d22f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa8e1fff000 CR3: 000000005209e000 CR4: 0000000000352ef0


Tested on:

commit:         0048fbb4 Merge tag 'locking-futex-2025-12-10' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1477da1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de48dccdf203ea90
dashboard link: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e2ea1a580000


