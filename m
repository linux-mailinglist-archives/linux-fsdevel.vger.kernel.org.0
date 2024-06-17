Return-Path: <linux-fsdevel+bounces-21818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D290AE05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E831F25227
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FA8195982;
	Mon, 17 Jun 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U+KFuh8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C94194092;
	Mon, 17 Jun 2024 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627649; cv=none; b=KydYi/oxWhjDvDy2b2dMv6bFP5y4IsEJdDdRa20FfmAtUjlTxSlqN6kZU18OAgKek6wkOUMGnK76gYT8aYjMmCvHbVj+xsamsdM1OAJ427Pp7jdORYVLX6hoGjeINTcV81hMaLF80RkOEeLPy0elu4I222lNf36IT5XoTMq2/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627649; c=relaxed/simple;
	bh=OonDC7q0u9m4bfDOaE0WiGD+DunAW8aGkxhtJGHxBdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm7p/WJJcwfRHmPCMXS6IV2vLRT88wE4Ink9ZkfdbbTCWx2rpyKvN9N4mQa5PyiBzJg+lbtG72tj5xk9KChvU6+rfQKdqYfJuhxH4TjLjOMuQgznggbJne4Y7THe1z7K0XlQni6SRwveoLAGBJqnBVgcDSupsD9BR+tsTO4Wqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U+KFuh8i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QIdj58YSbWlowQQfpDW0/F1qubf3+B8kLfjRnCazjV0=; b=U+KFuh8iTbywqqqr8zcYxkkzUA
	cq2/xOyvPt7oLgZDoUA8wSYNhDzfu9Dqt8a2fjxh6HEEvB5DEcn4e2dqn63CI/lBpdbmT2BML40Pf
	Lid8P5UOTwcjrOaPy2yeBVQBY6zWhdDUZyn4U7SNWfOY34g0hwul097oRi92D/DOgUqNVLU1Q7THl
	idJOFJb2Cw4bH5zZQe0fsxXADMiMMZ1DFmH5JSnbX4cfCeXsHwcuQ08bteO7HF8l+YIFrUO8Bbez0
	TbMzsNUhq8Bdvf861gjNQ3AuWAQPXSad79gQB1FuhEAUyxWL9FbkZCwgiF/R3gMZMOklT0mLZYOP3
	2qTN844Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJBYg-000000027Pj-0WKA;
	Mon, 17 Jun 2024 12:34:02 +0000
Date: Mon, 17 Jun 2024 13:34:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@lst.de>, david@fromorbit.com, djwong@kernel.org,
	chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, mcgrof@kernel.org, linux-mm@kvack.org,
	hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <ZnAtOtwmGV1vR6Pz@casper.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-4-kernel@pankajraghav.com>
 <20240613084409.GA23371@lst.de>
 <20240617095837.bzf4xiv2jxv6j7vt@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617095837.bzf4xiv2jxv6j7vt@quentin>

On Mon, Jun 17, 2024 at 09:58:37AM +0000, Pankaj Raghav (Samsung) wrote:
> > > @@ -2471,6 +2478,8 @@ static int filemap_create_folio(struct file *file,
> > >  	 * well to keep locking rules simple.
> > >  	 */
> > >  	filemap_invalidate_lock_shared(mapping);
> > > +	/* index in PAGE units but aligned to min_order number of pages. */
> > 
> > in PAGE_SIZE units?  Maybe also make this a complete sentence?
> Yes, will do.

I'd delete the comment entirely.  Anyone working on this code should
already know that folio indices are in units of PAGE_SIZE and must
be aligned, so I'm not sure what value this comment adds.

