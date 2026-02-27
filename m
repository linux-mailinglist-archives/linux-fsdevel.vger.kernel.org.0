Return-Path: <linux-fsdevel+bounces-78731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D53Ex+5oWkYwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:32:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBD1B9D7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA6D4320AFB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94441C2FB;
	Fri, 27 Feb 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BP9gWk1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252E43C07B;
	Fri, 27 Feb 2026 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205614; cv=none; b=IJtYqfJ9+D+qdllSrkz8VjUzJA2xVqJ9zYLUuu+tZLfwFzciYvX/3O9zQW994DGB982OCctoxNYdniRzpi44utdBDRpkWYyz4EMsR1gNqWCQ4uKnUqfRc92FDOXe/tqS6NYWzh4H/XQO0YYvCjCk92HFo4pLGglFd+S72/d1mqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205614; c=relaxed/simple;
	bh=xGnhZ6cyzcE6XY1nG/LDxblnQBcXSXIBaA0mnqv9XWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u17YJPqCUjq9pmW02DrGngtjkKWxnqVpOPwn7srfEzkrSexxhhEgPosTjr8L3IgLb4fkcTYsPCroLLcFaHbOcbKOT5lmc7u3Rgo25jtaijtTuzUDZQmr3b4esONwvKPfzJ41rmmt+hOnjr0zk1HlgaFeJTnKwkUNq6/ktNmHoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BP9gWk1R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=re+X6ck1AQZQchao0ynbIryXcVgPOwh7dKHH9EvgBr4=; b=BP9gWk1RTiW1qovhNGxhD9zEDq
	H24UnepRzhoEGp8jmVB75TB3tgUrUkwOAV2s9QulxkEWG6xFpqFV+BljiLpJeXGcWUKEFvcaq56lu
	UY7cbVSBEONJ5NmV88jrLLgL7aTMrnsHfRWRXhiQPguUjSctEqAFP83fM4tESFmHx/8kivPpdgi/y
	z7+zCF68ep7RIKRgMbJR6jrtlBmzgQQpUeA1dOv0RkmpzZF55PwtEjkyQUQcWmBd0J5Uf8cj9Uy7T
	ktLJUj8cXYEevOxSRDdzzqgJh2xXNECvf7M+7fVZgcCO9/eaovNg6sKxAryWF5DSt8RGXTqA0TxDC
	GB0qG6UQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvzdC-00000004kz2-17tX;
	Fri, 27 Feb 2026 15:19:54 +0000
Date: Fri, 27 Feb 2026 15:19:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, Michal Hocko <mhocko@suse.com>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, kernel@pankajraghav.com, tytso@mit.edu
Subject: Re: [RFC v2 0/3] Decoupling large folios dependency on THP
Message-ID: <aaG2GkICML-St3B4@casper.infradead.org>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <aaEsOu0hgCUznzl3@casper.infradead.org>
 <8ca84535-861c-4ab0-a46b-5dfe319ac8ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca84535-861c-4ab0-a46b-5dfe319ac8ac@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78731-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: A1CBD1B9D7D
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:45:07AM +0100, David Hildenbrand (Arm) wrote:
> I guess it would be rather trivial to just replace
> add_to_page_cache_lru() by filemap_add_folio() in below code.

In the Ottawa interpretation, that's true, but I'd prefer not to revisit
this code when transitioning to the New York interpretation.  This is
the NOMMU code after all, and the less time we spend on it, the better.

> > So either we need to reimplement all the good stuff that folio_split()
> > does for us, or we need to make folio_split() available on nommu.
> 
> folio splitting usually involves unmapping pages, which is rather
> cumbersome on nommu ;) So we'd have to think about that and the
> implications.

Depending on your point of view, either everything is mapped on nommu,
or nothing is mapped ;-)  In any case, the folio is freshly-allocated
and locked, so there's no chance anybody has mapped it yet.

> ramfs_nommu_expand_for_mapping() is all about allocating memory, not
> splitting something that might already in use somewhere.
> 
> So I folio_split() on nommu is a bit weird in that context.

Well, it is, but it's also exactly what we need to do -- frees folios
which are now entirely beyond i_size.  And it's code that's also used on
MMU systems, and the more code that's shared, the better.

> When it comes to allocating memory, I would assume that it would be
> better (and faster!) to
> 
> a) allocate a frozen high-order page
> 
> b) Create the (large) folios directly on chunks of the frozen page, and
> add them through filemap_add_folio().
> 
> We'd have a function that consumes a suitable page range and turns it
> into a folio (later allocates memdesc).
> 
> c) Return all unused frozen bits to the page allocator

Right, we could do that.  But that's more code and special code in the
nommu codebase.

