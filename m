Return-Path: <linux-fsdevel+bounces-18472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E178B9407
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 06:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC65BB22B1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 04:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF11CFBD;
	Thu,  2 May 2024 04:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9TdPa3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080F12E75;
	Thu,  2 May 2024 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625785; cv=none; b=L2G+Api1G1Gh+BkAZH7Izy3jM3FpaVRUsGxoJvZaSrXR+efuiv5gDQo8xAVQini6u2d2aiylOqqc+om27yzFimd1ML6PSwd2KGMBRxKLFvLZjp3endUfWzN5rqdunSetsldaAjhrG1AhKvV2l+rVgYkrANaWfiJNykbXoD4VGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625785; c=relaxed/simple;
	bh=RErIiwb7KjrEtrPM9oUJGIHwPjqy1LLfD6E4dtZSJD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a47jKaOYk+wCTeM0H95mYEhHYUtkjema6v/9CU+GWS/szIm9avI8DJWEn6rk8bCymaO8k8+M/glQr64MU3dOKXQXJ2gGcyo5gublrtxbOTiFlQ+O/+sUkauXMN2EGvkQQCT/cert3zpjCgCEI7fHSwuHtIY8m6OvydnBQL22ATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o9TdPa3k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e5fKejql7xfOpfCARvldQffDWhG7LhQH8yq4p2P85lA=; b=o9TdPa3kX4u8nLyUZ3Vo3RW1MH
	eN0FcLBZD7EO/pqXwOasZ+CxqLLFFGZd3CFfMF0g4zBfsZJWUo3s3QqWslzuVyXK5ZednicbxQCL8
	nBd+4xPRvM5MCdANS9IrwG4fNOAJ2/zQkW/3wlgKo663ly8lcglaJItpegysKJMZR3qF5iLLMcLME
	QE5djPwC4376IoDSpAHvjnug/Qw+74aE92awRRcNbyPcW21hyoH9AroJopjLMERSFx+YhETVxqkKH
	0eoRo7E/GBPTusKB7zotUKihzc1dwlHzUwcmyOte2QjD5cwsMAvGygoGOuoGR9pDKrn0D3as6dO58
	EruIZk4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2OUY-0000000BT8V-1eqi;
	Thu, 02 May 2024 04:56:22 +0000
Date: Wed, 1 May 2024 21:56:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chandan Babu R <chandanbabu@kernel.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/26] xfs: use unsigned ints for non-negative quantities
 in xfs_attr_remote.c
Message-ID: <ZjMc9vDp5rruRRK3@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680378.957659.14973171617153243991.stgit@frogsfrogsfrogs>
 <ZjHnXmcsIeTh9lHI@infradead.org>
 <20240501223927.GI360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501223927.GI360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 01, 2024 at 03:39:27PM -0700, Darrick J. Wong wrote:
> > Can we please get this included ASAP instead of having it linger around?
> 
> Chandan, how many more patches are you willing to take for 6.10?  I
> think Christoph has a bunch of fully-reviewed cleanups lurking on the
> list, and then there's this one.

Also a bunch of more bugfixes for the log recovery out of bounds
access and the racy iext accesses.  Although I need to respin that
last series for the name change requested by Dave unless someone
disagrees with that.

But even if it's not or 6.10 I would so love if we could feed this kind
of generally useful cleanups upstream ASAP instead of reposting it
hundreds of times or have it linger in a branch somewhere.  That just
leads to frustranting rebases, conflicts and reinventions.  You have
quite a few more candidates like that in your patch stack.


