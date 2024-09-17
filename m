Return-Path: <linux-fsdevel+bounces-29547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26897AB5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 08:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3311F22882
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 06:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AF6132139;
	Tue, 17 Sep 2024 06:20:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E225D8F0;
	Tue, 17 Sep 2024 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554014; cv=none; b=g6m2AXPyuskgyBO0tzQi+ABt/mDG8m04IeKKipgXujERGjUVOonL9x70Wu+nqstOxFVesp51nxqT3B48Z/Kp2utz58XUhCnKWFqGBvBdumneNPwgFSidzu+i4BHe68INFtl5PAF9JbDLPtPWYmLEpr3F060TfR4OqUKy+ZlnkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554014; c=relaxed/simple;
	bh=pFzT2ZqtUjl23iIZuzObb5iVFXkufhUazQnZ99FVJjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2yXDxU0UhCo5c+q0MCA8lZ+uw2XQwn4Gw1wvfYG7ISLMUrzA+/VyleIVJQak1Ojzg6exyrl4naEOGOuo+LlNYdEXivjhvwgaGcStjsTiEEIZE3x0pygsNJZuVUJvYvidnHigtS/TyMgqC7b+SyZQ8e294bwnWF1GN8Pq9tkLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C391B227ACB; Tue, 17 Sep 2024 08:20:07 +0200 (CEST)
Date: Tue, 17 Sep 2024 08:20:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240917062007.GA4170@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com> <20240913080659.GA30525@lst.de> <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 16, 2024 at 07:19:21PM +0530, Kanchan Joshi wrote:
> > Maybe part of the problem is that the API is very confusing.  A smal
> > part of that is of course that the existing temperature hints already
> > have some issues, but this seems to be taking them make it significantly
> > worse.
> 
> Can you explain what part is confusing. This is a simple API that takes 
> type/value pair. Two types (and respective values) are clearly defined 
> currently, and more can be added in future.

I though I outlined that below.

> > But if we increase this to a variable number of hints that don't have
> > any meaning (and even if that is just the rough order of the temperature
> > hints assigned to them), that doesn't really work.  We'll need an API
> > to check if these stream hints are supported and how many of them,
> > otherwise the applications can't make any sensible use of them.
> 
> - Since writes are backward compatible, nothing bad happens if the 
> passed placement-hint value is not supported. Maybe desired outcome (in 
> terms of WAF reduction) may not come but that's not a kernel problem 
> anyway. It's rather about how well application is segregating and how 
> well device is doing its job.

What do you mean with "writes are backward compatible" ?

> - Device is perfectly happy to work with numbers (0 to 256 in current 
> spec) to produce some value (i.e., WAF reduction). Any extra 
> semantics/abstraction on these numbers only adds to the work without 
> increasing that value. If any application needs that, it's free to 
> attach any meaning/semantics to these numbers.

If the device (or file system, which really needs to be in control
for actual files vs just block devices) does not support all 256
we need to reduce them to less than that.  The kernel can help with
that a bit if the streams have meanings (collapsing temperature levels
that are close), but not at all if they don't have meanings.  The
application can and thus needs to know the number of separate
streams available.


