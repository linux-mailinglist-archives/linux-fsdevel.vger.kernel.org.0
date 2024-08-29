Return-Path: <linux-fsdevel+bounces-27943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764D6964E27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 20:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB28A1F24058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590171B9B5B;
	Thu, 29 Aug 2024 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkp0Wl55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4971B8E84;
	Thu, 29 Aug 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957208; cv=none; b=Pgvwkn7Wq4wxz79gnngDV+BXvc1RnAqvu/QGRVEPByXnidtvhx8sc3D2gIxmg4QhTXZnTwmw+TBe53cGMzR/9BA8iBSiasLyOsM24geYp91/LN2annNtcnPZeOMA6fWAuq/dm7lzR9EvVviEUgFYz5CqOHuzzaaj8HibzkDcbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957208; c=relaxed/simple;
	bh=RqeunlF5ZFJcBlbWzlFsAtYwqUEEAoDZcL6ls2IJ6mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svLpZwayzGdEC3aJ5ek4z2ivknhwiYrZJInmLVEDKPCKPPrke3PBOu8Jc1rCAhnVrXg+dc+q3R1SdXwju+b9q8PwhDBD9CTbijki4IYCmnMEgwcXEiXytT1/qSBchcZEesj84Oau9267I9rd++teqoh7OYMPmC0A5gPvsGkuq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dkp0Wl55; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f4iXAUK+pMQw3ZYpzNzdT5E1lz9Q7PzED9IZsd209Dc=; b=dkp0Wl559op6o++iE9yNBhA+k2
	1y5lQ+yILVLb08qWladwtDIxPYR8EmLWbDcskR15ZxqydKg6rK+9caS1Ustb2CgBQB3TXRgiho2M2
	oiO9TZ9D3WwLG+DzJcU9gF65jnI9icZOG6OOZvvLdh4ug8UTkaUnRU5i6n/4EV0mypg+JWovHwsvm
	6rGuLrwl40DehVhBEj3hr11Ko4tRb9Epatvb5TvtDoCdtnTuNWF3WyOew/AtYlYPfrec1fgrVvXOj
	gG9AnWu4UHBpxtjrKcvy5JZn9Aq2WW3XtLuZpzm+oS/Fb1crYoneMTygTGlZ67Y0MikMXfi+7QRMg
	6pbrptKQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjkAM-00000003FJq-19W3;
	Thu, 29 Aug 2024 18:46:42 +0000
Date: Thu, 29 Aug 2024 11:46:42 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, brauner@kernel.org,
	akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com,
	ryan.roberts@arm.com, David Howells <dhowells@redhat.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dttf3r49e.fsf@linux.ibm.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Aug 29, 2024 at 12:51:25PM +0200, Sven Schnelle wrote:
