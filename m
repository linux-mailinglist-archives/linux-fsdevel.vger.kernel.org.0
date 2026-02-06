Return-Path: <linux-fsdevel+bounces-76569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMvUJgibhWmUDwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 08:40:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D95EFFB11B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 08:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BDF9303A849
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809632471E;
	Fri,  6 Feb 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="0E3Ptr24";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="11o4a9Pz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954931AF3D;
	Fri,  6 Feb 2026 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363648; cv=none; b=Cu3ihdoKUA/Zh8qTO7/OK93rHStq3+OaF6FZndVpVxXi1W6QNZsnRZDeKj8bZmx+O9HLn8UUeROaiCLX1StGbZZx/ygO/+Z7u/utSbF0NsR2/+e98HvpKi7cbSDyVK52GSB3OI41h0/usDYYPy+UgXwTMxAZiniVDq6bgx7jlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363648; c=relaxed/simple;
	bh=Ekc1ZCtm+mbJnZmgFaW5NS8nfFfTSlYUkXSoQkeAvjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZrrF1f/Z6cRv3nmh3zNsgM9epgL5j1cxa+/QffvXJpieTkwN+i3yQwvAaEt58NNaKbXB8w98lRk42Tl/QonXZKtILzhP+A3LPpEzKsPBen3bcJHzofDw7AU1QFXLBvjd+Fffuu2J1/kXa0opQPIcTbjflBY+r6taXWjjdCjSDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=0E3Ptr24; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=11o4a9Pz; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 10BD226F765D;
	Fri,  6 Feb 2026 16:40:40 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1770363640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45qGP9+dn9/atQxo/pZOb49L0cW1DJt6amQ0qdo6U4o=;
	b=0E3Ptr24hE+N1Hvj3ii00RsbuzK4r5AV2eO98ZBCOL7pn/NSG6ebdrM+xkGPy7SE6P3Bsj
	iNXPPFwjoQ2pWGuPYP+cSUcz55VcS2ycdJLerHQIYvy8BU323XadUxVGhDe3/orDhPvRtJ
	GK/AIWt8pMoatgfbcHe8u/l+Kr4TygMlmWikc2O3DR39m9zAPBFXEpF/VcHEIw/wBLSni+
	BkC8NOnCPXlAPgG3XBA0qPGqiCGFtvItI6qYVgR3YMXAFsIYbAXVxelQyFUeArNVaMnxbG
	rv1PG5HDbMAkGzuxr18cVoS8beJPy+ha8owmqnRpXyDa6HQSjoDVAu3CD8nuTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1770363640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45qGP9+dn9/atQxo/pZOb49L0cW1DJt6amQ0qdo6U4o=;
	b=11o4a9PzNHNlfwnBm+OjrGO+j5JJFj2ivDrx0a6hA+VQKEIVWE/DE3DXANodSYS32bqNDH
	OSh93cE9Ce4f92Cg==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.2/8.18.2/Debian-1) with ESMTPS id 6167ecL8313913
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 16:40:39 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.2/8.18.2/Debian-1) with ESMTPS id 6167ecpq970184
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 16:40:38 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.2/8.18.2/Submit) id 6167ecA5970181;
	Fri, 6 Feb 2026 16:40:38 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: syzbot <syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] KCSAN: data-race in fat12_ent_put /
 fat_mirror_bhs
