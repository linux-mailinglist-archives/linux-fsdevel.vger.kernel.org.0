Return-Path: <linux-fsdevel+bounces-12650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D13862294
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 05:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8E4B24037
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 04:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5014014;
	Sat, 24 Feb 2024 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfZunUKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9014005
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708747958; cv=none; b=CsTIU9wUarpYy5iD4WZihHHbl5PuVcc1+ASO85AIoVWpufcFr9DAPux8w0+14Uw4jyEXTQjNWpUhl4JH/xNKkcPw8DzD4l1t7jUnlVkCCOnhdkbhbbpOcFZVo9IEZ3slwFvtr+JDq4u/pFl54pGzlFQJcDi8eNLpFV72FizlLGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708747958; c=relaxed/simple;
	bh=mJnqsHTlNvDBuNXq/GoCgXXCnB7QOAGs6+kqJMB6Tq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoHTI1JkkKnf64YYSgN2wSGdDeGwaoV3pD70fqT6unw1ak9/qz86hq5SDhZtf48aAqVhEb83olXnB0PcoK7+Qm6GrHdvCmWYj2sGa65lWRUX8YkdwrjBvSVrA5qKk8o/Dv49ZFCLxqY2husPIojoJcvfobDDCOi2fd98YLxJWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfZunUKe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tR7eV9V1q7EsfOqu+JiqJ3BN2VxYXVsdegtSQkqGBns=; b=LfZunUKe9v6IXx3vUAzZFTYsJ6
	0XoKbZtJp+4yeL+1vq8+mP05cFSDmYrxsPWppgK2RZPeXhAiy1BGfYB46UidlHFa1xxWLjrx3Xif6
	YOvI4YO37nxRq0O5HCoY87f0vnb76e+vBcnivqkLh6E/G8neipB45pUx2ADWtKc2qiDm3SZZ+GmXY
	ddcMxh9bej1J4ihXDnVKehpTQjxzGa39Zqyb/F3Un4f511ZtiqHqBRw7XVvmRQFDtb5i31crRfNH3
	tiVIBWYOmWpVWhrKu9WlgbEO5zBlWMC1ipdiGmjTjeaU+Z8sw7uyt4swmaw6vS5SHDazKkNN/0xHK
	TGUpFZFg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdjOp-00000009UgB-2RmN;
	Sat, 24 Feb 2024 04:12:31 +0000
Date: Sat, 24 Feb 2024 04:12:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zdlsr88A6AAlJpcc@casper.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdkxfspq3urnrM6I@bombadil.infradead.org>

On Fri, Feb 23, 2024 at 03:59:58PM -0800, Luis Chamberlain wrote:
> Part of the testing we have done with LBS was to do some performance
> tests on XFS to ensure things are not regressing. Building linux is a
> fine decent test and we did some random cloud instance tests on that and
> presented that at Plumbers, but it doesn't really cut it if we want to
> push things to the limit though. What are the limits to buffered IO
> and how do we test that? Who keeps track of it?

TLDR: Why does the pagecache suck?

>   ~86 GiB/s on pmem DIO on xfs with 64k block size, 1024 XFS agcount on x86_64
>      Vs
>  ~ 7,000 MiB/s with buffered IO

Profile?  My guess is that you're bottlenecked on the xa_lock between
memory reclaim removing folios from the page cache and the various
threads adding folios to the page cache.

If each thread has its own file, that would help.  If the threads do
their own reclaim that would help the page cache ... but then they'd
contend on the node's lru lock instead, so just trading one pain for
another.

