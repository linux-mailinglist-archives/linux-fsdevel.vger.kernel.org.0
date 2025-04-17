Return-Path: <linux-fsdevel+bounces-46637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23162A9233E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2EB179FD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F9F2550B6;
	Thu, 17 Apr 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQlJzcRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A3254AF2;
	Thu, 17 Apr 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909164; cv=none; b=b1aWOXPSezZ2yGB1DV5Tkhxh52heLMMNDNhYqlhrSjKeOVtPmJEpA+E0dnQqASBHyxVO4JUXerm4/MmuXUSNPlj8fidJnyKZTqZBAWOliWTAxaDA72KrVi4iYv6UmB3LmJTEyRl9GwCYWUmnpJbcqmi/h1uggKThBN1bEW8QeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909164; c=relaxed/simple;
	bh=xec3dp/RIC77JMfS+/MvOqoTbbrCHx+7lWaIlF01YIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBgsUPOTpjH5hWWmvEYdiCMiRJrRjCLWB3StUTOgLA0ngB0OOq4/1qyXsdfzmbk+bHzOiAvmsFAcza96ojFoFVNcJhD1vXLFkzfqUurPfzBeaPPee3Q9IE+qrbIc3uhxKMO+cQ/cDtKcRwQWFn6JnPESJoKbu9Idt4mb93geP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQlJzcRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85746C4CEE4;
	Thu, 17 Apr 2025 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744909163;
	bh=xec3dp/RIC77JMfS+/MvOqoTbbrCHx+7lWaIlF01YIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQlJzcRvwtVJ50wjbgpc8FBJfKZKTKGOGcwZBvMdvPH155Vnh7X+51pfJ6DDz0Bt9
	 jTLinN9D10NhKUC3vf/buG44vlmkialuPpLJwVqWi6lyHk1b/2E9jsyfYkkAglUV8J
	 FCgKriH5+2jh+7TMZZJNbKlCaFNg+t7e+K8HiOk9sFLCbViEi0OwsVxIPmd2dVhD4x
	 w+4w5O8YmQ8UtDKAcpAPiRmIwx3kVzK4skofeqUxruDetChOZh7WNo78/fhkpON4qK
	 IB0MGbYkBLU8VG4CJzG11rpAHwgOZHdgrll2E4MVmlDshoHfj+itItSfD8qtgRAZd9
	 myRck0O6wGecw==
Date: Thu, 17 Apr 2025 09:59:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [6.15-rc2 regression] iomap: null pointer in a bio completion
Message-ID: <20250417165922.GQ25675@frogsfrogsfrogs>
References: <20250416180837.GN25675@frogsfrogsfrogs>
 <Z__5LOpee2-5rIaE@casper.infradead.org>
 <20250416202126.GD25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416202126.GD25659@frogsfrogsfrogs>

[cc linux-mm for more fun]

On Wed, Apr 16, 2025 at 01:21:26PM -0700, Darrick J. Wong wrote:
> On Wed, Apr 16, 2025 at 07:38:36PM +0100, Matthew Wilcox wrote:
> > On Wed, Apr 16, 2025 at 11:08:37AM -0700, Darrick J. Wong wrote:
> > > Hi folks,
> > > 
> > > I upgraded my arm64 kernel to 6.15-rc2, and I also see this splat in
> > > generic/363.  The fstets config is as follows:
> > > 
> > > MKFS_OPTIONS="-m metadir=1,autofsck=1,uquota,gquota,pquota, -b size=65536,"
> > > MOUNT_OPTIONS=""
> > > 
> > > The VM is arm64 with 64k base pages.  I've disabled LBS to work around
> > > a fair number of other strange bugs.  Does this ring a bell for anyone?
> > > 
> > > --D
> > > 
> > > list_add double add: new=ffffffff40538c88, prev=fffffc03febf8148, next=ffffffff40538c88.
> > 
> > Not a bell, but it's weird.  We're trying to add ffffffff40538c88 to
> > the list, but next already has that value.  So this is a double-free of
> > the folio?  Do you have VM_BUG_ON_FOLIO enabled with CONFIG_VM_DEBUG?
> 
> Nope, but I can go re-add it to my kconfig and see what happens.

