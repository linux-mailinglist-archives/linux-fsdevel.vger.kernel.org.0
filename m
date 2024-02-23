Return-Path: <linux-fsdevel+bounces-12529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1187F8608A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 03:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DE52850E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB4B673;
	Fri, 23 Feb 2024 02:03:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DBC2D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653805; cv=none; b=YdqZ8yznpZsMR/ikG0nJGaFzlSdmcFF26rht43z/d6uFDlM65JhGVpDYSI5NE7QfoKLr0HL8NVzvaRzvWgV/Tsg2hTKCxn2R/MnuI73TAPRsXxJIffnapx8V0qXQrkKD0dNKyXJI+VplTw2SyAhEXcjf2vlvsqMM9J4LlGIkJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653805; c=relaxed/simple;
	bh=EqwwQgShDPZSCFmD4EAzdDLI0VQyrLpY6aA9djXYpBo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eKh2lDDA91lsAawT3+Tzh4c7cVUE9BvV4Vp4Na3WGeSV+PTbLYtz53+YtiyB2M5r+7kNUB7/PEuW88WwFLJV2KNMBCCNhkeKVrBktBnjSXoAE5V3A+BZlPjpEILcJ7xXoWluPGnyyKzHBWLODPcgMpLKnCAe11df4rrgm3CISHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365256f2efcso4542725ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 18:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708653803; x=1709258603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKrgf129mFrg2kPZfg0LvclHW3UF997R10zWrzVHdFM=;
        b=eilajygkd/vVK828+gMmQ5fJkTOQozTGxKyFcM8NvwcaZO47003+ysDgJSlTKTgD9L
         9NgYxgntCtVVaGjtQX75oRYkD8LuNJ93jbusU6nyfFTLjUZpAlv9pX65rdphveo3nBc9
         IFtCvz5us2sAfY9EgFWLvNMM/485D/o83smta4Tbbj/dk0ygy7go6ZXhcT+WC0N93E1H
         74hzbqCCQ7vh346qp7dy910GLq53gwzbsvaQS90AeknFDVKed0Ap0iZgGR5HFI7M+409
         awcSRgpgawjBN71tzI0/SmseyUMZ8NvhsdacR0kPmpO/PgATCPKCpzjtOPzPk5Bz7FHy
         QW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXycQWAZWBrPoDUBxIZcVf/yqBJ6T0P37H5ojnNxW+yp1am3N2ztiFO8xkrbUFXGQR1L0XWBbKZNGBeVPx3Jz0MITe/hHHuXRg847vcUA==
X-Gm-Message-State: AOJu0YztB2n0yn3ir74NyfumI4DgyWRP6bpUqeAu0v85B+p5JJkEe5fr
	yeygRpGwT4ZSvMuql9agUIsNoAxsrefWoG3AG3QmQUghX90r21CIcu8V+IY3G9FHn4gjiVle69S
	VSSkJ4NxaJBJWT1uOa4QzG3F3JxvF8zA9rBCshtQtmlAWF+zMwrGCffI=
X-Google-Smtp-Source: AGHT+IGM0alMyQC7fdJq8wc8McpSrAwflkSLEWNeVF2I359YAzIrPa++BCY4VhsMhFclFulIY0oVvWm6SJWzmNZE0f6fuuUQxP4C
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:365:1f2b:7be8 with SMTP id
 b15-20020a92c56f000000b003651f2b7be8mr49353ilj.5.1708653802842; Thu, 22 Feb
 2024 18:03:22 -0800 (PST)
Date: Thu, 22 Feb 2024 18:03:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f673a1061202f630@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_get_root_ref
From: syzbot <syzbot+623a623cfed57f422be1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c02197fc9076 Merge tag 'powerpc-6.8-3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16765b8a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caa42dd2796e3ac1
dashboard link: https://syzkaller.appspot.com/bug?extid=623a623cfed57f422be1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b2a3f729cc3/disk-c02197fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4f10e6eb1ca/vmlinux-c02197fc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8488781d739e/bzImage-c02197fc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+623a623cfed57f422be1@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=51 which is not allocated.
WARNING: CPU: 1 PID: 31038 at lib/idr.c:525 ida_free+0x370/0x420 lib/idr.c:525
Modules linked in:
CPU: 1 PID: 31038 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkaller-00410-gc02197fc9076 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:ida_free+0x370/0x420 lib/idr.c:525
Code: 10 42 80 3c 28 00 74 05 e8 6d a3 9b f6 48 8b 7c 24 40 4c 89 fe e8 a0 89 17 00 90 48 c7 c7 00 ca c5 8c 89 de e8 01 91 fd f5 90 <0f> 0b 90 90 eb 3d e8 e5 85 39 f6 49 bd 00 00 00 00 00 fc ff df 4d
RSP: 0018:ffffc90015a67300 EFLAGS: 00010246
RAX: be5130472f5dd000 RBX: 0000000000000033 RCX: 0000000000040000
RDX: ffffc90009a7a000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc90015a673f0 R08: ffffffff81577992 R09: 1ffff92002b4cdb4
R10: dffffc0000000000 R11: fffff52002b4cdb5 R12: 0000000000000246
R13: dffffc0000000000 R14: ffffffff8e256b80 R15: 0000000000000246
FS:  00007fca3f4b46c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f167a17b978 CR3: 000000001ed26000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_get_root_ref+0xa48/0xaf0 fs/btrfs/disk-io.c:1346
 create_pending_snapshot+0xff2/0x2bc0 fs/btrfs/transaction.c:1837
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1931
 btrfs_commit_transaction+0xf1c/0x3740 fs/btrfs/transaction.c:2404
 create_snapshot+0x507/0x880 fs/btrfs/ioctl.c:848
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:998
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1044
 __btrfs_ioctl_snap_create+0x387/0x4b0 fs/btrfs/ioctl.c:1306
 btrfs_ioctl_snap_create_v2+0x1ca/0x400 fs/btrfs/ioctl.c:1393
 btrfs_ioctl+0xa74/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:857
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fca3e67dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fca3f4b40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fca3e7abf80 RCX: 00007fca3e67dda9
RDX: 00000000200005c0 RSI: 0000000050009417 RDI: 0000000000000003
RBP: 00007fca3e6ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fca3e7abf80 R15: 00007fff6bf95658
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

