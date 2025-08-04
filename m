Return-Path: <linux-fsdevel+bounces-56668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13D6B1A822
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF269627104
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934B28FFFB;
	Mon,  4 Aug 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0vRISbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D228FAA7;
	Mon,  4 Aug 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326027; cv=none; b=qw8qr4v5wyTZ4YabbgOxQwTWQuGbdmgaTEa0GRwlW2lOoypjKbv2/nYVEAox5mW0t4WHYq9j8k5V1sRnhAHAoxjuYhuZBlCyeJ4soKtenGEZ1tjQa4f5i+qpXSGSZUUpLh5AZ8XdyXR9/QYTX4FcR3JmZYh4jLFyygpgLuPXHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326027; c=relaxed/simple;
	bh=OKq2dTGP+5GNlAoPPGOC8X5a10FeXgFZlc9s1MF8JN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaPhgAE1FhX/lwnW8ovJ2nPhDOAKpzHL49/uUyA91NrVvdya5i5gKOIlclIRD9qU315/PIThzlfSph/32/R8DQiPxKOio14jwHJA2g2s+I43VdJt2a9l6Ul3prNpbspY7QHWKo9tOdmAJnaiQPhrN9pf3XgjaGEQ/dl31uCdI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0vRISbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A305C4CEE7;
	Mon,  4 Aug 2025 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754326026;
	bh=OKq2dTGP+5GNlAoPPGOC8X5a10FeXgFZlc9s1MF8JN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0vRISbGTuu9rB4ulTGYwp6KXekGZOa3/rZlRZeVHjZtwcpOXXCUH3y4JQlMYeNr2
	 WbnGtFY/x/m8T4cxQudyxDMz6oJZY2m2LXLiX4jGGjqKThwsEpdDV1tWmhaB+35ENX
	 zy2EYrr59Y9tFfv9zMoXwTdH5IjIvdwFSg1n2OrNpk0SGOXU3pLtMaibGaag+qAiCe
	 uqYeeJtdrO8qXpL31FrB2bioq66rxh4Zj46LM2QcyAFaXyGEbeipccDD3MEKUf7q6U
	 eCb/72TxkoNLxdKW95KfpQGlGYdV4gCEHclhr9unZKh1CI3a6XjIW9FZKvSHf64cTB
	 TU3GmoF5zXs9Q==
Date: Mon, 4 Aug 2025 10:47:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org
Subject: Re: [PATCH 2/7] block: align the bio after building it
Message-ID: <aJDkB8veXI4Znl8o@kbusch-mbp>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-3-kbusch@meta.com>
 <14c5a629-2169-4271-97b8-a1aba45a6e54@suse.de>
 <aJC-5qTTVDNjp0uk@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJC-5qTTVDNjp0uk@kbusch-mbp>

On Mon, Aug 04, 2025 at 08:08:38AM -0600, Keith Busch wrote:
> On Mon, Aug 04, 2025 at 08:54:00AM +0200, Hannes Reinecke wrote:
> > On 8/2/25 01:47, Keith Busch wrote:
> > > +static int bio_align_to_lbs(struct bio *bio, struct iov_iter *iter)
> > > +{
> > > +	struct block_device *bdev = bio->bi_bdev;
> > > +	size_t nbytes;
> > > +
> > > +	if (!bdev)
> > > +		return 0;
> > > +
> > > +	nbytes = bio->bi_iter.bi_size & (bdev_logical_block_size(bdev) - 1);
> > > +	if (!nbytes)
> > > +		return 0;
> > > +
> > > +	bio_revert(bio, nbytes);
> > > +	iov_iter_revert(iter, nbytes);
> > > +	if (!bio->bi_iter.bi_size)
> > > +		return -EFAULT;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   /**
> > >    * bio_iov_iter_get_pages - add user or kernel pages to a bio
> > >    * @bio: bio to add pages to
> > > @@ -1336,6 +1355,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> > >   		ret = __bio_iov_iter_get_pages(bio, iter);
> > >   	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
> > > +	ret = bio_align_to_lbs(bio, iter);
> > >   	return bio->bi_vcnt ? 0 : ret;
> > 
> > Wouldn't that cause the error from bio_align_to_lba() to be ignored
> > if bio->bi_vcnt is greater than 0?
> 
> That returns an error only if the alignment reduces the size to 0, so
> there would be a bug somewhere if bi_vcnt is not also 0 in that case.

But there is definitely a problem the other-way-around: if bi_vcnt is
already 0 because the first vector was a bad address, then my patch here
is mistakenly overriding 'ret' to indicate success when it wasn't.

