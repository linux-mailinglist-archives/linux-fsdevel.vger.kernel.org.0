Return-Path: <linux-fsdevel+bounces-46463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2AA89C6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F191900B17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EAF29293F;
	Tue, 15 Apr 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xRdJy+XJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GP4bwSBm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xRdJy+XJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GP4bwSBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D99292908
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716348; cv=none; b=qm4THJfaqukWsUP4MTIdQiidZyLuw8kEyx1SB5d6p2T9JXi+8WK5K/bAoPOaHantfWVBrYMqUfhMuZ+iIS9fI+TunggkBmpP5O7XVdN8wkj0ZSyQkf6TZXSZqT5NYdmRrRD/IVqlslT5rr1m0Qb2D4YD9NJkuy4hnrgmCiCpWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716348; c=relaxed/simple;
	bh=q5ZjYkeHcaCl6RC/1Oi0XQhvLOj1NAJGmtC+2fvUp+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3CbwkLmzzs6t7tivq7VAxVORZZj7xN2G/ZFf/baWVY7cbY/GfljpN9gtVMyr/YhrJGMYkGLxqekMn0ufHHv1KKv93zJUgpAJ5qOSZagjLF0azGG3kiGrUg+al7TmnDX78sfDtuKQCpUMu4DLfGKg3KZktjF1mK+k+yD68LiEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xRdJy+XJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GP4bwSBm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xRdJy+XJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GP4bwSBm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 643BF1F385;
	Tue, 15 Apr 2025 11:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744716344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUvz3mNVXZTDsjj2f6GMq8aLSKexmcTgxLqp8L/MMy0=;
	b=xRdJy+XJ29Awx/kROqOxvU4q6tic7kS4iYfO9xfn35gvEkqRUaY13MwytQIse64+tsXz3e
	fvbPUs6mWwW8gbfwpf3yKjFrg2E3FqnTNczigumOM9u5L8M+UTcb3QT9I5S9sACusKYRJE
	4utjoG9TEOVahZtkHLsHCoNRAXqOVTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744716344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUvz3mNVXZTDsjj2f6GMq8aLSKexmcTgxLqp8L/MMy0=;
	b=GP4bwSBmoBaymtsVFhoQxU+aHL7na/qw6+h2MQSb4zXNNXodEL0kiKHeKu/RSv/YeIZ/y5
	ea3Ldo5R5d3JRKAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744716344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUvz3mNVXZTDsjj2f6GMq8aLSKexmcTgxLqp8L/MMy0=;
	b=xRdJy+XJ29Awx/kROqOxvU4q6tic7kS4iYfO9xfn35gvEkqRUaY13MwytQIse64+tsXz3e
	fvbPUs6mWwW8gbfwpf3yKjFrg2E3FqnTNczigumOM9u5L8M+UTcb3QT9I5S9sACusKYRJE
	4utjoG9TEOVahZtkHLsHCoNRAXqOVTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744716344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUvz3mNVXZTDsjj2f6GMq8aLSKexmcTgxLqp8L/MMy0=;
	b=GP4bwSBmoBaymtsVFhoQxU+aHL7na/qw6+h2MQSb4zXNNXodEL0kiKHeKu/RSv/YeIZ/y5
	ea3Ldo5R5d3JRKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5437A137A5;
	Tue, 15 Apr 2025 11:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +2KOFDhC/mdyfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 11:25:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12498A0947; Tue, 15 Apr 2025 13:25:44 +0200 (CEST)
Date: Tue, 15 Apr 2025 13:25:44 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, jack@suse.cz, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, 
	david@redhat.com, axboe@kernel.dk, hare@suse.de, david@fromorbit.com, 
	djwong@kernel.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, 
	da.gomez@samsung.com, syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <kldodwnbi5ab5nostpqrbhxtolyzn5vqvmyjdwgehpkzknyrv4@u5y6ewg6hnon>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <20250415013641.f2ppw6wov4kn4wq2@offworld>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415013641.f2ppw6wov4kn4wq2@offworld>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,mit.edu,dilger.ca,vger.kernel.org,surriel.com,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com,syzkaller.appspotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 14-04-25 18:36:41, Davidlohr Bueso wrote:
> On Wed, 09 Apr 2025, Luis Chamberlain wrote:
> 
> > corruption can still happen even with the spin lock held. A test was
> > done using vanilla Linux and adding a udelay(2000) right before we
> > spin_lock(&bd_mapping->i_private_lock) on __find_get_block_slow() and
> > we can reproduce the same exact filesystem corruption issues as observed
> > without the spinlock with generic/750 [1].
> 
> fyi I was actually able to trigger this on a vanilla 6.15-rc1 kernel,
> not even having to add the artificial delay.

OK, so this is using generic/750, isn't it? How long did you have to run it
to trigger this? Because I've never seen this tripping...

								Honza

