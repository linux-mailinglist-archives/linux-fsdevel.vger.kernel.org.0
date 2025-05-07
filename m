Return-Path: <linux-fsdevel+bounces-48383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4709CAADFD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718191BA5D0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D494C2820C9;
	Wed,  7 May 2025 12:54:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BE280325
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622478; cv=none; b=hnJn28Otl8z5kcg/DGtsZ2IfHceJjLRTZbOlwMQRcUC4ZSj0UOfsIZaxAFAq1qszcPtrkYWOPDMmj1RGCiSBy6C3hXZmgo7Q+xEyt+rHbs2h4XajM0NG/k64JSdjw2M2z0rWOzgIomriVi2i7xKDnVHOjbPX1xCXUThcd069sE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622478; c=relaxed/simple;
	bh=QC6+HmSCsRbvwmx6zJIhx8tiaH69bA9xIL794v3U/VQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BT2AcF6gQLTl1lrtVhtx9Jsw5qeOFEhdD7zt5pShRsK7QAHHwIjj/fnX2yE5SPGdJzLSprZWdL5aFSnkcFtwxoxqUSgtVzv5K+aQZod/JZh0qN1M1nnTR+cyMVlsCKNgp59ugmskrtvsAjKi5LHsCKo/l2ZkulWWQd9hFzXhlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d96661c8a2so80439595ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 05:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746622476; x=1747227276;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJXgcgtEo3HvQThmkGtkELcoLcxPgR+NGnQEIlDNlVE=;
        b=p/x0FJYKW6Y8PCV/qgfAIsiw0xMJ4vSyt4d9lInkrToh7kWzBxMq0pwXdkHmHQGnrE
         jrKsMuOcxd+z8K90vRpr0ilFD6X/kKfsPLzTP57Y+5V7r0w+FDnK4JHSacvq4LiOUXF1
         oFVvwO6gfXBTLVpO8oNKGJbBL8hyxGrLHJxv64ZjifgmOXlFaDtrQnIUG7Qh4uoN2qa1
         fOGFEEtKCP9XkfCqKJyTL0t7rrYpUTiBxDsLH7Kl4VDMqZvauBoUIWEEnmzGoxKLj+sy
         bMM1R+1IYKElYVTvT0uWqx0y9GACNebnVZ0oenCfZ2DuMzNSWKLgpuisPComoKwu6MeA
         o57g==
X-Forwarded-Encrypted: i=1; AJvYcCXhVfDHUYLiM38u3KuuBciWLyapV1jc5PzILJJnJqqo1+zAWWbqA1oX7rIJ0KJKDur3/GrYVE3Hy1fVvbY+@vger.kernel.org
X-Gm-Message-State: AOJu0YylhmTSF4MUAM+6LhY0UZnLmOB58Q2ps3iYRBUeqPljIXgKw0M5
	Jff4iYceih5iw73Zz6+YTOHmQCet7CK1gj8nGXUEgUd0RjMQykcE+a9dzEdPcLmc7La+OKSwDst
	JQ5E3OEAquwCkXGboHcIquCDsP2E6u1YlszQTLqo2vIdHqCcbQCIyhCg=
X-Google-Smtp-Source: AGHT+IE9FFTW/1vyB9LVH+Qme6xJwWzOL1p1Ah7vIxZvTjNPwhUEBLF1vtivmCkB7VgofXzhJAqIuyGsPobvqxUGAaX/CBXGA7bw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:3d8:1d7c:e180 with SMTP id
 e9e14a558f8ab-3da738f96cdmr30761755ab.6.1746622475975; Wed, 07 May 2025
 05:54:35 -0700 (PDT)
Date: Wed, 07 May 2025 05:54:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681b580b.050a0220.37980e.0405.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in copy_fs / free_bprm
From: syzbot <syzbot+2428028ccd7d1ff933a0@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8d44db295c Merge tag 'for-6.15-rc5-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e971cc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6154604431d9aaf9
dashboard link: https://syzkaller.appspot.com/bug?extid=2428028ccd7d1ff933a0
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d91fa429308f/disk-0d8d44db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24f0298ad2f8/vmlinux-0d8d44db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d805d3a8719f/bzImage-0d8d44db.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2428028ccd7d1ff933a0@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in copy_fs / free_bprm

write to 0xffff88810475a110 of 4 bytes by task 10717 on cpu 0:
 free_bprm+0x122/0x220 fs/exec.c:1498
 do_execveat_common+0x560/0x750 fs/exec.c:1970
 do_execveat fs/exec.c:2053 [inline]
 __do_sys_execveat fs/exec.c:2127 [inline]
 __se_sys_execveat fs/exec.c:2121 [inline]
 __x64_sys_execveat+0x73/0x90 fs/exec.c:2121
 x64_sys_call+0x2dae/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:323
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd0/0x1a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810475a110 of 4 bytes by task 10715 on cpu 1:
 copy_fs+0x90/0xf0 kernel/fork.c:1804
 copy_process+0xc6e/0x1f90 kernel/fork.c:2420
 kernel_clone+0x16c/0x5b0 kernel/fork.c:2844
 __do_sys_clone3 kernel/fork.c:3148 [inline]
 __se_sys_clone3+0x1c2/0x200 kernel/fork.c:3127
 __x64_sys_clone3+0x31/0x40 kernel/fork.c:3127
 x64_sys_call+0x10c9/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:436
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd0/0x1a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 10715 Comm: syz.5.2513 Not tainted 6.15.0-rc5-syzkaller-00032-g0d8d44db295c #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
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

