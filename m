Return-Path: <linux-fsdevel+bounces-25027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71654947E8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 17:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE821F233E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D07815B0EE;
	Mon,  5 Aug 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLaS7P/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAA3CF5E;
	Mon,  5 Aug 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872915; cv=none; b=RHkS9gX2etRvu7fBXW+hJrN//q/A1gHcRj/BhQCB35tcMEj4JM+vW9AF6EJANrjXyRHBgVzrKttquzpn/57P4pmzFU/KF+9LMRS2QcDJZUboZaorkWLbE2RPL8zbkin5AssfQiyBUn8MVIcSMY7LATY+1aRVK+OzDMo+Ely2uiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872915; c=relaxed/simple;
	bh=Uv9QzwIMt6yW4nBXXpqHFK2rlCMOe0OowQLqaBc/9Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA418EHyg2ZTho8ZjAbvBIteIxONSTxDfQ/brpfd2Dosphcu/X757S9O7PnK/vgEtApMthOu1iNtgNMqma+fynQMzCd8SXklUbEseVGz9jjpXNmWEx2iXQ2+3RnY8lFiZkwfcOdH5E6GCr2XoVHBLUQ1HdouXTIV754Lc5ZUaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YLaS7P/J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jop/9x9H74hNHpnKVy1TkUC3RQJ767iFMVyahJvX3D0=; b=YLaS7P/JiJPZGL7DnXiOXovLrF
	c4PXj28tW3SRC0RGKXU7Gx2sXhLo6II75/dA186L6QAwk32nuuUUsxPcUV9mnaFpqPityaNyDaj5C
	YAV45bR8vTOEvQEJnp06l1qPChJlg6h8bE5KEfdTY1lLZ9Kx3Q+Sn6lVa3JWU5Xr8Tiz0A0HKRWzT
	S6GGekWPJPtnUM1w3q8JvfrGgsix8CPTjkahkD68w+q8MPe2EVbrDRDm48v7HJXodbnfJA7ffJkIG
	LfXSlDkyjQ5YIqsiXzCgxlAhj3djfOA6I4IqrJ7vOEEuB+euTJsXdm38gRktdlevDkLxhyzQ7FQAt
	9iUkkvJw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sazwi-00000004PrX-43q3;
	Mon, 05 Aug 2024 15:48:29 +0000
Date: Mon, 5 Aug 2024 16:48:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, Dave Chinner <david@fromorbit.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
Message-ID: <ZrD0TKDHWhwiEoz_@casper.infradead.org>
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
 <Zqwi48H74g2EX56c@dread.disaster.area>
 <b40a510d-37b3-da50-79db-d56ebd870bf0@huaweicloud.com>
 <Zqx824ty5yvwdvXO@dread.disaster.area>
 <1b99e874-e9df-0b06-c856-edb94eca16dc@huaweicloud.com>
 <20240805124252.nco2rblmgf6x7z4s@quack3>
 <20240805140023.inte2rxlhumkfvrh@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805140023.inte2rxlhumkfvrh@quack3>

On Mon, Aug 05, 2024 at 04:00:23PM +0200, Jan Kara wrote:
> Actually add Matthew to CC ;)

It's OK, I was reading.

FWIW, I agree with Dave; the locking complexity in this patch was
horrendous.  I was going to get to the same critique he had, but I first
wanted to understand what the thought process was.

> > > Ha, right, I missed the comments of this function, it means that there are
> > > some special callers that hold table lock instead of folio lock, is it
> > > pte_alloc_map_lock?
> > > 
> > > I checked all the filesystem related callers and didn't find any real
> > > caller that mark folio dirty without holding folio lock and that could
> > > affect current filesystems which are using iomap framework, it's just
> > > a potential possibility in the future, am I right?

Filesystems are normally quite capable of taking the folio lock to
prevent truncation.  It's the MM code that needs the "or holding the
page table lock" get-out clause.  I forget exactly which callers it
is; I worked through them a few times.  It's not hard to put a
WARN_ON_RATELIMIT() into folio_mark_dirty() and get a good sampling.

There's also a "or holding a buffer_head locked" get-out clause that
I'm not sure is documented anywhere, but obviously that doesn't apply
to the iomap code.

> > There used to be quite a few places doing that. Now that I've checked all
> > places I was aware of got actually converted to call folio_mark_dirty() under
> > a folio lock (in particular all the cases happening on IO completion, folio
> > unmap etc.). Matthew, are you aware of any place where folio_mark_dirty()
> > would be called for regular file page cache (block device page cache is in a
> > different situation obviously) without folio lock held?

Yes, the MM code definitely applies to regular files as well as block
devices.

