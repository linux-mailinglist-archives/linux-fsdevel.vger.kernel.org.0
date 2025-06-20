Return-Path: <linux-fsdevel+bounces-52340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C3FAE206A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697831C22B00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058612E8E0A;
	Fri, 20 Jun 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OnrcTh1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0918E20;
	Fri, 20 Jun 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438420; cv=none; b=DGGJnDckKuwhMoPInRDOTmf+/9OqWl2BSSsIPaB8YBaj63gv0vOl0+LQnI6IMYgs57MbuascAAlfQ3h72jiojZQM1euh2KJb0qh8crCUfN7tSJBprot92h6vXSRibOLvATAvGzH8Uzl3GUvpkzQb6RkPbICEBDf8dwO9ONCv21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438420; c=relaxed/simple;
	bh=PKeAjhz7PxdKmk2PDK/Y8/sjOSxcNLcgwyOicoy2Z84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjO/2W4ClTIS1rpJtBq6gaeZF7e0Q+vNhd/7DFg2PXcZJLAp1RNKQu6LFkBIWvYUqHi82oswPa2r6MVio1HugBG/wiBjdgbPm452tFrERf5nNCWbGCCWAC4Ac1dsctiM8N7cVxWz65ccslwU+9dLkg1C34CBenxubsjJxh01+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OnrcTh1H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Eo1XSA3SmcuMbRpTgyRtVlYknk3tdpLim2DRHohEz4=; b=OnrcTh1H3MnpfGDkkQoxf1opQy
	QjgELB6MqBVq+C0oj+tykw/OL5LNfDp2xeJgNZiFB3Q04xAMMvuDi/b9m407+tQhlW9AKFuDkx2OF
	7TbU3ZgyGj61tx/nEwMkBmVgPk/nKhlhvxtD3OAriolG9rkNl+lYExgn0RZT2mG11GcDdfJkTWLdo
	AdoPf7MrTzij29LOh1WPBF0ktWSsRITeYO+y4Ts2Xn1vd0Il3V1zeVZIhD7mR7QEzsT3qeY4krrbp
	oSYtuUzMLUIz5EYnE+R7Nbv2Wvd7MmuaSrotBF/nUgWI1mF6mxvjB89f9oqy56FuyKDy/DUj5VVhX
	iLxQfJ4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSezL-0000000D7nF-2NDn;
	Fri, 20 Jun 2025 16:53:15 +0000
Date: Fri, 20 Jun 2025 17:53:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>, seanjc@google.com, david@redhat.com,
	vbabka@suse.cz, akpm@linux-foundation.org, shuah@kernel.org,
	pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
	tabba@google.com, vannapurve@google.com, chao.gao@intel.com,
	bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com,
	jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
	jack@suse.cz, rppt@kernel.org, hch@infradead.org,
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
	roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, kent.overstreet@linux.dev,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
	dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
	jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
	aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
Message-ID: <aFWR-2WAQ283SZvg@casper.infradead.org>
References: <20250618112935.7629-4-shivankg@amd.com>
 <20250620143502.3055777-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620143502.3055777-2-willy@infradead.org>

On Fri, Jun 20, 2025 at 03:34:47PM +0100, Matthew Wilcox (Oracle) wrote:
> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
> +		pgoff_t index, fgf_t fgp_flags, gfp_t gfp,
> +		struct mempolicy *policy)
>  {
>  	struct folio *folio;
>  
> @@ -1982,7 +1984,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			err = -ENOMEM;
>  			if (order > min_order)
>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
> +			folio = filemap_alloc_folio(alloc_gfp, order, policy);
>  			if (!folio)
>  				continue;

This is missing the EXPORT_SYMBOL_GPL() change.  Sorry about that.
I'm sure you can fix it up ;-)  I only tested "make O=.build-all/ -j16
mm/ fs/" (on an allmodconfig) which doesn't get as far as making sure
that modules can still see all the symbols they need.

