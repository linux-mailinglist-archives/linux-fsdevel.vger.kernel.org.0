Return-Path: <linux-fsdevel+bounces-46127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C782A82D9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4A8189EB80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F75270ECA;
	Wed,  9 Apr 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If6AOTs4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF21BD517;
	Wed,  9 Apr 2025 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219817; cv=none; b=R6LD03ofzo3b7ECua4CtG0NsI1dEfCXnqL5iZHYmoNVWh3yqT0xHbNCF3jfXMxmmZqtgOJG61n+qM+rEdMZwG76AAEc8OgFHsMNcL98tCNVq9I4zN4q2at24wF/mKNpo6YXFAKIHBSg49xkzQ0Kw38pcH9ZFd7BjRdsf/mwPcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219817; c=relaxed/simple;
	bh=D8EdIIavIFCJOLcZ0muMdtbDxkJ45uofzZdjNy/oNoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvGCC78H9d9Xy4unnJQVt5UPbYTZwcmp7TbtVpDYYhUnFAVoyYDx2Z9ues9sqbtayWfwRY7UjwJx1Nx1wCu3VSgA7FPF8HaH3b57aNtbYU6LwLJRwsw0QAKuhkVZbrfDgnUUzS3njx8wPOrdtNxMU+IIibIyExXHG5ahB3n6bWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If6AOTs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EF2C4CEE2;
	Wed,  9 Apr 2025 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744219816;
	bh=D8EdIIavIFCJOLcZ0muMdtbDxkJ45uofzZdjNy/oNoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=If6AOTs4xskBSRRPUh7QTQAkclSrz8MYTk+qVhDkMyubNTHbtLjJNa4CdXG+1h2mG
	 mf87/fEovpzVPE0CW18Kb2hEd7A545ceySogYl7G7W/9Q5MnXDIjcd0NyVsrEViwX4
	 8z4Pozra2msuwj4Dh3Rt+Ki/T+iFTo/0RT7ShT0NQfL3/p22oquTlJZ1xfbmAFujYb
	 NYV8t51JvbwVbb/cZ/PtJB7N0FNo2U4g1+vnN+xb61UUeAnS037F3YfB0Q//AGzTSO
	 fVDxp6LWlZxhEDsGtvQMF9XoGCsgnHAzuUjNjr61QmqHxoexAdH9zi41ydBqSsMDdh
	 +TI61Jg90CMcQ==
Date: Wed, 9 Apr 2025 10:30:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Weird blockdev crash in 6.15-rc1?
Message-ID: <20250409173015.GN6266@frogsfrogsfrogs>
References: <20250408175125.GL6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408175125.GL6266@frogsfrogsfrogs>

On Tue, Apr 08, 2025 at 10:51:25AM -0700, Darrick J. Wong wrote:
> Hi everyone,
> 
> I saw the following crash in 6.15-rc1 when running xfs/032 from fstests
> for-next.  I don't see it in 6.14.  I'll try to bisect, but in the
> meantime does this look familiar to anyone?  The XFS configuration is
> pretty boring:
> 
> MKFS_OPTIONS="-m autofsck=1, -n size=8192"
> MOUNT_OPTIONS="-o uquota,gquota,pquota"
> 
> (4k fsblocks, x64 host, directory blocks are 8k)
> 
> From the stack trace, it looks like the null pointer dereference is in
> this call to bdev_nr_sectors:
> 
> void guard_bio_eod(struct bio *bio)
> {
> 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
> 
> because bio->bi_bdev is NULL for some reason.  The crash itself seems to
> be from do_mpage_readpage around line 304:
> 
> alloc_new:
> 	if (args->bio == NULL) {
> 		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), opf,
> 				      gfp);
> 
> bdev is NULL here                     ^^^^
> 
> 		if (args->bio == NULL)
> 			goto confused;
> 		args->bio->bi_iter.bi_sector = first_block << (blkbits - 9);
> 	}
> 
> 	length = first_hole << blkbits;
> 	if (!bio_add_folio(args->bio, folio, length, 0)) {
> 		args->bio = mpage_bio_submit_read(args->bio);
> 		goto alloc_new;
> 	}
> 
> 	relative_block = block_in_file - args->first_logical_block;
> 	nblocks = map_bh->b_size >> blkbits;
> 	if ((buffer_boundary(map_bh) && relative_block == nblocks) ||
> 	    (first_hole != blocks_per_folio))
> 		args->bio = mpage_bio_submit_read(args->bio);
> 
> My guess is that there was no previous call to ->get_block and that
> blocks_per_folio == 0, so nobody ever actually set the local @bdev
> variable to a non-NULL value.  blocks_per_folio is perhaps zero because
> xfs/032 tried formatting with a sector size of 64k, which causes the
> bdev inode->i_blkbits to be set to 16, but for some reason we got a
> folio that wasn't 64k in size:
> 
> 	const unsigned blkbits = inode->i_blkbits;
> 	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
> 
> <shrug> That's just my conjecture for now.

