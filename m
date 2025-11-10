Return-Path: <linux-fsdevel+bounces-67642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B629EC458C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EB73B444A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139892FE592;
	Mon, 10 Nov 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeTpOANL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAH1FF64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6538212560;
	Mon, 10 Nov 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766001; cv=none; b=k8hAytAMKSf9Mke/j4NH6A665Xt04ISarTLSE53qGtagEhX2J9PgjYoB631uwtsDSi2nRVjlsP2L9qJQydXQSNlYbQUGxY/LMOAqZYGaaKA4S1TjwMAHMvY0VyJ5ZpuxnBJuqLT+pBectYmIeWhtnreYiuGLc7cbr/UYZNKW700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766001; c=relaxed/simple;
	bh=HoHGOdSj7bTFhoiT0pF3v/Oy7LXbjZm8k5NEe753yd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sa4rfaqJ4NR+AaLNP7qCeRP9DLSqY1Ud6rrY6KZUXF9xDcM1omO6x1cDpckvtpj5gWWA3PR5dNSXA64RtGMMo+OC7BMbrf0DTMLtZKL6ihwJkJ6QpKtXGgVZv16xF9Y165RT3Jn4H1wrvywX4ZMEFX6lBnr40ikrBhGkxhWLyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeTpOANL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAH1FF64; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762765998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWYulQfR0TreZlqe/qFy/nUmcaT6X+aYnci2sC0M8+s=;
	b=IeTpOANLyUhi255Pz3g+GevA/LeLToFvR9GF2uEztHAPEeKnyegJT3Hx3QBbSw6VWL+pCX
	KPmV+FYcX4exu56pt2rFkK9IVBVptW6wt88fQE/voW9NljT+MUXz4q1quD3uhoiaxmOvDZ
	kW1IIDMpoHlwWkc7+o4msV5t9Pb8rScnkzWoNd8ZeEtkcdpkAk6bA6X6QhPQNHeFyyucR5
	LBLBwFz3cMuMKC6TCHnNCi5qTU8UwAKD2BbzxBom5/9H4XmT8FQpz9d3d3E7i2le3FHHUx
	djBrKgBBegfnxGC7fpOzxx1qO6r3Hu1XnnsQY2upt8YdYK2VfC8a/O2WlymhJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762765998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWYulQfR0TreZlqe/qFy/nUmcaT6X+aYnci2sC0M8+s=;
	b=oAH1FF64UEij1BWuPu1puzZO5DMShnO2Ri9sQ+M46IzSSjZp9jXlTuVFsi3DBPswFcgpav
	x7YvoAmfFmu0DdDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, "amurray @ thegoodpenguin . co .
 uk" <amurray@thegoodpenguin.co.uk>, brauner@kernel.org, chao@kernel.org,
 djwong@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] printk_ringbuffer: Fix check of valid data size
 when blk_lpos overflows
In-Reply-To: <20251107194720.1231457-2-pmladek@suse.com>
References: <20251107194720.1231457-1-pmladek@suse.com>
 <20251107194720.1231457-2-pmladek@suse.com>
