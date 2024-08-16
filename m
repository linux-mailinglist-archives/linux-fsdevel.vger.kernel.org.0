Return-Path: <linux-fsdevel+bounces-26093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0FA95401A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 05:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EC0B233F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 03:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A66E619;
	Fri, 16 Aug 2024 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OjwPN/33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086343EA64
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723779783; cv=none; b=OZ6miiy054DRHNhVemZg4TsXXFNCeSOgKcYPzeubP07f0UdpLq+pU+KkRbwgH8vCXcNBTmxCjCcJPXqZUoJKdxB5u7HpvNLJa6NNuS3BUMckPWH7vaSn3ByVh0ZbyUMrWWeG3Ia/b8eS1FzR5GVnR/9SBYcID7K5MSPaBd4jyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723779783; c=relaxed/simple;
	bh=JSeDhEpkVt7iOYFJaP+u0d3dSiwws2Pele+BVd4AgQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koAifUkuDsBZTTQL3LViC7hKpCsQKh5vzNJFWVPwNZFiO80YUL80U8jypCsgOS3/TzeX5MPwO/h10VKScSk5JbfhzMyE0ylb7Au0Ci979tvqkx3PbUy8LGa4zLL4v4C/CZgRDSh8SP5GauUrdpzNrPUfmYFRItFynFKucDBooog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OjwPN/33; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AUsOavIE8dxCHAG65JW9tarGXEp0lmQXHgPOb8+iEwg=; b=OjwPN/335UEp/RsJH48FT+j1FJ
	y24YeEN50R09pRYv4Y8+6uST73J1AUH0KJf4fXsi72fPIaElTZaY4v7dUGEmQCm2Wp+QPoAqY9pQB
	4Efi79WM9NNLAJfFwBeCUiavcHZO3LPFjPDwMX4fXtxjLwBT2L7xWnyw5I98jmXzBaVGqg7JLi9ok
	q7FhiBlMLZqcwK0ZYqsQGLx/UvZtiQxE4drwZDuXs2V82NqUFkE+sJYYVtS/Nkw78mJaiEvPdLuN0
	LtHQ4WtHW/Wl41PzTnKPtXE9i+5pDYE41O4CQ9DDdXSfxE5OCnOPm9u8M+N1j5qZH5/Q5lCUak4D5
	xCpzJF5A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1senrb-00000002xhn-0v9J;
	Fri, 16 Aug 2024 03:42:55 +0000
Date: Fri, 16 Aug 2024 04:42:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] Merge PG_private_2 and PG_mappedtodisk
Message-ID: <Zr7Kv0nR4_z9XaXx@casper.infradead.org>
References: <ZrzrIEDcJRFHOTNh@casper.infradead.org>
 <7e7ee391-6f4d-4d36-ace5-4f8ca81479bc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e7ee391-6f4d-4d36-ace5-4f8ca81479bc@redhat.com>

On Thu, Aug 15, 2024 at 11:41:23PM +0200, David Hildenbrand wrote:
> On 14.08.24 19:36, Matthew Wilcox wrote:
> > I believe these two flags have entirely disjoint uses and there will
> > be no confusion in amalgamating them.
> > 
> > Anonymous memory (re)uses mappedtodisk for anon_exclusive.
> > Anonymous memory does not use PG_private_2.
> 
> Also not when they are in the swapcache, right?

Correct, swapcache has no use of PG_private_2.

> > The one thing that's going to stand in the way of this is that various
> > parts of the VFS treat private_2 as a "wait for this bit to be clear",
> > due to its use in fscache (which is going away).
> > 
> > So my approach here is going to be:
> > 
> >   - Rename mappedtodisk to be PG_owner_priv_2 (add appropriate aliases)
> >   - Switch btrfs to use owner_priv_2 instead of private_2
> >   - Wait for the fscache use of private2 to finish its deprecation cycle
> >   - Remove private_2 entirely
> > 
> > Sound good?
> 
> Yes, one step into the right direction.

Cool, thanks.

