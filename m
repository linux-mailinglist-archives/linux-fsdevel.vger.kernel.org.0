Return-Path: <linux-fsdevel+bounces-15465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670EB88EE73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 19:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959F41C3324B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231251509BB;
	Wed, 27 Mar 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FsHkB3Ok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0912E1ED;
	Wed, 27 Mar 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565125; cv=none; b=j1JqJ59WNN1JN4fwibY656KwoFoNkq5zD0yq1xI8+oUugjkyVUly0YNyV+ObP4IwrsmVDNx6RpX08HO401lL5Z1JTY2K/meaFEeyA0KLIJbMJSOKw34JA82fFpxGTojTeOklMUltZ0TiliyEldbgGm7dRABWqMVADLh8bqQ9dnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565125; c=relaxed/simple;
	bh=biJi2IrgVq30FOqS2hK3EobFrX84OW9MAMNbFsaV0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6MPiqohL4Ot5PvHL+7ri36OVtcTGkngh5Ex1Y4WXh/r0ENH+SP3jKAgEM7V0VVolhY9g9ztzqfVxCOHqmd3KubM0OPFDQ2PN+jHq7hPYGAKFIeaxXxa6OU/ZOzqkHwj0FBiFwXwwEGcDXLWejxpOQUJ4cYJX5RWjK0qC4EBszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FsHkB3Ok; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jto/UBY8qFeuax+A/OGqBK80cikOQZ4LUK0jo01qdKA=; b=FsHkB3OkZbvW2lIRluP+DvQYvf
	oZF2Vx+216ffdZcTX7SPEY+DrhaoR16macUM0BQ9ipEBL7pt2KI1KrDuisYWoBe5+QdXSBIAguCug
	jVETiIojDCW3h2JAaMqm9Y7WcU4tjfJyqKwJGQkgZsXj6Ghb75RwIUPk2RFlvDniY3cq8OHmLrCVC
	GMMrX1c9UOcPqnUPrdbPwAXAMN/N2Km8/39X7qiw/oYgZNm1r082v4A+l5Hkeb22X300tTDg2k+x+
	pimn0w+kw7PQkid5OR1tbpViET52ntLiFHV1DtYAbvRjBgOyLa6kcSmbplUC/xm73JgT75/JVJxrh
	Y9cTQbag==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpYGz-00000004UtR-2mcl;
	Wed, 27 Mar 2024 18:45:17 +0000
Date: Wed, 27 Mar 2024 18:45:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs: Provide a means of invalidation
 without using launder_folio
Message-ID: <ZgRpPd1Ado-0_iYx@casper.infradead.org>
References: <2318298.1711551844@warthog.procyon.org.uk>
 <2506007.1711562145@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2506007.1711562145@warthog.procyon.org.uk>

On Wed, Mar 27, 2024 at 05:55:45PM +0000, David Howells wrote:
> +int filemap_invalidate_inode(struct inode *inode, bool flush)
> +{
> +	struct address_space *mapping = inode->i_mapping;
> +
> +	if (!mapping || !mapping->nrpages)
> +		goto out;
> +
> +	/* Prevent new folios from being added to the inode. */
> +	filemap_invalidate_lock(mapping);

I'm kind of surprised that the callers wouldn't want to hold that lock
over a call to this function.  I guess you're working on the callers,
so you'd know better than I would, but I would have used lockdep to
assert that invalidate_lock was held.

> +	if (!mapping->nrpages)
> +		goto unlock;
> +
> +	/* Assume there are probably PTEs only if there are mmaps. */
> +	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> +		unmap_mapping_pages(mapping, 0, ULONG_MAX, false);

Is this optimisation worth it?  We're already doing some expensive
operations here, does saving cycling the i_mmap_lock really help
anything?  You'll note that unmap_mapping_pages() already does this
check inside the lock.


