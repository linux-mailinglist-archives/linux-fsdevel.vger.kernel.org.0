Return-Path: <linux-fsdevel+bounces-69371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0625C78814
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 11:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 903D14EE028
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28E30F941;
	Fri, 21 Nov 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wd0WWixo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9332F6180;
	Fri, 21 Nov 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720536; cv=none; b=Hk1AmS4UN5xVftTnJUCQnwvOg0q1BA26xCWiCVBEUPtd3qGmPYlqG/0w/1yQojP7CqkSele4dVDWdASELxSzWCDsjEBTmj3zcANkeZQecj5k4gZBJk65OM7tt/UtDi5tMsOTujcOUwQFMlBFUSX3Za/Vs8NsT3ev9z8XG9pwiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720536; c=relaxed/simple;
	bh=SZiBvCMjel6CPR2XuRKUj5SuwhGtc8zfltPMNXMep2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ1ZlJcnOBAv3frUw2F57b4eH0MutUb+DpHhKpVezn1mTEBZcXy0Z50K0vt7o6FG1I2y7wPK5CH1Vhoo5cFqfJWqYg6KOmav9aCH/mBwKgjOqGS39a9eWeTxm8mV+acFx8wC7oXti2GsXiX72a4vcadqYHp7Z+HBegCCkBHcpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wd0WWixo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hWR1A0AVq7ooSj8qggv8jU7Tj18Snz116UqmuyhuTBY=; b=wd0WWixoa6sJDztd1wLXDr4AoV
	Y6udtxNR09ix5FKLFDEUbwdAj3oPh0FItpl6EIEfyfCWWaOHZZskZWn9th3pSy94jFlPWyUHCiU10
	43wUx9BvraFI9ln9h0YWgKKr84cqoN9XuFDAUXSdXuwS+rKiZYLkJIkHxkyz+OE4/WneSjQjE1msY
	bC+Yubwcw8I1DMHxk99SjVh6VwWHgD3DUKLRfnvnR1lhziSr5RBxRoXSCvQAbljvZua4z3l3MJ627
	tGN3o/LZepWTQdegAwy23JTFsShsGxTEdfjkb6BsrY/9tud/yXdUh2z8nVa2EZ6O+xvIO4bbKhvgY
	MhuzaVYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMOHN-00000008EGz-1nEN;
	Fri, 21 Nov 2025 10:22:13 +0000
Date: Fri, 21 Nov 2025 02:22:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: guzebing <guzebing1612@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	guzebing <guzebing@bytedance.com>,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH] iomap: add allocation cache for iomap_dio
Message-ID: <aSA9VTO8vDPYZxNx@infradead.org>
References: <20251121090052.384823-1-guzebing1612@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121090052.384823-1-guzebing1612@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 21, 2025 at 05:00:52PM +0800, guzebing wrote:
> From: guzebing <guzebing@bytedance.com>
> 
> As implemented by the bio structure, we do the same thing on the
> iomap-dio structure. Add a per-cpu cache for iomap_dio allocations,
> enabling us to quickly recycle them instead of going through the slab
> allocator.
> 
> By making such changes, we can reduce memory allocation on the direct
> IO path, so that direct IO will not block due to insufficient system
> memory. In addition, for direct IO, the read performance of io_uring
> is improved by about 2.6%.

Have you checked how much of that you'd get by using a dedicated
slab cache that should also do per-cpu allocations?  Note that even
if we had a dedicated per-cpu cache we'd probably still want that.

Also any chance you could factor this into common code?


