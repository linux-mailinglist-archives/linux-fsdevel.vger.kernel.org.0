Return-Path: <linux-fsdevel+bounces-9377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7FB8406D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9341F25678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6764CF6;
	Mon, 29 Jan 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XtLogM/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBC64CE3;
	Mon, 29 Jan 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534772; cv=none; b=LUg95OFvqAdhiMNS5OW6RNLhqjnn5xqvxNAY1ff8IZcDGhWYKWE+webB3A8Fmvj27yu0B93F/RxiN6/JNtvqZcIj4ZdvyHAHgsCeNbxPJh5kA0SOwV4ikuENJh65uwRkXTyvHkSXyudddkba6FJV1xicahu/EpbH1ttU2aQz4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534772; c=relaxed/simple;
	bh=xwMcV3tNhSk+2xyVIcFgqQPYvtX3UtKlP6tjwF+wLxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqlqYwe8O1D3zKTrKKPeq9Bffh8dP3ivJ2+rzp7STaMLwUQBcVXPjA8EdF5WHUcgjkKXaFx6EWh8nzLGiPcKB42ATNXk+VCRG1RW7hjGwcnrJWEHNGs7Xc0/NJ2emRY4GG6m97qfSo9HUzauh16BOXYZbNd2Iyc7n2CXkZjYssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XtLogM/b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Xny/9dxsbpogvH8OKBQOEtr91O6R9Hp8hj1G9BwXFc=; b=XtLogM/bjdvsN4LPHEVaTg29du
	0Unj6JuGv0EHxkbpUCdxQr8yIE3G+kAX/kJX+wiyiINxVZt1Lp6yByH7mj3xUmi1lsIJPbErTUwmt
	ENt4Qa0/KXxmZlQbiWoVkUcvX3KDU5VgfBTZTx6wkiPhB1dseNe4GwPAmkU2PFzAy5fwvJoYSW9ze
	FrjdfFENUWgA9HB218k9Q7AklwhGkZQGIrNRErGK8BCrjzt3nbPGoSpwXOGJ5CTR6Kh/3IeKZ27iR
	ry4JKdRnvVrQmXBH9x/tXavd2pvkj/91femN7KJwvCkZgitIuCjOSzHUrlWRYO0xRiGLifncssWg1
	3Jxna3MQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUReI-00000006hqA-0T1r;
	Mon, 29 Jan 2024 13:26:06 +0000
Date: Mon, 29 Jan 2024 13:26:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Mike Snitzer <snitzer@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbenbtEXY82N6tHt@casper.infradead.org>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
 <ZbciOba1h3V9mmup@fedora>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <ZbdhBaXkXm6xyqgC@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbdhBaXkXm6xyqgC@fedora>

On Mon, Jan 29, 2024 at 04:25:41PM +0800, Ming Lei wrote:
> Here the single .ra_pages may not work, that is why this patch stores
> the willneed range in maple tree, please see the following words from
> the original RH report:
> 
> "
> Increasing read ahead is not an option as it has a mixed I/O workload of
> random I/O and sequential I/O, so that a large read ahead is very counterproductive
> to the random I/O and is unacceptable.
> "

It is really frustrating having to drag this important information out of
you.  Please send the full bug report (stripping identifying information
if that's what the customer needs).  We seem to be covering the same
ground again in public that apparently you've already done in private.
This is no way to work with upstream.

