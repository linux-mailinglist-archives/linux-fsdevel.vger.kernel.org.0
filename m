Return-Path: <linux-fsdevel+bounces-52852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913B4AE7923
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F57B1BC5134
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B0620B7FD;
	Wed, 25 Jun 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R5wIjtJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J2dZhp5t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CDSxgEzK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wBMuvC/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D3208994
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838135; cv=none; b=jvpeTPFTjAOZrJ6TGYuo0+DSn+5bz05DsTyXkavu4ED71/z0m0ukT06ZMp4dN+BaGWfB9G8TBKfmnnYWXVy9oDTMAhq4YVdam8ojfhcTNU/sOa3n0SLpz3hO+ZcGo7WSpbR0eR28PB5g/5R3mW7x9x6WgkhmXqmgcsT7wAgEf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838135; c=relaxed/simple;
	bh=ZYcK/QhUWG4a3uuHz4avqRso0r+r5J9nI7/Ht04+45E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLDEwNNNN723R09EZGrpdRaVd9IrywKrT33X/CyLcqur+bnVNl1byuypsj/9KVuofW4qSnhoTBTsSmJN+OjSkouR1T3xW3VLzrAZtu3p8pfNjZFpInbauwpDwRQoKn8UnGHIvPrgip86fnUL1dM898/mjGZXd1srbimSBi1Gmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R5wIjtJC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J2dZhp5t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CDSxgEzK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wBMuvC/o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED1132118D;
	Wed, 25 Jun 2025 07:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750838132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWM6hseW4eoKZZAbk3Im6Bzz3XY09qGq4SXJ9GVOPfk=;
	b=R5wIjtJCZn1i/1vm/mBuJQHs+s0hkuaOVnLnLaT9RXCW6RE4+MDHcAWOxPiiPWLJgn7w7N
	uXgdi+nafBJjfEAzHvfm87SbLEan1PGtM7ph7Of001x4Fx9h9upaYaOxJLPKY09i+5dmv2
	WSJ8LDp2b0XRSCoHXS+tKNxIAiUU8/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750838132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWM6hseW4eoKZZAbk3Im6Bzz3XY09qGq4SXJ9GVOPfk=;
	b=J2dZhp5tZ/XnuGQtjxU5BNEasaCrXiNAYOJ/dtx2OHDHuuXqFTPOSfq94RGXAfMzhdgQKT
	FLUfS0dn03WpX/Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CDSxgEzK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="wBMuvC/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750838131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWM6hseW4eoKZZAbk3Im6Bzz3XY09qGq4SXJ9GVOPfk=;
	b=CDSxgEzKPP2x/qWOIVC72xSenHdukkNiDUUHhWDhCmn9JX4R2Vi/y2uR7NNn5CONywZVGF
	e04B/LcpA4C9WBw8hZNYrH34sWXJmeWq9cCwGhVKYELFi2YJXPW9kCyHLJVa0kLXOLzIGS
	kDTkvybRoiXgp7ly1sgbUcSihJDaZsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750838131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWM6hseW4eoKZZAbk3Im6Bzz3XY09qGq4SXJ9GVOPfk=;
	b=wBMuvC/o1iuEL3o5PfUUQUDBp4AOyBXEu/z5ji4u8mx2yR4p4SAp+FYyc4PcKSjAlKRcAs
	R8oVO+hz5WcxosDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B02313301;
	Wed, 25 Jun 2025 07:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yv9IG3KrW2hUEwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 07:55:30 +0000
Date: Wed, 25 Jun 2025 09:55:24 +0200
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
Subject: Re: [PATCH RFC 01/14] mm/memory: drop highest_memmap_pfn sanity
 check in vm_normal_page()
Message-ID: <aFurbAYy_F1LT9LD@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-2-david@redhat.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL88oxspsx4bg3gu1yybyqiqt4)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ED1132118D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On Tue, Jun 17, 2025 at 05:43:32PM +0200, David Hildenbrand wrote:
> In 2009, we converted a VM_BUG_ON(!pfn_valid(pfn)) to the current
> highest_memmap_pfn sanity check in commit 22b31eec63e5 ("badpage:
> vm_normal_page use print_bad_pte"), because highest_memmap_pfn was
> readily available.
> 
> Nowadays, this is the last remaining highest_memmap_pfn user, and this
> sanity check is not really triggering ... frequently.
> 
> Let's convert it to VM_WARN_ON_ONCE(!pfn_valid(pfn)), so we can
> simplify and get rid of highest_memmap_pfn. Checking for
> pfn_to_online_page() might be even better, but it would not handle
> ZONE_DEVICE properly.
> 
> Do the same in vm_normal_page_pmd(), where we don't even report a
> problem at all ...
> 
> What might be better in the future is having a runtime option like
> page-table-check to enable such checks dynamically on-demand. Something
> for the future.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

