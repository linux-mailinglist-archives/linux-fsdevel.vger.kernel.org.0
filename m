Return-Path: <linux-fsdevel+bounces-26717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B1A95B4EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EDF1F22F92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30341C9425;
	Thu, 22 Aug 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5u9mUWg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917EF26AF6
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329507; cv=none; b=u793Ms23bxX2J0GARfAGvvIUpRbvAx0698JqwTovyoj5ETfSmV9VmTtrbdI5gsbfkcOjnN1q9qiAUIIVH+Aa4bCWLsGaDDzgls9CBGm90Sut+zQyYq1T/Werk6vaOLtQRgiJCoEz4psJGahtv+mgmpS4annbr6kE1uf64bNcS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329507; c=relaxed/simple;
	bh=3pEhhQilSOY6xREfU5mRPtbMEfhEu3lZHAOaB4mjtDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq+MxB+o0bc8G00eju/RcYYBtR0ftPsEnYu92p0fU2PYnaKlsVl+ytLriMbp2R6nffbAYrkiwUK9jZXSYqc7q7EwcDPbpzMxgSTudWSd+9tCLVDoxoK7NCYsR3terA4a4RKa4YRQ1DlTSDPTQtJhjXD6TNLrUCh17rS9mSj3+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V5u9mUWg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nOabZakq8IflQ1H27zFS1XbgS7AbImggAf4MFUPb6Mo=; b=V5u9mUWgAsO4wK3EvZAepqSPsM
	PU5g9FZbmIAwxznETrsSdvqgvDU4G431qGgBTDWr23nBxKHqNekaRGM3ObcEynsUh7E3ic6Mi5J6M
	Z2VzoGnh/lLeR0xmYbNQd45lQzSDhJhVzQrcR7Y5Bor9FJ/yJ82EWR8TL6lIi6VL83HysRPtGvOUs
	+tBGin5YJyyNQgvW7AHzSvV091jxkaurxn7T4QWnZ7U0uxBV8rNbBOewhde21KdzsTfi1wLZemBAN
	CkUrYnn8rjBr8lqsOOlnT48CLgXxvEUD892i4BG3EJwYbUfGlAtNnuci+6FO4KF6He7Bf6WieWFfj
	HAE2o4+A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6sB-0000000AUk1-1bd2;
	Thu, 22 Aug 2024 12:25:03 +0000
Date: Thu, 22 Aug 2024 13:25:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] fuse: use folio_end_read
Message-ID: <ZscuH31tBtydNZPV@casper.infradead.org>
References: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
 <20240809162221.2582364-3-willy@infradead.org>
 <d0844e7465a12eef0e2998b5f44b350ee9e185be.camel@bitron.ch>
 <2aeca29ce9b17f67e1fac32b49c3c6ec19fdb035.camel@bitron.ch>
 <ZsSfEJA5omArfbQV@casper.infradead.org>
 <CAJfpegvFpADCWYwBdeAK3uofXL-cwmXr=WfRir7PP7hjkAr0Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvFpADCWYwBdeAK3uofXL-cwmXr=WfRir7PP7hjkAr0Wg@mail.gmail.com>

On Thu, Aug 22, 2024 at 01:58:28PM +0200, Miklos Szeredi wrote:
> On Tue, 20 Aug 2024 at 15:50, Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > Would it make sense to get a revert of this part (or a full revert of
> > > commit 413e8f014c8b) into mainline and also 6.10 stable if a proper fix
> > > will take more time?
> >
> > As far as I'm concerned, I've found the fix.  It's just that Miklos
> > isn't responding.  On holiday, perhaps?
> 
> I was, but not anymore.
> 
> I'm trying to dig though the unread pile, but haven't seen your fix.
> 
> Can you please point me in the right direction?

See the other fork of this thread:

> That's what I suspected was going wrong -- we're trying to end a read on
> a folio that is already uptodate.  Miklos, what the hell is FUSE doing
> here?


