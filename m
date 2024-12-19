Return-Path: <linux-fsdevel+bounces-37773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDD39F7293
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 03:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605721696B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 02:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70B82890;
	Thu, 19 Dec 2024 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN9hjwlm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB370809;
	Thu, 19 Dec 2024 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575258; cv=none; b=ZXpaRPL0KgIFgqNjKlwM50e8ju5+f63LiLH+Ufkysn6R8a4Ex5WqWZlxlriNPc2CxANffbu3uj+4mZGqe5IZmz0XPkfU52vzjkZugkVz1uHv54AuewD1My/97QptNfejFZBX7kgcgSt8ezbsNWboVlQq89VujKvxUsuFEqf6fZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575258; c=relaxed/simple;
	bh=bAPbGjzqohXCWnf30HixS7MM1IFIRs6yG/mVWv3E8gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUhvBYeqNWolv+xArBF4sv8ffIoLNcxdes5O2bAegr2fm7PNSuR+LdkyHjTW3oLQv6QSebTuTwerXDGAK/sD2gIjCEzBvUeamyFW2mLElELC5Rq6Sw8SUmkx9rtoaEhEl2Lv5RY488Sos1DmzAbdzLhJDvoH5TLi+kntW5pVEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN9hjwlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CA5C4CECD;
	Thu, 19 Dec 2024 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734575257;
	bh=bAPbGjzqohXCWnf30HixS7MM1IFIRs6yG/mVWv3E8gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WN9hjwlmx0HVdb4YF1Sq3oj3HwrhyUQI+IDlCYmRb6l10BP2p8TewhHz/yW/36pmr
	 q1/+2NLql1wgw6femargLL/rf4Q+ZiKFQC9JHm7DRpbiebO1GchSNvBXANY6xS4Xcp
	 9pk/lwCQz4Mwf+ffx6xWmRasxaX/8e3Hmgpget+YSCPC6tcrSxl7sRX89k0Auvyu+M
	 UjXFuZObfnoXGKmfMfoylih5IGFJ88Av7h63oRo7WZFt7HQ2yUibuGVOgPt78uLJMv
	 2jrMIMwVZlInZKczqxYqEnpP4ku47CZtPvfV1JtVba21KdzM59gA8ZzTzYgV1tLPf8
	 Aci6vSRMIfV5w==
Date: Wed, 18 Dec 2024 18:27:36 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH 0/5] fs/buffer: strack reduction on async read
Message-ID: <Z2OEmALBGB8ARLlc@bombadil.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
 <Z2MrCey3RIBJz9_E@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2MrCey3RIBJz9_E@casper.infradead.org>

On Wed, Dec 18, 2024 at 08:05:29PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 17, 2024 at 06:26:21PM -0800, Luis Chamberlain wrote:
> > This splits up a minor enhancement from the bs > ps device support
> > series into its own series for better review / focus / testing.
> > This series just addresses the reducing the array size used and cleaning
> > up the async read to be easier to read and maintain.
> 
> How about this approach instead -- get rid of the batch entirely?

Less is more! I wish it worked, but we end up with a null pointer on
ext4/032 (and indeed this is the test that helped me find most bugs in
what I was working on):

[  105.942462] loop0: detected capacity change from 0 to 1342177280
[  106.034851] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  106.036903] #PF: supervisor read access in kernel mode
[  106.038366] #PF: error_code(0x0000) - not-present page
[  106.039819] PGD 0 P4D 0
[  106.040574] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  106.041967] CPU: 2 UID: 0 PID: 29 Comm: ksoftirqd/2 Not tainted 6.13.0-rc3+ #42
[  106.044018] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-1 09/18/2024
[  106.046300] RIP: 0010:end_buffer_async_read_io+0x11/0x90
[  106.047819] Code: f2 ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 48 8b 47 10 48 89 fb 48 8b 40 18 <48> 8b 00 f6 40 0d 40 74 0d 0f b7 00 66 25 00 f0 66 3d 00 80 74 09
[  106.053016] RSP: 0018:ffffa85880137dd0 EFLAGS: 00010246
[  106.054499] RAX: 0000000000000000 RBX: ffff95e38f22e5b0 RCX: ffff95e39c8753e0
[  106.056507] RDX: ffff95e3809f8000 RSI: 0000000000000001 RDI: ffff95e38f22e5b0
[  106.058530] RBP: 0000000000000400 R08: ffff95e3a326b040 R09: 0000000000000001
[  106.060546] R10: ffffffffbb6070c0 R11: 00000000002dc6c0 R12: 0000000000000000
[  106.062426] R13: ffff95e3960ea800 R14: ffff95e39586ae40 R15: 0000000000000400
[  106.064223] FS:  0000000000000000(0000) GS:ffff95e3fbc80000(0000) knlGS:0000000000000000
[  106.066155] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.067473] CR2: 0000000000000000 CR3: 00000001226e2006 CR4: 0000000000772ef0
[  106.069085] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  106.070571] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  106.072050] PKRU: 55555554
[  106.072632] Call Trace:
[  106.073176]  <TASK>
[  106.073611]  ? __die_body.cold+0x19/0x26
[  106.074383]  ? page_fault_oops+0xa2/0x230
[  106.075155]  ? __smp_call_single_queue+0xa7/0x110
[  106.076077]  ? do_user_addr_fault+0x63/0x640
[  106.076916]  ? exc_page_fault+0x7a/0x190
[  106.077639]  ? asm_exc_page_fault+0x22/0x30
[  106.078394]  ? end_buffer_async_read_io+0x11/0x90
[  106.079245]  end_bio_bh_io_sync+0x23/0x40
[  106.079973]  blk_update_request+0x178/0x420
[  106.080727]  ? finish_task_switch.isra.0+0x94/0x290
[  106.081600]  blk_mq_end_request+0x18/0x30
[  106.082281]  blk_complete_reqs+0x3d/0x50
[  106.082954]  handle_softirqs+0xf9/0x2c0
[  106.083607]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  106.084393]  run_ksoftirqd+0x37/0x50
[  106.085012]  smpboot_thread_fn+0x184/0x220
[  106.085688]  kthread+0xda/0x110
[  106.086208]  ? __pfx_kthread+0x10/0x10
[  106.086824]  ret_from_fork+0x2d/0x50
[  106.087409]  ? __pfx_kthread+0x10/0x10
[  106.088013]  ret_from_fork_asm+0x1a/0x30
[  106.088658]  </TASK>
[  106.089045] Modules linked in: loop sunrpc 9p nls_iso8859_1 nls_cp437 vfat fat kvm_intel kvm crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd virtio_balloon 9pnet_virtio virtio_console joydev button evdev serio_raw nvme_fabrics nvme_core dm_mod drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod virtio_net net_failover virtio_blk failover crc32_pclmul crc32c_intel psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
[  106.097895] CR2: 0000000000000000
[  106.098326] ---[ end trace 0000000000000000 ]---

  Luis

