Return-Path: <linux-fsdevel+bounces-58113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49D3B298A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D487A99A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 04:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72642690C0;
	Mon, 18 Aug 2025 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HVjaZZZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABC266B52;
	Mon, 18 Aug 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492589; cv=none; b=W2MUJX4+cDgxx3EhaNHs9xcsx8pP79ZLJnaloW/plX3ux5nvN14uyGxHUaIGDyy/61+vw1FjJaHrIsaHkjTLZwLeJYDt3K4QlxcD3yvza1tTrt5ErvvOqbyfh2qIxDri/V6+2pZHR7AFxkiAAEILRhrmsp3b8G4YmHXAKOKY3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492589; c=relaxed/simple;
	bh=2xiu+FMyARWPvdBkrpzI426lbAfhGzmT1iq+5AQH6AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6oq7mNXIqtMwCVo2MruniMKsQ2dXiqxnRKIwNzSsDbObY4aC8rDdNETQnQMDa3gHVHih7W/SjyPWBzEHwUDtpnZHTtHn5FSc1tKcM0aFxGHzInYY6xdG43V44REzNMHTEAVyl1JgNqRMIO2bJveHkqNUaQ0jE1YTkFmgBx8V7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HVjaZZZC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ttDOyJ9w06X6rxoGDLLTdEiuNaoms1y6eq8r/nuoeZ8=; b=HVjaZZZCdVPhEdUeOcwob2tWtT
	xnaAz9b9md8WBgEFG3gBCKxURg7ynuH9Iye3+Rcf7KHkpEnGhFuXuBQw8kI2CgOCuiCmPUzZ1uJVa
	E2yFR2ATrbgD6wmA+k4B8GPurypLjpPEemnK0ZUtkopYvC/OHWr1h1o98X0Ysyujml5148edmLH+8
	Up7uT1qie1WcEUeUSyc5H1bpBNgDkdWE3cPczwaroFAadFp5t28cXvMQGrK4X5G6ZT72oFydFqP4d
	oYBtnMWyGlqb1LbtYnGa3etEHjo8ZN7rZNkw74nSMVrbC7EiKBREnK+4XuXecSPrc+Wf8hSZpe6Md
	4m6Z+Vcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unroZ-00000006V4T-12en;
	Mon, 18 Aug 2025 04:49:47 +0000
Date: Sun, 17 Aug 2025 21:49:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
Message-ID: <aKKw60JVunFUkvup@infradead.org>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com>
 <aJzwO9dYeBQAHnCC@kbusch-mbp>
 <yq11ppf2bnf.fsf@ca-mkp.ca.oracle.com>
 <aJ0JLLWrdfR5cRaW@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ0JLLWrdfR5cRaW@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 13, 2025 at 03:52:44PM -0600, Keith Busch wrote:
> On Wed, Aug 13, 2025 at 05:23:47PM -0400, Martin K. Petersen wrote:
> > dma_alignment defines the alignment of the DMA starting address. We
> > don't have a dedicated queue limit for the transfer length granularity
> > described by NVMe.
> 
> Darn, but thanks for confirming. I'll see if I can get by without
> needing a new limit, or look into adding one if not. Worst case, I can
> also let the device return the error, though I think we prefer not to
> send an IO that we know should fail.

Allowing an unprivileged user application to trivially trigger an I/O
error sounds like a bad idea.

But I think simply applying the dma_alignment to the length of
READ/WRITE commands might be work, while ignoring it for other types
of commands.

