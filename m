Return-Path: <linux-fsdevel+bounces-45781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B5A7C109
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C507917C467
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F41FAC5F;
	Fri,  4 Apr 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubHlGEyB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916A1FA859;
	Fri,  4 Apr 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782136; cv=none; b=OUW/Bvvchqn0g7PYdsGEvofuVRRUCLSuRIGzP95cGj5oDoosW8FpUoynNuCphI2lCSJx0KmBexqGFFONsldYBQ9ZCre8Juej1OAtVe+CvQxQmSmPu1iKx3FaCIbVriVKKmdRYNiDViw3cLVGNRMrkWv7/4qGegJT/O3fVkJvCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782136; c=relaxed/simple;
	bh=H0oSTstdUNtg4cUip28ivErWZsiL7Hvn8FBMRy2yATc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwDhapm1XlXGd45T/l7GGq5WSzcFcbjIDj2MKSZ8Ds8eY4aXNdvSwjr+/I3e6aF7aIphYHa1P4kUbTonuiKNnReBFfRT9C++oktjXGY9lrnMnMAad1PeIQsIH5+8FTVCP3+mD7T0xZ5Ydo6eDkyvmhsW37vB7xfUTHTqBRoMHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubHlGEyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2C7C4CEE8;
	Fri,  4 Apr 2025 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743782135;
	bh=H0oSTstdUNtg4cUip28ivErWZsiL7Hvn8FBMRy2yATc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubHlGEyBaVNw0cRZEWuJQOtYjdKJGC/tqCowyDjCBaxtpQB5FacxboGr7qbohqu4/
	 mWDJEI1ybSO//1WH64u693OKkG6iVzrvVAZHtjxA3MSHZYevOLIaRlsdVsHL6T7IQY
	 KVflait1qCEZ40GbJDbWE9+ueGFoILnTg4vywkcJWENPnWg4UR48oOcx+qGouHt4N+
	 VWxxCA8+binv4BexNpQqPLQiqIALypECEJTxFbXSK50HcXrja+a+tebAATxbRlZtTR
	 RNVk8dkB7P18/WoBOBUm0ZRU3IUjNGr8szpbnb4PC/QJg5VVtoBmri3lTZ6WakFspo
	 3YPQxjQpT2FxA==
Date: Fri, 4 Apr 2025 08:55:33 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org, jack@suse.cz, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com,
	dave@stgolabs.net, david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com
Subject: Re: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()
Message-ID: <Z_AA9SHZdRGq6tb4@bombadil.infradead.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
 <Z-rzyrS0Jr7t984Y@bombadil.infradead.org>
 <Z-3EDGCLMtCV-szJ@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-3EDGCLMtCV-szJ@bombadil.infradead.org>

On Wed, Apr 02, 2025 at 04:11:10PM -0700, Luis Chamberlain wrote:
> On Mon, Mar 31, 2025 at 12:58:04PM -0700, Luis Chamberlain wrote:
> > On Sat, Mar 29, 2025 at 11:47:31PM -0700, Luis Chamberlain wrote:
> > > Although we don't have exact traces of the filesystem corruption we
> > > can can reproduce fs corruption one ext4 by just removing the spinlock
> > > and stress testing the filesystem with generic/750, we eventually end
> > > up after 3 hours of testing with kdevops using libvirt on the ext4
> > > profile ext4-4k. Things like the below as reported recently [1]:
> > > 
> > > Mar 28 03:36:37 extra-ext4-4k unknown: run fstests generic/750 at 2025-03-28 03:36:37
> > > <-- etc -->
> > > Mar 28 05:57:09 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5174: comm fsstress: directory missing '.'
> > > Mar 28 06:04:43 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
> > > Mar 28 06:42:05 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
> > > Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
> > 
> > I reproduced again a corruption with ext4 when we remove the spin lock
> > alone with generic/750, the trace looks slightly different, and
> > this time I ran the test with ext4 with 2k block size filesystem. I
> > also reverted both "mm: migrate: remove folio_migrate_copy()" and
> > "mm: migrate: support poisoned recover from migrate folio" just in case
> > the extra check added by the later was helping avoid the corruption.
> 
> Since we didn't have much data over this filesystem corruption I figured
> it would be good to expand on that with more information. I reproduced yet
> again with just generic/750 and the spinlock removed in about ~6 hours:

Here's another for the collection, this one reproduced also on a 2k ext4
filesytem within just an hour, and also runs into "error count since
last fsck":

