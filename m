Return-Path: <linux-fsdevel+bounces-30666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3F198D123
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 12:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D111C21B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F51E6338;
	Wed,  2 Oct 2024 10:25:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB731E6309
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864728; cv=none; b=Vbm1KGA5PswxIwOnKTWkLGpo3wmJsVJh/8kgFX10WTME0YHbRBTsMOGgGEkbRiTpqxdJkLh6LOYftdFuMzUDb5MkJUQvltlruciuVr5eqIL5uWnW68NJsAzNAaNEejn7NJde43qbUUbpOsacYRBQ9JvflqwcjJG63jN43QRwKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864728; c=relaxed/simple;
	bh=+Pa0U280d6DsZNG12CgKtRyK+zwhKC+DagHdUGpVSUI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XrK9rEZRHZvM68K/dWWTUnNwTaaTnux3HEgYmnT0ZNOkikoXXnqrKv/ECHJNIwknSfFKGgjD3gz0ailI+d5FkToTyk0UUDCEMrTCRfcPAtuACcQgaKINESKHXcsWsFGy7QO3Ay8SATrji74L4FCEHvHmvFK8vzKe8qkSxYlP0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82aa499f938so59986639f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 03:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727864726; x=1728469526;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeIDSA5aQgO9Yo4vkLf5tHebKPm6rM/IETg88NRh50M=;
        b=di4khkCP2allpIwfX5Bdw6dMpijB/KBARlrnH7qM0bttJCeSQUIUVbxBBOPqBxsjkR
         Y+kqCyJA/ZFGbbUdoyEP7nkddEuWBHvoubtWo+0ldcnzKVigMf9S7vfFWW+41ns/0Ivk
         NYoC9OaKurmRzJ25ZKExqEtsTttV/eXAj6U2gXx7fXVojaehR77bRvIzpUadmAa/1Y+u
         6VUuG+xvaynObnqwvLMB5wp5y502TR7ughLzY5g8JWx6/T6jbrRTS2ujWbSqTeEOjJy6
         ilrZy0XGOCC48Qhb+WkGPhIM3vSUzJzi7MbEOg0HVRe6eAJnmbieKbbzGUjTHg9A3fwi
         c3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUcCvueySCeYceCLpbfWYV5x2/RFe+cf2h+nDMAOUP1WPYl5uR/Svczyn2R8gnnnEwZGLMuGo9K+jdRm9Lx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx163usdW0RyYSJ8X0EfCX7v6VyUe7WuvEeylZdw06fwMjaD2Iv
	esHKea5Yb5n8UpU07TBe1maXN750GdujwQaE4GkZNO1epwHzr6rRRkzXdcuoy2OFOtmnJaHhDMK
	GWSatqjG41xq5/N/JDqPZJleYZ/LH4P11TJEyI9YcoUe9WmNaTHn9nYs=
X-Google-Smtp-Source: AGHT+IHNRR3utitHkGqL/5wdna4fbn6LyiRWKT7FCQZxrGEmYPngQ6XvVsZB9y1kYio4nrNQU2uIn9AX31uD5lC64LtYIdDxkp6q
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a365619998mr22708625ab.6.1727864726220; Wed, 02 Oct 2024
 03:25:26 -0700 (PDT)
Date: Wed, 02 Oct 2024 03:25:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fd1f96.050a0220.f28ec.050e.GAE@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in fat16_ent_get / fat16_ent_put
From: syzbot <syzbot+3999cae1c2d59c2cc8b9@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c64307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13af6e9c27c7bbbf
dashboard link: https://syzkaller.appspot.com/bug?extid=3999cae1c2d59c2cc8b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e728901b4154/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e662806fa232/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed885d1a3f98/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3999cae1c2d59c2cc8b9@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fat16_ent_get / fat16_ent_put

write to 0xffff888104b849d2 of 2 bytes by task 13613 on cpu 0:
 fat16_ent_put+0x28/0x60 fs/fat/fatent.c:183
 fat_free_clusters+0x2a6/0x7a0 fs/fat/fatent.c:597
 fat_free fs/fat/file.c:376 [inline]
 fat_truncate_blocks+0x4a8/0x530 fs/fat/file.c:394
 fat_evict_inode+0x102/0x160 fs/fat/inode.c:656
 evict+0x2f0/0x580 fs/inode.c:723
 iput_final fs/inode.c:1875 [inline]
 iput+0x42a/0x5b0 fs/inode.c:1901
 do_unlinkat+0x282/0x4c0 fs/namei.c:4540
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x2e/0x40 fs/namei.c:4579
 x64_sys_call+0x280f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:88
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888104b849d2 of 2 bytes by task 14376 on cpu 1:
 fat16_ent_get+0x23/0x70 fs/fat/fatent.c:140
 fat_ent_read+0x3e0/0x5a0 fs/fat/fatent.c:372
 fat_get_cluster+0x4b9/0x830 fs/fat/cache.c:266
 fat_free fs/fat/file.c:346 [inline]
 fat_truncate_blocks+0x271/0x530 fs/fat/file.c:394
 fat_write_failed fs/fat/inode.c:218 [inline]
 fat_write_begin+0xc0/0xe0 fs/fat/inode.c:232
 generic_perform_write+0x1a8/0x4a0 mm/filemap.c:4054
 __generic_file_write_iter+0xa1/0x120 mm/filemap.c:4155
 generic_file_write_iter+0x77/0x1c0 mm/filemap.c:4181
 __kernel_write_iter+0x24b/0x4e0 fs/read_write.c:616
 dump_emit_page fs/coredump.c:884 [inline]
 dump_user_range+0x3a7/0x550 fs/coredump.c:945
 elf_core_dump+0x1b66/0x1c60 fs/binfmt_elf.c:2121
 do_coredump+0x1736/0x1ce0 fs/coredump.c:758
 get_signal+0xdc0/0x1070 kernel/signal.c:2902
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x9a/0x130 kernel/entry/common.c:231
 irqentry_exit+0x12/0x50 kernel/entry/common.c:334
 exc_general_protection+0x33d/0x4d0 arch/x86/kernel/traps.c:693
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:617

value changed: 0x03ea -> 0x0000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 14376 Comm: syz.3.1622 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================
FAT-fs (loop3): error, fat_get_cluster: invalid cluster chain (i_pos 1050)
FAT-fs (loop3): Filesystem has been set read-only
FAT-fs (loop3): error, fat_free_clusters: deleting FAT entry beyond EOF


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

