Return-Path: <linux-fsdevel+bounces-45576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E0A7988F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 01:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320B2171341
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6936A1F7098;
	Wed,  2 Apr 2025 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX+KudVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC0E1EBA18;
	Wed,  2 Apr 2025 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743635470; cv=none; b=kYXriX7J33WHNMmQhitHl9+31/tZeroyYjNlyY2SBcqEhUOvXMJqZte0oJtcjluJoHw1gD2QPvl8Pw2OLGU/zdFyGlHh2mGQjQTbxq5hsDgaQ1a4q9863JpHZDny8kdixPq0mqu5d0gEYOaOFy6IeK23fZ+sLtepn3yN+Eo7W9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743635470; c=relaxed/simple;
	bh=2FZJD0MOnLxxLnxB/GDmxgCJDt3KQiHUaMXpCRwWbkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRMm42qkDsFJomEpncFH02EH0XPLnOchw4gHBa+FYaS40FGCF0WeTBz156ckm3oWCkf7k1mjiOjtFokrtkDo8D9n3NjoFRm9nXzQbxg4H4MDXewQO93hWPdtqBZ8KEkpKMTu2tfSWIIdFQuwSaTdd1T6znXOAWwkEINlv4fJdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX+KudVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8085C4CEDD;
	Wed,  2 Apr 2025 23:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743635470;
	bh=2FZJD0MOnLxxLnxB/GDmxgCJDt3KQiHUaMXpCRwWbkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kX+KudVKmOtXkPVDhqrqZ1wZ7xTaNrtQm2pfF/aInNMhCXR/gNFRqjTMAczsezThz
	 1GBe7Q6M4fAZsPzw+nvDxPmQtnETSxasCXcWbfhHh86xLyOdiaCoaz1sgLOXNYBtxU
	 uiWyyQwWo4NgUlv7zoA3Qx71KgpNaKApHALTUXuUtnLDtEDWx+aqNFT6AnCCOGXfBy
	 Pu7o47bD8MBYR3TEDkGVQqhv1kYTvHmn9yDuax2HtpUXyrT1YlhLs3Pe1xTn4XSTWV
	 RP85YTt3LzW7ay5+nf/Sm32ZfcR098EJH7FL9puZfihOssWV3yFNTPw9atV7K8mg1B
	 qp6KMZhnHOZww==
Date: Wed, 2 Apr 2025 16:11:08 -0700
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
Message-ID: <Z-3EDGCLMtCV-szJ@bombadil.infradead.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
 <Z-rzyrS0Jr7t984Y@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-rzyrS0Jr7t984Y@bombadil.infradead.org>

On Mon, Mar 31, 2025 at 12:58:04PM -0700, Luis Chamberlain wrote:
> On Sat, Mar 29, 2025 at 11:47:31PM -0700, Luis Chamberlain wrote:
> > Although we don't have exact traces of the filesystem corruption we
> > can can reproduce fs corruption one ext4 by just removing the spinlock
> > and stress testing the filesystem with generic/750, we eventually end
> > up after 3 hours of testing with kdevops using libvirt on the ext4
> > profile ext4-4k. Things like the below as reported recently [1]:
> > 
> > Mar 28 03:36:37 extra-ext4-4k unknown: run fstests generic/750 at 2025-03-28 03:36:37
> > <-- etc -->
> > Mar 28 05:57:09 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5174: comm fsstress: directory missing '.'
> > Mar 28 06:04:43 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
> > Mar 28 06:42:05 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
> > Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
> 
> I reproduced again a corruption with ext4 when we remove the spin lock
> alone with generic/750, the trace looks slightly different, and
> this time I ran the test with ext4 with 2k block size filesystem. I
> also reverted both "mm: migrate: remove folio_migrate_copy()" and
> "mm: migrate: support poisoned recover from migrate folio" just in case
> the extra check added by the later was helping avoid the corruption.

Since we didn't have much data over this filesystem corruption I figured
it would be good to expand on that with more information. I reproduced yet
again with just generic/750 and the spinlock removed in about ~6 hours:

