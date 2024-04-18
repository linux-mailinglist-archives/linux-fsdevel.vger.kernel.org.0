Return-Path: <linux-fsdevel+bounces-17263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA98AA283
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 21:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE41C20CB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57917AD9C;
	Thu, 18 Apr 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ADrW8nHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5D17967F;
	Thu, 18 Apr 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467248; cv=none; b=iYA08sNinRV+A+i8enjLuP9KvaRa2Qf+k1zQfR9VXSnlcgeM1RiDFYXWNStUXoZcTKpzjk3hfeWfeQeqexzBTZkGKYy3c9Hmb85GyaSDzSbr2oiB9AuF7qGaybUEDblSvwPSprbAdh2uX25rLKCRV/RvX3RgEtWCVq7jJpp+1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467248; c=relaxed/simple;
	bh=7EyNpQUZN5Apzs9nqq1Wa7sd6oXGzF57OZvI5HJrXuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlluwhTpMy5P88sbZH7PrUgJ3PXbH784S/Jl7OE0UY5L8OyYGeu8rNX9LeXZ8ISV1pAVtdQpCc8B4KShSu8CeOWwjWVzwKWQT9GR56TjMRR7YZIhNxgO6tXtYOEGlv+FLJtMAEdGN9Psg0H24Fl9YClDw5ztf5mIm/KGpGP9Cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ADrW8nHg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bk48ni/EGHt3uuiKsBeEqwh1a2xXtcJeVknRmsg6nkw=; b=ADrW8nHgTy5pR9wXrNQAGsJBDT
	6dqqYR8sMVJUcBtU9LGqOR5JwzrlabDq+JddI+uRD/9dInGIx6j81YSqkgZkdMyo9D7PnCo3nKBnw
	hiEcmxLAYJwvcQTnzjjTUopo1j2HAIugm5mAWEsLsGng38bhEDh+wMR2l7ZnkbKRn/sVvsfSI4Ol3
	Eeo+y5B7xvM6AhtZDpTXFlstmFb2RDATKS/xgheIrlkKDkrPPl3hb+RnRF4WNRD7tOpK8EU88R213
	+9+NuudAQg3Un3+kDeHvr0N0Myyt1CkLKBwyzrj6t4wznILsZzmwoTR9AGNXM5HTJfqiAZ5+ykAen
	0wrUZLgw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxX6R-00000005y1I-3tsn;
	Thu, 18 Apr 2024 19:07:23 +0000
Date: Thu, 18 Apr 2024 20:07:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: Removing PG_error use from btrfs
Message-ID: <ZiFvawOnjZ7tDwPW@casper.infradead.org>
References: <ZiFbWx6o-hQ38QyZ@casper.infradead.org>
 <20240418180051.GX3492@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418180051.GX3492@twin.jikos.cz>

On Thu, Apr 18, 2024 at 08:00:51PM +0200, David Sterba wrote:
> On Thu, Apr 18, 2024 at 06:41:47PM +0100, Matthew Wilcox wrote:
> > btrfs currently uses it to indicate superblock writeback errors.
> > This proposal moves that information to a counter in the btrfs_device.
> > Maybe this isn't the best approach.  What do you think?
> 
> Tracking the number of errors in the device is a good approach.  The
> superblock write is asynchronous but it's not necessary to track the
> error in the page, we have the device structure in the end io callback.
> Also it's guaranteed that this is running only from one place so not
> even the atomics are needed.

Ah, but the completions might happen on different CPUs at the same time.
And the completion of the first write might happen while the submission
for a subsequent write are still running, and that might also adjust
the sb_wb_error value, so I think it is needed.

> I'd rather make the conversion from pages to folios a separate patch
> from the error counting change. I haven't seen anything obviously wrong
> but the superblock write is a critical action so it's a matter of
> precaution.

Understood.  I've split off three patches for folio conversion; one for
each function.

> > -		} else {
> > -			SetPageUptodate(page);
> > +			/* Ensure failure if a primary sb fails */
> > +			if (bio->bi_opf & REQ_FUA)
> > +				atomic_set(&device->sb_wb_errors, INT_MAX / 2);
> 
> This is using some magic constant so it would be better defined
> separately and documented what it means.

I was hoping that comment would be enough.  Name for the constant?
BTRFS_PRIMARY_SB_FAILED?

> Alternatively a flag can be set in the device if the primary superblock
> write fails but I think encoding that in the error count also works, as
> long as it's a named constant.

Yeah, I thought about that option too.  This seemed like the easiest way
to go.

