Return-Path: <linux-fsdevel+bounces-18197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B68B6705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 02:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966151F239C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743923BF;
	Tue, 30 Apr 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xYcf92wD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF410E4;
	Tue, 30 Apr 2024 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438164; cv=none; b=hvWw6FChf4/YUlIKg/JMtZDu68fjpKtMPxo8p8lbFEnjiNjfUZmvr2OIY6EidWNsTb8qD95JVIqebv9cU8CwMn0V7Jt0cDx/prZYhiY+xB5V7/DG8VusMZxvD+OmFepSyV3fa1LuT8Ixflolo0UOpjd14ysZKn8cQwCZyhmZ2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438164; c=relaxed/simple;
	bh=1ZnxycjF5aJJNUh3uGI3IBzRxP4OLylDpSHlIFlyei4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t24ZIUE/er3XPit2KMgh5wfME5KVGBUF9I6FIJhhk+Xlk+L/iOmyWM7weYGyg8+/U0x9F/B6Y5QL5EgRfAX8F7vKJ4EfwuPQBUwW+ess0+XQDg5y6bt115TJS/Rg8IuMSgMRaKeKK2Pw491cabxGitV9erbZw3tovHUEewETQ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xYcf92wD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/c1sbvVaBUDze1Pl3sFIYhaVC3nbi9k6Ah2N+APLOAw=; b=xYcf92wDxo1sXFsJbXLMmjOASO
	9SlBiQ9z5r/49zk3b+EvMGH9yexOYmFKq0kAEBt1rfPwLdWb78vZXR0nED8Z1JzMtMpaBq/FNzy4B
	gWgzztjxifGdR3VBDJEF3r4sNXBYNLebckaDd5vzgJ3V6X25Fid8PJee5dKHlWI07N2zaov9KGHUn
	EpxQe/OZl6BYXqYb2/LYXFzbnztJmdzluzxVSXFCsZIBXuRJl9Ztb2OM7A3gVkhdYQzEYkX4KEaXN
	Ul9/ltDCM78L4+PBv0nL9gKvXBuah+HScTVyVckqt9JoeBgiQJBtrJmL1v45FDgHUCqeKr6ySHx2T
	9vSo4NSg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1bgK-00000004bNi-16q4;
	Tue, 30 Apr 2024 00:49:16 +0000
Date: Mon, 29 Apr 2024 17:49:16 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Sean Christopherson <seanjc@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <ZjBADFMehRG1U6ln@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
 <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
 <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
 <6799F341-9E37-4F3E-B0D0-B5B2138A5F5F@nvidia.com>
 <ZjA7yBQjkh52TM_T@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjA7yBQjkh52TM_T@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Apr 29, 2024 at 05:31:04PM -0700, Luis Chamberlain wrote:
