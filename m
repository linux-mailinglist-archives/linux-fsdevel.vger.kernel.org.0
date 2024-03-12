Return-Path: <linux-fsdevel+bounces-14200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E087940B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0910E284BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FC77A136;
	Tue, 12 Mar 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jl3fKkjo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6DBA28;
	Tue, 12 Mar 2024 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246106; cv=none; b=BswiiX21mSzDltVZs2q1TpInP9eQlqnX89ZenRUkxod9aFRF+QA8lP7s0UAGX6g8IY3WM0VKCYFkdBeo373H9v45QdJwvz+vm5oVTy4B4VyEAHJhrVHX0562U+BQ2LI17JqCTa4Am3mfdisef3JDaAnbo3+jNb9FtDTksLNeB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246106; c=relaxed/simple;
	bh=PRHWmlunvFb/pRfUsLAeTv57hVkovzdTkLol1agdvUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0UVIF/cJNlo24MwjvUEq7PeCsE8RXW4AD616fWrJ029vAB4gfUD28XWxHqeril+1cLhmpjKjXVHWQvw+1MQWctQUvhsbf4ZNm2V+YrPX6+mn6CQsgal9PFdUQpOEP0EJ1yG/XM/Akfwkfnh1OFGKkYHJivCt+4puVzJ1fScIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jl3fKkjo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Thwm6eWyU+1fiGj99ssaAe6TjuTB15OZV9JAlunu2s=; b=jl3fKkjo8VwqfsRjRM5aU5Rcpn
	LUPPMetFNgZXWAxH0WtthDTdP745OWuDz9XV/W3/4FMLEeuO/2jM9V3Max3KNqcZur2xpsB2wRGMK
	193eVtKJN/Pw/8i4rb1uVzZKwglFmQf8/ZcHYQpfZU24P6SL3qxn3cWRj4hf7fb1EMl4/JNp33se2
	GT4rN8pwJjsqUiqzOV61wIe/SNbq3StwCDkGDxrHU96GbzoacvKVerakdAIDHWSGY2pIs8e32rZM2
	KPaZ7vh+wbqWgFxw3zKdCk2kJh7ZXN0qgIm60v25DKQieTFZn2+Hd9zmDYh8vuOC7tJpS33v3ntMW
	LX6oKaRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk18Y-00000005igE-0oWv;
	Tue, 12 Mar 2024 12:21:42 +0000
Date: Tue, 12 Mar 2024 05:21:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, brauner@kernel.org, david@fromorbit.com,
	tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/4] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <ZfBI1l2l3TWw0tMV@infradead.org>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-3-yi.zhang@huaweicloud.com>
 <20240311153737.GT1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311153737.GT1927156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 11, 2024 at 08:37:37AM -0700, Darrick J. Wong wrote:
> > +convert_delay:
> > +	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
> > +	xfs_iunlock(ip, lockmode);
> > +	truncate_pagecache_range(inode, offset, XFS_FSB_TO_B(mp, end_fsb));
> > +	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
> > +				       flags, &imap, &seq);
> 
> I expected this to be a direct call to xfs_bmapi_convert_delalloc.
> What was the reason not for using that?

Same here.  The fact that we even convert delalloc reservations in
xfs_iomap_write_direct is something that doesn't make much sense
given that we're punching out delalloc reservations before starting
direct I/O.


