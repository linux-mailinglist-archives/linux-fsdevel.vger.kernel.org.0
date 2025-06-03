Return-Path: <linux-fsdevel+bounces-50496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425BFACC91A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E021918861EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15DF239E65;
	Tue,  3 Jun 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CafIKnhM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29043E47B;
	Tue,  3 Jun 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960918; cv=none; b=U7gLhDwBQ0H+Dv0jnM8ko5tor1x2ObIkYoNA7WoEHE59EPfyLX1iHT0e78ZM82D1WtH8VA7eaRgikkL4hvqxudBoYXlfdJFJ/9zrhy2rGnDTTQjN9gQkMQAId9hU8UhrCvRSsconIX8P4xbXdZlP0DlOw/kPZzKZkTjirKuj2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960918; c=relaxed/simple;
	bh=m5XIq5RIlUaWirh4C/5WCxMUv5LGKm0wzhHqzU3F/rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYWM8XTLimuO3IbaQtzrsO4+1cF1+yX88Dwn4HQqpSdnDdTUAOxWnIhidJKn3ym1U73qYNDBjeUMEjORxa5Sd0hfbsmm13gCU6BtFoDOtYivbAnG4DzyFx84IzapxW9NKIEt0Rm5wzfCKzD0X/cpTlPSYlgu58eV0yjyU4SvDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CafIKnhM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NWF/m+whQ9NAjVENjezimZjEsDuS6u9BY+WJdI7HJ7o=; b=CafIKnhMe1WPVgL4WKM41su/Ak
	E7StKkX2E1DEcMgLjvKFH/jd78ALjQwMvnEcq2P20jUG97qs78yniKMQ/v65O78Dbtsj3E/JIbAwD
	qBvI+1Xo5mol3tHN8hJPdDkjYQ+NcVqva+GiyMYfbsWSSdvQITjgXQ+NONKG9yyyDskWO1zV6WYaW
	3CK8l67Bw+lyoryEGXw6MBrV6UHzwr5BYek6FMPiOMWUHY9velz2syJfrB59U3Sg8aSi45YYFtCit
	8SMyRKwdhXhKYejhw9B7shM+qiUa65uktVt+/kqQ0+IPf426MgY99owDskiPpJKRu1CeRXvxodpuD
	Sjytdo/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMSct-0000000BAHP-1w1p;
	Tue, 03 Jun 2025 14:28:27 +0000
Date: Tue, 3 Jun 2025 07:28:27 -0700
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
Message-ID: <aD8Gi9ShWDEYqWjB@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <924ac01f-b86b-4a03-b563-878fa7736712@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <924ac01f-b86b-4a03-b563-878fa7736712@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 04:18:22PM +0200, Christian König wrote:
> > Does it matter compared to the I/O in this case?
> 
> It unfortunately does, see the numbers on patch 3 and 4.

That's kinda weird.  Why does the page table lookup tage so much
time compared to normal I/O?

> My question is rather if it's ok to call f_op->write_iter() and 
> f_op->read_iter() with pages allocated by alloc_pages(), e.g.
> where drivers potentially ignore the page count and just re-use pages
> as they like?

read_iter and write_iter with ITER_BVEC just use the pages as source
and destination of the I/O.  They must not touch the refcounts or
do anything fancy with them.  Various places in the kernel rely on
that.


