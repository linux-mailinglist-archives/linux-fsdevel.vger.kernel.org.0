Return-Path: <linux-fsdevel+bounces-52349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B892AE221F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F53F3AAB20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE0C2EAB69;
	Fri, 20 Jun 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DsMPYjS2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MwlL7164";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DsMPYjS2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MwlL7164"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1C23B626
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443871; cv=none; b=JfGHo3uLjgB1auNqNnQ4E2HBVxwvXOsI+jJitAmwHe1De5yUcEVeVfHSBtVHYSIiQn8+4hWvplbxSd2rTymWc7yc1r2aQ1ThPLbrc2RpJC0xfGSE4PJbYIDFMjXUaI7L/wXTyQd6NSH5OXkdkqH+7/KOl/WjN8lfosa0xboRH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443871; c=relaxed/simple;
	bh=LlTFqSicIxJCqJzx/7xhoEA+gIfY0lLy+8HgCJYNy+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCOw+XxIqTUnZGDsJWuYhUaxsRxrbAVlUcogPusV83APAQWcAFtrgyqSeRgdcVxf9rRB5anzRh1MfPQPxAZMvskgAdjeOw6qAk7QaLZ6tuMOjtIVuCuv3QsEglqmY2EM2coZC/1ePAmeAfmQwYRhpPg1BzSBpRG8OCeyiW69Q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DsMPYjS2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MwlL7164; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DsMPYjS2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MwlL7164; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AD0C1F395;
	Fri, 20 Jun 2025 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750443867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lswmTKqGOdbcI3vWxx7qPu3GUSF0bctkl3uifvgYUg=;
	b=DsMPYjS2tRka2AE8YfG8rgXcebue7QhMIu8TN6ar1zuv8DAX3Upu05PrQfCcJj2JeH17qi
	++nEF0UBNawpKaNKFe17IbXNZ3V2EzItYXv3mSZzJ0MzQQ11StR6XsdMdDuFYod2GaOFPE
	uLQoOXajiHzU8gBDGar7l8UQP37FTxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750443867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lswmTKqGOdbcI3vWxx7qPu3GUSF0bctkl3uifvgYUg=;
	b=MwlL7164CYwcEFQW8H5X8aOWOLsZN5j5aJWwkCKrZ5AyDrOvZ1n+zG03w5/LLdgmRe1/4z
	17rvJX7nxfxWxJBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750443867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lswmTKqGOdbcI3vWxx7qPu3GUSF0bctkl3uifvgYUg=;
	b=DsMPYjS2tRka2AE8YfG8rgXcebue7QhMIu8TN6ar1zuv8DAX3Upu05PrQfCcJj2JeH17qi
	++nEF0UBNawpKaNKFe17IbXNZ3V2EzItYXv3mSZzJ0MzQQ11StR6XsdMdDuFYod2GaOFPE
	uLQoOXajiHzU8gBDGar7l8UQP37FTxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750443867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lswmTKqGOdbcI3vWxx7qPu3GUSF0bctkl3uifvgYUg=;
	b=MwlL7164CYwcEFQW8H5X8aOWOLsZN5j5aJWwkCKrZ5AyDrOvZ1n+zG03w5/LLdgmRe1/4z
	17rvJX7nxfxWxJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B41B413736;
	Fri, 20 Jun 2025 18:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6HJcJlmnVWhUEQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 20 Jun 2025 18:24:25 +0000
Date: Fri, 20 Jun 2025 19:24:23 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nvdimm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alistair Popple <apopple@nvidia.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 03/14] mm: compare pfns only if the entry is present
 when inserting pfns/pages
Message-ID: <dq5r2xmw3ypfk2luffas45up525aig4nu7qogojajspukak74o@gtg4kwwvjb5c>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-4-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL8d8xedm6iu8o66torxsk6bwd)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:43:34PM +0200, David Hildenbrand wrote:
> Doing a pte_pfn() etc. of something that is not a present page table
> entry is wrong. Let's check in all relevant cases where we want to
> upgrade write permissions when inserting pfns/pages whether the entry
> is actually present.
> 
> It's not expected to have caused real harm in practice, so this is more a
> cleanup than a fix for something that would likely trigger in some
> weird circumstances.

Couldn't we e.g have a swap entry's "pfn" accidentally match the one we're
inserting? Isn't that a correctness problem?

> 
> At some point, we should likely unify the two pte handling paths,
> similar to how we did it for pmds/puds.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Nice little cleanup, thanks.

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

