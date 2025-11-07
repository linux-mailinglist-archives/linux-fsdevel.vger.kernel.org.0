Return-Path: <linux-fsdevel+bounces-67426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA2C3FD67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FB63AFDFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD543271E7;
	Fri,  7 Nov 2025 12:02:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABA324B3C;
	Fri,  7 Nov 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516977; cv=none; b=IGbBVsYQt/jJqhaN0D1OXMdkQm2QAovOpANWbHvwSY9dRMHUCzF/IsGf7t3cFSG/PLYivAVnaAO/9yq3UkVqymryXBm70FuB/rR4GRxb2XbvLMlZf0Y6WIsFMpZvhnZ2h3nGlJYLCcIjp7so8RFPh8fjkl+lI8qvrd5+qVAVylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516977; c=relaxed/simple;
	bh=va2jq3+NYVYMfmnOUBovKBnEvhVInuQzxr2I6om00hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOhOttKQmwCKFEIR7ahAfIjr4uPt7nK33rk0Zvdav6/lF4iiEFprttf8wP7ZpTRrpXf8m8VeSCBec5NRp7oQPSBwH+E5BmeVMJpj2H5SyyLmltXjMfYMsLgHUJ01bYMzqVwPQUC+iEXv1EkhtVr1kcvRcQF/o3c1LG6E65cOpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A5877227AAF; Fri,  7 Nov 2025 13:02:49 +0100 (CET)
Date: Fri, 7 Nov 2025 13:02:48 +0100
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
Subject: Re: [PATCH 1/9] mempool: update kerneldoc comments
Message-ID: <20251107120248.GA30551@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-2-hch@lst.de> <20251107032648.GA16450@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107032648.GA16450@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 07:26:48PM -0800, Eric Biggers wrote:
> > - * *never* fails when called from process contexts. (it might
> > - * fail if called from an IRQ context.)
> > - * Note: using __GFP_ZERO is not supported.
> > + * Note: This function only sleeps if the alloc_fn callback sleeps or returns
> > + * %NULL.  Using __GFP_ZERO is not supported.
> 
> Maybe put the note about __GFP_ZERO being unsupported directly in the
> description of @gfp_mask.

I'll give it a try.

> >   *
> > - * Return: pointer to the allocated element or %NULL on error.
> > + * Return: pointer to the allocated element or %NULL on error. This function
> > + * never returns %NULL when @gfp_mask allows sleeping.
> 
> Is "allows sleeping" exactly the same as "__GFP_DIRECT_RECLAIM is set"?

Yes.

> The latter is what the code actually checks for.

I'll see if I can make that more clear.


