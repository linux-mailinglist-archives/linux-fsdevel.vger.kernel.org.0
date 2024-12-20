Return-Path: <linux-fsdevel+bounces-37974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1A9F9968
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 19:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CA17A0795
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108621D5B0;
	Fri, 20 Dec 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WEzQhONM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4921A428;
	Fri, 20 Dec 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734719084; cv=none; b=lP54zpxrX3C7SLW2UyBor0oYVA8heZ7Dz/Ehhtta93CSQxG7jWlwx+i0tapevwaT/9W5QqR9vg/4ykw/NhzPgiH2PdgUeGrgVM+qnofwf8dt/R7HECYrIIjPeFAL8P6j41D51uxTMJS7QjlRKK/r06srxFvm4U/SZvS84uPNYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734719084; c=relaxed/simple;
	bh=6Y7yGfp4vmmOcByNw5Yo9O2Ldz5CiioSApHtqZWlRfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L89sDzTftxudMcxNXqw+lQWLn9XCM9Qpp4hX3/gWICgBlUXmSC6kEKpfCHBRQruDay2Z6GsEDV1jfH+b08s30pFpSES+SFv7iYPqbdisoc23Zyir9kbKaTXpGbyRba7LLZJmeuZmlpouxoRVhhf9/CvG0LA0mFXP5MVqTaPGYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WEzQhONM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZSUgJWf89GuUNaxwrUPCTvHi/aEJ6DazxVR7uNCZBWA=; b=WEzQhONMURtrdmfJVniGyphw8M
	+Sr3IfTsoY9lZ1J+Ug9ZfyNQ6Hj0xbWOQoP3dpSW3N3KpZ1ujRcBnWnERvsnCpIPGgbiw9tTNg6kp
	M8MWfH+JKrz2GL6KJ5A0/05x2uALDhObDHm7ixVDlgzSjmb/2gTCq/9jFRzftwKeJW50ydTVA5i54
	hOjcyGrgBBgVhh9NvEIVQBJ2K+A/Nayw+dWCXxg8d/8/rdgUh9WR3VUAEVnvw2YHb32eyCHFnUWw8
	0b4/QG+56K0KP+N9GOK/DM5RpKPfUMsb12q8n21wQFKkigAg+7HG39qqh4g82B2mu7OmnSrkkW4qP
	w/AOomIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOhfz-000000024gY-1Bsb;
	Fri, 20 Dec 2024 18:24:39 +0000
Date: Fri, 20 Dec 2024 18:24:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
Message-ID: <Z2W2Z2Tq4WMNluWU@casper.infradead.org>
References: <20241216162701.57549-1-willy@infradead.org>
 <20241216162701.57549-5-willy@infradead.org>
 <ac706104-4d78-4534-8542-706f88caa4b7@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac706104-4d78-4534-8542-706f88caa4b7@squashfs.org.uk>

On Fri, Dec 20, 2024 at 06:19:35PM +0000, Phillip Lougher wrote:
> > @@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
> >   			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
> >   		struct folio *push_folio;
> >   		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
> > +		bool filled = false;

ahh, this should have been filled = true (if the folio is already
uptodate, then it has been filled).  Or maybe it'd be less confusing if
we named the bool 'uptodate'.

Would you like me to submit a fresh set of patches, or will you fix
these two bugs up?

Thanks for testing!

