Return-Path: <linux-fsdevel+bounces-12539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF6860A96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 07:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2001C1F2565F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 06:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69112E5E;
	Fri, 23 Feb 2024 06:04:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716F12B84
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668276; cv=none; b=puaVaQcud5IF3WK4uQ3mJiO+9XayMFVmozLu3cB7NjYN6g7la3GpZ9xooI6tHAccHolS8teUz1tVx9NeCSehzqWsiZmNAEw9Ayj5gG9Gy9Izkcl5vxi3bX9UKP5bwtjuRIqBTgDR6n6PCDAds/HdyL1rd1YIkD6HJ/en3utlqY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668276; c=relaxed/simple;
	bh=0NKzQCLtuKQmnXjNttL+pCw9kx0LdMVa/ys9hMUiF+0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VE7WTJJapUV8VrVopvlFDJVARPeWuBFRJ8XF0t4JlZgz8R+v2N06P3xIwvyI+egWRwgka6j2Tk3oIMjJrhKl3kL4VphbXFwM8P6m0o3dlJ2yTPcy3gR02Johl9boIh9xrhb6c/hGihbDPlIx+sIVistBIi1tF2/h2rY2JkCN74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfffd9b47fso49023239f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 22:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708668263; x=1709273063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yfL9ZgM+xNjftalFROFDZTzyqRtfFJqv19NzNVxKQs=;
        b=Qu8Y2sySCuyRdpKFdQp3VI2/c2GJ14LdgipRlLL8usiQjPOJioK42tKpYzjl32nrEK
         kjefB/M1O7Mt87ITC+iJBY7Kz3bmXLli57zz7I0IlIIhWhnJM31CJy7+Rf8ynfuXzMfb
         XgAyi9RRrbWmpmtt4t1B52yaP0PLxHOqY6r05yKKajk6iXnFUSQwNW6kuIhdS+JSYmRE
         FkasWWD5Xa6ug3FUHC8fCi9rSc3ig0IHasrD7w/+cgHNgwXeMvgsF3DwxSUZIXvwF1wR
         AZ/z7Bo4Ei/kmwYzMTrESbXtfECDChS3Ugy8mfWLNXTtQuV526UCnU5aYSntgb3e+zhY
         xlvA==
X-Forwarded-Encrypted: i=1; AJvYcCVhwjxMY8ahkxCRaZK7YxvwPPaiuNDvDfsDGldGZkUL6q6tSZLJqzdjWSdtcrSpftb73876ILUj8FaeCPT96Hi4iKIEFZaEnue8q20S8Q==
X-Gm-Message-State: AOJu0YxHNVFyzIAwURY/OlmorTY8mF94EvMLzVboHo6d9XQWtOwsIurb
	5eE9BMy6e6cDENN0Z9GgCsu3VuVwSbMlKSU4KRCxIW6c4YhDQk6xMRp1ObddpokcBJ49ZjfM7F+
	g5ienJPpRJujShhpO4DTqFGe7S0iSggMhVA903gCqBsMS6i5HQVu+ArA=
X-Google-Smtp-Source: AGHT+IEyq7wJnEDBhPSFjf5QgnBawSRxxTdeBiKNw9U+oHR8c8CQHxv9ZiRKlRDatNHLxEexvwhlSY/0woJ4pj7aHnRroKXJF5vg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:365:1c10:9cfa with SMTP id
 v13-20020a056e02164d00b003651c109cfamr90947ilu.5.1708668263435; Thu, 22 Feb
 2024 22:04:23 -0800 (PST)
Date: Thu, 22 Feb 2024 22:04:23 -0800
In-Reply-To: <000000000000f673a1061202f630@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1a463061206549f@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_get_root_ref
From: syzbot <syzbot+623a623cfed57f422be1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    1c892cdd8fe0 Merge tag 'vfs-6.8-rc6.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dbda8a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=623a623cfed57f422be1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166f9002180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b749aed7a8d1/disk-1c892cdd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8734e56ba943/vmlinux-1c892cdd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0bfc6f22fe8/bzImage-1c892cdd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8c78af1bc0b5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+623a623cfed57f422be1@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=46 which is not allocated.
WARNING: CPU: 0 PID: 5197 at lib/idr.c:525 ida_free+0x370/0x420 lib/idr.c:525
Modules linked in:
CPU: 0 PID: 5197 Comm: syz-executor.1 Not tainted 6.8.0-rc5-syzkaller-00121-g1c892cdd8fe0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:ida_free+0x370/0x420 lib/idr.c:525
Code: 10 42 80 3c 28 00 74 05 e8 7d 86 9b f6 48 8b 7c 24 40 4c 89 fe e8 a0 89 17 00 90 48 c7 c7 80 c9 c5 8c 89 de e8 21 72 fd f5 90 <0f> 0b 90 90 eb 3d e8 45 67 39 f6 49 bd 00 00 00 00 00 fc ff df 4d
RSP: 0018:ffffc90004a1f300 EFLAGS: 00010246
RAX: a25cdedaf9286500 RBX: 000000000000002e RCX: ffff888025b58000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004a1f3f0 R08: ffffffff81577ab2 R09: 1ffff92000943db4
R10: dffffc0000000000 R11: fffff52000943db5 R12: 0000000000000246
R13: dffffc0000000000 R14: ffffffff8e256d00 R15: 0000000000000246
FS:  00007f51d0a726c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056090d5db000 CR3: 000000007b920000 CR4: 0000000000350ef0
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
RIP: 0033:0x7f51cfc7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f51d0a720c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f51cfdabf80 RCX: 00007f51cfc7dda9
RDX: 00000000200005c0 RSI: 0000000050009417 RDI: 0000000000000003
RBP: 00007f51cfcca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f51cfdabf80 R15: 00007fff8ee6fb18
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

