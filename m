Return-Path: <linux-fsdevel+bounces-77643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEztHnJFlmmYdAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:04:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BFF15AC54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C733D300CA33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1833A6FE;
	Wed, 18 Feb 2026 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtQldDVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC422E7BB5;
	Wed, 18 Feb 2026 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455851; cv=none; b=UR/1hOizEVXvCwxrqW9hDSfT1pmzJam4uv7/NuUTeOE6bXK5RtDp45+UkvntqhhYYrQJN4vIVVZrP3xPQuPxAVFDr8XKnejTVQON/WiEeSoDnt57N1Xq++0gdti2urGlT29EXPlHTrSiINjzZmgRukZhhLaqkWnTT1givYj+l/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455851; c=relaxed/simple;
	bh=A4KpUH5qdtKiwpwNNT4LeI8gpC2In9JPJXbVJxd4NxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJ9hGEhbPXObwo9bkk3M11nkSRHy+D4TzpKl1g+tmZx+Mhsg7pwXG7aL1bMCkcMxt5yCSS0kEGZZnGKdoBOsg+99PsZWgP1Nk5Dut/Au9MZQbmKOySa8I5yqBAS7Y5wM0bnWhoECf7jEgMKxIIkc3OaegFZ9LSCoUhfr5PI/sXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtQldDVZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771455850; x=1802991850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A4KpUH5qdtKiwpwNNT4LeI8gpC2In9JPJXbVJxd4NxM=;
  b=MtQldDVZG9rMWGiTPkETJAFEz9w2xuTTNDgWswwnPfJisbqLGorM83u/
   WIM3QBi0TmXRLdhdz8RPBG16Csps86D1ceDJkeWs8N26QnvM1bLlg9Q6b
   Ya0e2wLO9ChGlExC2OXbV6DKNmNl/XFoh1igbd2oH1cEuzRHg/5VEtnEH
   m8oK16iuWkunlbrGqQXOY7zVK4dXhcYODU+qudgbIrBKmh0Oa6erE7LH1
   Wv1ROf5OPkImXO5m+XrC5nx4HyUXQQSZQED47qidZJfxbQUL2FF2TVa9f
   0BOGt7MbMkuM0+BUzUhkypxQzwAvB67Q5FIK9TnhO+J4irnErWjQrxSiO
   w==;
X-CSE-ConnectionGUID: 8dcusD7VRr2xUkVmjA9T4g==
X-CSE-MsgGUID: 9meo+4XoTbWG+p/MvH6GBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72444510"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72444510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:04:10 -0800
X-CSE-ConnectionGUID: RMYH7IUsQuuIdijNW4dt0w==
X-CSE-MsgGUID: j73tmhmcSbmAKux9ulhJMw==
X-ExtLoop1: 1
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.212]) ([10.125.109.212])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:04:07 -0800
Message-ID: <27ba8b1f-5674-4ccd-877a-a47b7e815cf6@intel.com>
Date: Wed, 18 Feb 2026 16:04:05 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223110.92320-1-john@jagalactic.com>
 <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77643-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 65BFF15AC54
X-Rspamd-Action: no action



On 1/18/26 3:31 PM, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> Both fs/dax.c:dax_folio_put() and drivers/dax/fsdev.c:
> fsdev_clear_folio_state() (the latter coming in the next commit after this
> one) contain nearly identical code to reset a compound DAX folio back to
> order-0 pages. Factor this out into a shared helper function.
> 
> The new dax_folio_reset_order() function:
> - Clears the folio's mapping and share count
> - Resets compound folio state via folio_reset_order()
> - Clears PageHead and compound_head for each sub-page
> - Restores the pgmap pointer for each resulting order-0 folio
> - Returns the original folio order (for callers that need to advance by
>   that many pages)
> 
> This simplifies fsdev_clear_folio_state() from ~50 lines to ~15 lines while
> maintaining the same functionality in both call sites.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  fs/dax.c | 60 +++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 289e6254aa30..7d7bbfb32c41 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -378,6 +378,45 @@ static void dax_folio_make_shared(struct folio *folio)
>  	folio->share = 1;
>  }
>  
> +/**
> + * dax_folio_reset_order - Reset a compound DAX folio to order-0 pages
> + * @folio: The folio to reset
> + *
> + * Splits a compound folio back into individual order-0 pages,
> + * clearing compound state and restoring pgmap pointers.
> + *
> + * Returns: the original folio order (0 if already order-0)
> + */
> +int dax_folio_reset_order(struct folio *folio)
> +{
> +	struct dev_pagemap *pgmap = page_pgmap(&folio->page);
> +	int order = folio_order(folio);
> +	int i;
> +
> +	folio->mapping = NULL;
> +	folio->share = 0;
> +
> +	if (!order) {
> +		folio->pgmap = pgmap;
> +		return 0;
> +	}
> +
> +	folio_reset_order(folio);
> +
> +	for (i = 0; i < (1UL << order); i++) {
> +		struct page *page = folio_page(folio, i);
> +		struct folio *f = (struct folio *)page;
> +
> +		ClearPageHead(page);
> +		clear_compound_head(page);
> +		f->mapping = NULL;
> +		f->share = 0;
> +		f->pgmap = pgmap;
> +	}
> +
> +	return order;
> +}
> +
>  static inline unsigned long dax_folio_put(struct folio *folio)
>  {
>  	unsigned long ref;
> @@ -391,28 +430,13 @@ static inline unsigned long dax_folio_put(struct folio *folio)
>  	if (ref)
>  		return ref;
>  
> -	folio->mapping = NULL;
> -	order = folio_order(folio);
> -	if (!order)
> -		return 0;
> -	folio_reset_order(folio);
> +	order = dax_folio_reset_order(folio);
>  
> +	/* Debug check: verify refcounts are zero for all sub-folios */
>  	for (i = 0; i < (1UL << order); i++) {
> -		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
>  		struct page *page = folio_page(folio, i);
> -		struct folio *new_folio = (struct folio *)page;
>  
> -		ClearPageHead(page);
> -		clear_compound_head(page);
> -
> -		new_folio->mapping = NULL;
> -		/*
> -		 * Reset pgmap which was over-written by
> -		 * prep_compound_page().
> -		 */
> -		new_folio->pgmap = pgmap;
> -		new_folio->share = 0;
> -		WARN_ON_ONCE(folio_ref_count(new_folio));
> +		WARN_ON_ONCE(folio_ref_count((struct folio *)page));
>  	}
>  
>  	return ref;


