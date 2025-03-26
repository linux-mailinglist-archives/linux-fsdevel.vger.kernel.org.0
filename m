Return-Path: <linux-fsdevel+bounces-45056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FDCA70EE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 03:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA243A71D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 02:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144413B2BB;
	Wed, 26 Mar 2025 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CDFEaSEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EC219E8;
	Wed, 26 Mar 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955703; cv=none; b=rYIBoXJqjUK/ivIJG+HDev/dcrtUMtkUVa4OoumLpMwERSNDgvI7RqrldhDdaP3xDr6HDR1hg361WZ9alD9W2jZ16iZ6p2N4m9b3yHaanvSQN0a4079rkDLmZuA0BVA1H2ycAZpaWq0Q6tSCC4LXs+p4xKtoTmCoMs71Gc5tCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955703; c=relaxed/simple;
	bh=Yh8rlxXRyZgDoKsncyXyipOwpty/cNbiRvKnJv4GXXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me7lLsiK2RgtHuZrcDuERZBqcDIh45npDZWRO1TF7IiIitdoGO7e4y+o0OPkf78AeS/kX2Uy7w91Jnxw+GcSnTjJo0H1Mxuh5Ii7BhT4Zcnidk9Vflb0eVVdK/oBhWoRA14kimmI/lPrMrg6nQG5FSzsQ7bGxHYnbjObv0q4lV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CDFEaSEH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H08voiyKqqmyqNnphcsyTXypKbCInKHul7dZLjLLGnI=; b=CDFEaSEHfoykny86NYKQKHmn5G
	6WlxxkyLfovT6voel/lbboxcFnShvFmicZGU+i3BeaIwk+0EvREUPdYpRak50XMQE5wionOMtmxw0
	IDDHfnb5InpdJ3oTTcO/HphPiAJIMg/Qzk8deokCg7sFFbfYHSPssaxIwU4/XJSwKq2Uy7vJOC/Bv
	0X8ZiU4YaEXzROuulQSwCklU2Yvtf0zMDumCk1ruQU4w+O8rteYZ9BYWgT3yZgeSIfQ85ypPv2tWe
	LO3dXeTLon6UzJBDCTPIQH6p0KoDEq5q6f4V/g3eHHDDUfpDrAbL0RzUaypIgzGigu0P9vZPFvm1e
	lm3D9R0w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txGIF-0000000GLJh-2fck;
	Wed, 26 Mar 2025 02:15:51 +0000
Date: Wed, 26 Mar 2025 02:14:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Allow file-backed or shared device private pages
Message-ID: <Z-NjI8DO6bvWphO3@casper.infradead.org>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
 <Z9e7Vye7OHSbEEx_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9e7Vye7OHSbEEx_@infradead.org>

On Sun, Mar 16, 2025 at 11:04:07PM -0700, Christoph Hellwig wrote:
> On Sun, Mar 16, 2025 at 03:29:23PM +1100, Alistair Popple wrote:
> > This series lifts that restriction by allowing ZONE_DEVICE private pages to
> > exist in the pagecache.
> 
> You'd better provide a really good argument for why we'd even want
> to do that.  So far this cover letter fails to do that.

Alistair and I discussed this during his session at LSFMM today.
Here's what I think we agreed to.

The use case is a file containing a potentially very large data set.
Some phases of processing that data set are best done on the GPU, other
phases on the CPU.  We agreed that shared writable mmap was not actually
needed (it might need to be supported for correctness, but it's not a
performance requirement).

So, there's no need to put DEVICE_PRIVATE pages in the page cache.
Instead the GPU will take a copy of the page(s).  We agreed that there
will have to be some indication (probably a folio flag?) that the GPU has
or may have a copy of (some of) the folio so that it can be invalidated
if the page is removed due to truncation / eviction.

Alistair, let me know if that's not what you think we agreed to ;-)

