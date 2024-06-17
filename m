Return-Path: <linux-fsdevel+bounces-21824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CCB90B47E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A3E2846C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869C1142652;
	Mon, 17 Jun 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bKvQ9GU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353C13FD8D;
	Mon, 17 Jun 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636920; cv=none; b=NzpLp6aQd/G2kEaRbq1hKdVcEf1ZVBGc4JZC9mALcMYDRT+Fv4N8B00rgUzBLxpTmYGznmJ0PLVEi28K30fWKGvS+dx/i8FFwPqeAbTJ2iFximYXcuBNHBAQO4FIEtT1OQnUSG1ry15GnmVlM0y9J2eKzRQQhFffpjNxsdx1TzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636920; c=relaxed/simple;
	bh=1ZXrRYKtWHtDB6OXL5vleRJGsJqOwCMPVyP1Ec8vH88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIM+7GQonKtPYjO/ubMayRq7Jt9A5ZfRykDN4EFYTqNNVXME8R5RPSjpBNvtP4wFpYgmOd79ZlROKOEWGgcrsxKOkSTWz+4M6/d3pflB1l8nie6eD5rBqZjiOYiyo3FXLsCZMVBmxQB94Lwgf1MQy8VEMLfBg3GG6s59Rj55dpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bKvQ9GU4; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W2tYq1NFmz9sRD;
	Mon, 17 Jun 2024 17:08:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718636911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZmaK3/av/+pYCO8JH+DfV1hFjKuc0xucbwt8WDUoYk=;
	b=bKvQ9GU4432FpITPMwykUykx1s6cXFn0dgCan0zb3jRVjd49al+ISqMn3IZ5bqFKIrM9r9
	oU+wehwV+gD9fmPYL99Aj4P0uTOQPprZ/eD4GvdKiNAgoiNjHwldBAhUza9ZdGrkv2vffB
	luVCyJ1jYCUGieiM+NCsB4/y/wAAis0f20MkJi86Epbffkc3DgYXRqPllJpyJmqGR93TaA
	QXbduQ9zVP8VWnyjFHYeD/sWeJx/zlAVQqylhwpnGlo2vbvUWGbNYJ7YnQJ4JlYvtLLaFH
	zB1lRVAqQxvE8DX05z1qsugqB2uZt1cfk/5eopjdSfHk5Fy+nDMD1zNI34U/rA==
Date: Mon, 17 Jun 2024 15:08:23 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: david@fromorbit.com, chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240617150823.tet4e7y7pco44dw7@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-8-kernel@pankajraghav.com>
 <20240612204025.GI2764752@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612204025.GI2764752@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4W2tYq1NFmz9sRD

On Wed, Jun 12, 2024 at 01:40:25PM -0700, Darrick J. Wong wrote:
> On Fri, Jun 07, 2024 at 02:58:58PM +0000, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index f3b43d223a46..b95600b254a3 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -27,6 +27,13 @@
> >  #define IOMAP_DIO_WRITE		(1U << 30)
> >  #define IOMAP_DIO_DIRTY		(1U << 31)
> >  
> > +/*
> > + * Used for sub block zeroing in iomap_dio_zero()
> > + */
> > +#define ZERO_FSB_SIZE (65536)
> > +#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
> > +static struct page *zero_fs_block;
> 
> Er... zero_page_64k ?
> 
> Since it's a permanent allocation, can we also mark the memory ro?

Sounds good.
> 
> > +
> >  struct iomap_dio {
> >  	struct kiocb		*iocb;
> >  	const struct iomap_dio_ops *dops;
> > @@ -52,6 +59,16 @@ struct iomap_dio {
> >  	};
> >  };
> >  
> > +int iomap_dio_init(void)
> > +{
> > +	zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
> > +
> > +	if (!zero_fs_block)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> 
> Can't we just turn this into another fs_initcall() instead of exporting
> it just so we can call it from iomap_init?  And maybe rename the
> existing iomap_init to iomap_pagecache_init or something, for clarity's
> sake?

Yeah, probably iomap_pagecache_init() in fs/iomap/buffered-io.c and
iomap_dio_init() in fs/iomap/direct-io.c 
> 
> --D
> 