Apr 02 17:49:49 fix-ext4-2k kernel: Linux version 6.14.0-12248-g87aeaf206469 (mcgrof@beef) (gcc (Debian 14.2.0-6) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #16 SMP PREEMPT_DYNAMIC Wed Apr  2 17:43:14 PDT 2025

<-- snip -->

Apr 02 17:50:50 fix-ext4-2k unknown: run fstests generic/750 at 2025-04-02 17:50:50
Apr 02 17:50:51 fix-ext4-2k kernel: EXT4-fs (loop5): mounted filesystem 2f6642d1-eab9-481a-86b4-dac9cc760f63 r/w with ordered data mode. Quota mode: none.
Apr 02 18:00:45 fix-ext4-2k kernel: NOHZ tick-stop error: local softirq work is pending, handler #10!!!
Apr 02 18:13:27 fix-ext4-2k kernel: NOHZ tick-stop error: local softirq work is pending, handler #10!!!
Apr 02 18:47:36 fix-ext4-2k kernel: ------------[ cut here ]------------
Apr 02 18:47:36 fix-ext4-2k kernel: WARNING: CPU: 4 PID: 2515 at fs/jbd2/transaction.c:1552 jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Apr 02 18:47:36 fix-ext4-2k kernel: Modules linked in: loop sunrpc 9p nls_iso8859_1 nls_cp437 vfat crc32c_generic fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio joydev virtio_console virtio_balloon button evdev serio_raw nvme_fabrics nvme_core dm_mod drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover virtio_blk failover psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Apr 02 18:47:36 fix-ext4-2k kernel: CPU: 4 UID: 0 PID: 2515 Comm: fsstress Not tainted 6.14.0-12248-g87aeaf206469 #16 PREEMPT(full) 
Apr 02 18:47:36 fix-ext4-2k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-2 10/04/2024
Apr 02 18:47:36 fix-ext4-2k kernel: RIP: 0010:jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Apr 02 18:47:36 fix-ext4-2k kernel: Code: 30 0f 84 5b fe ff ff 0f 0b 41 bc 8b ff ff ff e9 69 fe ff ff 48 8b 04 24 4c 8b 48 70 4d 39 cf 0f 84 53 ff ff ff e9 42 c5 00 00 <0f> 0b 41 bc e4 ff ff ff e9 41 ff ff ff 0f 0b 90 0f 1f 40 00 90 90
Apr 02 18:47:36 fix-ext4-2k kernel: RSP: 0018:ffffa464824d77f8 EFLAGS: 00010246
Apr 02 18:47:36 fix-ext4-2k kernel: RAX: 0000000000000001 RBX: ffff95c8866129d8 RCX: 00000000000000fd
Apr 02 18:47:36 fix-ext4-2k kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: RBP: ffff95c88726ac98 R08: ffff95c88726ac98 R09: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: R10: 00000000b2ae40cd R11: 00000000000064a2 R12: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: R13: ffff95c9849e7f88 R14: ffff95c8866129e0 R15: ffff95c986708180
Apr 02 18:47:36 fix-ext4-2k kernel: FS:  00007f230b292740(0000) GS:ffff95ca439cc000(0000) knlGS:0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 02 18:47:36 fix-ext4-2k kernel: CR2: 00007f230b28a000 CR3: 000000012517c003 CR4: 0000000000772ef0
Apr 02 18:47:36 fix-ext4-2k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
Apr 02 18:47:36 fix-ext4-2k kernel: PKRU: 55555554
Apr 02 18:47:36 fix-ext4-2k kernel: Call Trace:
Apr 02 18:47:36 fix-ext4-2k kernel:  <TASK>
Apr 02 18:47:36 fix-ext4-2k kernel:  __ext4_handle_dirty_metadata+0x6d/0x190 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_ext_insert_extent+0x5c1/0x1510 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? ext4_cache_extents+0x5a/0xd0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? ext4_find_extent+0x37c/0x3a0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_ext_map_blocks+0x51e/0x1900 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? mpage_map_and_submit_buffers+0x23f/0x270 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_map_blocks+0x11a/0x4d0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? kmem_cache_alloc_noprof+0x321/0x3e0
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_do_writepages+0x762/0xd40 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? ext4_writepages+0xd7/0x1b0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_writepages+0xd7/0x1b0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  do_writepages+0xdd/0x250
Apr 02 18:47:36 fix-ext4-2k kernel:  ? __call_rcu_common.constprop.0+0x130/0x290
Apr 02 18:47:36 fix-ext4-2k kernel:  ? iter_file_splice_write+0x1d6/0x4f0
Apr 02 18:47:36 fix-ext4-2k kernel:  ? kfree+0x1cc/0x370
Apr 02 18:47:36 fix-ext4-2k kernel:  filemap_fdatawrite_wbc+0x48/0x60
Apr 02 18:47:36 fix-ext4-2k kernel:  __filemap_fdatawrite_range+0x5b/0x80
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_release_file+0x6d/0xa0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  __fput+0xf4/0x2b0
Apr 02 18:47:36 fix-ext4-2k kernel:  __x64_sys_close+0x39/0x80
Apr 02 18:47:36 fix-ext4-2k kernel:  do_syscall_64+0x4b/0x120
Apr 02 18:47:36 fix-ext4-2k kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Apr 02 18:47:36 fix-ext4-2k kernel: RIP: 0033:0x7f230b324687
Apr 02 18:47:36 fix-ext4-2k kernel: Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
Apr 02 18:47:36 fix-ext4-2k kernel: RSP: 002b:00007ffc1efe2bb0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
Apr 02 18:47:36 fix-ext4-2k kernel: RAX: ffffffffffffffda RBX: 00007f230b292740 RCX: 00007f230b324687
Apr 02 18:47:36 fix-ext4-2k kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
Apr 02 18:47:36 fix-ext4-2k kernel: RBP: 00007ffc1efe2c60 R08: 0000000000000000 R09: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: R13: 00007ffc1efe2db0 R14: 00007ffc1efe31b0 R15: 000000000000622d
Apr 02 18:47:36 fix-ext4-2k kernel:  </TASK>
Apr 02 18:47:36 fix-ext4-2k kernel: ---[ end trace 0000000000000000 ]---
Apr 02 18:47:36 fix-ext4-2k kernel: ------------[ cut here ]------------
Apr 02 18:47:36 fix-ext4-2k kernel: WARNING: CPU: 2 PID: 2515 at fs/ext4/ext4_jbd2.c:360 __ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel: Modules linked in: loop sunrpc 9p nls_iso8859_1 nls_cp437 vfat crc32c_generic fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio joydev virtio_console virtio_balloon button evdev serio_raw nvme_fabrics nvme_core dm_mod drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover virtio_blk failover psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Apr 02 18:47:36 fix-ext4-2k kernel: CPU: 2 UID: 0 PID: 2515 Comm: fsstress Tainted: G        W           6.14.0-12248-g87aeaf206469 #16 PREEMPT(full) 
Apr 02 18:47:36 fix-ext4-2k kernel: Tainted: [W]=WARN
Apr 02 18:47:36 fix-ext4-2k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-2 10/04/2024
Apr 02 18:47:36 fix-ext4-2k kernel: RIP: 0010:__ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel: Code: 00 00 00 44 89 fa 4c 89 f6 49 c7 c1 3b 2c aa c0 4c 89 e7 41 bd fb ff ff ff e8 5a ce 05 00 eb 97 48 89 df e8 c0 a4 0a f6 eb 8a <0f> 0b 48 c7 c2 a0 42 a9 c0 45 89 e8 48 89 e9 44 89 fe 4c 89 f7 e8
Apr 02 18:47:36 fix-ext4-2k kernel: RSP: 0018:ffffa464824d7838 EFLAGS: 00010286
Apr 02 18:47:36 fix-ext4-2k kernel: RAX: ffff95c998971800 RBX: ffff95c88726ac98 RCX: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000ffffffff
Apr 02 18:47:36 fix-ext4-2k kernel: RBP: ffff95c9849e7f88 R08: ffff95c88726ac98 R09: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: R10: 00000000b2ae40cd R11: 00000000000064a2 R12: ffff95c999e4c430
Apr 02 18:47:36 fix-ext4-2k kernel: R13: 00000000ffffffe4 R14: ffffffffc0a94760 R15: 0000000000000556
Apr 02 18:47:36 fix-ext4-2k kernel: FS:  00007f230b292740(0000) GS:ffff95ca4394c000(0000) knlGS:0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 02 18:47:36 fix-ext4-2k kernel: CR2: 00007f230b291000 CR3: 000000012517c006 CR4: 0000000000772ef0
Apr 02 18:47:36 fix-ext4-2k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
Apr 02 18:47:36 fix-ext4-2k kernel: PKRU: 55555554
Apr 02 18:47:36 fix-ext4-2k kernel: Call Trace:
Apr 02 18:47:36 fix-ext4-2k kernel:  <TASK>
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_ext_insert_extent+0x5c1/0x1510 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? ext4_cache_extents+0x5a/0xd0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? ext4_find_extent+0x37c/0x3a0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_ext_map_blocks+0x51e/0x1900 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? mpage_map_and_submit_buffers+0x23f/0x270 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_map_blocks+0x11a/0x4d0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? kmem_cache_alloc_noprof+0x321/0x3e0
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_do_writepages+0x762/0xd40 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ? ext4_writepages+0xd7/0x1b0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_writepages+0xd7/0x1b0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  do_writepages+0xdd/0x250
Apr 02 18:47:36 fix-ext4-2k kernel:  ? __call_rcu_common.constprop.0+0x130/0x290
Apr 02 18:47:36 fix-ext4-2k kernel:  ? iter_file_splice_write+0x1d6/0x4f0
Apr 02 18:47:36 fix-ext4-2k kernel:  ? kfree+0x1cc/0x370
Apr 02 18:47:36 fix-ext4-2k kernel:  filemap_fdatawrite_wbc+0x48/0x60
Apr 02 18:47:36 fix-ext4-2k kernel:  __filemap_fdatawrite_range+0x5b/0x80
Apr 02 18:47:36 fix-ext4-2k kernel:  ext4_release_file+0x6d/0xa0 [ext4]
Apr 02 18:47:36 fix-ext4-2k kernel:  __fput+0xf4/0x2b0
Apr 02 18:47:36 fix-ext4-2k kernel:  __x64_sys_close+0x39/0x80
Apr 02 18:47:36 fix-ext4-2k kernel:  do_syscall_64+0x4b/0x120
Apr 02 18:47:36 fix-ext4-2k kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Apr 02 18:47:36 fix-ext4-2k kernel: RIP: 0033:0x7f230b324687
Apr 02 18:47:36 fix-ext4-2k kernel: Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
Apr 02 18:47:36 fix-ext4-2k kernel: RSP: 002b:00007ffc1efe2bb0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
Apr 02 18:47:36 fix-ext4-2k kernel: RAX: ffffffffffffffda RBX: 00007f230b292740 RCX: 00007f230b324687
Apr 02 18:47:36 fix-ext4-2k kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
Apr 02 18:47:36 fix-ext4-2k kernel: RBP: 00007ffc1efe2c60 R08: 0000000000000000 R09: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
Apr 02 18:47:36 fix-ext4-2k kernel: R13: 00007ffc1efe2db0 R14: 00007ffc1efe31b0 R15: 000000000000622d
Apr 02 18:47:36 fix-ext4-2k kernel:  </TASK>
Apr 02 18:47:36 fix-ext4-2k kernel: ---[ end trace 0000000000000000 ]---
Apr 02 18:47:36 fix-ext4-2k kernel: EXT4-fs: ext4_ext_grow_indepth:1366: aborting transaction: error 28 in __ext4_handle_dirty_metadata
Apr 02 18:47:36 fix-ext4-2k kernel: EXT4-fs error (device loop5): ext4_ext_grow_indepth:1366: inode #755485: block 3924606: comm fsstress: journal_dirty_metadata failed: handle type 2 started at line 2721, credits 11/0, errcode -28
Apr 02 18:47:36 fix-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_mb_clear_bb:6550: Readonly filesystem
Apr 02 18:47:36 fix-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_reserve_inode_write:5870: Readonly filesystem
Apr 02 18:47:37 fix-ext4-2k kernel: EXT4-fs error (device loop5): mpage_map_and_submit_extent:2336: inode #755485: comm fsstress: mark_inode_dirty error
Apr 02 18:47:37 fix-ext4-2k kernel: EXT4-fs error (device loop5): mpage_map_and_submit_extent:2338: comm fsstress: Failed to mark inode 755485 dirty
Apr 02 18:47:37 fix-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_do_writepages:2751: error 28
Apr 03 05:43:31 fix-ext4-2k kernel: NOHZ tick-stop error: local softirq work is pending, handler #10!!!
Apr 03 19:32:37 fix-ext4-2k kernel: EXT4-fs (loop5): error count since last fsck: 6
Apr 03 19:32:37 fix-ext4-2k kernel: EXT4-fs (loop5): initial error at time 1743644856: ext4_ext_grow_indepth:1366: inode 755485: block 3924606
Apr 03 19:32:37 fix-ext4-2k kernel: EXT4-fs (loop5): last error at time 1743644857: ext4_do_writepages:2751
Apr 04 08:12:34 fix-ext4-2k kernel: EXT4-fs: ext4_ext_grow_indepth:1366: aborting transaction: error 28 in __ext4_handle_dirty_metadata
Apr 04 08:12:35 fix-ext4-2k kernel: EXT4-fs error (device loop5): ext4_ext_grow_indepth:1366: inode #330657: block 855807: comm kworker/u35:9: journal_dirty_metadata failed: handle type 2 started at line 2721, credits 11/0, errcode -28
Apr 04 08:12:35 fix-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_mb_clear_bb:6550: Readonly filesystem
Apr 04 08:12:35 fix-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_do_writepages:2751: error 28

