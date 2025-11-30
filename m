Return-Path: <linux-fsdevel+bounces-70284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B7C95594
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 23:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 536C8341B7A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 22:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1A2459E7;
	Sun, 30 Nov 2025 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="sWiL+YLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KGgl7D6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017923D7C2;
	Sun, 30 Nov 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764542830; cv=none; b=EdybFoTa8aGBBh3EIeslb/Tm81fdcNxjwudw22cBHRMOP/I8D9GzQZfT406Lk8lyAEJ0WfT/fDcXJiAdNW6DhJMD/ZAP5/0dSTbGkmMi+RIgUZTRGZy9iP7qOjSZ3+aFQfxLvPdl27DVK3y/UaBqL/+xFaKF8lLXHsKVMs//8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764542830; c=relaxed/simple;
	bh=oYpN62TVW+ylJTErRZVOTyOTE/UtIM7eOXNM1e6VvGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qjHeEq2GHgg8MRqo7HZhDZevR0+tcsjmbgrM98+qNz5TMqBVkYXFl4ZO5nIUSW/Me2RIcv3jdNCoFCKDAkAGnMBLiKriXHWuUo0TN3DkYKP4C+JNeEVZYWgSq4BQjGQ1T6Wsp+JTJnkqX6kmX9lD9bi0jMuqpo8Lxvnn2stI7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=sWiL+YLa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KGgl7D6l; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CF98EC0114;
	Sun, 30 Nov 2025 17:47:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 30 Nov 2025 17:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764542826;
	 x=1764629226; bh=aishogxTrEOPrwTMqyb0SE9lcENAX822Su7XGpvObS0=; b=
	sWiL+YLagEo9NT/jNr3wIObMbfiRXNVsRQyzLgMveRunj2lPmvgH+1aEDcsdOLfy
	szu4QEqaYwW5HBxYdLKx8g1Je9eOiJtzS/oPNsH4niuJv/NVtfo5tCnOUuMCkS6y
	6IyTbfYBAc4P3HJ2kb8GRHsk0WdMTN5MDH1ivvXPtnBqriVQuQacY2IcriQEsRyt
	jF592TSZQQZ31FW49R344tKKFXorqxvpL8rEYQYKvPfSEgaSyT8DNiBpTVC56z5V
	TkSE5TzLAP2jaJoEeesJAK0FqbxTICW+P5fk4ILp2Fv7YK+67oC/sO88lpq7/GyM
	z5aEB5JMJEqeGN73P+thtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764542826; x=
	1764629226; bh=aishogxTrEOPrwTMqyb0SE9lcENAX822Su7XGpvObS0=; b=K
	Ggl7D6lsoQCPvbGEUKgw0/CRZMzvSSpgGCD2RPHULaVYeUv7cFcTBvx/S+jVp+h/
	a39nGr7gEOdqfrnOPgRfzLJVJx1l5RaRcBNGQ8oPNARNQKBFeK1LJiHb2uvfausp
	8SlSxvQLyQplUqZnpHifE2/jyOsMAVL6o16bfz7XNt+G4u5v8jMnbNrhAUG+9Y21
	Udry2KV+wP89TmNCM4p1LqXLBCCqUtV6xToY0Phm57gBpJqTe8EVE1xBz6Hj1388
	23TzTPMYS+8dMsIrT+rOcffFJKjZgmZzPLQbvXZ9RCtKRKbzFasH5BDF28JU8oAF
	Ild35WPyVQK6sFquyyM3g==
X-ME-Sender: <xms:acksaf2A127sRCnaDLU6hg34eJYi9rSE7TRMaOmwyxW7QcavI9mqYg>
    <xme:acksaejvgjDY3QZXNCIbZqbisqwCnUmmm5_dqWj1ygln0HY2El9OQHsUL8Owk7V4s
    fRDnU-ySffFUmJpJFcO_ZMwt-U_FQLWHmN6jfvJqvLzfYThGXbI3Bgj>
