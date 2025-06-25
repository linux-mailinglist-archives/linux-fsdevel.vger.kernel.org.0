Return-Path: <linux-fsdevel+bounces-52863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C4AE7A57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906AA5A7D44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899E273D73;
	Wed, 25 Jun 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YYF9suUm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="97EOmAoR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YYF9suUm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="97EOmAoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3426E6EC
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840366; cv=none; b=C3dacToZXLlPJR7/LentQo88gfD8aL4+9jW0VGHKu7A0JYQXPltHI+h2CJhqcJurO4kHtuqfxlUcsYLeNkpeEXsd7f5hpijQjeiJ28k/HQcxbqXFOdYbU/k5uHx04lP0QX347tclm0FojKRnuGAyld+znKwK31nwpo7GKu9GPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840366; c=relaxed/simple;
	bh=cLGO2tGWKLpFxyW5gkHqKwbizuk9GuQYNaXUCEwpD/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6TrboUB5nVG1kmBdTszYjDQLK6JEtrb9ArMtp7/GTWKv6T+ByN05StXtdQicc1XdsGtrRWWqrSsF+Ps5lQMJv1zcx9eqNQ/wPROJW5WJpo4zUhfqlMklhK0Leau0JSq82/NJ7bqWevvRgsXgiKH1+LdvOmjQMpeKQiDYc0/C5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YYF9suUm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=97EOmAoR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YYF9suUm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=97EOmAoR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E4F51F441;
	Wed, 25 Jun 2025 08:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750840362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LvsxlS0cmtKd50SAarkgxXsJSJ8SVxlr6YRJZ0Kuw7w=;
	b=YYF9suUmqmsov29mUAAwTXmEGnJGN45O8sq947w5kqRNGYS+c3eM3cjVel9o32Us7nww5O
	bAaC+RrllO1XzTVObIC+llSCBi2NGUP1kJIiALEUlJaXL7CkrISEVDW3m6hVmfuvM13li2
	ZPyssUu75btHyCNPVDdh19o37/jPh1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750840362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LvsxlS0cmtKd50SAarkgxXsJSJ8SVxlr6YRJZ0Kuw7w=;
	b=97EOmAoRfGyaaxwucVMLIn0KlgNXHwc+mku6jg9ohXLjfVZ4r6DPBYIL6zMF7QbFF8iALe
	mYWwvaGcbzAujkCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YYF9suUm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=97EOmAoR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750840362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LvsxlS0cmtKd50SAarkgxXsJSJ8SVxlr6YRJZ0Kuw7w=;
	b=YYF9suUmqmsov29mUAAwTXmEGnJGN45O8sq947w5kqRNGYS+c3eM3cjVel9o32Us7nww5O
	bAaC+RrllO1XzTVObIC+llSCBi2NGUP1kJIiALEUlJaXL7CkrISEVDW3m6hVmfuvM13li2
	ZPyssUu75btHyCNPVDdh19o37/jPh1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750840362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LvsxlS0cmtKd50SAarkgxXsJSJ8SVxlr6YRJZ0Kuw7w=;
	b=97EOmAoRfGyaaxwucVMLIn0KlgNXHwc+mku6jg9ohXLjfVZ4r6DPBYIL6zMF7QbFF8iALe
	mYWwvaGcbzAujkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 218C713485;
	Wed, 25 Jun 2025 08:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QkyABSm0W2jmHwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 08:32:41 +0000
Date: Wed, 25 Jun 2025 10:32:31 +0200
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
Subject: Re: [PATCH RFC 08/14] mm/huge_memory: mark PMD mappings of the huge
 zero folio special
Message-ID: <aFu0H_AgdM2W2-R_@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-9-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-9-david@redhat.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8E4F51F441
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:43:39PM +0200, David Hildenbrand wrote:
> The huge zero folio is refcounted (+mapcounted -- is that a word?)
> differently than "normal" folios, similarly (but different) to the ordinary
> shared zeropage.
> 
> For this reason, we special-case these pages in
> vm_normal_page*/vm_normal_folio*, and only allow selected callers to
> still use them (e.g., GUP can still take a reference on them).
> 
> vm_normal_page_pmd() already filters out the huge zero folio. However,
> so far we are not marking it as special like we do with the ordinary
> shared zeropage. Let's mark it as special, so we can further refactor
> vm_normal_page_pmd() and vm_normal_page().
> 
> While at it, update the doc regarding the shared zero folios.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

While doing this, would it make sense to update vm_normal_page_pmd()
comments to refelect that pmd_special will also catch huge_zero_folio()?
It only mentions huge pfnmaps.

It might not be worth doing since you remove that code later on, but
maybe if someone stares at this commit alone..


-- 
Oscar Salvador
SUSE Labs

