Return-Path: <linux-fsdevel+bounces-37968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF799F9676
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2116BE53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989821A445;
	Fri, 20 Dec 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SPq/Ye5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E206219A69;
	Fri, 20 Dec 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711717; cv=none; b=jyO0zTaRDOHIC0zdsxMfA11UBSyMXWA8YDDcmZ5chZdUFUZKmsr/J0xrgYAp4r1Wkqa/zETnwDNc+fm/y14xwDGxxjmqG9Chkw+TIz3DTP3a0J7i6+gzI+ESsigYQZ/ckb9Stdyr11rPHsu/+DeMAeoE2TbswvP58QgTwfl66C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711717; c=relaxed/simple;
	bh=XfreMjG1nA0EOM57udjTVKuHhc1kECmYzfzUHcoqcoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQhPVEyI0E9qNf/T/18VBU3Bs67INQRuITdTgV/jopKW8KSyPBhRXufDUpt5SJjr4cAexO2bsZ4j9gHHotiSa+eElvzoI6+cMrdHO6adz9Ilh3XJrXxJ3pKNAVHpELhH3lTXpXw2DdZsa9yxC1T9CT72h6e60PRuICSwnhnUEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SPq/Ye5i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eOJURInQzJIIcxDvMIe9WqrFg3ERzaS/I/bGYoCc5B8=; b=SPq/Ye5iqRqLJn0qvlIbcO2L0m
	Gcbs1Oaa2yZHR2GpYUcfdgCE8dl0eNjhwlXj3YlI4b7extR3eyOB4JDEaen+27UFrmN0gTFSaFAa3
	gd4It653wAxhHe09XN2EsDmVZSAyn8hxGfB44rqy4IEASkcNu2o88FYSpaElvzeqsVXhTjlwYRLaH
	S41R2amn/7rhCeVzGtl77Sa2Oot7A2nvjmB7VitDd28Fo9EgG6e7omtZJXt8w+FUQleAsOE8m5VWC
	OjrwwsBi86zufP39dCvI8+ane7uTghITrHCrMz1qjuD+JnxSOlQCQ+FShHQDJDNy3GenfLttC8F5j
	P0Kukecw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOflA-00000001b5o-3Q2e;
	Fri, 20 Dec 2024 16:21:52 +0000
Date: Fri, 20 Dec 2024 16:21:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, kirill@shutemov.name,
	bfoster@redhat.com
Subject: Re: [PATCH 06/12] mm/truncate: add folio_unmap_invalidate() helper
Message-ID: <Z2WZoBUIM2YAr0DZ@casper.infradead.org>
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-7-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154831.1086649-7-axboe@kernel.dk>

On Fri, Dec 20, 2024 at 08:47:44AM -0700, Jens Axboe wrote:
> +int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
> +			   gfp_t gfp)
>  {
> -	if (folio->mapping != mapping)
> -		return 0;
> +	int ret;
> +
> +	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
> -	if (!filemap_release_folio(folio, GFP_KERNEL))
> +	if (folio_test_dirty(folio))
>  		return 0;
> +	if (folio_mapped(folio))
> +		unmap_mapping_folio(folio);
> +	BUG_ON(folio_mapped(folio));
> +
> +	ret = folio_launder(mapping, folio);
> +	if (ret)
> +		return ret;
> +	if (folio->mapping != mapping)
> +		return -EBUSY;

The position of this test confuses me.  Usually we want to test
folio->mapping early on, since if the folio is no longer part of this
file, we want to stop doing things to it, rather than go to the trouble
of unmapping it.  Also, why do we want to return -EBUSY in this case?
If the folio is no longer part of this file, it has been successfully
removed from this file, right?


