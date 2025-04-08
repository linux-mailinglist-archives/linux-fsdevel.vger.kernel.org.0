Return-Path: <linux-fsdevel+bounces-46014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B029FA81403
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AED37BA298
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFD23E227;
	Tue,  8 Apr 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZaRkWNY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D16230242;
	Tue,  8 Apr 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134686; cv=none; b=K+x2a+yQX3cSH38e+kAtTEoX3i7sSvR98HIteWNUzGy5tXLbjcxqvIstk2ijdfRKjEa4UVDcSWKOMsm+3S3llJQi+NaxH8ArSKjh1RfBt8OM5eQCGEbsvYA3imULVSafMf++wTpZgddOoSes2P7EC3gSEDRXemRudp+Tg1ziLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134686; c=relaxed/simple;
	bh=UxEBvufb6vHFE7FhmCn85o4dAGl4/IPZA2oTcW7NdPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gqjp4U3nLHMq0QZrYfzsUmygdfskNLwIyScIqHpRIk01iLfcMfRfOSZ5fUdj/Voqn5jzhM95P14+ulk9cBMBLf2X5iovN32UUvELwEYFM2S+ujqDTGR2+76JevpXVENE4WQM3tafA9ju8tQOqPBW366vhisUACtwt6OcJLf8v7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZaRkWNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F30C4CEE8;
	Tue,  8 Apr 2025 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744134686;
	bh=UxEBvufb6vHFE7FhmCn85o4dAGl4/IPZA2oTcW7NdPc=;
	h=Date:From:To:Cc:Subject:From;
	b=BZaRkWNYDWDPQ8WPhthSPBvRD9R/uhnM3svxX1I2wwTBfOxky12RwtlY4mDpPylw6
	 T11YDC1DUVtNAWfwtwCEEQCw7ZukGt+tYIqnz5zyaHdx/HLxNNd2msmnP2ly+d+aVl
	 Uw0v6DP2toxwgMismhuKQu0utSbz54Aem+Nqr2iq47l0zdRRdN5tEPHJQdMlsEpvTg
	 +wL3eAmuVAOZgud5yrnUJrCqt/JmcjpoE/jfKCL8FXQ5znVrq9+t+/nSs04pfIWfjI
	 nlw7L52+1zpRvUHk0bu6HOog6YvB218UJbCKSSg6Ekxq9LR+cQJhNr9g9FWYwVDiQH
	 Q8qtA/9up3l+g==
Date: Tue, 8 Apr 2025 10:51:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Weird blockdev crash in 6.15-rc1?
Message-ID: <20250408175125.GL6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

I saw the following crash in 6.15-rc1 when running xfs/032 from fstests
for-next.  I don't see it in 6.14.  I'll try to bisect, but in the
meantime does this look familiar to anyone?  The XFS configuration is
pretty boring:

MKFS_OPTIONS="-m autofsck=1, -n size=8192"
MOUNT_OPTIONS="-o uquota,gquota,pquota"

(4k fsblocks, x64 host, directory blocks are 8k)

From the stack trace, it looks like the null pointer dereference is in
this call to bdev_nr_sectors:

void guard_bio_eod(struct bio *bio)
{
	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);

because bio->bi_bdev is NULL for some reason.  The crash itself seems to
be from do_mpage_readpage around line 304:

alloc_new:
	if (args->bio == NULL) {
		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), opf,
				      gfp);

bdev is NULL here                     ^^^^

		if (args->bio == NULL)
			goto confused;
		args->bio->bi_iter.bi_sector = first_block << (blkbits - 9);
	}

	length = first_hole << blkbits;
	if (!bio_add_folio(args->bio, folio, length, 0)) {
		args->bio = mpage_bio_submit_read(args->bio);
		goto alloc_new;
	}

	relative_block = block_in_file - args->first_logical_block;
	nblocks = map_bh->b_size >> blkbits;
	if ((buffer_boundary(map_bh) && relative_block == nblocks) ||
	    (first_hole != blocks_per_folio))
		args->bio = mpage_bio_submit_read(args->bio);

