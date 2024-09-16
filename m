Return-Path: <linux-fsdevel+bounces-29468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547EE97A2F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52DEB21543
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451215689A;
	Mon, 16 Sep 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gNjxOfWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1EA95E;
	Mon, 16 Sep 2024 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493399; cv=none; b=lHloRflUsSDytShkpdjIwCCjDhdq9EknbNv3pqU6rS/nH0MCfgYayPerq7Qwib67e9hRxgiWC4yMdNBRtsfg1HYFHlenqnLyklfjxFMafXc5AtRiBYiFyh03+IwoD080B0KL6kbEQSuZ5/oZPsKQ8TVPK+uNmqKSb0RaWczlPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493399; c=relaxed/simple;
	bh=5358DHb00/riUqxFwGC1LquJns98OBanNtye9TBg7Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK8UWWgmRUS4FmwIE+RF9JmLFNE4AYg+lKC1nUO5q7xrZtsu3NuE6jqibIGfHIbDnU+5Wico1sn8G4exM7RMZTQsrXmCi7cNgAGuZfKw2PfabYjLzSOcM824u+q2JRBCBAs+tCpp/B4ACYXmlkcIFb30B+t6So0xh4hnyMlMuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gNjxOfWA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qq8tYo1JEcSLEHueBFlP6ppnnitpWT6xJFK+HA9N1s0=; b=gNjxOfWAvf+YsKYoElIQn4rni0
	6N+tyQGjTWwWB1p4IFbKCksWfwTK7CmArJcHKg5rz91aJxEPAVWecr0Y9M9vejYbwmAoWA2aJCLLB
	J/uks525IrO4RGWjZAAcuRThdIQ5IHwN8CQFqNDhHmBBqa1uUqK/5D0v7n67gjqh5zI6h/bAT1Mz/
	aVUqdsdNInRz+TbFlT0DbUG+6fkXcsQgFiBLTKJ8Z/sJtwJ3JLiZyvP49i+O7mGt1GR9TzYC34oC5
	PnSMfQrrNW7qF101SjvfsAZkqcmm2IFYQjVwK9Fb3qIhkBCaTJyXJH+a4dMbUAEVJbMABK9nUyULh
	HhCf5eYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqBna-00000001zL5-0aWo;
	Mon, 16 Sep 2024 13:29:50 +0000
Date: Mon, 16 Sep 2024 14:29:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>,
	Dave Chinner <david@fromorbit.com>, clm@meta.com,
	regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZugyzR8Ak6hJNlXF@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <20240913-ortsausgang-baustart-1dae9a18254d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-ortsausgang-baustart-1dae9a18254d@brauner>

On Fri, Sep 13, 2024 at 02:11:22PM +0200, Christian Brauner wrote:
> So this issue it new to me as well. One of the items this cycle is the
> work to enable support for block sizes that are larger than page sizes
> via the large block size (LBS) series that's been sitting in -next for a
> long time. That work specifically targets xfs and builds on top of the
> large folio support.
> 
> If the support for large folios is going to be reverted in xfs then I
> see no point to merge the LBS work now. So I'm holding off on sending
> that pull request until a decision is made (for xfs). As far as I
> understand, supporting larger block sizes will not be meaningful without
> large folio support.

This is unwarranted; please send this pull request.  We're not going to
rip out all of the infrastructure although we might end up disabling it
by default.  There's a bunch of other work queued up behind that, and not
having it in Linus' tree is just going to make everything more painful.

