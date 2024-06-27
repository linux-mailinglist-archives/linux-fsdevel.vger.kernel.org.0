Return-Path: <linux-fsdevel+bounces-22619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C291A561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 13:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AD01C22DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865A14D451;
	Thu, 27 Jun 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="luN+Tp9s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FU/ogiTf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="luN+Tp9s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FU/ogiTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930BC148820;
	Thu, 27 Jun 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488020; cv=none; b=VgUkakwS7gy1tzHjiFNtiXx1uLV24tUtcx4EE4xMl7Ji+u7v3U1OKHboR9jJJmOlH6K+r8yPi9RdzWd0ajdMw+gKmVtRPG1/mu7Z71ywq/jCwSH+6yia0G4murUHcbTt1V7eIvyIvIWhFlPqMfbdOcabkfwQrAzUDKVrGq+k0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488020; c=relaxed/simple;
	bh=u+k5a/2uqKJqfAihXtIvotddpIjx40GhhPHNZ53sBA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIgJbEsaeh1uUE6rfZzSA/kj4h4fmadO6EmcBNPkbesjL7OnZJ3Ja6c+0cn6hn56ijnSjGTD2IbSPYQ64o6tdX79KoY8ea8NAfPL7X0YbodP5XoCli4BAnkraHoz4lR0mjEQZetd0KPg46KFhqfD9uv/EKOICvO3Y/ZLE6nRLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=luN+Tp9s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FU/ogiTf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=luN+Tp9s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FU/ogiTf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63CBB210E4;
	Thu, 27 Jun 2024 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719488010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t01R90XdldGO7anUbxHaqX31mDL54qz2uJ5POgVrV3w=;
	b=luN+Tp9sneSe5aIFXVa7+ZSq0Oicz+3+MOwfHde/chD8438+KoisRUxzvb8D1z4WP3bOQz
	VxJXxQobcBj2OgTk3kz6J+e5QHxwgaxsWTIxJyPUOxJrU9S0zo664JUIdm1g2C1oMaT2Eo
	5OG+LDM1yT8dr4qZJCGZuc9F2nevJak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719488010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t01R90XdldGO7anUbxHaqX31mDL54qz2uJ5POgVrV3w=;
	b=FU/ogiTfDgFmO7Vi9yS/KUQgM4cVEziltRx8Qob1nx8hoAQ2muOpZewJqlBhXE0NAdErzT
	HKrH1hm28QpHz1Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=luN+Tp9s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="FU/ogiTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719488010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t01R90XdldGO7anUbxHaqX31mDL54qz2uJ5POgVrV3w=;
	b=luN+Tp9sneSe5aIFXVa7+ZSq0Oicz+3+MOwfHde/chD8438+KoisRUxzvb8D1z4WP3bOQz
	VxJXxQobcBj2OgTk3kz6J+e5QHxwgaxsWTIxJyPUOxJrU9S0zo664JUIdm1g2C1oMaT2Eo
	5OG+LDM1yT8dr4qZJCGZuc9F2nevJak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719488010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t01R90XdldGO7anUbxHaqX31mDL54qz2uJ5POgVrV3w=;
	b=FU/ogiTfDgFmO7Vi9yS/KUQgM4cVEziltRx8Qob1nx8hoAQ2muOpZewJqlBhXE0NAdErzT
	HKrH1hm28QpHz1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A5F81384C;
	Thu, 27 Jun 2024 11:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AmAgEgpOfWYhPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Jun 2024 11:33:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 988C8A08A2; Thu, 27 Jun 2024 13:33:28 +0200 (CEST)
Date: Thu, 27 Jun 2024 13:33:28 +0200
From: Jan Kara <jack@suse.cz>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 06/13] mm/memory: Add dax_insert_pfn
Message-ID: <20240627113328.ozqkzhloufrpsdcr@quack3>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <50013c1ee52b5bb1213571bff66780568455f54c.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50013c1ee52b5bb1213571bff66780568455f54c.1719386613.git-series.apopple@nvidia.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL7pfqg7h1m44jupjp7nguhfec)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,deltatee.com,google.com,suse.cz,ziepe.ca,arm.com,kernel.org,ellerman.id.au,gmail.com,linux.intel.com,infradead.org,mit.edu,huawei.com,redhat.com,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.linux.dev,kvack.org,nvidia.com,lst.de,fromorbit.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 63CBB210E4
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 27-06-24 10:54:21, Alistair Popple wrote:
> Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
> creates a special devmap PTE entry for the pfn but does not take a
> reference on the underlying struct page for the mapping. This is
> because DAX page refcounts are treated specially, as indicated by the
> presence of a devmap entry.
> 
> To allow DAX page refcounts to be managed the same as normal page
> refcounts introduce dax_insert_pfn. This will take a reference on the
> underlying page much the same as vmf_insert_page, except it also
> permits upgrading an existing mapping to be writable if
> requested/possible.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Overall this looks good to me. Some comments below.

> ---
>  include/linux/mm.h |  4 ++-
>  mm/memory.c        | 79 ++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 76 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9a5652c..b84368b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1080,6 +1080,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
>  struct mmu_gather;
>  struct inode;
>  
> +extern void prep_compound_page(struct page *page, unsigned int order);
> +

You don't seem to use this function in this patch?

> diff --git a/mm/memory.c b/mm/memory.c
> index ce48a05..4f26a1f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1989,14 +1989,42 @@ static int validate_page_before_insert(struct page *page)
>  }
>  
>  static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
> -			unsigned long addr, struct page *page, pgprot_t prot)
> +			unsigned long addr, struct page *page, pgprot_t prot, bool mkwrite)
>  {
>  	struct folio *folio = page_folio(page);
> +	pte_t entry = ptep_get(pte);
>  
> -	if (!pte_none(ptep_get(pte)))
> +	if (!pte_none(entry)) {
> +		if (mkwrite) {
> +			/*
> +			 * For read faults on private mappings the PFN passed
> +			 * in may not match the PFN we have mapped if the
> +			 * mapped PFN is a writeable COW page.  In the mkwrite
> +			 * case we are creating a writable PTE for a shared
> +			 * mapping and we expect the PFNs to match. If they
> +			 * don't match, we are likely racing with block
> +			 * allocation and mapping invalidation so just skip the
> +			 * update.
> +			 */
> +			if (pte_pfn(entry) != page_to_pfn(page)) {
> +				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
> +				return -EFAULT;
> +			}
> +			entry = maybe_mkwrite(entry, vma);
> +			entry = pte_mkyoung(entry);
> +			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
> +				update_mmu_cache(vma, addr, pte);
> +			return 0;
> +		}
>  		return -EBUSY;

If you do this like:

		if (!mkwrite)
			return -EBUSY;

You can reduce indentation of the big block and also making the flow more
obvious...

> +	}
> +
>  	/* Ok, finally just insert the thing.. */
>  	folio_get(folio);
> +	if (mkwrite)
> +		entry = maybe_mkwrite(mk_pte(page, prot), vma);
> +	else
> +		entry = mk_pte(page, prot);

I'd prefer:

	entry = mk_pte(page, prot);
	if (mkwrite)
		entry = maybe_mkwrite(entry, vma);

but I don't insist. Also insert_pfn() additionally has pte_mkyoung() and
pte_mkdirty(). Why was it left out here?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

