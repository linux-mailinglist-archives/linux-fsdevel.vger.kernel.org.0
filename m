Return-Path: <linux-fsdevel+bounces-21772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403E2909B5B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 05:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63C91F2221B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7216C6B8;
	Sun, 16 Jun 2024 03:06:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822A161911
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718507165; cv=none; b=kAt+V5DHjs8KTw+oQJUDIdn0f3+m73gQZ0g+xXJXD5QDamy3uGHat9f4nCseMsMuKLGcSnqT9IFm3IKupM5M0mhLILe6HwwRpALCxrMEfK01ISe8eT6LisTu8igH/5PfOWyO0kSVv0PNjIq11XV37zziBp9wr1RhOh8rW3F+KGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718507165; c=relaxed/simple;
	bh=CvPap5L5VyXRFDjRh7/5UpHsK18wFSUDKUAFMLfPWF8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pyl9AoAVfa+sp4zCvuyVwUyy/USR2mrfsewKgUpz1W0Y7UDqLVxuBB/0Q0pr8idry/vGTwuJ5jCQiWzY6Zk+yCwIWAB6Bohz0a7krF294OmmnGnqmBRLsvFOYUlupljh1rNugKc2yZXpQWEaUjDZhAXl9jRi/sVWM1YnzTrA3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb846f49adso379048839f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jun 2024 20:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718507163; x=1719111963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lL4pEt8CNUQGiLnXmuWRmkgKbbs2AYt2k3t4y5TtmrY=;
        b=wps2//1EEwFSGfIinbGqFctLJfZX/rbf5wu/zBshQZyE/rJhbYAfJtdbtPEWcS8HgF
         YLSaD5cuhb4FTTZLtMi9QtqaBvpZtjQ5hl2QL6IJWSrowCPjwOoBu8IWAgfh2MO1CXCk
         li09HueXWjJuTvr2N/W8VwU/EvCnitIyPMGeOrDgeDSW+eeUgMk+0DIXhYjYIqIKYmQx
         1goOg3ghJ7JE9H0rieD/vk4SErRTPe2ohjVcyNRZaekqlONViUFfgI5m1OyB2uYjxaD+
         0RogqtBZmU2PkUwcPUkyY1nK57hf1YhSyQIfvJMgZUTgcU4IRofp0cpdzBd+6en4cMZZ
         cklg==
X-Forwarded-Encrypted: i=1; AJvYcCU8dwRe5eqS+VVyunvNc3vPCFkqUzoBUgiEi/9b7Ta2717PMT4VOqV5cGPf2+pMBriOf3hZYWggHi1H5b7Uk/n+5d0OyVcuw5hAcSkAEg==
X-Gm-Message-State: AOJu0Yw3lDgR6AQX8TAzwk1omkr2alMLMXb5OQtT2U8ZFwkQ5xxuwG5J
	Ez215UeQNu98NX81PAkdCtielhSVE7PZHdmo+s6Y/X/UeKaQrSx4uGEKBuvzmd9PGcm4xhEzepj
	yFV2QSjvTjVAjJCcAh0tWsRptpFqf/Geexq8hhqJwD8MQ+AgrI7tDVzo=
X-Google-Smtp-Source: AGHT+IG7RRZX4xBYLd1NhJiKcAWEgkhc8K3GNivFtpjlbGyk97kihhye9R3ekoErz5MAaLZMyq/tiC8JsT/UdPVT7RECdKk27xbb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:371f:b0:4b9:6637:4909 with SMTP id
 8926c6da1cb9f-4b966374a6emr223126173.6.1718507162965; Sat, 15 Jun 2024
 20:06:02 -0700 (PDT)
Date: Sat, 15 Jun 2024 20:06:02 -0700
In-Reply-To: <20240616023951.1250-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe2d22061af9206f@google.com>
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
From: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
To: hdanton@sina.com, jack@suse.cz, konishi.ryusuke@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __filemap_add_folio

