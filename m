Return-Path: <linux-fsdevel+bounces-52317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8596DAE1B37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D914E1897C2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BD321C17D;
	Fri, 20 Jun 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ic9HrU6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LiHWWYCP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ic9HrU6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LiHWWYCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79328AAED
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423825; cv=none; b=KkD/odg9qsAVQ57m/Yr1DhThBXGk2NTQzZg46kfT4VhGXAoqbw5/IicvOjUYYI/7AM/jLbE103aL2KW9qbEupRylkmppXyNXzNE3SnSGHghfesRL/h8O3CjQk/VypVukXmCvlcXvXlKGsxZwmFuu9t23lEA65huZGbb77pI16nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423825; c=relaxed/simple;
	bh=gQdstqaspvuL3Mn1j+dGyEJD3gl//kgW/fcz2I4sQoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLb/6hVye4Rh/xMxLKWFH18I6ReJtrWv93wDcMtRJ+1F2GljTZ/oiUhEPzHhvPi49Cw1LikylHUhtfUrt5qGAQ1WE0OuJrtsRMLRxYEJr0Sa34beVrA2cA21KikMj/es7jOsw6Wf8skan/eWU6mKD64HHL7jNnOEnX/2cu+IaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ic9HrU6f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LiHWWYCP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ic9HrU6f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LiHWWYCP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D84F7218F7;
	Fri, 20 Jun 2025 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750423821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ys4+sy2p6wxH24z91HD2NA/Jzc9E+Z7k2Ikl+nHm4uE=;
	b=Ic9HrU6fKmKemc6KvyVie4e50fWVhwD+Pq5jFpRKT8Qz5KPWBCVI6IfeQ7MZTM/rR3Dawk
	JYd+1tnhjJ/pUCS4sxwxVTDzIy3n8ZoIsn9fb1jYKiums/9nJ6vRA4Hg4TaYN46hoF4KHf
	AiIJ287Dktu3RCmEMM4hZuD4Uoz4Mx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750423821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ys4+sy2p6wxH24z91HD2NA/Jzc9E+Z7k2Ikl+nHm4uE=;
	b=LiHWWYCP2jqqbGGo61z0PzeQ5K4GXoyC1iSFhHJIvFSfA/2nIJz6ENBvt/C+kd8GeQx1xn
	JUSbZDa60QgO/tCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750423821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ys4+sy2p6wxH24z91HD2NA/Jzc9E+Z7k2Ikl+nHm4uE=;
	b=Ic9HrU6fKmKemc6KvyVie4e50fWVhwD+Pq5jFpRKT8Qz5KPWBCVI6IfeQ7MZTM/rR3Dawk
	JYd+1tnhjJ/pUCS4sxwxVTDzIy3n8ZoIsn9fb1jYKiums/9nJ6vRA4Hg4TaYN46hoF4KHf
	AiIJ287Dktu3RCmEMM4hZuD4Uoz4Mx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750423821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ys4+sy2p6wxH24z91HD2NA/Jzc9E+Z7k2Ikl+nHm4uE=;
	b=LiHWWYCP2jqqbGGo61z0PzeQ5K4GXoyC1iSFhHJIvFSfA/2nIJz6ENBvt/C+kd8GeQx1xn
	JUSbZDa60QgO/tCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C98D136BA;
	Fri, 20 Jun 2025 12:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wMA/BAxZVWiqLgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 20 Jun 2025 12:50:20 +0000
Date: Fri, 20 Jun 2025 14:50:18 +0200
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
Message-ID: <aFVZCvOpIpBGAf9w@localhost.localdomain>
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
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

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

I'm confused, I'm missing something here.
Before this change we would return NULL if e.g: pfn > highest_memmap_pfn, but
now we just print the warning and call pfn_to_page() anyway.
AFAIK, pfn_to_page() doesn't return NULL?
 

-- 
Oscar Salvador
SUSE Labs

