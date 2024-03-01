Return-Path: <linux-fsdevel+bounces-13329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD086E985
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 20:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A38AB24D97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 19:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E03A8EB;
	Fri,  1 Mar 2024 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ybvg9RV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640983A1B7;
	Fri,  1 Mar 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321221; cv=none; b=JjvpeU5gpnDM8R+lQnaHmdAO6GPR1c2lDRc1j4Cl1S7M7T2miCMw2UtCvEo4RLFWDamOlOXLL0V4gOCJu8SU56mC5eZK0/T17SyDrqYIymtuHrvgVgGn8IL4RMyNtoGemyk/g4M3fc4PaNPZKW1MrSVwsCHSpTE/tVZGzUYnKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321221; c=relaxed/simple;
	bh=kaSykyFIWcgLYerUBDYqhN2sEqTha2qYZpO3zUJw2GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYci9eoOxb5v374nUeXmmd0582Y6GLpsaQyaO+feRuQ5Knyt5htLjeKFz0RJBqu1AzLitjUCPC5nKo0KLYIvDWGMSbwOAWK3ugP0TSCVFTTfAtsL0+0kK1PrFrN41XPWpTWbTyh5qX8yt0vyOOqQDZg4z/pAnVPaXxH+pjAE3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ybvg9RV0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/2k9Ny7iGQGTNen6Wn7IjRx3a2E4Jj92/u6+1Zea9no=; b=Ybvg9RV0Gde632PiFIc43hHze0
	iWF8DGBZ7TOlrbN1f5/ZIZ7wcE/sxUzP3jY8eCH/OBRd9eeCx95AC6rnwCVVc/MEOAEw4DV6kbv/x
	6eQS9KZCEL4JaE9SiTP910MCvJWfrAyb6LG9z3rlYnDqmG/fT+NqN31YVFNYyka0S8bupSuzmrvkY
	VFoNblpQDTSbUZr2+hV7Kj45r4KdPjQFEVbe7zJXGJGxCXe4OHlGYTU0Ylihekg/aQO/tcLmGNcoc
	fNdSJPtktbPi0OM11Rd7zM3vvyD3zLUXrxWhuyV0UlPZvrgBXlXLnvnFsiiOCUprp6lIjnAH6whvH
	fy3nW0Vg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg8X1-0000000BhNj-0rOA;
	Fri, 01 Mar 2024 19:26:55 +0000
Date: Fri, 1 Mar 2024 19:26:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org, mcgrof@kernel.org, linux-mm@kvack.org,
	hare@suse.de, david@fromorbit.com, akpm@linux-foundation.org,
	gost.dev@samsung.com, linux-kernel@vger.kernel.org,
	chandan.babu@oracle.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 03/13] filemap: align the index to mapping_min_order
 in the page cache
Message-ID: <ZeIr_2fiEpWLgmsv@casper.infradead.org>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
 <20240301164444.3799288-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301164444.3799288-4-kernel@pankajraghav.com>

On Fri, Mar 01, 2024 at 05:44:34PM +0100, Pankaj Raghav (Samsung) wrote:
> +#define DEFINE_READAHEAD_ALIGNED(ractl, f, r, m, i)			\
> +	struct readahead_control ractl = {				\
> +		.file = f,						\
> +		.mapping = m,						\
> +		.ra = r,						\
> +		._index = mapping_align_start_index(m, i),		\
> +	}

My point was that you didn't need to do any of this.

Look, I've tried to give constructive review, but I feel like I'm going
to have to be blunt.  There is no evidence of design or understanding
in these patches or their commit messages.  You don't have a coherent
message about "These things have to be aligned; these things can be at
arbitrary alignment".  If you have thought about it, it doesn't show.

Maybe you just need to go back over the patches and read them as a series,
but it feels like "Oh, there's a hole here, patch it; another hole here,
patch it" without thinking about what's going on and why.

I want to help, but it feels like it'd be easier to do all the work myself
at this point, and that's not good for me, and it's not good for you.

So, let's start off: Is the index in ractl aligned or not, and why do
you believe that's the right approach?  And review each of the patches
in this series with the answer to that question in mind because you are
currently inconsistent.

