Return-Path: <linux-fsdevel+bounces-60301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D9B44844
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594E97B6C47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F42BD5B9;
	Thu,  4 Sep 2025 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OwfchKtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071329D282;
	Thu,  4 Sep 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020399; cv=none; b=SoCHdeh+0dBYJlazQ9vbXwDuBz5KSn6rBwKbsM1HIuTrljANlKq8iMMZAZStz5KWmiT7P5kEllXanpHNafc/52P6ljEWmnyoscgGT+yoaQIXuEfPyflHGG/q8iBzS7kXhDiImjmEiJZCHd5Eun03dR2dh6e8jIuBMF8AQ2TcoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020399; c=relaxed/simple;
	bh=IoM7Ah+/C6I3QTxAGdIvLeQsf3RF8vjCr2iCH4kYjWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yuc6Sg+CB1BLRVVhSrvlVWseK4nsfApdTEjWFdoI9zPuSWywzCxax9e4uPjBDFeOMWE88Xjm7CgUOR0FmoMwVWVIIIeRxdbj1a0BYENI0V0baD942BoEWt9N6FnXktSsjFyUCXKqGvWxvm8Nlugxe4inRsMfVC3QI+oGqa3qPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OwfchKtx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H5DibIcqRxKNXWNtzA5NuGSerJQoQi/LHZKvg9JlpbA=; b=OwfchKtx6GVl1HrafEw/gNFXoB
	96Zq6QjU/h5+JObGbEa5c057UDGj+8M5FDED00FBsGuUGfIiqqZ+fVXDtzOP1xvLD6dwfauACePG/
	71EpvrpUjlw6Tms0ku/d+NnYnN7veGZGN2/sXY7tlPgisSRhVeYYrbWxbWRSybkLwdwkeb3SCOaOP
	cSYfkBVgRZU1cMntowljwCN34az40lsRWRWNUWeghEBV2sXnuLTlSQbekVRvysShuRz++udGlJd8M
	AjE/HmJdzPanSq6Cyk5XRwdyLWv/Ej4pasZmXcc7yHtIOb2aMbhvOuff1E3V83Zhr6Paprbd2yzUb
	b8pRBoIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuHGc-000000077zW-46qY;
	Thu, 04 Sep 2025 21:13:15 +0000
Date: Thu, 4 Sep 2025 22:13:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 05/16] iomap: propagate iomap_read_folio() error to
 caller
Message-ID: <aLoA6nkQKGqG04pW@casper.infradead.org>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-6-joannelkoong@gmail.com>
 <aLktHFhtV_4seMDN@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLktHFhtV_4seMDN@infradead.org>

On Wed, Sep 03, 2025 at 11:09:32PM -0700, Christoph Hellwig wrote:
> On Fri, Aug 29, 2025 at 04:56:16PM -0700, Joanne Koong wrote:
> > Propagate any error encountered in iomap_read_folio() back up to its
> > caller (otherwise a default -EIO will be passed up by
> > filemap_read_folio() to callers). This is standard behavior for how
> > other filesystems handle their ->read_folio() errors as well.
> 
> Is it?  As far as I remember we, or willy in particular has been
> trying to kill this error return - it isn't very hepful when the
> actually interesting real errors only happen on async completion
> anyway.

I killed the error return from ->readahead (formerly readpages).
By definition, nobody is interested in the error of readahead
since nobody asked for the data in those pages.

I designed an error reporting mechanism a while back that allowed the
errno to propagate from completion context to whoever was waiting
on the folio(s) that were part of a read request.  I can dig that
patchset up again if there's interest.


