Return-Path: <linux-fsdevel+bounces-73798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B9D20C05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 333E330194FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C3285CAD;
	Wed, 14 Jan 2026 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lkjdvblg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NQnMkFva";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OAYdnjMV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zTFumuuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273833121B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414749; cv=none; b=Bq/Ggm3ZDexDh6T0+25tXU2tSGZjZYZde2HqCWRhunFYjFmc9ruk4Yjb3m1XNzYmLBspNPgSNX5L2R5IFUBp7IbAWdcQiReorIc0XLABdB39H9w5DMVUgHYmiKYAU92KURbq8o70ZxBOndbQrbtHsMlYkzc/MJ0qaO4Gnyu8enU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414749; c=relaxed/simple;
	bh=YlSpBieKwxM52JUs3ISeL42zhU9R6+wbnTPHE8eOf0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0ViMnlqMDFQX9HaYHtYZ97RZvWqYOERRs/fy5VgdvWN+eMGHEvlka2EvCT1apsGn56YTZBvrSBUTvs/c3RvR+c8w8OenV/dP202PQQMA+qyLF30ZXUjMK2LAduwWhYvYane5NhHwmOs5rUtEwA31lU+jeMm0aCt4F+MHHyCj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lkjdvblg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NQnMkFva; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OAYdnjMV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zTFumuuc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07C5834A57;
	Wed, 14 Jan 2026 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768414746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdNKxr90SkirKUcSE98U7rs8k+FlAB+4bfE17G0B/Tw=;
	b=Lkjdvblg5R+TQgUe/fPJ87uCjc9WG1xIzrDGFl5E/vrdQOup8xCNMFbMJN9EgKkjiglLNS
	Ypwjf4ADqpdmVuFf03SI+G/5ZRHDAX3D5WCqgXTpalczldbWJV0iDyF7nFxpXaj94f+Uge
	yvtD+5eMNhTw43Y7NJcMgV5zaF6aaco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768414746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdNKxr90SkirKUcSE98U7rs8k+FlAB+4bfE17G0B/Tw=;
	b=NQnMkFvaojsC8Ua1xTCyZaTwpIaFKUa+kGRoFTvZZWgH+mgAr/lIjricLqFzSONHKnFAKk
	UOmZw94lGyT3vECg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OAYdnjMV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zTFumuuc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768414745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdNKxr90SkirKUcSE98U7rs8k+FlAB+4bfE17G0B/Tw=;
	b=OAYdnjMVsY2d58lyI4UdZ3YJ9wcn4wy5VGBCvgVK5s8AoHaXxLO//uKVyRLOmo13QmcMNB
	kQYA1o7HIn/ufEuNPDVmCyouMGM1d4hjZQ8oqPLHoNGE9GYRUG7zV8iHDCrCRYVacMdA0R
	FkfddcWHMFS5LLVSflqeZN3Q3A7OUqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768414745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdNKxr90SkirKUcSE98U7rs8k+FlAB+4bfE17G0B/Tw=;
	b=zTFumuucwnLtexsHkUdeTVDY+aUghuT8zZjAdcRx1dOWCnuBIoASplhcIrfEcs6aNoalHg
	a/73HiB8vkuOEfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E330F3EA63;
	Wed, 14 Jan 2026 18:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fie5NhjeZ2neNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Jan 2026 18:19:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C7A4A0BFB; Wed, 14 Jan 2026 19:19:04 +0100 (CET)
Date: Wed, 14 Jan 2026 19:19:04 +0100
From: Jan Kara <jack@suse.cz>
To: Seunguk Shin <seunguk.shin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	nvdimm@lists.linux.dev, dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz, 
	Nick.Connolly@arm.com, ffidencio@nvidia.com, Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] fs/dax: check zero or empty entry before converting
 xarray
