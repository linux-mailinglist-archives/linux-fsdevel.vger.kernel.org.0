Return-Path: <linux-fsdevel+bounces-21308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D83901A12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0981F21C63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 04:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED9DDBB;
	Mon, 10 Jun 2024 04:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GU+QqmkW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Xu3G1CW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GU+QqmkW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Xu3G1CW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4049D304;
	Mon, 10 Jun 2024 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994955; cv=none; b=FuYlsJrbgdzSHA0zolT15i5A/ya8xA07IoW0vSdKg9TwPMmcwru6LcjBfLeQjAdhwIv3HhAOUOqVxRgHX7SqzWPokUzS5MHI30DX7IrFb3DhKfx7MfQdmVc6fpI0GKR5xvn0GLJEWEF+roR32u0CcKjbXRzWTQpDId+WY2M6OuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994955; c=relaxed/simple;
	bh=ewlToF4d7d5kFiGevHJgz4TudxyAcaMpxGxi+4W1iKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbKAXRhFZlwuEQyQoczjcL+gx0Q98bK7ZWwgfZoMZbozDYNAyaAvb9053WnfhX8aOEA5cwXoKpYFGHr5/KQHCG4DYzSWQvOyNdkJliO8AIJClEQF0m6G5A/tIJWBthPJ3yuPER80WLxJWTHDHrVwoxdDKqPDLF1Egf6/mkV9CVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GU+QqmkW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Xu3G1CW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GU+QqmkW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Xu3G1CW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C550621A28;
	Mon, 10 Jun 2024 04:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717994951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CnYPnGkfnl4u6bw5KXqozmF5Gw9xCjdvsWRN0WG0YI=;
	b=GU+QqmkWmqkb/WMg/Xw/lZuzX3xYTh1mLoVT83OkJcaDQwirJhkizproDDRneLrofKGJAq
	To7ZsWuthJJaGNitkyQufQLtGZAS7NXzgGJ34bIlwgXpw3HhUzwFbAX6M1msfFvzvQkb8K
	csvnoKcKvUfXfrm2MBY++t7llliP4Ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717994951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CnYPnGkfnl4u6bw5KXqozmF5Gw9xCjdvsWRN0WG0YI=;
	b=2Xu3G1CWjQMBrWHWy+Raxz32I23yOu3otkTScqrd3tZDMsuGh+mcx7LkNVMoKq4hljq7NZ
	/Of0G/J2YjneYuDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717994951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CnYPnGkfnl4u6bw5KXqozmF5Gw9xCjdvsWRN0WG0YI=;
	b=GU+QqmkWmqkb/WMg/Xw/lZuzX3xYTh1mLoVT83OkJcaDQwirJhkizproDDRneLrofKGJAq
	To7ZsWuthJJaGNitkyQufQLtGZAS7NXzgGJ34bIlwgXpw3HhUzwFbAX6M1msfFvzvQkb8K
	csvnoKcKvUfXfrm2MBY++t7llliP4Ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717994951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CnYPnGkfnl4u6bw5KXqozmF5Gw9xCjdvsWRN0WG0YI=;
	b=2Xu3G1CWjQMBrWHWy+Raxz32I23yOu3otkTScqrd3tZDMsuGh+mcx7LkNVMoKq4hljq7NZ
	/Of0G/J2YjneYuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 610C913A7F;
	Mon, 10 Jun 2024 04:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0AUaFceFZmZYHAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 04:49:11 +0000
Date: Mon, 10 Jun 2024 06:49:09 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/6] fs/proc/task_mmu: don't indicate
 PM_MMAP_EXCLUSIVE without PM_PRESENT
Message-ID: <ZmaFxfQX3AVMIVkp@localhost.localdomain>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122357.115423-3-david@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, Jun 07, 2024 at 02:23:53PM +0200, David Hildenbrand wrote:
> Relying on the mapcount for non-present PTEs that reference pages
> doesn't make any sense: they are not accounted in the mapcount, so
> page_mapcount() == 1 won't return the result we actually want to know.
> 
> While we don't check the mapcount for migration entries already, we
> could end up checking it for swap, hwpoison, device exclusive, ...
> entries, which we really shouldn't.
> 
> There is one exception: device private entries, which we consider
> fake-present (e.g., incremented the mapcount). But we won't care about
> that for now for PM_MMAP_EXCLUSIVE, because indicating PM_SWAP for them
> although they are fake-present already sounds suspiciously wrong.
> 
> Let's never indicate PM_MMAP_EXCLUSIVE without PM_PRESENT.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Forgot to comment on something:

> @@ -1517,14 +1514,13 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  			if (pmd_swp_uffd_wp(pmd))
>  				flags |= PM_UFFD_WP;
>  			VM_BUG_ON(!is_pmd_migration_entry(pmd));
> -			migration = is_migration_entry(entry);
>  			page = pfn_swap_entry_to_page(entry);

We do not really need to get the page anymore here as that is the non-present
part.

Then we could get away without checking the flags as only page != NULL
would mean a present pmd.

Not that we gain much as this is far from being a hot-path, but just
saying..

-- 
Oscar Salvador
SUSE Labs

