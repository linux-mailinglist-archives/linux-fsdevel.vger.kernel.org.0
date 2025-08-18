Return-Path: <linux-fsdevel+bounces-58188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE6B2AD8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E46188FFE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFB32A3FB;
	Mon, 18 Aug 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kz5ySasc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738133112B7;
	Mon, 18 Aug 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532691; cv=none; b=VFQXlXpjY+9ExoeN9nTR20j7hOLWc3Y9z2+ybV6/4OJRh3nGnJmUoDs3Y+dsB5YxyvEfPa2QGuowEuHA74r3lkJnecMRqnJB9/mpSkaJL5b5X9jEItt5EVsN2B6eQ3t8FhmdMoYxWyd3k2gaEFbcDLisAaGo2KDWwZi2gNyyeMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532691; c=relaxed/simple;
	bh=M6H5jyfuov51BaKE0XPQjZTzLJhPU/As4MWMVbHDhEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXWA1MJg5wm7TEKcGA+gLhx3dZHY9PZIFn0NZYgAY+2iWYkl006ELkWzKiFO7v5dRy5u7zLmyhpypkV83r1hVks/p2lfDF52ReNpN1IgUfzGVGGXn4YAyZTXbosvr3QsY/JlFpthRhzAUpBSdqtVddxA9zELMRAqb+xi6MOsg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kz5ySasc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JXkBF1fdtfgQH/TpbR0G8f6GA7c+FUfI4zbKqnpJcqY=; b=Kz5ySascq3Pn2wDwc0QM9Z7KEQ
	wZlqwjAHGkhLYVuHGq4ASCyHawUICBda3Kr69ES5bUntDfhk00M1FnoI5xHfDsQr7sXZVVUrMfEAv
	1jnyC3wLHb1uNCDG9XcCwhL9d1GHMvadQcYPIJkdP86mdiTEeEGNAdfj156mjQGpRk0Y6DUdJAtAE
	ZSSdoZrU4ocfcNF7yJXvwAM/lbSQZnTatYTHbVc7LE6/jdMqyf0Z6EnpazgQ/mVjc6LCqsUMSWG58
	RRWQDTtTjWY+c5lC9pHVXuKqnT+XxFPdiTMz/ZeR/RGQbDnfR+nDY9OEGYKwDkbPlrYrrwJvT8Mvf
	9cXAECfA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo2FM-00000008ACV-2vHI;
	Mon, 18 Aug 2025 15:58:08 +0000
Date: Mon, 18 Aug 2025 16:58:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v3 2/2] NFS: Enable the RWF_DONTCACHE flag for the NFS
 client
Message-ID: <aKNNkFJ3mt0svnyw@casper.infradead.org>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
 <001e5575d7ddbcdb925626151a7dcc7353445543.1755527537.git.trond.myklebust@hammerspace.com>
 <aKNE9UnyBoaE_UzJ@casper.infradead.org>
 <88e2e70a827618b5301d92b094ef07efacba0577.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88e2e70a827618b5301d92b094ef07efacba0577.camel@kernel.org>

On Mon, Aug 18, 2025 at 08:56:31AM -0700, Trond Myklebust wrote:
> On Mon, 2025-08-18 at 16:21 +0100, Matthew Wilcox wrote:
> > I don't think this technique is "safe".  By clearing the flag early,
> > the page cache can't see that a folio that was created by dropbehind
> > has now been reused and should have its dropbehind flag cleared.  So
> > we
> > might see pages dropped from the cache that really should not be.
> 
> The only alternative would be to add back in a helper in mm/filemap.c
> that does the normal folio_end_writeback() routine, but ignores the
> dropbehind flag. (folio_end_writeback_ignore_dropbehind()?)

Can you remind me why we clear the writeback flag as soon as the WRITE
completes instead of leaving it set until the COMMIT completes?

