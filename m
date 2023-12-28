Return-Path: <linux-fsdevel+bounces-6994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C681F6E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 11:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A5C1C23271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4726FA4;
	Thu, 28 Dec 2023 10:34:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ADC63DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ba7b2c0c1cso861728939f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 02:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703759668; x=1704364468;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0oCSfRy8XwUA44T0zAUXbingz0fhM4PCwluuYF0MN0=;
        b=hGaPTELKuG0mhVaIc4dJMfLMIX03TzNh92nQll93ma8cD41OuudPRgTj0wgNxWQSdG
         2HA1EP0P6F3LIeaNH7TL8W51tjkAEpjuabVGgWLpicsp5TOCQn/hTF0YdBat+ZQXHUQJ
         PBDJ0kIWwPEAkHA6ith6Q/+HsnZhmef093eV0HG0v/1xtek8gHEFsrSZsObYnRvO0qvQ
         hDWan1dYuSSwsesuMQFl9ZaRnNCz0qL1ygjC2wBgJ/nHqeQghoI7CMdWukwOeQL4RA6f
         c/AEtBkc8u8qkgVopCVEYeOaWzOZyBjOL749cQG8eWyxY5YjXhmTGoMeo9apBwz/aShH
         XROQ==
X-Gm-Message-State: AOJu0Yx2GdENIVK/jN/lJbEJmRiuVG05vLmQQ3pvrjzrphG0dxhosKKO
	PhGwhB/169OE2IjmwdoSMz96IWC6GsZUFVIU6RFDGH/SkqQZ
X-Google-Smtp-Source: AGHT+IGzkU8ICsFNgeWO4iMwAVO3MODGVzGlDeU6J/rYE3fRLIvnn0zpP26ixYu9X8V+8iYL6Mtid9xy6XQjpMWsk8M04Gd9o1Ii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:814e:0:b0:7ba:d9c8:b97d with SMTP id
 f14-20020a5d814e000000b007bad9c8b97dmr77030ioo.4.1703759668260; Thu, 28 Dec
 2023 02:34:28 -0800 (PST)
Date: Thu, 28 Dec 2023 02:34:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf405f060d8f75a9@google.com>
Subject: [syzbot] [udf?] KMSAN: uninit-value in udf_update_tag
From: syzbot <syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16e0171ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17561579e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1277e7a5e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f35551f8a991/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com

=======================================================
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
=====================================================
BUG: KMSAN: uninit-value in crc_itu_t_byte include/linux/crc-itu-t.h:22 [inline]
BUG: KMSAN: uninit-value in crc_itu_t+0x287/0x2e0 lib/crc-itu-t.c:60
 crc_itu_t_byte include/linux/crc-itu-t.h:22 [inline]
 crc_itu_t+0x287/0x2e0 lib/crc-itu-t.c:60
 udf_update_tag+0x5c/0x2a0 fs/udf/misc.c:261
 udf_rename+0x13dd/0x16a0 fs/udf/namei.c:877
 vfs_rename+0x1a79/0x1fa0 fs/namei.c:4844
 do_renameat2+0x1571/0x1ca0 fs/namei.c:4996
 __do_sys_rename fs/namei.c:5042 [inline]
 __se_sys_rename fs/namei.c:5040 [inline]
 __x64_sys_rename+0xec/0x140 fs/namei.c:5040
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable diriter created at:
 udf_rename+0xbb/0x16a0 fs/udf/namei.c:768
 vfs_rename+0x1a79/0x1fa0 fs/namei.c:4844

CPU: 0 PID: 5011 Comm: syz-executor409 Not tainted 6.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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

