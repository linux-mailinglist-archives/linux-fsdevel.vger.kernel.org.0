Return-Path: <linux-fsdevel+bounces-50963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47FAAD1808
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A835B3A5370
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 04:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE1280A52;
	Mon,  9 Jun 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rHP7I9UU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F589254AFE;
	Mon,  9 Jun 2025 04:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443736; cv=none; b=knVOHvctV/sDsYiHkQVmi4J4bKJfIS7HqYTY2n3CyB68bkGRVEZT/N0dF29TlKT/3GmLhnp7e2h6n75Sxayo/slwlhLGK6mPl9mzjT6Gz4qogAzkBfp1ARam3Pf3XgmbQfzMgHUq3l9WLH3LR9S2Ic50IMZ9ZyQJfFS8w/TDXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443736; c=relaxed/simple;
	bh=AgURGmBZPaSkRmiRoqHFlFPIJprX/0ieU7uX6Ixit90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQT6+OKEZkfqxEplIFE8HVlaWXSANjMvf8nRW51a84JdNP2QNYllQ4b/dpxA44PTrWbTY+k/LRb6/EztudAGBeNW+TPl+G48n0dDRJz70AwpcZ/rR4HLzW4CJQSNI0Q640rRkG5a07/l2hCmyU2m85TMxeqp0pMa1Hy/GpczE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rHP7I9UU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oeT73a0Hi9cOPyGYRSLUMdSjrVNXI7sw9Uk+bmyEzn8=; b=rHP7I9UUuAQAw0byw2iIpo1lFJ
	zvbVPtfIVNEnDvZ9E1i3kI/uUWfH3Lg4IFfJamPPveKy03Ptn8AT5+IuiPsJ7Gyj1eLYvV75kkky/
	KwEenybj6HmEa1IyjFVizqFwSAnml8QPm1xdo5gomYU6y2sIPE3yqFTe86Dt5WnAL4OmASNCKIv+1
	NlmPjRydtMGYf+nz6hNKwgJbXio3bde8bWS1ewqdobg5JeCyxqwY3UhWGBuSBlgamJ98mC3IyE4eX
	gvBIUrrc3DfdJkX6pLBCFDhVX3Fftro4JvRfYYVf73aJ8wi9Jo0li4WYB/42oSfqwWDkVP2Xm571M
	rMrSru6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOUEG-00000003PoK-2Bfw;
	Mon, 09 Jun 2025 04:35:24 +0000
Date: Sun, 8 Jun 2025 21:35:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: wangtao <tao.wangtao@honor.com>, Christoph Hellwig <hch@infradead.org>,
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
	"jstultz@google.com" <jstultz@google.com>,
	"tjmercier@google.com" <tjmercier@google.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"wangbintian(BintianWang)" <bintian.wang@honor.com>,
	yipengxiang <yipengxiang@honor.com>,
	liulu 00013167 <liulu.liu@honor.com>,
	hanfeng 00012985 <feng.han@honor.com>
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Message-ID: <aEZkjA1L-dP_Qt3U@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <5d36abace6bf492aadd847f0fabc38be@honor.com>
 <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 06, 2025 at 01:20:48PM +0200, Christian König wrote:
> > dmabuf acts as a driver and shouldn't be handled by VFS, so I made
> > dmabuf implement copy_file_range callbacks to support direct I/O
> > zero-copy. I'm open to both approaches. What's the preference of
> > VFS experts?
> 
> That would probably be illegal. Using the sg_table in the DMA-buf
> implementation turned out to be a mistake.

Two thing here that should not be directly conflated.  Using the
sg_table was a huge mistake, and we should try to move dmabuf to
switch that to a pure dma_addr_t/len array now that the new DMA API
supporting that has been merged.  Is there any chance the dma-buf
maintainers could start to kick this off?  I'm of course happy to
assist.

But that notwithstanding, dma-buf is THE buffer sharing mechanism in
the kernel, and we should promote it instead of reinventing it badly.
And there is a use case for having a fully DMA mapped buffer in the
block layer and I/O path, especially on systems with an IOMMU.
So having an iov_iter backed by a dma-buf would be extremely helpful.
That's mostly lib/iov_iter.c code, not VFS, though.

> The question Christoph raised was rather why is your CPU so slow
> that walking the page tables has a significant overhead compared to
> the actual I/O?

Yes, that's really puzzling and should be addressed first.


