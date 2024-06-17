Return-Path: <linux-fsdevel+bounces-21817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927590AE02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 14:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16847284A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4B195960;
	Mon, 17 Jun 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W96L0WwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B471940BD;
	Mon, 17 Jun 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627575; cv=none; b=ISw4L1KVntVZbTUkqm6Gv7z5/AFqlQyZYsL4YVk0Q1iVgYXJGxmjyJQHeZjQLC/XlASY3mAODDwf0QKcVuCVD6SkRalOXUGSqCUb+sk113CaO5ij1CyF8grlgRgxz96MN1C4HKnl2UrG53NKn7ygCDX5fRpm3JUKOFoERlApqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627575; c=relaxed/simple;
	bh=JrgP3nuNPPlZxwTwNTbYb+dbgkGqzU8nc9dLNwncdHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzNr61BhrVf8DRgZoXRmAWUpLjXgp/MakELan+pbSW3rzNGb8hFG0owD86tZutOHuNpZKZgA0RrrRUwTg7l159upK5ZHIRIpEVdxuVrkbpmHMEjOds/QlkbU0+rdmvNfWbs32/xbcQx/N89Ownl9MxoaqQZjLriImvYgKcEPNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W96L0WwC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q8GG92Q9B0EsVOVzS3VVMf3oPjlHCw7Vaw6WrjeC1Pw=; b=W96L0WwCEW7Lp/+PdB61gXqpg6
	ZXi7JmFiZDoF/iVT8B3Rytk4p0JLEcKF+AzY580QR1h3gvepl7odgiNXhFCiwxX1SSrmmaBr/tXwH
	xNJltFs3xvnkM3QOtqCVbLsts6aQRRwE/gKhv6p+kzAVuCehEv8nsUvJHcwPtslnkPG1qtiIitudd
	PV9w488a62geVr73R2jrY1jjKwsLGG3/CEGD0I6Lt/2FctQWpc5JQc4Pn3mLKOjjMRoOOZgMYcatY
	c3chijfe8YooXVkDy+SerDBpmaLVTYjCmp4N1hxfcE4ehu1LsyXDIPKQxwjDamfN5UlL4iM2OF6am
	nFWQVgjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJBXO-000000027Ft-3j5X;
	Mon, 17 Jun 2024 12:32:43 +0000
Date: Mon, 17 Jun 2024 13:32:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 04/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <ZnAs6lyMuHyk2wxI@casper.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
 <ZmnuCQriFLdHKHkK@casper.infradead.org>
 <20240614092602.jc5qeoxy24xj6kl7@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614092602.jc5qeoxy24xj6kl7@quentin>

On Fri, Jun 14, 2024 at 09:26:02AM +0000, Pankaj Raghav (Samsung) wrote:
> > Hm, but we don't have a reference on this folio.  So this isn't safe.
> 
> That is why I added a check for mapping after read_pages(). You are
> right, we can make it better.

That's not enoughh.

> > > +			if (mapping != folio->mapping)
> > > +				nr_pages = min_nrpages;
> > > +
> > > +			VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
> > > +			ractl->_index += nr_pages;
> > 
> > Why not just:
> > 			ractl->_index += min_nrpages;
> 
> Then we will only move min_nrpages even if the folio we found had a
> bigger order. Hannes patches (first patch) made sure we move the
> ractl->index by folio_nr_pages instead of 1 and making this change will
> defeat the purpose because without mapping order set, min_nrpages will
> be 1.

Hannes' patch is wrong.  It's not safe to call folio_nr_pages() unless
you have a reference to the folio.

> @@ -266,10 +266,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>                          * alignment constraint in the page cache.
>                          *
>                          */
> -                       if (mapping != folio->mapping)
> -                               nr_pages = min_nrpages;
> +                       nr_pages = max(folio_nr_pages(folio), (long)min_nrpages);

No.

> Now we will still move respecting the min order constraint but if we had
> a bigger folio and we do have a reference, then we move folio_nr_pages.

You don't have a reference, so it's never safe.

