Return-Path: <linux-fsdevel+bounces-33453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90469B8DD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 10:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78860286E91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E90158D94;
	Fri,  1 Nov 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbr7Nmy1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A1156220;
	Fri,  1 Nov 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730453252; cv=none; b=EPuEKd/taLRzRDdMIZZlm7fuk9LWsRCLu8l2fw5PpMZPIvYicaHodQI8Ufd2G1P7TaNgklSlZoyyaUoZ3Yxh/BmFLK7Fhfv0zacjaFiDT2umpO+ZopfVkUtQ37sgBRul60VAuOtx8QgAE9U3F4WoOonvA9gm6y4728SPRgML7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730453252; c=relaxed/simple;
	bh=vIfMnY0JkCIAyhWqCiZR0RpSQEmHqIzo87NLNuoklGk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FG6ySq2CA5OEOuULPrU6f/sPoIzlKO1yG9QOM5eKSog5kcSuOJuz5tNq4pkI6qpLMJrO3KiidQFvVQo2hUDwkdLeru952wHS0QAH1SPAT+oCvxoaSFji4nibSIcPTRpfZkdESFNel8NDhNN+x8u1AndwKA63Cdaho/KVAylX9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbr7Nmy1; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e6048bc23cso1047467b6e.3;
        Fri, 01 Nov 2024 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730453249; x=1731058049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIfMnY0JkCIAyhWqCiZR0RpSQEmHqIzo87NLNuoklGk=;
        b=bbr7Nmy1hwks5nAfmDITUL3s9lSCUL9Jkrb19AKZpxoGw3pXY7MPPOxGbVeifZxz1i
         aUyywXzVOGbbM7Kxwe+261px2F7H24XAoVpmYq38YjQkbrcgcRXh0nhJI3GU4XKIs+gg
         nd8Yiudp48J4n5sPiAUBOgyhltOumuoQdKQMAqnlyesnWI8mTxyszJwG31PTRiiD1R5z
         88SubsBSbv8xo/1dirTCe9mOmgIIv8CynZXzsR9wOadDLj8SnybkbsC0xxFyqlGoZFBY
         RnC2lMD/pVoRH1qUSBnu4Jy4LTOF/TyM3oYvVQTU2jCCWQkTThefhbGmOxK0559uLaWy
         J/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730453249; x=1731058049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIfMnY0JkCIAyhWqCiZR0RpSQEmHqIzo87NLNuoklGk=;
        b=M4Hktgi4aoupgcRObDa6tiEPkz8UwCmWsz9DRBPJsC6CUJtS/eEym8cHuxlMxCdoxy
         Uzesm23xJoQZ4gWjLB+AMPCfj/cE5QbnlYFHh+ctij7KkHSVvLGMlYSH7o7Dlqz3iiK5
         jIR7YABgx6J4DSFUlKuwh3+67hW6s9oyvQeeJ0uMxsAnlVu3Sf0TSQJ+irHhdmjjK6l5
         r3MMIPaiHGpHydzJ+Dh2XEmv7jTqkblgabj/Wa8aUFOpOoSU9W5V5AUeT7b2wBh7ZHu0
         P8tvqcHMB4tesijqgK0BSi78jLS7PwjTGT5V65UulY7/Gd4WvU7DU02FlZgy0AiMRoPO
         oegw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Xd2HYbM5vPFRym4MtuwOU9hO82C49+zMnAZqhGJSazWnrODHBp6txpoMVGpLkWDGRpYbygIqlrr5uGxU@vger.kernel.org, AJvYcCVydf1VgEn05j99ioO1G3iLxmpkgh4YhtNcy9jLapUzwrgLc55QJb0VSE0olj7Umay+Q2baqwFUipx3@vger.kernel.org, AJvYcCWleCSvAFMyHShRQgCLh+LJYxoX+CrRbHIg9LA4rILwe4PsdtGqYk+dzjsd2PGWw3Lvd1ZVjZwNWUqlewbp@vger.kernel.org
X-Gm-Message-State: AOJu0YzA89TrQSH3+Y4cDDeVaqC5MLyT5mwfL5uE2l9VF/MOtwYlXeTE
	mGSDLu9KTYTJThxX13FAMifzI+ogxu58bxmyux5gpQJP34mZMgPw
X-Google-Smtp-Source: AGHT+IEnw1KGe2Yr+hnMsq1dWAe8G0Pz1BzODKOkH9Nt1iSct2D9op4j5ophqjwd3N20iS/bM4YuZQ==
X-Received: by 2002:a05:6808:1b87:b0:3e6:4f5b:ae87 with SMTP id 5614622812f47-3e64f5bb068mr13279796b6e.47.1730453249109;
        Fri, 01 Nov 2024 02:27:29 -0700 (PDT)
