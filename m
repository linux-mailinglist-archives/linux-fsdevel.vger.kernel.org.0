Return-Path: <linux-fsdevel+bounces-9802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE87845055
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 05:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A89283EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BCA3BB21;
	Thu,  1 Feb 2024 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YkF4gx7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5561E49E;
	Thu,  1 Feb 2024 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762174; cv=none; b=uN1AlZukPaYnCZPlsOLd1tWKiuCB05dkkNaFF+6VjJ0BJ3SgEKFOPRv8r8ot2soROzeZX3AyjV2vVZ690vZ1FkpceK2l0nE9Lt+eBraSvmEetQHt2wN8KDTZIgaZhYHbZbv+8iUNMch0FLw8IK8Pwp+kW3FiPRM8/vneYD+fn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762174; c=relaxed/simple;
	bh=OEVOo8eim3R2lQTiss86sxtGriI0aMzNy5LhI1J134Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXQK4H4lWmvc5YoNuO9tv4SEm90xf6eIt7o7SxkMpIX8+BUrjJ1aDTv+sFj8kO4uG0eF4lRxcmZewPvy8YdQYHRYjCBPgNBq2gfzjwESccQy+I9O0oG+q05SS5lAvXtReU6+48HLUDuBKTrj+sS2k76c2vx4f7SyZBcx8wWscxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YkF4gx7E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BbO75Sa4lpAGLFf065Gk/ztVsKTvZhbTbKkiiGsMvNI=; b=YkF4gx7EoH6YK7VhQBwE7/fbdO
	VvdeJvR6RWeF2cZ/DZBy3B9zx6t1A7brIxv36MUcwRkdKUqoMVnlWaOEqFJyUbRPkqPddks8htZRm
	39ax8SCSNdxdLXgy8IyRk+pLoVG7eduAOii0BoiemiRSmJFh/YHYv/VOpivwNjK6LoWhP94ZaRtJA
	RBbtCY8hnVrjQrmjPEU09jjyo38OFjpTacA8NHSx35RDvNyjZQ8osV0V+CIWBKquMnYn3OJLAL0um
	30Re0IV5NsPcpDmpxUak/v3QX1K3S/LdfqGaYiJdlH+Eh+QBlQ0IYV8d6W0aCXhgRwzFyoeJezfXT
	znoqLuOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVOo5-0000000Er0V-3wtu;
	Thu, 01 Feb 2024 04:36:10 +0000
Date: Thu, 1 Feb 2024 04:36:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: Introduce buffered_write_operations
Message-ID: <ZbsfuaANd4DIVb4w@casper.infradead.org>
References: <20240130055414.2143959-1-willy@infradead.org>
 <20240130055414.2143959-2-willy@infradead.org>
 <20240130081252.GC22621@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130081252.GC22621@lst.de>

On Tue, Jan 30, 2024 at 09:12:52AM +0100, Christoph Hellwig wrote:
> > +struct buffered_write_operations {
> > +	int (*write_begin)(struct file *, struct address_space *mapping,
> > +			loff_t pos, size_t len, struct folio **foliop,
> > +			void **fsdata);
> > +	int (*write_end)(struct file *, struct address_space *mapping,
> > +			loff_t pos, size_t len, size_t copied,
> > +			struct folio *folio, void **fsdata);
> > +};
> 
> Should write_begin simply return the folio or an ERR_PTR instead of
> the return by reference?

OK, I've done that.  It's a _lot_ more intrusive for the ext4
conversion.  There's a higher risk of bugs.  BUT I think it does end up
looking a bit cleaner.  I also did the same conversion to iomap; ie

-static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
-               size_t len, struct folio **foliop)
+static struct folio *iomap_write_begin(struct iomap_iter *iter, loff_t pos,
+               size_t len)

with corresponding changes.  Again, ends up looking slightly cleaner.

> I also wonder if the fsdata paramter should go away - if a fs needs
> to pass forth and back fsdata, generic/filemap_perform_write is
> probably the wrong abstraction for it.

So I could get rid of fsdata in ext4; that works out fine.

We have three filesystems actually using fsdata (unless they call fsdata
something else ...)

fs/bcachefs/fs-io-buffered.c:   *fsdata = res;
fs/f2fs/compress.c:             *fsdata = cc->rpages;
fs/ocfs2/aops.c:        *fsdata = wc;

bcachefs seems to actually be using it for its intended purpose --
passing a reservation between write_begin and write_end.

f2fs also doesn't seem terribly objectional; passing rpages between
begin & end.

ocfs2 is passing a ocfs2_write_ctxt between the two.

I don't know that it's a win to remove fsdata from these callbacks,
only to duplicate __generic_file_write_iter() into ocfs2,
generic_perform_write() into f2fs and ... er, I don't think bcachefs
uses any of the functions which would call back through
write_begin/write_end.  So maybe that one's dead code?

Anyway, I'm most inclined to leave fsdata andling the way I had it
in v1, unless you have a better suggestion.

