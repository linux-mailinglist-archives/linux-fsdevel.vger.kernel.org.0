Return-Path: <linux-fsdevel+bounces-14208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15187951D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 14:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C048B212A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E077A71A;
	Tue, 12 Mar 2024 13:29:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392A7A154
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250165; cv=none; b=UP8eosILa1vmYBuRCnl4aKJmwvNJXYxVsx98GcxUEKW08+p2tV0gVHwF+IWgVTVOMl/p0LWPfP8qtooSJUL8FplSWyJYN41R8e44efM/Y9x2CFEFmqz1MCcgTXQlxcxjuugnFyMXZLf/tr8yfbhNrD+h1+pet9N8wEZhlnEk6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250165; c=relaxed/simple;
	bh=9zDWvzr+Z/USZHV5GgIfmY6ihcfdVLNoDxi/gf9ye2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EwoUUv123b1Lqnn4haBgd/gVeByt+QSMigQBKlffjTXOZd7AIi3MkGGFcoB1szfq+nve+tR7kK5DcwJAk/mIOKZxzA+90+Z56P/p+lCBn9nDnIcgNM0cL9M1Vbhn6Ct7zlQ3TF0hFAbd+AOk0GXx5+zu/eweTHWwOwnMh1MwSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8bcaf249aso155386039f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 06:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710250163; x=1710854963;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bq8oySasJniwgrTVTRjL6eVYP1UAR0wtRyHJzV1J4yQ=;
        b=v395b8OtczJx5xaQ7Tn8wXBEZcZTs4IaPE0mk6zZiIyRFGMy3o55MYUAQRvChpbS0z
         qXxKHXQJHmJ2NdqVgC77UDHeyiMesBuGeSMMASAA76yfYl/0xnh9YhMSrJfj3zR8rod3
         9w4gng14b2bDmtShKfcDbiZ26fjUwMnG8CLRFw5KWR3aLa2Ibw3extiSwH1SlFB37w67
         yfKQ0AtaDX0yrR1KgpIQWZAEvRDw3p7Mpi8RdL7S6bqrXwzg8sLQLKoDLVuXlk5BTCjk
         ufZtiUqdS19Ty15dVhrMmsUd7YjzFOG2aRsY55/RUSvXkJXIsR49JjbePW0fAA6Zokra
         LgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhIflcXY9STdPrsNUMV0WUP/UQwU7eLl+vP03NS3hplb8ytMFyCWiTS6H/hGJ6eA8X7RgcXVxltXHHfF9sQgZRaCoSvficDwGhvd18SA==
X-Gm-Message-State: AOJu0YxoerCrm8jSFyD5SgfXjmbZ7JcaRE1LBFTepXEy9EehTT1a3f4E
	bJfs+Fu/SNbb7YplNEe1Jtz5lGxvdtEU3RU31ektwtJztWNfEz6ViEJmEHm21j4ZFTDrQV+USiJ
	RkD2S9uX+HW/Db4o+VGbBlVBPqizlevmNZdFsqR9mkU1+djrB8ZIhMZM=
X-Google-Smtp-Source: AGHT+IGZeZXXf8bH1DA0X3MAx8JZZLhiIrMrnaS65+hIG+wrDzDFoNAll+p4zbvX73DtHyoDMbY6aHVDzjeMhO65SD2eaihZWCxn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc2:b0:7c8:de8:83c with SMTP id
 l2-20020a0566022dc200b007c80de8083cmr141541iow.2.1710250162968; Tue, 12 Mar
 2024 06:29:22 -0700 (PDT)
Date: Tue, 12 Mar 2024 06:29:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070f071061376a5b6@google.com>
Subject: [syzbot] [net?] [afs?] WARNING in rxrpc_alloc_data_txbuf
From: syzbot <syzbot+150fa730f40bce72aa05@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	kuba@kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    75c2946db360 Merge tag 'wireless-next-2024-03-08' of git:/..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16700bf2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc4c0052bd7e51d8
dashboard link: https://syzkaller.appspot.com/bug?extid=150fa730f40bce72aa05
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163dfe92180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17818449180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b9317816c71d/disk-75c2946d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d18e4d62eff/vmlinux-75c2946d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9089b556e6fd/bzImage-75c2946d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+150fa730f40bce72aa05@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5074 at include/linux/gfp.h:323 page_frag_alloc_align include/linux/gfp.h:323 [inline]
WARNING: CPU: 1 PID: 5074 at include/linux/gfp.h:323 rxrpc_alloc_data_txbuf+0x7cf/0xda0 net/rxrpc/txbuf.c:36
Modules linked in:
CPU: 1 PID: 5074 Comm: syz-executor206 Not tainted 6.8.0-rc7-syzkaller-02348-g75c2946db360 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:page_frag_alloc_align include/linux/gfp.h:323 [inline]
RIP: 0010:rxrpc_alloc_data_txbuf+0x7cf/0xda0 net/rxrpc/txbuf.c:36
Code: 96 01 f7 4c 89 f7 e8 a0 f1 58 f7 45 31 f6 4c 89 f0 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 42 96 01 f7 90 <0f> 0b 90 e9 8d f9 ff ff 44 89 fe 83 e6 01 31 ff e8 6c 9a 01 f7 44
RSP: 0018:ffffc9000398f328 EFLAGS: 00010293
RAX: ffffffff8a91d8de RBX: 0000000000000000 RCX: ffff8880284f5940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffffffff8a91d266 R09: 1ffffffff1f0c0fd
R10: dffffc0000000000 R11: fffffbfff1f0c0fe R12: ffff88802e3a4390
R13: ffff88801b6b5280 R14: ffff88801caf4900 R15: 0000000000000cc0
FS:  0000555556094380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020005c08 CR3: 00000000755e2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxrpc_send_data+0xb17/0x2800 net/rxrpc/sendmsg.c:351
 rxrpc_do_sendmsg+0x1569/0x1910 net/rxrpc/sendmsg.c:718
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmmsg+0x3b2/0x740 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fb02c0cf369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc045a3f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007ffdc045a5c8 RCX: 00007fb02c0cf369
RDX: 0000000000000001 RSI: 0000000020005c00 RDI: 0000000000000003
RBP: 00007fb02c142610 R08: 00007ffdc045a5c8 R09: 00007ffdc045a5c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdc045a5b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