In-Reply-To: <69858d8b.050a0220.3b3015.0031.GAE@google.com>
References: <69858d8b.050a0220.3b3015.0031.GAE@google.com>
Date: Fri, 06 Feb 2026 16:40:38 +0900
Message-ID: <87h5rue2vd.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mail.parknet.co.jp,none];
	R_DKIM_ALLOW(-0.20)[parknet.co.jp:s=20250114,parknet.co.jp:s=20250114-ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[parknet.co.jp:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76569-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[hirofumi@mail.parknet.co.jp,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,parknet.co.jp:email,parknet.co.jp:dkim,syzkaller.appspot.com:url,googlegroups.com:email,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-fsdevel,51b4c65bb770155d058f];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: D95EFFB11B
X-Rspamd-Action: no action

syzbot <syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    de0674d9bc69 Merge tag 'for-6.19-rc8-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f240aa580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
> dashboard link: https://syzkaller.appspot.com/bug?extid=51b4c65bb770155d058f
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bfedab2f6279/disk-de0674d9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f012a4cb8d82/vmlinux-de0674d9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/acb727c49110/bzImage-de0674d9.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com

This looks like same with the following thread.

  https://lore.kernel.org/all/20250902081727.7146-1-anmuxixixi@gmail.com/

And this temporary inconsistency will be fixed until unmount, so it
should be no corruption by this race. Let me know if corruption remained
after unmount.

Thanks.

> ==================================================================
> BUG: KCSAN: data-race in fat12_ent_put / fat_mirror_bhs
>
> read-write to 0xffff888129151032 of 1 bytes by task 4937 on cpu 1:
>  fat12_ent_put+0xc4/0x170 fs/fat/fatent.c:165
>  fat_ent_write+0x6c/0xe0 fs/fat/fatent.c:417
>  fat_chain_add+0x16c/0x490 fs/fat/misc.c:136
>  fat_add_cluster fs/fat/inode.c:113 [inline]
>  __fat_get_block fs/fat/inode.c:155 [inline]
>  fat_get_block+0x46c/0x5e0 fs/fat/inode.c:190
>  __block_write_begin_int+0x400/0xf90 fs/buffer.c:2145
>  block_write_begin fs/buffer.c:2256 [inline]
>  cont_write_begin+0x5fe/0x970 fs/buffer.c:2594
>  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:230
>  generic_perform_write+0x183/0x490 mm/filemap.c:4314
>  __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4431
>  generic_file_write_iter+0x8d/0x310 mm/filemap.c:4457
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x5a6/0x9f0 fs/read_write.c:686
>  ksys_write+0xdc/0x1a0 fs/read_write.c:738
>  __do_sys_write fs/read_write.c:749 [inline]
>  __se_sys_write fs/read_write.c:746 [inline]
>  __x64_sys_write+0x40/0x50 fs/read_write.c:746
>  x64_sys_call+0x2847/0x3000 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888129151000 of 512 bytes by task 4940 on cpu 0:
>  fat_mirror_bhs+0x1df/0x320 fs/fat/fatent.c:395
>  fat_alloc_clusters+0xb48/0xc50 fs/fat/fatent.c:543
>  fat_add_cluster fs/fat/inode.c:108 [inline]
>  __fat_get_block fs/fat/inode.c:155 [inline]
>  fat_get_block+0x258/0x5e0 fs/fat/inode.c:190
>  __block_write_begin_int+0x400/0xf90 fs/buffer.c:2145
>  block_write_begin fs/buffer.c:2256 [inline]
>  cont_write_begin+0x5fe/0x970 fs/buffer.c:2594
>  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:230
>  generic_perform_write+0x183/0x490 mm/filemap.c:4314
>  __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4431
>  generic_file_write_iter+0x8d/0x310 mm/filemap.c:4457
>  __kernel_write_iter+0x319/0x590 fs/read_write.c:619
>  dump_emit_page fs/coredump.c:1298 [inline]
>  dump_user_range+0xa7d/0xdb0 fs/coredump.c:1372
>  elf_core_dump+0x21a2/0x2330 fs/binfmt_elf.c:2111
>  coredump_write+0xacf/0xdf0 fs/coredump.c:1049
>  do_coredump fs/coredump.c:1126 [inline]
>  vfs_coredump+0x26bc/0x3120 fs/coredump.c:1200
>  get_signal+0xd7b/0xf60 kernel/signal.c:3019
>  arch_do_signal_or_restart+0x96/0x450 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:75 [inline]
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
>  irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
>  irqentry_exit+0xf7/0x510 kernel/entry/common.c:196
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 4940 Comm: syz.3.398 Not tainted syzkaller #0 PREEMPT(voluntary) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> ==================================================================
> syz.3.398 (4940) used greatest stack depth: 8696 bytes left
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

