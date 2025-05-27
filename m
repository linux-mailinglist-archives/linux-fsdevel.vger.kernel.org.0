Return-Path: <linux-fsdevel+bounces-49902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0AAC4DF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3E01628D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C21263C68;
	Tue, 27 May 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vvx9raQ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="81f1tsr1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vvx9raQ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="81f1tsr1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B32586FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347047; cv=none; b=BwS5jOYyCgpM4nHO/bqgnMdkH+0ts2uLGCM/8nPUtIuCsIP+Xc+RmQSk0GEEv1tbJ7/0mrdpsGoGDTsqOAGoxaJJ9JRk6xBA5s0r5L0ToAZq21dC+9fVsj6yZBFQkHvJsUWjLbIJh85t2KhtsjWNTqryS4qYqWACSQqwWFypnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347047; c=relaxed/simple;
	bh=js52LayBz9PgM2SZwSqxMBnhXn2OtWE1E3p7dAREJ50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFP2qtXNkHfCzQrMovTJt1M6yudpMgIPg017mouEk2eVJ8EZnwmTLzR3xNaEgrQ0xTkzn2NzCC1u2fHbE/2dvxW+ceKHTHwoqsEpiGZZMIXmFcIOePuOV1lA0vpSr0q9ukk5n+xgz3qdOiUtsKgCcs28k1LLpfTbjAea3EiWm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vvx9raQ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=81f1tsr1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vvx9raQ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=81f1tsr1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CE2021E9D;
	Tue, 27 May 2025 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748347043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eC4+uoA5CyH6ztcu9EPfFEwRDnPkNdbc6z+Wuhgsq8Q=;
	b=Vvx9raQ3Vg43lh5ENyXul6ei5MwvXNDWMqD/pDFcquLlFEemjnFlZi6WvkZoRv6aAyJ8sQ
	8DaJsQxOD67T2a5lxAnkL+FJwCsTqTembVVOeWMi0aKYKhau/2pG8v4sEFt7BI+AA+LXve
	MoTGxBFfKNKbGC9X28Ij+GooWF+8K+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748347043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eC4+uoA5CyH6ztcu9EPfFEwRDnPkNdbc6z+Wuhgsq8Q=;
	b=81f1tsr1UBkuWfzn06Ky07hTG8baxhFHXHnYegjlID4EU3mWkauEZxy8E5z/eLDyZbKGda
	m9MNrgb/tUCyhHAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Vvx9raQ3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=81f1tsr1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748347043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eC4+uoA5CyH6ztcu9EPfFEwRDnPkNdbc6z+Wuhgsq8Q=;
	b=Vvx9raQ3Vg43lh5ENyXul6ei5MwvXNDWMqD/pDFcquLlFEemjnFlZi6WvkZoRv6aAyJ8sQ
	8DaJsQxOD67T2a5lxAnkL+FJwCsTqTembVVOeWMi0aKYKhau/2pG8v4sEFt7BI+AA+LXve
	MoTGxBFfKNKbGC9X28Ij+GooWF+8K+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748347043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eC4+uoA5CyH6ztcu9EPfFEwRDnPkNdbc6z+Wuhgsq8Q=;
	b=81f1tsr1UBkuWfzn06Ky07hTG8baxhFHXHnYegjlID4EU3mWkauEZxy8E5z/eLDyZbKGda
	m9MNrgb/tUCyhHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DE8C13A62;
	Tue, 27 May 2025 11:57:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7VfNGqOoNWi6DQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 May 2025 11:57:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0537A0951; Tue, 27 May 2025 13:57:22 +0200 (CEST)
