Return-Path: <linux-fsdevel+bounces-61918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EF5B7D8F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CE03BD113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98C309EE3;
	Wed, 17 Sep 2025 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ptkrptGs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CuqXr5mf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ptkrptGs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CuqXr5mf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E02EC0A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107287; cv=none; b=XCoTsfQYvbGgVFuF6Kxw3B9fat6eb+Ap006zfkOe2ygxdVg8E37/7RTQUlvf3NOsrg0Z0F48smkRc5t9XRCZyI+nhwX7Rc8osBsN6iadEoRC4nRAulVK56Y7SePIb4t+Y5RqIn7R+33cDrh0tKvTOWkbp8lvDVLvQELwKNBXSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107287; c=relaxed/simple;
	bh=ciZgr3saMqkC9Hg4J5Abkz6ma9TvnLFlCoi8tiRqVbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smLYp47azH5jW07h4lTj2p8vHU5aNXKDNHcJpFHy+uQ7reFhkJbi3itVYkY628s7F5DEMocKepymDcczjhTFAwLuoOiguUIGwjgBogiT8Xvdx4bo3s0PsLpPvQZOn3O8GfRmZKkr21bE/4N/V1ASsH1SVXZSP5YuJRAm9XJ5gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ptkrptGs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CuqXr5mf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ptkrptGs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CuqXr5mf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 732A82126F;
	Wed, 17 Sep 2025 11:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758107282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/j+TghCbMxS6Hr+M6Px03nxBiobgKniH+u2vLxerW8=;
	b=ptkrptGseCISVsQSxi+p8tUW59Rrjz0N5sPnd1wzkFhKOxrWCHCwTIW4TWDHSpOespuFww
	1e1PZQAzfRkjbo8bpdzp23GXJKOG2bLZpYH6zuvmfjqFO+esZfZXR+lBVUjtyUWkNHbwAY
	0UVQEfLseGzXPrwa54eoqUh4Ta4r680=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758107282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/j+TghCbMxS6Hr+M6Px03nxBiobgKniH+u2vLxerW8=;
	b=CuqXr5mf1f5gVEyVE/lNW/q6XMjuaOaU8Fo7jUe67po6sdGNuF62L3WB6GMPs7nmsIzR+e
	XeKtsoSUgaSSfvAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758107282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/j+TghCbMxS6Hr+M6Px03nxBiobgKniH+u2vLxerW8=;
	b=ptkrptGseCISVsQSxi+p8tUW59Rrjz0N5sPnd1wzkFhKOxrWCHCwTIW4TWDHSpOespuFww
	1e1PZQAzfRkjbo8bpdzp23GXJKOG2bLZpYH6zuvmfjqFO+esZfZXR+lBVUjtyUWkNHbwAY
	0UVQEfLseGzXPrwa54eoqUh4Ta4r680=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758107282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/j+TghCbMxS6Hr+M6Px03nxBiobgKniH+u2vLxerW8=;
	b=CuqXr5mf1f5gVEyVE/lNW/q6XMjuaOaU8Fo7jUe67po6sdGNuF62L3WB6GMPs7nmsIzR+e
	XeKtsoSUgaSSfvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D09581368D;
	Wed, 17 Sep 2025 11:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1iOPL46WymikQwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 17 Sep 2025 11:07:58 +0000
Date: Wed, 17 Sep 2025 12:07:52 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	kexec@lists.infradead.org, kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>, 
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 06/13] mm: add remap_pfn_range_prepare(),
 remap_pfn_range_complete()
Message-ID: <fdkqhtegozzwx3p4fqzkar7dfbzffn7xiz7ht365c3pe4x6hk3@zbfwoktrhci3>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <7c050219963aade148332365f8d2223f267dd89a.1758031792.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c050219963aade148332365f8d2223f267dd89a.1758031792.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,infradead.org,kernel.org,alpha.franken.de,linux.ibm.com,davemloft.net,gaisler.com,arndb.de,linuxfoundation.org,intel.com,fluxnic.net,linux.dev,suse.de,redhat.com,paragon-software.com,arm.com,zeniv.linux.org.uk,suse.cz,oracle.com,google.com,suse.com,linux.alibaba.com,gmail.com,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,googlegroups.com,nvidia.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Tue, Sep 16, 2025 at 03:11:52PM +0100, Lorenzo Stoakes wrote:
> We need the ability to split PFN remap between updating the VMA and
> performing the actual remap, in order to do away with the legacy
> f_op->mmap hook.
> 
> To do so, update the PFN remap code to provide shared logic, and also make
> remap_pfn_range_notrack() static, as its one user, io_mapping_map_user()
> was removed in commit 9a4f90e24661 ("mm: remove mm/io-mapping.c").
> 
> Then, introduce remap_pfn_range_prepare(), which accepts VMA descriptor
> and PFN parameters, and remap_pfn_range_complete() which accepts the same
> parameters as remap_pfn_rangte().
                remap_pfn_range

> 
> remap_pfn_range_prepare() will set the cow vma->vm_pgoff if necessary, so
> it must be supplied with a correct PFN to do so.  If the caller must hold
> locks to be able to do this, those locks should be held across the
> operation, and mmap_abort() should be provided to revoke the lock should
> an error arise.
> 
> While we're here, also clean up the duplicated #ifdef
> __HAVE_PFNMAP_TRACKING check and put into a single #ifdef/#else block.
> 
> We would prefer to define these functions in mm/internal.h, however we
> will do the same for io_remap*() and these have arch defines that require
> access to the remap functions.
>

I'm confused. What's stopping us from declaring these new functions in
internal.h? It's supposed to be used by core mm only anyway?


> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

The changes themselves look OK to me, but I'm not super familiar with these
bits anyway.

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

