Return-Path: <linux-fsdevel+bounces-47107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3149A99219
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8049F1768AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D12951A1;
	Wed, 23 Apr 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nSeo62+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79647294A11;
	Wed, 23 Apr 2025 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421746; cv=none; b=WMolbx/n0nCvXj91gHcCVYE7jxc/yoJ+AdKgXLJdhK97E1tv6u3kxtp35TBsSFTBKqUTXYkRdldCxQdtTymincMVvSlw7Ju0+MLdVwggEB8aEWbJLrETHk6yLZ93o0PB3P2lATW6Drkyv6cCHjBHmDsrOv8AbQRYcCISj0Kmnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421746; c=relaxed/simple;
	bh=jAfJr2XQWsTd7yRq7KWP63S4YmwQunNDIphELRFESnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxT3plLO66IhYkvdsbmpvESVlPYvMLmCqAgFOXiw2VL8jqCpZO/+jgsVxjWtjmQp8U+EWzb5TE3GRHJBzaHAQtqF+WLHTUe5Xnfw6XJwST3QEFtjai3Zf5xQD7x7FDmK/561zUdhExTp0UQW1KD1/0k3F+CirfDrJOnWCTortlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nSeo62+2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YoQyjWRH9eXTiQRhc7wzvbUlYYQ5kxVn10ITUVJfxVA=; b=nSeo62+2iEJWLdPbfSzRAj630A
	vc46VIYo8JO6jguCJvkZjSPRIQJWOeHOUEo8dDzOv11DXHKLct/WjEbfkHy+J6UVEfxeDe4FufJS4
	mOBl3ORlESe46TgCZGwtqTObif0KHDrQiut8vUmdOSw1rsqVNJXtt7iaSf+jkAJVeItbYhO5QRBc+
	+zWueHtk4ROnwp4Ckp2zdCcwSYvWcEs7ojJMUeGohOVXSyBwxRV9lLSXFT9AiaET/X2hH/urDyFzW
	o07rR4ZYzzDPB57RKTsidANeA1LnFTjaxBiNbw2eOgSQL3bndMKeKo77WeuYxGDJxcG4CzMH6dtlS
	cBioKC7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7bva-00000009U9R-0oVY;
	Wed, 23 Apr 2025 15:22:22 +0000
Date: Wed, 23 Apr 2025 16:22:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: trondmy@kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Initial NFS client support for RWF_DONTCACHE
Message-ID: <aAkFrow1KTUmA_cH@casper.infradead.org>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
 <c608d941-c34d-4cf9-b635-7f327f0fd8f4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c608d941-c34d-4cf9-b635-7f327f0fd8f4@oracle.com>

On Wed, Apr 23, 2025 at 10:38:37AM -0400, Chuck Lever wrote:
> On 4/23/25 12:25 AM, trondmy@kernel.org wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 
> > The following patch set attempts to add support for the RWF_DONTCACHE
> > flag in preadv2() and pwritev2() on NFS filesystems.
> 
> Hi Trond-
> 
> "RFC" in the subject field noted.
> 
> The cover letter does not explain why one would want this facility, nor
> does it quantify the performance implications.
> 
> I can understand not wanting to cache on an NFS server, but don't you
> want to maintain a data cache as close to applications as possible?

If you look at the original work for RWF_DONTCACHE, you'll see this is
the application providing the hint that it's doing a streaming access.
It's only applied to folios which are created as a result of this
access, and other accesses to these folios while the folios are in use
clear the flag.  So it's kind of like O_DIRECT access, except that it
does go through the page cache so there's none of this funky alignment
requirement on the userspace buffers.

