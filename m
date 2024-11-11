Return-Path: <linux-fsdevel+bounces-34182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06D9C37EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9AD1C21704
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 05:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9771714F9F9;
	Mon, 11 Nov 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T1+WSmdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F518E1F;
	Mon, 11 Nov 2024 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304333; cv=none; b=N/9ewoG92qVhBdjQRAU9SCy/7hySgYjYF1SB+70f5OTqXoanOshxPBvy68m9eEI5ogvo0/Lw5EkHaNYI/P5Ofl/v4GzbTTFDFFucTs37WR69dGn6M2tlhPb9t2QFeHir8U9s7/tAo1HS4HWk3yhjCV8rTfVzrEoP2wLcJleBuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304333; c=relaxed/simple;
	bh=EO1QHIM5+jGSfEBNzYbLoWnFYHOurX46zYafIDiSrjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/kvqpkK+fIJ8kJbz5Hqim8xebEYE7japcTQfJCCKIG+AgpSmoCaqj7JpiopE3RfFD3SZefg9F2vDbvJffZsBGh2r0NG1Wg2qV56go9vliNPExMb96Bxi9E1LPhQ0erE09Zg+y+3YQFDLCIVZqWqNIVeo4513LfYK7VDkOYc68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T1+WSmdM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/tjpwVMdHaeR0AMQS52svXXyIw2bL3kG9DW5H+2u1Gc=; b=T1+WSmdM+UAnQkcVtBJhUIxV99
	HZRtGy8E2LaE5e/wamHDg0up4A6l2BhNrt3WIO7BEQBaOioByu9e+I2bWAow3I2DSFtKh215bUsRn
	YmL4nRo+eyiZ5WXFN4LcJNQFL4e45RYk11vuA/bqkGXInnej3UrpTVmONtMR29tM9BG0idHAS2ra2
	TViCy51WbWJ5IaOPTlW978MvprYcdfeD0xpZjHNTkMU0ir4DCITREv2MOAo73DeXzR+2K5XiN5yJy
	52ZiVH6rj4xmou6wqZfFO5fdRY1rHdFHPLMGDNaRa7TSVE8eatxJnEFSxJwwFNMe6vDufiYaReIRf
	FD4a4DOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tANLO-0000000GQGy-26jq;
	Mon, 11 Nov 2024 05:52:10 +0000
Date: Sun, 10 Nov 2024 21:52:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: About using on-stack fsdata pointer for write_begin() and
 write_end() callbacks
Message-ID: <ZzGbioLSB3m7ozq1@infradead.org>
References: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 11, 2024 at 02:57:06PM +1030, Qu Wenruo wrote:
> Hi,
> 
> Recently I'm working on migrating btrfs_buffered_write() to utilize
> write_begin() and write_end() callbacks.

Why?  They aren't exactly efficient, and it's just going to create
more Churn for Goldwyn's iomap work.

> Currently only the following filesystems really utilizing that pointer:
> 
> - bcachefs
>   Which is a structure of 24 bytes without any extra pointer.

And as pointed out last time willy and I did go through the users of
write_begin/end this is just dead code that is never called.

> Thus I'm wondering should we make perform_generic_write() to accept a
> *fsdata pointer, other than making write_begin() to allocate one.
> So that we only need to allocate the memory (or use the on-stack one)
> once per write, other than once per folio.

And that scheme was one of my suggestions back then, together with
removing write_begin/end from address_space_operations because they
aren't operations called by MM/pagecache code, but just callbacks
provided by the file system to perform_generic_write.


