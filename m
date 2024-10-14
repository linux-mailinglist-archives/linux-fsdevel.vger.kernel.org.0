Return-Path: <linux-fsdevel+bounces-31861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB5499C3A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD67C1C229DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E31531E1;
	Mon, 14 Oct 2024 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZD/yKvuN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4E1494C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895331; cv=none; b=Vlof16UeYfZhE5MdIrepXypJ3Ouvybmkg7ND8kslAJ72MTT6JHPnnznZ7mtEgqccZ4RSCoe05aSIXGVjsv45M6iiCOKHzrZVAolHFn2QBpjrGup/t67lqqxqSXQlDDeSZaZkB70IjYz53mKUJeZCCfWI/wzJRksXT2v9qMTdKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895331; c=relaxed/simple;
	bh=5IEaU3e+DEHoxPtbx3NoSgiE7Z+Bz7wCkupqP5bHilI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oaf9iFV8D4xpMDpfEVhzs/zaUiugpxVr+1ds2hPDXpKNskFlkH+VEhYPyx5VPx41OAQCulR0teAsfQvKO31rN8tZ1pPQuKpvgF2HSfdvpAlVtOR93/ZgwOo18h3G7GmRYMGSzfmUF3XDJRcUKCFIbstymCRnrcAbf4z2MN6z3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZD/yKvuN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fadb636abaso33995781fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728895326; x=1729500126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSv+xwq+z3p6YBh0iihgCLzRA7mMnGfXBEJed04Tcj4=;
        b=ZD/yKvuN1Jl4WQwmWFAlK/7CXL2jWHK9BL8gUhpRt2Vj1FUy1I18eZOXNlqTuY1YKW
         fqZAwuLlKbekVlsjoxFbiwquvdBf9odk8UiXWdxCH0ME4a3HjSATUVx1jdXrPxRCSi4U
         zkbiVlBBzA5UC38z4tYMNoTpbGxXMyXrC1UOBayEVu0Pf1T8jNrVhV1rjupDNSO/MxuP
         NwjHfK3tkDpUKNvmYEy5Ev9UCkqtjQGoN+w20u4K/URE/3dLQoEqZME5+do1olRhA3od
         ATYthvB0Uk101LDC444B6S3738UBWx+GlPz8PlIu+au+4LuyC55xTbm5jZkTz9CafHIi
         29aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895326; x=1729500126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSv+xwq+z3p6YBh0iihgCLzRA7mMnGfXBEJed04Tcj4=;
        b=OM2EGO2WhZaHwW6qtW36tYYYvCZBsAFpbQOKxIY/2IZWEXW/xDbLr3jCQJBa9HUxq1
         oqvZZRDHOv4WIjqjL09EqrIbDJS4WWoJDczqdubEPMfiOecidp2T+Bs4HNxvKU3/2CSO
         8GANthEZrb5wt+q99lvjQQQLFmuh8jK0aTeLBbppChHjXrBw0kJ0prHy/VyvCwNj29P2
         m5EpzvbBBu4DjYwvc16b614sK7ti+ocWgBNfgNetpqLF84wskzb+Vnz6Fqto2yDMpXBd
         FXlGLAxC3KAA10b4UI7YKZHk4rG8Kqyf7sfLYt+DfOt3uIUWSc9cHpc/foNDWRd54Nmp
         w4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7Xsg6qynsKzhM5u8dW3DdMZkApEFwxeh5st+eYtRxaV/ZB4r2F3lXE8vYeIGY+KnOU1+4TMhuA6h7WVUY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdf9QKlCOKQ0aALdFgZTv8qO+F4rRLWIHyl0vdrESAxmXHcUud
	E//HocsDRDgnAcq6XYN67+qi7DxDuS6OIMO5kNTJF49PwVYwZagsY8HFElQVaUVpoXNWZWfIpUn
	8KDNsIJuMcGkZ5eVpOM3cgHOh7NOUO0CnAZgc
X-Google-Smtp-Source: AGHT+IF2uYJCbsJkyDBWyM5xTWoycN/RNE3CIRPq0iQCNjhjuXvs4DvMzreZ3NkwxXh7K9h1fLiTRosINDYsDdTZmy8=
X-Received: by 2002:a05:651c:1990:b0:2fb:4f0c:e3d8 with SMTP id
 38308e7fff4ca-2fb4f0cea31mr10438791fa.27.1728895326189; Mon, 14 Oct 2024
 01:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670ba885.050a0220.4cbc0.002e.GAE@google.com>
