Return-Path: <linux-fsdevel+bounces-15241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6779088B5B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420FCC44379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C780C0B;
	Mon, 25 Mar 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L+oSZr1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683F6D1AB;
	Mon, 25 Mar 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391377; cv=none; b=P0EKkHIwVNRndj+S2v5NmaY4Co16LTX+E6/RF0aSrV+xPmerQS2Wf2lK5GrXQZWIHPAi0yaJNSQzFPpLogETfH4qBdad639Q7tB2uKmQfBKgLAyPsE3iy4iyi7JO9YQhIZrwXPAwqlLZ2A1EnhTzDNxSrGwIRo2plDUgwO0A9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391377; c=relaxed/simple;
	bh=K/SjS/Ljp1g6r6uZTI8orehVb3wXjEfbSTdQkvL2kQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8LcYLpLcojr7AfHwsH78IaD3teASDRr0r7JterpGheCq/Fn/x7n323m/vZJ52Ns4zGraTVUOBqBtvQJkgyMF3QddE1xK+8TxRUk7gIhl/5BpfMkLpzmXZmqDVFxD2pRQH+9TbHo6h+os1sjjyMBKOHaSvjCIGOcOycM5+Y/zzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L+oSZr1p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l7E+1tHSH1IK7nuvUWxZFmjLoD4xOjRNO5sUR9Pf950=; b=L+oSZr1p6P6iD4v9M1lW/38dNk
	Ft19z4dLHo93OI83W6Hgo3RAW15U3QhbxG3VyadGiznwBIGAY4TjdOwq+aPoX+3Fecco2txGtp1Su
	qgnJh3kKWPEhtdPJh4//lCAMCjkyUSld5107p+z5YtIr2IKtoqFtuyvaZ5HD6rEX7DEVZLFRA9O6s
	Smu8CzAiKWQSPkPaTKPaqb91AYA//j7a0spNwTYaPbDmbjS+Af/Qmh6bWprRjTwyCm2IJrd58XZvD
	pkwXKpdDrrI32fsQT82yh9nrnkCtWeUtF8PVmvznqQsw4f7q5kezGw9rAkJcxyTcjLcuxbpOA9aoJ
	4lrqKMSg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rop4c-0000000H3yU-33W8;
	Mon, 25 Mar 2024 18:29:30 +0000
Date: Mon, 25 Mar 2024 18:29:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de,
	mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 02/11] fs: Allow fine-grained control of folio sizes
Message-ID: <ZgHCir0cpYZ4vOa0@casper.infradead.org>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313170253.2324812-3-kernel@pankajraghav.com>

On Wed, Mar 13, 2024 at 06:02:44PM +0100, Pankaj Raghav (Samsung) wrote:
> +/*
> + * mapping_set_folio_min_order() - Set the minimum folio order
> + * @mapping: The address_space.
> + * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
> + *
> + * The filesystem should call this function in its inode constructor to
> + * indicate which base size of folio the VFS can use to cache the contents
> + * of the file.  This should only be used if the filesystem needs special
> + * handling of folio sizes (ie there is something the core cannot know).
> + * Do not tune it based on, eg, i_size.
> + *
> + * Context: This should not be called while the inode is active as it
> + * is non-atomic.
> + */
> +static inline void mapping_set_folio_min_order(struct address_space *mapping,
> +					       unsigned int min)
> +{
> +	if (min > MAX_PAGECACHE_ORDER)
> +		min = MAX_PAGECACHE_ORDER;
> +
> +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> +			 (min << AS_FOLIO_ORDER_MIN) |
> +			 (MAX_PAGECACHE_ORDER << AS_FOLIO_ORDER_MAX);
> +}

I was surprised when I read this, which indicates it might be surprising
for others too.  I think it at least needs a comment to say that the
maximum will be set to the MAX_PAGECACHE_ORDER, because I was expecting
it to set max == min.  I guess that isn't what XFS wants, but someone
doing this to, eg, ext4 is going to have an unpleasant surprise when
they call into block_read_full_folio() and overrun 'arr'.

I'm still not entirely convinced this wouldn't be better to do as
mapping_set_folio_order_range() and have

static inline void mapping_set_folio_min_order(struct address_space *mapping,
		unsigned int min)
{
	mapping_set_folio_range(mapping, min, MAX_PAGECACHE_ORDER);
}


