Return-Path: <linux-fsdevel+bounces-18499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F228B9954
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 12:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001681F21306
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A5160263;
	Thu,  2 May 2024 10:44:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A365CDE9
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646665; cv=none; b=UWSt4rO7LZ8ZLaNqBrLyrn4WM36h81OB0qoy6iwvudmiWtS9iVxAZKDF5MQtZGt5mHsFpgdXpXCqls63Yu3wjDi1Jew87DvoAYoj9j/TeKPffGb7XCerlOUI4bRRXPaL6N6D0CeVUx+0lsFkCFWqazU6Xp5ywjKcKIl6DQ97pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646665; c=relaxed/simple;
	bh=NOH4Q80i0aHmhlMjpXkQRsNTtB7joD46Fj469GefL1I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gdKDqXEhhbWilr8iC0xYJIovGqoXK9y6I3PkGqh2rp6wi2DKXWBzhRVuLjACRHhGMktIZXGUUm5rU1AW02sY4Yu9mnF+1KCJxz8zKAowt+UiSo9h+pMow6D9bQGxKWLzV0/Ss/zZZ/taPRsMe4/LbiiyAJzQkUWpveEJ34B4P28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dec4e29827so474932639f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 03:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714646663; x=1715251463;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dl6UnXILKm1BseeObaKJwodV315wbNFh9cCBT8pNe4=;
        b=HrNQCl2vtLDSPQ7ZEXV65/yggoEwOriaiQd0zx4sNTYGpNpVkD/ViT7hlPut02jKoP
         mlgIYQuRgGGvPmYBAv3ZX8MhIJdDlUbMD9fnPEfhOu3UdeShiO9nTL0PlF9zwcf0U67s
         AKk4lTJH9gQY191H5+EJpAu7FA57wCvW17G3R9M8m4ONHQBWojNf+ZcF0f/B2OTyclCS
         Ats/q2AK4OsLTeha+RDUOn+juZrQsWKihh3TReenKbeJmJnKnlUiGYFghNm2KUjMgLr3
         59M6jsI0vZ+Srw0T2CU3nkA3Mr/5mFBJxZw3gtpmI1jWL7suKPkZHnrKkEfHlk+wEMti
         +HCw==
X-Forwarded-Encrypted: i=1; AJvYcCUiwFSJh6AWyx1g2c9cp6/Mo98dGdc0iIjRwKjHeRsfpSBVBzMh0vkOYM8jiQOYnSSywux7ub7Lndn/ovI30BQY8AEeeymY5/jYHWBmkA==
X-Gm-Message-State: AOJu0YxOGs+NnskzQbZYrAS990d5etNEBKjpdZYZkLQ7gcU5vBuIloMC
	vDIOBSmLdFH9t6cyJ+AvWsfsesMJYmTzpjThJP6MYWh7TjB9ktHDDDKwpmKW7b7/xiFEiYB7pyM
	kl3eZW4fA33tVxWrCNgmHfqv8vdHz00zVrM54ox945Z11YUuoNHiImBw=
X-Google-Smtp-Source: AGHT+IHxewD7L+JVk/FKz42jZGn5HicAWf7z/TKYTsW5cpAppB2iyirUg5mS6LexhNlSvadPeYQNqoXay0geZyv011hggP10M8sL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c9:b0:487:30aa:adb6 with SMTP id
 n9-20020a05663831c900b0048730aaadb6mr158463jav.2.1714646663339; Thu, 02 May
 2024 03:44:23 -0700 (PDT)
Date: Thu, 02 May 2024 03:44:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048aa8506177649b0@google.com>
Subject: [syzbot] [iomap?] WARNING in iomap_iter (2)
From: syzbot <syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c8159388952 Merge tag 'rust-fixes-6.9' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157da5e8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7edc7330e976610e
dashboard link: https://syzkaller.appspot.com/bug?extid=0a3683a0a6fecf909244
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c1a97f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1538a228980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2c815938.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f7792ed3c5c/vmlinux-2c815938.xz
kernel image: https://storage.googleapis.com/syzbot-assets/28870b4ff18a/bzImage-2c815938.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f3da29bab42a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 5183 at fs/iomap/iter.c:51 iomap_iter_done fs/iomap/iter.c:51 [inline]
WARNING: CPU: 3 PID: 5183 at fs/iomap/iter.c:51 iomap_iter+0xe1e/0x10b0 fs/iomap/iter.c:95
Modules linked in:
CPU: 3 PID: 5183 Comm: syz-executor200 Not tainted 6.9.0-rc5-syzkaller-00355-g2c8159388952 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:iomap_iter_done fs/iomap/iter.c:51 [inline]
RIP: 0010:iomap_iter+0xe1e/0x10b0 fs/iomap/iter.c:95
Code: 0f 0b 90 e9 e2 f8 ff ff e8 5f 42 73 ff 90 0f 0b 90 e9 b1 f7 ff ff e8 51 42 73 ff 90 0f 0b 90 e9 38 f7 ff ff e8 43 42 73 ff 90 <0f> 0b 90 e9 4b f7 ff ff e8 35 42 73 ff 90 0f 0b 90 e9 e5 f6 ff ff
RSP: 0018:ffffc90003367a38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90003367b60 RCX: ffffffff821a7538
RDX: ffff888021e1c880 RSI: ffffffff821a7ded RDI: 0000000000000006
RBP: 0000000000fffc80 R08: 0000000000000006 R09: 0000000000fffc80
R10: 0000000000fffc80 R11: 0000000000000000 R12: 0000000000fffc80
R13: ffffc90003367ba2 R14: ffffc90003367b98 R15: 0000000000fffc00
FS:  00007f52540656c0(0000) GS:ffff88806b500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 0000000022e6c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_file_buffered_write+0x202/0x9c0 fs/iomap/buffered-io.c:1014
 blkdev_buffered_write block/fops.c:658 [inline]
 blkdev_write_iter+0x4f3/0xc90 block/fops.c:708
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6db/0x1100 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f52540af509
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5254065168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f525413b608 RCX: 00007f52540af509
RDX: 0000000001670e68 RSI: 0000000020000380 RDI: 0000000000000005
RBP: 00007f525413b600 R08: 00007f52540656c0 R09: 0000000000000000
R10: 00007f52540656c0 R11: 0000000000000246 R12: 00007f525413b60c
R13: 0000000000000006 R14: 00007ffeeef47cd0 R15: 00007ffeeef47db8
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

