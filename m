Return-Path: <linux-fsdevel+bounces-36155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2FD9DE8B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 15:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E159B2263F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB9213B280;
	Fri, 29 Nov 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCZwM1n+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DF5588F;
	Fri, 29 Nov 2024 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891204; cv=none; b=Q05ShtZmaszkHwyn3L3E/ppXFr1lLmBOgTzaBEVFuWzsP653hm/aQiyYHPMLPRKSA024o182bpqINL4ZeMSEjsRxIleo/TCqeG5AloCBRJq2Xm4BopolY0KwYhNh2CNzghL+U1PaVSQw5PvqMqnybIi/QUBn0Z6weQlRuuRMkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891204; c=relaxed/simple;
	bh=6mw/FlTI8MVOgDRWdcFTJb3loKK3buYJaduFq/EGMnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1+eQg8IbQY+NZAtOqmxeHGNjYoa8grKB8GMJHUl5pXrRMx/eS9Uu3sDSHwFSgrAIK5LL7hAeDwo7YT64jNkgWhEmf4nKqLCuIfZdpCieJ3njOqc0eZ9nK0UPyKPfDtmo9VvmkL/XfSCDvQzb1AIIipyNZ9E1qSh6GQrJYhCvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OCZwM1n+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8hjlvTfLKZGT+fSA34Wy1KPsz0rVWkmsJ6NfArBAZfE=; b=OCZwM1n+45nRWao68MufT5yFP6
	ECK1Pb1Bl7NhgIoPBZQpGh/SZePDQXQ9XqwZHj15so2N/F7aPV1CyrX7vejBOtaft6kMuU8mPPRXT
	O5YaVEL19RdH07BtYtH9qERs9q1us0RsZKtl/74qCFexpWhXzcrTAAoOFhPOnKh1cxG00SWwx0Psw
	5KBQtKGhYsE0Pplm8Sk0+Hyg1pYbbqIm+BNFnoPgxaKDKlt1A+v+8yjlfT3SEz4J7bZ2xliTVt2TO
	L0iu0dPbmevJX5scnAELwrPIM35T35Gbbl2cxBOFteVvIAQwF5xqTn1LlOtqrHoMgw7uqlma5womo
	D+/ZeJoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tH2A5-000000047m0-0Ozz;
	Fri, 29 Nov 2024 14:40:01 +0000
Date: Fri, 29 Nov 2024 14:40:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/5] ceph: Do not look at the index of an encrypted page
Message-ID: <Z0nSQF7ujc6wzv8b@casper.infradead.org>
References: <20241129055058.858940-1-willy@infradead.org>
 <20241129055058.858940-2-willy@infradead.org>
 <a8f7569120339dedc6bbe50df773e0e55baf11fa.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f7569120339dedc6bbe50df773e0e55baf11fa.camel@kernel.org>

On Fri, Nov 29, 2024 at 08:26:42AM -0500, Jeff Layton wrote:
> On Fri, 2024-11-29 at 05:50 +0000, Matthew Wilcox (Oracle) wrote:
> > If the pages array contains encrypted pages, we cannot look at
> > page->index because that field is uninitialised.  Instead, use the new
> > ceph_fscrypt_pagecache_folio() to get the pagecache folio and look at
> > the index of that.
> > 
> > Fixes: 4de77f25fd85 (ceph: use osd_req_op_extent_osd_iter for netfs reads)
> 
> This commit may be a better candidate for the fixes tag:
> 
>      d55207717ded ceph: add encryption support to writepage and writepages

... that's the commit i had intended to use.  Not sure what I
fat-fingered to make this happen.

