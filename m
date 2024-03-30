Return-Path: <linux-fsdevel+bounces-15763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE7892AAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 12:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992862827F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D4374C3;
	Sat, 30 Mar 2024 11:13:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6552C6B2
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Mar 2024 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797213; cv=none; b=Ny05a6cAp1JyJ1wDTzx4Yn8qO5CDbE73oUFQIaTce1/0ZBUjTbUZaj2jh0sGIcokHsuvkNRhMm0SFBcLL1MQ4QsEhVk64xNZKlQh53jKLdoHs7pqHRGagV9oSio6rvChT4n1KYFF1/IeWOEC4l3dhIdZBTSHY2vHv/lAH7eU08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797213; c=relaxed/simple;
	bh=esAXML7DHdxiwyFJ3iRZS4Izea43hxblUD9ErMVwPiI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RfjzeOxVJrkA+xMBu6DyZ5xB7qZaNX/CDb9gWK15171t5Yau+3q1V+Svi/bs+X+JTuglYXnJPB9Su/UdvoNNkIuz0N+tziTgLvrg6vIL1JuPWh7fP02L0oUlx2EvijL2YHc4llCHeBWiyima1jDGE8nq+q0gJe9b+jpI0sdyTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so201848939f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Mar 2024 04:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797210; x=1712402010;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th/ktqkvCCzUDJYZJAFFpoB/hGLm/LGgGFQxtdAl6RU=;
        b=BOrtTxCiCKnH7Pm1st+cR5Kq/8QaSJJ9AT8gQSZcmtHOp1pYBVdykJ9X+IbfRmRiaE
         PhBfS3G12IaK/O5hE4ld1vfe55YNCeUaMuMpC1Ses6/TuZGtZzlp8bNs5PoJ18LQD2Ai
         J1QD2Q//SIDUYNb+VGOHJ6YkVwHW6JXWBx4kBe//hixKaceQCM5itZrgF/fTMeRbB/c/
         B5XDyRAJywtYloTFvbDYDndZj9TuXt87AJRytD+skz5yLzULorW6HPe4VlOKWRCXAGSz
         q6qfb+tuidzGoo2LxVcAdqhSINLbiE6U97p2ReRcudGyKdCwRW9wlXT8j03CHkPqGwcz
         5YKg==
X-Forwarded-Encrypted: i=1; AJvYcCWl3VsO3XvomhbfwP1gAaPnNO7ixB4OQtpARRUlZJ1sX2/9oyUAlPs9ZsHMlwGT1EpWSKcYZKYWYbiYhkPspkpK4pgDenQHGIMRo1Y0xQ==
X-Gm-Message-State: AOJu0YwA5ZFQLVyStyP1pBhsbyv8gfhMXsdJtkGmvAuQ09FC4sBdZtx2
	E3YM9RNm+xBd0rXisOD6xEs87kKEMEP/DT7xxOF9OwWIPIzufahLApFjg9R++eMqKDZOtmCq5EX
	uEaZwVlwAbt6Rzvr226jZfHabY8nztgf0r5Yojy8c3WEq59H+KHReBj8=
X-Google-Smtp-Source: AGHT+IGxal1IK5WXsozmNjYHSWk6UQm4arNSNM0+XE34coPxtoa/VQPoyRHCC6IT846ZPApk7qV62yTI6SCgeH/pNAly4hRnVze8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:858f:b0:475:2758:9f20 with SMTP id
 it15-20020a056638858f00b0047527589f20mr184172jab.1.1711797210408; Sat, 30 Mar
 2024 04:13:30 -0700 (PDT)
Date: Sat, 30 Mar 2024 04:13:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a77e580614ded85a@google.com>
Subject: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
From: syzbot <syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    928a87efa423 Merge tag 'gfs2-v6.8-fix' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106cc57e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a39546180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b4aa7e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7d66fa7ed5c7/disk-928a87ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b511d64cde0/vmlinux-928a87ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8810588440a2/bzImage-928a87ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trace_9p_client_res include/trace/events/9p.h:146 [inline]
BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 trace_9p_client_res include/trace/events/9p.h:146 [inline]
 p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
 p9_tag_alloc net/9p/client.c:278 [inline]
 p9_client_prepare_req+0x20a/0x1770 net/9p/client.c:641
 p9_client_rpc+0x27e/0x1340 net/9p/client.c:688
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5017 Comm: syz-executor353 Not tainted 6.9.0-rc1-syzkaller-00005-g928a87efa423 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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

