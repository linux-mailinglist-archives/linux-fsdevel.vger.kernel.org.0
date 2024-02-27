Return-Path: <linux-fsdevel+bounces-12968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7B869B5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8404A28BD12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3C1487C6;
	Tue, 27 Feb 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sUlIYkzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958681EEE6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049271; cv=none; b=JBskDklY6KExtlgtE7WRmY8JgylDx68YAM8qi8gsQHzf6Mri+dlw/evMY72dXYdeBHorKug776Rl4Lu2QfThcQzO1mAE0O5cO1UroW37hViQfNDu5T+gWIkvQ3/LWohBdtrxybSWBVthEMnhaq2euR6l4TsWxVggeaeMSFNfpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049271; c=relaxed/simple;
	bh=5wRaU3YKhDUsLsIBPsgOkmo0CTfRA/SgSuW4xviYFIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSTxOoKoFfhtv63QIW1B2le4rBjOTWRG/M7fZDvo9NEYrqN9OYcqEyFpzxQFd+EoJ3L4vS67+o2c9maO6P2WZ2Bh4tGS1OrRMcSr9xU5and0UMkQ04RFelUd7taKAR47wZOh0/HMBK6vns65W9G/osa6bod6eLJPBI/xe/Gi2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sUlIYkzL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ehaBaelOcxQhJl05ZpX3EeYgZv5VWBUnDUYHSnkxWkI=; b=sUlIYkzLLkeRznviQQlcnak9ex
	TkUEF+nHZee72xTK0JZj5RLmPUllfltWRWr/0Qz7Tpgkanfcy3IWIWLJZfZH5S1Vmd7Rk9auyD+lW
	qaKf/7K4r2hCJhCA1ugdog1tgIwMoSBxRPzFdYzXoudU5ay7nvR/ZQxC4yyS+OmuIThZ09jJbsanJ
	f1o5v8ZsUMwKLiyq5uABiB5Rq8Lbvfg5iDZ67DnUbm3rVDQOKCWrdqouxjhTw6H318kZIxSxZkQp9
	svVWM48YWw55/uP22VXkFFiS/3RWbuotE+voZybTAFh8J3EW+vxSNt2V+eWcoQA8ZFfILlXtmI3Ba
	6SsYTuCg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezmh-00000002lth-1UPC;
	Tue, 27 Feb 2024 15:54:23 +0000
Date: Tue, 27 Feb 2024 15:54:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zd4FrwE8D7m31c66@casper.infradead.org>
References: <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>

On Tue, Feb 27, 2024 at 07:32:32AM -0800, Paul E. McKenney wrote:
> At a ridiculously high level, reclaim is looking for memory to free.
> Some read-only memory can often be dropped immediately on the grounds
> that its data can be read back in if needed.  Other memory can only be
> dropped after being written out, which involves a delay.  There are of
> course many other complications, but this will do for a start.

Hi Paul,

I appreciate the necessity of describing what's going on at a very high
level, but there's a wrinkle that I'm not sure you're aware of which
may substantially change your argument.

For anonymous memory, we do indeed wait until reclaim to start writing it
to swap.  That may or may not be the right approach given how anonymous
memory is used (and could be the topic of an interesting discussion
at LSFMM).

For file-backed memory, we do not write back memory in reclaim.  If it
has got to the point of calling ->writepage in vmscan, things have gone
horribly wrong to the point where calling ->writepage will make things
worse.  This is why we're currently removing ->writepage from every
filesystem (only ->writepages will remain).  Instead, the page cache
is written back much earlier, once we get to balance_dirty_pages().
That lets us write pages in filesystem-friendly ways instead of in MM
LRU order.