X-ME-Received: <xmr:acksaQmSMW6qCZh4jDPOgLDDj1ELocVsJQHRproKAU-wQ1LoeQ2a2sVEsoNq_0q6SZfqFLyvm7AISKeUhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeitdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhepkfffgggfuffvfhevhfgjtgfg
    sehtjeertddtvdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofi
    htmhdrohhrgheqnecuggftrfgrthhtvghrnhepudevuedtjeegvdekheegveekfedvfeek
    gfffvefhudeiheehgfektddtgffgteehnecuffhomhgrihhnpehmrghofihtmhdrohhrgh
    dpkhgvrhhnvghlrdhorhhgpdhshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhg
    ohhoghhlvggrphhishdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughird
    hhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthho
    peifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgurghnthhonh
    esshhinhgrrdgtohhmpdhrtghpthhtohepshihiigsohhtoddvjeejvdejvdehiedvfeej
    vgeisgguugefieegleesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehshiiikhgrlhhlvghrqdgsuhhgshesghhoohhglhgvghhrohhuph
    hsrdgtohhm
X-ME-Proxy: <xmx:acksacYqZ1rvolCrO8StnTsnai-KCkaCo_dKs1bckQQFt1k5qAT2fw>
    <xmx:acksaTFTicRVt9fKredJoSn7QSSzX1I2LvmCOwXMkV0kSTtiUkDoRw>
    <xmx:acksaTZz125t7P_2UqTvvHGd9hmbV2Swp8hTtmMxlsgO6r661S3lNA>
    <xmx:acksafxpJCm5R0kMaZzyNU6dus9AX4aO5vuwmPDJFtb4yrMPaTDhxg>
    <xmx:asksabOriQbmwVz4aowXpnXFXvpYkXSRXPxEgaPHUOLhkqKmUvpPTCw9>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 17:47:03 -0500 (EST)
Message-ID: <7575ac83-1757-4769-aefb-ca92e7bed514@maowtm.org>
Date: Sun, 30 Nov 2025 22:47:02 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fuse?] possible deadlock in __folio_end_writeback
To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, linux-mm@kvack.org, willy@infradead.org,
 Hillf Danton <hdanton@sina.com>
References: <68e583e1.a00a0220.298cc0.0485.GAE@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <68e583e1.a00a0220.298cc0.0485.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all, just for information, I seem to be able to reproduce this
occasionally (have seen it happen on 3 separate occasions) when lockdep is
enabled, but it doesn't seem like there is any mention of this on lore
aside from this syzbot report, hence sending this quick email.

The setup is a QEMU VM using virtiofs exported from the host via virtiofsd
as the guest rootfs.  The guest is running Debian (Docker image extracted
as rootfs).  I'm not sure exactly how to reproduce it, but it seems like
it happens when doing things like "apt update" / "apt install <thing>".
First observed on next-20251031 but now happens in 6.18.0-rc7.

Sometimes the warning is "WARNING: possible irq lock inversion dependency
detected" instead. Console log for this at
https://fileshare.maowtm.org/20251130/lockdep-splat.txt

