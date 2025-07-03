Return-Path: <linux-fsdevel+bounces-53794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D02AF73E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C331C85929
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F772E7BCF;
	Thu,  3 Jul 2025 12:19:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264328D8CD;
	Thu,  3 Jul 2025 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545169; cv=none; b=pC9O9z0Q/jvLL7v4Rtn1a/Sn5ePj4vP2QUuZfcpMLK42RE8tnVjj+uyOUZtk+Oqw8MmKZ2GOCOcE+v8sNEQqPzGWeMxFAYMk/3GZl4LluIfhzFYqlnZoH1Q30LdTBmz4e3qyUYmlQgCLqF8jUTSjHikZNyKJJY1cntcUZG2Ufdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545169; c=relaxed/simple;
	bh=IctvpTvjCZ0AmNIvJgrRHYVJcl3Ssd5ljbs5s0DK1/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLuNUw3V/q3904lYI/wzVkORZW7z3wxvhka80tORXi9DdVqSmqQg+xsqCDSm/KVdpltYAcuwU2MUp8Uqo9DUwczk0B1zZpxaGEvQoRxynAsgZUdOW87lSR5O6T6W/5Q6IiSMZotmQEHSncS5rh9rUmGD6HkXNg/yr1mTDSE5DLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBB5468C4E; Thu,  3 Jul 2025 14:19:22 +0200 (CEST)
Date: Thu, 3 Jul 2025 14:19:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	hch@lst.de, miklos@szeredi.hu, brauner@kernel.org,
	anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 04/16] iomap: hide ioends from the generic writeback
 code
Message-ID: <20250703121922.GB19114@lst.de>
References: <20250624022135.832899-1-joannelkoong@gmail.com> <20250624022135.832899-5-joannelkoong@gmail.com> <20250702173819.GX10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702173819.GX10009@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 02, 2025 at 10:38:19AM -0700, Darrick J. Wong wrote:
> > -Filesystems that need to update internal bookkeeping (e.g. unwritten
> > -extent conversions) should provide a ``->submit_ioend`` function to
> > -set ``struct iomap_end::bio::bi_end_io`` to its own function.
> > -This function should call ``iomap_finish_ioends`` after finishing its
> > -own work (e.g. unwritten extent conversion).
> > -
> 
> I really wish you wouldn't delete the documentation that talks about
> what sort of things you might do in a ->writeback_submit function.
> That might be obvious to us who've been around for a long time, but I
> don't think that's so obvious to the junior programmers.

Because it's somewhere between wrong and totally arbitrary.  That whole
file is a real pain in the but because of that approach and I really
should have fought against adding it much harder.

> >  /*
> > - * Submit an ioend.
> 
> Please retain the summary.

The summary is split up into comments in the places where it makes
sense now.

> >  
> > -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> > +	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> >  new_ioend:
> > -		error = iomap_submit_ioend(wpc, 0);
> > -		if (error)
> > -			return error;
> > -		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
> > +		if (ioend) {
> > +			error = wpc->ops->writeback_submit(wpc, 0);
> 
> Should we call ioend_writeback_submit directly if
> !wpc->ops->writeback_submit, to avoid the indirect call hit for simpler
> filesystems?

No.  Compared to all the other indirect calls here it doesn't matter,
and having arbitrary defaults tends to cause problems down the road.


