Return-Path: <linux-fsdevel+bounces-18475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE48B94B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727E6B22506
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C108C1A;
	Thu,  2 May 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W1q+hzgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E950819;
	Thu,  2 May 2024 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714631658; cv=none; b=j4ADTkLf3PJLMhnEjJq+c7OrppF5G1CPuK16hDEA9PDZKfeDxOQwdZp8W2Y0kXu+ADgwVQfs1PJiu+wRpdEh3Y+ssxe+fII3lSdSvHNrfct2BlJwz20f7g8N0mvef//4XPAdySCZcrS6dAZ3x8grTsi0Lw2JGbzrzL4ns295114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714631658; c=relaxed/simple;
	bh=7Mc7Ty1VbUPRUi5QZvmsccwkaqI4TbLdP62iaNgO35c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo/fsWyw4PISEqP6EJHckMFiDvnaiDXzuPSHn59p3IFlpI/E2nQKWnwhaKXJvwE8jtJWcCnQ6RUXDlWEPBW/BDnM+aLHKeEHD/09LWxYKlma+kxCKWCujV9Qv9XfSQAlViQ5uhEo4pk2D1nSKlTRT58Hund9wPaGT6WVr4MvZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W1q+hzgU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Mc7Ty1VbUPRUi5QZvmsccwkaqI4TbLdP62iaNgO35c=; b=W1q+hzgUAAyfMJnTq2GfaQwX2U
	N7gMfQkVZJmrEJtMsxthVqiW6lhsGcVhbZ+IBfG7bAyyoE5cl2yUZA0/kM12sf8PBZISyUsUBmVvG
	Z5F+vH8FlWCrf3iVxqsCfoBISA6qvI2/OYm6Kcn3ucIaEzljElkoVgy0zeQ7BiXR7VJ4anUtXuc3Z
	1iYM4tNIsSW396/rUdVlvteL4N6s0GjmQoa+JduxaPGWbrC5szrjjfaGTO/xILRhzARdfKeqjtxhe
	VnegCTSE8Lr9IaDYvbLBxxWeY3XamA6uhlcWvnbe37c+o2HjbwJJPPcka1M7GaIYYgtFbQeqo0RgF
	HdKWhYKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Q1I-0000000BfQl-2QK8;
	Thu, 02 May 2024 06:34:16 +0000
Date: Wed, 1 May 2024 23:34:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/26] xfs: use unsigned ints for non-negative quantities
 in xfs_attr_remote.c
Message-ID: <ZjMz6GVrrFtL-9dT@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680378.957659.14973171617153243991.stgit@frogsfrogsfrogs>
 <ZjHnXmcsIeTh9lHI@infradead.org>
 <20240501223927.GI360919@frogsfrogsfrogs>
 <87r0ekbuva.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0ekbuva.fsf@debian-BULLSEYE-live-builder-AMD64>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 02, 2024 at 11:26:08AM +0530, Chandan Babu R wrote:
> 1. optimize COW end I/O remapping v2

This has been retracted and split.

> 2. iext handling fixes and cleanup
> ... are either missing RVBs or need to address review comments.

I'll resend this with the rename in a bit.


