Return-Path: <linux-fsdevel+bounces-21768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F348909AA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 02:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE9E1F21B0C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 00:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB210F4;
	Sun, 16 Jun 2024 00:10:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC8366
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718496604; cv=none; b=fRrBcDR1VJ8CNqSAx04sbzyIrGlG9nO4Wphy8M7W9VsjKZc6TVfzPzz2DbwnxJ+fCy5CRmORYhUE6r4fU8zYyUMbI1MoKdaXwiJcjp2THsfDpvDChMura7MmJ99Zo7k+Zbf/BoCtrPIf8SEMRqZCvWP6Wg0TeQrWlu7JUwheyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718496604; c=relaxed/simple;
	bh=Hf7sfFQ3cSMQ1BvCIvPW2slf2/cNJ6E1fEE/xrn3//Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cRss8E0DqblNm/g5+fpHNJCIH5PIiUmXNbPelpoCitTuGaoX4ipnuCpuNIycgGGa7Fz96mq0k9pGeZSUN1aUo2aJ0RY55vbWKB4W9hd8kab0nXKM/piqLq3Sf4e1rE7x60sxK2rlO+pGd/QtwTVYfFTWvvN9GsIbAIP82Ro61Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb7c3b8cf8so360149939f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jun 2024 17:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718496602; x=1719101402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1ViQOmfPbYo1UQjxR1ujw8trFh3Yo+KDFkFbV6YAoE=;
        b=xSLPuio0Py5tktSBxY9Ulgoog/2jxp9LMNz3gT6fFrQhyKmkJIVRaV5zfIsMWuI2qr
         7r3n3gaF6LjrdLxgUHlbiSkVW8IR2sJYUftTpGdeH0hG6mURtoa0TFyjK0VEHJjuw/E1
         MTaT95CTI2V9YVJSkOt7O7H7+XJfFZ5FLB3yfrOIzbGXCCqacBsurgxx89Elysj1WG4J
         ikA+FB4qEpSL1HS1V+/KzrnhUKCETsP6gRBJm2FbxIc7AqfYaa8bIfdOpuSndRZ+upHC
         BaE5+WJu6k9+JU6t8+7RNb/E7uXZaYT1CuCvW/wbxdpf7rI/NRrYxhvwaXT+dS+XHa0W
         DUww==
X-Forwarded-Encrypted: i=1; AJvYcCVr+m3KoJ33opDgwyYg/8ZR+/SPj0xCvwHFYi6hkortTMN81Ka7NLTXfh8I6afDAXGMXO2z1M8wWYOgrE/Km97u/wAPEshMXpWDfK7jnQ==
X-Gm-Message-State: AOJu0Yw2nulM/NxEdiLM9zOT5WbDqzu00jSw4jNRcjWB+uATL+D/PNh0
	D9Q2O1nCvuCpztpRKsarqnUG5D0OWSnylzQYFdTp/zTytxV6sNjDYfw7fx4ilcktg7XNp8+JEXa
	DWVJ4Z2uAkdFRTvrtS+TS2AmN/xjgnYd+bPdrXIa8Wgj+mZbpo7MU0VQ=
X-Google-Smtp-Source: AGHT+IFPHGW8ZEaSdgfbB5UzrzYfKMCNJLV8SIc3JTugWpEoQ9hEclzxOPzSQ2FkEl0lpyQ0zWaDAnZzj9QfqNlJqsSKS6tFnlEJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871b:b0:4b9:685d:7f65 with SMTP id
 8926c6da1cb9f-4b9685d8b68mr231744173.4.1718496602136; Sat, 15 Jun 2024
 17:10:02 -0700 (PDT)
Date: Sat, 15 Jun 2024 17:10:02 -0700
In-Reply-To: <20240615235238.1079-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084b401061af6ab80@google.com>
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
From: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
To: hdanton@sina.com, jack@suse.cz, konishi.ryusuke@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __destroy_inode

NILFS (loop0): I/O error reading meta-data file (ino=3, block-offset=0)
NILFS (loop0): I/O error reading meta-data file (ino=3, block-offset=0)
NILFS (loop0): disposed unprocessed dirty file(s) when stopping log writer
------------[ cut here ]------------
kernel BUG at fs/inode.c:285!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 5330 Comm: syz-executor Not tainted 6.10.0-rc3-syzkaller-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__destroy_inode+0x5e4/0x7a0 fs/inode.c:285
Code: 2a 03 00 00 48 c7 c7 40 78 3d 8b c6 05 aa 6d cc 0d 01 e8 bf d9 69 ff e9 0e fc ff ff e8 a5 8b 8c ff 90 0f 0b e8 9d 8b 8c ff 90 <0f> 0b e8 95 8b 8c ff 90 0f 0b 90 e9 fa fa ff ff e8 87 8b 8c ff 90
RSP: 0018:ffffc900035afaf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880325ba7c8 RCX: ffffffff82015439
RDX: ffff8880222ec880 RSI: ffffffff820159b3 RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880325ba980
R13: 0000000000000024 R14: ffffffff8b706c60 R15: ffff8880325ba8a0
FS:  0000555571e27480(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01cb366731 CR3: 0000000034ef4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 destroy_inode+0x91/0x1b0 fs/inode.c:310
 iput_final fs/inode.c:1742 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1768
 iput+0x5c/0x80 fs/inode.c:1758
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
RIP: 0033:0x7fc203a7e217
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fffe9265ae8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000064 RCX: 00007fc203a7e217
RDX: 0000000000000200 RSI: 0000000000000009 RDI: 00007fffe9266c90
RBP: 00007fc203ac8336 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000202 R12: 00007fffe9266c90
R13: 00007fc203ac8336 R14: 0000555571e27430 R15: 0000000000000005
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__destroy_inode+0x5e4/0x7a0 fs/inode.c:285
Code: 2a 03 00 00 48 c7 c7 40 78 3d 8b c6 05 aa 6d cc 0d 01 e8 bf d9 69 ff e9 0e fc ff ff e8 a5 8b 8c ff 90 0f 0b e8 9d 8b 8c ff 90 <0f> 0b e8 95 8b 8c ff 90 0f 0b 90 e9 fa fa ff ff e8 87 8b 8c ff 90
RSP: 0018:ffffc900035afaf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880325ba7c8 RCX: ffffffff82015439
RDX: ffff8880222ec880 RSI: ffffffff820159b3 RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880325ba980
R13: 0000000000000024 R14: ffffffff8b706c60 R15: ffff8880325ba8a0
FS:  0000555571e27480(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0016fb000 CR3: 0000000034ef4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         83a7eefe Linux 6.10-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11bb8ada980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16642012980000


