Return-Path: <linux-fsdevel+bounces-67429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C89C3FD97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 13:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BDC04E6113
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639F327210;
	Fri,  7 Nov 2025 12:07:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F303054F7;
	Fri,  7 Nov 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517270; cv=none; b=E6CySfJ1kMZg37ecuUR87yMFsswmuqzNL4eST6nPds9RKJNu4GNxPFqkPyKh7YVYECWbShbk0XCZqolrtjCIfO+3mBQbYnCvrX14r/61QkfShl51NBpD+LrnSkkdAJWEHdd3cTbETeJmIgR4DYsXGcQP0aezY88I63LNkxlC7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517270; c=relaxed/simple;
	bh=bUus5sZq1kwKdr0ScMiPSqnuooEEj3BwMlMsUg+clYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuHhY35wBMawrHn++b6KVEolerS3nDowY6YFEBc8JMh4jBXHZOGCCoyddEzcxXzR5Sg4gRSPJ0RVouTTCX45VNin/WXKEjq9p2quuUOwgxC25itx9QmXvl72NX2CpiSwkLFtJwU76db3/R+UHGiy4ytgJp+CazgC1UHnAVKWsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89D95227AAE; Fri,  7 Nov 2025 13:07:43 +0100 (CET)
Date: Fri, 7 Nov 2025 13:07:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/9] fscrypt: pass a real sector_t to
 fscrypt_zeroout_range_inline_crypt
Message-ID: <20251107120743.GD30551@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-5-hch@lst.de> <20251107035533.GB47797@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107035533.GB47797@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 07:55:33PM -0800, Eric Biggers wrote:
> On Fri, Oct 31, 2025 at 10:34:34AM +0100, Christoph Hellwig wrote:
> > While the pblk argument to fscrypt_zeroout_range_inline_crypt is
> > declared as a sector_t it actually is interpreted as a logical block
> > size unit, which is highly unusual.  Switch to passing the 512 byte
> > units that sector_t is defined for.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/crypto/bio.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> Looks fine, though of course fscrypt_zeroout_range() itself still takes
> a 'sector_t pblk' argument.

Yes.  The argument conventions for fscrypt are a bit odd in general.  I
actually cleaned all this up for an earlier version, but decided to keep
it minimal for this version:

https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/fscrypt-experiments

I plan to bring the ext4/fscrypt cleanups in that branch back later.