> Hi,
> 
> "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:
> 
> > From: Luis Chamberlain <mcgrof@kernel.org>
> >
> > split_folio() and split_folio_to_list() assume order 0, to support
> > minorder for non-anonymous folios, we must expand these to check the
> > folio mapping order and use that.
> >
> > Set new_order to be at least minimum folio order if it is set in
> > split_huge_page_to_list() so that we can maintain minimum folio order
> > requirement in the page cache.
> >
> > Update the debugfs write files used for testing to ensure the order
> > is respected as well. We simply enforce the min order when a file
> > mapping is used.
> >
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Tested-by: David Howells <dhowells@redhat.com>
> 
> This causes the following warning on s390 with linux-next starting from
> next-20240827:
> 
> [  112.690518] BUG: Bad page map in process ksm01  pte:a5801317 pmd:99054000
> [  112.690531] page: refcount:0 mapcount:-1 mapping:0000000000000000 index:0x3ff86102 pfn:0xa5801
> [  112.690536] flags: 0x3ffff00000000004(referenced|node=0|zone=1|lastcpupid=0x1ffff)
> [  112.690543] raw: 3ffff00000000004 0000001d47439e30 0000001d47439e30 0000000000000000
> [  112.690546] raw: 000000003ff86102 0000000000000000 fffffffe00000000 0000000000000000
> [  112.690548] page dumped because: bad pte
> [  112.690549] addr:000003ff86102000 vm_flags:88100073 anon_vma:000000008c8e46e8 mapping:0000000000000000 index:3ff86102
> [  112.690553] file:(null) fault:0x0 mmap:0x0 read_folio:0x0
> [  112.690561] CPU: 1 UID: 0 PID: 604 Comm: ksm01 Not tainted 6.11.0-rc5-next-20240827-dirty #1441
> [  112.690565] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
> [  112.690568] Call Trace:
> [  112.690571]  [<000003ffe0eb77fe>] dump_stack_lvl+0x76/0xa0
> [  112.690579]  [<000003ffe03f4a90>] print_bad_pte+0x280/0x2d0
> [  112.690584]  [<000003ffe03f7654>] zap_present_ptes.isra.0+0x5c4/0x870
> [  112.690598]  [<000003ffe03f7a46>] zap_pte_range+0x146/0x3d0
> [  112.690601]  [<000003ffe03f7f1c>] zap_p4d_range+0x24c/0x4b0
> [  112.690603]  [<000003ffe03f84ea>] unmap_page_range+0xea/0x2c0
> [  112.690605]  [<000003ffe03f8754>] unmap_single_vma.isra.0+0x94/0xf0
> [  112.690607]  [<000003ffe03f8866>] unmap_vmas+0xb6/0x1a0
> [  112.690609]  [<000003ffe0405724>] exit_mmap+0xc4/0x3e0
> [  112.690613]  [<000003ffe0154aa2>] mmput+0x72/0x170
> [  112.690616]  [<000003ffe015e2c6>] exit_mm+0xd6/0x150
> [  112.690618]  [<000003ffe015e52c>] do_exit+0x1ec/0x490
> [  112.690620]  [<000003ffe015e9a4>] do_group_exit+0x44/0xc0
> [  112.690621]  [<000003ffe016f000>] get_signal+0x7f0/0x800
> [  112.690624]  [<000003ffe0108614>] arch_do_signal_or_restart+0x74/0x320
> [  112.690628]  [<000003ffe020c876>] syscall_exit_to_user_mode_work+0xe6/0x170
> [  112.690632]  [<000003ffe0eb7c04>] __do_syscall+0xd4/0x1c0
> [  112.690634]  [<000003ffe0ec303c>] system_call+0x74/0x98
> [  112.690638] Disabling lock debugging due to kernel taint
> 
> To reproduce, running the ksm01 testsuite from ltp seems to be
> enough. The splat is always triggered immediately. The output from ksm01
> is:
> 
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1809: TINFO: LTP version: 20240524-208-g6c3293c6f
> tst_test.c:1813: TINFO: Tested kernel: 6.11.0-rc5-next-20240827 #1440 SMP Thu Aug 29 12:13:28 CEST 2024 s390x
> tst_test.c:1652: TINFO: Timeout per run is 0h 00m 30s
> mem.c:422: TINFO: wait for all children to stop.
> mem.c:388: TINFO: child 0 stops.
> mem.c:388: TINFO: child 1 stops.
> mem.c:388: TINFO: child 2 stops.
> mem.c:495: TINFO: KSM merging...
> mem.c:434: TINFO: resume all children.
> mem.c:422: TINFO: wait for all children to stop.
> mem.c:344: TINFO: child 0 continues...
> mem.c:347: TINFO: child 0 allocates 128 MB filled with 'c'
> mem.c:344: TINFO: child 1 continues...
> mem.c:347: TINFO: child 1 allocates 128 MB filled with 'a'
> mem.c:344: TINFO: child 2 continues...
> mem.c:347: TINFO: child 2 allocates 128 MB filled with 'a'
> mem.c:400: TINFO: child 1 stops.
> mem.c:400: TINFO: child 2 stops.
> mem.c:400: TINFO: child 0 stops.
> Test timeouted, sending SIGKILL!
> tst_test.c:1700: TINFO: Killed the leftover descendant processes
> tst_test.c:1706: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1708: TBROK: Test killed! (timeout?)

Thanks for the report and test reproducer, I was able to reproduce on
x86_64 easily with ltp/testcases/kernel/mem/ksm/ksm01 as well:

ltp/testcases/kernel/mem/ksm/ksm01
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1809: TINFO: LTP version: 20240524-208-g6c3293c6fc20
tst_test.c:1813: TINFO: Tested kernel: 6.11.0-rc5-next-20240827 #56 SMP
PREEMPT_DYNAMIC Tue Aug 27 08:10:26 UTC 2024 x86_64
tst_test.c:1652: TINFO: Timeout per run is 0h 00m 30s
mem.c:422: TINFO: wait for all children to stop.
mem.c:388: TINFO: child 0 stops.
mem.c:388: TINFO: child 1 stops.
mem.c:388: TINFO: child 2 stops.
mem.c:495: TINFO: KSM merging...
mem.c:434: TINFO: resume all children.
mem.c:422: TINFO: wait for all children to stop.
mem.c:344: TINFO: child 0 continues...
mem.c:344: TINFO: child 2 continues...
mem.c:344: TINFO: child 1 continues...
mem.c:347: TINFO: child 1 allocates 128 MB filled with 'a'
mem.c:347: TINFO: child 0 allocates 128 MB filled with 'c'
mem.c:347: TINFO: child 2 allocates 128 MB filled with 'a'
mem.c:400: TINFO: child 1 stops.
mem.c:400: TINFO: child 0 stops.
mem.c:400: TINFO: child 2 stops.


