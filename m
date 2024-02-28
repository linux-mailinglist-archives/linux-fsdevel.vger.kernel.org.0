Return-Path: <linux-fsdevel+bounces-13043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D194186A792
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 05:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53952B25C0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 04:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2500820DD5;
	Wed, 28 Feb 2024 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bnMVz8HP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07820DC9
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 04:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094164; cv=none; b=BrsBsXuBYk1cQv1kuEPDisGW7Gf9rfvpDKsfj/n86Mlul5j5j6faFM5bMIAizVzaDSeVMrtkaKjxOJY4XvnFIB6y/MB8J31KW1Y47dWtx28TTLeTVAML8nlSuK6lVQkCZfnbBBDm41fluuaMd8IoA5derktFsJXZqD6hfJ8sJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094164; c=relaxed/simple;
	bh=N1wbeDl5iQVq60uoGeHadbMS92tsdw2+xsEeFfMclRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUszijKxP9WYrJWi80LMkwcwmcGs9T+8TtS13k4aMpcFqG0oICxMssPwvYor/pWddEq/zCGv2baNHt/HABQsrQFkrvJkuUcBLbJbF1wMwqt2Z5UtYNwlzNx1J0Zvw04s6LXDkMJpB26+x/hyBjG9v8LZvmiOXZpraNIJ6qka35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bnMVz8HP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hmC0rMc+RpbdHnLbpCJcomObutjlQbb7NzvcfcXhktk=; b=bnMVz8HPzO7kypVgoCf3rpcAMF
	mMMJhLFJ+skv9Tl7aFh44Vfiy0fJUWz5HOQcwwuZdIUWdPtQu5oh52P6nhF8lNhRplJMm260v6cNq
	jAZQrUHWmhiwTZ/I+Fnf+KQq8ISvV6uSu43lscJKHfjax2/+XJvYG4q7M2eBC0ztXu555NA9MV2bm
	xWLKQ8gcvi4cwDCLnXHKyFqTHTmoQmIsC7r421JAGZ09p7gefmBLMdpKOTCPedI7oRJjDxaW7o/E3
	KzrHQA/mO6gjO8eXwr5cjA2DJJFkOBnk1Pm9QTc2KjXFKZvxupJauVLzuNY/aSMNUCiCzcgq3ksdP
	IFUl8S/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfBSi-00000004EmB-20fq;
	Wed, 28 Feb 2024 04:22:32 +0000
Date: Wed, 28 Feb 2024 04:22:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zd61CH2jLe0Orrjr@casper.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
 <4rde5abojkj6neokif4j6z4bgkqwztowfiiklpvxramiuhvzjb@ts5af6w4bl4t>
 <Zd6h1C5z_my3jhgU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd6h1C5z_my3jhgU@casper.infradead.org>

On Wed, Feb 28, 2024 at 03:00:36AM +0000, Matthew Wilcox wrote:
> On Tue, Feb 27, 2024 at 09:22:26PM -0500, Kent Overstreet wrote:
> > Which does raise the question of if we've ever attempted to define a
> > lock ordering on folios. I suspect not, since folio lock doesn't even
> > seem to have lockdep support.
> 
> We even wrote it down!
> 
>                 /*
>                  * To avoid deadlocks between range_cyclic writeback and callers
>                  * that hold pages in PageWriteback to aggregate I/O until
>                  * the writeback iteration finishes, we do not loop back to the
>                  * start of the file.  Doing so causes a page lock/page
>                  * writeback access order inversion - we should only ever lock
>                  * multiple pages in ascending page->index order, and looping
>                  * back to the start of the file violates that rule and causes
>                  * deadlocks.
>                  */
> 
> (I'll take the AR to put this somewhere better like in the folio_lock()
> kernel-doc)

Um.  I already did.

 * Context: May sleep.  If you need to acquire the locks of two or
 * more folios, they must be in order of ascending index, if they are
 * in the same address_space.  If they are in different address_spaces,
 * acquire the lock of the folio which belongs to the address_space which
 * has the lowest address in memory first.

Where should I have put this information that you would have found it,
if not in the kernel-doc for folio_lock()?

