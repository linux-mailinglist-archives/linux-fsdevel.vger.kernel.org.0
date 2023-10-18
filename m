Return-Path: <linux-fsdevel+bounces-706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0137CE962
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 22:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5141281C45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F8A1EB4D;
	Wed, 18 Oct 2023 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aAleQllB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88A3E017
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 20:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1647C433C7;
	Wed, 18 Oct 2023 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1697662139;
	bh=JuWErFM2WrGzAy7+fDdBQTFA8S4wJj0BlJeoUkTkeRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aAleQllBVR74KbuenGmF3jh3LPxow1/kFCOEqYwYErco11/Y21XSj5+o96sTrN77y
	 jVs0vPaUjSDPuS3bO1mwExCOjQ44isZJ0X26nnkO4/6wAtzJdFzIvZNJOIfgz7vdXo
	 LI5MpwObECWOWSHXjQy4aPQgQtQsUFb6siKsf6Sc=
Date: Wed, 18 Oct 2023 13:48:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [syzbot] [mm?] [fs?] general protection fault in folio_flags
Message-Id: <20231018134858.e0c6445045f5f6c3954f6a62@linux-foundation.org>
In-Reply-To: <00000000000085670f060802a9bd@google.com>
References: <00000000000085670f060802a9bd@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 12:29:47 -0700 syzbot <syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2dac75696c6d Add linux-next specific files for 20231018
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13858275680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
> dashboard link: https://syzkaller.appspot.com/bug?extid=1e2648076cadf48ad9a1
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17543ee5680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101f5fe5680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327/disk-2dac7569.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vmlinux-2dac7569.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b738d/bzImage-2dac7569.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com

Thanks.

> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASA
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 5710 Comm: syz-executor155 Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> RIP: 0010:PageTail include/linux/page-flags.h:286 [inline]
> RIP: 0010:folio_flags.constprop.0+0x21/0x150 include/linux/page-flags.h:313
> Code: 84 00 00 00 00 00 0f 1f 00 41 54 55 53 48 89 fb e8 14 2f a4 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 00 01 00 00 48 8b 6b 08 31 ff 83 e5 01 48 89 ee
> RSP: 0018:ffffc90004367968 EFLAGS: 00010247
> RAX: dffffc0000000000 RBX: fffffffffffffffe RCX: ffffffff81b7e126
> RDX: 0000000000000000 RSI: ffffffff81e49d1c RDI: 0000000000000006
> RBP: 0000000020200000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 1ffffffff1976fb9 R12: ffff88801675b900
> R13: ffff888025f9f680 R14: fffffffffffffffe R15: 1ffff9200086cf3d
> FS:  00007f2f2a17c6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2f2a17cd58 CR3: 000000001bfa0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  folio_test_head include/linux/page-flags.h:790 [inline]
>  folio_test_large include/linux/page-flags.h:811 [inline]
>  folio_order include/linux/mm.h:1079 [inline]
>  collapse_pte_mapped_thp+0x42d/0x13b0 mm/khugepaged.c:1512

Vishal, could you please take a look?

>  madvise_collapse+0x875/0xaf0 mm/khugepaged.c:2761
>  madvise_vma_behavior+0x1fe/0x1d00 mm/madvise.c:1086
>  madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1260
>  do_madvise+0x333/0x660 mm/madvise.c:1440
>  __do_sys_madvise mm/madvise.c:1453 [inline]
>  __se_sys_madvise mm/madvise.c:1451 [inline]
>  __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1451
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f2f2a1dc7a9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2f2a17c238 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007f2f2a266318 RCX: 00007f2f2a1dc7a9
> RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
> RBP: 00007f2f2a266310 R08: 00007ffe616d77f7 R09: 00007f2f2a17c6c0
> R10: 0000000000000000 R11: 0000000000000246 R12: b635773f07ebbeef
> R13: 000000000000006e R14: 00007ffe616d7710 R15: 00007ffe616d77f8
>
> ...
>

