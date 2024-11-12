Return-Path: <linux-fsdevel+bounces-34384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E979C4E09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73980282BA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D620896E;
	Tue, 12 Nov 2024 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lVTqh7ki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69C208208;
	Tue, 12 Nov 2024 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387910; cv=none; b=QQyg3LUVc+sk8lg0LFbaxr1bU4neaAtWzl94TsAmE3r6+5dxo1ltYY9/1xDmDikxXpsGwth4MqunNlJ1Bw+ClcHOnjQ+pPm2Q0OWv7uYxDRoL8+Q2Ty5eX5lr2hpdLRJ95ZJ+oS9/6rW3MxgfXX13LEV/zhkFrTeGDcLF5F61xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387910; c=relaxed/simple;
	bh=eGSuJOa10L2cTGCqVU4xFbokV0RyMzsWcPILVR2xE/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIAq515Mp0MoDdvXOb3rseMZApPYQzXatA/xYhIZzOrrsGElWbDG9FQC+Rewrlr+YzV8Miy7Z9mr5z8nbIUrGdp2m5kSfRNc+vbU8LnsMhiEkB8ax11+dqHt04Bzq6M+BmseJeEjMYJqZ3hDu10inUqOoGKaMbmSyuxN1WVl2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lVTqh7ki; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Jcfj6yTIBV63UuicFfafEH7N0VIACgBc+zT8dxqB38=; b=lVTqh7kibLojX/djnr+xaM5jGp
	ANx/P/AkItOs/NY2laYbjN8+5YbFrPwHdeuFRm/ScpSieCCFMmCwyzbfyGtdaIF83cywHSqd71g0M
	RqOF+u+guj8wYd+a64w/KkZOiSYv8UY3UyMNscTstRMoJhwMARhVpWK00DnNyX6UplOkJr5Umxcvi
	esW7N3YhiCL23YileXHiTzUy5ArAHl0/xc01xFiPWivqPpG60X31+vUeqbnoJJNthS5czf7R42RgZ
	IRLn5vyfv1mrbpZhmZe/+RQRMjV6xVX1E1Iimhu4wSLss7F6qzKpRDXFd4FPspyn9OS9t0MLbWrX1
	rbA4n3gA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAj5Q-00000002DRZ-2JTe;
	Tue, 12 Nov 2024 05:05:08 +0000
Date: Mon, 11 Nov 2024 21:05:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-fsdevel@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: About using on-stack fsdata pointer for write_begin() and
 write_end() callbacks
Message-ID: <ZzLiBEA6Sp-P7xoB@infradead.org>
References: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
 <ZzGbioLSB3m7ozq1@infradead.org>
 <d5dca4eb-2294-4d24-9e36-dac8be852622@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5dca4eb-2294-4d24-9e36-dac8be852622@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 11, 2024 at 06:06:57PM +1030, Qu Wenruo wrote:
> > Why?  They aren't exactly efficient, and it's just going to create
> > more Churn for Goldwyn's iomap work.
> 
> So it is not recommended to go the write_begin() and write_end() callbacks
> at all?
> Or just not recommended for btrfs?

They aren't a very efficient model, so I would not recommend to add
new users.

> I know there are limits like those call backs do not support IOCB_NOWAIT,
> and the memory allocation inefficient problem (it should only affect ocfs2),
> but shouldn't we encourage to use the more common paths where all other fses
> go?

I'd recommend to use iomap.

> > And that scheme was one of my suggestions back then, together with
> > removing write_begin/end from address_space_operations because they
> > aren't operations called by MM/pagecache code, but just callbacks
> > provided by the file system to perform_generic_write.
> > 
> 
> Mind to point me to the old discussion thread? I'd like to know why we
> didn't go that path.

Probably because no one did the work yet.  I don't have a pointer at
hand, but it was a discussion willy kicked up about converting
write_begin/end to folios.


