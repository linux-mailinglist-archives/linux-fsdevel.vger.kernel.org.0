Return-Path: <linux-fsdevel+bounces-52868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495AFAE7AEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA035A0041
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED62820A7;
	Wed, 25 Jun 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cyy+NN0h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rGwHmcrF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cyy+NN0h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rGwHmcrF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE21274FDB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841612; cv=none; b=L0RURsgCDErLDDNEs6fnHnt1RKB+pOdS8z6HlS4ah33I9dxn33BNDQFXygmG6/kVALD9ck2n8+ksVLQAoSkXFzukjp1uAuCBqwlcIidPcxbcwE+PKhX3dRTumc6B6kg5Ol/WcOt2UZTrrub7dw+ok0KrLd905z/3v+ESLwW+rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841612; c=relaxed/simple;
	bh=tZbZp/vtpw2+MpssFSXFUMkGQYHFpzOZjs1LC9c5oNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf+G6LkJvB2JkvbBtMgLYeZDhCA+MPWKfXeOQsjrV+VRhc4/dHn1GDiiHMdu/UJNiy1LU4K6pSlGs2osCm0FbxPbeW/J1hP54iseZP2SNzjGJR3wVNrShdpZvN15XW/i52m2g/5i5oKpc+4Girqj4ydJL3VufbXLxP1TQ36wPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cyy+NN0h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rGwHmcrF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cyy+NN0h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rGwHmcrF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D6291F441;
	Wed, 25 Jun 2025 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750841609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAfGh4tYtysketyE4fbGkajM3VhOr88Hy7D0kXgBIiU=;
	b=cyy+NN0hrseRtAGCGBieJVuers0yS9mDOnwBsQkfjvA4vTfElXF9LBcFPJC5g42YcOWnnf
	kTFWduHPeuZsjTb3MlzoftZVmCB9Myqt0knmJq3lwBuY5kijYGEJSKM8mftl6YDrUndxeq
	YTGo4dnpA209BaBqWWNpNViantAlXFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750841609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAfGh4tYtysketyE4fbGkajM3VhOr88Hy7D0kXgBIiU=;
	b=rGwHmcrFlj+nV2KdEQwWN3n5vfoo/k7CBzpbQ0xp+u+NAsLjhNM2V4rMA5UpDFNC+jAbud
	neEzhTu5DnXfcHBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750841609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAfGh4tYtysketyE4fbGkajM3VhOr88Hy7D0kXgBIiU=;
	b=cyy+NN0hrseRtAGCGBieJVuers0yS9mDOnwBsQkfjvA4vTfElXF9LBcFPJC5g42YcOWnnf
	kTFWduHPeuZsjTb3MlzoftZVmCB9Myqt0knmJq3lwBuY5kijYGEJSKM8mftl6YDrUndxeq
	YTGo4dnpA209BaBqWWNpNViantAlXFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750841609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAfGh4tYtysketyE4fbGkajM3VhOr88Hy7D0kXgBIiU=;
	b=rGwHmcrFlj+nV2KdEQwWN3n5vfoo/k7CBzpbQ0xp+u+NAsLjhNM2V4rMA5UpDFNC+jAbud
	neEzhTu5DnXfcHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B604713485;
	Wed, 25 Jun 2025 08:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TjjbKQe5W2ikJwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 08:53:27 +0000
Date: Wed, 25 Jun 2025 10:53:26 +0200
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
Subject: Re: [PATCH RFC 10/14] mm/memory: factor out common code from
 vm_normal_page_*()
Message-ID: <aFu5Bn2APcr2sf7k@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-11-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-11-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhwqoz3wsm4df3nfubx4grhps)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:43:41PM +0200, David Hildenbrand wrote:
> Let's reduce the code duplication and factor out the non-pte/pmd related
> magic into vm_normal_page_pfn().
> 
> To keep it simpler, check the pfn against both zero folios. We could
> optimize this, but as it's only for the !CONFIG_ARCH_HAS_PTE_SPECIAL
> case, it's not a compelling micro-optimization.
> 
> With CONFIG_ARCH_HAS_PTE_SPECIAL we don't have to check anything else,
> really.
> 
> It's a good question if we can even hit the !CONFIG_ARCH_HAS_PTE_SPECIAL
> scenario in the PMD case in practice: but doesn't really matter, as
> it's now all unified in vm_normal_page_pfn().
> 
> While at it, add a check that pmd_special() is really only set where we
> would expect it.
> 
> No functional change intended.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Comment below

>  struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
> @@ -650,35 +661,12 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	unsigned long pfn = pmd_pfn(pmd);
>  
> -	/* Currently it's only used for huge pfnmaps */

Although the check kind of spells it out, we could leave this one and also add
that huge_zero_pfn, to make it more explicit.
 

-- 
Oscar Salvador
SUSE Labs