> On Mon, Apr 29, 2024 at 10:29:29AM -0400, Zi Yan wrote:
> > On 28 Apr 2024, at 23:56, Luis Chamberlain wrote:
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index 73a052a382f1..83b528eb7100 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -1484,7 +1484,12 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
> > >  	int rc;
> > >
> > >  	folio_lock(folio);
> > > +	if (folio_test_dirty(folio)) {
> > > +		rc = -EBUSY;
> > > +		goto out;
> > > +	}
> > >  	rc = split_folio_to_list(folio, split_folios);
> > > +out:
> > >  	folio_unlock(folio);
> > >  	if (!rc)
> > >  		list_move_tail(&folio->lru, split_folios);
> > >
> > > However I'd like compaction folks to review this. I see some indications
> > > in the code that migration can race with truncation but we feel fine by
> > > it by taking the folio lock. However here we have a case where we see
> > > the folio clearly locked and the folio is dirty. Other migraiton code
> > > seems to write back the code and can wait, here we just move on. Further
> > > reading on commit 0003e2a414687 ("mm: Add AS_UNMOVABLE to mark mapping
> > > as completely unmovable") seems to hint that migration is safe if the
> > > mapping either does not exist or the mapping does exist but has
> > > mapping->a_ops->migrate_folio so I'd like further feedback on this.
> > 
> > During migration, all page table entries pointing to this dirty folio
> > are invalid, and accesses to this folio will cause page fault and
> > wait on the migration entry. I am not sure we need to skip dirty folios.

That would seem to explain why we get this, if we allow these to
continue, ie, without the hunk above, so it begs to ask, are we sure
we are waiting for migration to complete if we're doing writeback?

Apr 29 17:28:54 min-xfs-reflink-16k-4ks unknown: run fstests generic/447 at 2024-04-29 17:28:54
Apr 29 17:28:55 min-xfs-reflink-16k-4ks kernel: XFS (loop5): EXPERIMENTAL: Filesystem with Large Block Size (16384 bytes) enabled.
Apr 29 17:28:55 min-xfs-reflink-16k-4ks kernel: XFS (loop5): Mounting V5 Filesystem 89a3d14d-8147-455d-8897-927a0b7baf65
Apr 29 17:28:55 min-xfs-reflink-16k-4ks kernel: XFS (loop5): Ending clean mount
Apr 29 17:28:56 min-xfs-reflink-16k-4ks kernel: XFS (loop5): Unmounting Filesystem 89a3d14d-8147-455d-8897-927a0b7baf65
Apr 29 17:28:59 min-xfs-reflink-16k-4ks kernel: XFS (loop5): EXPERIMENTAL: Filesystem with Large Block Size (16384 bytes) enabled.
Apr 29 17:28:59 min-xfs-reflink-16k-4ks kernel: XFS (loop5): Mounting V5 Filesystem e29c3eee-18d1-4fec-9a17-076b3eccbd74
Apr 29 17:28:59 min-xfs-reflink-16k-4ks kernel: XFS (loop5): Ending clean mount
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: BUG: kernel NULL pointer dereference, address: 0000000000000036
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: #PF: supervisor read access in kernel mode
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: #PF: error_code(0x0000) - not-present page
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: PGD 0 P4D 0
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: CPU: 3 PID: 2245 Comm: kworker/u36:5 Not tainted 6.9.0-rc5+ #26
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: Workqueue: writeback wb_workfn (flush-7:5)
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: RIP: 0010:filemap_get_folios_tag (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-arch-fallback.h:2426 ./include/linux/atomic/atomic-arch-fallback.h:2456 ./include/linux/atomic/atomic-instrumented.h:1518 ./include/linux/page_ref.h:238 ./include/linux/page_ref.h:247 ./include/linux/page_ref.h:280 ./include/linux/page_ref.h:313 mm/filemap.c:1984 mm/filemap.c:2222) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: Code: ad 05 86 00 48 89 c3 48 3d 06 04 00 00 74 e8 48 81 fb 02 04 00 00 0f 84 d0 00 00 00 48 85 db 0f 84 04 01 00 00 f6 c3 01 75 c4 <8b> 43 34 85 c0 0f 84 b7 00 00 00 8d 50 01 48 8d 73 34 f0 0f b1 53
All code
========
   0:	ad                   	lods   %ds:(%rsi),%eax
   1:	05 86 00 48 89       	add    $0x89480086,%eax
   6:	c3                   	ret
   7:	48 3d 06 04 00 00    	cmp    $0x406,%rax
   d:	74 e8                	je     0xfffffffffffffff7
   f:	48 81 fb 02 04 00 00 	cmp    $0x402,%rbx
  16:	0f 84 d0 00 00 00    	je     0xec
  1c:	48 85 db             	test   %rbx,%rbx
  1f:	0f 84 04 01 00 00    	je     0x129
  25:	f6 c3 01             	test   $0x1,%bl
  28:	75 c4                	jne    0xffffffffffffffee
  2a:*	8b 43 34             	mov    0x34(%rbx),%eax		<-- trapping instruction
  2d:	85 c0                	test   %eax,%eax
  2f:	0f 84 b7 00 00 00    	je     0xec
  35:	8d 50 01             	lea    0x1(%rax),%edx
  38:	48 8d 73 34          	lea    0x34(%rbx),%rsi
  3c:	f0                   	lock
  3d:	0f                   	.byte 0xf
  3e:	b1 53                	mov    $0x53,%cl

Code starting with the faulting instruction
===========================================
   0:	8b 43 34             	mov    0x34(%rbx),%eax
   3:	85 c0                	test   %eax,%eax
   5:	0f 84 b7 00 00 00    	je     0xc2
   b:	8d 50 01             	lea    0x1(%rax),%edx
   e:	48 8d 73 34          	lea    0x34(%rbx),%rsi
  12:	f0                   	lock
  13:	0f                   	.byte 0xf
  14:	b1 53                	mov    $0x53,%cl
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: RSP: 0018:ffffad0a0396b8f8 EFLAGS: 00010246
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: RAX: 0000000000000002 RBX: 0000000000000002 RCX: 00000000000ba200
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: RDX: 0000000000000002 RSI: 0000000000000002 RDI: ffff9f408d20d488
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000000
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: R10: 0000000000000228 R11: 0000000000000000 R12: ffffffffffffffff
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: R13: ffffad0a0396bbb8 R14: ffffad0a0396bcb8 R15: ffff9f40633bfc00
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: FS:  0000000000000000(0000) GS:ffff9f40bbcc0000(0000) knlGS:0000000000000000
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: CR2: 0000000000000036 CR3: 000000010bd44006 CR4: 0000000000770ef0
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: PKRU: 55555554
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: Call Trace:
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel:  <TASK>
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? page_fault_oops (arch/x86/mm/fault.c:713) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? write_cache_pages (mm/page-writeback.c:2569) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? xfs_vm_writepages (fs/xfs/xfs_aops.c:508) xfs
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? do_user_addr_fault (./include/linux/kprobes.h:591 (discriminator 1) arch/x86/mm/fault.c:1265 (discriminator 1)) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? exc_page_fault (./arch/x86/include/asm/paravirt.h:693 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1563) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? filemap_get_folios_tag (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-arch-fallback.h:2426 ./include/linux/atomic/atomic-arch-fallback.h:2456 ./include/linux/atomic/atomic-instrumented.h:1518 ./include/linux/page_ref.h:238 ./include/linux/page_ref.h:247 ./include/linux/page_ref.h:280 ./include/linux/page_ref.h:313 mm/filemap.c:1984 mm/filemap.c:2222) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? filemap_get_folios_tag (mm/filemap.c:1972 mm/filemap.c:2222) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? __pfx_iomap_do_writepage (fs/iomap/buffered-io.c:1963) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: writeback_iter (./include/linux/pagevec.h:91 mm/page-writeback.c:2421 mm/page-writeback.c:2520) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: write_cache_pages (mm/page-writeback.c:2568) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: iomap_writepages (fs/iomap/buffered-io.c:1984) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: xfs_vm_writepages (fs/xfs/xfs_aops.c:508) xfs
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: do_writepages (mm/page-writeback.c:2612) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: __writeback_single_inode (fs/fs-writeback.c:1659) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: writeback_sb_inodes (fs/fs-writeback.c:1943) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: __writeback_inodes_wb (fs/fs-writeback.c:2013) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: wb_writeback (fs/fs-writeback.c:2119) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: wb_workfn (fs/fs-writeback.c:2277 (discriminator 1) fs/fs-writeback.c:2304 (discriminator 1)) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: kthread (kernel/kthread.c:388) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel:  </TASK>
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: Modules linked in: xfs nvme_fabrics nvme_core t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sunrpc 9p netfs kvm_intel kvm crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_intel crypto_simd cryptd virtio_balloon pcspkr 9pnet_virtio virtio_console button evdev joydev serio_raw loop drm dm_mod autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod virtio_net net_failover failover virtio_blk crc32_pclmul crc32c_intel psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: CR2: 0000000000000036
Apr 29 17:29:20 min-xfs-reflink-16k-4ks kernel: ---[ end trace 0000000000000000 ]---