Date: Mon, 10 Nov 2025 10:19:17 +0106
Message-ID: <87ms4uuu6q.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-07, Petr Mladek <pmladek@suse.com> wrote:
> The commit 67e1b0052f6bb8 ("printk_ringbuffer: don't needlessly wrap
> data blocks around") allows to use the last 4 bytes of the ring buffer.
>
> But the check for the @data_size was not properly updated in get_data().
> It fails when "blk_lpos->next" overflows to "0". In this case:
>
>   + is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)
>     returns "false" because it checks "blk_lpos->next - 1".
>
>   + "blk_lpos->begin < blk_lpos->next" fails because "blk_lpos->next"
>     is already 0.
>
>   + is_blk_wrapped(data_ring, blk_lpos->begin + DATA_SIZE(data_ring),
>     blk_lpos->next) returns "false" because "begin_lpos" is from
>     the next wrap but "next_lpos - 1" is from the previous one.
>
> As a result, get_data() triggers the WARN_ON_ONCE() for "Illegal
> block description", for example:
>
> [  216.317316][ T7652] loop0: detected capacity change from 0 to 16
> ** 1 printk messages dropped **
> [  216.327750][ T7652] ------------[ cut here ]------------
> [  216.327789][ T7652] WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840, CPU#1: syz.0.585/7652
> [  216.327848][ T7652] Modules linked in:
> [  216.327907][ T7652] CPU: 1 UID: 0 PID: 7652 Comm: syz.0.585 Not tainted syzkaller #0 PREEMPT(full)
> [  216.327933][ T7652] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> [  216.327953][ T7652] RIP: 0010:get_data+0x48a/0x840
> [  216.327986][ T7652] Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 a7 19 1f 00 90 <0f> 0b 90 eb 05 e8 9c 19 1f 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
> [  216.328007][ T7652] RSP: 0018:ffffc900035170e0 EFLAGS: 00010293
> [  216.328029][ T7652] RAX: ffffffff81a1eee9 RBX: 00003fffffffffff RCX: ffff888033255b80
> [  216.328048][ T7652] RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
> [  216.328063][ T7652] RBP: 0000000000000012 R08: 0000000000000e55 R09: 000000325e213cc7
> [  216.328079][ T7652] R10: 000000325e213cc7 R11: 00001de4c2000037 R12: 0000000000000012
> [  216.328095][ T7652] R13: 0000000000000000 R14: ffffc90003517228 R15: 1ffffffff1bca646
> [  216.328111][ T7652] FS:  00007f44eb8da6c0(0000) GS:ffff888125fda000(0000) knlGS:0000000000000000
> [  216.328131][ T7652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  216.328147][ T7652] CR2: 00007f44ea9722e0 CR3: 0000000066344000 CR4: 00000000003526f0
> [  216.328168][ T7652] Call Trace:
> [  216.328178][ T7652]  <TASK>
> [  216.328199][ T7652]  _prb_read_valid+0x672/0xa90
> [  216.328328][ T7652]  ? desc_read+0x1b8/0x3f0
> [  216.328381][ T7652]  ? __pfx__prb_read_valid+0x10/0x10
> [  216.328422][ T7652]  ? panic_on_this_cpu+0x32/0x40
> [  216.328450][ T7652]  prb_read_valid+0x3c/0x60
> [  216.328482][ T7652]  printk_get_next_message+0x15c/0x7b0
> [  216.328526][ T7652]  ? __pfx_printk_get_next_message+0x10/0x10
> [  216.328561][ T7652]  ? __lock_acquire+0xab9/0xd20
> [  216.328595][ T7652]  ? console_flush_all+0x131/0xb10
> [  216.328621][ T7652]  ? console_flush_all+0x478/0xb10
> [  216.328648][ T7652]  console_flush_all+0x4cc/0xb10
> [  216.328673][ T7652]  ? console_flush_all+0x131/0xb10
> [  216.328704][ T7652]  ? __pfx_console_flush_all+0x10/0x10
> [  216.328748][ T7652]  ? is_printk_cpu_sync_owner+0x32/0x40
> [  216.328781][ T7652]  console_unlock+0xbb/0x190
> [  216.328815][ T7652]  ? __pfx___down_trylock_console_sem+0x10/0x10
> [  216.328853][ T7652]  ? __pfx_console_unlock+0x10/0x10
> [  216.328899][ T7652]  vprintk_emit+0x4c5/0x590
> [  216.328935][ T7652]  ? __pfx_vprintk_emit+0x10/0x10
> [  216.328993][ T7652]  _printk+0xcf/0x120
> [  216.329028][ T7652]  ? __pfx__printk+0x10/0x10
> [  216.329051][ T7652]  ? kernfs_get+0x5a/0x90
> [  216.329090][ T7652]  _erofs_printk+0x349/0x410
> [  216.329130][ T7652]  ? __pfx__erofs_printk+0x10/0x10
> [  216.329161][ T7652]  ? __raw_spin_lock_init+0x45/0x100
> [  216.329186][ T7652]  ? __init_swait_queue_head+0xa9/0x150
> [  216.329231][ T7652]  erofs_fc_fill_super+0x1591/0x1b20
> [  216.329285][ T7652]  ? __pfx_erofs_fc_fill_super+0x10/0x10
> [  216.329324][ T7652]  ? sb_set_blocksize+0x104/0x180
> [  216.329356][ T7652]  ? setup_bdev_super+0x4c1/0x5b0
> [  216.329385][ T7652]  get_tree_bdev_flags+0x40e/0x4d0
> [  216.329410][ T7652]  ? __pfx_erofs_fc_fill_super+0x10/0x10
> [  216.329444][ T7652]  ? __pfx_get_tree_bdev_flags+0x10/0x10
> [  216.329483][ T7652]  vfs_get_tree+0x92/0x2b0
> [  216.329512][ T7652]  do_new_mount+0x302/0xa10
> [  216.329537][ T7652]  ? apparmor_capable+0x137/0x1b0
> [  216.329576][ T7652]  ? __pfx_do_new_mount+0x10/0x10
> [  216.329605][ T7652]  ? ns_capable+0x8a/0xf0
> [  216.329637][ T7652]  ? kmem_cache_free+0x19b/0x690
> [  216.329682][ T7652]  __se_sys_mount+0x313/0x410
> [  216.329717][ T7652]  ? __pfx___se_sys_mount+0x10/0x10
> [  216.329836][ T7652]  ? do_syscall_64+0xbe/0xfa0
> [  216.329869][ T7652]  ? __x64_sys_mount+0x20/0xc0
> [  216.329901][ T7652]  do_syscall_64+0xfa/0xfa0
> [  216.329932][ T7652]  ? lockdep_hardirqs_on+0x9c/0x150
> [  216.329964][ T7652]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  216.329988][ T7652]  ? clear_bhb_loop+0x60/0xb0
> [  216.330017][ T7652]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  216.330040][ T7652] RIP: 0033:0x7f44ea99076a
> [  216.330080][ T7652] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> [  216.330100][ T7652] RSP: 002b:00007f44eb8d9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [  216.330128][ T7652] RAX: ffffffffffffffda RBX: 00007f44eb8d9ef0 RCX: 00007f44ea99076a
> [  216.330146][ T7652] RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f44eb8d9eb0
> [  216.330164][ T7652] RBP: 0000200000000180 R08: 00007f44eb8d9ef0 R09: 0000000000000000
> [  216.330181][ T7652] R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000001c0
> [  216.330196][ T7652] R13: 00007f44eb8d9eb0 R14: 00000000000001a1 R15: 0000200000000080
> [  216.330233][ T7652]  </TASK>
>
> Solve the problem by moving and fixing the sanity check. The problematic
> if-else-if-else code will just distinguish three basic scenarios:
> "regular" vs. "wrapped" vs. "too many times wrapped" block.
>
> The new sanity check is more precise. A valid "data_size" must be
> lower than half of the data buffer size. Also it must not be zero at
> this stage. It allows to catch problematic "data_size" even for wrapped
> blocks.
>
> Closes: https://lore.kernel.org/all/69096836.a70a0220.88fb8.0006.GAE@google.com/
> Closes: https://lore.kernel.org/all/69078fb6.050a0220.29fc44.0029.GAE@google.com/
> Fixes: 67e1b0052f6bb82 ("printk_ringbuffer: don't needlessly wrap data blocks around")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
Tested-by: John Ogness <john.ogness@linutronix.de>

