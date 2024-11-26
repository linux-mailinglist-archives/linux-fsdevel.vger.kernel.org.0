Return-Path: <linux-fsdevel+bounces-35872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A79D9285
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 08:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50749281A4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD0199384;
	Tue, 26 Nov 2024 07:35:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2712192B77
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606506; cv=none; b=tyW+M7e3ehRYiZ+b+BKQ78vANGxWkauZ6IdqCwsVkGHxwK2Zasr0AEfZtwuo8eJlHJckCSYtRe4Hl1dWMSFDUyrBwPVIKVRTO9vuZ7m9zdX6nGONGDzbLeoXw755TytWDaVPE89VeadUYs9ls1jH0SyzeEdDbwfFCaDb/czTeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606506; c=relaxed/simple;
	bh=rsFYmagk2Ec8FqwOoIDKUoDPUQCIWdBSo1RL1Fs1c1w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kV7mWjOUq+esoEbZvSb+3ZbFROqjuonyzvVi6r+w2zeedNiae3+Hwqw3XKBjI84cLQpZ95OSn4alq6Ri1oWlnwCR4GbZZYSEwI34Vle9klXhOvqdRUjXWKfpMqj2UebxYo95F973YgtxMKDZN1hr2jaMvJxwuoBAFDBp5Oj0Tdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77a0ca771so37194105ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 23:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606504; x=1733211304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlAgNKtr+sSD9KDj4hEbYJLZ6WrE4BShhgRvMIf6ALk=;
        b=CuS5tiV88Tl55igdxzZDrhGjXdz1PytzwbY2OHmHa69DDqkUm+VaPGPMeirBoV+/mO
         4rac5R65RzxC8yKQyvgErxzPdkCVtY+Cy78WzLrH5wBRXfOWs4WfQeMFwjzmA1WXjX47
         q3+w46rN9SNuPan8dZTY28vKS3v8J0991y1OnyV+wiCopGJ/RY3F30ViANVAIlfRqV3z
         wp/eNGkhgbpBDNvQaqWK1VWMO5FTwyPrPscq8jw0XykFq3cZ2uUQ7qevQsvrzippRH3t
         Kuy7Zkkhac0g/Rtmh0ansCXqYYhpG5S1Hxq6mdl+iPzQzpScmI1FpWjpGgpkxHrlFUcw
         LZOg==
X-Forwarded-Encrypted: i=1; AJvYcCUvxyEbQDoxIM0HfM8SKI3acV2qq/tNhcArTUw5qrGR17m0fidgo/55CiHaT8I2teK6yZfnzQiYUuFUrsac@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBO1xYFIWSx/I7Aw95aMh6gAqJYJnrwPLkpOYVOMZytow/4vS
	8pj45skBHjk6swk3uxkBRuKehPp6/mKM6TSMQH34sNpZwAVCpYSAGWWMOvPzzvwoB5rjYYZAMGB
	s7mdgBlplJDAv6akK89PThal41GJp/SYdBs9sQ9ZGkn0wEXpWd0p9lXM=
X-Google-Smtp-Source: AGHT+IFc/HZlN2PZTrGVlYaVMfyQimAJdEboH2jos4v8g7Tg/2592001DE7aKVbatBTmUXb25PlLyL7z0uYsb6f+fGi3y1wRK5ZB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:3a7:464d:36a5 with SMTP id
 e9e14a558f8ab-3a79afd0df2mr185147035ab.21.1732606504099; Mon, 25 Nov 2024
 23:35:04 -0800 (PST)
Date: Mon, 25 Nov 2024 23:35:04 -0800
In-Reply-To: <43dc0351-7220-4326-ac07-ef37f6e5605a@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67457a28.050a0220.21d33d.0010.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org, 
	wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __folio_start_writeback

 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2918
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at mm/page-writeback.c:3119!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 3538 Comm: kworker/u8:10 Not tainted 6.12.0-rc7-syzkaller-00132-g21865e0dd679 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btrfs-delalloc btrfs_work_helper
RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
Code: 25 ff 0f 00 00 0f 84 d3 00 00 00 e8 14 79 c4 ff e9 ba f5 ff ff e8 0a 79 c4 ff 4c 89 f7 48 c7 c6 c0 0e f4 8b e8 6b 46 0d 00 90 <0f> 0b e8 f3 78 c4 ff 4c 89 f7 48 c7 c6 20 15 f4 8b e8 54 46 0d 00
RSP: 0018:ffffc9000ca9f500 EFLAGS: 00010246
RAX: 258fc5bd6608dc00 RBX: 0000000000000002 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8beacb20 RDI: 0000000000000001
RBP: ffffc9000ca9f670 R08: ffffffff94059917 R09: 1ffffffff280b322
R10: dffffc0000000000 R11: fffffbfff280b323 R12: 0000000000000000
R13: 1ffff92001953eac R14: ffffea0001c40500 R15: ffff888073b564f8
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0002adb80 CR3: 0000000027072000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_folio fs/btrfs/extent_io.c:187 [inline]
 __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
 submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
 submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
 run_ordered_work fs/btrfs/async-thread.c:245 [inline]
 btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
Code: 25 ff 0f 00 00 0f 84 d3 00 00 00 e8 14 79 c4 ff e9 ba f5 ff ff e8 0a 79 c4 ff 4c 89 f7 48 c7 c6 c0 0e f4 8b e8 6b 46 0d 00 90 <0f> 0b e8 f3 78 c4 ff 4c 89 f7 48 c7 c6 20 15 f4 8b e8 54 46 0d 00
RSP: 0018:ffffc9000ca9f500 EFLAGS: 00010246
RAX: 258fc5bd6608dc00 RBX: 0000000000000002 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8beacb20 RDI: 0000000000000001
RBP: ffffc9000ca9f670 R08: ffffffff94059917 R09: 1ffffffff280b322
R10: dffffc0000000000 R11: fffffbfff280b323 R12: 0000000000000000
R13: 1ffff92001953eac R14: ffffea0001c40500 R15: ffff888073b564f8
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fabe0e31440 CR3: 0000000032718000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         21865e0d btrfs: use PTR_ERR() instead of PTR_ERR_OR_ZE..
git tree:       https://github.com/btrfs/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10835778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4954ad2c62b915
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

