Return-Path: <linux-fsdevel+bounces-79575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NQoHPV1qmnRRwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 07:36:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 100DC21C213
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 07:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE7983047E4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE0371CF8;
	Fri,  6 Mar 2026 06:36:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F79371046
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778981; cv=none; b=QsKr7i9EXco5h2JHsYErJyOttvZFYsjWRDnEC2P0gLsRDOiO9iFG3gbboLlcB0XcBOxoSG7Vp5TRSBpNTUfYiT/ehQHG2l3Y0RiJ7Yts3i+aiSevof6ocFGUIB3iDkqPZ8N7OUs1EY0jbRIlUCOUogyAeh3YObjdSQwjnTeQXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778981; c=relaxed/simple;
	bh=vNum4srGc5ORMInpONutwPrC4E9EEdH+0lnajRvuj9w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M8JOMxpFu5oY+XkQmdyijbeQUoOij67i+EqzgSUO6Cm6J9vdf5zIK13+hzmPUjOtlS3wiYYkoPCRax8WNVCfVUCKgYCHeotc473XwdOeLlIzx5xQoLdu4xNEfJF79jNO3dXKB3lgoLyWCsi68Sa7Xj1194NI7rMYAtPJoK9OXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6798747187eso132729958eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 22:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778979; x=1773383779;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJ64YFn8UUA1y2uPrXf95iWTGshR2gj7Q9p2jyzHyL4=;
        b=U9dv/LdLIOuddxxJzYdfy96q66AxsOYZBtFBkPkefzMDnyv+dlyLH+k3JM7VwSDBih
         zaj+jXpgc/9pygiU4fjdp9oi3vmq5ysv8WdUmO5bja8dcribGkbXa0uEhbaKDrySEvKl
         qwtxc+YGQb1SEGjBgMQ82AWCb7EDc6qoJKhy969rmUcbvo1uGq9HOxMfpbU5lqYvuA2r
         KrmUkI+SVhRJe0eRw6qh7aLieQK6VRHyxk/bs+0m4D7TPWEfxEQqKU3CoYj8t6d6kNl6
         0fcXc0ZbZV9V3SWz+G+uVqYEpYN9PYKd1gdQ/fFOU3yCJuOnDg9Qb1IOLbB1N1A+fYum
         qSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO881e/lPrZ55qSYg+JICU2ZHG983ixwaPXLYtW6zVJYEtO457DBWvbfxtEJ1OPkeB9IUriHcPAvcZri7R@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhv1mp1CFuh355IkS0IVczHt7tYmeZnJnMChTs3PteztZo6nP
	TLGhk2GwxyvmwJj1iMoIElbTjQlqtxTgsLBPAPuLsUICBpw4LSXfihDIAyYZ4sXdYq7Lh7VcseZ
	yiiNfLPEd0id3b12KkakZhfJ5lkfD9RgOKitw17po63vd8rpG5kHk7Qc7xTk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81cb:b0:679:f11b:a511 with SMTP id
 006d021491bc7-67b9bd1690dmr825645eaf.45.1772778978939; Thu, 05 Mar 2026
 22:36:18 -0800 (PST)
Date: Thu, 05 Mar 2026 22:36:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69aa75e2.050a0220.13f275.0010.GAE@google.com>
Subject: [syzbot] [netfs?] BUG: unable to handle kernel NULL pointer
 dereference in netfs_unbuffered_write
From: syzbot <syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 100DC21C213
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79575-lists,linux-fsdevel=lfdr.de,7227db0fbac9f348dba0];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,storage.googleapis.com:url,appspotmail.com:email,syzkaller.appspot.com:url,goo.gl:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    c107785c7e8d Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15db7b5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1628ab5a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a5414a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c107785c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a4a4abcd973/vmlinux-c107785c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f60667f16840/bzImage-c107785c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com

netfs: Couldn't get user pages (rc=-14)
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 31867067 P4D 31867067 PUD 0 
Oops: Oops: 0010 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 6079 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003b7fb90 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88803bd3a5b0 RCX: ffffffff82c49d0a
RDX: ffff88802b9ca4c0 RSI: ffffffff82c49b9c RDI: ffff88803bd3a500
RBP: 0000000000140000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88803bd3a598
R13: dffffc0000000000 R14: ffff88803bd3a500 R15: ffff888023066580
FS:  00007f9e9a09f6c0(0000) GS:ffff8880d6644000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002c65b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 netfs_unbuffered_write+0xae5/0x2080 fs/netfs/direct_write.c:189
 netfs_unbuffered_write_iter_locked+0x801/0xab0 fs/netfs/direct_write.c:287
 netfs_unbuffered_write_iter+0x40c/0x710 fs/netfs/direct_write.c:377
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e9919c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e9a09f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9e99415fa0 RCX: 00007f9e9919c799
RDX: 000000000208e24b RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007f9e99232bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9e99416038 R14: 00007f9e99415fa0 R15: 00007fff05034208
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003b7fb90 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88803bd3a5b0 RCX: ffffffff82c49d0a
RDX: ffff88802b9ca4c0 RSI: ffffffff82c49b9c RDI: ffff88803bd3a500
RBP: 0000000000140000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88803bd3a598
R13: dffffc0000000000 R14: ffff88803bd3a500 R15: ffff888023066580
FS:  00007f9e9a09f6c0(0000) GS:ffff8880d6644000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002c65b000 CR4: 0000000000352ef0


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

