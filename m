Return-Path: <linux-fsdevel+bounces-16293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B141089AA76
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC921C212B3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EFC2C195;
	Sat,  6 Apr 2024 11:00:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909EA210E6
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712401226; cv=none; b=GAgfsOuXhLO/m4pC/7/mOwOWtiPNm4YPX3PGVCMHHjfYxTDRygJtjMy76wahkVDihRVXDIPu0IQhUKmLEDCnxNiFex9UErhd59AWl5/s21d+0NXLkeBvV9BymiqCn6xEkXgpe1EkKsu2NsEvME9eQ/zdinNXf88vaecmqVr27fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712401226; c=relaxed/simple;
	bh=DKwWOfQnJsZ4Gs+P1eLSemMFo4nUei3Z0dxRU3R6tgI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AObK/1a96ceBzgbSDl8m2+SEoWh7lO52jMIfFn3q5/KVoW6nFIWAwjjHxV0TqBBz3QXPTo4GNqtOGiE4y0x2w7+9gEykKFHM8skAIyfhO1PqSC8sNhPyRN7IW3+TavezR69VstCTKP7AMzdKRTy5EsOkyskZY/ZeVL9dlMr6y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d0330ce3d4so333721739f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Apr 2024 04:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712401224; x=1713006024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcRd1UmCP+fAW8HucEpzYBsLAzTIBczIJoAjaMr1iEA=;
        b=qwMFCPF+DOOr9n8RESqpg1BUmBlWz9jxXKVLfbtglObSRg9ArjXnAq9Wk3GOJ/rsrI
         xDT4x6ig4TAbSJdhhz9ADBUEenzTiYWGXWvfx6Hve4TPn5WqMsZHWiwUGNnde21TnMBg
         rRFlmFnxj/U7k7+XIHL71ijq0SYJF+KFKAFe3KD99zJtyvrVge6dzDZ3NSdAt+IZZlrs
         tx3aaIHLc4L6neKUD+5AFHs8g+jqqOuM28d0Nb9Um2H/DtFxNlv8v3SoIUQwLZvvKkec
         NsKRYwsp99OHYhJDlZPsYvtIZ0tGisgPjP1rPqX66nx5fBpiLRk/rkXIS4RrajahN4uJ
         tT1A==
X-Forwarded-Encrypted: i=1; AJvYcCXSQ4xUUj2swIzyt8zVaNvUjLSUG0hsBF9RNiyXSkF5BCF3z0NPhqi42kTRXe7NQTy+UF5qpu7u/MCn1v+qOhVNgbIalM3epD5l0F3vQA==
X-Gm-Message-State: AOJu0YxXeM/jZqsl3uPTB9LdEr/USaqzZ92WWMjsE4ziQBAhckAut7XS
	bhkMsqD7Cdtdb0NWnHrEn59GjpIU1AtPoF+mci/L1GVjw+a2YNZseBEYGIvn2L2tDXqeg9pig76
	1M6a7GuYrpSEov7D6BCyxTmHBUeMZiRtQZgJT83c1zhawZ1X86Czk254=
X-Google-Smtp-Source: AGHT+IFVi/HxZgkQX+l1l/w+QNB3XCCKyyRMuSGGUQU0Sc9HciSLyp1Tp59ZtwnEp9pO7eM4vgYDwCZfR7sqx9yDjvy2E6wjOmhS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2654:b0:47f:3994:c919 with SMTP id
 n20-20020a056638265400b0047f3994c919mr236894jat.6.1712401223834; Sat, 06 Apr
 2024 04:00:23 -0700 (PDT)
Date: Sat, 06 Apr 2024 04:00:23 -0700
In-Reply-To: <0000000000000d480b060df43de5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8f1d606156b7ad9@google.com>
Subject: Re: [syzbot] [nilfs?] KMSAN: uninit-value in nilfs_add_checksums_on_logs
 (2)
From: syzbot <syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e8b0ccb2a787 Merge tag '9p-for-6.9-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115eb623180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=47a017c46edb25eff048
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156679a1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f27ef6180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf4b0d1e3b2d/disk-e8b0ccb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/422cac6cc940/vmlinux-e8b0ccb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a4df48e199b/bzImage-e8b0ccb2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/69e1e69e7522/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KMSAN: uninit-value in crc32_le_base+0x43c/0xd80 lib/crc32.c:197
 crc32_body lib/crc32.c:110 [inline]
 crc32_le_generic lib/crc32.c:179 [inline]
 crc32_le_base+0x43c/0xd80 lib/crc32.c:197
 nilfs_segbuf_fill_in_data_crc fs/nilfs2/segbuf.c:224 [inline]
 nilfs_add_checksums_on_logs+0xb80/0xe40 fs/nilfs2/segbuf.c:327
 nilfs_segctor_do_construct+0x9876/0xdeb0 fs/nilfs2/segment.c:2078
 nilfs_segctor_construct+0x1eb/0xe30 fs/nilfs2/segment.c:2381
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2489 [inline]
 nilfs_segctor_thread+0xc50/0x11e0 fs/nilfs2/segment.c:2573
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12b7/0x2b60 lib/iov_iter.c:481
 generic_perform_write+0x4c1/0xc60 mm/filemap.c:3982
 __generic_file_write_iter+0x20a/0x460 mm/filemap.c:4069
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4095
 __kernel_write_iter+0x68b/0xc40 fs/read_write.c:523
 dump_emit_page fs/coredump.c:890 [inline]
 dump_user_range+0x8dc/0xee0 fs/coredump.c:951
 elf_core_dump+0x520f/0x59c0 fs/binfmt_elf.c:2077
 do_coredump+0x32d5/0x4920 fs/coredump.c:764
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xe4/0x1f0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 dump_user_range+0x4a/0xee0 fs/coredump.c:935
 elf_core_dump+0x520f/0x59c0 fs/binfmt_elf.c:2077
 do_coredump+0x32d5/0x4920 fs/coredump.c:764
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xe4/0x1f0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

CPU: 0 PID: 5014 Comm: segctord Not tainted 6.9.0-rc2-syzkaller-00207-ge8b0ccb2a787 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

