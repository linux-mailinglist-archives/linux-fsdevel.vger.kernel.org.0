Return-Path: <linux-fsdevel+bounces-9106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E083E38B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14A81F2571C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C42421E;
	Fri, 26 Jan 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a6nigD30"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B7208B8;
	Fri, 26 Jan 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302877; cv=none; b=FkxwQ4fbf7aZMSRiZ2KTRGMBRf0Se006oVqldS8H9qr7Jcm4nsuFbXsueK5YaYcfqQZXTZbAllGv6i5kvveQY6GzOhRuW46O7y7SsL6+I1lTjsuKghS4ugEfemObKSY/yuWkteeAN6quaKVwDo7xGX+TG6MGBI/FBsfB/XwfjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302877; c=relaxed/simple;
	bh=K/vV4HXLF0w/iq9+oevY/s4BTuCZ0+kwXRPOV5D4Cdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia+W0qFrF28D+Tdmx30EMRnSwjlbN8YattjfI70lRC0RiIYZUUYC5R19HUv3blX4kq+eC8j9wWnilb6p3pkbMdasd4agWSKqlco82SR8kT5zSiMc6HsVZF3iwXNXEE2Fp0ormtUKPn43SiQBzHKIXR3TzeG7FJ7jM2VPoZSMjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a6nigD30; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r/QEG1+GRs70rQ+r6RwZXc9jTJs5Jf1cK8sS2vy9OTU=; b=a6nigD30c17ynoFn1++uO4A7rB
	gBLNhhEo+pCSqVhVYWH0mQV6ltDRyprpRDjL6ZBPRRZEpeyZpNb/IZbOXUdO9Cj6m2GKVXw+2Dj0T
	MdRat3pIfEqyJ8iv7xrggI+qBxtQuetCP89u3dcSf3mcZI2Kw9J6bJly4sclyfPZfo214N3SwhMvT
	yy4ufWAt98IFJ2EHzZmNeRiRWxDwzn9T2LrRSWM45f1wBizs0lEuWmYfrZG3ofJkG3CMweKlUwv21
	Dvz3wChQlBJd/S7n1XHNcZCuYY9DfjNi063dK0fGrElQSJ45A/Gzy2azctDB6oPreBUMcbXB7tgac
	wpF82cMg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTTJz-0000000EqNO-07FO;
	Fri, 26 Jan 2024 21:01:07 +0000
Date: Fri, 26 Jan 2024 21:01:06 +0000
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
Message-ID: <ZbQdkiwEs8o4h807@casper.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
 <Y4d0UReDb+EmUJOz@casper.infradead.org>
 <Y5D8wYGpp/95ShTV@bombadil.infradead.org>
 <ZbLI63UHBErD6_L2@casper.infradead.org>
 <ZbLKl25vxw0eTzGE@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbLKl25vxw0eTzGE@bombadil.infradead.org>

On Thu, Jan 25, 2024 at 12:54:47PM -0800, Luis Chamberlain wrote:
> On Thu, Jan 25, 2024 at 08:47:39PM +0000, Matthew Wilcox wrote:
> > On Wed, Dec 07, 2022 at 12:51:13PM -0800, Luis Chamberlain wrote:
> > > Me and Pankaj are very interested in helping on this front. And so we'll
> > > start to organize and talk every week about this to see what is missing.
> > > First order of business however will be testing so we'll have to
> > > establish a public baseline to ensure we don't regress. For this we intend
> > > on using kdevops so that'll be done first.
> > > 
> > > If folks have patches they want to test in consideration for folio /
> > > iomap enhancements feel free to Cc us :)
> > > 
> > > After we establish a baseline we can move forward with taking on tasks
> > > which will help with this conversion.
> > 
> > So ... it's been a year.  How is this project coming along?  There
> > weren't a lot of commits to f2fs in 2023 that were folio related.
> 
> The review at LSFMM revealed iomap based filesystems were the priority
> and so that has been the priority. Once we tackle that and get XFS
> support we can revisit which next fs to help out with. Testing has been
> a *huge* part of our endeavor, and naturally getting XFS patches up to
> what is required has just taken a bit more time. But you can expect
> patches for that within a month or so.

Is anyone working on the iomap conversion for f2fs?

