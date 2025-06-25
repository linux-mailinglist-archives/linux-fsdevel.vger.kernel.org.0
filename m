Return-Path: <linux-fsdevel+bounces-52859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D0AE79C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F871BC688E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2FE20E007;
	Wed, 25 Jun 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ugXBAMjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OR3gvBYA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ugXBAMjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OR3gvBYA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B91E990E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839328; cv=none; b=jV5yenb9SKy5X931GyG/gWuigkIxGzdkqQugVN/l3Yafa/DoketPLKsH9cUMhEcsXUG8tHKjrAh2nbyZhkjcDrDGg0XO7NLAXTn239fnElKFWI86mdFDjvNRhTK63lAhNPQE+kEFES06PFamfzadnxKSXMIHGe+UHQGoj0DwpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839328; c=relaxed/simple;
	bh=+PaCCUmw1ybpR45z4pBl88rg+ZMhAu6ODh9EN99oOTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwMucpGjDYKAMMGXmbPvRt+61amYU+D2+ezrMezdaUAZ7ETV+YRkbBfajGIXAZ5AAS6POC7gKjTcfISGJMUGR6ED7TKeS07cfwFGfHgLUpjggJ5XlqO6hOQxkpgt3rZcOccbEd4P5Af+G+6CvlrkPF7ZC93n7UREcFztJGdHp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ugXBAMjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OR3gvBYA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ugXBAMjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OR3gvBYA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B4CD1F441;
	Wed, 25 Jun 2025 08:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750839325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BqRuDfyym3GMLPKIzCqnQ5WuIIDbXNkO7EJ8+AjpXY=;
	b=ugXBAMjf1CuR3YYZVcVdgSE+DpTi3ti3pqBby1QyvaTXUU6iozh/xxrTBb3XI7NTH4ZSLB
	hypsOfNQXPAY6zIFKsSKbggW+4ASPy+2+Mvpc1yz0rcmZBlfktxkuRB8iUnDdIolQRJBR/
	lFSAot5RjOw4+1RDSPCbOKindeoQzPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750839325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BqRuDfyym3GMLPKIzCqnQ5WuIIDbXNkO7EJ8+AjpXY=;
	b=OR3gvBYAwe31U8phnHX5Z9yJtmLm4I5pEFZTjXPl9dhBMToX2wWxVDYYGGji59QL8pDU/u
	mbggJRf4r9X2Y5DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ugXBAMjf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OR3gvBYA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750839325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BqRuDfyym3GMLPKIzCqnQ5WuIIDbXNkO7EJ8+AjpXY=;
	b=ugXBAMjf1CuR3YYZVcVdgSE+DpTi3ti3pqBby1QyvaTXUU6iozh/xxrTBb3XI7NTH4ZSLB
	hypsOfNQXPAY6zIFKsSKbggW+4ASPy+2+Mvpc1yz0rcmZBlfktxkuRB8iUnDdIolQRJBR/
	lFSAot5RjOw4+1RDSPCbOKindeoQzPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750839325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BqRuDfyym3GMLPKIzCqnQ5WuIIDbXNkO7EJ8+AjpXY=;
	b=OR3gvBYAwe31U8phnHX5Z9yJtmLm4I5pEFZTjXPl9dhBMToX2wWxVDYYGGji59QL8pDU/u
	mbggJRf4r9X2Y5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD9EC13301;
	Wed, 25 Jun 2025 08:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u4CpJxuwW2iOGQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 08:15:23 +0000
Date: Wed, 25 Jun 2025 10:15:22 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, nvdimm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH RFC 06/14] mm/huge_memory: support huge zero folio in
 vmf_insert_folio_pmd()
Message-ID: <aFuwGmM0Ebl1IRGl@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-7-david@redhat.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B4CD1F441
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL88oxspsx4bg3gu1yybyqiqt4)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -4.51
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:43:37PM +0200, David Hildenbrand wrote:
> Just like we do for vmf_insert_page_mkwrite() -> ... ->
> insert_page_into_pte_locked(), support the huge zero folio.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

insert_page_into_pte_locked() creates a special pte in case it finds the
zero folio while insert_pmd() doesn't.
I know that we didn't want to create special mappings for normal refcount folios
but this seems inconsistent? I'm pretty sure there's a reason but could you
elaborate on that?

> ---
>  mm/huge_memory.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1ea23900b5adb..92400f3baa9ff 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1418,9 +1418,11 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	if (fop.is_folio) {
>  		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
>  
> -		folio_get(fop.folio);
> -		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
> -		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
> +		if (!is_huge_zero_folio(fop.folio)) {
> +			folio_get(fop.folio);
> +			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
> +			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
> +		}
>  	} else {
>  		entry = pmd_mkhuge(pfn_pmd(fop.pfn, prot));
>  		entry = pmd_mkspecial(entry);
> -- 
> 2.49.0
> 
> 

-- 
Oscar Salvador
SUSE Labs

