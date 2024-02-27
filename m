Return-Path: <linux-fsdevel+bounces-12924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEEB868B10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10C9B23DC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B50130E27;
	Tue, 27 Feb 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vhUfu7Uk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07987E761;
	Tue, 27 Feb 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023496; cv=none; b=eHfPCoHJTsexPDx1UVGSpRMxMKW1qVRFI/WTrAHZPJ0nd4kytGyfO/lNze+1LT/ZNXpkHp2I5mHU3m9hIyFMzg+e+NjcMYWqqXDneoNo6p7tEMt2CzLSii3lLnn5L+/mzwKuSVqQxkX2LPfl++kjkam6oQqPK/QEn2ECDxsXvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023496; c=relaxed/simple;
	bh=F6Dw1yhuXSn9tDcHzMLVsOx+fa7VDnyjl31zCJLzb7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoHJqNXk7EYHVbCnTFQI5N+7PCsm1h7a7z0BTKFxPuEIVjsLquxVUs0dhN+fxL0OOCm7fgbuj7JRYaoN7q2je+dojuH0tDjn1EI7+goVXGMWMzzFbEfXaPhF65zh9uYTKHzNLcbwh+p6CvqDpPBrcKFQHPMvcZIxSgZD9MZkgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vhUfu7Uk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TkWJL6wn2z9t0M;
	Tue, 27 Feb 2024 09:44:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709023491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28mM1L7VoPpQ2Bxti5OxSfSjhM5DSY0iAhB3xAG9DsE=;
	b=vhUfu7Ukkzc0sJ3NR4BGYejf5reNNcHuMppL3CH2U9H7P/14zED8PWIe58sugXnGExZkI8
	yWE9fwlD0rlXjqEW4HgHb1ItUC84CCTD2HKudIo/vn1WQs2xO4gDIQVTcUXPpW4nwpdQY6
	RiKmh/OvoFKM7M0FnU/Nyw4HAGNa4lHRCiDRD4mRBdQNNRCNX1q2B0vaSi8nehFSqKLoWr
	kScyJxMdKaa0STuFn5cqUJDhIdUsjXjV2q/qDojeo8kXV6/WwDgUc7JXWz4FlO2bAQWBHe
	BFikc0eFXVid62NyhvTPH4xx3QiyPOSeWygvw5gXSH9O8iqdS9vtJ4DH/jzjUA==
Date: Tue, 27 Feb 2024 09:44:46 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david@fromorbit.com, chandan.babu@oracle.com, 
	akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, 
	djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 12/13] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <uw6wet56alvrcj6erv3fwn3hqjsyijhk4ke7f54yowt3mzkreh@hiov5ttykytu>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-13-kernel@pankajraghav.com>
 <ZdyQdGkSIw9OsSqc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdyQdGkSIw9OsSqc@casper.infradead.org>
X-Rspamd-Queue-Id: 4TkWJL6wn2z9t0M

On Mon, Feb 26, 2024 at 01:21:56PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 26, 2024 at 10:49:35AM +0100, Pankaj Raghav (Samsung) wrote:
> > +	if (check_mul_overflow(nblocks, (1 << sbp->sb_blocklog), &bytes))
> 
> Why would you not use check_shl_overflow()?

This looks better than check_mul_overflow. I will use this in the next
version.
> 
> > +		return -EFBIG;
> > +
> > +	mapping_count = bytes >> PAGE_SHIFT;
> >  	/* Limited by ULONG_MAX of page cache index */
> > -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> > +	if (mapping_count > ULONG_MAX)
> >  		return -EFBIG;
> >  	return 0;
> >  }
> > -- 
> > 2.43.0
> > 

