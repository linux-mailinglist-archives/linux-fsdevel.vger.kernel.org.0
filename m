Return-Path: <linux-fsdevel+bounces-35929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A639D9C06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D554FB2D615
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0A91DA612;
	Tue, 26 Nov 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C3OyJxhw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D11D89EF;
	Tue, 26 Nov 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640139; cv=none; b=tOD2o0F0Mcsm6ts+jgc17ruCKNbEDGDX8lg0yzgmw2pHP/aTxTCPigAFovVScwMVOIjxTMHnsycV+zVLZXNhxw7aem6ASP1HoRPy6W8xZVAmYGRZrUkL3m3Gy8PHbfgaOAbNsG55PvFC7wWCucNZTkw2I40LzoTpweSpHnOEF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640139; c=relaxed/simple;
	bh=l1b3y3+GF+OuiSeMYjg7qeU3V5AsSZoO9SwNjdTD8s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LervaLXT63S5qRhZYUYmL+65FBO2+6g7cTx688FTlmyXN0JgzF91rBIBw5/Spbn3nd3plnAWYtJPpLV5TxbSHiAZtDjzBDoQXLZe4Tnfp5YeLKoBQZKYm3YD42lS5Gps9WxHafDZX9iO3rRGbAmyJm1HFv1djXtrVVODabQWXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C3OyJxhw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tPsdjbpH4KrZ7VjJrvC7Z+8yrw3XNOthduOr07lzPY4=; b=C3OyJxhw6Gkjv74IJwN11by+uL
	+OPjlPpcUN4X035iTxfQrqjK0S+J+paHb4Eaqxq5xhy2lZllttZSXFPK5jP0DSIc5/+YuzeSt3h55
	Wu0whn1fufvvr2lwtCIMOHt3bq+tsTyEY7tqDXESh+96gYGuqGTu0LIrvv81RLD975dq9n9gpKdNK
	brL0zcDSvtZXZSEPt0HNJhLCtxBrRKdUiibjsifNt7rmr7dfCrOnJ+Q4C0IRj53KyRv4+Hri2ldc9
	ity2Z76mVG0llOxHIayxzm0JWB2qr3SVcGuhK6kUy9iJbRu7YC4QMX5YfMj0Bs8MOQwR89S7D387I
	c6iSvTFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFyqc-00000000CcE-3Loj;
	Tue, 26 Nov 2024 16:55:34 +0000
Date: Tue, 26 Nov 2024 16:55:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Philippe Troin <phil@fifi.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>
Subject: Re: Regression in NFS probably due to very large amounts of readahead
Message-ID: <Z0X9hnjBEWXcVms-@casper.infradead.org>
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
 <20241126103719.bvd2umwarh26pmb3@quack3>
 <20241126150613.a4b57y2qmolapsuc@quack3>
 <fba6bc0c-2ea8-467c-b7ea-8810c9e13b84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba6bc0c-2ea8-467c-b7ea-8810c9e13b84@gmail.com>

On Tue, Nov 26, 2024 at 04:28:04PM +0100, Anders Blomdell wrote:
> On 2024-11-26 16:06, Jan Kara wrote:
> > Hum, checking the history the update of ra->size has been added by Neil two
> > years ago in 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't
> > process all pages"). Neil, the changelog seems as there was some real
> > motivation behind updating of ra->size in read_pages(). What was it? Now I
> > somewhat disagree with reducing ra->size in read_pages() because it seems
> > like a wrong place to do that and if we do need something like that,
> > readahead window sizing logic should rather be changed to take that into
> > account? But it all depends on what was the real rationale behind reducing
> > ra->size in read_pages()...
>
> My (rather limited) understanding of the patch is that it was intended to read those pages
> that didn't get read because the allocation of a bigger folio failed, while not redoing what
> readpages already did; how it was actually going to accomplish that is still unclear to me,
> but I even don't even quite understand the comment...
> 
> 	/*
> 	 * If there were already pages in the page cache, then we may have
> 	 * left some gaps.  Let the regular readahead code take care of this
> 	 * situation.
> 	 */
> 
> the reason for an unchanged async_size is also beyond my understanding.

This isn't because we couldn't allocate a folio, this is when we
allocated folios, tried to read them and we failed to submit the I/O.
This is a pretty rare occurrence under normal conditions.

