Return-Path: <linux-fsdevel+bounces-46429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD7A8918A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 03:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BD93B09AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 01:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEE1F30B3;
	Tue, 15 Apr 2025 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TUCkccYq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8F1D52B;
	Tue, 15 Apr 2025 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681405; cv=pass; b=AjnaW47+xn3GkqLEDoOqKI79xI9ItbnWG8tyDsZc9se700Laxkc6FahDb6H/lw/EKWKr3MI5kIQ/yz9R+PvcMBFk535I8/UJ1TkWvFMgw6raiT0hUI9OQ5XFpm2GzIrFfBZ3UbEQf/BtZvdjWIKfFVW+gjGgLRt8kGjHD+F8Fgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681405; c=relaxed/simple;
	bh=l2eAEpr2jmdEcxL4U8LcqJHOZIzwoezZVEdRxK9LTUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVVgi5ecQdQmDtP3UL9HPF7qlVD3n9ebGM1lIXa0vhQMwVimsPnXZvyoygebrABKaczGWkAOz/Xah2EaTvpe7ELq9i1G+Uq3pdXFVydKx95qIat5YobuETlgWOmvNZI0+hrYIQcBaMaAd6FjlVwspTtID3aj7JVECglHBm9d86U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TUCkccYq; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 88D4C4E4A9D;
	Tue, 15 Apr 2025 01:36:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (100-110-51-173.trex-nlb.outbound.svc.cluster.local [100.110.51.173])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 066F64E3AD9;
	Tue, 15 Apr 2025 01:36:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744681006; a=rsa-sha256;
	cv=none;
	b=P/GhzsEz5f9ceO38nSheIaNLR+4Mkv1VkDy7ninjeDx/G23ylMuyjoxWjHfK56KO45x9X8
	s6Y4se+5xk9e8uhizLjyHRh6iQOay+vjlLPNc+MyyTWhxVcAS51WN/TKkm6vPeZASS6wjR
	XqIDL8LDZMLWwgKYcJDj8rqqGL6tjnx4LPYcV3P8i+qVZRT0hUoFh2/V2Zn4vwIodiUG0B
	Sqxrp0ob/Tx7UDFCVa0OtIcEFo8wwMPYUoR4n2k1Vtd7TMu6V725fixNMLzkoOefAkB4YG
	CEbseikqTgutQuklA0AmHJm1CVpBji48Xh94FCW/icQz+5aOri8wpyKJjZP/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744681006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jlfvjRzAtxfUTZ9I3wbiorK0UEQiipXG/ieXwtFY7M8=;
	b=4+sh4iX1YJzXWIOdWBn3zBOhgpFdWAic+C2oDY7jiLGkPSRsJG2pBLfuaw+LmacMqQNmbt
	EG4d8qneVGTS5gKCC3fY8ZwBxULL6Fym7yMlk/S58NWDSonQ6K51FEGLGidC0x5E6mMvWH
	VvFJSYMGEbitMSCQjTIxJU4Syri5oKXtv2YhCMpf31wloOq1tMyY9bMM+KmAiLG68XhrfP
	rL9VbS7hq9jD/CWW3/d8tG2+vDG6tdTL+sNhhvSC7XO6zxVETtBNoN382molLi/p0W1mJ5
	37WXHIcbeEhSWlJB61VgtPBkRlx66mWQRkSz6lem26ni8yuA2wu58ICcUhoDSA==
ARC-Authentication-Results: i=1;
	rspamd-865c984fb5-w772g;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shade-Bitter: 0415a5496692aa68_1744681006409_492724278
X-MC-Loop-Signature: 1744681006409:3535641005
X-MC-Ingress-Time: 1744681006409
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.173 (trex/7.0.3);
	Tue, 15 Apr 2025 01:36:46 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Zc6Fm457Tz49;
	Mon, 14 Apr 2025 18:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744681005;
	bh=jlfvjRzAtxfUTZ9I3wbiorK0UEQiipXG/ieXwtFY7M8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=TUCkccYqtzJaKksj1NWAxf9lhTQO9W+/6e6pzjlWrrLuEThkO2MjGdyCxE8/CfmvJ
	 wuqiK9EIncEpRQAMcTAH0Fyx0DSe2lgX3/a5Ez1/D4iXRAigLuNg4KrvzcvyetYcwD
	 44ksUcIuQ1Nr50dASjJnPsl7B/ILRzoIw4hGa+En+j5k9+0IU8qZhtLBUcvCZ+OH9O
	 /Ik0JYVKfb78VbQ1KSEJsFrMc8pZHIGMSLf/Jyyxyx4g89K736YOz2lNPBQ6egx9Of
	 jMB2juYqfyL/6GhpC5TPIPY1MAkua8Fk7fhUbBA6HqbBeNESDQU5p4KB+wnQKD5iSZ
	 YcluHuV2gK9PA==
Date: Mon, 14 Apr 2025 18:36:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <20250415013641.f2ppw6wov4kn4wq2@offworld>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, riel@surriel.com, willy@infradead.org,
	hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com,
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com,
	djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250410014945.2140781-2-mcgrof@kernel.org>
User-Agent: NeoMutt/20220429

On Wed, 09 Apr 2025, Luis Chamberlain wrote:

>corruption can still happen even with the spin lock held. A test was
>done using vanilla Linux and adding a udelay(2000) right before we
>spin_lock(&bd_mapping->i_private_lock) on __find_get_block_slow() and
>we can reproduce the same exact filesystem corruption issues as observed
>without the spinlock with generic/750 [1].

fyi I was actually able to trigger this on a vanilla 6.15-rc1 kernel,
not even having to add the artificial delay.

[336534.157119] ------------[ cut here ]------------
[336534.158911] WARNING: CPU: 3 PID: 87221 at fs/jbd2/transaction.c:1552 jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
[336534.160771] Modules linked in: loop sunrpc 9p kvm_intel nls_iso8859_1 nls_cp437 vfat fat crc32c_generic kvm ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd 9pnet_virtio cryptd virtio_balloon virtio_console evdev joydev button nvme_fabrics nvme_core dm_mod drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover virtio_blk failover psmouse serio_raw virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
[336534.173218] CPU: 3 UID: 0 PID: 87221 Comm: kworker/u36:8 Not tainted 6.15.0-rc1 #2 PREEMPT(full)
[336534.175146] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2025.02-5 03/28/2025
[336534.176947] Workqueue: writeback wb_workfn (flush-7:5)
[336534.178183] RIP: 0010:jbd2_journal_dirty_metadata+0x21c/0x230 [jbd2]
[336534.179626] Code: 30 0f 84 5b fe ff ff 0f 0b 41 bc 8b ff ff ff e9 69 fe ff ff 48 8b 04 24 4c 8b 48 70 4d 39 cf 0f 84 53 ff ff ff e9 32 c3 00 00 <0f> 0b 41 bc e4 ff ff ff e9 41 ff ff ff 0f 0b 90 0f 1f 40 00 90 90
[336534.183983] RSP: 0018:ffff9f168d38f548 EFLAGS: 00010246
[336534.185194] RAX: 0000000000000001 RBX: ffff8c0ae8244e10 RCX: 00000000000000fd
[336534.186810] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[336534.188399] RBP: ffff8c09db0d8618 R08: ffff8c09db0d8618 R09: 0000000000000000
[336534.189977] R10: ffff8c0b2671a83c R11: 0000000000006989 R12: 0000000000000000
[336534.191243] R13: ffff8c09cc3b33f0 R14: ffff8c0ae8244e18 R15: ffff8c0ad5e0ef00
[336534.192469] FS:  0000000000000000(0000) GS:ffff8c0b95b8d000(0000) knlGS:0000000000000000
[336534.193840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[336534.194831] CR2: 00007f0ebab4f000 CR3: 000000011e616005 CR4: 0000000000772ef0
[336534.196044] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[336534.197274] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[336534.198473] PKRU: 55555554
[336534.198927] Call Trace:
[336534.199350]  <TASK>
[336534.199701]  __ext4_handle_dirty_metadata+0x5c/0x190 [ext4]
[336534.200626]  ext4_ext_insert_extent+0x575/0x1440 [ext4]
[336534.201465]  ? ext4_cache_extents+0x5a/0xd0 [ext4]
[336534.202243]  ? ext4_find_extent+0x37c/0x3a0 [ext4]
[336534.203024]  ext4_ext_map_blocks+0x50e/0x18d0 [ext4]
[336534.203803]  ? mpage_map_and_submit_buffers+0x23f/0x270 [ext4]
[336534.204723]  ext4_map_blocks+0x11a/0x4d0 [ext4]
[336534.205442]  ? ext4_alloc_io_end_vec+0x1f/0x70 [ext4]
[336534.206239]  ? kmem_cache_alloc_noprof+0x310/0x3d0
[336534.206982]  ext4_do_writepages+0x762/0xd40 [ext4]
[336534.207706]  ? __pfx_block_write_full_folio+0x10/0x10
[336534.208451]  ? ext4_writepages+0xc6/0x1a0 [ext4]
[336534.209161]  ext4_writepages+0xc6/0x1a0 [ext4]
[336534.209834]  do_writepages+0xdd/0x250
[336534.210378]  ? filemap_get_read_batch+0x170/0x310
[336534.211069]  __writeback_single_inode+0x41/0x330
[336534.211738]  writeback_sb_inodes+0x21b/0x4d0
[336534.212375]  __writeback_inodes_wb+0x4c/0xe0
[336534.212998]  wb_writeback+0x19c/0x320
[336534.213546]  wb_workfn+0x30e/0x440
[336534.214039]  process_one_work+0x188/0x340
[336534.214650]  worker_thread+0x246/0x390
[336534.215196]  ? _raw_spin_lock_irqsave+0x23/0x50
[336534.215879]  ? __pfx_worker_thread+0x10/0x10
[336534.216522]  kthread+0x104/0x250
[336534.217004]  ? __pfx_kthread+0x10/0x10
[336534.217554]  ? _raw_spin_unlock+0x15/0x30
[336534.218140]  ? finish_task_switch.isra.0+0x94/0x290
[336534.218979]  ? __pfx_kthread+0x10/0x10
[336534.220347]  ret_from_fork+0x2d/0x50
[336534.221086]  ? __pfx_kthread+0x10/0x10
[336534.221703]  ret_from_fork_asm+0x1a/0x30
[336534.222415]  </TASK>
[336534.222775] ---[ end trace 0000000000000000 ]---