Ok so overnight my debugging patch confirmed this hypothesis:

XFS (sda4): Mounting V5 Filesystem 8cf3c461-57b0-4bba-86ab-6dc13b8cdab0
XFS (sda4): Ending clean mount
XFS (sda4): Quotacheck needed: Please wait.
XFS (sda4): Quotacheck: Done.
XFS (sda4): Unmounting Filesystem 8cf3c461-57b0-4bba-86ab-6dc13b8cdab0
FARK bio_alloc with NULL bdev?! blkbits 13 fsize 4096 blocks_per_folio 0

willy told me to set CONFIG_DEBUG_VM=y and rerun xfs/032.  That
didn't turn anything up, so I decided to race it with:

	while sleep 0.1; do blkid -c /dev/null; done

to simulate udev calling libblkid.  That produced a debugging assertion
with 40 seconds:

page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x4f3bc4 pfn:0x43da4
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880446b4800
flags: 0x4fff80000000041(locked|head|node=1|zone=1|lastcpupid=0xfff)
raw: 04fff80000000041 0000000000000000 dead000000000122 0000000000000000
raw: 00000000004f3bc4 0000000000000000 00000001ffffffff ffff8880446b4800
head: 04fff80000000041 0000000000000000 dead000000000122 0000000000000000
head: 00000000004f3bc4 0000000000000000 00000001ffffffff ffff8880446b4800
head: 04fff80000000201 ffffea00010f6901 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1))
------------[ cut here ]------------
kernel BUG at mm/filemap.c:871!
Oops: invalid opcode: 0000 [#1] SMP
CPU: 3 UID: 0 PID: 26689 Comm: (udev-worker) Not tainted 6.15.0-rc1-djwx #rc1 PREEMPT(lazy)  8c302df0300eabbbd3cdc47fd812690b8d635c39
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__filemap_add_folio+0x4ae/0x540
Code: 40 49 89 d4 0f b6 c1 49 d3 ec 81 e1 c0 00 00 00 0f 84 e0 fb ff ff e9 92 b6 d3 ff 48 c7 c6 68 57 ec 81 4c 89 ef e8 82 6e 05 00 <0f> 0b 49 89 d4 e9 c2 fb ff ff 48 c7 c6 9
RSP: 0018:ffffc900016e3a70 EFLAGS: 00010246
RAX: 0000000000000049 RBX: 0000000000112cc0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000ffffffff
RBP: 0000000000000001 R08: 0000000000000000 R09: 205d313431343737
R10: 0000000000000729 R11: 6d75642065676170 R12: 00000000004f3ba8
R13: ffffea00010f6900 R14: ffff88804076a530 R15: ffff88804076a530
FS:  00007f8863b788c0(0000) GS:ffff8880fb952000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cf459d5000 CR3: 000000000d96f003 CR4: 00000000001706f0
Call Trace:
 <TASK>
 ? memcg_list_lru_alloc+0x2d0/0x2d0
 filemap_add_folio+0x7f/0xd0
 page_cache_ra_unbounded+0x147/0x260
 force_page_cache_ra+0x92/0xb0
 filemap_get_pages+0x13b/0x7b0
 ? current_time+0x3b/0x110
 filemap_read+0x106/0x4c0
 ? _raw_spin_unlock+0x14/0x30
 blkdev_read_iter+0x64/0x120
 vfs_read+0x290/0x390
 ksys_read+0x6f/0xe0
 do_syscall_64+0x47/0x100
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f886428025d
Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d a6 53 0a 00 e8 59 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 81 23 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f c
RSP: 002b:00007fff5ce76228 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055cf45839640 RCX: 00007f886428025d
RDX: 0000000000040000 RSI: 000055cf45996908 RDI: 000000000000000f
RBP: 00000004f3b80000 R08: 00007f886435add0 R09: 00007f886435add0
R10: 0000000000000000 R11: 0000000000000246 R12: 000055cf459968e0
R13: 0000000000040000 R14: 000055cf45839698 R15: 000055cf459968f8
 </TASK>
Modules linked in: xfs ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables nfnet]
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:__filemap_add_folio+0x4ae/0x540
Code: 40 49 89 d4 0f b6 c1 49 d3 ec 81 e1 c0 00 00 00 0f 84 e0 fb ff ff e9 92 b6 d3 ff 48 c7 c6 68 57 ec 81 4c 89 ef e8 82 6e 05 00 <0f> 0b 49 89 d4 e9 c2 fb ff ff 48 c7 c6 9
RSP: 0018:ffffc900016e3a70 EFLAGS: 00010246
RAX: 0000000000000049 RBX: 0000000000112cc0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000ffffffff
RBP: 0000000000000001 R08: 0000000000000000 R09: 205d313431343737
R10: 0000000000000729 R11: 6d75642065676170 R12: 00000000004f3ba8
R13: ffffea00010f6900 R14: ffff88804076a530 R15: ffff88804076a530
FS:  00007f8863b788c0(0000) GS:ffff8880fb952000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cf459d5000 CR3: 000000000d96f003 CR4: 00000000001706f0

