Return-Path: <linux-fsdevel+bounces-52851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900F1AE791F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6D41BC50C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397EF204098;
	Wed, 25 Jun 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SjrdOX2s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bUX5vEHY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SjrdOX2s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bUX5vEHY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EA207A26
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838103; cv=none; b=DTJRXRqWAe207CzIvbv1YXMXgx7CQmG5/Wm5eIcakcalGyEHQ35z2r5P1w+xJ7xdQPKQeCafbWi8/9GiKUJrSWy972g6CwlwyLgaLt1aeqpT3Xrx50PWOhb+H/Amo3TdSerQ9to0gFs46b95oGOHG8hbOnhglUX8pskPwKiJujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838103; c=relaxed/simple;
	bh=GGSR1sAePJsPOnz++Aerqtc9xPzkK5LJcZnkjQa1RKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeykuQVRY/N1oD4pPGRmv8a7TvU04l89Fojq3N9GxoF25WAgCjtFOgPDWk2N2zG8ncKwbfuKBTxI5h1kZWPBoCSEovC5NO6reh+0Q9oHBfKSBF7HSv1/W/fW4glMHvplq3nbejHBRmiUyXU5GxcxqYCn8vAE2ffAFiOS5hA1WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SjrdOX2s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bUX5vEHY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SjrdOX2s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bUX5vEHY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49BF42116F;
	Wed, 25 Jun 2025 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750838100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jr2DJml86CkvLgTSl6zdjggn2/vW3DsZt/BTczAFHQo=;
	b=SjrdOX2sDdKgblCBMUVnqceNrMIMGh7OJX/oXKNA/dYbvqUlTFLFP+jpNUZipabqT6lRUs
	NEn6D98AlAdhUOLJQJuROjeIfyitgRIrk2YpCJYVqqWiL5h9xC9uiOOT3WX7JiFJrAtEhY
	IzZ4nYNYrfDGb7c1Ur8Soy88nOFnBE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750838100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jr2DJml86CkvLgTSl6zdjggn2/vW3DsZt/BTczAFHQo=;
	b=bUX5vEHYowEIL50emhbwwFb2Vo3qPhtmEGVKJWUo61ycvBCV2bTYEWcMcHt/VS2qmRMSLI
	alj/+MB1POrNwdAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750838100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jr2DJml86CkvLgTSl6zdjggn2/vW3DsZt/BTczAFHQo=;
	b=SjrdOX2sDdKgblCBMUVnqceNrMIMGh7OJX/oXKNA/dYbvqUlTFLFP+jpNUZipabqT6lRUs
	NEn6D98AlAdhUOLJQJuROjeIfyitgRIrk2YpCJYVqqWiL5h9xC9uiOOT3WX7JiFJrAtEhY
	IzZ4nYNYrfDGb7c1Ur8Soy88nOFnBE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750838100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jr2DJml86CkvLgTSl6zdjggn2/vW3DsZt/BTczAFHQo=;
	b=bUX5vEHYowEIL50emhbwwFb2Vo3qPhtmEGVKJWUo61ycvBCV2bTYEWcMcHt/VS2qmRMSLI
	alj/+MB1POrNwdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDAA013301;
	Wed, 25 Jun 2025 07:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5MYqL1KrW2gjEwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 07:54:58 +0000
Date: Wed, 25 Jun 2025 09:54:57 +0200
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
Message-ID: <aFurUeuxhasLdCTT@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-2-david@redhat.com>
 <aFVZCvOpIpBGAf9w@localhost.localdomain>
 <c88c29d2-d887-4c5a-8b4e-0cf30e71d596@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88c29d2-d887-4c5a-8b4e-0cf30e71d596@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Mon, Jun 23, 2025 at 04:04:01PM +0200, David Hildenbrand wrote:
> Hi Oscar,

Hi David,

> 
> > I'm confused, I'm missing something here.
> > Before this change we would return NULL if e.g: pfn > highest_memmap_pfn, but
> > now we just print the warning and call pfn_to_page() anyway.
> > AFAIK, pfn_to_page() doesn't return NULL?
> 
> You're missing that vm_normal_page_pmd() was created as a copy from
> vm_normal_page() [history of the sanity check above], but as we don't have
> (and shouldn't have ...) print_bad_pmd(), we made the code look like this
> would be something that can just happen.

Ok I see.

> 
> "
> Do the same in vm_normal_page_pmd(), where we don't even report a
> problem at all ...
> "
> 
> So we made something that should never happen a runtime sanity check without
> ever reporting a problem ...

all clear now, thanks :-)



-- 
Oscar Salvador
SUSE Labs

