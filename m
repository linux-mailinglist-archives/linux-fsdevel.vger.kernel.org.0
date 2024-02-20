Return-Path: <linux-fsdevel+bounces-12170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC7985C2EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A501F23AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23C077632;
	Tue, 20 Feb 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MaYQDkcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2076C73;
	Tue, 20 Feb 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451122; cv=none; b=H4GFFSDxHbNfHGxYKFyeE4qwjDAE+cP+UYfYtv7Ahfm32Mp/PKwvkAeWzZO66RKMu8IcDfajHqmURxMHW8VSqFMS591jsSdjSV5ZTSoBq40JlnWB9/r+I8Z17C2hRRNAzK8R3MMldNTTOo4mjC5AIUKZzokWP7IvtaQNgjHiEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451122; c=relaxed/simple;
	bh=MyPFSOYlBjy3h+mEouuawhBTwAboC4Jd26CDCvKS1uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXfx/19ZbLaGnCbn+uULDJB8xlFZ5HnPpNqGeUfl9VmPJXk7Enu4SiltREv5D4+oOVrXMOOoNPnSO+YzME6CXHd7Jauza7eXo2JD34XxaH2ZTeIxyUqLYVCYl+fh6i1RO1i6gTw0KWx2GZDmGuQEDgWFoYKA4zGyKNHFzsXwR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MaYQDkcN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yhTeaGLn9EDLoAkiXoHfAJ3YFGzXQgVsFIuBWC5G4b8=; b=MaYQDkcN/b7E41oAuhVQ6S/Cfc
	eg7gBOgem8NGzRf2XDbo354+XDIORH8+dQjq/AD+J1QQFd9sn1iOm+d4F4edsl4pK4W3pOKlrfEE3
	8znTLDWJ3ytKlIezXi4X8irYA77RwIHwQDHfM8Mrlb3Jeoe4HR49Lqr/nzciC5jFAPaQ37s63MZPO
	rJ7U8xDDA/prBqMrJ2OuEAyqsyBrz6AIjPLjVAdMm2FzaQo7Wsii5h9Jb0wieQts/pQBdL0xP47HA
	kcdvK6h+srHXMyXHPvdm5RDZzniLWFujoslAGiZCue0wrqUpkKrKgeQgBcaDsGiKu0sHAC785t5d1
	PmQ7l3oA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcUBD-0000000Fh4o-2iKG;
	Tue, 20 Feb 2024 17:45:19 +0000
Date: Tue, 20 Feb 2024 09:45:19 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] test_xarray: fix soft lockup for advanced-api tests
Message-ID: <ZdTlL3UvlyrfpBlt@bombadil.infradead.org>
References: <20240216194329.840555-1-mcgrof@kernel.org>
 <20240219182808.726500bf3546b49ac05d98d4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219182808.726500bf3546b49ac05d98d4@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 19, 2024 at 06:28:08PM -0800, Andrew Morton wrote:
> On Fri, 16 Feb 2024 11:43:29 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > The new adanced API tests
> 
> So this is a fix against the mm-unstable series "test_xarray: advanced
> API multi-index tests", v2.

Yes.

> > want to vet the xarray API is doing what it
> > promises by manually iterating over a set of possible indexes on its
> > own, and using a query operation which holds the RCU lock and then
> > releases it. So it is not using the helper loop options which xarray
> > provides on purpose. Any loop which iterates over 1 million entries
> > (which is possible with order 20, so emulating say a 4 GiB block size)
> > to just to rcu lock and unlock will eventually end up triggering a soft
> > lockup on systems which don't preempt, and have lock provin and RCU
> > prooving enabled.
> > 
> > xarray users already use XA_CHECK_SCHED for loops which may take a long
> > time, in our case we don't want to RCU unlock and lock as the caller
> > does that already, but rather just force a schedule every XA_CHECK_SCHED
> > iterations since the test is trying to not trust and rather test that
> > xarray is doing the right thing.
> > 
> > [0] https://lkml.kernel.org/r/202402071613.70f28243-lkp@intel.com
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> As the above links shows, this should be
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202402071613.70f28243-lkp@intel.com