In-Reply-To: <670ba885.050a0220.4cbc0.002e.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Oct 2024 10:41:51 +0200
Message-ID: <CACT4Y+bbG_pthEYyG5mCYZVdA1Rzch2rZ5Yoit6gPaKjssPAJg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] stack segment fault in folio_wait_writeback
To: syzbot <syzbot+8cb2efaaad483f65f56c@syzkaller.appspotmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 13 Oct 2024 at 13:01, syzbot
<syzbot+8cb2efaaad483f65f56c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7234e2ea0edd Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=157a085f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
> dashboard link: https://syzkaller.appspot.com/bug?extid=8cb2efaaad483f65f56c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146c7fd0580000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7234e2ea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aa111520a0b7/vmlinux-7234e2ea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/07889fadba3b/bzImage-7234e2ea.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/178fe4a5f5e7/mount_1.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7847e1862894/mount_2.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8cb2efaaad483f65f56c@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 256
> exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0xcc9b7de9, utbl_chksum : 0xe619d30d)
> Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5340 Comm: syz.0.50 Not tainted 6.12.0-rc2-syzkaller-00305-g7234e2ea0edd #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:PageTail include/linux/page-flags.h:281 [inline]
> RIP: 0010:const_folio_flags include/linux/page-flags.h:309 [inline]
> RIP: 0010:folio_test_writeback include/linux/page-flags.h:555 [inline]
> RIP: 0010:folio_wait_writeback+0x2f/0x1e0 mm/page-writeback.c:3187
> Code: 41 57 41 56 41 55 41 54 53 48 83 ec 18 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 ac 7e c4 ff 4c 8d 73 08 4c 89 f5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 f7 e8 11 2f 2e 00 4d 8b 3e 4c 89 fe
> RSP: 0018:ffffc900025a7190 EFLAGS: 00010202
> RAX: ffffffff81d068a4 RBX: 0000000000000000 RCX: ffff888000c3c880
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000001 R08: ffffffff81cc460e R09: 1ffffd4000003328
> R10: dffffc0000000000 R11: fffff94000003329 R12: dffffc0000000000
> R13: dffffc0000000000 R14: 0000000000000008 R15: 0000000000000001
> FS:  00007f7a897816c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7a88a75c60 CR3: 000000003f406000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __filemap_fdatawait_range+0x17c/0x2b0 mm/filemap.c:533
>  file_write_and_wait_range+0x1e3/0x280 mm/filemap.c:792
>  __generic_file_fsync+0x6f/0x1a0 fs/libfs.c:1528
>  exfat_file_fsync+0xf9/0x1d0 fs/exfat/file.c:524
>  exfat_file_write_iter+0x312/0x3f0 fs/exfat/file.c:608
>  iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
>  do_splice_from fs/splice.c:941 [inline]
>  direct_splice_actor+0x11b/0x220 fs/splice.c:1164
>  splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
>  do_splice_direct_actor fs/splice.c:1207 [inline]
>  do_splice_direct+0x289/0x3e0 fs/splice.c:1233
>  do_sendfile+0x561/0xe10 fs/read_write.c:1388
>  __do_sys_sendfile64 fs/read_write.c:1455 [inline]
>  __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7a8897dff9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7a89781038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f7a88b35f80 RCX: 00007f7a8897dff9
> RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
> RBP: 00007f7a889f0296 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000100001 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f7a88b35f80 R15: 00007fffbdf78608
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:PageTail include/linux/page-flags.h:281 [inline]
> RIP: 0010:const_folio_flags include/linux/page-flags.h:309 [inline]
> RIP: 0010:folio_test_writeback include/linux/page-flags.h:555 [inline]
> RIP: 0010:folio_wait_writeback+0x2f/0x1e0 mm/page-writeback.c:3187
> Code: 41 57 41 56 41 55 41 54 53 48 83 ec 18 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 ac 7e c4 ff 4c 8d 73 08 4c 89 f5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 f7 e8 11 2f 2e 00 4d 8b 3e 4c 89 fe
> RSP: 0018:ffffc900025a7190 EFLAGS: 00010202
> RAX: ffffffff81d068a4 RBX: 0000000000000000 RCX: ffff888000c3c880
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000001 R08: ffffffff81cc460e R09: 1ffffd4000003328
> R10: dffffc0000000000 R11: fffff94000003329 R12: dffffc0000000000
> R13: dffffc0000000000 R14: 0000000000000008 R15: 0000000000000001
> FS:  00007f7a897816c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7a8975ff98 CR3: 000000003f406000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   41 57                   push   %r15
>    2:   41 56                   push   %r14
>    4:   41 55                   push   %r13
>    6:   41 54                   push   %r12
>    8:   53                      push   %rbx
>    9:   48 83 ec 18             sub    $0x18,%rsp
>    d:   48 89 fb                mov    %rdi,%rbx
>   10:   49 bd 00 00 00 00 00    movabs $0xdffffc0000000000,%r13
>   17:   fc ff df
>   1a:   e8 ac 7e c4 ff          call   0xffc47ecb
>   1f:   4c 8d 73 08             lea    0x8(%rbx),%r14
>   23:   4c 89 f5                mov    %r14,%rbp
>   26:   48 c1 ed 03             shr    $0x3,%rbp
> * 2a:   42 80 7c 2d 00 00       cmpb   $0x0,0x0(%rbp,%r13,1) <-- trapping instruction

+tracing maintainers

Not sure how this instruction can cause stack segment violation.
The reproducer does something with raw tracepoints:
https://syzkaller.appspot.com/text?tag=ReproSyz&x=146c7fd0580000

Can raw tracepoints legally arbitrary corrupt kernel state?
If yes, is there some safe subset at least?


>   30:   74 08                   je     0x3a
>   32:   4c 89 f7                mov    %r14,%rdi
>   35:   e8 11 2f 2e 00          call   0x2e2f4b
>   3a:   4d 8b 3e                mov    (%r14),%r15
>   3d:   4c 89 fe                mov    %r15,%rsi
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

