Return-Path: <linux-fsdevel+bounces-20076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FFB8CDBC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 23:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1DB284EBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 21:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3519127E06;
	Thu, 23 May 2024 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tsLUPJLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7384DF0;
	Thu, 23 May 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498669; cv=none; b=OdSI7+hEaDOkd/pcr+docMFmA+7YX0cT9U8ERHOnFJK1MLelmmIOdplsqxV+/c8h68Boz+Qe1KvkRmPoKFIpEacVlwl/a/0CpsRHco+u9x8pRIiGFtXG/q9CL0EbKpvdUWce5R95D3Dp9GM8rs8+mo/AzEEqF2hv7IAWUAHCVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498669; c=relaxed/simple;
	bh=U3AgHnBZpyYL5qEMXNzACcVIILK+NSDoYAQQlQadUCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTrFpHS1YSkqxycM7ba5Pu0VqYavYVZJvGms4PICctOnuzXTDc67FM791X0DbcLuf7q0o2qmKDJU7N6KQlkkNa5g3hQpV/gx6uDDpwf3KPUrPX7uJAEjKf32UMtJxmzdMwkzwyx/UsH2u3MWgv5kS3IptQ6Rpfd8e9FXWX0Fd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tsLUPJLS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r87UAbK+4R52aZiqOZBmOZr7m2+QGycYejcygFi33ow=; b=tsLUPJLS2N3rALCVwA2t6lT593
	GD9cL90LgdZ2ePs9mg6ccCGkeWTQKm/4zBpsKNbwQjQJND5c26fJEDYFM6WCCcqNKB8CMn44IlHSb
	09+dQNAG1HHBXx2CXo8kggBRpF0bbczK6BwJQhnFPR1jdGV6dG2tGujk980glw2N/sJuCCMedzrnp
	yreRs95Xcn15oYfdgVfk/kdoUjyslT4tGI6SUrO7M5kUOd1BQG1ZoLXK9lhfLEQD4L94kMeHDSarJ
	26iy+Y39Z6fdq/6gNZrq0vOBDbj5t4le2d38JaAXCyUu15zIEYJq6Y6MoZSFeTS+MKaYUUjoPXbFt
	p13WMb6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAFiI-000000026LH-2V56;
	Thu, 23 May 2024 21:11:02 +0000
Date: Thu, 23 May 2024 22:11:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when
 io with IOCB_NOWAIT
Message-ID: <Zk-w5n769fyZWTYC@casper.infradead.org>
References: <20240513132339.26269-1-liuwei09@cestc.cn>
 <20240523130802.730d2790b8e5f691871575c0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523130802.730d2790b8e5f691871575c0@linux-foundation.org>

On Thu, May 23, 2024 at 01:08:02PM -0700, Andrew Morton wrote:
> On Mon, 13 May 2024 21:23:39 +0800 Liu Wei <liuwei09@cestc.cn> wrote:
> 
> > After commit (6be96d3ad3 fs: return if direct I/O will trigger writeback),
> > when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
> > process context will not be blocked.
> > 
> > However, if the device already has page cache in memory, EAGAIN will be
> > returned. And even when trying to reissue the AIO with direct I/O and
> > IOCB_NOWAIT again, we consistently receive EAGAIN.
> > 
> > Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
> > with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
> > the same time.
> 
> Can't userspace do this?  If EAGAIN, sync the fd and retry the IO?

I don't think that it can, because the pages will still be there, even
if now clean?  I think the idea was to punt to a worker thread which
could sleep and retry without NOWAIT.  But let's see what someone
involved in this patch has to say about the intent.

