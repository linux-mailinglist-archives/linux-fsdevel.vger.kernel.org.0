Return-Path: <linux-fsdevel+bounces-41733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC379A362C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460A6188F1F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57602676CE;
	Fri, 14 Feb 2025 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uFAVLGxd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFBB1531C1;
	Fri, 14 Feb 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549767; cv=none; b=aqXYAQhLMfT7/i1au9r9zrlPt3udgiaL8Qrl7Cop3yboYs3mWNJD/P1hj4/sHikKycJfGuuPmib703LhHKsSvNAOrdN86l1T3gYec+gQu8jurHidjabCJxv71noiL2V9LCV9CbjVhhxSxcjiQuC5bsOaUKUpmfOMvBwIoWbMZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549767; c=relaxed/simple;
	bh=K7RpZQGrGO5ej4N2ORvfhLBZaal78okbm2evpdo/Ssw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHgQZ/ixn60Wb03lHn5BU8kfXI1w/g4SjjONCd+Gx6XJHbnEJ9SM9wpt0TRnEWkp9WkiWDVhFGzg6dAGmk5qDyOvQz8lc1xHkPxPPY5e8a3WL+rkG1LldjjxQ9VejmUaEHmThaD7dUF3luVG5wjviEoi+AKsjLTpAAqMwCdX0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uFAVLGxd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yszxBhdXIxOMKDgR5Ams0H6VL4l4tjK2fj+Y7S/786g=; b=uFAVLGxd5WSfTURAxxre/UCYKt
	0Ti+uhLs1ehIxcMs+AXPQPAPhresx1Ag7o2Epcchusysyj0RqZvRTwwzjQh0YqTVe3OnJppwgoxLW
	fEImhrBpSejFVbFmNyTuTaguYFTYIz2xtBlhDWWzckTw65luBhYYTnFrNe0itvqMw+5qCO4fsH/Ig
	Y+woMu/FDJ2xqXciwc8wYq+AyPLGMIMbfAougUkrLWsjKnibPi3FdgD48t5aHX+EG7uqtfSHm6sGR
	xzladomTXySYECruUGRu1sw9HJzR9H5wroz54bIkHMKv+ouT+qjJLm48iLBm0K61LQs85Ohv4pPo3
	fHn0Lfig==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiyME-0000000BjXd-32Pf;
	Fri, 14 Feb 2025 16:16:02 +0000
Date: Fri, 14 Feb 2025 16:16:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] dax: Remove access to page->index
Message-ID: <Z69sQl-iq_d1YQSE@casper.infradead.org>
References: <20241216155408.8102-1-willy@infradead.org>
 <677c78a121044_f58f29458@dwillia2-xfh.jf.intel.com.notmuch>
 <ivwl5yqx7bfa6hw233gaicmdb3tvqmy6tqsrfbiyghzwlrghxk@yifmg7leosa7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ivwl5yqx7bfa6hw233gaicmdb3tvqmy6tqsrfbiyghzwlrghxk@yifmg7leosa7>

On Wed, Jan 08, 2025 at 10:24:00AM +1100, Alistair Popple wrote:
> On Mon, Jan 06, 2025 at 04:43:13PM -0800, Dan Williams wrote:
> > Matthew Wilcox (Oracle) wrote:
> > > This looks like a complete mess (why are we setting page->index at page
> > > fault time?)
> > 
> > Full story in Alistair's patches, but this a side effect of bypassing
> > the page allocator for instantiating file-backed mappings.
> > 
> > > but I no longer care about DAX, and there's no reason to
> > > let DAX hold us back from removing page->index.
> > 
> > Question is whether to move ahead with this now and have Alistair
> > rebase, or push ahead with getting Alistair's series into -next? I am
> > hoping that Alistair's series can move ahead this cycle, but still
> > catching up on the latest after the holiday break.
> 
> The rebase probably isn't that hard, but if we push ahead with my series it's
> largely unnecessary as it moves this over to the folio anyway. I've just posted
> a respin on top of next-20241216 -
> https://lore.kernel.org/linux-mm/cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com/

Looking at what's in linux-next today, there's no changes to
dax_set_mapping(), so this patch still applies cleanly (patch 2/2 is
obviated).  Can you look at this patch (1/2) again and apply it if it
seems good?

