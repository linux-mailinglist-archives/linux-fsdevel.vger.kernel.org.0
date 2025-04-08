Return-Path: <linux-fsdevel+bounces-45939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D5A7F8E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21361188C688
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA17263F5E;
	Tue,  8 Apr 2025 09:01:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC136221DA0
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102892; cv=none; b=pgP+Lan5ZT+J/DPBjl2tha6rbVHyS5fE3Q3ScHGqkmdCqZjjUb2WC0QAUAGfv2cPEBPvJ8jMzZo5032gVxs4lYcEIwvQMJJObiuZc2DsJKpyt+5lCX57QvLMBgYPQqwg9DvRkr0sbIEs4J/j+6RH1zt2u2MeyzIW6t0npie05R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102892; c=relaxed/simple;
	bh=384l3PTbeYSwCorTutkbhVMp6kKpAlQaOmRq97Jqrj8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=myayStA6Di23Wr4GgrtJ/tXJ7EzatDwbhiQTnMQSJnxM6gDhmpl7KHfuYnQDBUNKJoAH9gRMsldt4mmzZ7RTbtYQbL78yJG8VEsGDjGbZCf7ublytApxwb8QyhR00IdKijijv+M+eLSw5X7tl1uPccc171kTIB3BzvTxHCcIQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85e15e32379so511827539f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 02:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102890; x=1744707690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPm2Fj3K9bOe54x0wglZkU5Qak+qbf+/DlnHrO1S04c=;
        b=fMgHBzsABsTjLthOXPvkRWDbjaDH1MQ1+woiWbiSTi3p9NjdwUxFeOQr9hAvTpKviq
         vVXeqHuchIk+D4k7Wk3tUfZjaz1pvJFigfaNBEUvWZdnzFYtrItBBNdoi75RtjAf1b/u
         BDyG0vg/yJvrFPJ+nHP3gs1vAGPWJ/GnzX0crgs2g4rfhFVIJH4tAql8qleQ+JGGVUbn
         x73zFvKP+Az88CGQ7NjIAzKJvfxotUvAqEdOOyp4lALW/d2jD+0n6gsX2tukeP+GAX6c
         /0ncn4M62CShDHWtWZSVV1jOPwEwrs91tqaEcoA2Uo7Bd5WzZipT7fWmz+faCZxtQz1G
         jUYw==
X-Forwarded-Encrypted: i=1; AJvYcCXnBGmAcKTnY713gdJZYUgUmZgSvhmVOBGfzOfnql0XVl3ey5FcyqAcNoAx+VWbZR10/FSGHUd0MmdSM+cd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyagelq6hFBRTyimyMwGsCDaDMZT6mAG9NzHYEJCui7BCy3asVA
	+nh5d3YKaElMq+/rXclyay/Bm7t+W1iFwyY2oAv//q5hGFv9bw0JcmdjxAca5XqYUcM9TqoIPuT
	UYc5LGKQOdp2HJ9kahcGeewKdu+8WYko3DxFjij/bn4/6T1Na5eWkbro=
X-Google-Smtp-Source: AGHT+IHvOmHTaxKw32IHfBibRmPBaLK8bfWab8je54uO/jfBP8shxFJjrhVyBu0cSggEvkPgXqT5kSTTfL7IjrCOn04x0iS6YY8y
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c25:b0:3d3:fdcc:8fb8 with SMTP id
 e9e14a558f8ab-3d6e3f056ebmr135999395ab.10.1744102889953; Tue, 08 Apr 2025
 02:01:29 -0700 (PDT)
Date: Tue, 08 Apr 2025 02:01:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f4e5e9.050a0220.396535.055c.GAE@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in file_end_write / posix_acl_update_mode
From: syzbot <syzbot+dbb3b5b8e91c5be8daad@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c98070580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5bf3e2a48bfe768
dashboard link: https://syzkaller.appspot.com/bug?extid=dbb3b5b8e91c5be8daad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d90ae40aa6df/disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/616ed7a70804/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed2c418afc9a/bzImage-0af2f6be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbb3b5b8e91c5be8daad@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in file_end_write / posix_acl_update_mode

write to 0xffff888118513aa0 of 2 bytes by task 16080 on cpu 1:
 posix_acl_update_mode+0x220/0x250 fs/posix_acl.c:720
 simple_set_acl+0x6c/0x120 fs/posix_acl.c:1022
 set_posix_acl fs/posix_acl.c:954 [inline]
 vfs_set_acl+0x581/0x720 fs/posix_acl.c:1133
 do_set_acl+0xab/0x130 fs/posix_acl.c:1278
 do_setxattr fs/xattr.c:633 [inline]
 filename_setxattr+0x1f1/0x2b0 fs/xattr.c:665
 path_setxattrat+0x28a/0x320 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0x6e/0x90 fs/xattr.c:743
 x64_sys_call+0x28e7/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:189
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888118513aa0 of 2 bytes by task 16073 on cpu 0:
 file_end_write+0x1f/0x110 include/linux/fs.h:3059
 vfs_fallocate+0x3a5/0x3b0 fs/open.c:350
 ksys_fallocate fs/open.c:362 [inline]
 __do_sys_fallocate fs/open.c:367 [inline]
 __se_sys_fallocate fs/open.c:365 [inline]
 __x64_sys_fallocate+0x78/0xc0 fs/open.c:365
 x64_sys_call+0x295f/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:286
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x8000 -> 0x8072

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 16073 Comm: syz.6.3255 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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

