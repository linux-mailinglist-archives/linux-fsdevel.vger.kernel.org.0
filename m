Return-Path: <linux-fsdevel+bounces-25686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28B94F019
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF5CB25124
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8A18455B;
	Mon, 12 Aug 2024 14:43:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB02183CA6;
	Mon, 12 Aug 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473798; cv=none; b=J+Kt0CzDstrrawXO7pNhhyB2Ml6ZELBHfjcCzd4gfX0YdsAyGkda2rqUpt5Ssc+3gUvV+dXV961XEKiy9Vu8q2DrIRCr1VQlUd0glgkpJIa+KSoeovvPkvjD4GuTc6pwPrT4v8IGzJNWlfd1Oh205UmAYN569Wkbh2yr7F/z+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473798; c=relaxed/simple;
	bh=P2cDySqP570Mm57ztlSkr+rbFtxIfMCE9kUJTZ31qq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfZA7Y8a6L5W7ZzI279EARqgbQF1Z2mzo32tNl090Dxz1SvdboetkWIR1KRbrNbEkL78c27RSx9pUM/M1A+62wvxmFLL0HJjP87rgaAqLz6Mf2ZGZAC2+HTYdddZeGGS+hc6EEiP4v3ilsgHjNlBSgntOQZMRjwlwuqClR48+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A93E3227A87; Mon, 12 Aug 2024 16:43:11 +0200 (CEST)
Date: Mon, 12 Aug 2024 16:43:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs: convert perag lookup to xarray
Message-ID: <20240812144311.GA29114@lst.de>
References: <20240812063143.3806677-1-hch@lst.de> <20240812063143.3806677-3-hch@lst.de> <ZroepUyYganq8UHJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZroepUyYganq8UHJ@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 12, 2024 at 03:39:33PM +0100, Matthew Wilcox wrote:
> > +	rcu_read_lock();
> > +	xa_for_each_marked(&mp->m_perags, index, pag, XFS_ICI_RECLAIM_TAG) {
> > +		trace_xfs_reclaim_inodes_count(pag, _THIS_IP_);
> >  		reclaimable += pag->pag_ici_reclaimable;
> > -		xfs_perag_put(pag);
> >  	}
> > +	rcu_read_unlock();
> 
> Would you rather use xas_for_each_marked() here?  O(n) rather than
> O(n.log(n)).
>
> Other than that, looks like a straightforward and correct conversion.

That probably would be more efficient, but the API feels like awkward
due to the required end argument on top of the slightly cumbersome
but not really horrible caller provided XA_STATE().

Is there any good reason why there's isn't an O(1) version that is
just as simple to use as xa_for_each_marked?

