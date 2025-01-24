Return-Path: <linux-fsdevel+bounces-40093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA130A1BE94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 23:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC727A2185
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3B1E7C28;
	Fri, 24 Jan 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RebL+1dS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1F18A93E;
	Fri, 24 Jan 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737758977; cv=none; b=uU9o8VbDGjz8PeDHswW/uVu/UTGyclSpgetD1dczGvLsBoUt+SQBpUUh7Tuc84Ef4Gm/U9bhULrzyIDCi7hDjA5SKm28j7cEfJTPhq4qJfL8pWrcvHw3XzwemOtw7uC8EjP+b4IcP2uv22khfCBdv6BvhB0+X/r7W6PF9rzrmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737758977; c=relaxed/simple;
	bh=LWWTQQn2VY7HWS5flBbrS7xVaUai6k/TZ/WsbHRGFUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuuy4qF6SA/wf+99imIL4IYabKw5+jqOoj6xtxfNKdwlR8pj6lirV4OAVzpuI0o6z1C18xJAYKiU08QQO54eS7akSI3KNxyLT4kYygE8HcpoDFsAPrRyEhspKAXHj6eAlN2drX+nh0M1oEOhmulK6LOtwKwe7B1O5RWYJGyczuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RebL+1dS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dRbdPPhjOKdes39J3VJ4WjCcw0dY3uS4T7TD+DKOtL4=; b=RebL+1dS3WsBUZg0D2+s70RWQY
	YpR9avyNzuL6LHSr5zYWzShy4L7wQeOvYeUOhk35eBcMIF1/Qe/b54PMfCqFxgBln99Ye39GQ3VDQ
	8eNueQ2PJ6kdEqFkstwliK2PdRF3cvldBPjWajNEDf9xvB9dXZDTScBpPBpoqCyfo/nj2HZhaN6/k
	KqaFdRswg615uP7nFNRjp2guJowMmbreeJiKZ5sBbObKzq1X+847nV6DGFUuxLjTo6wOIbt+70g9t
	jyb/w4i8qKZIJ+Jib/+80/JGqqYbdLiT6Z9HgqYSdpzi2DdxeiUEQSDjtBcWvKsgJwGneYeCzcsDs
	JCZiCLXw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbSUY-00000001MPz-19a4;
	Fri, 24 Jan 2025 22:49:34 +0000
Date: Fri, 24 Jan 2025 22:49:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH] block: Skip the folio lock if the folio is already dirty
Message-ID: <Z5QY_hpDZ84KN3In@casper.infradead.org>
References: <20250124224832.322771-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124224832.322771-1-willy@infradead.org>

On Fri, Jan 24, 2025 at 10:48:29PM +0000, Matthew Wilcox (Oracle) wrote:
> Postgres sees significant contention on the hashed folio waitqueue lock
> when performing direct I/O to 1GB hugetlb pages.  This is because we
> mark the destination pages as dirty, and the locks end up 512x more
> contended with 1GB pages than with 2MB pages.
> 
> We can skip the locking if the folio is already marked as dirty.
> The writeback path clears the dirty flag before commencing writeback,
> if we see the dirty flag set, the data written to the folio will be
> written back.
> 
> In one test, throughput increased from 18GB/s to 20GB/s and moved the
> bottleneck elsewhere.
> 
> Reported-by: Andres Freund <andres@anarazel.de>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

... this is the wrong version of the patch *facepalm*

