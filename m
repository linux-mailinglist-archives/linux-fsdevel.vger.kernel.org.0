Return-Path: <linux-fsdevel+bounces-41309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E0DA2DB40
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 06:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA96518879C1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 05:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3C42A87;
	Sun,  9 Feb 2025 05:48:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3B8831
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739080104; cv=none; b=LEpfyZF4aND237mqoGXb6qZbhKSsns+X5syfk9jg+q4JTXUQdmSkkpqzzclQY/Z6WWSzuoSY+dAa378VjRNGMTnY/Yw1U0lsIVp3FNmh1OLxQn14HIvNmjJOoQ+5tq2NZ7VbuvkxofqiFTCLTP6gLSB9Pwf6QMXlKtSCtACGrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739080104; c=relaxed/simple;
	bh=z4tA6hMPFEUrw4W8If8IRwdzbP+7LHbbAeSr7eOfrqo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ay1R3aKtO8PB5GnIYugSSF/ARk620gibHwoV363X7018INA4qp31jz+BAN5EL7WoGI82ckAGYckxKwz1xRXahYybWN+OnNC6lyNsQn56DBTThtUxR6XphmbeNEAad3Q+5PWFr+ZbM88GAB5zu9Ga+pcnhCH3vMIvpEJ+NQUU/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d058142573so27730285ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 21:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739080101; x=1739684901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JllO9RRFJnC6OlotxyZV0275rRnlEQ+hFYSIKClP0zo=;
        b=gcjqzKCMxiFdfQffwDyxnloLWxhsVDOc6uhjIlOggHeKCO+e2+MNCVi9NP4lMM7FpH
         rPFBei01Fz+NrkqwPjVKBa3HNc5gaQGy9pgBaCi6iDX+ue6ziisfZiL23/k3JrZnU6al
         zHyIG8Cm/5L7pBBveUyqNMXhfz3GeQW7soOPFuGy/znThDmTMvqo3onoSKpdkUCSZGv9
         Er4qiALlwBMVPuKvZwjhBATadPsnoD4Kza/gTpbfYUpHnrbx14AR43cn1D0aSBv1eIxf
         EolzNIKJu5yPxCh6yVDpufNJeLa3MJBt1c+/N1gbUz2W5N7g2pVcoFVLJVpL0sUEH2a4
         tQiA==
X-Forwarded-Encrypted: i=1; AJvYcCVN/8m3/oYTQYWFgPRunjFR6ML6DSKj0eD7RT6n2SMUeVCeeOkCakEnLzuSGGG68PwzYweauPa9VJqGFwSp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TXZgZjEHryOaJ/5Fm9gOpPfvNe3kEdtk0ZhEXNRuTRATnqUw
	w+i85sxYjzCr6+zuMpzPV1OFL8s+oT/6VsGEFaPAZ3nBiKmpuL5Q9iROeI3waonXXfVJE/akfJC
	ekedLHidvbb2ijU6GGurW8p9CtSnt1ewlpZUFkZrx/TaHypiVmorEs2Y=
X-Google-Smtp-Source: AGHT+IEVlqPGn5xXlDn15cyBvhgT74wjTffnI3VeukLWL4MB4bOujt2MzbXZKZbjwvr6nkObbO3W9eamNmsdrG7983+II/w0cP8q
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:3cd:e9a0:3c3d with SMTP id
 e9e14a558f8ab-3d13e159583mr68052515ab.2.1739080101450; Sat, 08 Feb 2025
 21:48:21 -0800 (PST)
Date: Sat, 08 Feb 2025 21:48:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a841a5.050a0220.110943.0017.GAE@google.com>
Subject: [syzbot] [isofs?] KMSAN: uninit-value in isofs_readdir
From: syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
To: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5c8c229261f1 Merge tag 'kthreads-fixes-2025-02-04' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13a8beb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f20bce78db15972a
dashboard link: https://syzkaller.appspot.com/bug?extid=812641c6c3d7586a1613
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12042df8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ff93df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63aa4d99d73d/disk-5c8c2292.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/104150a76e91/vmlinux-5c8c2292.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4622f8c58f4/bzImage-5c8c2292.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/24fb8c942e20/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com

loop0: detected capacity change from 1764 to 1763
=====================================================
BUG: KMSAN: uninit-value in do_isofs_readdir fs/isofs/dir.c:150 [inline]
BUG: KMSAN: uninit-value in isofs_readdir+0xa33/0x2610 fs/isofs/dir.c:262
 do_isofs_readdir fs/isofs/dir.c:150 [inline]
 isofs_readdir+0xa33/0x2610 fs/isofs/dir.c:262
 iterate_dir+0x740/0x930 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64+0x170/0x540 fs/readdir.c:389
 __x64_sys_getdents64+0x96/0xe0 fs/readdir.c:389
 x64_sys_call+0x3b0f/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:218
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_frozen_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4762
 alloc_pages_mpol+0x4cd/0x890 mm/mempolicy.c:2270
 alloc_frozen_pages_noprof mm/mempolicy.c:2341 [inline]
 alloc_pages_noprof+0x1b5/0x250 mm/mempolicy.c:2361
 get_free_pages_noprof+0x34/0xc0 mm/page_alloc.c:4798
 isofs_readdir+0x74/0x2610 fs/isofs/dir.c:256
 iterate_dir+0x740/0x930 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64+0x170/0x540 fs/readdir.c:389
 __x64_sys_getdents64+0x96/0xe0 fs/readdir.c:389
 x64_sys_call+0x3b0f/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:218
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5784 Comm: syz-executor207 Not tainted 6.14.0-rc1-syzkaller-00028-g5c8c229261f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


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

