Return-Path: <linux-fsdevel+bounces-52808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D5AE7035
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F381BC38B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83442E7F03;
	Tue, 24 Jun 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZF5Jkk8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1626CE11;
	Tue, 24 Jun 2025 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794974; cv=none; b=rHJeHwkQ3GiWOzFUiP70kZ+vzbuvp1sq5B41LnGa9To3h6eCKONoa7E81UaNIixefOSfYeiWbLsG0UvG7auk1U6AL2+cmJlIFcQPcM9qjt8HkfQrFlk7VYj3fYulD0Slhz195TYvyd8nb7uWqfmQStEzKl5xLONFyToH4A7tpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794974; c=relaxed/simple;
	bh=zTEiSDhPnb/SmNQlci8Du6ozlroH9HA2n8hti67QsGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zesh7QUuP7BUgZ3axsIJM1MFue/xv2DpE99hmqG6tZLFNBuPmJd2srd05cuxBaPyjXThCY6yZGtE3YVSFfqM3/+q4OgD0NPA/+nb4Vq6S+tCzBj+RVK/uob5oKo1KTOfr/eV537+JDhpSC0iOjXPzoToHakH3Dp1E1MUzzkx95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZF5Jkk8i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kdFFQM8DBnlzbNbR3IoBJ1KwDp3c0vUeXIeHUg3TCw8=; b=ZF5Jkk8i+is9uJTE8UJbADAUvr
	IkKqs8NFBHcMEBYhHFAxtEif+Yu12Dv1F0dKdubRerUvKuJRkJ/bEJqrc1ybbVqCKhQIZpii2EpEC
	0xC3BkXvB7qW6G2l7cPnai4O4NCt7uF2NjqBhXLFLN/8hJ/IrjTrSgwZp2TUUQUAstEK1PLqmGwyM
	sMzpy0EhjfbDCoGoq/o/WKji4PPjPe6Ronx2TA+W4N9HTez1kyJXaHzuahK0C2i5UAtmbrqlo9+Yc
	PXtQuRJ3cMGugqsfymgfHPFhL+e0s9i30lVp5boZJUCwDdudup8sDAgcTiCFySoipNJf1t3LvZCSv
	88tAJd6g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU9kY-00000007WLb-3f9v;
	Tue, 24 Jun 2025 19:56:10 +0000
Date: Tue, 24 Jun 2025 20:56:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, ying chen <yc1082463@gmail.com>,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aFsC2vTJNG7UmfMi@casper.infradead.org>
References: <CAN2Y7hyi1HCrSiKsDT+KD8hBjQmsqzNp71Q9Z_RmBG0LLaZxCA@mail.gmail.com>
 <aFqyyUk9lO5mSguL@infradead.org>
 <c77a55f5ab294be222c8abd86c2b8fddabca9f61.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77a55f5ab294be222c8abd86c2b8fddabca9f61.camel@kernel.org>

On Tue, Jun 24, 2025 at 02:26:18PM -0400, Jeff Layton wrote:
> On Tue, 2025-06-24 at 07:14 -0700, Christoph Hellwig wrote:
> > On Sun, Jun 22, 2025 at 08:32:18PM +0800, ying chen wrote:
> > > Normally, user space returns immediately after writing data to the
> > > buffer cache. However, if an error occurs during the actual disk
> > > write operation, data loss may ensue, and there is no way to report
> > > this error back to user space immediately. Current kernels may report
> > > writeback errors when fsync() is called, but frequent invocations of
> > > fsync() can degrade performance. Therefore, a new sysctl
> > > fs.xfs.report_writeback_error_on_read is introduced, which, when set
> > > to 1, reports writeback errors when read() is called. This allows user
> > > space to be notified of writeback errors more promptly.
> > 
> > That's really kernel wide policy and not something magic done by a
> > single file system.
> 
> ...not to mention that getting an error back on a read for a prior
> writeback error would be completely unexpected by most applications.

Well.  It's somewhat understandable:

	write() (returns success)
	writeback happens, error logged
	memory pressure evicts folio
	read() brings folio into page cache
	attempt to read contents fails, error returned

I'm not sure it's a good solution, but it's plausible.

