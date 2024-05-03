Return-Path: <linux-fsdevel+bounces-18654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407118BAF4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C71CB21892
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293AC4A99C;
	Fri,  3 May 2024 14:55:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87246BA0
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748133; cv=none; b=l2ushRL5ScUsighRkcAGGLhM7jRCnHeFZHuVxp56t2yHTFunzfxawIzcyURheDmCn+6sjHxVdjBacirvjGTd+9pSg4fQFeGTzfu3dOG3cdz/6qOgPa1Z2tdZah9vcKj5Mwk6nI8VPF1nOLKKhj+BaoG+9fOsj3/2VIs0NKNVu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748133; c=relaxed/simple;
	bh=QKHQ8GXzaHQv7SZhL6uyVbGA/6cXE3hUh7Z5YIWKyic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IvqqfSkq3UAp5KKYMlyBDTog60vZ2A4XkeXmrLXBFiINZzOAn4S3oSBLSxYEazIpIqFwx0cL1Dex9I6BIN/K56hOnM1SMUo9S4F1Jtu8wSA8j+5B4vjRVUsZMXYpXJHnKlhGJZjZY6DXS8m7kXHL7a6Uc46xHSYRM3j9e/18Lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso833633039f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 07:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748130; x=1715352930;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHjzFqTGEImXhvutzT4hL2jo5Ja0cpO/UGtE6EWFnh0=;
        b=aOEyT2oh7+1ut4P3QY4TpJvxVeE0l+L5vVVvSUS3YqkHxO8k9XnHpSHcYmtw34yA7c
         fPfQYQLq5GnDrmwu31SnTEIPHZyV2Af7qSYJReo8Au/asVlRDPBXyLSF7VbRhsKtQKHR
         xun34d3EaGRfr4GBiYMHnfcWhimwuGwAhkNXMpo/E8fe/0u61b0FrAmTn4KPMTOeb0n3
         4dOJ0Ymal+0dwK65akkXRBCgI+71SCcgyygj9IYyrXg3TblVS3SelYcN9UPKa1mAO+Yg
         Eu+B+XW75X18KxQeMDmL5ZXusIFQtDHk2nwyEndHU5bkzIBeVjEIg4gexNKArkJCEwm1
         S5aw==
X-Forwarded-Encrypted: i=1; AJvYcCWyzRKMShpgBqjzU6K5n4EM6enj9RVmtNyuCiZImZyM56zJM0aG3xQM+yUSy+taazJez9AskMuK8yoJ7PbTH1TS7SqMswO0WWufHjI50g==
X-Gm-Message-State: AOJu0YxWjB+3DOJcBVEgZZY3QJgQx8amv0Nj6a8k3A6Vf8+J6tkEDB70
	u2poWB77FqHYv24PkuPVryOt6toi4kqs9SdgDDQLbG8OJeL5tfvO0DcSevpo0YWiiy9D+j4qiZB
	3uLxAjFh8IMGgsu2ds1vlvxsWvIhIEc/SQ954jPGnjoS7KA0RJwMg/KM=
X-Google-Smtp-Source: AGHT+IFecX4KwUhq16GQoy4m1dbwzzqR8OHn14RgAK+2KWtIOJI1j0KW8HKfFgVz9Pdk+V9aZeJgfv0sRXkZnm8CXbiaWOCOgPOj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8c16:b0:487:cbff:ac40 with SMTP id
 jl22-20020a0566388c1600b00487cbffac40mr122447jab.4.1714748130405; Fri, 03 May
 2024 07:55:30 -0700 (PDT)
Date: Fri, 03 May 2024 07:55:30 -0700
In-Reply-To: <000000000000f75b4906178da124@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003143a506178de969@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_node_read_done
From: syzbot <syzbot+bf7215c0525098e7747a@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131169df180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=bf7215c0525098e7747a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177775df180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107ed354980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b281.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b281.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7414e75d88aa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf7215c0525098e7747a@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=crc64,data_checksum=none,nojournal_transaction_names
bcachefs (loop0): recovering from clean shutdown, journal seq 10
------------[ cut here ]------------
kernel BUG at fs/bcachefs/backpointers.h:75!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5095 Comm: syz-executor372 Not tainted 6.9.0-rc6-next-20240503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:bucket_pos_to_bp fs/bcachefs/backpointers.h:75 [inline]
RIP: 0010:bch2_backpointer_invalid+0x9cc/0x9d0 fs/bcachefs/backpointers.c:65
Code: fc ff ff e8 f6 19 8d fd 48 c7 c7 40 7f 91 8e 48 89 de e8 87 e9 e2 00 e9 fc f7 ff ff e8 dd 19 8d fd 90 0f 0b e8 d5 19 8d fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 53 e8
RSP: 0018:ffffc9000344e600 EFLAGS: 00010293
RAX: ffffffff8408fc0b RBX: 00000000002d3cb6 RCX: ffff88807db18000
RDX: 0000000000000000 RSI: 00000000002d3cb6 RDI: 000000000000001b
RBP: 000000b4f2d90000 R08: ffffffff8408f5aa R09: 1ffffffff25f54b0
R10: dffffc0000000000 R11: fffffbfff25f54b1 R12: 1ffff92000689d58
R13: ffffc9000344eaa0 R14: ffff8880747000bb R15: 000000000000001b
FS:  0000555571535380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561aa32c7360 CR3: 0000000077a0a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_btree_node_read_done+0x3e7d/0x5ed0 fs/bcachefs/btree_io.c:1234
 btree_node_read_work+0x665/0x1300 fs/bcachefs/btree_io.c:1345
 bch2_btree_node_read+0x2637/0x2c80 fs/bcachefs/btree_io.c:1730
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1769 [inline]
 bch2_btree_root_read+0x61e/0x970 fs/bcachefs/btree_io.c:1793
 read_btree_roots+0x22d/0x7b0 fs/bcachefs/recovery.c:472
 bch2_fs_recovery+0x2334/0x36e0 fs/bcachefs/recovery.c:800
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
RIP: 0033:0x7f754d2be98a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffdfc823d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fffdfc823f0 RCX: 00007f754d2be98a
RDX: 0000000020011a00 RSI: 0000000020011a40 RDI: 00007fffdfc823f0
RBP: 0000000000000004 R08: 00007fffdfc82430 R09: 00000000000119f7
R10: 0000000002000000 R11: 0000000000000282 R12: 0000000002000000
R13: 00007fffdfc82430 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bucket_pos_to_bp fs/bcachefs/backpointers.h:75 [inline]
RIP: 0010:bch2_backpointer_invalid+0x9cc/0x9d0 fs/bcachefs/backpointers.c:65
Code: fc ff ff e8 f6 19 8d fd 48 c7 c7 40 7f 91 8e 48 89 de e8 87 e9 e2 00 e9 fc f7 ff ff e8 dd 19 8d fd 90 0f 0b e8 d5 19 8d fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 53 e8
RSP: 0018:ffffc9000344e600 EFLAGS: 00010293
RAX: ffffffff8408fc0b RBX: 00000000002d3cb6 RCX: ffff88807db18000
RDX: 0000000000000000 RSI: 00000000002d3cb6 RDI: 000000000000001b
RBP: 000000b4f2d90000 R08: ffffffff8408f5aa R09: 1ffffffff25f54b0
R10: dffffc0000000000 R11: fffffbfff25f54b1 R12: 1ffff92000689d58
R13: ffffc9000344eaa0 R14: ffff8880747000bb R15: 000000000000001b
FS:  0000555571535380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561aa3246638 CR3: 0000000077a0a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