Received: from [10.172.23.36] ([38.207.141.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f9050sm2205376a12.74.2024.11.01.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:27:28 -0700 (PDT)
Message-ID: <73b917c76cff44f3085c79f251d958b1ec6c793a.camel@gmail.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-use-after-free Read in
 xfs_inode_item_push
From: Julian Sun <sunjunchao2870@gmail.com>
To: syzbot <syzbot+1a28995e12fd13faa44e@syzkaller.appspotmail.com>, 
	chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Date: Fri, 01 Nov 2024 17:27:24 +0800
In-Reply-To: <66f5d630.050a0220.38ace9.0002.GAE@google.com>
References: <66f5d630.050a0220.38ace9.0002.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 14:46 -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 11a299a7933e Merge tag 'for-6.12/block-202=
40925' of
> git://..
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1378aaa998000=
0
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3D31f49563bb05c4a8
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D1a28995e12fd13faa44e
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 15.0.6=
, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D164f7627980000
> C reproducer:=C2=A0=C2=A0 https://syzkaller.appspot.com/x/repro.c?x=3D109=
23a80580000
>=20
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/e97035004495/disk-11a299a7.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/0be318a25b1d/vmlinux-11a299a=
7.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/91f17271baa3/bzImage-11a299a=
7.xz
> mounted in repro:
> https://storage.googleapis.com/syzbot-assets/971400d21e6d/mount_0.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+1a28995e12fd13faa44e@syzkaller.appspotmail.com
>=20
> BUG: KASAN: slab-use-after-free in xfs_inode_item_push+0x293/0x2e0
> fs/xfs/xfs_inode_item.c:775
> Read of size 8 at addr ffff8880774cfa70 by task xfsaild/loop2/10928
>=20
> CPU: 1 UID: 0 PID: 10928 Comm: xfsaild/loop2 Not tainted 6.11.0-
> syzkaller-10669-g11a299a7933e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__dump_stack lib/dump_stack.c:94 [inline]
> =C2=A0dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> =C2=A0print_address_description mm/kasan/report.c:377 [inline]
> =C2=A0print_report+0x169/0x550 mm/kasan/report.c:488
> =C2=A0kasan_report+0x143/0x180 mm/kasan/report.c:601
> =C2=A0xfs_inode_item_push+0x293/0x2e0 fs/xfs/xfs_inode_item.c:775
> =C2=A0xfsaild_push_item fs/xfs/xfs_trans_ail.c:395 [inline]
> =C2=A0xfsaild_push fs/xfs/xfs_trans_ail.c:523 [inline]
> =C2=A0xfsaild+0x112a/0x2e00 fs/xfs/xfs_trans_ail.c:705
> =C2=A0kthread+0x2f0/0x390 kernel/kthread.c:389
> =C2=A0ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> =C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> =C2=A0</TASK>
>=20
> Allocated by task 10907:
> =C2=A0kasan_save_stack mm/kasan/common.c:47 [inline]
> =C2=A0kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> =C2=A0unpoison_slab_object mm/kasan/common.c:319 [inline]
> =C2=A0__kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
> =C2=A0kasan_slab_alloc include/linux/kasan.h:247 [inline]
> =C2=A0slab_post_alloc_hook mm/slub.c:4086 [inline]
> =C2=A0slab_alloc_node mm/slub.c:4135 [inline]
> =C2=A0kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
> =C2=A0xfs_inode_item_init+0x33/0xc0 fs/xfs/xfs_inode_item.c:870
> =C2=A0xfs_trans_ijoin+0xeb/0x130 fs/xfs/libxfs/xfs_trans_inode.c:36
> =C2=A0xfs_create+0x8a0/0xf60 fs/xfs/xfs_inode.c:720
> =C2=A0xfs_generic_create+0x5d5/0xf50 fs/xfs/xfs_iops.c:213
> =C2=A0vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
> =C2=A0do_mkdirat+0x264/0x3a0 fs/namei.c:4280
> =C2=A0__do_sys_mkdir fs/namei.c:4300 [inline]
> =C2=A0__se_sys_mkdir fs/namei.c:4298 [inline]
> =C2=A0__x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
> =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> =C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Freed by task 5213:
> =C2=A0kasan_save_stack mm/kasan/common.c:47 [inline]
> =C2=A0kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> =C2=A0kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
> =C2=A0poison_slab_object mm/kasan/common.c:247 [inline]
> =C2=A0__kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
> =C2=A0kasan_slab_free include/linux/kasan.h:230 [inline]
> =C2=A0slab_free_hook mm/slub.c:2343 [inline]
> =C2=A0slab_free mm/slub.c:4580 [inline]
> =C2=A0kmem_cache_free+0x1a2/0x420 mm/slub.c:4682
> =C2=A0xfs_inode_free_callback+0x152/0x1d0 fs/xfs/xfs_icache.c:158
> =C2=A0rcu_do_batch kernel/rcu/tree.c:2567 [inline]
> =C2=A0rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
> =C2=A0handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
> =C2=A0__do_softirq kernel/softirq.c:588 [inline]
> =C2=A0invoke_softirq kernel/softirq.c:428 [inline]
> =C2=A0__irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
> =C2=A0irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
> =C2=A0instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037
> [inline]
> =C2=A0sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1=
037
> =C2=A0asm_sysvec_apic_timer_interrupt+0x1a/0x20
> arch/x86/include/asm/idtentry.h:702
>=20
> The buggy address belongs to the object at ffff8880774cfa40
> =C2=A0which belongs to the cache xfs_ili of size 264
> The buggy address is located 48 bytes inside of
> =C2=A0freed 264-byte region [ffff8880774cfa40, ffff8880774cfb48)
>=20
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
> pfn:0x774cf
> ksm flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff888142abe140 ffffea0001d56080 0000000000000007
> raw: 0000000000000000 00000000000c000c 00000001f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Reclaimable, gfp_mask
> 0x52c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE)
> , pid 5289, tgid 5289 (syz-executor269), ts 76754520423, free_ts
> 21942205490
> =C2=A0set_page_owner include/linux/page_owner.h:32 [inline]
> =C2=A0post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
> =C2=A0prep_new_page mm/page_alloc.c:1545 [inline]
> =C2=A0get_page_from_freelist+0x3039/0x3180 mm/page_alloc.c:3457
> =C2=A0__alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
> =C2=A0alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
> =C2=A0alloc_slab_page+0x6a/0x120 mm/slub.c:2413
> =C2=A0allocate_slab+0x5a/0x2f0 mm/slub.c:2579
> =C2=A0new_slab mm/slub.c:2632 [inline]
> =C2=A0___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
> =C2=A0__slab_alloc+0x58/0xa0 mm/slub.c:3909
> =C2=A0__slab_alloc_node mm/slub.c:3962 [inline]
> =C2=A0slab_alloc_node mm/slub.c:4123 [inline]
> =C2=A0kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4142
> =C2=A0xfs_inode_item_init+0x33/0xc0 fs/xfs/xfs_inode_item.c:870
> =C2=A0xfs_trans_ijoin+0xeb/0x130 fs/xfs/libxfs/xfs_trans_inode.c:36
> =C2=A0xfs_icreate+0x13a/0x1f0 fs/xfs/xfs_inode.c:593
> =C2=A0xfs_symlink+0xa74/0x1230 fs/xfs/xfs_symlink.c:170
> =C2=A0xfs_vn_symlink+0x1f5/0x740 fs/xfs/xfs_iops.c:443
> =C2=A0vfs_symlink+0x137/0x2e0 fs/namei.c:4615
> =C2=A0do_symlinkat+0x222/0x3a0 fs/namei.c:4641
> page last free pid 1 tgid 1 stack trace:
> =C2=A0reset_page_owner include/linux/page_owner.h:25 [inline]
> =C2=A0free_pages_prepare mm/page_alloc.c:1108 [inline]
> =C2=A0free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
> =C2=A0free_contig_range+0x152/0x550 mm/page_alloc.c:6748
> =C2=A0destroy_args+0x8a/0x840 mm/debug_vm_pgtable.c:1017
> =C2=A0debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
> =C2=A0do_one_initcall+0x248/0x880 init/main.c:1269
> =C2=A0do_initcall_level+0x157/0x210 init/main.c:1331
> =C2=A0do_initcalls+0x3f/0x80 init/main.c:1347
> =C2=A0kernel_init_freeable+0x435/0x5d0 init/main.c:1580
> =C2=A0kernel_init+0x1d/0x2b0 init/main.c:1469
> =C2=A0ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> =C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>=20
> Memory state around the buggy address:
> =C2=A0ffff8880774cf900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =C2=A0ffff8880774cf980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff8880774cfa00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0ffff8880774cfa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =C2=A0ffff8880774cfb00: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test

--=20
Julian Sun <sunjunchao2870@gmail.com>

