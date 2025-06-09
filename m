Return-Path: <linux-fsdevel+bounces-51028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FBAD2059
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EECA1888062
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51D25C6F3;
	Mon,  9 Jun 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1u6MGlwJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pRurrtfM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnNvvLNM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zz6QzN03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091922AD0B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477250; cv=none; b=GtHpv0Q1W7xIjCj5WsBzZ5lmmOJytA7nBgf31snU0Lgk5jcKagz0LQY5IzjR4EeTw7mQN6YurLg0I7/JvjHDCzegfr8mN+LN103LgGoYgYi5X4Zr+wb14R19CiLgQhKlMXvMFxqZYTCOPxy2DHY4eI5GoO1+OXB4Z2IWAV0Ks8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477250; c=relaxed/simple;
	bh=jywSTTI0kUbqSPlQCQBvbKoOanBvh4/HlAWzPhc8YDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc7oD/tSdeb9p3+PUfOyGV2TGN28X9whmi9OJ7ONqP8SsH2jCUXu1rt2LqDKQ3HKj+3y4KpjjPjoxPhL2k5NH2FNq3yDW5J4ZIJ2yIOloBPEoUtGfkABBWbalFTnEPz3UBT8Avi52YE6/8brwj7LGxQfilzL55aWLArzz2yo8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1u6MGlwJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pRurrtfM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnNvvLNM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zz6QzN03; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBFD12118A;
	Mon,  9 Jun 2025 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749477247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zs1mWoZdR3u56m/B8OfDJobP7EagVElCkSqRSNAEy8=;
	b=1u6MGlwJPao4id+RMU8TPIvFfy5c+tyxacq1sGcYqEB4APW4FXFT7svzd/VAWxNgG5Vsz0
	rqeFXbLBXtHZVE4CY4/BkQmaHPbdT60aqjvx3rO1/9Wgv0e6TBysacqHFrD/wHaRyR4rY+
	L5UvJd+gIH3fm5Uf94cWELs09gVIarE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749477247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zs1mWoZdR3u56m/B8OfDJobP7EagVElCkSqRSNAEy8=;
	b=pRurrtfMF1fMo0PpsI2HPkIA3cx2WtO/Zv+/eWWqraK7fhIyyyI2rU305evyr9p2Kt7E6U
	nW5/6Hb4va1AAXDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RnNvvLNM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Zz6QzN03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749477245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zs1mWoZdR3u56m/B8OfDJobP7EagVElCkSqRSNAEy8=;
	b=RnNvvLNMCfWNysM950Z/yW2xxIiPe5XhiAFW/hsSqe0fvjMPjuqtzNEO/NBFU6uncgkz7J
	hh3zITBW6Uw34ugNsu/I8p4KAED0rFDnCEGjSKiF1VZDK5v1ISHA01kbLAcEtKX8+MvpiI
	jpHXMynqDJpAalknDyFgnk6hEOuQjGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749477245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zs1mWoZdR3u56m/B8OfDJobP7EagVElCkSqRSNAEy8=;
	b=Zz6QzN036M3aeRIcN1NynDirgADAuN8Az36B5JvrT0A+Fhx/MQKpEtKSCzODtNIFvKkOHp
	FsfBVQJuiW2bTICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B106313A1D;
	Mon,  9 Jun 2025 13:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P9cxK33nRmhmZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Jun 2025 13:54:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D19B9A094C; Mon,  9 Jun 2025 15:54:01 +0200 (CEST)
Date: Mon, 9 Jun 2025 15:54:01 +0200
From: Jan Kara <jack@suse.cz>
To: Xianying Wang <wangxianying546@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] WARNING in bdev_getblk
Message-ID: <x3govm5j2nweio5k3r4imvg6cyg3onadln4tvj7bh4gmleuzqn@zmnbnjfqawfo>
References: <CAOU40uAjmLO9f0LOGqPdVd5wpiFK6QaT+UwiNvRoBXhVnKcDbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOU40uAjmLO9f0LOGqPdVd5wpiFK6QaT+UwiNvRoBXhVnKcDbw@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EBFD12118A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

Hi!

On Mon 09-06-25 16:39:15, Xianying Wang wrote:
> I encountered a kernel WARNING in the function bdev_getblk() when
> fuzzing the Linux 6.12 kernel using Syzkaller. The crash occurs during
> a block buffer allocation path, where __alloc_pages_noprof() fails
> under memory pressure, and triggers a WARNING due to an internal
> allocation failure.

Ah, this is a warning about GFP_NOFAIL allocation from direct reclaim:

