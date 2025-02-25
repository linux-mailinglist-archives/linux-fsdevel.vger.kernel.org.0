Return-Path: <linux-fsdevel+bounces-42565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF17A43BEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209D3188ECD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908433981;
	Tue, 25 Feb 2025 10:36:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39786260A3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479792; cv=none; b=OkHjIBcTU7raqrLajnQIcfXhpB5P1BZ0WmM6MMng1aGMhDWprw3AXZNgQLyArEXavaE2Sy84uIY3KHiYbyQXAbvHU8O79H8VzqC2dStDBBIzyJxtMKzVytoFmIIC+wDvPqKZ0M19O5BpW97bqcfi4qcb6MRO1WFoaZN1hQ8EuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479792; c=relaxed/simple;
	bh=XjsAgpsN0j5oRHDKfW6dWsYs0oKQaUu98fmWODDFbQs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ck/FbSPtC+pXnicm1tLimUXN+ZrGg7X6Evm0A0PDJ+6b5z2csm+FLfWLKboxLx3SYvjVnvVyglPY3HC+uUoInv7CLsyKWMlQLDOMfTjZ8QUbdVC/bIfSb38j6etiv910Zt8I9tbezy0IpWkzu4JLTJgwVuJPwDJRc8r+afY/ibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2b6d933a5so41509595ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 02:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479790; x=1741084590;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itkP3+EqX5jDHrJ5nqo1dq9K7WbkKJPEFcpMjPBhsv4=;
        b=k9z6xKxKLSBcvxiFGLXIYQAYwDAePvdFAuaN1sBsENQqNGkhwdkWDMQT72RSRJr9Qb
         6IPpoSoDv5tq7xgyusYSwNa8nlrwidUia9Zbi9wXIl6yoOYXMrUcxDzKzOGD3aF55CND
         qU4ub7VJ0fFCVv9neYGtaFcWk5zdJmPS+rODE0naQz3aqEzireYeKWlJBgwu6b5fJ1bf
         i/AmOvK4hh1XcGlk0AtGHH1SUr5/Oik6rYaEcmE42FBRRdzTUovXUPykegx896sA32Si
         rPvsuynBhdGy7jiNJm1CLDsqsqVRa/UgscsgF8ikH8tn1F0B2UnanI8n0dVHOCC2Pb5V
         58Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXUVpLqclru079PusQ8Y3Wbl6kIYNvM+zkoufgJysFpFfi3xPaypzKN3/NSqJt4SO8DKSBlVl5GA0nahMsI@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOAy2k7YMflCtOTFu8yphjCvoMedOfqbIzfALoYnueGz4awUD
	CQsAS6SWs5axyP1wgzfYIF8cIJIbaU4afjHntEiUHTzuP1xVv2OTWhteV99RXCpCzypOoLRstCq
	SHeZkHbm1CcwVzJpZU/IMN5SoRJDbMEdfxkv7tEmafrH+ZWTh4p4g5hs=
X-Google-Smtp-Source: AGHT+IFbCtGYN61vjgMvuKY9FqO2iFg0X/7ZT3gxl6WR+kyIz5LfL7pn902vPL7OLDRZM32Vw31ljX1b8mS3lYQ1iGrVPm6ofRIE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f04:b0:3cf:b87b:8fde with SMTP id
 e9e14a558f8ab-3d2caefdc5cmr154864735ab.17.1740479790345; Tue, 25 Feb 2025
 02:36:30 -0800 (PST)
Date: Tue, 25 Feb 2025 02:36:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bd9d2e.050a0220.bbfd1.00a5.GAE@google.com>
Subject: [syzbot] [netfs?] KCSAN: data-race in netfs_advance_write / netfs_write_collection_worker
From: syzbot <syzbot+912f708269025e337cba@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130277f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9dd6c7eeba2114e
dashboard link: https://syzkaller.appspot.com/bug?extid=912f708269025e337cba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2b352c2abb77/disk-d082ecbc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5f4a062a264/vmlinux-d082ecbc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3a86625df5a/bzImage-d082ecbc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+912f708269025e337cba@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in netfs_advance_write / netfs_write_collection_worker

write to 0xffff8881188765b8 of 8 bytes by task 3523 on cpu 0:
 netfs_prepare_write fs/netfs/write_issue.c:210 [inline]
 netfs_advance_write+0x36f/0x610 fs/netfs/write_issue.c:298
 netfs_unbuffered_write+0xde/0x330 fs/netfs/write_issue.c:721
 netfs_unbuffered_write_iter_locked+0x2b7/0x570 fs/netfs/direct_write.c:100
 netfs_unbuffered_write_iter+0x2b7/0x3b0 fs/netfs/direct_write.c:195
 v9fs_file_write_iter+0x60/0x80 fs/9p/vfs_file.c:404
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x77b/0x920 fs/read_write.c:679
 ksys_write+0xe8/0x1b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:739
 x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881188765b8 of 8 bytes by task 50 on cpu 1:
 netfs_collect_write_results fs/netfs/write_collect.c:231 [inline]
 netfs_write_collection_worker+0x3ee/0x2530 fs/netfs/write_collect.c:374
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x4db/0xa20 kernel/workqueue.c:3317
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3398
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x0000000000000000 -> 0xffff888103259900

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 50 Comm: kworker/u8:3 Not tainted 6.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound netfs_write_collection_worker
==================================================================


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