Test timeouted, sending SIGKILL!
tst_test.c:1700: TINFO: Killed the leftover descendant processes
tst_test.c:1706: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1708: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0


With vm debugging however I get more information about the issue:

Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: page: refcount:1 mapcount:1 mapping:0000000000000000 index:0x7f589dd7f pfn:0x211d7f
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: memcg:ffff93ba245b8800
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: anon flags: 0x17fffe000020838(uptodate|dirty|lru|owner_2|swapbacked|node=0|zone=2|lastcpupid=0x1ffff)
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: raw: 017fffe000020838 ffffe59008475f88 ffffe59008476008 ffff93ba2abca5b1
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: raw: 00000007f589dd7f 0000000000000000 0000000100000000 ffff93ba245b8800
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: ------------[ cut here ]------------
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: kernel BUG at mm/filemap.c:1509!
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CPU: 2 UID: 0 PID: 74 Comm: ksmd Not tainted 6.11.0-rc5-next-20240827 #56
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RIP: 0010:folio_unlock+0x43/0x50
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Code: 93 fc ff ff f0 80 30 01 78 06 5b c3 cc cc cc cc 48 89 df 31 f6 5b e9 dc fc ff ff 48 c7 c6 a0 56 49 89 48 89 df e8 2d 03 05 00 <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RSP: 0018:ffffbb1dc02afe38 EFLAGS: 00010246
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RAX: 000000000000003f RBX: ffffe59008475fc0 RCX: 0000000000000000
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000003
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: R10: ffffbb1dc02afce0 R11: ffffffff896c3608 R12: ffffe59008475fc0
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: R13: 0000000000000000 R14: ffffe59008470000 R15: ffffffff89f88060
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: FS:  0000000000000000(0000) GS:ffff93c15fc80000(0000) knlGS:0000000000000000
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CR2: 0000558e368d9c48 CR3: 000000010ca66004 CR4: 0000000000770ef0
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: PKRU: 55555554
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Call Trace:
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  <TASK>
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? die+0x32/0x80
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? do_trap+0xd9/0x100
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? do_error_trap+0x6a/0x90
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? exc_invalid_op+0x4c/0x60
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? asm_exc_invalid_op+0x16/0x20
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ksm_scan_thread+0x175b/0x1d30
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_ksm_scan_thread+0x10/0x10
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  kthread+0xda/0x110
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_kthread+0x10/0x10
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ret_from_fork+0x2d/0x50
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_kthread+0x10/0x10
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ret_from_fork_asm+0x1a/0x30
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  </TASK>
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Modules linked in: xfs nvme_fabrics 9p kvm_intel kvm crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd pcspkr 9pnet_virtio joydev virtio_balloon virtio_console evdev button serio_raw drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod virtio_net net_failover virtio_blk failover nvme psmouse crc32_pclmul crc32c_intel nvme_core virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: ---[ end trace 0000000000000000 ]---
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RIP: 0010:folio_unlock+0x43/0x50
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Code: 93 fc ff ff f0 80 30 01 78 06 5b c3 cc cc cc cc 48 89 df 31 f6 5b e9 dc fc ff ff 48 c7 c6 a0 56 49 89 48 89 df e8 2d 03 05 00 <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RSP: 0018:ffffbb1dc02afe38 EFLAGS: 00010246
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RAX: 000000000000003f RBX: ffffe59008475fc0 RCX: 0000000000000000
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000003
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: R10: ffffbb1dc02afce0 R11: ffffffff896c3608 R12: ffffe59008475fc0
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: R13: 0000000000000000 R14: ffffe59008470000 R15: ffffffff89f88060
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: FS:  0000000000000000(0000) GS:ffff93c15fc80000(0000) knlGS:0000000000000000
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CR2: 0000558e368d9c48 CR3: 000000010ca66004 CR4: 0000000000770ef0
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: PKRU: 55555554

Looking at the KSM code in context ksm_scan_thread+0x175 is mm/ksm.c routine
cmp_and_merge_page() on the split case:

                } else if (split) {                                             
                        /*                                                      
                         * We are here if we tried to merge two pages and       
                         * failed because they both belonged to the same        
                         * compound page. We will split the page now, but no    
                         * merging will take place.                             
                         * We do not want to add the cost of a full lock; if    
                         * the page is locked, it is better to skip it and      
                         * perhaps try again later.                             
                         */                                                     
                        if (!trylock_page(page))                                
                                return;                                         
                        split_huge_page(page);                                  
                        unlock_page(page);                                      
                }

The trylock_page() is faulty. I'm digging in further.

  Luis