Digging into the VM, I noticed that mount is stuck in D state:

/proc/44312/task/44312/stack :
[<0>] folio_wait_bit_common+0x144/0x350
[<0>] truncate_inode_pages_range+0x4df/0x5b0
[<0>] set_blocksize+0x10b/0x130
[<0>] xfs_setsize_buftarg+0x1f/0x50 [xfs]
[<0>] xfs_setup_devices+0x1a/0xc0 [xfs]
[<0>] xfs_fs_fill_super+0x423/0xb20 [xfs]
[<0>] get_tree_bdev_flags+0x132/0x1d0
[<0>] vfs_get_tree+0x17/0xa0
[<0>] path_mount+0x721/0xa90
[<0>] __x64_sys_mount+0x10c/0x140
[<0>] do_syscall_64+0x47/0x100
[<0>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

Regrettably the udev worker is gone, but my guess is that the process
exited with the folio locked, so now truncate_inode_pages_range can't
lock it to get rid of it.

Then it occurred to me to look at set_blocksize again:

	/* Don't change the size if it is same as current */
	if (inode->i_blkbits != blksize_bits(size)) {
		sync_blockdev(bdev);
		inode->i_blkbits = blksize_bits(size);
		mapping_set_folio_order_range(inode->i_mapping,
				get_order(size), get_order(size));
		kill_bdev(bdev);
	}

(Note that I changed mapping_set_folio_min_order here to
mapping_set_folio_order_range to shut up a folio migration bug that I
reported elsewhere on fsdevel yesterday, and willy suggested forcing the
max order as a temporary workaround.)

The update of i_blkbits and the order bits of mapping->flags are
performed before kill_bdev truncates the pagecache, which means there's
a window where there can be a !uptodate order-0 folio in the pagecache
but i_blkbits > PAGE_SHIFT (in this case, 13).  The debugging assertion
above is from someone trying to install a too-small folio into the
pagecache.  I think the "FARK" message I captured overnight is from
readahead trying to bring in contents from disk for this too-small folio
and failing.

So I think the answer is that set_blocksize needs to lock out folio_add,
flush the dirty folios, invalidate the entire bdev pagecache, set
i_blkbits and the folio order, and only then allow new additions to the
pagecache.

But then, which lock(s)?  Were this a file on XFS I'd say that one has
to take i_rwsem and mmap_invalidate_lock before truncating the pagecache
but by my recollection bdev devices don't take either lock in their IO
paths.

--D

