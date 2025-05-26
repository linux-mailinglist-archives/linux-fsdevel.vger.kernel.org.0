Return-Path: <linux-fsdevel+bounces-49859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79BAC431B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366383B3C87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7F23D2BF;
	Mon, 26 May 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWfc6UXQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="znmz2cSA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWfc6UXQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="znmz2cSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06551FCFFB
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748277562; cv=none; b=QoHDcahRloHqzP0P2ZPU6FhDeCQLMu9dSXKYfVq6engeC07poLFrkWCqnWUYKIQ6TYVBuD8QvG6IU1FDJ3XjjBV6iRTjUP5T18ptN3uUyQe7F1o4oG6mMN5E4RCD6Sc9YxIra+i8wt2PrUtsk0b4gBpqmST41PobSrAbTf0bMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748277562; c=relaxed/simple;
	bh=9lvhLJx+DPOKx2WKzevKWgEXLT5f72qqudboPBAYaoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqES0sdMiuCLV1H6xgEECInxmVhI2yjdKywXJ+21LzzcKC/3x/cZ+p7A7AldcjwZPdZuUqKKJ0wBoe9IjOx2aUebhqXbQqbw6gY0pTGa1KU/T8s5r7aXimV1BgY+k2Fo4VqD/lb7FlIDXBCIEfXLXv7n3xPD0mecOhoNyH1gy4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWfc6UXQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=znmz2cSA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWfc6UXQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=znmz2cSA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0247C1FB9D;
	Mon, 26 May 2025 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748277559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkPXp4NOCpAdAmof68xdPnbPl/ZdSSV21vmhyw/Tock=;
	b=MWfc6UXQQSShB1gti/wp7JRDwwhsUknK3kfPlEk8/t6FVRp4GS93gDe1urz4DXav9fqnAd
	r8kVFyCFGmMmF92dBktaJlk0kWReWJzcI7m31pPyvG7MShH5yBKRQ/+PRo8mATLn9t/r1c
	qAKJvy78H9zS66XLJjE47tvekCZQKFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748277559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkPXp4NOCpAdAmof68xdPnbPl/ZdSSV21vmhyw/Tock=;
	b=znmz2cSA5VT07+LkE6SnQt5Sgr9mJCRLw35ved796XkoQoHtDtByhegiUA0g9URk5LW7VV
	EOnnur9kdnAvQTBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MWfc6UXQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=znmz2cSA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748277559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkPXp4NOCpAdAmof68xdPnbPl/ZdSSV21vmhyw/Tock=;
	b=MWfc6UXQQSShB1gti/wp7JRDwwhsUknK3kfPlEk8/t6FVRp4GS93gDe1urz4DXav9fqnAd
	r8kVFyCFGmMmF92dBktaJlk0kWReWJzcI7m31pPyvG7MShH5yBKRQ/+PRo8mATLn9t/r1c
	qAKJvy78H9zS66XLJjE47tvekCZQKFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748277559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkPXp4NOCpAdAmof68xdPnbPl/ZdSSV21vmhyw/Tock=;
	b=znmz2cSA5VT07+LkE6SnQt5Sgr9mJCRLw35ved796XkoQoHtDtByhegiUA0g9URk5LW7VV
	EOnnur9kdnAvQTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E384F13964;
	Mon, 26 May 2025 16:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gEQ8NzaZNGiTeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 May 2025 16:39:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7BFBDA09B7; Mon, 26 May 2025 18:39:18 +0200 (CEST)
Date: Mon, 26 May 2025 18:39:18 +0200
From: Jan Kara <jack@suse.cz>
To: Parav Pandit <parav@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: warning on flushing page cache on block device removal
Message-ID: <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
References: <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 0247C1FB9D
X-Spam-Level: 
X-Spam-Flag: NO

Hello!