NILFS (loop0): I/O error reading meta-data file (ino=3, block-offset=0)
NILFS (loop0): I/O error reading meta-data file (ino=3, block-offset=0)
NILFS (loop0): disposed unprocessed dirty file(s) when stopping log writer
------------[ cut here ]------------
kernel BUG at mm/filemap.c:873!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 5321 Comm: syz-executor Not tainted 6.10.0-rc3-syzkaller-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__filemap_add_folio+0xd1d/0xe80 mm/filemap.c:873
Code: 37 8b 4c 89 f7 e8 23 68 10 00 90 0f 0b e8 9b 14 ce ff 48 c7 c6 e0 92 37 8b 4c 89 f7 e8 0c 68 10 00 90 0f 0b e8 84 14 ce ff 90 <0f> 0b e8 7c 14 ce ff 90 0f 0b 90 e9 24 fb ff ff e8 6e 14 ce ff 48
RSP: 0018:ffffc900035773f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81bfc8cd
RDX: ffff888023052440 RSI: ffffffff81bfd0cc RDI: 0000000000000001
RBP: ffff88803233a9f0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffc90003577468
R13: 0000000000000000 R14: ffffea0000b3f7c0 R15: 0000000000000000
FS:  000055556c846480(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe311b9ff8 CR3: 000000001ae02000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filemap_add_folio+0x110/0x220 mm/filemap.c:971
 __filemap_get_folio+0x455/0xa80 mm/filemap.c:1959
 filemap_grab_folio include/linux/pagemap.h:697 [inline]
 nilfs_grab_buffer+0xc3/0x370 fs/nilfs2/page.c:57
 nilfs_mdt_submit_block+0x9f/0x870 fs/nilfs2/mdt.c:121
 nilfs_mdt_read_block+0xa4/0x3b0 fs/nilfs2/mdt.c:176
 nilfs_mdt_get_block+0xdb/0xb90 fs/nilfs2/mdt.c:251
 nilfs_palloc_get_block+0xb5/0x300 fs/nilfs2/alloc.c:217
 nilfs_palloc_get_entry_block+0x165/0x1b0 fs/nilfs2/alloc.c:319
 nilfs_ifile_delete_inode+0x1e6/0x260 fs/nilfs2/ifile.c:109
 nilfs_evict_inode+0x294/0x550 fs/nilfs2/inode.c:950
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 nilfs_put_root+0xae/0xe0 fs/nilfs2/the_nilfs.c:925
 nilfs_segctor_destroy fs/nilfs2/segment.c:2788 [inline]
 nilfs_detach_log_writer+0x5ef/0xaa0 fs/nilfs2/segment.c:2850
 nilfs_put_super+0x43/0x1b0 fs/nilfs2/super.c:498
 generic_shutdown_super+0x159/0x3d0 fs/super.c:642
 kill_block_super+0x3b/0x90 fs/super.c:1676
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f70d447e217
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe311ba288 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000064 RCX: 00007f70d447e217
RDX: 0000000000000200 RSI: 0000000000000009 RDI: 00007ffe311bb430
RBP: 00007f70d44c8336 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000202 R12: 00007ffe311bb430
R13: 00007f70d44c8336 R14: 000055556c846430 R15: 0000000000000005
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__filemap_add_folio+0xd1d/0xe80 mm/filemap.c:873
Code: 37 8b 4c 89 f7 e8 23 68 10 00 90 0f 0b e8 9b 14 ce ff 48 c7 c6 e0 92 37 8b 4c 89 f7 e8 0c 68 10 00 90 0f 0b e8 84 14 ce ff 90 <0f> 0b e8 7c 14 ce ff 90 0f 0b 90 e9 24 fb ff ff e8 6e 14 ce ff 48
RSP: 0018:ffffc900035773f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81bfc8cd
RDX: ffff888023052440 RSI: ffffffff81bfd0cc RDI: 0000000000000001
RBP: ffff88803233a9f0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffc90003577468
R13: 0000000000000000 R14: ffffea0000b3f7c0 R15: 0000000000000000
FS:  000055556c846480(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f70d45a8000 CR3: 000000001ae02000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         83a7eefe Linux 6.10-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15608256980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147bb012980000


