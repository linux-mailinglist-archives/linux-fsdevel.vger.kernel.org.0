Return-Path: <linux-fsdevel+bounces-26103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B51954607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BFC1C2202D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438116EC19;
	Fri, 16 Aug 2024 09:46:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878E78C9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801587; cv=none; b=JJ3lztWnkXs5Pm4Iqy4dgmFXKBQMTgqrPxuNNpKHox2brvsgB7O+1+m83q/9HFDWwx01b3K2OHCCss7IFzuCLVweunvxrx6xtL2C5xOCzTn8iBAj5/o24hV9iMff/nDjUVv9qBVF6fL+AVXnzYd2U8PhYZGoeXTLQaNBSwWUhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801587; c=relaxed/simple;
	bh=1L/ww/Sczm2uAjgFIPsrwLBpMiPQhDGAUCiGRllq9XY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GTfebmi83Wek1Qt/NUsXRLAxHP/2zH5XPFp+I+b/ykSFfezW5wiuiB/yHGSTb7HF0oiry5+yY3OHdFhYHuC5KERUYqjPqFKbDwbcXEmG7HwoYt0Lhb3mSn+9lWhffM7RYBgnr/178lTQxHVc0Q981cSgBRXg5PWCCgauYWURusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso189306939f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 02:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801584; x=1724406384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+jc6R3Vwgd4nRUWxp1IMCgQDjJpSWB6yhVXj2Ff18g=;
        b=t8oZ8eUNnVrXgi7W/MF+WV0e1FVoc1kBhtlLupPkipZCm6lczk6/gUSZHuxijuNedL
         3vP7Oz6OmSEPW8f3xnA8lGrbHO1ynOjEd1J6V/4wyv+kBvKrJku8u1S1GiMIyg7rAjL5
         o2qsF1n/QkbufaQWp7XbfJlxsJxJQvEahht/iHPcgQjF0ELVH67R5ecMqV2i7zNAMs8k
         xnMvgA+ZdteLOwGZCzKkXTid4G8Wdo/U95a0113+0WpwjFeQLAw3lKiL97g72pwl199a
         AZ8w9t0rRIakutMmqUo2jyPmusxKJtJfrI8mYB63kT32HezXTJ9pnULpMix4T0acyG3w
         dmvA==
X-Forwarded-Encrypted: i=1; AJvYcCVXg4xIJ637yOiticoykCJhXIvlcpL1EGyp3LiG7An02vr4OtX6nFzcmv5A+ztsnP4gM83BpT5waWr3VwxV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sIwK76UUuOF9ElSzJse8R+cEikX5fLAj81ChKDioBMp610ph
	+kLTMWqA5y2cIrsPEfhxMtuF6VHQczkgsNSIHjoXsCfOGp97rBOJMUfNGXjWDpPyKAfGUojkVrv
	d4Jq9p9djDwCPSvo3eAE3uQwmQXGpPvg2jph8P9fTIGTBqDP998vRD+U=
X-Google-Smtp-Source: AGHT+IEUUexl6/+WI65T1E05izy98keqo/nxrdhjFsO6pZOqyI5yd5MpRwx02QmdbHAfbAkaJzmiRCHf8B/5/3+yJmZRylo9DAb1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2482:b0:4ca:7d94:37de with SMTP id
 8926c6da1cb9f-4cce1703984mr69003173.5.1723801584605; Fri, 16 Aug 2024
 02:46:24 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:46:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d314b061fc9d5c1@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in pipe_poll / pipe_release (7)
From: syzbot <syzbot+1f49e6ed8370198296d4@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1fb918967b56 Merge tag 'for-6.11-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119e0ad5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77bd8f74037eecb
dashboard link: https://syzkaller.appspot.com/bug?extid=1f49e6ed8370198296d4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63f8e12ef21f/disk-1fb91896.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d776ae2f2dcd/vmlinux-1fb91896.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9636a1ac2746/bzImage-1fb91896.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f49e6ed8370198296d4@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in pipe_poll / pipe_release

write to 0xffff888111d4fc68 of 4 bytes by task 12262 on cpu 1:
 pipe_release+0xb3/0x1c0 fs/pipe.c:731
 __fput+0x192/0x6f0 fs/file_table.c:422
 ____fput+0x15/0x20 fs/file_table.c:450
 task_work_run+0x13a/0x1a0 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x5dd/0x1720 kernel/exit.c:882
 do_group_exit+0x142/0x150 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x1f/0x20 kernel/exit.c:1040
 x64_sys_call+0x2d5d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888111d4fc68 of 4 bytes by task 3249 on cpu 0:
 pipe_poll+0x17d/0x260 fs/pipe.c:689
 vfs_poll include/linux/poll.h:84 [inline]
 do_select+0x959/0xfa0 fs/select.c:538
 core_sys_select+0x362/0x530 fs/select.c:681
 do_pselect fs/select.c:763 [inline]
 __do_sys_pselect6 fs/select.c:804 [inline]
 __se_sys_pselect6+0x213/0x280 fs/select.c:795
 __x64_sys_pselect6+0x78/0x90 fs/select.c:795
 x64_sys_call+0x26f7/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:271
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3249 Comm: syz-executor Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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

