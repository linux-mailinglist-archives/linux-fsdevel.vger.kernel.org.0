Return-Path: <linux-fsdevel+bounces-69447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABFFC7B3CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535B83A3C9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC2C2FF649;
	Fri, 21 Nov 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M/CsTa0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F3426B760;
	Fri, 21 Nov 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748716; cv=none; b=tQzGXYNw0gvIjcfSdAkbjaupypr8a2qGUdj68q3YAVKOdt8vmucp9C+WE2T2Itv1YgTviUWmmXovmi7aUcFmPkpPwQrM5oGsG6fhqi+NPuCg2SPE5WSz4oJmVHLd2/EYh85qDULoeGhSc/3qt2+3SDoLwm9Qy/5+RxXaY41H/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748716; c=relaxed/simple;
	bh=Wa6xClv8NW0RAE33MZq89ApNXSfdBaddC/8F/noLinQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TnaD20O6QwnBnOaYs93Odd9Rx6utPp/ulHuQFK8shC6E1Y1vWUSXzkYLhM/J+C5Qc8VazHlAhOozdr3YEltM0faqqHbX4Pol69TVTl96/6pNMZBKEcFdJ4gveN61yDAgWGfP5s827fk+EBp6FWTCHhDJsft/w6Uoa12XsiFEOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M/CsTa0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B059C4CEF1;
	Fri, 21 Nov 2025 18:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763748716;
	bh=Wa6xClv8NW0RAE33MZq89ApNXSfdBaddC/8F/noLinQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/CsTa0TIFq6NUTlvuUwELOxq0/VnZ0IHmeC3vw88+1rL+NhflZn7WYZRE5SKyI/n
	 Tcj/gN9DyEoqzcp1LE+TKL1Tnn7bupc7UuF78MkSf6J2HjjmQdai/VgrGxLCM5GqeL
	 MC26UxPW2MYoFOY2rWVweKReidfkr+UPiaSiXIXk=
Date: Fri, 21 Nov 2025 10:11:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [ext4?] WARNING in __folio_mark_dirty (3)
Message-Id: <20251121101155.173d63bd6611cd3c4aa22cf9@linux-foundation.org>
In-Reply-To: <691f44bb.a70a0220.2ea503.0032.GAE@google.com>
References: <691f44bb.a70a0220.2ea503.0032.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 08:41:31 -0800 syzbot <syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    23cb64fb7625 Merge tag 'soc-fixes-6.18-3' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1287997c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=38a0c4cddc846161
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172cd658580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15378484580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a14ebce6c664/disk-23cb64fb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7703c3032e2f/vmlinux-23cb64fb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a16c5b94924d/bzImage-23cb64fb.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4fa9525269b6/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11d42a12580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com

Thanks.

: void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
: 			     int warn)
: {
: 	unsigned long flags;
: 
: 	/*
: 	 * Shmem writeback relies on swap, and swap writeback is LRU based,
: 	 * not using the dirty mark.
: 	 */
: 	VM_WARN_ON_ONCE(folio_test_swapcache(folio) || shmem_mapping(mapping));
: 
: 	xa_lock_irqsave(&mapping->i_pages, flags);
: 	if (folio->mapping) {	/* Race with truncate? */
: 		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));

this

: 		folio_account_dirtied(folio, mapping);
: 		__xa_set_mark(&mapping->i_pages, folio->index,
: 			      PAGECACHE_TAG_DIRTY);
: 	}
: 	xa_unlock_irqrestore(&mapping->i_pages, flags);
: }

I'm guessing that ext4 permitted a non-uptodate folio to find its way
into the blockdev mapping then the pagefault code tried to modify it
and got upset.


> EXT4-fs error (device loop0): ext4_ext_remove_space:2955: inode #15: comm syz.0.51: pblk 0 bad header/extent: invalid extent entries - magic f30a, entries 2, max 4(4), depth 0(0)
> EXT4-fs error (device loop0) in ext4_setattr:6050: Corrupt filesystem
> EXT4-fs error (device loop0): ext4_validate_block_bitmap:441: comm syz.0.51: bg 0: block 112: padding at end of block bitmap is not set
> EXT4-fs error (device loop0): ext4_map_blocks:778: inode #15: block 3: comm syz.0.51: lblock 3 mapped to illegal pblock 3 (length 1)
> EXT4-fs error (device loop0): ext4_ext_remove_space:2955: inode #15: comm syz.0.51: pblk 0 bad header/extent: invalid extent entries - magic f30a, entries 2, max 4(4), depth 0(0)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6107 at mm/page-writeback.c:2716 __folio_mark_dirty+0x1fb/0xe20 mm/page-writeback.c:2716
> Modules linked in:
> CPU: 0 UID: 0 PID: 6107 Comm: syz.0.51 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:__folio_mark_dirty+0x1fb/0xe20 mm/page-writeback.c:2716
> Code: 3c 38 00 74 08 48 89 df e8 52 a7 26 00 4c 8b 33 4c 89 f6 48 83 e6 08 31 ff e8 d1 ed c4 ff 49 83 e6 08 75 1c e8 66 e8 c4 ff 90 <0f> 0b 90 eb 16 e8 5b e8 c4 ff e9 7e 07 00 00 e8 51 e8 c4 ff eb 05
> RSP: 0018:ffffc90003a079d0 EFLAGS: 00010293
> RAX: ffffffff81f9c4ea RBX: ffffea0001213400 RCX: ffff888025260000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffff94000242681 R12: ffff8880416cb4f0
> R13: ffff8880416cb4e8 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000555587ebe500(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000440 CR3: 000000002e288000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  block_dirty_folio+0x17a/0x1d0 fs/buffer.c:754
>  fault_dirty_shared_page+0x103/0x570 mm/memory.c:3519
>  wp_page_shared mm/memory.c:3906 [inline]
>  do_wp_page+0x263e/0x4930 mm/memory.c:4109
>  handle_pte_fault mm/memory.c:6211 [inline]
>  __handle_mm_fault mm/memory.c:6336 [inline]
>  handle_mm_fault+0x97c/0x3400 mm/memory.c:6505
>  do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
>  handle_page_fault arch/x86/mm/fault.c:1476 [inline]
>  exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
> RIP: 0033:0x7f385fe87398
> Code: fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 66 0f 1f 84 00 00 00 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 c5 fe 6f 54 16 e0 c5 fe 6f 5c 16 c0 c5
> RSP: 002b:00007ffd3b8738f8 EFLAGS: 00010246
> RAX: 0000200000000440 RBX: 0000000000000004 RCX: 0030656c69662f2e
> RDX: 0000000000000008 RSI: 0030656c69662f2e RDI: 0000200000000440
> RBP: 0000000000000000 R08: 0000001b2d820000 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000009 R12: 00007f3860115fac
> R13: 00007f3860115fa0 R14: fffffffffffffffe R15: 0000000000000004
>  </TASK>