> 
> [336534.157119] ------------[ cut here ]------------
> [336534.158911] WARNING: CPU: 3 PID: 87221 at fs/jbd2/transaction.c:1552 jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
> [336534.160771] Modules linked in: loop sunrpc 9p kvm_intel nls_iso8859_1 nls_cp437 vfat fat crc32c_generic kvm ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd 9pnet_virtio cryptd virtio_balloon virtio_console evdev joydev button nvme_fabrics nvme_core dm_mod drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover virtio_blk failover psmouse serio_raw virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
> [336534.173218] CPU: 3 UID: 0 PID: 87221 Comm: kworker/u36:8 Not tainted 6.15.0-rc1 #2 PREEMPT(full)
> [336534.175146] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2025.02-5 03/28/2025
> [336534.176947] Workqueue: writeback wb_workfn (flush-7:5)
> [336534.178183] RIP: 0010:jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
> [336534.179626] Code: 30 0f 84 5b fe ff ff 0f 0b 41 bc 8b ff ff ff e9 69 fe ff ff 48 8b 04 24 4c 8b 48 70 4d 39 cf 0f 84 53 ff ff ff e9 32 c3 00 00 <0f> 0b 41 bc e4 ff ff ff e9 41 ff ff ff 0f 0b 90 0f 1f 40 00 90 90
> [336534.183983] RSP: 0018:ffff9f168d38f548 EFLAGS: 00010246
> [336534.185194] RAX: 0000000000000001 RBX: ffff8c0ae8244e10 RCX: 00000000000000fd
> [336534.186810] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [336534.188399] RBP: ffff8c09db0d8618 R08: ffff8c09db0d8618 R09: 0000000000000000
> [336534.189977] R10: ffff8c0b2671a83c R11: 0000000000006989 R12: 0000000000000000
> [336534.191243] R13: ffff8c09cc3b33f0 R14: ffff8c0ae8244e18 R15: ffff8c0ad5e0ef00
> [336534.192469] FS:  0000000000000000(0000) GS:ffff8c0b95b8d000(0000) knlGS:0000000000000000
> [336534.193840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [336534.194831] CR2: 00007f0ebab4f000 CR3: 000000011e616005 CR4: 0000000000772ef0
> [336534.196044] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [336534.197274] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [336534.198473] PKRU: 55555554
> [336534.198927] Call Trace:
> [336534.199350]  <TASK>
> [336534.199701]  __ext4_handle_dirty_metadata+0x5c/0x190 [ext4]
> [336534.200626]  ext4_ext_insert_extent+0x575/0x1440 [ext4]
> [336534.201465]  ? ext4_cache_extents+0x5a/0xd0 [ext4]
> [336534.202243]  ? ext4_find_extent+0x37c/0x3a0 [ext4]
> [336534.203024]  ext4_ext_map_blocks+0x50e/0x18d0 [ext4]
> [336534.203803]  ? mpage_map_and_submit_buffers+0x23f/0x270 [ext4]
> [336534.204723]  ext4_map_blocks+0x11a/0x4d0 [ext4]
> [336534.205442]  ? ext4_alloc_io_end_vec+0x1f/0x70 [ext4]
> [336534.206239]  ? kmem_cache_alloc_noprof+0x310/0x3d0
> [336534.206982]  ext4_do_writepages+0x762/0xd40 [ext4]
> [336534.207706]  ? __pfx_block_write_full_folio+0x10/0x10
> [336534.208451]  ? ext4_writepages+0xc6/0x1a0 [ext4]
> [336534.209161]  ext4_writepages+0xc6/0x1a0 [ext4]
> [336534.209834]  do_writepages+0xdd/0x250
> [336534.210378]  ? filemap_get_read_batch+0x170/0x310
> [336534.211069]  __writeback_single_inode+0x41/0x330
> [336534.211738]  writeback_sb_inodes+0x21b/0x4d0
> [336534.212375]  __writeback_inodes_wb+0x4c/0xe0
> [336534.212998]  wb_writeback+0x19c/0x320
> [336534.213546]  wb_workfn+0x30e/0x440
> [336534.214039]  process_one_work+0x188/0x340
> [336534.214650]  worker_thread+0x246/0x390
> [336534.215196]  ? _raw_spin_lock_irqsave+0x23/0x50
> [336534.215879]  ? __pfx_worker_thread+0x10/0x10
> [336534.216522]  kthread+0x104/0x250
> [336534.217004]  ? __pfx_kthread+0x10/0x10
> [336534.217554]  ? _raw_spin_unlock+0x15/0x30
> [336534.218140]  ? finish_task_switch.isra.0+0x94/0x290
> [336534.218979]  ? __pfx_kthread+0x10/0x10
> [336534.220347]  ret_from_fork+0x2d/0x50
> [336534.221086]  ? __pfx_kthread+0x10/0x10
> [336534.221703]  ret_from_fork_asm+0x1a/0x30
> [336534.222415]  </TASK>
> [336534.222775] ---[ end trace 0000000000000000 ]---
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