My guess is that there was no previous call to ->get_block and that
blocks_per_folio == 0, so nobody ever actually set the local @bdev
variable to a non-NULL value.  blocks_per_folio is perhaps zero because
xfs/032 tried formatting with a sector size of 64k, which causes the
bdev inode->i_blkbits to be set to 16, but for some reason we got a
folio that wasn't 64k in size:

	const unsigned blkbits = inode->i_blkbits;
	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;

<shrug> That's just my conjecture for now.

--D

[87005.669555] run fstests xfs/032 at 2025-04-07 17:24:41
[87006.359661] XFS (sda3): EXPERIMENTAL exchange range feature enabled.  Use at your own risk!
[87006.362419] XFS (sda3): EXPERIMENTAL parent pointer feature enabled.  Use at your own risk!
[87006.366059] XFS (sda3): Mounting V5 Filesystem ec1e349e-c0e7-4cb2-a8ac-b41da447e314
[87006.417753] XFS (sda3): Ending clean mount

<repeats a bunch of times>

[87272.286501] XFS (sda4): EXPERIMENTAL large block size feature enabled.  Use at your own risk!
[87272.289810] XFS (sda4): EXPERIMENTAL exchange range feature enabled.  Use at your own risk!
[87272.292854] XFS (sda4): EXPERIMENTAL parent pointer feature enabled.  Use at your own risk!
[87272.296468] XFS (sda4): Mounting V5 Filesystem ab5d65e3-52b5-47dc-8ace-15d0abdddbb8
[87272.339664] XFS (sda4): Ending clean mount
[87272.345326] XFS (sda4): Quotacheck needed: Please wait.
[87272.354286] XFS (sda4): Quotacheck: Done.
[87272.478858] XFS (sda4): Unmounting Filesystem ab5d65e3-52b5-47dc-8ace-15d0abdddbb8
[87281.127350] XFS (sda4): EXPERIMENTAL large block size feature enabled.  Use at your own risk!
[87281.132043] XFS (sda4): Mounting V5 Filesystem 30e523c4-47a4-44ac-9cd2-2287dc04737e
[87281.185758] XFS (sda4): Ending clean mount
[87281.190101] XFS (sda4): Quotacheck needed: Please wait.
[87281.198888] XFS (sda4): Quotacheck: Done.
[87281.293127] XFS (sda4): Unmounting Filesystem 30e523c4-47a4-44ac-9cd2-2287dc04737e
[87290.299787] BUG: kernel NULL pointer dereference, address: 0000000000000008
[87290.302137] #PF: supervisor read access in kernel mode
[87290.303833] #PF: error_code(0x0000) - not-present page
[87290.305547] PGD 0 P4D 0 
[87290.306362] Oops: Oops: 0000 [#1] SMP
[87290.307687] CPU: 0 UID: 0 PID: 932780 Comm: (udev-worker) Tainted: G        W           6.15.0-rc1-djwx #rc1 PREEMPT(lazy)  19ee1dc3e4e157eae36f07f1b9cd9c98a1775e33
[87290.312198] Tainted: [W]=WARN
[87290.313093] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
[87290.316499] RIP: 0010:guard_bio_eod+0x17/0x210
[87290.317911] Code: f0 ff 46 1c e8 da 5b 00 00 48 89 d8 5b c3 0f 0b 0f 1f 00 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 53 48 83 ec 30 48 8b 47 08 <48> 8b 68 08 48 85 ed 74 1e 48 8b 47 20 48 89 fb 48 39 e8 73 12 44
[87290.323459] RSP: 0018:ffffc9000274f8f8 EFLAGS: 00010282
[87290.325253] RAX: 0000000000000000 RBX: ffff888105f06e00 RCX: 0000000000000000
[87290.327451] RDX: 0000000000000000 RSI: ffffea0004096840 RDI: ffff888105f06e00
[87290.329720] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[87290.332110] R10: ffff8881007df110 R11: ffffc9000274fa18 R12: ffffc9000274f9f8
[87290.334433] R13: 000000000000000d R14: 0000000000000000 R15: ffffea0004096840
[87290.336591] FS:  00007f84f15528c0(0000) GS:ffff8884aa858000(0000) knlGS:0000000000000000
[87290.338904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87290.340452] CR2: 0000000000000008 CR3: 00000001052f7000 CR4: 00000000003506f0
[87290.342705] Call Trace:
[87290.343474]  <TASK>
[87290.344197]  ? bio_alloc_bioset+0xcd/0x520
[87290.345511]  ? bio_add_page+0x62/0xb0
[87290.346582]  do_mpage_readpage+0x3da/0x730
[87290.347948]  mpage_readahead+0x95/0x110
[87290.349230]  ? blkdev_iomap_begin+0x70/0x70
[87290.350578]  read_pages+0x84/0x220
[87290.351636]  ? filemap_add_folio+0xaf/0xd0
[87290.353004]  page_cache_ra_unbounded+0x1a7/0x240
[87290.354602]  force_page_cache_ra+0x92/0xb0
[87290.355922]  filemap_get_pages+0x13b/0x760
[87290.357347]  ? current_time+0x3b/0x110
[87290.358674]  filemap_read+0x114/0x480
[87290.359919]  blkdev_read_iter+0x64/0x120
[87290.361268]  vfs_read+0x290/0x390
[87290.362422]  ksys_read+0x6f/0xe0
[87290.363422]  do_syscall_64+0x47/0x100
[87290.364668]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[87290.366097] RIP: 0033:0x7f84f1c5a25d
[87290.367031] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d a6 53 0a 00 e8 59 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 81 23 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
[87290.373149] RSP: 002b:00007ffc88a090e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[87290.375431] RAX: ffffffffffffffda RBX: 000055b4264c76b0 RCX: 00007f84f1c5a25d
[87290.377757] RDX: 0000000000000400 RSI: 000055b4264e84a8 RDI: 0000000000000010
[87290.379746] RBP: 0000000000000c00 R08: 00007f84f1d35380 R09: 00007f84f1d35380
[87290.381570] R10: 0000000000000000 R11: 0000000000000246 R12: 000055b4264e8480
[87290.383535] R13: 0000000000000400 R14: 000055b4264c7708 R15: 000055b4264e8498
[87290.385827]  </TASK>
[87290.386578] Modules linked in: dm_delay ext4 mbcache jbd2 btrfs blake2b_generic xor lzo_compress lzo_decompress zlib_deflate raid6_pq zstd_compress dm_log_writes dm_thin_pool dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_zero dm_flakey xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables nfnetlink bfq sha512_ssse3 sha512_generic pvpanic_mmio pvpanic sha256_ssse3 sch_fq_codel fuse configfs ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
[87290.404596] Dumping ftrace buffer:
[87290.405554]    (ftrace buffer empty)
[87290.406677] CR2: 0000000000000008
[87290.407769] ---[ end trace 0000000000000000 ]---
[87290.409182] RIP: 0010:guard_bio_eod+0x17/0x210
[87290.410696] Code: f0 ff 46 1c e8 da 5b 00 00 48 89 d8 5b c3 0f 0b 0f 1f 00 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 53 48 83 ec 30 48 8b 47 08 <48> 8b 68 08 48 85 ed 74 1e 48 8b 47 20 48 89 fb 48 39 e8 73 12 44
[87290.416951] RSP: 0018:ffffc9000274f8f8 EFLAGS: 00010282
[87290.418659] RAX: 0000000000000000 RBX: ffff888105f06e00 RCX: 0000000000000000
[87290.420948] RDX: 0000000000000000 RSI: ffffea0004096840 RDI: ffff888105f06e00
[87290.422926] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[87290.425178] R10: ffff8881007df110 R11: ffffc9000274fa18 R12: ffffc9000274f9f8
[87290.427631] R13: 000000000000000d R14: 0000000000000000 R15: ffffea0004096840
[87290.430009] FS:  00007f84f15528c0(0000) GS:ffff8884aa858000(0000) knlGS:0000000000000000
[87290.432636] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87290.434574] CR2: 0000000000000008 CR3: 00000001052f7000 CR4: 00000000003506f0
[87290.436932] note: (udev-worker)[932780] exited with irqs disabled
[87290.439147] ------------[ cut here ]------------
[87290.440772] WARNING: CPU: 0 PID: 932780 at kernel/exit.c:900 do_exit+0x95a/0xbb0
[87290.443010] Modules linked in: dm_delay ext4 mbcache jbd2 btrfs blake2b_generic xor lzo_compress lzo_decompress zlib_deflate raid6_pq zstd_compress dm_log_writes dm_thin_pool dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_zero dm_flakey xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables nfnetlink bfq sha512_ssse3 sha512_generic pvpanic_mmio pvpanic sha256_ssse3 sch_fq_codel fuse configfs ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
[87290.459803] CPU: 0 UID: 0 PID: 932780 Comm: (udev-worker) Tainted: G      D W           6.15.0-rc1-djwx #rc1 PREEMPT(lazy)  19ee1dc3e4e157eae36f07f1b9cd9c98a1775e33
[87290.464613] Tainted: [D]=DIE, [W]=WARN
[87290.466017] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
[87290.469408] RIP: 0010:do_exit+0x95a/0xbb0
[87290.470885] Code: 83 b8 0b 00 00 65 01 05 40 a0 4f 01 e9 14 ff ff ff 4c 89 e6 bf 05 06 00 00 e8 b2 0f 01 00 e9 ca f7 ff ff 0f 0b e9 de f6 ff ff <0f> 0b e9 16 f7 ff ff 4c 89 e6 48 89 df e8 04 94 00 00 e9 f7 f9 ff
[87290.476385] RSP: 0018:ffffc9000274fed8 EFLAGS: 00010282
[87290.478117] RAX: 0000000080000000 RBX: ffff8881afe0c180 RCX: 0000000000000000
[87290.480231] RDX: 0000000000000001 RSI: 0000000000002710 RDI: 00000000ffffffff
[87290.482972] RBP: ffff88812a74df00 R08: 0000000000000000 R09: 205d323339363334
[87290.485443] R10: 6b726f772d766564 R11: 7528203a65746f6e R12: 0000000000000009
[87290.487900] R13: ffff88811a661100 R14: ffff8881afe0c180 R15: 0000000000000000
[87290.489893] FS:  00007f84f15528c0(0000) GS:ffff8884aa858000(0000) knlGS:0000000000000000
[87290.492491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87290.494307] CR2: 0000000000000008 CR3: 00000001052f7000 CR4: 00000000003506f0
[87290.496540] Call Trace:
[87290.497265]  <TASK>
[87290.497958]  make_task_dead+0x79/0x160
[87290.499214]  rewind_stack_and_make_dead+0x16/0x20
[87290.500781] RIP: 0033:0x7f84f1c5a25d
[87290.501947] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d a6 53 0a 00 e8 59 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 81 23 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
[87290.507872] RSP: 002b:00007ffc88a090e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[87290.510463] RAX: ffffffffffffffda RBX: 000055b4264c76b0 RCX: 00007f84f1c5a25d
[87290.512701] RDX: 0000000000000400 RSI: 000055b4264e84a8 RDI: 0000000000000010
[87290.514952] RBP: 0000000000000c00 R08: 00007f84f1d35380 R09: 00007f84f1d35380
[87290.517277] R10: 0000000000000000 R11: 0000000000000246 R12: 000055b4264e8480
[87290.519406] R13: 0000000000000400 R14: 000055b4264c7708 R15: 000055b4264e8498
[87290.521500]  </TASK>
[87290.522388] ---[ end trace 0000000000000000 ]---