First few lines:
    ========================================================
    WARNING: possible irq lock inversion dependency detected
    6.18.0-rc7-dev-00007-g3ef6e4434e3a #1 Tainted: G                 N
    --------------------------------------------------------
    swapper/4/0 just changed the state of lock:
    ffff8881030c0880 (&xa->xa_lock#8){-...}-{3:3}, at: __folio_end_writeback (./include/linux/instrumented.h:82 ./include/asm-generic/bitops/instrumented-lock.h:79 ./include/linux/page-flags.h:772 mm/page-writeback.c:2997)
    but this lock took another, HARDIRQ-unsafe lock in the past:
    (&p->sequence){+.-.}-{0:0}

On 10/7/25 22:19, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cbf33b8e0b36 Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a25ee2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b4263e12240e6e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eaea7c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134c4304580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cbf33b8e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/54786e46ef23/vmlinux-cbf33b8e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dd6f88ce083b/bzImage-cbf33b8e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com
> 
> wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
> wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
> =====================================================
> WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> syzkaller #0 Not tainted
> -----------------------------------------------------
> kworker/u4:0/12 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> ffffffff995aa110 (&p->sequence){+.-.}-{0:0}, at: __fprop_add_percpu_max+0x10d/0x210 lib/flex_proportions.c:186
> 
> and this task is already holding:
> ffff888040a24240 (&xa->xa_lock#12){-...}-{3:3}, at: __folio_end_writeback+0x1da/0x950 mm/page-writeback.c:2996
> which would create a new lock dependency:
>  (&xa->xa_lock#12){-...}-{3:3} -> (&p->sequence){+.-.}-{0:0}
> 
> but this new dependency connects a HARDIRQ-irq-safe lock:
>  (&xa->xa_lock#12){-...}-{3:3}
> 
> ... which became HARDIRQ-irq-safe at:
>   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
>   __folio_end_writeback+0x1da/0x950 mm/page-writeback.c:2996
>   folio_end_writeback_no_dropbehind+0x151/0x290 mm/filemap.c:1668
>   folio_end_writeback+0xea/0x220 mm/filemap.c:1694
>   end_bio_bh_io_sync+0xba/0x120 fs/buffer.c:2776
>   blk_update_request+0x57e/0xe60 block/blk-mq.c:998
>   scsi_end_request+0x7c/0x830 drivers/scsi/scsi_lib.c:637
>   scsi_io_completion+0x131/0x390 drivers/scsi/scsi_lib.c:1078
>   ata_qc_complete_multiple+0x1ae/0x280 drivers/ata/libata-sata.c:789
>   ahci_qc_complete drivers/ata/libahci.c:1887 [inline]
>   ahci_handle_port_interrupt+0x3d5/0x610 drivers/ata/libahci.c:1954
>   ahci_port_intr drivers/ata/libahci.c:1965 [inline]
>   ahci_handle_port_intr+0x19f/0x2e0 drivers/ata/libahci.c:1996
>   ahci_single_level_irq_intr+0x9b/0xe0 drivers/ata/libahci.c:2030
>   __handle_irq_event_percpu+0x295/0xab0 kernel/irq/handle.c:203
>   handle_irq_event_percpu kernel/irq/handle.c:240 [inline]
>   handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:257
>   handle_edge_irq+0x23b/0xa10 kernel/irq/chip.c:855
>   generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>   handle_irq arch/x86/kernel/irq.c:254 [inline]
>   call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
>   __common_interrupt+0x141/0x1f0 arch/x86/kernel/irq.c:325
>   common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:318
>   asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
>   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
>   _raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
>   spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>   ata_scsi_queuecmd+0x3f0/0x5c0 drivers/ata/libata-scsi.c:4398
>   scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1626 [inline]
>   scsi_queue_rq+0x1c91/0x2cc0 drivers/scsi/scsi_lib.c:1868
>   blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
>   __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>   blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>   __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
>   blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
>   blk_mq_run_hw_queue+0x404/0x4f0 block/blk-mq.c:2367
>   blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
>   blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
>   __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
>   blk_finish_plug+0x5e/0x90 block/blk-core.c:1252
>   wb_writeback+0xa80/0xaf0 fs/fs-writeback.c:2233
>   wb_check_old_data_flush fs/fs-writeback.c:2301 [inline]
>   wb_do_writeback fs/fs-writeback.c:2354 [inline]
>   wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2382
>   process_one_work kernel/workqueue.c:3263 [inline]
>   process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>   kthread+0x70e/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> to a HARDIRQ-irq-unsafe lock:
>  (&p->sequence){+.-.}-{0:0}
> 
> ... which became HARDIRQ-irq-unsafe at:
> ...
>   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>   do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
>   do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
>   fprop_new_period+0x1a3/0x3a0 lib/flex_proportions.c:74
>   writeout_period+0x8b/0x130 mm/page-writeback.c:615
>   call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>   expire_timers kernel/time/timer.c:1798 [inline]
>   __run_timers kernel/time/timer.c:2372 [inline]
>   __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
>   run_timer_base kernel/time/timer.c:2393 [inline]
>   run_timer_softirq+0x103/0x180 kernel/time/timer.c:2404
>   handle_softirqs+0x283/0x870 kernel/softirq.c:622
>   run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
>   smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
>   kthread+0x70e/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> other info that might help us debug this:
> 
>  Possible interrupt unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&p->sequence);
>                                local_irq_disable();
>                                lock(&xa->xa_lock#12);
>                                lock(&p->sequence);
>   <Interrupt>
>     lock(&xa->xa_lock#12);
> 
>  *** DEADLOCK ***
> 
> 5 locks held by kworker/u4:0/12:
>  #0: ffff888030f92948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
>  #0: ffff888030f92948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
>  #1: ffffc900001e7bc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
>  #1: ffffc900001e7bc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
>  #2: ffff888000a240e0 (&type->s_umount_key#54){.+.+}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:562
>  #3: ffff888040a24638 (&fi->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #3: ffff888040a24638 (&fi->lock){+.+.}-{3:3}, at: fuse_writepages_send fs/fuse/file.c:2089 [inline]
>  #3: ffff888040a24638 (&fi->lock){+.+.}-{3:3}, at: fuse_iomap_writeback_range+0x818/0x1800 fs/fuse/file.c:2150
>  #4: ffff888040a24240 (&xa->xa_lock#12){-...}-{3:3}, at: __folio_end_writeback+0x1da/0x950 mm/page-writeback.c:2996
> 
> the dependencies between HARDIRQ-irq-safe lock and the holding lock:
> -> (&xa->xa_lock#12){-...}-{3:3} {
>    IN-HARDIRQ-W at:
>                     lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>                     _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
>                     __folio_end_writeback+0x1da/0x950 mm/page-writeback.c:2996
>                     folio_end_writeback_no_dropbehind+0x151/0x290 mm/filemap.c:1668
>                     folio_end_writeback+0xea/0x220 mm/filemap.c:1694
>                     end_bio_bh_io_sync+0xba/0x120 fs/buffer.c:2776
>                     blk_update_request+0x57e/0xe60 block/blk-mq.c:998
>                     scsi_end_request+0x7c/0x830 drivers/scsi/scsi_lib.c:637
>                     scsi_io_completion+0x131/0x390 drivers/scsi/scsi_lib.c:1078
>                     ata_qc_complete_multiple+0x1ae/0x280 drivers/ata/libata-sata.c:789
>                     ahci_qc_complete drivers/ata/libahci.c:1887 [inline]
>                     ahci_handle_port_interrupt+0x3d5/0x610 drivers/ata/libahci.c:1954
>                     ahci_port_intr drivers/ata/libahci.c:1965 [inline]
>                     ahci_handle_port_intr+0x19f/0x2e0 drivers/ata/libahci.c:1996
>                     ahci_single_level_irq_intr+0x9b/0xe0 drivers/ata/libahci.c:2030
>                     __handle_irq_event_percpu+0x295/0xab0 kernel/irq/handle.c:203
>                     handle_irq_event_percpu kernel/irq/handle.c:240 [inline]
>                     handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:257
>                     handle_edge_irq+0x23b/0xa10 kernel/irq/chip.c:855
>                     generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>                     handle_irq arch/x86/kernel/irq.c:254 [inline]
>                     call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
>                     __common_interrupt+0x141/0x1f0 arch/x86/kernel/irq.c:325
>                     common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:318
>                     asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
>                     __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
>                     _raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
>                     spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>                     ata_scsi_queuecmd+0x3f0/0x5c0 drivers/ata/libata-scsi.c:4398
>                     scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1626 [inline]
>                     scsi_queue_rq+0x1c91/0x2cc0 drivers/scsi/scsi_lib.c:1868
>                     blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
>                     __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>                     blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>                     __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
>                     blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
>                     blk_mq_run_hw_queue+0x404/0x4f0 block/blk-mq.c:2367
>                     blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
>                     blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
>                     __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
>                     blk_finish_plug+0x5e/0x90 block/blk-core.c:1252
>                     wb_writeback+0xa80/0xaf0 fs/fs-writeback.c:2233
>                     wb_check_old_data_flush fs/fs-writeback.c:2301 [inline]
>                     wb_do_writeback fs/fs-writeback.c:2354 [inline]
>                     wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2382
>                     process_one_work kernel/workqueue.c:3263 [inline]
>                     process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
>                     worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>                     kthread+0x70e/0x8a0 kernel/kthread.c:463
>                     ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>                     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>    INITIAL USE at:
>                    lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
>                    _raw_spin_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:170
>                    spin_lock_irq include/linux/spinlock.h:376 [inline]
>                    shmem_add_to_page_cache+0x72d/0xba0 mm/shmem.c:887
>                    shmem_alloc_and_add_folio+0x846/0xf60 mm/shmem.c:1936
>                    shmem_get_folio_gfp+0x59d/0x1660 mm/shmem.c:2533
>                    shmem_read_folio_gfp+0x8a/0xe0 mm/shmem.c:5931
>                    drm_gem_get_pages+0x223/0xa20 drivers/gpu/drm/drm_gem.c:656
>                    drm_gem_shmem_get_pages_locked+0x201/0x440 drivers/gpu/drm/drm_gem_shmem_helper.c:200
>                    drm_gem_shmem_pin_locked+0x22c/0x460 drivers/gpu/drm/drm_gem_shmem_helper.c:261
>                    drm_gem_shmem_vmap_locked+0x46b/0x790 drivers/gpu/drm/drm_gem_shmem_helper.c:365
>                    drm_gem_vmap_locked drivers/gpu/drm/drm_gem.c:1279 [inline]
>                    drm_gem_vmap+0x10a/0x1d0 drivers/gpu/drm/drm_gem.c:1321
>                    drm_client_buffer_vmap+0x43/0x80 drivers/gpu/drm/drm_client.c:312
>                    drm_fbdev_shmem_driver_fbdev_probe+0x258/0x900 drivers/gpu/drm/drm_fbdev_shmem.c:160
>                    drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1650 [inline]
>                    __drm_fb_helper_initial_config_and_unlock+0x1236/0x18a0 drivers/gpu/drm/drm_fb_helper.c:1830
>                    drm_fbdev_client_hotplug+0x16c/0x230 drivers/gpu/drm/clients/drm_fbdev_client.c:52
>                    drm_client_register+0x172/0x210 drivers/gpu/drm/drm_client.c:141
>                    drm_fbdev_client_setup+0x19f/0x3f0 drivers/gpu/drm/clients/drm_fbdev_client.c:159
>                    drm_client_setup+0x107/0x220 drivers/gpu/drm/clients/drm_client_setup.c:46
>                    vkms_create drivers/gpu/drm/vkms/vkms_drv.c:201 [inline]
>                    vkms_init+0x3e0/0x4b0 drivers/gpu/drm/vkms/vkms_drv.c:221
>                    do_one_initcall+0x233/0x820 init/main.c:1283
>                    do_initcall_level+0x104/0x190 init/main.c:1345
>                    do_initcalls+0x59/0xa0 init/main.c:1361
>                    kernel_init_freeable+0x334/0x4b0 init/main.c:1593
>                    kernel_init+0x1d/0x1d0 init/main.c:1483
>                    ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  }
>  ... key      at: [<ffffffff995cb060>] xa_init_flags.__key+0x0/0x20
> 
> the dependencies between the lock to be acquired
>  and HARDIRQ-irq-unsafe lock:
> -> (&p->sequence){+.-.}-{0:0} {
>    HARDIRQ-ON-W at:
>                     lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>                     do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
>                     do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
>                     fprop_new_period+0x1a3/0x3a0 lib/flex_proportions.c:74
>                     writeout_period+0x8b/0x130 mm/page-writeback.c:615
>                     call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>                     expire_timers kernel/time/timer.c:1798 [inline]
>                     __run_timers kernel/time/timer.c:2372 [inline]
>                     __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
>                     run_timer_base kernel/time/timer.c:2393 [inline]
>                     run_timer_softirq+0x103/0x180 kernel/time/timer.c:2404
>                     handle_softirqs+0x283/0x870 kernel/softirq.c:622
>                     run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
>                     smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
>                     kthread+0x70e/0x8a0 kernel/kthread.c:463
>                     ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>                     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>    IN-SOFTIRQ-W at:
>                     lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>                     do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
>                     do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
>                     fprop_new_period+0x1a3/0x3a0 lib/flex_proportions.c:74
>                     writeout_period+0x8b/0x130 mm/page-writeback.c:615
>                     call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>                     expire_timers kernel/time/timer.c:1798 [inline]
>                     __run_timers kernel/time/timer.c:2372 [inline]
>                     __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
>                     run_timer_base kernel/time/timer.c:2393 [inline]
>                     run_timer_softirq+0x103/0x180 kernel/time/timer.c:2404
>                     handle_softirqs+0x283/0x870 kernel/softirq.c:622
>                     run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
>                     smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
>                     kthread+0x70e/0x8a0 kernel/kthread.c:463
>                     ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>                     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>    INITIAL USE at:
>                    lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>                    do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
>                    do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
>                    fprop_new_period+0x1a3/0x3a0 lib/flex_proportions.c:74
>                    writeout_period+0x8b/0x130 mm/page-writeback.c:615
>                    call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>                    expire_timers kernel/time/timer.c:1798 [inline]
>                    __run_timers kernel/time/timer.c:2372 [inline]
>                    __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
>                    run_timer_base kernel/time/timer.c:2393 [inline]
>                    run_timer_softirq+0x103/0x180 kernel/time/timer.c:2404
>                    handle_softirqs+0x283/0x870 kernel/softirq.c:622
>                    run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
>                    smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
>                    kthread+0x70e/0x8a0 kernel/kthread.c:463
>                    ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>    INITIAL READ USE at:
>                         lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>                         seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
>                         fprop_fraction_percpu+0x170/0x400 lib/flex_proportions.c:155
>                         __wb_calc_thresh+0x119/0x4a0 mm/page-writeback.c:913
>                         wb_bg_dirty_limits mm/page-writeback.c:2130 [inline]
>                         domain_over_bg_thresh mm/page-writeback.c:2144 [inline]
>                         wb_over_bg_thresh+0x154/0x3d0 mm/page-writeback.c:2165
>                         wb_check_background_flush fs/fs-writeback.c:2257 [inline]
>                         wb_do_writeback fs/fs-writeback.c:2355 [inline]
>                         wb_workfn+0xb1c/0xef0 fs/fs-writeback.c:2382
>                         process_one_work kernel/workqueue.c:3263 [inline]
>                         process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
>                         worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>                         kthread+0x70e/0x8a0 kernel/kthread.c:463
>                         ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>                         ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  }
>  ... key      at: [<ffffffff99ac9760>] fprop_global_init.__key.1+0x0/0x20
>  ... acquired at:
>    lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>    seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
>    fprop_fraction_percpu+0x130/0x400 lib/flex_proportions.c:155
>    __fprop_add_percpu_max+0x10d/0x210 lib/flex_proportions.c:186
>    wb_domain_writeout_add mm/page-writeback.c:562 [inline]
>    __wb_writeout_add+0xa5/0x290 mm/page-writeback.c:586
>    __folio_end_writeback+0x4d5/0x950 mm/page-writeback.c:3003
>    folio_end_writeback_no_dropbehind+0x151/0x290 mm/filemap.c:1668
>    folio_end_writeback+0xea/0x220 mm/filemap.c:1694
>    fuse_writepage_finish fs/fuse/file.c:1837 [inline]
>    fuse_send_writepage fs/fuse/file.c:1887 [inline]
>    fuse_flush_writepages+0x6c8/0x900 fs/fuse/file.c:1912
>    fuse_writepages_send fs/fuse/file.c:2091 [inline]
>    fuse_iomap_writeback_range+0x923/0x1800 fs/fuse/file.c:2150
>    iomap_writeback_range fs/iomap/buffered-io.c:1593 [inline]
>    iomap_writeback_folio+0xe72/0x1c80 fs/iomap/buffered-io.c:1718
>    iomap_writepages+0x162/0x2d0 fs/iomap/buffered-io.c:1770
>    fuse_writepages+0x2ad/0x380 fs/fuse/file.c:2220
>    do_writepages+0x32b/0x550 mm/page-writeback.c:2604
>    __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
>    writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:2015
>    __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2086
>    wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2197
>    wb_check_background_flush fs/fs-writeback.c:2267 [inline]
>    wb_do_writeback fs/fs-writeback.c:2355 [inline]
>    wb_workfn+0xb63/0xef0 fs/fs-writeback.c:2382
>    process_one_work kernel/workqueue.c:3263 [inline]
>    process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
>    worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>    kthread+0x70e/0x8a0 kernel/kthread.c:463
>    ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: writeback wb_workfn (flush-0:42)
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
>  check_irq_usage kernel/locking/lockdep.c:2857 [inline]
>  check_prev_add kernel/locking/lockdep.c:3169 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain+0x1f05/0x2140 kernel/locking/lockdep.c:3908
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>  seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
>  fprop_fraction_percpu+0x130/0x400 lib/flex_proportions.c:155
>  __fprop_add_percpu_max+0x10d/0x210 lib/flex_proportions.c:186
>  wb_domain_writeout_add mm/page-writeback.c:562 [inline]
>  __wb_writeout_add+0xa5/0x290 mm/page-writeback.c:586
>  __folio_end_writeback+0x4d5/0x950 mm/page-writeback.c:3003
>  folio_end_writeback_no_dropbehind+0x151/0x290 mm/filemap.c:1668
>  folio_end_writeback+0xea/0x220 mm/filemap.c:1694
>  fuse_writepage_finish fs/fuse/file.c:1837 [inline]
>  fuse_send_writepage fs/fuse/file.c:1887 [inline]
>  fuse_flush_writepages+0x6c8/0x900 fs/fuse/file.c:1912
>  fuse_writepages_send fs/fuse/file.c:2091 [inline]
>  fuse_iomap_writeback_range+0x923/0x1800 fs/fuse/file.c:2150
>  iomap_writeback_range fs/iomap/buffered-io.c:1593 [inline]
>  iomap_writeback_folio+0xe72/0x1c80 fs/iomap/buffered-io.c:1718
>  iomap_writepages+0x162/0x2d0 fs/iomap/buffered-io.c:1770
>  fuse_writepages+0x2ad/0x380 fs/fuse/file.c:2220
>  do_writepages+0x32b/0x550 mm/page-writeback.c:2604
>  __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
>  writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:2015
>  __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2086
>  wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2197
>  wb_check_background_flush fs/fs-writeback.c:2267 [inline]
>  wb_do_writeback fs/fs-writeback.c:2355 [inline]
>  wb_workfn+0xb63/0xef0 fs/fs-writeback.c:2382
>  process_one_work kernel/workqueue.c:3263 [inline]
>  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>  kthread+0x70e/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> [...]

