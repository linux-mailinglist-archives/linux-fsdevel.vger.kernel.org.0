Return-Path: <linux-fsdevel+bounces-24662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F39428EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 10:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078171F2353E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10C1A7F7F;
	Wed, 31 Jul 2024 08:12:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF7450E2
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413549; cv=none; b=AfMQ0u7k9hOtFR3aGP1/vfDWYnyPkc2jDDOJf+JMTBtJ1QrZivT6+WCZRl5d4cX3CJHIUzKmNbfMuxDaEDFpS9Vam712eZ113mekNLD0r5C9MmW1E2V1xdhNhPCV5btKfOv0aEFs0Kps5QN2kteuXXRl1pcz/eYxZVSl85c0HFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413549; c=relaxed/simple;
	bh=qvJpor+LrL/+K3X0/nxl5ABeRnDyAXVwXQac/wHVRvo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qYJd2qWbn0lU6PRJYsuFqMo9KOEFdfRdzY4f7v7OCJr8wzz/jhNiP/ZTu+NGcdRxCidb/9cmDxBzB0zQErFgUpmOZheg37N2UmXaFeA2scgU+IhWJMzJ4ciB520HD1tub2pwCJcVUxD0thUoYJMXRTLejAClA5io5isIohcHGPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3994393abd5so90115205ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 01:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722413547; x=1723018347;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVTKQyRC9LK9ysbvwuUUt5aZLW04t0wRCTT0WqX7JWg=;
        b=wSmz9hVPCRuR6+5mpxX9q/UJWMQzIf1HsHSzPZbuuXEFyeMYMnlNjQa3mlmEQEa3GI
         8zgp5VqaGEbBWeVtPj5yl7DIid37R4w+djwZn4P1gRxyUE80xeSxw4QnkEDpsycCBxFl
         i9VT1W01K4o6FkCJqx5TNUpm8q6Lf5ZaOCBc72tYkoT8HDTeJsdPnoAS+ICw4NRxFkK5
         NyImX7a85WI0SmC/OqRTSKVdHO/PUEUAqBsJLuJqH+kO0NwUjNY4mNnCi4R2a83aCnlv
         LriR++OI3veHhlbXwXWoOZXMHeaSCYvqKtar95UBwtOnGdRRCer1SHgW9brQ8w1fdPcU
         5+nA==
X-Forwarded-Encrypted: i=1; AJvYcCXtVzKW4u5hljZQv/xofdE7EhNDriAoe7eVdYAaCXAhSerJJb7C5Qi8nTKEnsyeE8xcQ75y7CS3hkbOfb60jPqASZ+bQYIuGVs9oAGgBA==
X-Gm-Message-State: AOJu0Yypub5Jq3/O+J+frVBEP1WKXOVu9kEWVXZ4Fz0l7rTDAOTS2NDT
	zDc48FLvoRriKbcf58UnBGmD6s3mFIAgDuETdmtbdUVn+WQ3CqwqotXOyWOHu8F3PWe1oeMNGxg
	WAP0AolWbIUUSEAPpnfvnlo4gg28euUDKO16WXRozmquXNyD2VekvHKY=
X-Google-Smtp-Source: AGHT+IFngX/W//rbF0BAH2Q/79wqR6rvNFnLJa7T4lGBOJL3HDXIigWQk12LHJ7LCvkCWDA+hRhH3TwpyLegeIYwAts46tu0VDGH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b22:b0:396:dc3a:72f2 with SMTP id
 e9e14a558f8ab-39aec40c813mr10289205ab.3.1722413547584; Wed, 31 Jul 2024
 01:12:27 -0700 (PDT)
Date: Wed, 31 Jul 2024 01:12:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a90e8c061e86a76b@google.com>
Subject: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f8c4f506285 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=145d019d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1629a655980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bfb899980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ed9f828b1910/disk-2f8c4f50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8bdff998eb1/vmlinux-2f8c4f50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41b7030717aa/bzImage-2f8c4f50.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6b20d8f48921/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8
=====================================================
BUG: KMSAN: uninit-value in pick_link+0xd8c/0x1690 fs/namei.c:1850
 pick_link+0xd8c/0x1690 fs/namei.c:1850
 step_into+0x156f/0x1640 fs/namei.c:1909
 open_last_lookups fs/namei.c:3674 [inline]
 path_openat+0x39da/0x6100 fs/namei.c:3883
 do_filp_open+0x20e/0x590 fs/namei.c:3913
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1442
 x64_sys_call+0x1fe/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4719
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2263
 alloc_pages_noprof mm/mempolicy.c:2343 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2350
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1008
 do_read_cache_folio+0x12a/0xfd0 mm/filemap.c:3753
 do_read_cache_page mm/filemap.c:3855 [inline]
 read_cache_page+0x63/0x1d0 mm/filemap.c:3864
 read_mapping_page include/linux/pagemap.h:907 [inline]
 page_get_link+0x73/0xab0 fs/namei.c:5272
 pick_link+0xd6c/0x1690
 step_into+0x156f/0x1640 fs/namei.c:1909
 open_last_lookups fs/namei.c:3674 [inline]
 path_openat+0x39da/0x6100 fs/namei.c:3883
 do_filp_open+0x20e/0x590 fs/namei.c:3913
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1442
 x64_sys_call+0x1fe/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5191 Comm: syz-executor190 Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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

