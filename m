Return-Path: <linux-fsdevel+bounces-15287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF5688BCB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A640EB228D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C6114A8B;
	Tue, 26 Mar 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hrJ58fz4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479AFBFC;
	Tue, 26 Mar 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442658; cv=none; b=BEihGjvEynqNGrnX/hmOz70YaWFfmaI+AYbXKAmxQce5cg0pnkkNN0YgwRyAwKtfsyfSqbhVL7aaKijrw+By3ila5Xythnfs/MsQ3l7V/G169WssEKpwg20ici52QTqAuzSmUa87pAyWxQJrvAZdD0CllF+Zt7Nxa3/6MQqCNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442658; c=relaxed/simple;
	bh=tm+NbvYrGarFYSyqK/ixN59aSdmFMLA9v1r7zEm/Uvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB1wvc33Q3JBECBfJpBdPJ1xuzOJBgLxHq5GRgoR3Wb3H/2EveYxJJ/D5Ocler9EXJpZ8SjHFRHpG+uVSG+lhpQo6wtVGcfujUF/AggrxKnQAtpStHoDQEYvM6RRQ1tZtuzx5BbkFRl3RmW3O3caGvinGcf5J5NY8pTdCYt/hZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hrJ58fz4; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4V3jyb1kR6z9skM;
	Tue, 26 Mar 2024 09:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711442647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgtpYMDWWZCofmZ+Xr/eXLBedWKAyq/G32SmuICtiAA=;
	b=hrJ58fz4Ue65jycC7i4YDw02447kT3KvXWoC6FTQuBcFb+4nZ6Mm0+ODTk4YLfH5jWs/NA
	ovH5FV/oJAysdNyFyv2ujSm0zy2JqICHjuhl1KzCik5tTzDQHX4lS+Rvyj7HlPOTuDTu2W
	zWwJgEl3gOBCx6IbQLhfktko0CKJYqIRrpxJoDw7/8jH21wUNMIyhPCaZaw27WKNzQreeb
	W+vufsc7/cPKw/CCfyZT/+V1vgZr1g8MAVUJL2nB/yBwQSe1bpYs+hW8zyWB0F/eGZM7Tk
	pnbl2TSyqI7tSWiGf4ODrH+OpLKpZFtnYEJRgBiNxL5MLsByk8JwxRAblu+6ng==
Date: Tue, 26 Mar 2024 09:44:02 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 02/11] fs: Allow fine-grained control of folio sizes
Message-ID: <hjkct6wz4amxzhr4ndrw7srnjepcr3kmd34kixynznhivxv5og@r7hdu4mqt3j3>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-3-kernel@pankajraghav.com>
 <ZgHCir0cpYZ4vOa0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHCir0cpYZ4vOa0@casper.infradead.org>
X-Rspamd-Queue-Id: 4V3jyb1kR6z9skM

On Mon, Mar 25, 2024 at 06:29:30PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 13, 2024 at 06:02:44PM +0100, Pankaj Raghav (Samsung) wrote:
> > +/*
> > + * mapping_set_folio_min_order() - Set the minimum folio order
> > + * @mapping: The address_space.
> > + * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
> > + *
> > + * The filesystem should call this function in its inode constructor to
> > + * indicate which base size of folio the VFS can use to cache the contents
> > + * of the file.  This should only be used if the filesystem needs special
> > + * handling of folio sizes (ie there is something the core cannot know).
> > + * Do not tune it based on, eg, i_size.
> > + *
> > + * Context: This should not be called while the inode is active as it
> > + * is non-atomic.
> > + */
> > +static inline void mapping_set_folio_min_order(struct address_space *mapping,
> > +					       unsigned int min)
> > +{
> > +	if (min > MAX_PAGECACHE_ORDER)
> > +		min = MAX_PAGECACHE_ORDER;
> > +
> > +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> > +			 (min << AS_FOLIO_ORDER_MIN) |
> > +			 (MAX_PAGECACHE_ORDER << AS_FOLIO_ORDER_MAX);
> > +}
> 
> I was surprised when I read this, which indicates it might be surprising
> for others too.  I think it at least needs a comment to say that the
> maximum will be set to the MAX_PAGECACHE_ORDER, because I was expecting
> it to set max == min.  I guess that isn't what XFS wants, but someone
> doing this to, eg, ext4 is going to have an unpleasant surprise when
> they call into block_read_full_folio() and overrun 'arr'.
> 
> I'm still not entirely convinced this wouldn't be better to do as
> mapping_set_folio_order_range() and have
> 
> static inline void mapping_set_folio_min_order(struct address_space *mapping,
> 		unsigned int min)
> {
> 	mapping_set_folio_range(mapping, min, MAX_PAGECACHE_ORDER);
> }

I agree. Having a helper like this will make it more explicit. The
limits checking can also be done in this helper itself.

Also it makes mapping_set_large_folio() more clear:

static inline void mapping_set_large_folios(struct address_space *mapping)
{
      mapping_set_folio_range(mapping, 0, MAX_PAGECACHE_ORDER);
}

instead of just calling mapping_set_folio_min_order(). Thanks.

