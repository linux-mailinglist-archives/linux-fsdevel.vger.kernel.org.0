Return-Path: <linux-fsdevel+bounces-58193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E8B2AEF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 19:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6ED1BA52EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE8343D63;
	Mon, 18 Aug 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ukz6/cLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B206342CB1;
	Mon, 18 Aug 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536685; cv=none; b=dBZK63YsKiGwXjKNpZoYx/2A7Lavu3Kbe3Vtf/EPIKQw6X0ord01bzmlc6JhjEFSHLHbo25mPkB+z5OR93mWf/KvqvgciKjM9Fh7JyUkcIO+tujeYJMnDZdnLrUvSqDUAIfZySBU6u0cGdnZLG2SD7m76lI9qcpDWCxsE6DWLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536685; c=relaxed/simple;
	bh=2Fy+XHUKRZ28bhDCCibyjvaWjBvBQ0t2pg8SThG+d04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP90K+yltmdTo1m8fvgXCmCGVIwFk500NJMZxIncPyg6vPz7t79T1Bx57HK1AbglQLVm5MTaVflckbYeHzMzCNWewmSAIXGCuxFikJpRIyAtwXMtLE1V4WM6/RJ5DI695gCNUMWy/7blbYJD6mvXAomLKGu6qPWi8HM66oLS14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ukz6/cLQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r0zFopsz6LczyNVaD27yL2LZrYKfKAHdjGdtV6Y6zj8=; b=ukz6/cLQUHkJnAguajM2dRdJcg
	s6mnfOcBCOhxA+WTGOxABbdEdCp/O/B3IbBtXUw8Z6aIMkJyt2UFRWIJprWLSfzzLKJXoscBXM1ST
	/RrJTQO/QyO+7kYUbd4VuRgyXZBHRNh12cgsMn1ifEoM2K2HEVgmx8NsHOOmLU5Q++bFN64zBNOWu
	JlZEW86J2fy+3xBhtHRzpWXY6WRGAsgw/JZdIrqIr936mPnQ03nwDu9cJS9qMULGh/gAVIiL27s2a
	uP9ISbvU/hP3AG5U7Evo3V2SggIKsMtOgbv1Cz3+um+HnwoyKi7S5XISHJhm0EyWrMu2tBN26+jg3
	a2mFn3Kg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo3Hl-00000008rF9-1nVO;
	Mon, 18 Aug 2025 17:04:41 +0000
Date: Mon, 18 Aug 2025 18:04:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v3 2/2] NFS: Enable the RWF_DONTCACHE flag for the NFS
 client
Message-ID: <aKNdKRy65hv8sNon@casper.infradead.org>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
 <001e5575d7ddbcdb925626151a7dcc7353445543.1755527537.git.trond.myklebust@hammerspace.com>
 <aKNE9UnyBoaE_UzJ@casper.infradead.org>
 <88e2e70a827618b5301d92b094ef07efacba0577.camel@kernel.org>
 <aKNNkFJ3mt0svnyw@casper.infradead.org>
 <c3d5dead2b76161ba96187b85497e55a8a01032a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d5dead2b76161ba96187b85497e55a8a01032a.camel@kernel.org>

On Mon, Aug 18, 2025 at 09:49:47AM -0700, Trond Myklebust wrote:
> > Can you remind me why we clear the writeback flag as soon as the
> > WRITE
> > completes instead of leaving it set until the COMMIT completes?
> 
> It's about reducing latency.
> 
> An unstable WRITE is typically a quick operation because it only
> requires the server to cache the data.
> 
> COMMIT requires persistence, and so it is typically slower.
> Furthermore, the intention of COMMIT is to also allow the batching of
> writeback on the server, so that disk wakeup and seeks are minimised.
> While that is probably much less of a concern with modern SSDs vs older
> hard drives, the NFS client design has to cater to both.
> 
> So by clearing the writeback flag after the WRITE, we allow operations
> that want to further modify a specific folio to proceed without having
> to wait for persistence of the entire batch.

Ah; NFS sets SB_I_STABLE_WRITES.  Unfortunately, 6c17260ca4ae is
a little light on details about why.


