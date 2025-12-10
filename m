Return-Path: <linux-fsdevel+bounces-71043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEABCB272E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 09:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71F273026395
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C5302749;
	Wed, 10 Dec 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GpZ40KU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8D1A4F3C;
	Wed, 10 Dec 2025 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355568; cv=none; b=Ps8fVTiOd/b8ShFvuk4Clzk+Yp7MWZNvQvibR8zw4k/ZA+0CmoN8ZblMNaG7KHTaD44gx8N3TQrRDm2bmSuLmtLHur+gTpA0q0JbNzygslsTF4Zld20b4ignSrNHOiqiWJmjhANG/ueUIdliuqKoXtWjBIxGS3amgLEeWtcYzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355568; c=relaxed/simple;
	bh=RTaTVeMg04YHaQOjbX9jJFyj4G8vBIspppLffXBVHms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gII2g5M8CHDldMeJbIONzY3wzL1uIlKYvPE6057RjZxAoie8Tj+b1QcPuVQUq6DRuZ7jO8yAcBh/lC6YXcURXCKbJu6oqQBb1wkwPV85cOGxx9rMB4kjTvlBrlgmk41BVSrTSLD0j1zgNiXmh9QUbFtThPPKenjdtR1VxRqKscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GpZ40KU2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wEvQcURYapAuWTIomIIzYbWrtAigaNvRekpwUAiJGZM=; b=GpZ40KU2WrUfIhGFZagHFzAGUW
	Y4uWT4ZP7gJMOd7EP/g/ZQ3XvX1dS8GdpnRbtlVQNBPrTjnt5vEuk34oy0t9mqs0cVFNj0OsXGVAc
	33n0c7xB/8fdxzrlky8/Py3lZjzgXiNhya3acF/149fs0zE1HHuzSxEXA3tVkCcBbu3PgYIUiINBQ
	IV+TqWYoZVpxpIOAkeTgqc+ixdwmIZcqErL2o6wc899peMmnnn1pziiupQ+c5Z6BCAjZBBkbf3XOc
	uGGH2GhGkpuVEbq77pNtjJ1+lDD2O0Dm5vVoCsPPzGYE8A223MfhpesBGHYsY+KsqPMz5xJfgXj0q
	e9ndppww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTFcn-0000000FFWW-3MT2;
	Wed, 10 Dec 2025 08:32:41 +0000
Date: Wed, 10 Dec 2025 00:32:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: asmadeus@codewreck.org
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aTkwKbnXvUZs4UU9@infradead.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aTkNbptI5stvpBPn@infradead.org>
 <aTkjWsOyDzXq_bLv@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTkjWsOyDzXq_bLv@codewreck.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 10, 2025 at 04:38:02PM +0900, asmadeus@codewreck.org wrote:
> Christoph Hellwig wrote on Tue, Dec 09, 2025 at 10:04:30PM -0800:
> > On Wed, Dec 10, 2025 at 06:04:23AM +0900, Dominique Martinet via B4 Relay wrote:
> > > From: Dominique Martinet <asmadeus@codewreck.org>
> > > 
> > > When doing a loop mount of a filesystem over 9p, read requests can come
> > > from unexpected places and blow up as reported by Chris Arges with this
> > > reproducer:
> > > ```
> > > dd if=/dev/zero of=./xfs.img bs=1M count=300
> > > yes | mkfs.xfs -b size=8192 ./xfs.img
> > > rm -rf ./mount && mkdir -p ./mount
> > > mount -o loop ./xfs.img ./mount
> > 
> > We should really wire this up to xfstests so that all file systems
> > see the pattern of kmalloc allocations passed into the block layer
> > and then on to the direct I/O code.
> 
> Note this doesn't seem to reproduce on my test VM so I'm not sure what
> kind of precondition there is to going through this code...

In general the best way to get XFS issue kmalloc I/O is to use a
file system sector size smaller than the page size, і.e. something
like:

   mkfs.xfs -s 512 -b 4096 -f

The above would do that job when run on a large page size system
like typical arm64 configs.

> > And 9p (just like NFS) really needs to switch away from
> > iov_iter_get_pages_alloc2 to iov_iter_extract_pages, which handles not
> > just this perfectly fine but also fixes various other issues.
> 
> Ok, so we can remove the special branch for kvec and just extract pages
> with this.

Yes.

> I understand it pins user spaces pages, so there's no risk of it moving
> under us during the IO, and there's nothing else we need to do about it?

Yes, unlike iov_iter_get_pages_alloc2 which gets a reference and doesn't
pin.

> Looking at the implementation for iov_iter_extract_bvec_pages() it looks
> like it might not process all the way to the end, so we need to loop on
> calling iov_iter_extract_pages()? (I see networking code looping on
> "while (iter->count > 0)")

Yes.

> I'll send a v2 with that when I can

You looked into this already, but in case you haven't seen it yet,
don't forget to call unpin_user_folio on the completion side as well.

> While I have your attention, there's some work to move away from large
> (>1MB) kmalloc() in the non-zerocopy case into kvmalloc() that might not
> be contiguous (see commit e21d451a82f3 ("9p: Use kvmalloc for message
> buffers on supported transports") that basically only did that for
> trans_fd), there's no iov_iter involved so it's off topic but how would
> one get around "extracting pages" out of that?

vmalloc and I/O is in general problematic, because you need special
calls to flush the cached for VIVT caches:
flush_kernel_vmap_range / invalidate_kernel_vmap_range.

If you want to stuff that into an iov_iter, the only sane way is to
call vmalloc_to_page and build a bvec iter from that at the moment.
You also need to do the flush_kernel_vmap_range /
invalidate_kernel_vmap_range in the caller for it.


> 
> > Note that the networking code still wants special treatment for kmalloc
> > pages, so you might have more work there.
> 
> I *think* we're fine on this end, as it's just passing the buffers into
> a sg list for virtio, as long as things don't move under the caller I
> assume they don't care...

Ok, if your backend is virtio that's fine.  If it's actual 9p over the
network you might still into issues, though.


