Return-Path: <linux-fsdevel+bounces-18769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A048BC304
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3148A2817C9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4606E61F;
	Sun,  5 May 2024 18:25:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F86BB29
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714933544; cv=none; b=ewTL/EPeAD2cPvSoKXYEeWG6HD1qdoJevtFf26G5xBJj6+OHWPWg8FE4qdcsNAFUPv9ngjtaJsTef2yDGvGv3fVaA5g1seeOsMtKNfwOHgIVE2Tc9Fqs0iSsDrEGHpYQPk6IqA/YeYAbPQP/5Qz24QOGiHeN1dOsrmlIC7RKb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714933544; c=relaxed/simple;
	bh=//bqdXS8w0BW15dtdl5gmSDcss5UyazdNdNNJku+Twg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c0pIbC+P7fEGejtxZPAFvHYV8Ye2h+YFkK+py13ifUfRH2LASUddPzaRpCg5QsKbE6CherNQmB0vEMNisDbfCghlrGZ/I5IvYP+fIK2rWn833ikj/fkwT7Mn2ud8Iw5psDMp0mJNUTAyFu+S8maBDtdBJ3q0KB16I6eAwC9PzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7da42f683f7so84247239f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 11:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714933542; x=1715538342;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6zs6mgxeD7FCVOWi2xhlCSZQPLkGDhYzpu77IBMvu0=;
        b=mp9z3Do3/Hjfopx3q74oR4YHQvclBmrUxD1MZC+BAtKCfUQvWu5YFPSxX3ka/gav6V
         0cvluwlkPBp83sNK/Ke3/casmDv82xKXfksYk5wRf6KFqk0VVnNoGVOCkGTuMieBh4z3
         Cq0saYZDZlB/GSP2u/U+BwF3tFz/zY8a1lMwLtIAqsbwgPwTWgFG67VGakxAV00FeCym
         +K7xBvexzKXARqhU6BxK+nYIF5P6vm7jquZqi9CrywukKdrGuHuTKIzoYq6ogkPzqaYZ
         BPVLoqH6Utv+11kdCPbnpPAcyWdZdGUUz1ZH2CUlmMlRLbhBT7WZ2dRINTtyxvNPiMSz
         h50g==
X-Forwarded-Encrypted: i=1; AJvYcCVVPP2EXQ2E4NplE4hMSP/GU6RrL7PHQY+ZEQHQf440IM7am0rjxfaZKiyH55fI2l91vjGrEzM/A1Y8EKYjVTj32dUqPLxGyi9fkI1WdQ==
X-Gm-Message-State: AOJu0YyCR0QoTL0W4MaEAzH+XZ7Ek/i+8ExvpNBO1rQb8qHx3u922zDA
	H596dowzpdLjHVoVf4HliTka0KNQvBMtW911PftLi8dwHSYA+b8ZkMqXL09WBFldiKQ7OPIw097
	YZJK0KY/3B6XCxThtT9MOOphnTbJbJniE5Up8q4Ghv2Z68eeKrCMgPuk=
X-Google-Smtp-Source: AGHT+IGNSnh0TNI8LFcDsrwxqx5tq9GkaeP4HhY6PUTEPhUSzWr2I4V9XFfIuZ1+lU+ZIVXha5t0YsxmKkaMh51+HASZBKUrAuoY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:36c:4457:ca5d with SMTP id
 j22-20020a056e02219600b0036c4457ca5dmr290905ila.5.1714933541408; Sun, 05 May
 2024 11:25:41 -0700 (PDT)
Date: Sun, 05 May 2024 11:25:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c9a4c0617b9140c@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_sort_keys
From: syzbot <syzbot+300755e8da6fa5e5edec@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14dc9a4c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=300755e8da6fa5e5edec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12118a70980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16722a4c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b281.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b281.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/de11adcb4745/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+300755e8da6fa5e5edec@syzkaller.appspotmail.com

bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=compression=lz4,nojournal_transaction_names
bcachefs (loop0): recovering from clean shutdown, journal seq 7
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/bkey_sort.c:185!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5093 Comm: syz-executor254 Not tainted 6.9.0-rc6-next-20240503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:bch2_sort_keys+0x1a62/0x1a90 fs/bcachefs/bkey_sort.c:184
Code: e1 07 80 c1 03 38 c1 0f 8c 47 ea ff ff 48 8b 7c 24 20 e8 a1 3d f0 fd e9 38 ea ff ff e8 d7 8e 8a fd 90 0f 0b e8 cf 8e 8a fd 90 <0f> 0b e8 c7 8e 8a fd 90 0f 0b e8 bf 8e 8a fd 90 0f 0b e8 b7 8e 8a
RSP: 0018:ffffc9000375e8a0 EFLAGS: 00010293
RAX: ffffffff840b8711 RBX: 0000000000000080 RCX: ffff88802889bc00
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000000
RBP: ffffc9000375ea30 R08: ffffffff840b768c R09: 0000000000000000
R10: ffffc9000375e7a0 R11: fffff520006ebcf6 R12: ffffc9000375eb20
R13: 0000000000000001 R14: ffff888079100901 R15: ffff8880791008b9
FS:  00005555567cf380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d90bd11f18 CR3: 0000000079808000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btree_node_sort+0x6ad/0x1840 fs/bcachefs/btree_io.c:335
 bch2_btree_post_write_cleanup+0x120/0xa70 fs/bcachefs/btree_io.c:2273
 bch2_btree_node_write+0x169/0x1f0 fs/bcachefs/btree_io.c:2314
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x2ac/0x350 fs/bcachefs/btree_trans_commit.c:250
 bch2_btree_node_flush0+0x27/0x40 fs/bcachefs/btree_trans_commit.c:259
 journal_flush_pins+0x5f7/0xb20 fs/bcachefs/journal_reclaim.c:553
 journal_flush_done+0xbc/0x260 fs/bcachefs/journal_reclaim.c:809
 bch2_journal_flush_pins+0x102/0x3a0 fs/bcachefs/journal_reclaim.c:839
 bch2_journal_flush_all_pins fs/bcachefs/journal_reclaim.h:76 [inline]
 bch2_journal_replay+0x1094/0x1360 fs/bcachefs/recovery.c:301
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:182
 bch2_run_recovery_passes+0x19e/0x820 fs/bcachefs/recovery_passes.c:225
 bch2_fs_recovery+0x235e/0x36e0 fs/bcachefs/recovery.c:804
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1030
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2105
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1917
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2bec06b8ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc4937aec8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc4937aee0 RCX: 00007f2bec06b8ba
RDX: 0000000020005d80 RSI: 0000000020000000 RDI: 00007ffc4937aee0
RBP: 0000000000000004 R08: 00007ffc4937af20 R09: 0000000000005d7f
R10: 0000000000000002 R11: 0000000000000282 R12: 0000000000000002
R13: 00007ffc4937af20 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_sort_keys+0x1a62/0x1a90 fs/bcachefs/bkey_sort.c:184
Code: e1 07 80 c1 03 38 c1 0f 8c 47 ea ff ff 48 8b 7c 24 20 e8 a1 3d f0 fd e9 38 ea ff ff e8 d7 8e 8a fd 90 0f 0b e8 cf 8e 8a fd 90 <0f> 0b e8 c7 8e 8a fd 90 0f 0b e8 bf 8e 8a fd 90 0f 0b e8 b7 8e 8a
RSP: 0018:ffffc9000375e8a0 EFLAGS: 00010293
RAX: ffffffff840b8711 RBX: 0000000000000080 RCX: ffff88802889bc00
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000000
RBP: ffffc9000375ea30 R08: ffffffff840b768c R09: 0000000000000000
R10: ffffc9000375e7a0 R11: fffff520006ebcf6 R12: ffffc9000375eb20
R13: 0000000000000001 R14: ffff888079100901 R15: ffff8880791008b9
FS:  00005555567cf380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d90bd11f18 CR3: 0000000079808000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

