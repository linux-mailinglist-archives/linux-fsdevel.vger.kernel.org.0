Return-Path: <linux-fsdevel+bounces-22173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5891321D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 07:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955D02854F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 05:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC03149E15;
	Sat, 22 Jun 2024 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vCbRsdey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F9273FE;
	Sat, 22 Jun 2024 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719033553; cv=none; b=iEBVn3VZXWiArIeiLNYMjq7IA4yRK4tLoTWShI011UabPdue+3WDOrHZeiNuTOt/2mvPh5UMVFL+jcUxfy7CLGdz9T0id7m59EPibt9G3rSWyauPsV4f/y9uadZtmmeiB+gvFTelUOykDriVCSI1EXT6HuEIiUfSPPIDDj0ZgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719033553; c=relaxed/simple;
	bh=unfZ6xHIh8OTUujtOq3+fBHT0LUHUTuPqbFOHN7UAYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9CEGjJ1C42ds3Bp6wdhw7062nl0pnoIeQ5rjZonoilIG0Ytq9q+VRJ4AWS22KXKxyukzhPRjQ+YpTPfh4hvRzUDkcnvUgTN82I65K9LWOP9xj1r4Ij7ktFWvka1ly9lGZTk988DXWOvPgQCLntOk9KAlrhxPg6g50wBAi/jksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vCbRsdey; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bPXBrH9ln0Qs9gRrnExlKlHWl4LYgq9/5kBdLz3ri4Q=; b=vCbRsdeyzNGPyeNzVT1EXcxnrw
	nIjIuSxk0d3Kps6bCygkxFbiKG8sc3ERHWF//di7pCogE8Y2hxlsNn4X6ranwugvXAK/Azq49BeLq
	/dzc+typzNa6t/o28KtFKVfHo3wRcet8SYihSkUPKTSKaW10tAPmZQydrDyczcYCofVgrn+A40Yuj
	ZMv1OyBe9Hekd1YafGBDRQk9hQtvuTr8e81Jb/3zBvBSmALO8u0qfFMt9G9SE9XLiwXamcmMWJsJc
	CrYCNo+y94xLLhpmyuM7Ww9WfeJRDH6UDJQbkty6hx9vO3WXPtLVygzeUPI3an2Nq8riD813fPfwc
	jdILDqQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKt9Z-0000000BR14-1YMM;
	Sat, 22 Jun 2024 05:19:09 +0000
Date: Fri, 21 Jun 2024 22:19:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	fsverity@lists.linux.dev, Eric Sandeen <sandeen@redhat.com>,
	Shirley Ma <shirley.ma@oracle.com>
Subject: Re: Handing xfs fsverity development back to you
Message-ID: <ZnZezSymGy2VyeeG@infradead.org>
References: <20240612190644.GA3271526@frogsfrogsfrogs>
 <vg3n7rusjj2cnkdfm45bnsgf4jacts5elc2umbyxcfhcatmtvc@z7u64a5n4wc6>
 <20240621043511.GB4362@sol.localdomain>
 <20240621172720.GD3058325@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621172720.GD3058325@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 21, 2024 at 10:27:20AM -0700, Darrick J. Wong wrote:
> That sounds like a good approach for ext4 which will likely be feeding
> you folios from the pagecache anyway.  If Andrey sticks with the buffer
> cache that I wrote, then the virtual address is a slab allocation which
> is already mapped.

... yet another reasons to not be pointleslly different code and create
special cases and extra code in every layer of the stack..