Note: I still have LBS disabled on all kernels by setting
BLK_MAX_BLOCK_SIZE to PAGE_SIZE.

Ok, so an arm64 VM running a standard xfs filesystem with 64k fsblocks
coughed this up:

[27044.508369] run fstests xfs/565 at 2025-04-16 21:40:09
[27044.700177] spectre-v4 mitigation disabled by command-line option
[27045.648181] XFS (sda2): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!
[27046.227911] XFS (sda3): EXPERIMENTAL metadata directory tree feature enabled.  Use at your own risk!
[27046.227925] XFS (sda3): EXPERIMENTAL exchange range feature enabled.  Use at your own risk!
[27046.227929] XFS (sda3): EXPERIMENTAL parent pointer feature enabled.  Use at your own risk!
[27046.229149] XFS (sda3): Mounting V5 Filesystem 14008600-4e22-41d0-822a-3de7da9c381c
[27046.304188] XFS (sda3): Ending clean mount
[27046.308836] XFS (sda3): Quotacheck needed: Please wait.
[27046.317504] XFS (sda3): Quotacheck: Done.
[27046.362899] XFS (sda3): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!
[27065.826372] BUG: Bad page s
** replaying previous printk message **
[27065.826372] BUG: Bad page state in process fsx  pfn:26045
[27065.826392] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7 pfn:0x26045
[27065.826399] flags: 0x1ffe10000000000e(referenced|uptodate|writeback|node=0|zone=1|lastcpupid=0x7ff)
[27065.826404] raw: 1ffe10000000000e dead000000000100 dead000000000122 0000000000000000
[27065.826407] raw: 0000000000000007 0000000000000000 00000000ffffffff 0000000000000000
[27065.826408] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[27065.826410] Modules linked in: dm_snapshot dm_zero dm_delay btrfs blake2b_generic xor xor_neon lzo_compress lzo_decompress zlib_deflate raid6_pq zstd_compress ext4 crc16 mbcache jbd2 dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac nf_tables sha2_ce sha256_arm64 bfq sch_fq_codel loop fuse configfs efivarfs ip_tables x_tables overlay nfsv4 [last unloaded: scsi_debug]
[27065.826442] CPU: 1 UID: 0 PID: 3601528 Comm: fsx Tainted: G        W           6.15.0-rc2-xfsa #rc2 PREEMPT  ec95dfdc82195810701b8f14bbdb4ba4e6ea2c8d
[27065.826446] Tainted: [W]=WARN
[27065.826447] Hardware name: QEMU KVM Virtual Machine, BIOS 1.6.6 08/22/2023
[27065.826448] Call trace:
[27065.826449]  show_stack+0x20/0x38 (C)
[27065.826455]  dump_stack_lvl+0x78/0x90
[27065.826459]  dump_stack+0x18/0x28
[27065.826460]  bad_page+0x8c/0x138
[27065.826464]  free_page_is_bad_report+0xa8/0xc0
[27065.826466]  free_unref_folios+0x5c8/0x860
[27065.826469]  folios_put_refs+0x148/0x270
[27065.826472]  __folio_batch_release+0x58/0x70
[27065.826474]  writeback_iter+0x32c/0x348
[27065.826476]  iomap_writepages+0x834/0xad0
[27065.826479]  xfs_vm_writepages+0x9c/0x128 [xfs 136e69c8bf79e8d93fbbc1bf83b8832fd3bc0371]
[27065.826586]  do_writepages+0x90/0x2d0
[27065.826587]  filemap_fdatawrite_wbc+0x74/0xa0
[27065.826590]  __filemap_fdatawrite_range+0x68/0xa0
[27065.826592]  file_write_and_wait_range+0x70/0xe8
[27065.826594]  xfs_file_fsync+0x60/0x290 [xfs 136e69c8bf79e8d93fbbc1bf83b8832fd3bc0371]
[27065.826681]  vfs_fsync_range+0x3c/0x90
[27065.826684]  __arm64_sys_msync+0x1cc/0x2e8
[27065.826687]  do_el0_svc+0x74/0x110
[27065.826690]  el0_svc+0x44/0x1e0
[27065.826693]  el0t_64_sync_handler+0x10c/0x138
[27065.826696]  el0t_64_sync+0x198/0x1a0
[27065.826698] Disabling lock debugging due to kernel taint
[27065.832180] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7 pfn:0x26045
[27065.832185] flags: 0x1ffe10000000000e(referenced|uptodate|writeback|node=0|zone=1|lastcpupid=0x7ff)
[27065.832188] raw: 1ffe10000000000e dead000000000100 dead000000000122 0000000000000000
[27065.832190] raw: 0000000000000007 0000000000000000 00000000ffffffff 0000000000000000
[27065.832191] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
[27065.832197] ------------[ cut here ]------------
[27065.832198] kernel BUG at include/linux/mm.h:1526!
[27065.832200] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[27065.979828] Dumping ftrace buffer:
[27065.981195]    (ftrace buffer empty)
[27065.982650] Modules linked in: dm_snapshot dm_zero dm_delay btrfs blake2b_generic xor xor_neon lzo_compress lzo_decompress zlib_deflate raid6_pq zstd_compress ext4 crc16 mbcache jbd2 dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac nf_tables sha2_ce sha256_arm64 bfq sch_fq_codel loop fuse configfs efivarfs ip_tables x_tables overlay nfsv4 [last unloaded: scsi_debug]
[27066.010042] CPU: 1 UID: 0 PID: 3574426 Comm: 1:34 Tainted: G    B   W           6.15.0-rc2-xfsa #rc2 PREEMPT  ec95dfdc82195810701b8f14bbdb4ba4e6ea2c8d
[27066.016826] Tainted: [B]=BAD_PAGE, [W]=WARN
[27066.018938] Hardware name: QEMU KVM Virtual Machine, BIOS 1.6.6 08/22/2023
[27066.021912] Workqueue: xfs-conv/sda3 xfs_end_io [xfs]
[27066.024902] pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
[27066.028280] pc : folio_end_writeback+0x204/0x240
[27066.030746] lr : folio_end_writeback+0x204/0x240
[27066.032827] sp : fffffe0088cefbb0
[27066.034563] x29: fffffe0088cefbb0 x28: 0000000000000000 x27: 0000000000010000
[27066.038368] x26: ffffffff40881180 x25: ffffffff40881140 x24: 0000000000010000
[27066.042648] x23: 0000000000000000 x22: fffffc01e0cec470 x21: fffffc018e7e7350
[27066.046639] x20: fffffc018e7e7300 x19: ffffffff40881140 x18: 0000000000000010
[27066.050633] x17: 635f6665725f6f69 x16: 6c6f662029746e69 x15: 2064656e6769736e
[27066.054020] x14: 752828284f494c4f x13: 292975373231203d x12: fffffe0081324268
[27066.057289] x11: 000000000089f660 x10: 000000000089f5f8 x9 : fffffe00800e4240
[27066.061380] x8 : c00000010001d054 x7 : fffffe0081319068 x6 : 0000000000001ce0
[27066.065461] x5 : fffffe008131af48 x4 : 0000000000000000 x3 : 0000000000000000
[27066.069318] x2 : 0000000000000000 x1 : fffffc00ec6f5400 x0 : 000000000000005c
[27066.073423] Call trace:
[27066.074840]  folio_end_writeback+0x204/0x240 (P)
[27066.077449]  iomap_finish_ioend_buffered+0x134/0x3b8
[27066.080512]  iomap_finish_ioend+0x64/0xf8
[27066.082947]  iomap_finish_ioends+0x80/0x138
[27066.085147]  xfs_end_ioend+0x84/0x258 [xfs 136e69c8bf79e8d93fbbc1bf83b8832fd3bc0371]
[27066.089783]  xfs_end_io+0xd0/0x128 [xfs 136e69c8bf79e8d93fbbc1bf83b8832fd3bc0371]
[27066.094129]  process_one_work+0x184/0x408
[27066.095509]  worker_thread+0x268/0x388
[27066.097437]  kthread+0x144/0x210
[27066.099299]  ret_from_fork+0x10/0x20
[27066.101216] Code: aa1303e0 d0005241 9107e021 9401567c (d4210000) 
[27066.104634] ---[ end trace 0000000000000000 ]---
[27066.107292] note: 1:34[3574426] exited with irqs disabled
[27066.107380] note: 1:34[3574426] exited with preempt_count 1

