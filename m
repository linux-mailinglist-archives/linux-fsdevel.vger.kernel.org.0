Return-Path: <linux-fsdevel+bounces-52877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D12CAE7CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C14C7B8692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA829AAE3;
	Wed, 25 Jun 2025 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="miKXzUfe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pp4+T8OW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="miKXzUfe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pp4+T8OW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9C27C863
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843231; cv=none; b=DDv1nLI9SWfD7rZi++eKm+hcqznmIIa4oeQ8BbqZ2m5+bgnHgP/xv+bSkQKDj6tn8tgyB+PcEZqzX3Fxlry9mj4R7hP0et3qmLxHv/Wu6uli542DmBsfDtrG2Wpu6WG8RsMSufLYiHHzCctD5b9lxZWjw6NWJmrvSuUglKBzz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843231; c=relaxed/simple;
	bh=uDafNFhTllkTUBhR+Oa68ZEnc3lAmutJazclJcROfpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoVvmO0/xMxcQw5lLC2De2vAjtOqWYC7bIDB4sSjzpXssvqxA+3Tep0PX4ZMJKyIwDMoTec2bya/X8Lq9BsZ34kLiK1BnZACXDPbFEDtJi9teL/zABSTCh81y2omjpx0FwlleDhGnhRAy1O6Q4jdzDfIO539ninYcP9ZmEVm6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=miKXzUfe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pp4+T8OW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=miKXzUfe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pp4+T8OW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7590B21175;
	Wed, 25 Jun 2025 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750843228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4q3oGP7adTB8xOiBgLxnYABFNkmwV9fipjngdpsbJoI=;
	b=miKXzUfeGl2pjydsa10CWxnBe2+CHlKnhDyCPKT646v6UehiSg9+biAVtawaFBQJo8aQin
	cdgi38gDEtnz6+PbEP83t/UT9CgHsh9WL3l6nmLJiY4thRTvACpfvA99l3pGdRz6liynY9
	qTjReKMPsEMjCSHjFPlG77NrYjPdvXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750843228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4q3oGP7adTB8xOiBgLxnYABFNkmwV9fipjngdpsbJoI=;
	b=Pp4+T8OWBB+ZZNZMVIItKcc5NnUoHOmitTzyHMdjD/Ru3J27KyA2yro2T4sTGDoOZWuswY
	vMG6X6WHMBNBodDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750843228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4q3oGP7adTB8xOiBgLxnYABFNkmwV9fipjngdpsbJoI=;
	b=miKXzUfeGl2pjydsa10CWxnBe2+CHlKnhDyCPKT646v6UehiSg9+biAVtawaFBQJo8aQin
	cdgi38gDEtnz6+PbEP83t/UT9CgHsh9WL3l6nmLJiY4thRTvACpfvA99l3pGdRz6liynY9
	qTjReKMPsEMjCSHjFPlG77NrYjPdvXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750843228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4q3oGP7adTB8xOiBgLxnYABFNkmwV9fipjngdpsbJoI=;
	b=Pp4+T8OWBB+ZZNZMVIItKcc5NnUoHOmitTzyHMdjD/Ru3J27KyA2yro2T4sTGDoOZWuswY
	vMG6X6WHMBNBodDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8C3213485;
	Wed, 25 Jun 2025 09:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9mrjNVq/W2h9MAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 09:20:26 +0000
Date: Wed, 25 Jun 2025 11:20:21 +0200
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
Message-ID: <aFu_VeTRSk4Pz-ZL@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-11-david@redhat.com>
 <aFu5Bn2APcr2sf7k@localhost.localdomain>
 <1ea2de52-7684-4e27-a8e9-233390f63eeb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ea2de52-7684-4e27-a8e9-233390f63eeb@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, Jun 25, 2025 at 10:57:39AM +0200, David Hildenbrand wrote:
> I don't think that comment is required anymore -- we do exactly what
> vm_normal_page() does + documents,
> 
> What the current users are is not particularly important anymore.
> 
> Or why do you think it would still be important?

Maybe the current users are not important, but at least a comment directing 
to vm_normal_page like "See comment in vm_normal_page".
Here, and in vm_normal_page_pud().

Just someone has it clear why we're only checking for X and Y when we find a
pte/pmd/pud special.

But not really a strong opinion here, just I think that it might be helpful.


-- 
Oscar Salvador
SUSE Labs