[   44.141691] ------------[ cut here ]------------
[   44.142325] WARNING: CPU: 1 PID: 3002 at mm/page_alloc.c:4238 __alloc_pages_noprof+0x1746/0x1ef0
[   44.143484] Modules linked in:
[   44.143868] CPU: 1 UID: 0 PID: 3002 Comm: syz-executor.0 Not tainted 6.12.0 #1
[   44.144651] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   44.145679] RIP: 0010:__alloc_pages_noprof+0x1746/0x1ef0
[   44.146277] Code: 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 82 07 00 00 f6 43 2d 08 0f 84 0d ee ff ff 90 <0f> 0b 90 e9 04 ee ff ff 44 89 4c 24 40 65 8b 15 52 fc 8c 7e 89 d2
[   44.148206] RSP: 0018:ffff8880195f6940 EFLAGS: 00010202
[   44.148758] RAX: 0000000000000007 RBX: ffff8880156be480 RCX: 1ffff1100fffb931
[   44.149516] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8880156be4ac
[   44.150278] RBP: 0000000000000400 R08: 0000000000000801 R09: 000000000000000b
[   44.151030] R10: ffff88807ffdcd87 R11: 0000000000000000 R12: 0000000000000000
[   44.152622] R13: ffff8880195f6a10 R14: 0000000000148c48 R15: 0000000000148c48
[   44.153657] FS:  00007fdccd5c76c0(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
[   44.155023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.155659] CR2: 00007f1d26fa6000 CR3: 000000000e67a000 CR4: 0000000000350ef0
[   44.156431] Call Trace:
[   44.156706]  <TASK>
[   44.156946]  ? __warn+0xea/0x2c0
[   44.157343]  ? __alloc_pages_noprof+0x1746/0x1ef0
[   44.157865]  ? report_bug+0x2f5/0x3f0
[   44.158298]  ? __alloc_pages_noprof+0x1746/0x1ef0
[   44.158812]  ? __alloc_pages_noprof+0x1747/0x1ef0
[   44.159347]  ? handle_bug+0xe5/0x180
[   44.159753]  ? exc_invalid_op+0x35/0x80
[   44.160216]  ? asm_exc_invalid_op+0x1a/0x20
[   44.160683]  ? __alloc_pages_noprof+0x1746/0x1ef0
[   44.161237]  ? __pte_offset_map+0xe9/0x1f0
[   44.161693]  ? __pte_offset_map+0xf4/0x1f0
[   44.162168]  ? __sanitizer_cov_trace_pc+0x8/0x80
[   44.162677]  ? __pte_offset_map+0x12f/0x1f0
[   44.163175]  ? __pfx___alloc_pages_noprof+0x10/0x10
[   44.163710]  ? pte_offset_map_nolock+0x106/0x1b0
[   44.164253]  ? check_pte+0x253/0x2e0
[   44.164661]  ? page_vma_mapped_walk+0x62c/0x1640
[   44.165192]  ? __sanitizer_cov_trace_switch+0x54/0x90
[   44.165742]  ? policy_nodemask+0xeb/0x4b0
[   44.166206]  alloc_pages_mpol_noprof+0xf2/0x330
[   44.166704]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10
[   44.167285]  ? xas_load+0x6a/0x2a0
[   44.167674]  folio_alloc_noprof+0x21/0x70
[   44.168138]  filemap_alloc_folio_noprof+0x324/0x360
[   44.168676]  ? __pfx_filemap_get_entry+0x10/0x10
[   44.169209]  ? __pfx_filemap_alloc_folio_noprof+0x10/0x10
[   44.169798]  ? __filemap_get_folio+0x149/0x4e0
[   44.170313]  __filemap_get_folio+0x213/0x4e0
[   44.170792]  bdev_getblk+0x1d4/0x500
[   44.171221]  __ext4_get_inode_loc+0x4fa/0x1350
[   44.171713]  ? _raw_spin_lock_irq+0x81/0xe0
[   44.172206]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[   44.172730]  ? __pfx___ext4_get_inode_loc+0x10/0x10
[   44.173287]  ? folio_mapping+0xdc/0x1f0
[   44.173725]  ? __sanitizer_cov_trace_switch+0x54/0x90
[   44.174307]  ext4_get_inode_loc+0xbe/0x160
[   44.174769]  ? __pfx_ext4_get_inode_loc+0x10/0x10
[   44.175312]  ext4_reserve_inode_write+0xce/0x280
[   44.175825]  ? folio_referenced+0x2d0/0x4f0
[   44.176315]  __ext4_mark_inode_dirty+0x105/0x730
[   44.176828]  ? __pfx___ext4_mark_inode_dirty+0x10/0x10
[   44.177421]  ? blk_mq_flush_plug_list+0x5b5/0x1580
[   44.177954]  ? ext4_journal_check_start+0x1a4/0x2b0
[   44.178522]  ? __ext4_journal_start_sb+0x199/0x460
[   44.179075]  ? ext4_dirty_inode+0xa5/0x130
[   44.179533]  ? __pfx__raw_spin_lock+0x10/0x10
[   44.180015]  ? __pfx_ext4_dirty_inode+0x10/0x10
[   44.180537]  ext4_dirty_inode+0xdd/0x130
[   44.180977]  __mark_inode_dirty+0x121/0x9d0
[   44.181465]  iput.part.0+0xfc/0x6c0
[   44.181857]  iput+0x62/0x80
[   44.182202]  dentry_unlink_inode+0x2c7/0x4b0
[   44.182672]  __dentry_kill+0x1d5/0x5e0
[   44.183108]  shrink_dentry_list+0xf3/0x1f0
[   44.183551]  prune_dcache_sb+0xeb/0x150
[   44.183971]  ? down_read_trylock+0x114/0x1c0
[   44.184493]  ? __pfx_prune_dcache_sb+0x10/0x10
[   44.184977]  ? __pfx_ext4_es_scan+0x10/0x10
[   44.185457]  super_cache_scan+0x339/0x550
[   44.185895]  shrink_slab+0x51c/0xa90
[   44.186321]  ? __pfx_shrink_slab+0x10/0x10
[   44.186765]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[   44.187293]  shrink_node+0x606/0x1760
[   44.187702]  ? throttle_direct_reclaim+0xcd/0x8f0
[   44.188244]  do_try_to_free_pages+0x2aa/0x1260
[   44.188733]  try_to_free_pages+0x215/0x470
[   44.189196]  ? __pfx_try_to_free_pages+0x10/0x10
[   44.189692]  ? wake_all_kswapds+0x12d/0x2e0

In this case slab reclaim has dropped the last inode reference which
triggered update of lazy time, thus inode is dirtied which needs to do
GFP_NOFAIL memory allocation to handle all the block updates & journalling.
I think we should rather teach flush worker to handle these delayed lazy
time updates instead of handling them in iput_final(). At least for
PF_MEMALLOC cases...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