Message-ID: <pj7j72k2f4kc5hhid6md6ntn6hwapl5oocuubc2g5ec7vhf2te@yux7oeq43nhe>
References: <18af3213-6c46-4611-ba75-da5be5a1c9b0@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18af3213-6c46-4611-ba75-da5be5a1c9b0@arm.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 07C5834A57
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Wed 14-01-26 17:49:30, Seunguk Shin wrote:
> Trying to convert zero or empty xarray entry causes kernel panic.
> 
> [    0.737679] EXT4-fs (pmem0p1): mounted filesystem
> 79676804-7c8b-491a-b2a6-9bae3c72af70 ro with ordered data mode. Quota mode:
> disabled.
> [    0.737891] VFS: Mounted root (ext4 filesystem) readonly on device 259:1.
> [    0.739119] devtmpfs: mounted
> [    0.739476] Freeing unused kernel memory: 1920K
> [    0.740156] Run /sbin/init as init process
> [    0.740229]   with arguments:
> [    0.740286]     /sbin/init
> [    0.740321]   with environment:
> [    0.740369]     HOME=/
> [    0.740400]     TERM=linux
> [    0.743162] Unable to handle kernel paging request at virtual address
> fffffdffbf000008
> [    0.743285] Mem abort info:
> [    0.743316]   ESR = 0x0000000096000006
> [    0.743371]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.743444]   SET = 0, FnV = 0
> [    0.743489]   EA = 0, S1PTW = 0
> [    0.743545]   FSC = 0x06: level 2 translation fault
> [    0.743610] Data abort info:
> [    0.743656]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
> [    0.743720]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    0.743785]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    0.743848] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000b9d17000
> [    0.743931] [fffffdffbf000008] pgd=10000000bfa3d403,
> p4d=10000000bfa3d403, pud=1000000040bfe403, pmd=0000000000000000
> [    0.744070] Internal error: Oops: 0000000096000006 [#1]  SMP
> [    0.748888] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.18.4 #1 NONE
> [    0.749421] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    0.749969] pc : dax_disassociate_entry.constprop.0+0x20/0x50
> [    0.750444] lr : dax_insert_entry+0xcc/0x408
> [    0.750802] sp : ffff80008000b9e0
> [    0.751083] x29: ffff80008000b9e0 x28: 0000000000000000 x27:
> 0000000000000000
> [    0.751682] x26: 0000000001963d01 x25: ffff0000004f7d90 x24:
> 0000000000000000
> [    0.752264] x23: 0000000000000000 x22: ffff80008000bcc8 x21:
> 0000000000000011
> [    0.752836] x20: ffff80008000ba90 x19: 0000000001963d01 x18:
> 0000000000000000
> [    0.753407] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000000
> [    0.753970] x14: ffffbf3154b9ae70 x13: 0000000000000000 x12:
> ffffbf3154b9ae70
> [    0.754548] x11: ffffffffffffffff x10: 0000000000000000 x9 :
> 0000000000000000
> [    0.755122] x8 : 000000000000000d x7 : 000000000000001f x6 :
> 0000000000000000
> [    0.755707] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> fffffdffc0000000
> [    0.756287] x2 : 0000000000000008 x1 : 0000000040000000 x0 :
> fffffdffbf000000
> [    0.756871] Call trace:
> [    0.757107]  dax_disassociate_entry.constprop.0+0x20/0x50 (P)
> [    0.757592]  dax_iomap_pte_fault+0x4fc/0x808
> [    0.757951]  dax_iomap_fault+0x28/0x30
> [    0.758258]  ext4_dax_huge_fault+0x80/0x2dc
> [    0.758594]  ext4_dax_fault+0x10/0x3c
> [    0.758892]  __do_fault+0x38/0x12c
> [    0.759175]  __handle_mm_fault+0x530/0xcf0
> [    0.759518]  handle_mm_fault+0xe4/0x230
> [    0.759833]  do_page_fault+0x17c/0x4dc
> [    0.760144]  do_translation_fault+0x30/0x38
> [    0.760483]  do_mem_abort+0x40/0x8c
> [    0.760771]  el0_ia+0x4c/0x170
> [    0.761032]  el0t_64_sync_handler+0xd8/0xdc
> [    0.761371]  el0t_64_sync+0x168/0x16c
> [    0.761677] Code: f9453021 f2dfbfe3 cb813080 8b001860 (f9400401)
> [    0.762168] ---[ end trace 0000000000000000 ]---
> [    0.762550] note: init[1] exited with irqs disabled
> [    0.762631] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> 
> This patch just reorders checking and converting.
> 
> Signed-off-by: Seunguk Shin <seunguk.shin@arm.com>

I think this was introduced by Alistair's patches (added to CC) and as such
we should add:

Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")

tag here. Otherwise the fix looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 289e6254aa30..de316be2cc4e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -443,11 +443,12 @@ static void dax_associate_entry(void *entry, struct
> address_space *mapping,
>                                 unsigned long address, bool shared)
>  {
>         unsigned long size = dax_entry_size(entry), index;
> -       struct folio *folio = dax_to_folio(entry);
> +       struct folio *folio;
> 
>         if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
>                 return;
> 
> +       folio = dax_to_folio(entry);
>         index = linear_page_index(vma, address & ~(size - 1));
>         if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
>                 if (folio->mapping)
> @@ -468,21 +469,23 @@ static void dax_associate_entry(void *entry, struct
> address_space *mapping,
>  static void dax_disassociate_entry(void *entry, struct address_space
> *mapping,
>                                 bool trunc)
>  {
> -       struct folio *folio = dax_to_folio(entry);
> +       struct folio *folio;
> 
>         if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
>                 return;
> 
> +       folio = dax_to_folio(entry);
>         dax_folio_put(folio);
>  }
> 
>  static struct page *dax_busy_page(void *entry)
>  {
> -       struct folio *folio = dax_to_folio(entry);
> +       struct folio *folio;
> 
>         if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
>                 return NULL;
> 
> +       folio = dax_to_folio(entry);
>         if (folio_ref_count(folio) - folio_mapcount(folio))
>                 return &folio->page;
>         else
> --
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

