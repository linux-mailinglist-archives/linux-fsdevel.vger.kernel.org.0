Return-Path: <linux-fsdevel+bounces-56646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980FB1A416
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 16:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A457AAD8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F3A26F471;
	Mon,  4 Aug 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls0/4rEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755D2BAF7;
	Mon,  4 Aug 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316522; cv=none; b=nmpXgCA2/Y4aN7AVPbd6E5v2wxO7k0ffWoQwpEOryB+ktLEDNyXig+N4JeeUNAj1bputfwLS2Eihw0eJOvWc47D6n4u7R8mXykF72U2TMJhhhq5tXWb0pwX8SpOfn6m+4rYgtCafXGOKJv4fBk7a+jqWR/FMs+fpV4KsJV8bIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316522; c=relaxed/simple;
	bh=+7Q4LotkGwU5ARZYTGNnCuBdetHLX3DRgjQvtKWhXzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvRTePtynmMSRvJRYINB8rH98KWNAsK+kXjGqOFz22kXOc8z0bbsSfNK1yyVAzKxfRtq5o1ROf37AZc6F4+69guTvwiGNxgwmJ5VG9ivAGg34b3WiNrI9l0AldV20awDSwiHKkiUUBWk7w0MmwLPjiBmVQeOooNMeLOroD9fmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls0/4rEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040E7C4CEE7;
	Mon,  4 Aug 2025 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754316521;
	bh=+7Q4LotkGwU5ARZYTGNnCuBdetHLX3DRgjQvtKWhXzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ls0/4rEzghBmvR0vP8lQ63jV9Ne2vih9EuPhtx0lfJsVSWafCSD8lowTwlYCWSWH3
	 iAJoAfO8H7B7MLKxPxBO9SG6lBdmVrr2brAy4i5atmiM+4sXCE4pzamyRou9a2izWt
	 1gKTF7IFQ6ez+NqItBxcSbZ9lFCzk/wmuHE9YRFrJcijTUag6F08uIlDle8P1fMMOU
	 +naPsw+VTvORrZ93ujPN8krJKyIL7XapyEx9868EnbA78ubsDdJDV7yrzGl/iVy7vw
	 vkNK730Ir8W4L8YtoEynIHYQD8/Glt5GvaR26s+rQB7y6vebZKiifieCcXEpd/BhVu
	 wM5VBUhVvk+fg==
Date: Mon, 4 Aug 2025 08:08:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org
Subject: Re: [PATCH 2/7] block: align the bio after building it
Message-ID: <aJC-5qTTVDNjp0uk@kbusch-mbp>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-3-kbusch@meta.com>
 <14c5a629-2169-4271-97b8-a1aba45a6e54@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c5a629-2169-4271-97b8-a1aba45a6e54@suse.de>

On Mon, Aug 04, 2025 at 08:54:00AM +0200, Hannes Reinecke wrote:
> On 8/2/25 01:47, Keith Busch wrote:
> > +static int bio_align_to_lbs(struct bio *bio, struct iov_iter *iter)
> > +{
> > +	struct block_device *bdev = bio->bi_bdev;
> > +	size_t nbytes;
> > +
> > +	if (!bdev)
> > +		return 0;
> > +
> > +	nbytes = bio->bi_iter.bi_size & (bdev_logical_block_size(bdev) - 1);
> > +	if (!nbytes)
> > +		return 0;
> > +
> > +	bio_revert(bio, nbytes);
> > +	iov_iter_revert(iter, nbytes);
> > +	if (!bio->bi_iter.bi_size)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> >   /**
> >    * bio_iov_iter_get_pages - add user or kernel pages to a bio
> >    * @bio: bio to add pages to
> > @@ -1336,6 +1355,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >   		ret = __bio_iov_iter_get_pages(bio, iter);
> >   	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
> > +	ret = bio_align_to_lbs(bio, iter);
> >   	return bio->bi_vcnt ? 0 : ret;
> 
> Wouldn't that cause the error from bio_align_to_lba() to be ignored
> if bio->bi_vcnt is greater than 0?

That returns an error only if the alignment reduces the size to 0, so
there would be a bug somewhere if bi_vcnt is not also 0 in that case.

