Return-Path: <linux-fsdevel+bounces-44672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF417A6B3F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDB64825DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9FA1E9919;
	Fri, 21 Mar 2025 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kf2KvaaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D611D5CD7;
	Fri, 21 Mar 2025 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534062; cv=none; b=eVVepYG1LfWC+eWF5MCaxJIlDaw0zCkPxoq4k5COdM7EZvX66oDwwCUEezTMz9hJCUXJ5BM5aGlUpBOHegLk/4q8dkOf8F0tvbRyU6JWa0/Hrh2rwH+iBOGm0wzu7TlowRIHmXluN2l4Dj+oAL6HEhZW7VPE9qE0/yuiRc2nAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534062; c=relaxed/simple;
	bh=kwOkxKV4qTer06lP41Ffd6PSlRNYEP3PWjtpJ0CNkzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoulZZ8uuMf4ZYZpjHiqb5T+loSczqTZddJJhPwFM25fTJHsenavZdj0P8bY/LBAdoAVXHCm7nEezpSscT6Az5TDxaB0PbI7M/nwZFFQNPoVCKGig9A4upMMTivzg8dvS56FpomDUEdIM896REs0Gfbes3L7DL5YayoWgwjx6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kf2KvaaY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rUyXpJNwMUhzMPk5QM3GkvuJrE/4O7e8Ynsm2+/B6s8=; b=Kf2KvaaYATGpCtxdSKU5/6rPCA
	KAkFT3eZmQAkfjf5zy7uXXS82wFhob4doB/KA+43X3dISEqyPawWkrNyBlpoZtdgWVXEmob7h9A2T
	INmhKDoOOCjOrjW4ZSjUvWB03s3OSD+vre15oic0+OgKkwp14Sr/g6/gqSwlMApZNHX6IiM17Op0A
	0pdaXp0Ty2kdgJI3qfEyUskbjjdfeoRtb2GuSsZ2qkpEpR0MO0Y/g0FonmFmXlySGE0zWNjOhaN18
	6K+0taEVWg/lI1bi9TslKaztZnjLhaXpsm7T4I+pdul/sW/3pyTjE0hNQ2c74u6nXUIlDS+1SjHRs
	WTlUT8bw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvUhg-0000000DsHV-1Vd5;
	Fri, 21 Mar 2025 05:13:56 +0000
Date: Thu, 20 Mar 2025 22:13:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com,
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com,
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, jack@suse.cz,
	hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
	ritesh.list@gmail.com, aneesh.kumar@kernel.org, bhelgaas@google.com,
	sj@kernel.org, fvdl@google.com, ziy@nvidia.com, yuzhao@google.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [RFC 1/3] mm: implement cleancache
Message-ID: <Z9z1lC9ppphUhDjk@infradead.org>
References: <20250320173931.1583800-1-surenb@google.com>
 <20250320173931.1583800-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320173931.1583800-2-surenb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 20, 2025 at 10:39:29AM -0700, Suren Baghdasaryan wrote:
> Cleancache can be thought of as a page-granularity victim cache for clean

Please implement your semantics directly instea of with a single user
abstraction.  If we ever need an abstraction we can add it once we have
multiple consumers and know what they need.