Apr 01 18:17:16 fix-ext4-2k kernel: Linux version 6.14.0-12246-g6ee4cc7e5950-dirty (mcgrof@beef) (gcc (Debian 14.2.0-6) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #9 SMP PREEMPT_DYNAMIC Tue Apr  1 18:12:51 PDT 2025
<-- snip -->
Apr 01 18:17:43 fix-ext4-2k unknown: run fstests generic/750 at 2025-04-01 18:17:43
Apr 01 18:17:44 fix-ext4-2k kernel: EXT4-fs (loop5): mounted filesystem 218f1368-a3fd-42d5-9869-82b1539c5e74 r/w with ordered data mode. Quota mode: none.
Apr 02 00:18:24 fix-ext4-2k kernel: ------------[ cut here ]------------
Apr 02 00:18:24 fix-ext4-2k kernel: WARNING: CPU: 5 PID: 5588 at fs/jbd2/transaction.c:1552 jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Apr 02 00:18:24 fix-ext4-2k kernel: Modules linked in: loop sunrpc nls_iso8859_1 kvm_intel nls_cp437 9p vfat fat kvm crc32c_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio virtio_console virtio_balloon button evdev joydev serio_raw nvme_fabrics dm_mod nvme_core drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Apr 02 00:18:24 fix-ext4-2k kernel: CPU: 5 UID: 0 PID: 5588 Comm: kworker/u38:0 Not tainted 6.14.0-12246-g6ee4cc7e5950-dirty #9 PREEMPT(full) 
Apr 02 00:18:24 fix-ext4-2k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-2 10/04/2024
Apr 02 00:18:24 fix-ext4-2k kernel: Workqueue: writeback wb_workfn (flush-7:5)
Apr 02 00:18:24 fix-ext4-2k kernel: RIP: 0010:jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Apr 02 00:18:24 fix-ext4-2k kernel: Code: 30 0f 84 5b fe ff ff 0f 0b 41 bc 8b ff ff ff e9 69 fe ff ff 48 8b 04 24 4c 8b 48 70 4d 39 cf 0f 84 53 ff ff ff e9 42 c5 00 00 <0f> 0b 41 bc e4 ff ff ff e9 41 ff ff ff 0f 0b 90 0f 1f 40 00 90 90
Apr 02 00:18:24 fix-ext4-2k kernel: RSP: 0018:ffffb44046157588 EFLAGS: 00010246
Apr 02 00:18:24 fix-ext4-2k kernel: RAX: 0000000000000001 RBX: ffff9a73d04a58e8 RCX: 00000000000000fd
Apr 02 00:18:24 fix-ext4-2k kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: RBP: ffff9a74c2c4e478 R08: ffff9a74c2c4e478 R09: 0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: R10: 000000007b4f6d91 R11: 0000000000003151 R12: 0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: R13: ffff9a74c8d44460 R14: ffff9a73d04a58f0 R15: ffff9a74e92be300
Apr 02 00:18:24 fix-ext4-2k kernel: FS:  0000000000000000(0000) GS:ffff9a7597a0c000(0000) knlGS:0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 02 00:18:24 fix-ext4-2k kernel: CR2: 00007ff766871000 CR3: 0000000116e6a002 CR4: 0000000000772ef0
Apr 02 00:18:24 fix-ext4-2k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
Apr 02 00:18:24 fix-ext4-2k kernel: PKRU: 55555554
Apr 02 00:18:24 fix-ext4-2k kernel: Call Trace:
Apr 02 00:18:24 fix-ext4-2k kernel:  <TASK>
Apr 02 00:18:24 fix-ext4-2k kernel:  __ext4_handle_dirty_metadata+0x6d/0x190 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_ext_insert_extent+0x5c1/0x1510 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? ext4_cache_extents+0x5a/0xd0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? ext4_find_extent+0x37c/0x3a0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_ext_map_blocks+0x51e/0x1900 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? mpage_map_and_submit_buffers+0x23f/0x270 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_map_blocks+0x11a/0x4d0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? kmem_cache_alloc_noprof+0x321/0x3e0
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_do_writepages+0x762/0xd40 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_stack_trace_consume_entry+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  ? arch_stack_walk+0x88/0xf0
Apr 02 00:18:24 fix-ext4-2k kernel:  ? ext4_writepages+0xd7/0x1b0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_writepages+0xd7/0x1b0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  do_writepages+0xdd/0x250
Apr 02 00:18:24 fix-ext4-2k kernel:  __writeback_single_inode+0x41/0x330
Apr 02 00:18:24 fix-ext4-2k kernel:  writeback_sb_inodes+0x21b/0x4e0
Apr 02 00:18:24 fix-ext4-2k kernel:  wb_writeback+0x89/0x320
Apr 02 00:18:24 fix-ext4-2k kernel:  wb_workfn+0xbe/0x440
Apr 02 00:18:24 fix-ext4-2k kernel:  ? queue_delayed_work_on+0x6b/0x80
Apr 02 00:18:24 fix-ext4-2k kernel:  process_one_work+0x188/0x350
Apr 02 00:18:24 fix-ext4-2k kernel:  worker_thread+0x255/0x3a0
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  kthread+0x112/0x250
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  ? _raw_spin_unlock+0x15/0x30
Apr 02 00:18:24 fix-ext4-2k kernel:  ? finish_task_switch.isra.0+0x94/0x290
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  ret_from_fork+0x2d/0x50
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 00:18:24 fix-ext4-2k kernel:  </TASK>
Apr 02 00:18:24 fix-ext4-2k kernel: ---[ end trace 0000000000000000 ]---
Apr 02 00:18:24 fix-ext4-2k kernel: ------------[ cut here ]------------
Apr 02 00:18:24 fix-ext4-2k kernel: WARNING: CPU: 5 PID: 5588 at fs/ext4/ext4_jbd2.c:360 __ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel: Modules linked in: loop sunrpc nls_iso8859_1 kvm_intel nls_cp437 9p vfat fat kvm crc32c_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio virtio_console virtio_balloon button evdev joydev serio_raw nvme_fabrics dm_mod nvme_core drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Apr 02 00:18:24 fix-ext4-2k kernel: CPU: 5 UID: 0 PID: 5588 Comm: kworker/u38:0 Tainted: G        W           6.14.0-12246-g6ee4cc7e5950-dirty #9 PREEMPT(full) 
Apr 02 00:18:24 fix-ext4-2k kernel: Tainted: [W]=WARN
Apr 02 00:18:24 fix-ext4-2k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-2 10/04/2024
Apr 02 00:18:24 fix-ext4-2k kernel: Workqueue: writeback wb_workfn (flush-7:5)
Apr 02 00:18:24 fix-ext4-2k kernel: RIP: 0010:__ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel: Code: 00 00 00 44 89 fa 4c 89 f6 49 c7 c1 3b 1c 77 c0 4c 89 e7 41 bd fb ff ff ff e8 5a ce 05 00 eb 97 48 89 df e8 c0 a4 4a e2 eb 8a <0f> 0b 48 c7 c2 a0 32 76 c0 45 89 e8 48 89 e9 44 89 fe 4c 89 f7 e8
Apr 02 00:18:24 fix-ext4-2k kernel: RSP: 0018:ffffb440461575c8 EFLAGS: 00010286
Apr 02 00:18:24 fix-ext4-2k kernel: RAX: ffff9a74e1d5d800 RBX: ffff9a74c2c4e478 RCX: 0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000ffffffff
Apr 02 00:18:24 fix-ext4-2k kernel: RBP: ffff9a74c8d44460 R08: ffff9a74c2c4e478 R09: 0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: R10: 000000007b4f6d91 R11: 0000000000003151 R12: ffff9a73c12236c8
Apr 02 00:18:24 fix-ext4-2k kernel: R13: 00000000ffffffe4 R14: ffffffffc0763760 R15: 0000000000000556
Apr 02 00:18:24 fix-ext4-2k kernel: FS:  0000000000000000(0000) GS:ffff9a7597a0c000(0000) knlGS:0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 02 00:18:24 fix-ext4-2k kernel: CR2: 00007ff766871000 CR3: 0000000116e6a002 CR4: 0000000000772ef0
Apr 02 00:18:24 fix-ext4-2k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 02 00:18:24 fix-ext4-2k kernel: DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
Apr 02 00:18:24 fix-ext4-2k kernel: PKRU: 55555554
Apr 02 00:18:24 fix-ext4-2k kernel: Call Trace:
Apr 02 00:18:24 fix-ext4-2k kernel:  <TASK>
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_ext_insert_extent+0x5c1/0x1510 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? ext4_cache_extents+0x5a/0xd0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? ext4_find_extent+0x37c/0x3a0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_ext_map_blocks+0x51e/0x1900 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? mpage_map_and_submit_buffers+0x23f/0x270 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_map_blocks+0x11a/0x4d0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? kmem_cache_alloc_noprof+0x321/0x3e0
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_do_writepages+0x762/0xd40 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_stack_trace_consume_entry+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  ? arch_stack_walk+0x88/0xf0
Apr 02 00:18:24 fix-ext4-2k kernel:  ? ext4_writepages+0xd7/0x1b0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  ext4_writepages+0xd7/0x1b0 [ext4]
Apr 02 00:18:24 fix-ext4-2k kernel:  do_writepages+0xdd/0x250
Apr 02 00:18:24 fix-ext4-2k kernel:  __writeback_single_inode+0x41/0x330
Apr 02 00:18:24 fix-ext4-2k kernel:  writeback_sb_inodes+0x21b/0x4e0
Apr 02 00:18:24 fix-ext4-2k kernel:  wb_writeback+0x89/0x320
Apr 02 00:18:24 fix-ext4-2k kernel:  wb_workfn+0xbe/0x440
Apr 02 00:18:24 fix-ext4-2k kernel:  ? queue_delayed_work_on+0x6b/0x80
Apr 02 00:18:24 fix-ext4-2k kernel:  process_one_work+0x188/0x350
Apr 02 00:18:24 fix-ext4-2k kernel:  worker_thread+0x255/0x3a0
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  kthread+0x112/0x250
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  ? _raw_spin_unlock+0x15/0x30
Apr 02 00:18:24 fix-ext4-2k kernel:  ? finish_task_switch.isra.0+0x94/0x290
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  ret_from_fork+0x2d/0x50
Apr 02 00:18:24 fix-ext4-2k kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 00:18:24 fix-ext4-2k kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 00:18:24 fix-ext4-2k kernel:  </TASK>
Apr 02 00:18:24 fix-ext4-2k kernel: ---[ end trace 0000000000000000 ]---
Apr 02 00:18:24 fix-ext4-2k kernel: EXT4-fs: ext4_ext_grow_indepth:1366: aborting transaction: error 28 in __ext4_handle_dirty_metadata
Apr 02 00:18:24 fix-ext4-2k kernel: EXT4-fs error (device loop5): ext4_ext_grow_indepth:1366: inode #1010806: block 3112384: comm kworker/u38:0: journal_dirty_metadata failed: handle type 2 started at line 2721, credits 11/0, errcode -28
Apr 02 00:18:24 fix-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_mb_clear_bb:6550: Readonly filesystem
Apr 02 00:18:24 fix-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_reserve_inode_write:5870: Readonly filesystem
Apr 02 00:18:24 fix-ext4-2k kernel: EXT4-fs error (device loop5): mpage_map_and_submit_extent:2336: inode #1010806: comm kworker/u38:0: mark_inode_dirty error
Apr 02 00:18:24 fix-ext4-2k kernel: EXT4-fs error (device loop5): mpage_map_and_submit_extent:2338: comm kworker/u38:0: Failed to mark inode 1010806 dirty
Apr 02 00:18:24 fix-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_do_writepages:2751: error 28


