Return-Path: <linux-fsdevel+bounces-15838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C305F8944B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E678A1C217B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA9450A8F;
	Mon,  1 Apr 2024 18:17:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84044F1E5
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995456; cv=none; b=NHh+BkWg6t7qo4obZXKEZKGTSpptAUt4ceHXhWEcrrNRjHbDU0Cze8JrxBlmcWTN/keYEkRlFJlMVlfkfvmA/RrEfWKUtpWM4F9gieIc4wWbyv1QMg/7QDIwIhTKqdiRRg3gSjDmlm0JWanz69WLeudhF0e72FMJTAHJ8F3Zv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995456; c=relaxed/simple;
	bh=Yle4yvFZIqedNTg+h/HEtgcYNzDRNeSusEr/hRLPLDs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tn1Sd71UlG3eVKCFxFlxUTosNYkslt5TVeLxHJBWXLkf/fJbdLxTCL5g6GEUPFMH1LctXWcHNE6R6oW296o3HXw2e0S8VpBq2UG//iUMKngK2vZzMtG3dLlFXguekKk/jviFNQrw1U/2kSUb+8a7AXl3rBzoa9pgPxrRV6B3g6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso467205039f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 11:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711995454; x=1712600254;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJlEndQEIzeEpe1fH5ecDqbiBNhCkTHqvRITIB+hE1o=;
        b=NYaoOpr4JIbGmFCTdrXbMI2ccZWx3TWoyrf57cWGyOYHt0qKea2XVrbAjn1T5CNiiz
         NXi1Htmzf2oLp3z4nz/i2eDkelLLkssiKsgSdXG7e6Bqh161rW7VUG7wabfI4mVPUA1k
         +pEfzXanI6Kr+MqtE9QVOyDd75dyarz1lsml8lDg+SqP+S9uhIDVjLNWAjmhCaFHLSf2
         PwQl6kxeYs1B2vaXGjIUt1w8aag71sBSXbFAd9aTmUSldh/qeWHlnOlv7Z3rf+Vkts+y
         eVpizhgPe1BuYlVOpKxayomgVfE8/OEJdIGbtYzhe65hviPknYvf4vzVxh25NuaceXSk
         Oftg==
X-Forwarded-Encrypted: i=1; AJvYcCUtb+LLY8UT8byabxHhljCONKIFIDguDmteaZpcMfotgEl44CtECJRl5pshVwBz+mzBghjyhEvxoqMJ8Pr0Rb97L9Mro/j+nZXX409RNQ==
X-Gm-Message-State: AOJu0Yy3LMh5eXegktF5iNhK2JtH6UpHxma9KREDtnlzgGCMO7nDitpZ
	+6iHlqYb0UhxiLEtpshD+roaRdHrraDCWtCSt85L7/OkKLIFZ2gwfaVuEPHt7DLJftjIL19/UrX
	nW5qdHbzedTvb62cxOqpSpAV0AinWrjpGexvL+Loug8nATwYuTEYAz6g=
X-Google-Smtp-Source: AGHT+IFEGWgQDwItsI3Up41wsO/M+n4dRqh5NjCYKEq5pkmMs7ZwpVG+VeSxDvQ2a3yXoh1JRjrzhmcJVaGp3bu1VntcEsZVY7fr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3488:b0:47c:195d:16f6 with SMTP id
 t8-20020a056638348800b0047c195d16f6mr429616jal.6.1711995452391; Mon, 01 Apr
 2024 11:17:32 -0700 (PDT)
Date: Mon, 01 Apr 2024 11:17:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc14b006150d005a@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbSplit (2)
From: syzbot <syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a6bd6c933339 Add linux-next specific files for 20240328
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=179ebb76180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0058bda1436e073
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ca8a249162c4b9a7d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ef71f9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132cf70d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c1618ff7d25/disk-a6bd6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/875519f620fe/vmlinux-a6bd6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad92b057fb96/bzImage-a6bd6c93.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0e8af372eab3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:2639:11
shift exponent 121 is too large for 32-bit type 'int'
CPU: 0 PID: 5079 Comm: syz-executor118 Not tainted 6.9.0-rc1-next-20240328-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:454
 dbSplit+0x21a/0x220 fs/jfs/jfs_dmap.c:2639
 dbAllocBits+0x4e5/0x9a0 fs/jfs/jfs_dmap.c:2191
 dbAllocDmap fs/jfs/jfs_dmap.c:2032 [inline]
 dbAllocDmapLev+0x250/0x4a0 fs/jfs/jfs_dmap.c:1986
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1823
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbAlloc+0x658/0xca0 fs/jfs/jfs_dmap.c:888
 dtSplitUp fs/jfs/jfs_dtree.c:979 [inline]
 dtInsert+0xda7/0x6b00 fs/jfs/jfs_dtree.c:868
 jfs_create+0x7ba/0xb90 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3497 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0x1425/0x3240 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_open fs/open.c:1429 [inline]
 __se_sys_open fs/open.c:1425 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1425
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7faf13ba19b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9504bea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fff9504c088 RCX: 00007faf13ba19b9
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000020000400
RBP: 00007faf13c1a610 R08: 00000000000060cc R09: 0000000000000000
R10: 00007fff9504bd70 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff9504c078 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

