Return-Path: <linux-fsdevel+bounces-53820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4BAF7EF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F081C580016
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F67E2F0C70;
	Thu,  3 Jul 2025 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPzHa813"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66F289E17;
	Thu,  3 Jul 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564072; cv=none; b=XXvAoj53QLbGRMORwI269V1T8AEsEDPdq+S5uSshz99TF5KwXdPgxdqG5IBTC7glX6iaYPpsTZ+SzdsUAD2CumGie7y6CsR+qyu6dIqWD/dFR8XJd8L8QIPfcL1xcuMBdxxYYH4zq/taQ/r2ZbkI2vPdbwoFmWxqY7iJqL/ylh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564072; c=relaxed/simple;
	bh=rnJj1lAmOczNutJS2NXs1aB/YBX4KrH5s6OETafbVrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m37WNiuN9e198M2ZsgcHhwVZpgQebrwTT295Vtoq+Dudz+W/DkMoajcaAdtzBzaTjqbLbu2zNMnmVHAkW437pTZ/59EdhSqYEM92SCzHvKgtR4ZGdIA973rOpLLI1Oz/igdsd05KU6gWb3jk2KQ7eEJeFjOZcLvpsJbHRGoxt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FPzHa813; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OWB1t5fsA1yteyotlpnQA7pAyDo5DDfi98K8/8ko/0w=; b=FPzHa813kryaam2+V7sRBYnun/
	y/egD8SelkoS0Nt7ZCPIt4bOotNndyMv/qlv2AOw6jG03lKOVurJkvycQbZl4KLgy63na1tBft+RM
	hhFAHH8dsRXzCrxiFb6k57gkTwpXPnIpwLrAVr5H6i+BjMm9xuDitLTM2Rz4uhW6PJFdgTs1H9ru+
	T3ah/X7EJaBaptqpAQgf6HWXzQopYJFt33PVAMp9183A+EkLf9wQhnS4zupnxROY8+/dS06JOOAoX
	zYYtfP/tEL6zei7usyZPy9g755PwxDZzncMopeiH5YRJnBt1Jrrvne9Am1Oi/mDxOGjUmYu8IKuTB
	NNsRtefg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXNpE-0000000DsHI-3pNd;
	Thu, 03 Jul 2025 17:34:20 +0000
Date: Thu, 3 Jul 2025 18:34:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: alexjlzheng@gmail.com, brauner@kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>, linux-mm@kvack.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with
 locks
Message-ID: <aGa_HFAupmxO_iri@casper.infradead.org>
References: <20250701144847.12752-1-alexjlzheng@tencent.com>
 <aGaLLHq3pRjGlO2W@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGaLLHq3pRjGlO2W@infradead.org>

On Thu, Jul 03, 2025 at 06:52:44AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 01, 2025 at 10:48:47PM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > In the buffer write path, iomap_set_range_uptodate() is called every
> > time iomap_end_write() is called. But if folio_test_uptodate() holds, we
> > know that all blocks in this folio are already in the uptodate state, so
> > there is no need to go deep into the critical section of state_lock to
> > execute bitmap_set().
> > 
> > Although state_lock may not have significant lock contention due to
> > folio lock, this patch at least reduces the number of instructions.
> 
> That means the uptodate bitmap is stale in that case.  That would
> only matter if we could clear the folio uptodate bit and still
> expect the page content to survive.  Which sounds dubious and I could
> not find anything relevant grepping the tree, but I'm adding the
> linux-mm list just in case.

Once a folio is uptodate, there is no route back to !uptodate without
going through the removal of the folio from the page cache.  The read()
path relies on this for example; once it has a refcount on the folio,
and has checked the uptodate bit, it will copy the contents to userspace.

