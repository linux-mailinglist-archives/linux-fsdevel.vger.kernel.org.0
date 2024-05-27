Return-Path: <linux-fsdevel+bounces-20284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28D48D104F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 00:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88F51F22114
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594D167D83;
	Mon, 27 May 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W46aTZnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71C101DE;
	Mon, 27 May 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849599; cv=none; b=VzXGbGv0QK95KnkzHu1We1he0zY5cD7UnF5Waql9AUDPvMmxkJ1Ttks/RMU8J87Rrcm+cZ0EZeStSyfiNfbx6yTrD5V3BxtXoN/QG6jhOXZs4JuoUpvA65b0tvvdJqwFWwM4YTancHy4hbTHn5XdHC0CX2PfLP2uDBwYGNwhXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849599; c=relaxed/simple;
	bh=xteO/duhHrr8zHBhHW3MJ26nWqqjWTZHB+o7b8pD3yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYwx3bakQ1WaI9OvVekDSVL7PFw46T/T1y7SBLdDpoZtoCOgcv86Qwea68aXBiCAqQoZ2osayR9XNtro50ywFvugUBU3ne+sDZCSSiLy5p91Ie2XhalU41ylp2BSsZALHLMltvMHBNbpBs5fJXiCdGGH4DkA3HjY7+sIDjbbZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W46aTZnF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q6QhU7sKR5QtsOX2F1+hAkRgqnFTKmnF+5KVWJ1Beow=; b=W46aTZnF2g3pObfqLgHSuvvP8f
	PTkB0Gnh8LL1d/ksibNbD3Hi+s9DlPBRI3hlMg9tKy/Rm1x2YY01pR8ccq9dM2LwSgUC2Nz5W5NzV
	qNxo7hxAo0xp2CdNbB5oGK4KAORrPQigmnSMggI+PqBhZJ+FUbNoA/Q888/qI0C3DSPOqncuURwig
	rIVwFzNzDB5aqtcu9jV6ljhjIOugfeXGgPGGBJaV4H9kuyzIpRBLUcM8RkGWZLkIxiK7G0tRViU6u
	IZraOoTgTGm8Jih2FDJPoUsipqa5hNGzUItGnyr1puajL0KNRKT+1ooOXP/K86Cee2o5xX/6HZ9DR
	0YZYgwcA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBj0N-000000083ub-32ao;
	Mon, 27 May 2024 22:39:47 +0000
Date: Mon, 27 May 2024 23:39:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, hare@suse.de,
	ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <ZlULs_hAKMmasUR8@casper.infradead.org>
References: <20240527210125.1905586-1-willy@infradead.org>
 <20240527220926.3zh2rv43w7763d2y@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527220926.3zh2rv43w7763d2y@quentin>

On Mon, May 27, 2024 at 10:09:26PM +0000, Pankaj Raghav (Samsung) wrote:
> > For this version, I fixed the TODO that the maximum folio size was not
> > being honoured.  I made some other changes too like adding const, moving
> > the location of the constants, checking CONFIG_TRANSPARENT_HUGEPAGE, and
> > dropping some of the functions which aren't needed until later patches.
> > (They can be added in the commits that need them).  Also rebased against
> > current Linus tree, so MAX_PAGECACHE_ORDER no longer needs to be moved).
> 
> Thanks for this! So I am currently running my xfstests on the new series
> I am planning to send in a day or two based on next-20240523.
> 
> I assume this patch is intended to be folded in to the next LBS series?

Right, that was why I numbered it as 5.1 so as to not preempt your v6.

> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 1ed9274a0deb..c6aaceed0de6 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -204,13 +204,18 @@ enum mapping_flags {
> >  	AS_EXITING	= 4, 	/* final truncate in progress */
> >  	/* writeback related tags are not used */
> >  	AS_NO_WRITEBACK_TAGS = 5,
> > -	AS_LARGE_FOLIO_SUPPORT = 6,
> > -	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> > -	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> > +	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
> > +	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
> >  				   folio contents */
> > -	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
> > +	AS_UNMOVABLE = 8,	/* The mapping cannot be moved, ever */
> > +	AS_FOLIO_ORDER_MIN = 16,
> > +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
> >  };
> >  
> > +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> 
> As you changed the mapping flag offset, these masks also needs to be
> changed accordingly.

That's why I did change them?


