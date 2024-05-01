Return-Path: <linux-fsdevel+bounces-18403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713D8B85BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E841C22453
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886A4C637;
	Wed,  1 May 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AG5zqyoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37577F;
	Wed,  1 May 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546527; cv=none; b=oNf1yWZol4TNtp+QTgTV5g4rvrGF67QcInmxA2gRZLk5wPBOxs+VDyKDdKb/J7o+j2amUNWGKGRJZOePqzY2UEG9z4JCV97Uv3OfxQN0GnF6h5o6rwaby48C2cOPb9mODp6hrYNiUzHdWEr0K5BEUocdgzpl/zzJLRRlvLRAS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546527; c=relaxed/simple;
	bh=RciCJY354ego14lArhMkXGNpNaIjw4R5PxEqmle4TkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1LCIid+M/skSDdXxUCo+OHydoJljI1peSD1OtE1beJX4zzj6typGT9Zih8+4R/OPO7F4McESvhIsjYEPDV5x9zctXOLx28VkGSntbks/Dscno90+DVhhvc061URs9s9jLb9IOrW8sjkHHY8fgX3bn1ez1M32TqXpVxuZkR+4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AG5zqyoF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HcowvvARxlwPqZqq3be9isn/xuWi6HUcXxv2hkurI9M=; b=AG5zqyoFbyRuX7dRT+ORdF2l+T
	gymDsVinKhONMWnpjAN1O7TWq3IeyGrYyu8FVmWB5e+DpDD5zyHXyMSwL2Q8sJNYC5x107yF7Zd/O
	ZDvZkbtzfdGerc0/iadKh5oyAppHaVJj4M/8IR/J8AG8c0DrxPXumr7PdpjHQhXN8bDKYvB3l0vkP
	AEUwCOwjNx7Jl8zkJaYekcmtD3pgjhTc481pJ8ZiY3PlqruWYXjwjeo8IHS/+akJs+lirA4s9S/7m
	jD91tXiaEqg/R77UZsQasqd13Sqvq4xFqdXT+Xm7Jxz6oyTSh1602wCj2brLnEyKJfOsklDsiUqMB
	jLC8htQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s23sE-00000008iDE-1A7w;
	Wed, 01 May 2024 06:55:26 +0000
Date: Tue, 30 Apr 2024 23:55:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/26] xfs: use unsigned ints for non-negative quantities
 in xfs_attr_remote.c
Message-ID: <ZjHnXmcsIeTh9lHI@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680378.957659.14973171617153243991.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444680378.957659.14973171617153243991.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 08:24:22PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In the next few patches we're going to refactor the attr remote code so
> that we can support headerless remote xattr values for storing merkle
> tree blocks.  For now, let's change the code to use unsigned int to
> describe quantities of bytes and blocks that cannot be negative.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can we please get this included ASAP instead of having it linger around?


