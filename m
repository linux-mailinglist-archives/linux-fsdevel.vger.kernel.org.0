Return-Path: <linux-fsdevel+bounces-34388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04369C4E5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52E62846B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D73F208239;
	Tue, 12 Nov 2024 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1CAqNfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0925234;
	Tue, 12 Nov 2024 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390070; cv=none; b=idnzkOPPp5yZhCs9hTVw3g6TgfZjTgDC291OAIGK4BIaLmh3YUXRjnO53iOdmYgtEhPH3v1+MB56AvPstEoEY+ttGijj3gwy58cz4EPxw4uFrrVzHZ+B5HQMGu5ihdC9OtiYzMP8dnkbjl7x+up0d9OvYR24l2EGnrGTPHTj+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390070; c=relaxed/simple;
	bh=/vXCgZWuD7wuc3T3261mVkW762tnp+6s7v6zEroFHbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG4K08lnJ1uAHtmzGU14nvC0hDLFn2/OJd6jwnkLhp3WpVn+6N6nuMDvzFG5A9d50s10Y1GTqh+fO9RqSJ4wJFOdj+K8ykLYA/3NsRIjmkvNGTbrTIYh7flhTePtrzO7SNRMPgk9uT1QsOnYefZ78T3gkP5focC5nGzrtXk8ZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A1CAqNfE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/vXCgZWuD7wuc3T3261mVkW762tnp+6s7v6zEroFHbY=; b=A1CAqNfExODp8owLmICHLhOuzl
	iQppXPOwJRwbKuPAsFPR1BFyZcU3CF+CxFOxUvksKAO+ny4dDkGHkuFNVk8xosbQ90rzrPN8fkyLx
	YnPAUj2Q0nwyZci+FGWosTlGYwwVEIGnNWUf+GTxsIIBgVvDk5cvlL7hhqB+H2EN02pSc7/P+jGUY
	hfkyEur625CvVq8WrtHWs0aGYBI3yFQocEUacoaFgrCak9FPbLLKmYWNbw3zIskbg7K6UIZkxa6Ka
	KspQXLO+dqvC8xF7I2GUnU0kgFJjRJxq12Z2Nrfsy1/aXigXqUwDKP2VHmNcB7pE3cuADxh+J2yi+
	WtV/cI8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAjeB-00000002HCb-2Kko;
	Tue, 12 Nov 2024 05:41:03 +0000
Date: Mon, 11 Nov 2024 21:41:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-fsdevel@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: About using on-stack fsdata pointer for write_begin() and
 write_end() callbacks
Message-ID: <ZzLqb5o8JsUdBGUu@infradead.org>
References: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
 <ZzGbioLSB3m7ozq1@infradead.org>
 <d5dca4eb-2294-4d24-9e36-dac8be852622@suse.com>
 <ZzLiBEA6Sp-P7xoB@infradead.org>
 <b595203e-c299-46f8-b79a-185276d53d89@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b595203e-c299-46f8-b79a-185276d53d89@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 12, 2024 at 04:01:42PM +1030, Qu Wenruo wrote:
> Although I'm still struggling on the out-of-band dirty folio (someone marked
> a folio dirty without notifying the fs) handling.

No one is allowed to mark pages dirty without file system involvement.

> The iomap writepages implementation will just mark all the folio range dirty
> and start mapping.

iomap writepages (just like any other writepages) never marks folios
dirty, it clears the dirty bit.


