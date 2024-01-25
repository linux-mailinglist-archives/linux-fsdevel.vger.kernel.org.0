Return-Path: <linux-fsdevel+bounces-9007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2734583CDC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7001C24118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837E31386B6;
	Thu, 25 Jan 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N6o2AsrF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A9135416;
	Thu, 25 Jan 2024 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215671; cv=none; b=QG9zigUpoRqey5O04H5sLHa7BoPZFMuZxcaJ31cRcGDts5GwZcwXfuzyd/7A19tOjFe0D1aWjcPsNBJNzdFF5yimqhRUg2L6L0jbNvUMeI87Jv3kRix1SHmKPmodd0CQrz9jy0tBHfTWVm58IGGuJHwhjdVfrn4hOTBh40TUXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215671; c=relaxed/simple;
	bh=56c8o/PnnsFZL82o5Qr1kNlTvUosM/c1XaHFOGIRpPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smQO3FD5vW83sjpvDUJmAwI7oJPCsx6Ul120n7sSriXqVOy7ejPqeENZW51A99PuAoQx65YWIDD+ojNwE4VKLBgF1qGhwxNdMbaOhhyAz5FL9s477CFHYK2ydaoJNjgiE3UF0WIEiZ5lmI5hLwOC9DtbjfUdIZnUU0Hz96oJDEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N6o2AsrF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BBqOb/ZqrKdawgvhDpAKr22AD6q4pmmVnTFBoWIGiU8=; b=N6o2AsrFBnAxGhkLunHLObyk6I
	e4zIFiWfoXqIX1uGE4X5PvacBk28dmC5837lBiaHc/0AwORUO7ROgg+Nl8jhP+maRD+1utRm1Bh87
	oEL1gHoCpSocSeYW41GJz3OCLXYq1nTa7wVQqyohz3CxubRixhcW07tzQGKL/q3eQ+HANlwcc+W3Q
	Im+GTbC7oygnNpQRb7DI/08r6ASMkp1NGYRXZUA6iBam2ELid26Sve4ryqWxQBBMSdKIbjI+VGP0t
	Bdt8FM3sEOJrJdcoFkIeGXjiHxvruvxzYaK90OD1m4gPm/RJuL6zdClJzEDiEWxpRaVf/KfMY3YtY
	qnxp6K/g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT6dP-0000000B791-1vmr;
	Thu, 25 Jan 2024 20:47:39 +0000
Date: Thu, 25 Jan 2024 20:47:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, fengnanchang@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	vishal.moola@gmail.com,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH] f2fs: Support enhanced hot/cold data separation for f2fs
Message-ID: <ZbLI63UHBErD6_L2@casper.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
 <Y4d0UReDb+EmUJOz@casper.infradead.org>
 <Y5D8wYGpp/95ShTV@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5D8wYGpp/95ShTV@bombadil.infradead.org>

On Wed, Dec 07, 2022 at 12:51:13PM -0800, Luis Chamberlain wrote:
> On Wed, Nov 30, 2022 at 03:18:41PM +0000, Matthew Wilcox wrote:
> > From a filesystem point of view, you need to ensure that you handle folios
> > larger than PAGE_SIZE correctly.  The easiest way is to spread the use
> > of folios throughout the filesystem.  For example, today the first thing
> > we do in f2fs_read_data_folio() is convert the folio back into a page.
> > That works because f2fs hasn't told the kernel that it supports large
> > folios, so the VFS won't create large folios for it.
> > 
> > It's a lot of subtle things.  Here's an obvious one:
> >                         zero_user_segment(page, 0, PAGE_SIZE);
> > There's a folio equivalent that will zero an entire folio.
> > 
> > But then there is code which assumes the number of blocks per page (maybe
> > not in f2fs?) and so on.  Every filesystem will have its own challenges.
> > 
> > One way to approach this is to just enable large folios (see commit
> > 6795801366da or 8549a26308f9) and see what breaks when you run xfstests
> > over it.  Probably quite a lot!
> 
> Me and Pankaj are very interested in helping on this front. And so we'll
> start to organize and talk every week about this to see what is missing.
> First order of business however will be testing so we'll have to
> establish a public baseline to ensure we don't regress. For this we intend
> on using kdevops so that'll be done first.
> 
> If folks have patches they want to test in consideration for folio /
> iomap enhancements feel free to Cc us :)
> 
> After we establish a baseline we can move forward with taking on tasks
> which will help with this conversion.

So ... it's been a year.  How is this project coming along?  There
weren't a lot of commits to f2fs in 2023 that were folio related.

