Return-Path: <linux-fsdevel+bounces-38148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58C9FCE17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 22:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BF016370E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 21:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A619B5B8;
	Thu, 26 Dec 2024 21:44:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C605198E9B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249465; cv=none; b=bIPksA7ZwRNOcbTRbYgLcjK6w4F560QYpDQoLsFsYNF7v/J3bYdrrLLH1DTlnB9slW3V3311Xjqi2pfkmgjUOpxeZBxsTLIUPrvWk0CTlUFafkbULBZufTL8qjQQ1dYOm/HLi+vCeU1IZJ47GfirfLKPT93ytKmUVqZu19k1wJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249465; c=relaxed/simple;
	bh=NwuLxqrMHYjzHd3nPzjelzlOxCb20XD7pDSvgbfFA+w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TjSYAoom1dkVeyyz2teVuaVEH3ZbZSWgsuBRJ/Y51FhFwbLRxnjt9Z8lDV5UKJPiVf3hSF1t59PtqWm7lFmovbvuPsmMmiZkWe6JTuYLS/CS5zFsc+ahVlsjDVM8ZhCx9p2sur2sRbx/LHK4cCRCnnwwhVoF0T4eHDP1uVYIJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-849d26dd331so275342939f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 13:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735249463; x=1735854263;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9BBVFdpmelnGBdByk8AQjzuGOhr/Qdln3EjFJahLsE=;
        b=hqd/PbSb4jJESHVsfA2liM2FqLcSrbIy1tKAYyPK4tWlS6lrxTmENwm4MMfkmSJoQJ
         a0ySVED7PIdLiLx8SWbeKDcOYPlMuKakG2w6lcJ8W42fkRsew5IIMjcBEu/rGVcpD4Zo
         yi7k1QGmlhCI8IywLXpcMwylg47hmfqrYo/xLAJi8AYp02U+p2HBzCJba793X+MzYvNE
         3fGueBW4mA/vNqQdWdunndkUHUDSial47/L9YTSviDX2wVGc4rlLh+xHAdSNqu5QVtXk
         R4daiTOHOEalX3B1mC8FHtv0r3sEhIc0Jj3AAUHv3v3IbpsuI838Qvtf5nm2Plof0N0a
         BUTw==
X-Forwarded-Encrypted: i=1; AJvYcCVAUmpjAkvPcQlENmvgViTNpuTA5bbBXyMnIUxIC+8+Ufx1i50BAFEpoEM9x0HydKyrAEUE97J9g+dNrNKw@vger.kernel.org
X-Gm-Message-State: AOJu0YzAiMlOrZZms5O1tQLe7f2Rw5z4WUvOrNVko5GR1Gsghp0Fslsb
	dPhzibCOR9h2fys7Dw2VIUFQJehYrVzoq3EvmNNu3EywmZn+1ZcdzE32qE4hJDtJlTHiW3ThxcU
	mD3Zrt25kTgujwqLQPRor7a8qpbWfHvdsd0OXyMXN/zmdDU55aTpbfa4=
X-Google-Smtp-Source: AGHT+IHeQ2EkO7BAuFTMySi+x97oob8WIlAuDYl4DBF3hHhbQw8qiaOaEHLr0e5hMV1mEe61QL1usdW4HY0rJd3OkEY1l3q2oIl8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1488:b0:3a7:e956:13fc with SMTP id
 e9e14a558f8ab-3c2fee1244amr196657545ab.5.1735249463232; Thu, 26 Dec 2024
 13:44:23 -0800 (PST)
Date: Thu, 26 Dec 2024 13:44:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676dce37.050a0220.2f3838.0472.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in read_pages / read_pages (4)
From: syzbot <syzbot+e1d2475cbd1f0c63692f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10431018580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d3cfca6847d1fa
dashboard link: https://syzkaller.appspot.com/bug?extid=e1d2475cbd1f0c63692f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f3f5cceed80/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ba00b70d91e/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b99c1bb4d63f/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1d2475cbd1f0c63692f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in read_pages / read_pages

read-write to 0xffff8881034df5e0 of 4 bytes by task 9479 on cpu 1:
 read_pages+0x23f/0x540 mm/readahead.c:170
 page_cache_ra_unbounded+0x2b8/0x310 mm/readahead.c:295
 do_page_cache_ra mm/readahead.c:325 [inline]
 page_cache_ra_order mm/readahead.c:524 [inline]
 page_cache_async_ra+0x40c/0x420 mm/readahead.c:674
 do_async_mmap_readahead mm/filemap.c:3231 [inline]
 filemap_fault+0x2d1/0xb30 mm/filemap.c:3330
 __do_fault+0xb6/0x200 mm/memory.c:4907
 do_read_fault mm/memory.c:5322 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0xe98/0x2ac0 mm/memory.c:6112
 faultin_page mm/gup.c:1196 [inline]
 __get_user_pages+0xf2c/0x2670 mm/gup.c:1494
 populate_vma_page_range mm/gup.c:1932 [inline]
 __mm_populate+0x25b/0x3b0 mm/gup.c:2035
 do_mlock+0x415/0x510 mm/mlock.c:653
 __do_sys_mlock mm/mlock.c:661 [inline]
 __se_sys_mlock mm/mlock.c:659 [inline]
 __x64_sys_mlock+0x36/0x40 mm/mlock.c:659
 x64_sys_call+0x26b2/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:150
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read-write to 0xffff8881034df5e0 of 4 bytes by task 9477 on cpu 0:
 read_pages+0x23f/0x540 mm/readahead.c:170
 page_cache_ra_unbounded+0x266/0x310
 do_page_cache_ra mm/readahead.c:325 [inline]
 page_cache_ra_order+0xf7/0x110 mm/readahead.c:524
 do_sync_mmap_readahead+0x267/0x2a0 mm/filemap.c:3203
 filemap_fault+0x32f/0xb30 mm/filemap.c:3344
 __do_fault+0xb6/0x200 mm/memory.c:4907
 do_read_fault mm/memory.c:5322 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0xe98/0x2ac0 mm/memory.c:6112
 faultin_page mm/gup.c:1196 [inline]
 __get_user_pages+0xf2c/0x2670 mm/gup.c:1494
 populate_vma_page_range mm/gup.c:1932 [inline]
 __mm_populate+0x25b/0x3b0 mm/gup.c:2035
 mm_populate include/linux/mm.h:3396 [inline]
 vm_mmap_pgoff+0x1d6/0x290 mm/util.c:585
 ksys_mmap_pgoff+0x286/0x330 mm/mmap.c:542
 x64_sys_call+0x1940/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:10
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000001f -> 0x0000001c

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 9477 Comm: syz.5.1573 Tainted: G        W          6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

