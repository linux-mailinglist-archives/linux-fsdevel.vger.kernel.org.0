Return-Path: <linux-fsdevel+bounces-20633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89268D6437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC02290745
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA17B15D5A0;
	Fri, 31 May 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pWPviTlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983C158D90;
	Fri, 31 May 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164788; cv=none; b=aVtsb9rjMJp7eVZZrqVH6xXTuiNba6kG03TPF0ezOKPL7ttfm3z7ZeF/N3VrlTymKA5eXcKUvfwGzSM2t87zxk7PF5VU3wxiy67jvrLYzGHxdZ2kGTEo29jfl/ZZQVw6JuuFS0Ujbtf6HuvA7+ALjJHJc47H4QDOdAHCqV3zPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164788; c=relaxed/simple;
	bh=6JJ5ps6ZIamaEEyye+8WpVUCDosh5IsJAEyqH8a4Fmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1VLZvv/qlUYtGDWcpYx6jLWg9vFMu6zwn7rIMK0EelGlFRs/kNnIWRzWtMntUNYYLveH3zdeu9aChtbRTLSNuyDXuKfCpWHw+l/BANxaKcuZpCjRSAClxc4yhoLV65X67pa9rjNEJ+nbMZ/K2mZgvZFbiikvNi7u0axKXscQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pWPviTlx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vEbj/mPHsn3QcnUqRh59ks+EW1Vdv9n1ac8MDEZPrrQ=; b=pWPviTlxvg29CjNkTECFhr47YG
	nRivkSATijfbywLe03+rw4GNVCGeQ15cv7AIgdUmhE2iazinrir3C2rRq5jFnF3S1xSDLtDVXZfJW
	lD1GJ4SK38IgV+1Bcl/3pjIE1qPTIG944rQNlga9GdcXM5fHGPfVWMnGCKIE3ctuyqmuJAH001juR
	R7P8erk68r/HKP5rrTcygDoidrpR8iM3bpUeN77vW7GxwCDOvBFNA+2X7RxseZZWHFW4PtNJUsU1D
	IGyIzNpXJwbljNMQ1gmryvZjcBPZG8QJhNHtbBPlwfl2xDjK5DhTtss9QVyMGMqUTk1y5dMJML8mh
	aAb+OFPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD30D-0000000AT9z-3lqQ;
	Fri, 31 May 2024 14:13:05 +0000
Date: Fri, 31 May 2024 07:13:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 7/8] xfs: reserve blocks for truncating realtime
 inode
Message-ID: <Zlna8S76sbj-6ItP@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-8-yi.zhang@huaweicloud.com>
 <ZlnFvWsvfrR1HBZW@infradead.org>
 <20240531141000.GH52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531141000.GH52987@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 31, 2024 at 07:10:00AM -0700, Darrick J. Wong wrote:
> On Fri, May 31, 2024 at 05:42:37AM -0700, Christoph Hellwig wrote:
> > > -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > > +	resblks = XFS_IS_REALTIME_INODE(ip) ? XFS_DIOSTRAT_SPACE_RES(mp, 0) : 0;
> > 
> > This probably wants a comment explaining that we need the block
> > reservation for bmap btree block allocations / splits that can happen
> > because we can split a written extent into one written and one
> > unwritten, while for the data fork we'll always just shorten or
> > remove extents.
> 
> "for the data fork"? <confused>
> 
> This always runs on the data fork.  Did you mean "for files with alloc
> unit > 1 fsblock"?

Sorry, it was meant to say for the data device.  My whole journey
to check if this could get called for the attr fork twisted my mind.
But you have a good point that even for the rt device we only need
the reservation for an rtextsize > 1.


