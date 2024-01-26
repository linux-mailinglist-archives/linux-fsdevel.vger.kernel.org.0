Return-Path: <linux-fsdevel+bounces-9110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F1083E3FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD701F24335
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA124A1B;
	Fri, 26 Jan 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGYM24Fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6510286A6;
	Fri, 26 Jan 2024 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304732; cv=none; b=BukZpZvgGcU8HFeECOw2qey5MtOq3oS0PJ5gDR3E1ssC0bkxAQE8UZvmso1MwfDxKaqj4CqcqIm3OEXpvUhFEYOmfYUo58fFZyuAb5uZ9SCa2ciHqex6QH9kTisybVNGINVIvW5kS/d18YdELE/aWn0f98pBemkz7xcXP2+po7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304732; c=relaxed/simple;
	bh=jsc/69WSzTKZ/G5310wlLrX/CRAN2B+7XXtyP6eyFKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD6twj19Pj4yXIPuVLaMRvaG74r3K7WJRLstGHQnpkJFDtXxTfDtREF/ewq+dooyp1UzPktjshrYMzZljal8fOt53oLErQISe+0kNQ34jdgHyoIRjFbOoucnBlAMCggPsn3TEPsMg7ZpdsVaiDr0UF8dmaPWc4zIBE4sdusQmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FGYM24Fn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wP2xVl8JLp8XOMebTnhcra6qLaj2U02CkDsznEmwziE=; b=FGYM24Fn+Iz/x4NlIX2hTy5y5U
	H0auvnkk5HhfbmBVyRp0C+FfOq4dPgI3F5Os6p1JDSkEKZrwwSLQkEVQXY1WVKNQ8krGfhCMj9sH3
	4eFvZ0/ZWQdg5jN0WKLY5t+OKTIFjMccd5933cX34wXREJP4KlaQx52Z3V9O+o4+Zygcvrl2AR1ct
	w4ZVz+F0dqIfJr3agbnE3KOp2Wm5Xq59t+zGVbOqkEDG9NqcW7dbLSamFoppg5LohKRfi2WqYlFmu
	tlYDHsGuZGfead2WwW/Op4vijp23jPraeuT6Hp6WE70EeIJB1cbeGCzSp1oWy8ViUw83uOSURLb2V
	Z95d7Dtg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTTnx-00000005TLG-3VbV;
	Fri, 26 Jan 2024 21:32:05 +0000
Date: Fri, 26 Jan 2024 13:32:05 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@google.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, fengnanchang@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	vishal.moola@gmail.com,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH] f2fs: Support enhanced hot/cold data separation for f2fs
Message-ID: <ZbQk1WqGgwgoMbg3@bombadil.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
 <Y4d0UReDb+EmUJOz@casper.infradead.org>
 <Y5D8wYGpp/95ShTV@bombadil.infradead.org>
 <ZbLI63UHBErD6_L2@casper.infradead.org>
 <ZbLKl25vxw0eTzGE@bombadil.infradead.org>
 <ZbQdkiwEs8o4h807@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQdkiwEs8o4h807@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Jan 26, 2024 at 09:01:06PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 25, 2024 at 12:54:47PM -0800, Luis Chamberlain wrote:
> > On Thu, Jan 25, 2024 at 08:47:39PM +0000, Matthew Wilcox wrote:
> > > On Wed, Dec 07, 2022 at 12:51:13PM -0800, Luis Chamberlain wrote:
> > > > Me and Pankaj are very interested in helping on this front. And so we'll
> > > > start to organize and talk every week about this to see what is missing.
> > > > First order of business however will be testing so we'll have to
> > > > establish a public baseline to ensure we don't regress. For this we intend
> > > > on using kdevops so that'll be done first.
> > > > 
> > > > If folks have patches they want to test in consideration for folio /
> > > > iomap enhancements feel free to Cc us :)
> > > > 
> > > > After we establish a baseline we can move forward with taking on tasks
> > > > which will help with this conversion.
> > > 
> > > So ... it's been a year.  How is this project coming along?  There
> > > weren't a lot of commits to f2fs in 2023 that were folio related.
> > 
> > The review at LSFMM revealed iomap based filesystems were the priority
> > and so that has been the priority. Once we tackle that and get XFS
> > support we can revisit which next fs to help out with. Testing has been
> > a *huge* part of our endeavor, and naturally getting XFS patches up to
> > what is required has just taken a bit more time. But you can expect
> > patches for that within a month or so.
> 
> Is anyone working on the iomap conversion for f2fs?

It already has been done for direct IO by Eric as per commit a1e09b03e6f5
("f2fs: use iomap for direct I/O"), not clear to me if anyone is working
on buffered-io. Then f2fs_commit_super() seems to be the last buffer-head
user, and its not clear what the replacement could be yet.

Jaegeuk, Eric, have you guys considered this?

  Luis

