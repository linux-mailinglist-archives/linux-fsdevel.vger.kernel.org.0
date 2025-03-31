Return-Path: <linux-fsdevel+bounces-45384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88BA76DCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 21:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73497188C1C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319C21A440;
	Mon, 31 Mar 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRSNOJeF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C571BFE00;
	Mon, 31 Mar 2025 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451084; cv=none; b=Jfg7tEfirrpfSaLiI8jNbpvkC9ZM1qwzFUMfq9xzg8NCjRp+SuueoFcmrJZ3AJkn4HkGcYWitaDgS+iVaMERcYK6ZqY+dN1L7paznSg1K6vu8a2ZGGqjhfZpdIbSDGmIB9zQLHLjUEaKjwEVDqydwbf6Yhe51cQDurwrVhXwmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451084; c=relaxed/simple;
	bh=/E+wwz98eNFd1DmNPK1lqFRD9SrYNrqWDNmrsLZOPHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvaSaiO+MJzXcPkLYE3qpeVK5MA5lWBVhMmhhxuyVtnYaHptsv1+IMKzTonR2thtwesW0F99V+6UE+b28xfLefCGBSSBcGWE4nmBZKImM9UFGSzE2aZEf2S6tuVKwlWEcgq695bWbxlcipEFaOAu5UXY4CTSv6YLnXYF/e72Egc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRSNOJeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB31C4CEE3;
	Mon, 31 Mar 2025 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743451084;
	bh=/E+wwz98eNFd1DmNPK1lqFRD9SrYNrqWDNmrsLZOPHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRSNOJeFxsx9bkrYs9YzaSS+qpFbA+kQEeEyoiywHRmH+Ncj53au5sr+AX+/QiveT
	 ICxPqla9sFqPIAQIAjKYHqJocc7dyEdXGELWCyPmV+SrA9oa8dtyTXeU0GiVpy5MoM
	 Rv7qOiKzJfPw2VrOMKW34FnBuElq9WdXw7V1jJf9QlJ5IqSEyp+w187txwHmK31dBj
	 c4e6FO8FXAzhpbgbId47fxZlpOIZZub0wseSW5MSo13+9+fqtrlmbrNaH8mtBXTw6p
	 /RLb2dzCbMK0D1kCog5OXz/E5ZX2fBHtl2ONOY7Iab736QaO0/MEX8JvE3Eed5tQB4
	 jxn1AwrT0GahQ==
Date: Mon, 31 Mar 2025 12:58:02 -0700
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
Message-ID: <Z-rzyrS0Jr7t984Y@bombadil.infradead.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330064732.3781046-3-mcgrof@kernel.org>

On Sat, Mar 29, 2025 at 11:47:31PM -0700, Luis Chamberlain wrote:
> Although we don't have exact traces of the filesystem corruption we
> can can reproduce fs corruption one ext4 by just removing the spinlock
> and stress testing the filesystem with generic/750, we eventually end
> up after 3 hours of testing with kdevops using libvirt on the ext4
> profile ext4-4k. Things like the below as reported recently [1]:
> 
> Mar 28 03:36:37 extra-ext4-4k unknown: run fstests generic/750 at 2025-03-28 03:36:37
> <-- etc -->
> Mar 28 05:57:09 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5174: comm fsstress: directory missing '.'
> Mar 28 06:04:43 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
> Mar 28 06:42:05 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
> Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)

I reproduced again a corruption with ext4 when we remove the spin lock
alone with generic/750, the trace looks slightly different, and
this time I ran the test with ext4 with 2k block size filesystem. I
also reverted both "mm: migrate: remove folio_migrate_copy()" and
"mm: migrate: support poisoned recover from migrate folio" just in case
the extra check added by the later was helping avoid the corruption. I
also added some debugfs stats one can use to verify exact values of
how buffer_migrate_folio_norefs() can fail. I put this tree on
linux-kdevops 20250321-accel-ext4-bug branch [0] for other folks' convenience.
This time it took ~ 5 hours to reproduce and we start off with a jbd
jbd2_journal_dirty_metadata() kernel warning followed by putting
the filesystem in read-only mode:

