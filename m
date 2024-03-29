Return-Path: <linux-fsdevel+bounces-15666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034238914F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 09:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2575285607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286DD481B1;
	Fri, 29 Mar 2024 08:02:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1145974
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699344; cv=none; b=fZtDdixAIIx+DigNoU/YBk+/b0d7ScUAgZyXLFR6MyyujkhmBqZy7lyRM4izr1Z1UQpnxqc6ujskgtvpQk63jm2cRGInJ9HCMBU9LKnwETMEkfzYz43F1HNawRFa7ex5yh4d4aTGsobVUiXLoH6EorthQH9OVo53IX/o9YMv+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699344; c=relaxed/simple;
	bh=l6+5c+ADTS89MXMV2bdFTOT5+OH+d8SoaktMkRZq+r4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y0RyV+RjudwvOOhT17spjBrnZ9hCMZSMz/Uju5AfkONbmBGvAcOE5IHBXk4sHZ5bEJcKAomZ4S9KR9Y8FsBiY/R2BYkxh4XMbHMEWzoZqyXHRYHOR/oDJ/6vrX65ATAr4bhNpNF/fZqhUCoDZ/0pge7Lz07o7njGk+HNk4RV2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf0ebfda8so174024039f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711699342; x=1712304142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnePw+Iu4UT8Cim0LGo0H/yVtv3O4p0fZOyd3SdKm1M=;
        b=weiDlEmlFm+pyme+1WNN0LpComX7lC5U781PgBbQ8pDAS9HwEzlZK4Sa+Db9+BKE2P
         Yav+n2HSP7fg/cDw0xDJbR8spDUKVVKDVYzgJo5W/qOQfoanXJsUc0MIHH8ea5gP/FzK
         6xiDDY+CesswWBOQrJNmxSykuKomUHBOJPV4sptX/HEz4fhiJJrbQ7H8oxyM2dd2sVic
         LuM2nvOIkqnUx+VGyWGT9U2IOVCDDIa9eBef1sZFbsJPwZSx+LoHd2BK9NO48/jiUZwU
         MaMYFgTgVUQk1f8FYwUT9FmWgzso1IFvFb2gwPfxrmNk6MpYjPism+JtTw4VX86pI7Jd
         53/w==
X-Gm-Message-State: AOJu0Yw5ZbEStICyI/I6yRxZlvUUG6YxkGdt8W6XZgM5SFcrvietMVPa
	yvkmyZxtiH7PhPUctEwgJoBYDzvl9LQbLdva6Os+bqioJXt/19bW8Hnj+03g+J2Ho8KdyY8Zp52
	QgBKUYM+tXlHLdHBBAU4VaVTFmTa938UePXTKe2p3raC1PKSoXP3dr10iQA==
X-Google-Smtp-Source: AGHT+IFyuKG80G6WX3fY2i0icB9vjrfJPmTP+AtBeZjcqurwzNhHBAzVe9lR59GfzFiAd5wBqMYCmVMksqbz4SdS+I/sRr9xFCsk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3488:b0:47c:1788:e23 with SMTP id
 t8-20020a056638348800b0047c17880e23mr47052jal.4.1711699342534; Fri, 29 Mar
 2024 01:02:22 -0700 (PDT)
Date: Fri, 29 Mar 2024 01:02:22 -0700
In-Reply-To: <0000000000001c59010612fd7c60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004676d00614c80fab@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_strcasecmp
From: syzbot <syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fa8019180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=e126b819d8187b282d44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105065c6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1034025e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ccde1a19e22/disk-8d025e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45420817e7d9/vmlinux-8d025e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354bdafd8c8f/bzImage-8d025e20.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/417a5560bbaa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in case_fold fs/hfsplus/unicode.c:23 [inline]
BUG: KMSAN: uninit-value in hfsplus_strcasecmp+0x1ca/0x770 fs/hfsplus/unicode.c:47
 case_fold fs/hfsplus/unicode.c:23 [inline]
 hfsplus_strcasecmp+0x1ca/0x770 fs/hfsplus/unicode.c:47
 hfsplus_cat_case_cmp_key+0xde/0x190 fs/hfsplus/catalog.c:26
 hfs_find_rec_by_key+0xb1/0x240 fs/hfsplus/bfind.c:100
 __hfsplus_brec_find+0x26f/0x7b0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:195
 hfsplus_brec_read+0x46/0x1a0 fs/hfsplus/bfind.c:222
 hfsplus_fill_super+0x199e/0x2700 fs/hfsplus/super.c:531
 mount_bdev+0x397/0x520 fs/super.c:1676
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:647
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
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x6e4/0x1000 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 hfsplus_find_init+0x91/0x250 fs/hfsplus/bfind.c:21
 hfsplus_fill_super+0x1688/0x2700 fs/hfsplus/super.c:525
 mount_bdev+0x397/0x520 fs/super.c:1676
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:647
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

CPU: 1 PID: 5017 Comm: syz-executor416 Not tainted 6.9.0-rc1-syzkaller-00061-g8d025e2092e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