Date: Tue, 27 May 2025 13:57:22 +0200
From: Jan Kara <jack@suse.cz>
To: Parav Pandit <parav@nvidia.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: warning on flushing page cache on block device removal
Message-ID: <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
References: <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 7CE2021E9D
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On Tue 27-05-25 11:00:56, Parav Pandit wrote:
> > From: Jan Kara <jack@suse.cz>
> > Sent: Monday, May 26, 2025 10:09 PM
> > 
> > Hello!
> > 
> > On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> > > I am running a basic test of block device driver unbind, bind while
> > > the fio is running random write IOs with direct=0.  The test hits the
> > > WARN_ON assert on:
> > >
> > > void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t
> > > to) {
> > >         int bsize = i_blocksize(inode);
> > >         loff_t rounded_from;
> > >         struct folio *folio;
> > >
> > >         WARN_ON(to > inode->i_size);
> > >
> > > This is because when the block device is removed during driver unbind,
> > > the driver flow is,
> > >
> > > del_gendisk()
> > >     __blk_mark_disk_dead()
> > >             set_capacity((disk, 0);
> > >                 bdev_set_nr_sectors()
> > >                     i_size_write() -> This will set the inode's isize to 0, while the
> > page cache is yet to be flushed.
> > >
> > > Below is the kernel call trace.
> > >
> > > Can someone help to identify, where should be the fix?
> > > Should block layer to not set the capacity to 0?
> > > Or page catch to overcome this dynamic changing of the size?
> > > Or?
> > 
> > After thinking about this the proper fix would be for i_size_write() to happen
> > under i_rwsem because the change in the middle of the write is what's
> > confusing the iomap code. I smell some deadlock potential here but it's
> > perhaps worth trying :)
> >
> Without it, I gave a quick try with inode_lock() unlock() in
> i_size_write() and initramfs level it was stuck.  I am yet to try with
> LOCKDEP.

You definitely cannot put inode_lock() into i_size_write(). i_size_write()
is expected to be called under inode_lock. And bdev_set_nr_sectors() is
breaking this rule by not holding it. So what you can try is to do
inode_lock() in bdev_set_nr_sectors() instead of grabbing bd_size_lock.

> I was thinking, can the existing sequence lock be used for 64-bit case as
> well? 

The sequence lock is about updating inode->i_size value itself. But we need
much larger scale protection here - we need to make sure write to the block
device is not happening while the device size changes. And that's what
inode_lock is usually used for.

								Honza

> > > WARNING: CPU: 58 PID: 9712 at mm/truncate.c:819
> > > pagecache_isize_extended+0x186/0x2b0
> > > Modules linked in: virtio_blk xt_CHECKSUM xt_MASQUERADE xt_conntrack
> > > ipt_REJECT nf_reject_ipv4 xt_set ip_set xt_tcpudp xt_addrtype
> > > nft_compat xfrm_user xfrm_algo nft_chain_nat nf_nat nf_conntrack
> > > nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink nfsv3
> > > rpcsec_gss_krb5 nfsv4 nfs netfs nvme_fabrics nvme_core cuse overlay
> > > bridge stp llc binfmt_misc intel_rapl_msr intel_rapl_common
> > > intel_uncore_frequency intel_uncore_frequency_common skx_edac
> > > skx_edac_common nfit x86_pkg_temp_thermal intel_powerclamp
> > coretemp
> > > kvm_intel ipmi_ssif kvm dell_pc dell_smbios platform_profile dcdbas
> > > rapl intel_cstate dell_wmi_descriptor wmi_bmof mei_me mei
> > > intel_pch_thermal ipmi_si acpi_power_meter acpi_ipmi nfsd sch_fq_codel
> > > auth_rpcgss nfs_acl ipmi_devintf ipmi_msghandler lockd grace
> > > dm_multipath msr scsi_dh_rdac scsi_dh_emc scsi_dh_alua parport_pc
> > > sunrpc ppdev lp parport efi_pstore ip_tables x_tables autofs4 raid10
> > > raid456 async_raid6_recov async_memcpy async_pq async_xor xor
> > async_tx
> > > raid6_pq raid1 raid0 linear mlx5_core mgag200  i2c_algo_bit
> > > drm_client_lib drm_shmem_helper drm_kms_helper mlxfw
> > > ghash_clmulni_intel psample sha512_ssse3 drm sha256_ssse3 i2c_i801 tls
> > > sha1_ssse3 ahci i2c_mux megaraid_sas tg3 pci_hyperv_intf i2c_smbus
> > > lpc_ich libahci wmi aesni_intel crypto_simd cryptd
> > > CPU: 58 UID: 0 PID: 9712 Comm: fio Not tainted 6.15.0-rc7-vblk+ #21
> > > PREEMPT(voluntary) Hardware name: Dell Inc. PowerEdge R740/0DY2X0,
> > > BIOS 2.11.2 004/21/2021
> > > RIP: 0010:pagecache_isize_extended+0x186/0x2b0
> > > Code: 04 00 00 00 e8 2b bc 1f 00 f0 41 ff 4c 24 34 75 08 4c 89 e7 e8
> > > ab bd ff ff 48 83 c4 08 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc cc <0f> 0b
> > > e9 04 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 20
> > > RSP: 0018:ffff88819a16f428 EFLAGS: 00010287
> > > RAX: dffffc0000000000 RBX: ffff88908380c738 RCX: 000000000000000c
> > > RDX: 1ffff112107018f1 RSI: 000000002e47f000 RDI: ffff88908380c788
> > > RBP: ffff88819a16f450 R08: 0000000000000001 R09: fffff94008933c86
> > > R10: 000000002e47f000 R11: 0000000000000000 R12: 0000000000001000
> > > R13: 0000000033956000 R14: 000000002e47f000 R15: ffff88819a16f690
> > > FS:  00007f1be37fe640(0000) GS:ffff889069680000(0000)
> > > knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f1c05205018 CR3: 000000115d00d001 CR4: 00000000007726f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  iomap_file_buffered_write+0x763/0xa90
> > >  ? aa_file_perm+0x37e/0xd40
> > >  ? __pfx_iomap_file_buffered_write+0x10/0x10
> > >  ? __kasan_check_read+0x15/0x20
> > >  ? __pfx_down_read+0x10/0x10
> > >  ? __kasan_check_read+0x15/0x20
> > >  ? inode_needs_update_time.part.0+0x15c/0x1e0
> > >  blkdev_write_iter+0x628/0xc90
> > >  aio_write+0x2f9/0x6e0
> > >  ? io_submit_one+0xc98/0x1c20
> > >  ? __pfx_aio_write+0x10/0x10
> > >  ? kasan_save_stack+0x40/0x60
> > >  ? kasan_save_stack+0x2c/0x60
> > >  ? kasan_save_track+0x18/0x40
> > >  ? kasan_save_free_info+0x3f/0x60
> > >  ? kasan_save_track+0x18/0x40
> > >  ? kasan_save_alloc_info+0x3c/0x50
> > >  ? __kasan_slab_alloc+0x91/0xa0
> > >  ? fget+0x17c/0x250
> > >  io_submit_one+0xb9c/0x1c20
> > >  ? io_submit_one+0xb9c/0x1c20
> > >  ? __pfx_aio_write+0x10/0x10
> > >  ? __pfx_io_submit_one+0x10/0x10
> > >  ? __kasan_check_write+0x18/0x20
> > >  ? _raw_spin_lock_irqsave+0x96/0xf0
> > >  ? __kasan_check_write+0x18/0x20
> > >  __x64_sys_io_submit+0x14e/0x390
> > >  ? __pfx___x64_sys_io_submit+0x10/0x10
> > >  ? aio_read_events+0x489/0x800
> > >  ? read_events+0xc1/0x2f0
> > >  x64_sys_call+0x20ad/0x2150
> > >  do_syscall_64+0x6f/0x120
> > >  ? __pfx_read_events+0x10/0x10
> > >  ? __x64_sys_io_submit+0x1c6/0x390
> > >  ? __x64_sys_io_submit+0x1c6/0x390
> > >  ? __pfx___x64_sys_io_submit+0x10/0x10
> > >  ? __x64_sys_io_getevents+0x14c/0x2a0
> > >  ? __kasan_check_read+0x15/0x20
> > >  ? do_io_getevents+0xfa/0x220
> > >  ? __x64_sys_io_getevents+0x14c/0x2a0
> > >  ? __pfx___x64_sys_io_getevents+0x10/0x10
> > >  ? fpregs_assert_state_consistent+0x25/0xb0
> > >  ? __kasan_check_read+0x15/0x20
> > >  ? fpregs_assert_state_consistent+0x25/0xb0
> > >  ? syscall_exit_to_user_mode+0x5e/0x1d0
> > >  ? do_syscall_64+0x7b/0x120
> > >  ? __x64_sys_io_getevents+0x14c/0x2a0
> > >  ? __pfx___x64_sys_io_getevents+0x10/0x10
> > >  ? __kasan_check_read+0x15/0x20
> > >  ? fpregs_assert_state_consistent+0x25/0xb0
> > >  ? syscall_exit_to_user_mode+0x5e/0x1d0
> > >  ? do_syscall_64+0x7b/0x120
> > >  ? syscall_exit_to_user_mode+0x5e/0x1d0
> > >  ? do_syscall_64+0x7b/0x120
> > >  ? syscall_exit_to_user_mode+0x5e/0x1d0
> > >  ? clear_bhb_loop+0x40/0x90
> > >  ? clear_bhb_loop+0x40/0x90
> > >  ? clear_bhb_loop+0x40/0x90
> > >  ? clear_bhb_loop+0x40/0x90
> > >  ? clear_bhb_loop+0x40/0x90
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > RIP: 0033:0x7f1c0431e88d
> > > Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48
> > > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > > 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
> > > RSP: 002b:00007f1be37f9628 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000000d1
> > > RAX: ffffffffffffffda RBX: 00007f1be37fc7a8 RCX: 00007f1c0431e88d
> > > RDX: 00007f1bd40032e8 RSI: 0000000000000001 RDI: 00007f1bfa545000
> > > RBP: 00007f1bfa545000 R08: 00007f1af0512010 R09: 0000000000000718
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > > R13: 0000000000000000 R14: 00007f1bd40032e8 R15: 00007f1bd4000b70
> > > </TASK> ---[ end trace 0000000000000000 ]---
> > >
> > > fio: attempt to access beyond end of device
> > > vda: rw=2049, sector=0, nr_sectors = 8 limit=0 Buffer I/O error on dev
> > > vda, logical block 0, lost async page write
> > >
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