Mar 31 06:51:30 extra-ext4-2k kernel: Linux version 6.14.0-rc7-next-20250321-00004-ge4b961f1dadb (mcgrof@beef) (gcc (Debian 14.2.0-16) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #92 SMP PREEMPT_DYNAMIC Mon Mar 31 06:43:08 UTC 2025
Mar 31 06:51:30 extra-ext4-2k kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc7-next-20250321-00004-ge4b961f1dadb root=PARTUUID=503fa6f2-2d5b-4d7e-8cf8-3a811de326ce ro console=tty0 console=tty1 console=ttyS0,115200n8 console=ttyS0

<-- snip -->

Mar 31 06:56:05 extra-ext4-2k unknown: run fstests generic/750 at 2025-03-31 06:56:05
Mar 31 06:56:06 extra-ext4-2k kernel: EXT4-fs (loop5): mounted filesystem 858bf9bf-6582-42d3-b2f5-41c7061033df r/w with ordered data mode. Quota mode: none.
Mar 31 07:02:04 extra-ext4-2k kernel: NOHZ tick-stop error: local softirq work is pending, handler #10!!!
Mar 31 07:35:22 extra-ext4-2k kernel: NOHZ tick-stop error: local softirq work is pending, handler #10!!!
Mar 31 07:53:05 extra-ext4-2k kernel: NOHZ tick-stop error: local softirq work is pending, handler #10!!!
Mar 31 11:47:01 extra-ext4-2k kernel: ------------[ cut here ]------------
Mar 31 11:47:01 extra-ext4-2k kernel: WARNING: CPU: 5 PID: 3092 at fs/jbd2/transaction.c:1552 jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Mar 31 11:47:01 extra-ext4-2k kernel: Modules linked in: loop sunrpc 9p nls_iso8859_1 nls_cp437 vfat crc32c_generic fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio virtio_balloon virtio_console button evdev joydev serio_raw nvme_fabrics drm dm_mod nvme_core nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Mar 31 11:47:01 extra-ext4-2k kernel: CPU: 5 UID: 0 PID: 3092 Comm: fsstress Not tainted 6.14.0-rc7-next-20250321-00004-ge4b961f1dadb #92 PREEMPT(full) 
Mar 31 11:47:01 extra-ext4-2k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Mar 31 11:47:01 extra-ext4-2k kernel: RIP: 0010:jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Mar 31 11:47:01 extra-ext4-2k kernel: Code: 30 0f 84 5b fe ff ff 0f 0b 41 bc 8b ff ff ff e9 69 fe ff ff 48 8b 04 24 4c 8b 48 70 4d 39 cf 0f 84 53 ff ff ff e9 22 c5 00 00 <0f> 0b 41 bc e4 ff ff ff e9 41 ff ff ff 0f 0b 90 0f 1f 40 00 90 90
Mar 31 11:47:01 extra-ext4-2k kernel: RSP: 0018:ffffb8bd83d2f7f8 EFLAGS: 00010246
Mar 31 11:47:01 extra-ext4-2k kernel: RAX: 0000000000000001 RBX: ffff9d72cb6d7528 RCX: 00000000000000fd
Mar 31 11:47:01 extra-ext4-2k kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: RBP: ffff9d72cf5127b8 R08: ffff9d72cf5127b8 R09: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: R10: ffff9d733c8d983c R11: 0000000000006496 R12: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: R13: ffff9d72c258cce8 R14: ffff9d72cb6d7530 R15: ffff9d72c25ff000
Mar 31 11:47:01 extra-ext4-2k kernel: FS:  00007f1f5ae7f740(0000) GS:ffff9d7386349000(0000) knlGS:0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 31 11:47:01 extra-ext4-2k kernel: CR2: 000055a76a03bfa8 CR3: 0000000108f76001 CR4: 0000000000772ef0
Mar 31 11:47:01 extra-ext4-2k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 31 11:47:01 extra-ext4-2k kernel: PKRU: 55555554
Mar 31 11:47:01 extra-ext4-2k kernel: Call Trace:
Mar 31 11:47:01 extra-ext4-2k kernel:  <TASK>
Mar 31 11:47:01 extra-ext4-2k kernel:  ? jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? __warn.cold+0x93/0xf8
Mar 31 11:47:01 extra-ext4-2k kernel:  ? jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? report_bug+0xe6/0x170
Mar 31 11:47:01 extra-ext4-2k kernel:  ? jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? handle_bug+0x199/0x260
Mar 31 11:47:01 extra-ext4-2k kernel:  ? exc_invalid_op+0x13/0x60
Mar 31 11:47:01 extra-ext4-2k kernel:  ? asm_exc_invalid_op+0x16/0x20
Mar 31 11:47:01 extra-ext4-2k kernel:  ? jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? jbd2_journal_dirty_metadata+0x9e/0x230 [jbd2]
Mar 31 11:47:01 extra-ext4-2k kernel:  __ext4_handle_dirty_metadata+0x6d/0x190 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_ext_insert_extent+0x5c1/0x1510 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? ext4_cache_extents+0x5a/0xd0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? ext4_find_extent+0x37c/0x3a0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_ext_map_blocks+0x51e/0x1900 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? mpage_map_and_submit_buffers+0x23f/0x270 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_map_blocks+0x11a/0x4d0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? kmem_cache_alloc_noprof+0x321/0x3e0
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_do_writepages+0x762/0xd40 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? ext4_da_write_end+0xa3/0x3c0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? ext4_writepages+0xd7/0x1b0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_writepages+0xd7/0x1b0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  do_writepages+0xdd/0x250
Mar 31 11:47:01 extra-ext4-2k kernel:  filemap_fdatawrite_wbc+0x48/0x60
Mar 31 11:47:01 extra-ext4-2k kernel:  __filemap_fdatawrite_range+0x5b/0x80
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_release_file+0x6d/0xa0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  __fput+0xf4/0x2b0
Mar 31 11:47:01 extra-ext4-2k kernel:  __x64_sys_close+0x39/0x80
Mar 31 11:47:01 extra-ext4-2k kernel:  do_syscall_64+0x4b/0x120
Mar 31 11:47:01 extra-ext4-2k kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Mar 31 11:47:01 extra-ext4-2k kernel: RIP: 0033:0x7f1f5af11687
Mar 31 11:47:01 extra-ext4-2k kernel: Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
Mar 31 11:47:01 extra-ext4-2k kernel: RSP: 002b:00007ffc2509e1d0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
Mar 31 11:47:01 extra-ext4-2k kernel: RAX: ffffffffffffffda RBX: 00007f1f5ae7f740 RCX: 00007f1f5af11687
Mar 31 11:47:01 extra-ext4-2k kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
Mar 31 11:47:01 extra-ext4-2k kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: R13: 00007ffc2509e7c0 R14: 0000000000000003 R15: 0000000000000004
Mar 31 11:47:01 extra-ext4-2k kernel:  </TASK>
Mar 31 11:47:01 extra-ext4-2k kernel: ---[ end trace 0000000000000000 ]---
Mar 31 11:47:01 extra-ext4-2k kernel: ------------[ cut here ]------------
Mar 31 11:47:01 extra-ext4-2k kernel: WARNING: CPU: 5 PID: 3092 at fs/ext4/ext4_jbd2.c:360 __ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel: Modules linked in: loop sunrpc 9p nls_iso8859_1 nls_cp437 vfat crc32c_generic fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio virtio_balloon virtio_console button evdev joydev serio_raw nvme_fabrics drm dm_mod nvme_core nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Mar 31 11:47:01 extra-ext4-2k kernel: CPU: 5 UID: 0 PID: 3092 Comm: fsstress Tainted: G        W           6.14.0-rc7-next-20250321-00004-ge4b961f1dadb #92 PREEMPT(full) 
Mar 31 11:47:01 extra-ext4-2k kernel: Tainted: [W]=WARN
Mar 31 11:47:01 extra-ext4-2k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Mar 31 11:47:01 extra-ext4-2k kernel: RIP: 0010:__ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel: Code: 00 00 00 44 89 fa 4c 89 f6 49 c7 c1 df 2b 97 c0 4c 89 e7 41 bd fb ff ff ff e8 6a ce 05 00 eb 97 48 89 df e8 60 99 8a f5 eb 8a <0f> 0b 48 c7 c2 60 42 96 c0 45 89 e8 48 89 e9 44 89 fe 4c 89 f7 e8
Mar 31 11:47:01 extra-ext4-2k kernel: RSP: 0018:ffffb8bd83d2f838 EFLAGS: 00010286
Mar 31 11:47:01 extra-ext4-2k kernel: RAX: ffff9d72c04ef800 RBX: ffff9d72cf5127b8 RCX: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000ffffffff
Mar 31 11:47:01 extra-ext4-2k kernel: RBP: ffff9d72c258cce8 R08: ffff9d72cf5127b8 R09: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: R10: ffff9d733c8d983c R11: 0000000000006496 R12: ffff9d71d05fe378
Mar 31 11:47:01 extra-ext4-2k kernel: R13: 00000000ffffffe4 R14: ffffffffc0964720 R15: 0000000000000556
Mar 31 11:47:01 extra-ext4-2k kernel: FS:  00007f1f5ae7f740(0000) GS:ffff9d7386349000(0000) knlGS:0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 31 11:47:01 extra-ext4-2k kernel: CR2: 000055a76a03bfa8 CR3: 0000000108f76001 CR4: 0000000000772ef0
Mar 31 11:47:01 extra-ext4-2k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 31 11:47:01 extra-ext4-2k kernel: PKRU: 55555554
Mar 31 11:47:01 extra-ext4-2k kernel: Call Trace:
Mar 31 11:47:01 extra-ext4-2k kernel:  <TASK>
Mar 31 11:47:01 extra-ext4-2k kernel:  ? __ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? __warn.cold+0x93/0xf8
Mar 31 11:47:01 extra-ext4-2k kernel:  ? __ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? report_bug+0xe6/0x170
Mar 31 11:47:01 extra-ext4-2k kernel:  ? __ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? handle_bug+0x199/0x260
Mar 31 11:47:01 extra-ext4-2k kernel:  ? exc_invalid_op+0x13/0x60
Mar 31 11:47:01 extra-ext4-2k kernel:  ? asm_exc_invalid_op+0x16/0x20
Mar 31 11:47:01 extra-ext4-2k kernel:  ? __ext4_handle_dirty_metadata+0x102/0x190 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? __ext4_handle_dirty_metadata+0x6d/0x190 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_ext_insert_extent+0x5c1/0x1510 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? ext4_cache_extents+0x5a/0xd0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? ext4_find_extent+0x37c/0x3a0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_ext_map_blocks+0x51e/0x1900 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? mpage_map_and_submit_buffers+0x23f/0x270 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_map_blocks+0x11a/0x4d0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? kmem_cache_alloc_noprof+0x321/0x3e0
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_do_writepages+0x762/0xd40 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? ext4_da_write_end+0xa3/0x3c0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ? ext4_writepages+0xd7/0x1b0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_writepages+0xd7/0x1b0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  do_writepages+0xdd/0x250
Mar 31 11:47:01 extra-ext4-2k kernel:  filemap_fdatawrite_wbc+0x48/0x60
Mar 31 11:47:01 extra-ext4-2k kernel:  __filemap_fdatawrite_range+0x5b/0x80
Mar 31 11:47:01 extra-ext4-2k kernel:  ext4_release_file+0x6d/0xa0 [ext4]
Mar 31 11:47:01 extra-ext4-2k kernel:  __fput+0xf4/0x2b0
Mar 31 11:47:01 extra-ext4-2k kernel:  __x64_sys_close+0x39/0x80
Mar 31 11:47:01 extra-ext4-2k kernel:  do_syscall_64+0x4b/0x120
Mar 31 11:47:01 extra-ext4-2k kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Mar 31 11:47:01 extra-ext4-2k kernel: RIP: 0033:0x7f1f5af11687
Mar 31 11:47:01 extra-ext4-2k kernel: Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
Mar 31 11:47:01 extra-ext4-2k kernel: RSP: 002b:00007ffc2509e1d0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
Mar 31 11:47:01 extra-ext4-2k kernel: RAX: ffffffffffffffda RBX: 00007f1f5ae7f740 RCX: 00007f1f5af11687
Mar 31 11:47:01 extra-ext4-2k kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
Mar 31 11:47:01 extra-ext4-2k kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
Mar 31 11:47:01 extra-ext4-2k kernel: R13: 00007ffc2509e7c0 R14: 0000000000000003 R15: 0000000000000004
Mar 31 11:47:01 extra-ext4-2k kernel:  </TASK>
Mar 31 11:47:01 extra-ext4-2k kernel: ---[ end trace 0000000000000000 ]---
Mar 31 11:47:01 extra-ext4-2k kernel: EXT4-fs: ext4_ext_grow_indepth:1366: aborting transaction: error 28 in __ext4_handle_dirty_metadata
Mar 31 11:47:01 extra-ext4-2k kernel: EXT4-fs error (device loop5): ext4_ext_grow_indepth:1366: inode #213689: block 9062541: comm fsstress: journal_dirty_metadata failed: handle type 2 started at line 2721, credits 11/0, errcode -28
Mar 31 11:47:01 extra-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_mb_clear_bb:6550: Readonly filesystem
Mar 31 11:47:01 extra-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_reserve_inode_write:5870: Readonly filesystem
Mar 31 11:47:01 extra-ext4-2k kernel: EXT4-fs error (device loop5): mpage_map_and_submit_extent:2336: inode #213689: comm fsstress: mark_inode_dirty error
Mar 31 11:47:01 extra-ext4-2k kernel: EXT4-fs error (device loop5): mpage_map_and_submit_extent:2338: comm fsstress: Failed to mark inode 213689 dirty
Mar 31 11:47:01 extra-ext4-2k kernel: EXT4-fs error (device loop5) in ext4_do_writepages:2751: error 28

So at least we now have 2 different public filesystem corruptions traces with
ext4 without the spin lock.

[0] https://github.com/linux-kdevops/linux/tree/20250321-accel-ext4-bug

  Luis

