Return-Path: <linux-fsdevel+bounces-23108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8ED927487
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 13:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9ACE284860
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B82B157A43;
	Thu,  4 Jul 2024 11:04:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45FA1A2C31
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091058; cv=none; b=AH8poIb3OLPoiRa2JQ4C783MvuehXyHspsFs4TSlwGnwEsaysntghgZNFQoxHiFKJeLHmokyad5zfWUQNkfr5fC279HqOuKawIuPcLdach9aVD/hrtL+ap87yxnpT+/Rg+Qr2ag4Etjq3XhV8pxLkqxdEX20YsaLVn8W/gte2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091058; c=relaxed/simple;
	bh=gYS2whrZY86Kq5/Ysa/GGAOdZHOWk5qsRXJF/IiNlY0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V/LJpjdf6wl+TjEbAdhEzp2Kdn/S+sP28ygx4J2QKQnWSUOQZXMpxAyNO1+GsM0ICf38e33AQHWLKeYgLeDR0N2Dgu2xsCvGpcYJDpTqwkenzLdlwSW4wxxouWFPx3orVkbq6DZtk1ZocaTQxh2dOVyp/yHvhfwcAokTUJl2EcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f59855336cso73750539f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 04:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091056; x=1720695856;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIc8y7SfIQseVVtb2caKhWpDcc0rvRRo+xzgagIpOBQ=;
        b=RjyoLf9GeCOlu7NBugOhSbPA9yOf19QKP1RMmRUn1E/sL7S8etzDDPywP3TDqSlWBE
         TdlNGBokcuf3xb3fSbVeZTFLuET7yME07fOKfRiLzaDudRlTj/noIDyFqt8xzeGnNiY0
         NtBq0FmuaO1PGNNXFnjJYtdQuWjkLwkjAeEK2hd7gAJhnWygv1VMS/rwla0BnHn2mxtS
         lno3KoSaB3ekLwYrrV228O/IIbPfJY+TjcasYDEpVpLQ0MNWpxelp8K77nZYcfTrKmVZ
         FGxahSXY3Biouh3RZAfns3mMFkpai76PKZbIQ1du/sVmfy569dulYLKI2QO4nq7WxrL5
         J3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPeHPk1DtyIaPvFa5g/j+K0MrZ+YLuWb8uDOE/JmBVeOT73yWUQL/hWcblhH02HFT+Zo+p7/gSyinmcPI3ua9tZTaEAUD+tpCtqY18Qg==
X-Gm-Message-State: AOJu0YxWgmznTOfo9BvHaXBCMwmvwFckClUSPvOI8FFaTM/3KLVX5Zaj
	O7i4CTyLGpWoprEfJaR1UFU1SIEbdHNnX1KxFoNw70lbWUgwTuefEurDo2uT0pFdXE7YmYg12fj
	tJ/j/xcTME90LeUo68tnNjDyRH93U419IDchizuJh/b81WXy0Qi7nYCk=
X-Google-Smtp-Source: AGHT+IFeaPd5H1fJzhRGyCJpOUmF0sfxC90youmbetsLBodBTMQDNfXlWodcq3yNZuDvPmc4Y7wFs56GFlgR4MdgtAx1Y4qkgmBr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6086:b0:7f3:a80e:8cec with SMTP id
 ca18e2360f4ac-7f66db5e21amr6845439f.0.1720091055821; Thu, 04 Jul 2024
 04:04:15 -0700 (PDT)
Date: Thu, 04 Jul 2024 04:04:15 -0700
In-Reply-To: <0000000000000538640617a80980@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d2c82061c69e8ca@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: stack-out-of-bounds Read in gfs2_dump_glock
From: syzbot <syzbot+7efd59a5a532c57037e6@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16418635980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e82849980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b55181980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/947727e7be17/disk-795c58e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8898920020bb/vmlinux-795c58e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9aed6052df98/bzImage-795c58e4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7bee2c9df91a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7efd59a5a532c57037e6@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0:  H: s:SH f:H e:0 p:5123 [syz-executor201] iterate_dir+0x57a/0x810 fs/readdir.c:110
==================================================================
BUG: KASAN: stack-out-of-bounds in gfs2_dump_glock+0x15b1/0x1bb0
Read of size 8 at addr ffffc900034a7ca0 by task syz-executor201/5125

CPU: 0 PID: 5125 Comm: syz-executor201 Not tainted 6.10.0-rc6-syzkaller-00069-g795c58e4c7fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 gfs2_dump_glock+0x15b1/0x1bb0
 gfs2_consist_inode_i+0xf5/0x110 fs/gfs2/util.c:457
 gfs2_dirent_scan+0x52b/0x670
 gfs2_dirent_search+0x30e/0x8c0 fs/gfs2/dir.c:853
 gfs2_dir_search+0xb2/0x2f0 fs/gfs2/dir.c:1653
 gfs2_lookupi+0x461/0x5e0 fs/gfs2/inode.c:340
 __gfs2_lookup+0xa4/0x280 fs/gfs2/inode.c:896
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
 lookup_slow+0x53/0x70 fs/namei.c:1709
 walk_component fs/namei.c:2004 [inline]
 link_path_walk+0x9ea/0xea0 fs/namei.c:2331
 path_parentat fs/namei.c:2540 [inline]
 __filename_parentat+0x263/0x6f0 fs/namei.c:2564
 filename_parentat fs/namei.c:2582 [inline]
 filename_create+0xf6/0x540 fs/namei.c:3887
 do_mknodat+0x18b/0x5b0 fs/namei.c:4052
 __do_sys_mknod fs/namei.c:4098 [inline]
 __se_sys_mknod fs/namei.c:4096 [inline]
 __x64_sys_mknod+0x8e/0xa0 fs/namei.c:4096
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc9a7de9779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc9a7d75168 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
RAX: ffffffffffffffda RBX: 00007fc9a7e7d6d8 RCX: 00007fc9a7de9779
RDX: 0000000000000701 RSI: 0000000000000000 RDI: 0000000020000680
RBP: 00007fc9a7e7d6d0 R08: 00007ffc076d7ae7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc9a7e7d6dc
R13: 000000000000006e R14: 00007ffc076d7a00 R15: 00007ffc076d7ae8
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc900034a0000, ffffc900034a9000) created by:
 copy_process+0x5d1/0x3dc0 kernel/fork.c:2220

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802c96fd80 pfn:0x2c96f
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88802c96fd80 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 5106, tgid 5106 (syz-executor201), ts 62007196465, free_ts 61954421151
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 vm_area_alloc_pages mm/vmalloc.c:3575 [inline]
 __vmalloc_area_node mm/vmalloc.c:3651 [inline]
 __vmalloc_node_range_noprof+0x971/0x1460 mm/vmalloc.c:3832
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1115
 copy_process+0x5d1/0x3dc0 kernel/fork.c:2220
 kernel_clone+0x223/0x870 kernel/fork.c:2797
 __do_sys_clone3 kernel/fork.c:3098 [inline]
 __se_sys_clone3+0x2cb/0x350 kernel/fork.c:3082
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5074 tgid 5074 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2588
 discard_slab mm/slub.c:2527 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2995
 put_cpu_partial+0x17c/0x250 mm/slub.c:3070
 __slab_free+0x2ea/0x3d0 mm/slub.c:4308
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4045
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:656
 netlink_sendmsg+0x631/0xcb0 net/netlink/af_netlink.c:1880
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc900034a7b80: 00 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900034a7c00: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 00 00 00
>ffffc900034a7c80: 00 f3 f3 f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00
                               ^
 ffffc900034a7d00: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
 ffffc900034a7d80: 04 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