Thanks, yes...

> > --- a/lib/test_xarray.c
> > +++ b/lib/test_xarray.c
> > @@ -781,6 +781,7 @@ static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
> >  {
> >  	XA_STATE(xas, xa, index);
> >  	void *p;
> > +	static unsigned int i = 0;
> 
> I don't think this needs static storage.

Actually it does, without it the schedule never happens and produces the
soft lockup in the splat below.:

> PetPeeve: it is unexpected that `i' has unsigned type.  Can a more
> communicative identifier be used?

Sure,

The static however is needed otherwise we end up with:

Feb 20 14:37:09 small kernel: Linux version 6.8.0-rc4-next-20240212+ (mcgrof@deb-101020-bm01) (gcc (Debian 13.2.0-4) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41) #23 SMP PREEMPT_DYNAMIC Tue Feb 20 14:34:35 UTC 2024
Feb 20 14:37:09 small kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.8.0-rc4-next-20240212+ root=UUID=79e12315-47fe-462c-b69d-270b4fa13487 ro console=tty0 console=tty1 console=ttyS0,115200n8 elevator=noop scsi_mod.use_blk_mq=Y net.ifnames=0 biosdevname=0
Feb 20 14:37:09 small kernel: BIOS-provided physical RAM map:
Feb 20 14:37:09 small kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable

...

Feb 20 14:37:09 small kernel: Freeing initrd memory: 95720K
Feb 20 14:37:09 small kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
Feb 20 14:37:09 small kernel: io scheduler mq-deadline registered

...

And the soft lockup:

Feb 20 14:37:09 small kernel: watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [swapper/0:1]
Feb 20 14:37:09 small kernel: Modules linked in:
Feb 20 14:37:09 small kernel: irq event stamp: 1786208
Feb 20 14:37:09 small kernel: hardirqs last  enabled at (1786207): [<ffffffff839633c4>] _raw_spin_unlock_irq+0x24/0x50
Feb 20 14:37:09 small kernel: hardirqs last disabled at (1786208): [<ffffffff8394aafa>] sysvec_apic_timer_interrupt+0xa/0xc0
Feb 20 14:37:09 small kernel: softirqs last  enabled at (1786198): [<ffffffff82e96746>] __irq_exit_rcu+0x76/0xd0
Feb 20 14:37:09 small kernel: softirqs last disabled at (1786193): [<ffffffff82e96746>] __irq_exit_rcu+0x76/0xd0
Feb 20 14:37:09 small kernel: CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-next-20240212+ #23
Feb 20 14:37:09 small kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Feb 20 14:37:09 small kernel: RIP: 0010:lock_is_held_type+0xee/0x120
Feb 20 14:37:09 small kernel: Code: 77 da f2 83 e8 83 0b 00 00 b8 ff ff ff ff 65 0f c1 05 6e 21 6d 7c 83 f8 01 75 20 41 f7 c7 00 02 00 00 74 06 fb 0f 1f 44 00 00 <5b> 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 31 ed eb c2 0f 0b 48 c7 c7
Feb 20 14:37:09 small kernel: RSP: 0000:ffffbf4400017d48 EFLAGS: 00000206
Feb 20 14:37:09 small kernel: RAX: 0000000000000001 RBX: ffff9bfe4180ce98 RCX: 0000000000000001
Feb 20 14:37:09 small kernel: RDX: 0000000000000000 RSI: ffffffff83f2da77 RDI: ffffffff83f5c6bf
Feb 20 14:37:09 small kernel: RBP: 0000000000000000 R08: 0000000000000019 R09: 0000000000000019
Feb 20 14:37:09 small kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff84355b38
Feb 20 14:37:09 small kernel: R13: ffff9bfe4180c400 R14: 00000000ffffffff R15: 0000000000000246
Feb 20 14:37:09 small kernel: FS:  0000000000000000(0000) GS:ffff9bfebdc00000(0000) knlGS:0000000000000000
Feb 20 14:37:09 small kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 20 14:37:09 small kernel: CR2: ffff9bfe53601000 CR3: 0000000011e23001 CR4: 0000000000770ef0
Feb 20 14:37:09 small kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Feb 20 14:37:09 small kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Feb 20 14:37:09 small kernel: PKRU: 55555554
Feb 20 14:37:09 small kernel: Call Trace:
Feb 20 14:37:09 small kernel:  <IRQ>
Feb 20 14:37:09 small kernel:  ? watchdog_timer_fn+0x271/0x310
Feb 20 14:37:09 small kernel:  ? softlockup_fn+0x70/0x70
Feb 20 14:37:09 small kernel:  ? __hrtimer_run_queues+0x19e/0x360
Feb 20 14:37:09 small kernel:  ? hrtimer_interrupt+0xfe/0x230
Feb 20 14:37:09 small kernel:  ? __sysvec_apic_timer_interrupt+0x84/0x1d0
Feb 20 14:37:09 small kernel:  ? sysvec_apic_timer_interrupt+0x98/0xc0
Feb 20 14:37:09 small kernel:  </IRQ>
Feb 20 14:37:09 small kernel:  <TASK>
Feb 20 14:37:09 small kernel:  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
Feb 20 14:37:09 small kernel:  ? lock_is_held_type+0xee/0x120
Feb 20 14:37:09 small kernel:  ? lock_is_held_type+0xcd/0x120
Feb 20 14:37:09 small kernel:  xas_descend+0xc9/0x190
Feb 20 14:37:09 small kernel:  xas_load+0x39/0x50
Feb 20 14:37:09 small kernel:  test_get_entry.constprop.0+0x91/0x170
Feb 20 14:37:09 small kernel:  check_xa_multi_store_adv.constprop.0+0x21c/0x4c0
Feb 20 14:37:09 small kernel:  check_multi_store_advanced.constprop.0+0x3a/0x60
Feb 20 14:37:09 small kernel:  ? check_xas_retry.constprop.0+0x9a0/0x9a0
Feb 20 14:37:09 small kernel:  xarray_checks+0x4f/0xe0
Feb 20 14:37:09 small kernel:  do_one_initcall+0x5d/0x350
Feb 20 14:37:09 small kernel:  kernel_init_freeable+0x24d/0x410
Feb 20 14:37:09 small kernel:  ? rest_init+0x190/0x190
Feb 20 14:37:09 small kernel:  kernel_init+0x16/0x1b0
Feb 20 14:37:09 small kernel:  ret_from_fork+0x2d/0x50
Feb 20 14:37:09 small kernel:  ? rest_init+0x190/0x190
Feb 20 14:37:09 small kernel:  ret_from_fork_asm+0x11/0x20
Feb 20 14:37:09 small kernel:  </TASK>
Feb 20 14:37:09 small kernel: watchdog: BUG: soft lockup - CPU#0 stuck for 52s! [swapper/0:1]
Feb 20 14:37:09 small kernel: Modules linked in:
Feb 20 14:37:09 small kernel: irq event stamp: 1838538
Feb 20 14:37:09 small kernel: hardirqs last  enabled at (1838537): [<ffffffff83a00d06>] asm_sysvec_apic_timer_interrupt+0x16/0x20
Feb 20 14:37:09 small kernel: hardirqs last disabled at (1838538): [<ffffffff8394aafa>] sysvec_apic_timer_interrupt+0xa/0xc0
Feb 20 14:37:09 small kernel: softirqs last  enabled at (1838508): [<ffffffff82e96746>] __irq_exit_rcu+0x76/0xd0
Feb 20 14:37:09 small kernel: softirqs last disabled at (1838503): [<ffffffff82e96746>] __irq_exit_rcu+0x76/0xd0
Feb 20 14:37:09 small kernel: CPU: 0 PID: 1 Comm: swapper/0 Tainted: G             L     6.8.0-rc4-next-20240212+ #23
Feb 20 14:37:09 small kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Feb 20 14:37:09 small kernel: RIP: 0010:lock_is_held_type+0xee/0x120
Feb 20 14:37:09 small kernel: Code: 77 da f2 83 e8 83 0b 00 00 b8 ff ff ff ff 65 0f c1 05 6e 21 6d 7c 83 f8 01 75 20 41 f7 c7 00 02 00 00 74 06 fb 0f 1f 44 00 00 <5b> 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 31 ed eb c2 0f 0b 48 c7 c7
Feb 20 14:37:09 small kernel: RSP: 0000:ffffbf4400017d48 EFLAGS: 00000206
Feb 20 14:37:09 small kernel: RAX: 0000000000000001 RBX: ffff9bfe4180ce70 RCX: 0000000000000001
Feb 20 14:37:09 small kernel: RDX: 0000000000000000 RSI: ffffffff83f2da77 RDI: ffffffff83f5c6bf
Feb 20 14:37:09 small kernel: RBP: 0000000000000001 R08: 0000000000000019 R09: 0000000000000019
Feb 20 14:37:09 small kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff842d1040
Feb 20 14:37:09 small kernel: R13: ffff9bfe4180c400 R14: 00000000ffffffff R15: 0000000000000246
Feb 20 14:37:09 small kernel: FS:  0000000000000000(0000) GS:ffff9bfebdc00000(0000) knlGS:0000000000000000
Feb 20 14:37:09 small kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 20 14:37:09 small kernel: CR2: ffff9bfe53601000 CR3: 0000000011e23001 CR4: 0000000000770ef0
Feb 20 14:37:09 small kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Feb 20 14:37:09 small kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Feb 20 14:37:09 small kernel: PKRU: 55555554
Feb 20 14:37:09 small kernel: Call Trace:
Feb 20 14:37:09 small kernel:  <IRQ>
Feb 20 14:37:09 small kernel:  ? watchdog_timer_fn+0x271/0x310
Feb 20 14:37:09 small kernel:  ? softlockup_fn+0x70/0x70
Feb 20 14:37:09 small kernel:  ? __hrtimer_run_queues+0x19e/0x360
Feb 20 14:37:09 small kernel:  ? hrtimer_interrupt+0xfe/0x230
Feb 20 14:37:09 small kernel:  ? __sysvec_apic_timer_interrupt+0x84/0x1d0
Feb 20 14:37:09 small kernel:  ? sysvec_apic_timer_interrupt+0x98/0xc0
Feb 20 14:37:09 small kernel:  </IRQ>
Feb 20 14:37:09 small kernel:  <TASK>
Feb 20 14:37:09 small kernel:  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
Feb 20 14:37:09 small kernel:  ? lock_is_held_type+0xee/0x120
Feb 20 14:37:09 small kernel:  ? lock_is_held_type+0xcd/0x120
Feb 20 14:37:09 small kernel:  xas_descend+0xd6/0x190
Feb 20 14:37:09 small kernel:  xas_load+0x39/0x50
Feb 20 14:37:09 small kernel:  test_get_entry.constprop.0+0x91/0x170
Feb 20 14:37:09 small kernel:  check_xa_multi_store_adv.constprop.0+0x3b1/0x4c0
Feb 20 14:37:09 small kernel:  check_multi_store_advanced.constprop.0+0x3a/0x60
Feb 20 14:37:09 small kernel:  ? check_xas_retry.constprop.0+0x9a0/0x9a0
Feb 20 14:37:09 small kernel:  xarray_checks+0x4f/0xe0
Feb 20 14:37:09 small kernel:  do_one_initcall+0x5d/0x350
Feb 20 14:37:09 small kernel:  kernel_init_freeable+0x24d/0x410
Feb 20 14:37:09 small kernel:  ? rest_init+0x190/0x190
Feb 20 14:37:09 small kernel:  kernel_init+0x16/0x1b0
Feb 20 14:37:09 small kernel:  ret_from_fork+0x2d/0x50
Feb 20 14:37:09 small kernel:  ? rest_init+0x190/0x190
Feb 20 14:37:09 small kernel:  ret_from_fork_asm+0x11/0x20
Feb 20 14:37:09 small kernel:  </TASK>
Feb 20 14:37:09 small kernel: XArray: 148257077 of 148257077 tests passed

  Luis

