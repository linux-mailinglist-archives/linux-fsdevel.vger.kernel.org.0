Return-Path: <linux-fsdevel+bounces-14697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05CC87E2CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAE21C20BCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 04:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A39208BB;
	Mon, 18 Mar 2024 04:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWHjDTdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0781E883;
	Mon, 18 Mar 2024 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710736745; cv=none; b=uoiuJeTAULLtFWFgzMj/Swr8MbxDlW0eNGfcdiBGklvxSB8Iq/eXBkysqQhTPlkJB4QhVYPq64HXRuE+6EXR8Wnm7fopZBgGPrXR/i87dB16jv+30JXkpCu14iPaoJ96toqXQi5TYvUxBBeu4C8FrS/iXMZGW4nGWDkwOFeTIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710736745; c=relaxed/simple;
	bh=qQ6uQSLBS08eJR5PSFFBt/l0icE7ChjjIeXcc5PcETk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBowFknwARAHj+rCsyo4bBhJhNiFAJwuCJW4J+hWXF6eIJ25A74fsWRsHKd5Jy+mRXhG8L4Vi8PK8IGxxLRu/riU+EmgAIC8TpA49IrEgsYFbSm8ii4dBTWiWteeKG2gmPF3McCdjQlksy2BmYqkV0o5bXklU/ovHwn1F2g77sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KWHjDTdE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZnUdutU7SpebkHGWledEgEvqgeHpGgxlETIbbok/6ys=; b=KWHjDTdEIp4s566EmHC0E5Q6wZ
	bHF72svR+5C9nJPfUooi3jjlgQseXzTSVjbWit+k7sX5p3ugrBLTCAh9fLHR0ux3ILPdjFkP1QffZ
	nOgj+iWwcyC8UOAOMd02iXbXWDzH0b9sCdcmtWFs7B0DDAAUJLqJe0Arzp9U8H+nPCWSnNX4BuDHc
	b+h3F8mJAiPHizsghZm4JRyj0C0D4TC4RILUaOZ1n6/NwSNUjkffz7nQxsqCsHNq6NIlFQ9z8Qp8k
	ybI2Sha/uqmVuYOklCNYRR+ePHP1GHqpOQfhbc6PMkCACeC9vhE+OxwEIhsDiMP9DwPUWpk6lvPBB
	Q4vzJ0ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm4m5-00000007GDQ-2KzF;
	Mon, 18 Mar 2024 04:39:01 +0000
Date: Sun, 17 Mar 2024 21:39:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, ebiggers@kernel.org,
	aalbersh@redhat.com, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 26/40] xfs: add fs-verity support
Message-ID: <ZffFZfWP-jSScAQN@infradead.org>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246327.2684506.14573441099126414062.stgit@frogsfrogsfrogs>
 <ZfecSzBoVDW5328l@infradead.org>
 <20240318043436.GH1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318043436.GH1927156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 17, 2024 at 09:34:36PM -0700, Darrick J. Wong wrote:
> > select few file systems doesn't seem very efficient.  Given that we
> > very rarely update it and thus concurrency on the write side doesn't
> > matter much, is there any way we could get a away with a fs-wide
> > lookup data structure and avoid this?
> 
> Only if you can hand a 128-bit key to an xarray. ;)

That's why I said lookup data structure and not xarray.  It would
probably work with an rthashtable.

> But in all seriousness, we could have a per-AG xarray that maps
> xfs_agino_t to this xarray of merkle blocks.  That would be nice in that
> we don't have to touch xfs_icache.c for the shrinker at all.

I have to admit I haven't read the code enough to even know from
what to what it maps.  I'll try to get a bit deeper into the code,
time permitting.


