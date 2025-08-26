Return-Path: <linux-fsdevel+bounces-59208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7E6B362A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB779188B50A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438BA34A320;
	Tue, 26 Aug 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3DUy03A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10034A31D;
	Tue, 26 Aug 2025 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214130; cv=none; b=N5T16VJ1kTo/kqXnyiQkbVqP1gGh4yCV5eDQsNuvqciHuXSxZuBri/xR8lcnqig472tWL/+Qmju6W7oCKMQMHJeC1IxRgY7njYYBUO7x/OTNhpX5VnhdZCgAtbRFY+hpJbMA3MwYuATwgHFq/7xLagRr3qh2+b1rm+03F5Q4JqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214130; c=relaxed/simple;
	bh=/GF/EE8LSbkG5+vnM2Y9COqE8FiD1Xe9jn2p6rxdpZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhS7Xhng62aMLSVC4Q1217sq8HwYZQTQuZv1jwzo6eE17HiM8FqNvPo9iXHVIPTUm4OeUt9pHq87pZvwzns6eAhG9c2l24aTuOxfyTJhtm2F5yyslyT4pcBpO1XRrXxZIe2lAd8yTwHrjuY/ExTKNsB9WsDuLUv3sO1Tx9UuVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W3DUy03A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wgBlLzPE+bIG9QXx0H4m5iqszn2RpK1T27yebeWsnBE=; b=W3DUy03AvAMTLbFDQRviP/lnDk
	db1RPwBWBpQX2ng+76PGsqI5uqyj15i7XKq5/P7H4Xtpg0/1JSfBdtKUzrwlxDdOVtLkTR777JuqI
	OCy+y9clZdX68f/IbLKZx94+rbicQtQ6edhKJwFQB0d6YEEzEDzWA0PkYym+7gYvreKmQK/gkqjPs
	8nB2Jwne2dDX+oQonE84tJOVI1CGMOn+dejWAzUm+S6cljSW8lvodPg+Da+nC21O9dDZO05TBC4V0
	kj1WaAsL7Nw3EJ8+L1IzImh5+A6dhcVxJRMmxZNUU27j98itAfnNCEyasQO1Wo0p8CTl4kzkp7fF9
	TDGj6LWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtWJ-0000000C4Ad-0jgj;
	Tue, 26 Aug 2025 13:15:27 +0000
Date: Tue, 26 Aug 2025 06:15:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
Message-ID: <aK2zbz9KU4T3oFTu@infradead.org>
References: <20250822150550.GP7942@frogsfrogsfrogs>
 <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com>
 <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com>
 <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
 <aKwq_QoiEvtK89vY@infradead.org>
 <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
 <aKw_XSEEFVG4n79_@infradead.org>
 <CAPFOzZuH=Mb2D_sNTZrnbcx0SYKcQOqMydk373_eTLc19-H+cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPFOzZuH=Mb2D_sNTZrnbcx0SYKcQOqMydk373_eTLc19-H+cQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 26, 2025 at 05:46:03PM +0800, Fengnan Chang wrote:
> > Interesting.  This is why the not yet merged ext4 iomap patches I guess?
> > Do you see similar numbers with XFS?
> Yes, similar numbers with XFS.

Can you add the numbers to the next submission of the patch?


