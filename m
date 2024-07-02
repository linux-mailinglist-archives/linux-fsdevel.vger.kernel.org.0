Return-Path: <linux-fsdevel+bounces-22962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B4C9243F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F630284469
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10691BD512;
	Tue,  2 Jul 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aj1qMLLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B71509AE;
	Tue,  2 Jul 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939122; cv=none; b=oFzixGUkMuAOYL19OvzH8YXRFuBRzCh5+VnxHJcBKs1QNyyawukzR6K8IoQ5n0MTQ3t/baORBDw6XJSrb+rLXYlDSyAMtmErGZqd5Vcs59hTA+e+qta3nRbJau0hb4ZiF8VrMfS39VekakEO5nq7bftWlPC0bD6jPQcO/9yrbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939122; c=relaxed/simple;
	bh=GCRqDVLCekcBX56SlIiYsghqaVoGPKvF7IxMxfLjxFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9akIWLlpk+Gef/Hsg9xR7aucWhTDX+OxY8kMKTxOzt8ifXdLupymcXxrS4BKQ2LeYyUrB7Kx+OZ1H27MQApwawXPXMiMObyYiAf+JR41D07aPwtLSlw0K8u/6p/2mE9Xydh1q0z7Q84BgRYhNiqd4F9cDP5+8Nxa36Utrd0qhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aj1qMLLz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t7a/aHEDbr14CJa/+qvpFMgVsA/T3gcImqxhM0zCkOk=; b=aj1qMLLz45jfsjGgj3OABoFYSY
	XY+0xFseGxJzE8ONLBlJtdBF3IdVifKJr/bG03yY6f/KA9aq+TqbhUw9sXH5/a/JUV5Fis1nwhj8Y
	lzHLKxD9MA0vx83hW+lV5CjDITJXQkHhFQjNLwgNFy0XwU2CycPspT1hh5yMi931AhAkR5zM6qQ95
	EIbp2N0xGY+c5K9sB1CtbJooSLTIBpKuFyq8aW9GNrw7DhLGbl/zkIMbFdIpAa2TykQkK1EGAFoTC
	bZxujctftCqYGsTRDps3U98p6YpYESSLqoo2NurKHjyaUHIbfZMFXcpWkEkXSh9ZUzsXfNnyQ+MG2
	R+TaRBlw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOgjT-00000000xhV-0F3Y;
	Tue, 02 Jul 2024 16:51:55 +0000
Date: Tue, 2 Jul 2024 17:51:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@lst.de>, david@fromorbit.com,
	chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZoQwKlYkI5oik32m@casper.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
 <20240702074203.GA29410@lst.de>
 <20240702101556.jdi5anyr3v5zngnv@quentin>
 <20240702120250.GA17373@lst.de>
 <20240702140123.emt2gz5kbigth2en@quentin>
 <20240702154216.GA1037@lst.de>
 <20240702161329.i4w6ipfs7jg5rpwx@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702161329.i4w6ipfs7jg5rpwx@quentin>

On Tue, Jul 02, 2024 at 04:13:29PM +0000, Pankaj Raghav (Samsung) wrote:
> On Tue, Jul 02, 2024 at 05:42:16PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 02, 2024 at 02:01:23PM +0000, Pankaj Raghav (Samsung) wrote:
> > +static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> > >                 loff_t pos, unsigned len)
> > >  {
> > >         struct inode *inode = file_inode(dio->iocb->ki_filp);
> > >         struct bio *bio;
> > >  
> > > +       if (!len)
> > > +               return 0;
> > >         /*
> > >          * Max block size supported is 64k
> > >          */
> > > -       WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);
> > > +       if (len > ZERO_PAGE_64K_SIZE)
> > > +               return -EINVAL;
> > 
> > The should probably be both WARN_ON_ONCE in addition to the error
> > return (and ZERO_PAGE_64K_SIZE really needs to go away..)
> 
> Yes, I will rename it to ZERO_PAGE_SZ_64K as you suggested.

No.  It needs a symbolic name that doesn't include the actual size.
Maybe ZERO_PAGE_IO_MAX.  Christoph suggested using SZ_64K to define
it, not to include it in the name.


