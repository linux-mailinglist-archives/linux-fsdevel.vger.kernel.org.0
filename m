Return-Path: <linux-fsdevel+bounces-46233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C8EA84F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCDD9A6A97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5660205E0F;
	Thu, 10 Apr 2025 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SaitTTQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E11922C0;
	Thu, 10 Apr 2025 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322072; cv=none; b=fqtSNnum2shqcOJYljIppWso/1gqZ1fvdxR7XYmGBOmeKdtTYx/MIkya3fMemOFGlPLdME7/dVNMeiM82axOkYgtdhZz+IEsX1ChGgGJKq+CIX1BKUtZgbFuCPR/NfeC/5s9w98rGuuStAdz+gzJ7Dr5tj35311w6mV6aZ5wLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322072; c=relaxed/simple;
	bh=ahu+sTxJTXiWKP8t7Gml2qUY2sR/8/zIRmlQd4hg6Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RapZkNZVctcPaBXsLCSEqPUucAfg6Fjr6w/JGwvi59ZB2v5ttRlt0kEUvy+3l7XsruLzRX2ON7q2nwpDPFqahfzyKxODPG2uisiBw8bqTH4/c9kKNcbXz2sRuoX9JwjMDl31Wl8IWbUx3MAGXWNduf2ro/cPm6Zhb9HyK7ozDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SaitTTQh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ptq3DX6oQJpzB4WzIaKVRnwccOIqrNxFcRm9sYgBPG0=; b=SaitTTQhNXMeax3PzYnh6YILfb
	7nP2twZTWYxldHkWeB8Yl3vuroBauUQniNO5N02JPt10g00B1aUN4DnpDY1PuePFeYzCtGIm9MAnw
	3dfH1i/br9eJFfjpdEGnOm6A/Onu/q1yfWhs8snf1aWYBAV6qCBWS/c9Hv+CMKGrYtxNePk7CfV+b
	uqeiPD12YAmgPl3Oovg/Jlt4HBegJcwnyAUQkj/zAmKWiSOlQkH85CDfN2wEzjzLMKz77ocqDN3e/
	P8dt6FIH3zqoIrqhNdWQ2Vd0AHQLXtUfebACcYt9rVGdpWsHm6Met6LMF/z/+UzMl+QBnEkkN+aqU
	+aal1lSw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2zqk-00000003QUG-2tUM;
	Thu, 10 Apr 2025 21:54:19 +0000
Date: Thu, 10 Apr 2025 22:54:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
Message-ID: <Z_g-Chjk12ijqf9O@casper.infradead.org>
References: <20250410091020.119116-1-david@redhat.com>
 <67f826cbd874f_72052944e@dwillia2-xfh.jf.intel.com.notmuch>
 <Z_gotADO2ba-Qz9Z@casper.infradead.org>
 <67f82e0e234ea_720529471@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f82e0e234ea_720529471@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Apr 10, 2025 at 01:46:06PM -0700, Dan Williams wrote:
> Matthew Wilcox wrote:
> > On Thu, Apr 10, 2025 at 01:15:07PM -0700, Dan Williams wrote:
> > > For consistency and clarity what about this incremental change, to make
> > > the __split_folio_to_order() path reuse folio_reset_order(), and use
> > > typical bitfield helpers for manipulating _flags_1?
> > 
> > I dislike this intensely.  It obfuscates rather than providing clarity.
> 
> I'm used to pushing folks to use bitfield.h in driver land, but will not
> push it further here.

I think it can make sense in places.  Just not here.

> What about this hunk?
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a47682d1ab7..301ca9459122 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3404,7 +3404,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  	if (new_order)
>  		folio_set_order(folio, new_order);
>  	else
> -		ClearPageCompound(&folio->page);
> +		folio_reset_order(folio);
>  }

I think that's wrong.  We're splitting this folio into order-0 folios,
but folio_reset_order() is going to modify folio->_flags_1 which is in
the next page.

