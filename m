Return-Path: <linux-fsdevel+bounces-50506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55CBACCAE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 18:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EFF17687F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6823D298;
	Tue,  3 Jun 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OluYoGGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67972605;
	Tue,  3 Jun 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966531; cv=none; b=i7FrN8rM9ESqiplNlWKC0ZqKlKomb3T+jnAA7OAM1zvwOWey9NfDgUH/Ty4wPwSLR5y1Q76LG+KnBIpktfBpjWyfBuQv3W/q0ObsisxTV8RJ9yAqQv9RRgHZWitdrNAYQxlhmUxYG1QeyJ62w/J6Fhn+QItabMb8hDk05zKjgM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966531; c=relaxed/simple;
	bh=utGGHye6zuMyX2IqEOVmv3+Md9E7v87JO8RTvtptp4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiHDy98mmW+haaLt4hlR3krye0GUsmDuxIeYlyntyTdV69OZBMPPWu37M/z6KQT2ajzOSEWvz2Xhb0RCoKgqkmiY+PAniyZ5Abu5yd0bQibT/l0tbGrVMFPHMu/64UXAFedTSODj83WVIfXDTVunvbbkB5fiPLbcglCnwodC118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OluYoGGV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lqpA2obXAEGYiV7llfEv48yhrGfp0onTICfwh/ANc24=; b=OluYoGGVKqLlm6rzxdjM4LhMQ1
	eOPz3SupE+Bw9ysysO+kM/cAgvP06gWwIbzC4/e4gASjwVugANssBjc40YPUGAx+Pj/cmjG3+82q5
	ArJv2MFY9l9APkjyj+Yoq3yRmcH4NTq6C8N7+2xDqz76XDB+kn3u2iRial5JhXnskyYxuwaozZLDK
	86nULefboRLcSVdt6e0PZk4PZPJNI/v2PdtKLZ9GxYdJtdmt/bXzjlJ5pPNkX0MbOyih2PJE2o/JN
	5iAGN7D8oW5lzjB+iOXUn0QOl0bteQbmcnNIdnGqC+cRk6GyHKpthYQeF10F4Y/qlSP7eOdt5Vl6m
	oPf9mjfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMU5P-0000000BMWf-1H2s;
	Tue, 03 Jun 2025 16:01:59 +0000
Date: Tue, 3 Jun 2025 09:01:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>, wangtao <tao.wangtao@honor.com>,
	sumit.semwal@linaro.org, kraxel@redhat.com,
	vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	amir73il@gmail.com, benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
	jack@suse.cz, baolin.wang@linux.alibaba.com,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	bintian.wang@honor.com, yipengxiang@honor.com, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Message-ID: <aD8cd137bWPALs4u@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <924ac01f-b86b-4a03-b563-878fa7736712@amd.com>
 <aD8Gi9ShWDEYqWjB@infradead.org>
 <d1937343-5fc3-4450-b31a-d45b6f5cfc16@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1937343-5fc3-4450-b31a-d45b6f5cfc16@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 05:55:18PM +0200, Christian König wrote:
> On 6/3/25 16:28, Christoph Hellwig wrote:
> > On Tue, Jun 03, 2025 at 04:18:22PM +0200, Christian König wrote:
> >>> Does it matter compared to the I/O in this case?
> >>
> >> It unfortunately does, see the numbers on patch 3 and 4.
> > 
> > That's kinda weird.  Why does the page table lookup tage so much
> > time compared to normal I/O?
> 
> I have absolutely no idea. It's rather surprising for me as well.
> 
> The user seems to have a rather slow CPU paired with fast I/O, but it still looks rather fishy to me.
> 
> Additional to that allocating memory through memfd_create() is *much* slower on that box than through dma-buf-heaps (which basically just uses GFP and an array).

Can someone try to reproduce these results on a normal system
before we're building infrastructure based on these numbers?


