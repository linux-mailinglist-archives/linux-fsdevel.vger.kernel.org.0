Return-Path: <linux-fsdevel+bounces-51230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B859AD4AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94780179554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159A228C9C;
	Wed, 11 Jun 2025 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZHBKFKzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D391A28D;
	Wed, 11 Jun 2025 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749622097; cv=none; b=lyWSF1x6FRefjmp0XLAeQX+VZ47fTMi3RZDLZeI/UUlTyf19J4Nu7vHGdtFwaqDfLolB9mSeIBnN+brmon1AiyXJZ0Or14o4qquj37vGa/nssjIBEnFgyeJ/zUh21PMOH5aLKVAPqn2zGIvHaN8bROBOoROPf/qUNpaW00NzmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749622097; c=relaxed/simple;
	bh=RtUg9EKSSuLFS9RlzQw5TKXMfyAaXWz/l9NWRQha/dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO2YXnfeDJsNBYVCU1fi4OBJPDRAftKLx8Y+3FZx+/dFUQIVZF5meLBcQ/YTe74SGQ6GJIMDcWhXXOH5qrVcER99h4LIbT4kxvQgAUWRPq2ax1a7yoOtHIeMKN3+8g371Qs+SdfNQ+D2wbV3e1Z5E0YYvzXkcl23TboCOKSv+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZHBKFKzM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pY7jRxeVYDBWehLdmeYwiUmwTINllKo3L7LfIGWF+gU=; b=ZHBKFKzMw1C1USOYxQ8zzexsAK
	HAclljtg0YIvkvvXAuJLm3I/iepEKPwr3WcV4B3qMAij7J/1p1rEErKnrAaAMTv197AnT4khvqVHr
	b3I2lWMJYFdXLRmYHzvpHd1x8fCBnQQriCRZJ1iTJbuz7tI6DDF7cKcWqTUB+UuG/TNFHVF8zlKUF
	M2qrB6MlyVPhj/oFFu2OjuUgGDOG3dhvgt6oU1yjj9CpqNygL2SWHlyoulwSCZ2aq/P1ShG88cYFv
	xJey/aEfS0i/FHy3f/fCgi8kSibIDT0Bef9OUfyoll71puxTN0260XOFPdEwqJ9SZ6JQvqApbq2I6
	nVzE6Mhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPEdD-00000008vLh-3aGY;
	Wed, 11 Jun 2025 06:08:15 +0000
Date: Tue, 10 Jun 2025 23:08:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Message-ID: <aEkdT-gCSA75OVNv@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com>
 <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org>
 <aEgyu86jWSz0Gpia@infradead.org>
 <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com>
 <aEkARG3yyWSYcOu6@infradead.org>
 <CAJnrk1b8edbe8svuZXLtvWBnsNhY14hBCXhoqNXdHM6=df6YAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b8edbe8svuZXLtvWBnsNhY14hBCXhoqNXdHM6=df6YAg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 11:00:51PM -0700, Joanne Koong wrote:
> Not a great idea, but theoretically we could stash that info (offset
> and len) in the folio->private iomap_folio_state struct. I don't think
> that runs into synchronization issues since it would be set and
> cleared while the file lock is held for that read.

Yeah, I thought about it, but there's no simple hole, so we'd bloat
a long living structure for short-term argument passing.

So I've been thinking of maybe sticking to something similar to
your version, but with a few tweaks.  Let me cook up a patch for
review.

> But regardless I think we still need a new variant of read_folio
> because if a non block-io iomap wants to use iomap_read_folio() /
> iomap_readahead() for the granular uptodate parsing logic that's in
> there, it'll need to provide a method for reading a partial folio. I
> initially wasn't planning to have fuse use iomap_read_folio() /
> iomap_readahead() but I realized there's some cases where fuse will
> find it useful, so i'm planning to add that in.

Heh.  How much of the iomap code can you reuse vs just using another
variant that shareds the uptodate/dirty bitmaps?

> > variant of read_folio that allows partial reads might still be nicer
> > than a iomap_folio_op.  Let me draft that and see if willy or other mm
> > folks choke on it :)
> 
> writeback_folio() is also a VM level concept so under that same logic,
> should writeback_folio() also be an address space operation?

Not really.  Yes, writing back a part of a folio is high level in
concept, but you really need quite a lot of iomap speific in practive.

> 
> A more general question i've been trying to figure out is if the
> vision is that iomap is going to be the defacto generic library that
> all/most filesystems will be using in the future?

That's always been my plan.  But it's not been overly successful
so far.

> If so then it makes
> sense to me to add this to the address space operations but if not
> then I don't think I see the hate for having the folio callbacks be
> embedded in iomap_folio_op.

I'd really avoid sticking something that is just a callback into the
address_space operations.  We've done that for write_begin/write_end
and it has turned out to be a huge mess.  Something in the aops
must be callable standalone and not depend on a very specific caller
context.