On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> I am running a basic test of block device driver unbind, bind while the
> fio is running random write IOs with direct=3D0.  The test hits the WARN_=
ON
> assert on:
>=20
> void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
> {
>         int bsize =3D i_blocksize(inode);
>         loff_t rounded_from;
>         struct folio *folio;
>=20
>         WARN_ON(to > inode->i_size);
>=20
> This is because when the block device is removed during driver unbind,
> the driver flow is,
>=20
> del_gendisk()
>     __blk_mark_disk_dead()
>             set_capacity((disk, 0);
>                 bdev_set_nr_sectors()
>                     i_size_write() -> This will set the inode's isize to =
0, while the page cache is yet to be flushed.
>=20
> Below is the kernel call trace.
>=20
> Can someone help to identify, where should be the fix?
> Should block layer to not set the capacity to 0?
> Or page catch to overcome this dynamic changing of the size?
> Or?

After thinking about this the proper fix would be for i_size_write() to
happen under i_rwsem because the change in the middle of the write is
what's confusing the iomap code. I smell some deadlock potential here but
it's perhaps worth trying :)

								Honza


> WARNING: CPU: 58 PID: 9712 at mm/truncate.c:819 pagecache_isize_extended+=
0x186/0x2b0
> Modules linked in: virtio_blk xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_=
REJECT nf_reject_ipv4 xt_set ip_set xt_tcpudp xt_addrtype nft_compat xfrm_u=
ser xfrm_algo nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ip=
v4 nf_tables nfnetlink nfsv3 rpcsec_gss_krb5 nfsv4 nfs netfs nvme_fabrics n=
vme_core cuse overlay bridge stp llc binfmt_misc intel_rapl_msr intel_rapl_=
common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_ed=
ac_common nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipm=
i_ssif kvm dell_pc dell_smbios platform_profile dcdbas rapl intel_cstate de=
ll_wmi_descriptor wmi_bmof mei_me mei intel_pch_thermal ipmi_si acpi_power_=
meter acpi_ipmi nfsd sch_fq_codel auth_rpcgss nfs_acl ipmi_devintf ipmi_msg=
handler lockd grace dm_multipath msr scsi_dh_rdac scsi_dh_emc scsi_dh_alua =
parport_pc sunrpc ppdev lp parport efi_pstore ip_tables x_tables autofs4 ra=
id10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx=
 raid6_pq raid1 raid0 linear mlx5_core mgag200
>  i2c_algo_bit drm_client_lib drm_shmem_helper drm_kms_helper mlxfw ghash_=
clmulni_intel psample sha512_ssse3 drm sha256_ssse3 i2c_i801 tls sha1_ssse3=
 ahci i2c_mux megaraid_sas tg3 pci_hyperv_intf i2c_smbus lpc_ich libahci wm=
i aesni_intel crypto_simd cryptd
> CPU: 58 UID: 0 PID: 9712 Comm: fio Not tainted 6.15.0-rc7-vblk+ #21 PREEM=
PT(voluntary)=20
> Hardware name: Dell Inc. PowerEdge R740/0DY2X0, BIOS 2.11.2 004/21/2021
> RIP: 0010:pagecache_isize_extended+0x186/0x2b0
> Code: 04 00 00 00 e8 2b bc 1f 00 f0 41 ff 4c 24 34 75 08 4c 89 e7 e8 ab b=
d ff ff 48 83 c4 08 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc cc <0f> 0b e9 04 ff=
 ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 20
> RSP: 0018:ffff88819a16f428 EFLAGS: 00010287
> RAX: dffffc0000000000 RBX: ffff88908380c738 RCX: 000000000000000c
> RDX: 1ffff112107018f1 RSI: 000000002e47f000 RDI: ffff88908380c788
> RBP: ffff88819a16f450 R08: 0000000000000001 R09: fffff94008933c86
> R10: 000000002e47f000 R11: 0000000000000000 R12: 0000000000001000
> R13: 0000000033956000 R14: 000000002e47f000 R15: ffff88819a16f690
> FS:  00007f1be37fe640(0000) GS:ffff889069680000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1c05205018 CR3: 000000115d00d001 CR4: 00000000007726f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  iomap_file_buffered_write+0x763/0xa90
>  ? aa_file_perm+0x37e/0xd40
>  ? __pfx_iomap_file_buffered_write+0x10/0x10
>  ? __kasan_check_read+0x15/0x20
>  ? __pfx_down_read+0x10/0x10
>  ? __kasan_check_read+0x15/0x20
>  ? inode_needs_update_time.part.0+0x15c/0x1e0
>  blkdev_write_iter+0x628/0xc90
>  aio_write+0x2f9/0x6e0
>  ? io_submit_one+0xc98/0x1c20
>  ? __pfx_aio_write+0x10/0x10
>  ? kasan_save_stack+0x40/0x60
>  ? kasan_save_stack+0x2c/0x60
>  ? kasan_save_track+0x18/0x40
>  ? kasan_save_free_info+0x3f/0x60
>  ? kasan_save_track+0x18/0x40
>  ? kasan_save_alloc_info+0x3c/0x50
>  ? __kasan_slab_alloc+0x91/0xa0
>  ? fget+0x17c/0x250
>  io_submit_one+0xb9c/0x1c20
>  ? io_submit_one+0xb9c/0x1c20
>  ? __pfx_aio_write+0x10/0x10
>  ? __pfx_io_submit_one+0x10/0x10
>  ? __kasan_check_write+0x18/0x20
>  ? _raw_spin_lock_irqsave+0x96/0xf0
>  ? __kasan_check_write+0x18/0x20
>  __x64_sys_io_submit+0x14e/0x390
>  ? __pfx___x64_sys_io_submit+0x10/0x10
>  ? aio_read_events+0x489/0x800
>  ? read_events+0xc1/0x2f0
>  x64_sys_call+0x20ad/0x2150
>  do_syscall_64+0x6f/0x120
>  ? __pfx_read_events+0x10/0x10
>  ? __x64_sys_io_submit+0x1c6/0x390
>  ? __x64_sys_io_submit+0x1c6/0x390
>  ? __pfx___x64_sys_io_submit+0x10/0x10
>  ? __x64_sys_io_getevents+0x14c/0x2a0
>  ? __kasan_check_read+0x15/0x20
>  ? do_io_getevents+0xfa/0x220
>  ? __x64_sys_io_getevents+0x14c/0x2a0
>  ? __pfx___x64_sys_io_getevents+0x10/0x10
>  ? fpregs_assert_state_consistent+0x25/0xb0
>  ? __kasan_check_read+0x15/0x20
>  ? fpregs_assert_state_consistent+0x25/0xb0
>  ? syscall_exit_to_user_mode+0x5e/0x1d0
>  ? do_syscall_64+0x7b/0x120
>  ? __x64_sys_io_getevents+0x14c/0x2a0
>  ? __pfx___x64_sys_io_getevents+0x10/0x10
>  ? __kasan_check_read+0x15/0x20
>  ? fpregs_assert_state_consistent+0x25/0xb0
>  ? syscall_exit_to_user_mode+0x5e/0x1d0
>  ? do_syscall_64+0x7b/0x120
>  ? syscall_exit_to_user_mode+0x5e/0x1d0
>  ? do_syscall_64+0x7b/0x120
>  ? syscall_exit_to_user_mode+0x5e/0x1d0
>  ? clear_bhb_loop+0x40/0x90
>  ? clear_bhb_loop+0x40/0x90
>  ? clear_bhb_loop+0x40/0x90
>  ? clear_bhb_loop+0x40/0x90
>  ? clear_bhb_loop+0x40/0x90
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f1c0431e88d
> Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007f1be37f9628 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> RAX: ffffffffffffffda RBX: 00007f1be37fc7a8 RCX: 00007f1c0431e88d
> RDX: 00007f1bd40032e8 RSI: 0000000000000001 RDI: 00007f1bfa545000
> RBP: 00007f1bfa545000 R08: 00007f1af0512010 R09: 0000000000000718
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000000 R14: 00007f1bd40032e8 R15: 00007f1bd4000b70
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>=20
> fio: attempt to access beyond end of device
> vda: rw=3D2049, sector=3D0, nr_sectors =3D 8 limit=3D0
> Buffer I/O error on dev vda, logical block 0, lost async page write
>=20
>=20
--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR

