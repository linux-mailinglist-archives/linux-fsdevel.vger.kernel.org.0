Return-Path: <linux-fsdevel+bounces-63715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85ABCB700
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 04:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 964EA4EC265
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073C23D28C;
	Fri, 10 Oct 2025 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v2KuPb7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB521CC4B;
	Fri, 10 Oct 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760064015; cv=none; b=Un5SiGBvQrCHGiABVQT9HyaesTF4K8PdjVsI+e8fKi3woAWksv59a+pn7nJMpGf/3ch3fuUzD7z166YwIO9SrziT9GFdSrlB8CQNpTenubc7TAMjFWz0TiEctVD8WX2s/XqjXNne6o73jrp7EMs++5N/ihwKxUEjnCQ/wYh9yIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760064015; c=relaxed/simple;
	bh=+O5fD/fAvfcINgglSqBg1fQcHMPTu+YnoaXoYPykJP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGA9/OB7NuYsrwoLCGb+PDFKW8HGYixefzdH7PW3NbISOE9D72Mj3Nrb4qlLqTtbz3cM5nJ9QPGSQ5lOcMNENFUoOr4bJapseKb3UcLcWCc/p0WHFAnKTllky3qyBH8cXDBByCyqikOPDGWHYg8rXcooHHdoVC9vgiqs1F4H9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v2KuPb7+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5nEgPiwNZqJY/+pI9FIhkXYcYvcHnRfvZ3w5CnVMM8Q=; b=v2KuPb7+X3CquJ8kc7LUjH9LyU
	lXhmAD0NZIy8B9cVZIjPqtRCU/mTL197+QHuEWB+JvZi2dHdt8x+oVEoohFVJ/5/bofowuOY8cw1+
	W34mQIV8jcJfn7f+m/Le//QjkQPy8/PTr/EH9kIbgc34HGov9DcIe1eG1s+6P0btLYxQ8YZcmk7UI
	CpP7lSE3KDiwpMZo11L++VW+5WIapejtvBwxr8R5ZrvfooDPB3H0NRJmmcxHYoeiCiHwvFL4jJ/V+
	w3dCKWfggOWZqSlGPX4XpmPp85/yLo1n6Gd3tA62nu50W5JHRYbTv6ucOwQ847lT4yro+jr1hgrmG
	YWdN3oBA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v732r-00000002Scf-3b0v;
	Fri, 10 Oct 2025 02:39:49 +0000
Date: Fri, 10 Oct 2025 03:39:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com,
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com,
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, jack@suse.cz,
	m.szyprowski@samsung.com, robin.murphy@arm.com, hannes@cmpxchg.org,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	minchan@kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev,
	Minchan Kim <minchan@google.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
Message-ID: <aOhx9Zj1a6feN8wC@casper.infradead.org>
References: <20251010011951.2136980-1-surenb@google.com>
 <20251010011951.2136980-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010011951.2136980-2-surenb@google.com>

On Thu, Oct 09, 2025 at 06:19:44PM -0700, Suren Baghdasaryan wrote:
> +	/*
> +	 * 99% of the time, we don't need to flush the cleancache on the bdev.
> +	 * But, for the strange corners, lets be cautious
> +	 */
> +	cleancache_invalidate_inode(mapping, mapping->host);

Why do we need to pass in both address_space and inode?

> +/*
> + * Backend API
> + *
> + * Cleancache does not touch page reference. Page refcount should be 1 when
> + * page is placed or returned into cleancache and pages obtained from
> + * cleancache will also have their refcount at 1.

I don't like these references to page refcount.  Surely you mean folio
refcount?

> +	help
> +	  Cleancache can be thought of as a page-granularity victim cache
> +	  for clean pages that the kernel's pageframe replacement algorithm
> +	  (PFRA) would like to keep around, but can't since there isn't enough

PFRA seems to be an acronym you've just made up.  Why?

> +struct cleancache_inode {
> +	struct inode *inode;
> +	struct hlist_node hash;
> +	refcount_t ref_count;
> +	struct xarray folios; /* protected by folios.xa_lock */

This is a pointless comment.  All xarrays are protected by their own
xa_lock.

> +static DEFINE_IDR(fs_idr);

No.  The IDR is deprecated.  Use an allocating XArray.

> +/*
> + * Folio attributes:
> + *	folio->_mapcount - pool_id
> + *	folio->mapping - ccinode reference or NULL if folio is unused
> + *	folio->index - file offset

No.  Don't reuse fields for something entirely different.  Put a
properly named field in the union.

> +static void folio_attachment(struct folio *folio, struct cleancache_inode **ccinode,

Unnecessarily long line


