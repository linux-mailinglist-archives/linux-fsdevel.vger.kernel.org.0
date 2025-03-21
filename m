Return-Path: <linux-fsdevel+bounces-44673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B1FA6B3F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87928188C314
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18191E9B1B;
	Fri, 21 Mar 2025 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1wmiI9+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F31E493C;
	Fri, 21 Mar 2025 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534098; cv=none; b=Ol6B1hGJj2GDJZTzgE6hjMEJkWk2SbHqLzsuvO70xMn043S8K0tYkS0nIwbqKSbae/SuWmcaFj3E0MNnvJcMXeJGI1hRXaPuVkSbruQO0OC6rYggXpQA6AcmQnO0GeL/vkqUnMJ9jP3pb0xdNIa5+Dlzw5wjSv4V4CxyzloPw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534098; c=relaxed/simple;
	bh=xdG9r9zig5930+Z9+K5PrYoRrYhQzmwyeGDldmRg6fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4IxCqx65jsDNo0m/34U/MgSROzar4pBrWfR5PaIcczYQ6VOMDYzsxpLP6y6aA/hcpfqzZuZ7Ii2W8NuEwm3ooP3jC0HhleMufXHWlLDgoze67MRv4AfPZikyose7B1BMbcZckp5EX0yjPBQUIaSEp+B8ALLqjeXfawiDL9FiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1wmiI9+V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fIC/SAXuaviF4kGty41Kn3ZZ26v8zIm5FHzMRtfkfFc=; b=1wmiI9+VZjGjXVJSYgYQgrg6N1
	t5dpCQ9cWL8kFMKwc19IlHoDP7CaQdDWJhrB8p7UjT/s0y+sKqjIWWZfy/VHNp3CoCXALSc7yKnbR
	iI3qfxX9AFYNvdMABaL+ZQ3Wq94cBUX/4ZGjDQpEEqxbCkNaBG9X47Lx3OXVA+GBnEAhNjC+DC1lS
	9h4zNL/fx2G2f6uOLH+8ehqAH5Byvo0FHJOm32VV0yA8YncZ/7GRtxSoOJwwDOOogrYawcbuA9HrH
	c90vZ+beiRPDIl915nDJC97Vd1M1BlHuVnb/zBYhDVi4KK80b5b+/UQQCW5v/Dysa3Uuq8pCi69Sc
	s79lkjwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvUiR-0000000DsQw-3ibf;
	Fri, 21 Mar 2025 05:14:43 +0000
Date: Thu, 20 Mar 2025 22:14:43 -0700
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
Subject: Re: [RFC 2/3] mm: introduce GCMA
Message-ID: <Z9z1w2vHfJrwSgWW@infradead.org>
References: <20250320173931.1583800-1-surenb@google.com>
 <20250320173931.1583800-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320173931.1583800-3-surenb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 20, 2025 at 10:39:30AM -0700, Suren Baghdasaryan wrote:
> From: Minchan Kim <minchan@google.com>
> 
> This patch introduces GCMA (Guaranteed Contiguous Memory Allocator)
> cleacache backend which reserves some amount of memory at the boot
> and then donates it to store clean file-backed pages in the cleancache.
> GCMA aims to guarantee contiguous memory allocation success as well as
> low and deterministic allocation latency.
> 
> Notes:
> Originally, the idea was posted by SeongJae Park and Minchan Kim [1].
> Later Minchan reworked it to be used in Android as a reference for
> Android vendors to use [2].

That is not a very good summay.  It needs to explain how you ensure
that the pages do stay clean forever.


