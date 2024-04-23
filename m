Return-Path: <linux-fsdevel+bounces-17450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1698ADC31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28951F22B0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062041BF27;
	Tue, 23 Apr 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D3DfB22s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDE1947D;
	Tue, 23 Apr 2024 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842455; cv=none; b=JVwbvwj5hTO40nYjukeCMZW508u5wtKzm95ZUZ4Pppmo4PsbUSwKosZaXyjp0sez5DM3XdMIVKQ8TV+aao63mwJwE7MpEFru4BLcZogQyL9CuR7/dvm7Rn8nFstNSK29aES7MPXouNDJFHWYuq8a6SQucZnwT3i2Z114TsjjrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842455; c=relaxed/simple;
	bh=TqFloEBDDDDjUnEYCg21M5RkfdSGJzEj109KWykFAfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+iUEM6Sm8BHzJxXOZBXmZc9A0GhSM1MSYzzLDbam4wuxJXXZVhR5lAmJ7yv7sMnuN1I9q/CTSc81jUsaof1aUXEefZDxXFzGlWhm9skzJO5pbTZoGQe5X1SvhIHT5jIPh5dovvFZ/TRHodYqOiDUPh+kw7QNrHx2znqiwKfUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D3DfB22s; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ahOv8RHRHifyUk0ox51n0lR3ydUmc3KBYtfrDe9uFDw=; b=D3DfB22sArpzZQubmTzNVyI5BY
	o6Fbriu5e2GR7x+Ia4mzcXCJrV6d15JDGKP5QKjPohvpppecxXBXG8yckT/0cxCx4didyOcyK/H5U
	hXAm/mKp+enYKfne+boHbgUOi8ygocZppO/Ucdd9U3iq/ytQfU2U0q/A6Y4jAWqLrD+CrH1kgy/HC
	ebG4gdR8hJOXNlFmVnUsxxsI0nM74398582WcAQGyDsWW9Ig2gU4rY459hqCgzmrCZU8TiCKE8ZDe
	fj5bkxdwpHxnDc4XARp1gAmCMnOK20ruCJqOZdEV0TZ9ZPQUPT4vrBikwtZHD0nX4oyh5FuLX14uj
	f+smxCLg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz6hp-0000000FVEl-2lAA;
	Tue, 23 Apr 2024 03:20:29 +0000
Date: Tue, 23 Apr 2024 04:20:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
	Kairui Song <kasong@tencent.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
Message-ID: <Zico_U_i5ZQu9a1N@casper.infradead.org>
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Mon, Apr 22, 2024 at 03:54:58PM +0800, Huang, Ying wrote:
> Is it possible to add "start_offset" support in xarray, so "index"
> will subtract "start_offset" before looking up / inserting?

We kind of have that with XA_FLAGS_ZERO_BUSY which is used for
XA_FLAGS_ALLOC1.  But that's just one bit for the entry at 0.  We could
generalise it, but then we'd have to store that somewhere and there's
no obvious good place to store it that wouldn't enlarge struct xarray,
which I'd be reluctant to do.

> Is it possible to use multiple range locks to protect one xarray to
> improve the lock scalability?  This is why we have multiple "struct
> address_space" for one swap device.  And, we may have same lock
> contention issue for large files too.

It's something I've considered.  The issue is search marks.  If we delete
an entry, we may have to walk all the way up the xarray clearing bits as
we go and I'd rather not grab a lock at each level.  There's a convenient
4 byte hole between nr_values and parent where we could put it.

Oh, another issue is that we use i_pages.xa_lock to synchronise
address_space.nrpages, so I'm not sure that a per-node lock will help.

But I'm conscious that there are workloads which show contention on
xa_lock as their limiting factor, so I'm open to ideas to improve all
these things.

