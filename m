Return-Path: <linux-fsdevel+bounces-42299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2641A400D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A89701DAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC2253B5D;
	Fri, 21 Feb 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTk40ATd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A2253331;
	Fri, 21 Feb 2025 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169644; cv=none; b=H3mnpsagSUQR2jDV5zKX/lZ6c0eWg8CO5W0CeB7YDWmXeWoowCOK3sjri0PwEq2h1UqVxE8D8DMvLlVTkNmLBrJTSWztgnFMrk6dc6qbcH2ZNx4r/dU5ZtpBz8mTuZ8d0q0bZGh1d0ZTi6GjkU9ZXXeChzi3tCtNrXrBppmf+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169644; c=relaxed/simple;
	bh=YJ+Q7JeyAPb3xnnizZXZ5b+bToHyaWbbPsU74D2oU5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzu8gv17WD9qJGCb+tHw6ei/vUdbsQYl5Gn+62PGhv45HY+0yxBIBibhoyxnrAK5hUoO7eDurAXaWWAv17YD/wNknc0XX53hAMWRL1pfr91TkBt+miPfVlA18ogbctV0hiBb74PH/G1opPS9wanzF0loqdYRQh1j4dMVQioDBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nTk40ATd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lz2vU2dsUdlOV7Xg0859QGB32mS/prta9dYKuupqdpU=; b=nTk40ATdl4bFKKJ47xSJpFqrda
	YnBx7ynyElatAbZVExdqFV2wIMTPwpxxMIStgQlwfSNDZ0Qzvu+N5dOrr9FxQXfVCmeVJ5hdeZGOx
	lmBFM3W3iNwr/PxCK0nHYVaiFVqpeH5zkLXOtjErAgASLmpkNPWNFyHFa+RYUaW9y0EFEY/pb2kVK
	nzU/HBXDDfua2lRcsZIUrgJ9qa1TdmbRvCD0UPKW0xUQavfZTMXBgShNmLQAg34jutsjb9nLmWCsu
	6yYmX4FNuDJl78svXJfiots27qTgz0Vzee5X5I5ktXKIzNc9z14QS/24FIxjeQnXiwqSmxN43c7U5
	TxbV+glQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlZcD-0000000F2bY-3NN0;
	Fri, 21 Feb 2025 20:27:17 +0000
Date: Fri, 21 Feb 2025 20:27:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v2 4/8] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <Z7jhpdQfygJ1AAwp@casper.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-5-mcgrof@kernel.org>
 <Z7Ow_ib2GDobCXdP@casper.infradead.org>
 <a4ba2d82-1f42-4d70-bf66-56ef9c037cca@suse.de>
 <Z7jM8p5boAOOxz_j@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7jM8p5boAOOxz_j@bombadil.infradead.org>

On Fri, Feb 21, 2025 at 10:58:58AM -0800, Luis Chamberlain wrote:
> +++ b/fs/mpage.c
> @@ -152,6 +152,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  {
>  	struct folio *folio = args->folio;
>  	struct inode *inode = folio->mapping->host;
> +	const unsigned min_nrpages = mapping_min_folio_nrpages(folio->mapping);
>  	const unsigned blkbits = inode->i_blkbits;
>  	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
>  	const unsigned blocksize = 1 << blkbits;
> @@ -172,6 +173,8 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  
>  	/* MAX_BUF_PER_PAGE, for example */
>  	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> +	VM_BUG_ON_FOLIO(args->nr_pages < min_nrpages, folio);
> +	VM_BUG_ON_FOLIO(!IS_ALIGNED(args->nr_pages, min_nrpages), folio);
>  
>  	if (args->is_readahead) {
>  		opf |= REQ_RAHEAD;

Also, I don't think these assertions add any value; we already assert
these things are true in other places.