(No idea what's gone wrong here.)

A separate x86_64 VM with an external log (probably not relevant here)
hit a different debugging assertion:

[15965.251834] run fstests xfs/167 at 2025-04-16 18:37:00
[15967.100442] XFS (sda4): EXPERIMENTAL metadata directory tree feature enabled.  Use at your own risk!
[15967.105284] XFS (sda4): EXPERIMENTAL exchange range feature enabled.  Use at your own risk!
[15967.108134] XFS (sda4): EXPERIMENTAL parent pointer feature enabled.  Use at your own risk!
[15967.112252] XFS (sda4): Mounting V5 Filesystem aee6c79a-2f1e-4745-8482-a6d8afe83ac4
[15967.143277] XFS (sda4): Ending clean mount
[15967.148020] XFS (sda4): Quotacheck needed: Please wait.
[15967.155249] XFS (sda4): Quotacheck: Done.
[15970.205635] page: refcount:9 mapcount:0 mapping:ffff8882fb216710 index:0x298 pfn:0x154598
[15970.233230] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[15970.262936] memcg:ffff8881ad88a000
[15970.275270] aops:xfs_address_space_operations [xfs] ino:6000097 dentry name(?):"f9"
[15970.298922] flags: 0x17ff90000000078(uptodate|dirty|lru|head|node=0|zone=2|lastcpupid=0xfff)
[15970.307315] raw: 017ff90000000078 ffffea0007a2fb08 ffff8881ad88f180 ffff8882fb216710
[15970.319416] raw: 0000000000000298 0000000000000000 00000009ffffffff ffff8881ad88a000
[15970.336475] head: 017ff90000000078 ffffea0007a2fb08 ffff8881ad88f180 ffff8882fb216710
[15970.339826] head: 0000000000000298 0000000000000000 00000009ffffffff ffff8881ad88a000
[15970.346704] head: 017ff80000000203 ffffea0005516601 00000000ffffffff 00000000ffffffff
[15970.351991] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[15970.357011] page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
[15970.359605] ------------[ cut here ]------------
[15970.362354] kernel BUG at mm/filemap.c:1498!
[15970.365541] Oops: invalid opcode: 0000 [#1] SMP
[15970.370049] CPU: 3 UID: 0 PID: 3942619 Comm: fsstress Tainted: G        W           6.15.0-rc2-xfsx #rc2 PREEMPT(lazy)  04eaac2a75eb2d6e3a8956ee16f846a788b85520
[15970.377554] Tainted: [W]=WARN
[15970.378528] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
[15970.381940] RIP: 0010:folio_unlock+0x26/0x30
[15970.383238] Code: 1f 44 00 00 0f 1f 44 00 00 48 8b 07 a8 01 74 0e f0 80 37 01 78 01 c3 31 f6 e9 a6 f9 ff ff 48 c7 c6 e0 10 ec 81 e8 3a 68 05 00 <0f> 0b 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 c3 66 2e 0f 1f 84 00
[15970.388747] RSP: 0018:ffffc9000590bca0 EFLAGS: 00010246
[15970.390635] RAX: 000000000000003f RBX: ffffea0005516600 RCX: 0000000000000000
[15970.393035] RDX: 0000000000000000 RSI: ffffffff81eba76a RDI: 00000000ffffffff
[15970.395565] RBP: 0000000000000000 R08: 0000000000000000 R09: 205d313130373533
[15970.399975] R10: 6163656220646570 R11: 6d75642065676170 R12: 0000000000298000
[15970.409272] R13: 0000000000200000 R14: 0000000000008000 R15: ffffea0005516600
[15970.424310] FS:  00007fdbc79cd740(0000) GS:ffff8884aa9d6000(0000) knlGS:0000000000000000
[15970.444038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15970.451996] CR2: 00007f1246c92380 CR3: 00000001248d1000 CR4: 00000000003506f0
[15970.462591] Call Trace:
[15970.466654]  <TASK>
[15970.470148]  __iomap_put_folio.isra.0+0x2b/0x60
[15970.476981]  iomap_file_buffered_write+0x2be/0x4a0
[15970.483051]  xfs_file_buffered_write+0x83/0x2f0 [xfs 231e2a102a6454d3e21b4636268dc4f5eb5721b0]
[15970.494560]  vfs_write+0x291/0x470
[15970.499144]  ksys_write+0x6f/0xe0
[15970.503534]  do_syscall_64+0x37/0xf0
[15970.508349]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[15970.515526] RIP: 0033:0x7fdbc7ac8300
[15970.520945] Code: 40 00 48 8b 15 01 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d e1 22 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[15970.548210] RSP: 002b:00007ffde969b448 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[15970.558763] RAX: ffffffffffffffda RBX: 0000000000010e60 RCX: 00007fdbc7ac8300
[15970.568419] RDX: 0000000000010e60 RSI: 000055de855bcc00 RDI: 0000000000000005
[15970.578464] RBP: 0000000000000179 R08: 000055de855d7ff0 R09: 00007fdbc7ba3450
[15970.589319] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffde969b510
[15970.598442] R13: 0000000000000005 R14: 000055de855bcc00 R15: 0000000000000000
[15970.607348]  </TASK>
[15970.610324] Modules linked in: ext4 crc16 mbcache jbd2 dm_zero dm_delay btrfs blake2b_generic xor lzo_compress lzo_decompress zlib_deflate raid6_pq zstd_compress dm_thin_pool dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_flakey xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables nfnetlink bfq sha512_ssse3 sha512_generic sha256_ssse3 pvpanic_mmio pvpanic sch_fq_codel loop fuse configfs ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
[15970.694964] Dumping ftrace buffer:
[15970.701977]    (ftrace buffer empty)
[15970.709877] ---[ end trace 0000000000000000 ]---
[15970.732042] RIP: 0010:folio_unlock+0x26/0x30
[15970.747097] Code: 1f 44 00 00 0f 1f 44 00 00 48 8b 07 a8 01 74 0e f0 80 37 01 78 01 c3 31 f6 e9 a6 f9 ff ff 48 c7 c6 e0 10 ec 81 e8 3a 68 05 00 <0f> 0b 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 c3 66 2e 0f 1f 84 00
[15970.784542] RSP: 0018:ffffc9000590bca0 EFLAGS: 00010246
[15970.792617] RAX: 000000000000003f RBX: ffffea0005516600 RCX: 0000000000000000
[15970.805752] RDX: 0000000000000000 RSI: ffffffff81eba76a RDI: 00000000ffffffff
[15970.814534] RBP: 0000000000000000 R08: 0000000000000000 R09: 205d313130373533
[15970.823773] R10: 6163656220646570 R11: 6d75642065676170 R12: 0000000000298000
[15970.841278] R13: 0000000000200000 R14: 0000000000008000 R15: ffffea0005516600
[15970.859052] FS:  00007fdbc79cd740(0000) GS:ffff8884aa956000(0000) knlGS:0000000000000000
[15970.873825] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15970.887439] CR2: 00007fdbc79cc000 CR3: 00000001248d1000 CR4: 00000000003506f0
[15975.917484] XFS (sda3): Unmounting Filesystem 08bbb125-35b7-4b09-aa53-5951eb30a02b
[15976.293690] XFS (sda4): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!

iomap_write_iter calls __iomap_put_folio calls folio_unlock in the
middle of the do { } loop.  AFAICT neither iomap nor
copy_folio_from_iter_atomic unlock the folio, so someone else did.

--D

