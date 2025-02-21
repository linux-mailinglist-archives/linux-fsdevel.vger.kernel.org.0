Return-Path: <linux-fsdevel+bounces-42305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A763A40130
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873333ADE03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1CF205E31;
	Fri, 21 Feb 2025 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJB+txSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A571D7E2F;
	Fri, 21 Feb 2025 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170368; cv=none; b=Z56giF0Egro0XHIrrfimtBRQaBmUWGiIhoykDHb5QrT97YwcPjZkFAxlMbxtvYTFdg4tV5UyrBP/Kkk7TdTcS0ct8kZzBAR7jumfZ/Y19PRIw9Si4CtrDo7cA6kCTxMb+43uMuxHumPo3Cg7CKDVbDoX5SOYKJxW31bOZoGb9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170368; c=relaxed/simple;
	bh=AaAq8ScKNC8Uf0VCPH0436/Qy7v9E5DOBbn/7rwwYEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3gjGSIRJKW548sbidg7GXNC35+m4vpICybpPZhcuOR26egaXs3bYX98B6iFnATwiD7F7GOqCPF36MdmU48SJiuDwidZUd0kCZ51fimKeWS7geO08G2Oaha6UvA0MqQfRpvcQIAh1ZpdKhthYwf56IWy8mEXrCMHCSmrbWWfBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJB+txSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A91C4CED6;
	Fri, 21 Feb 2025 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740170367;
	bh=AaAq8ScKNC8Uf0VCPH0436/Qy7v9E5DOBbn/7rwwYEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJB+txStwZOOPjF/n00d8dhU+GyXoQAD+7dp35olNNHVeOnt47wVzTVoQuMXbJ2YN
	 00atFNwAuUKOGCTVvn6UOerfW/7aur8/rUOCERu0bIVPHI/1a140Nx34b2tkiZAji4
	 +vFwSP/8MnQPR4BpA84R4f9IRfFwWR6vRxtDyTk20GEzTuGQzTMqB3M94A0wbcA5/D
	 nLLGMYX5K00ZVzNiZjLCbcwj1QZEDMNV2rEH/ZK4GQeQE/CBsQZ5JRNc31Dr9FAFCs
	 xo+/DYO8Y5IEBXql++0SaRztis/tJgsKAc1iJ0c1D4cuNhE/pk8x6i2F4Iz+U/EP7g
	 zoWsASugxLc3w==
Date: Fri, 21 Feb 2025 12:39:24 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v2 4/8] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <Z7jkfD6IK5KVPrPK@bombadil.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-5-mcgrof@kernel.org>
 <Z7Ow_ib2GDobCXdP@casper.infradead.org>
 <a4ba2d82-1f42-4d70-bf66-56ef9c037cca@suse.de>
 <Z7jM8p5boAOOxz_j@bombadil.infradead.org>
 <Z7jhpdQfygJ1AAwp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7jhpdQfygJ1AAwp@casper.infradead.org>

On Fri, Feb 21, 2025 at 08:27:17PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 21, 2025 at 10:58:58AM -0800, Luis Chamberlain wrote:
> > +++ b/fs/mpage.c
> > @@ -152,6 +152,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
> >  {
> >  	struct folio *folio = args->folio;
> >  	struct inode *inode = folio->mapping->host;
> > +	const unsigned min_nrpages = mapping_min_folio_nrpages(folio->mapping);
> >  	const unsigned blkbits = inode->i_blkbits;
> >  	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
> >  	const unsigned blocksize = 1 << blkbits;
> > @@ -172,6 +173,8 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
> >  
> >  	/* MAX_BUF_PER_PAGE, for example */
> >  	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> > +	VM_BUG_ON_FOLIO(args->nr_pages < min_nrpages, folio);
> > +	VM_BUG_ON_FOLIO(!IS_ALIGNED(args->nr_pages, min_nrpages), folio);
> >  
> >  	if (args->is_readahead) {
> >  		opf |= REQ_RAHEAD;
> 
> Also, I don't think these assertions add any value; we already assert
> these things are true in other places.

Sure, it may not have been clear to others but that doesn't mean we
need to be explicit about that in code, the commit log can justify this
alone. Will remove.

  Luis

