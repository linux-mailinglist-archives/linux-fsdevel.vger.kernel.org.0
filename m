Return-Path: <linux-fsdevel+bounces-58235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6D5B2B727
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5AD7B442F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3CA28640E;
	Tue, 19 Aug 2025 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H70igcBq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47018E3F;
	Tue, 19 Aug 2025 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571295; cv=none; b=mn7gK4Rp6L4Lp8O0gOQGtnMtPYnE396M6/nl+N7gOCioNm0V7QG3Vwx9cH8PbE33HXPEylsCK0JFDekp4rpe0vshwUVJ6SgAC9uzxzflCkS3OtvNmhX8fQAm28WRiiYSbHFYvuNVq/ID29CyjOacfkHrzEMHi/Lt9xmJotF55d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571295; c=relaxed/simple;
	bh=KMGyNtjtrLCyv9tEVPwvf74AtviAE4WX4hdDglb3nAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq6zfsIVe/G4Hd0ZjQSEa6Kajv1Rs+klfUJQ8dle5mq5aBkiHMTtJoRjUPSqjNFd/mR+sPYQPT56QjgNCuaIbC1MC57fbAZfjRpqiJhpGdmvKHaxid4I+BLJxSu+RTvY9duE4FevjyrQJhlhyHd3xFNug3d4bFtaHZ8QKrzguEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H70igcBq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mTBnV4bc3gSI0g52nwjGpXSW5TVHNqW9pyIpZEnrk9I=; b=H70igcBqpiQYNo4ugKW1YZfnad
	8lQrxV0D0gUVaU/APagwXs/155/NS4GN7t+bC/zBBA0yfNIjPjhxWAXtRIPkkOw9QdyIlxFGas5Yx
	+QFeKcKhEKJHyk5nArTo1z2LacZut1/Bf5u/YrCyvEv96NGQzlJR5YwWTV0KJoBP1tFOoqPKicLyL
	tks+q7GgC/4zitDwaq3H2Y7WRqHG3AlADNJjQmRAN3VFwgy8h1fywRt6driRb31fYYIhPGlDIie6Z
	ojKTebYkz/dCWa71jznojegmy0VlcGxa0ctu0Pl+CFcG4F9UECWNqFM9IinKKKywDGEfXOhA6bFvg
	dZ89j+2g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoCHy-0000000EwLT-2pYe;
	Tue, 19 Aug 2025 02:41:30 +0000
Date: Tue, 19 Aug 2025 03:41:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Boris Burkov <boris@bur.io>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, shakeel.butt@linux.dev, wqu@suse.com,
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: Re: [PATCH v3 4/4] memcg: remove warning from folio_lruvec
Message-ID: <aKPkWv77HMOQwyVi@casper.infradead.org>
References: <cover.1755562487.git.boris@bur.io>
 <0cf22669a203b8671b6774408bfa4864ba3dbf60.1755562487.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf22669a203b8671b6774408bfa4864ba3dbf60.1755562487.git.boris@bur.io>

On Mon, Aug 18, 2025 at 05:36:56PM -0700, Boris Burkov wrote:
> Commit a4055888629bc ("mm/memcg: warning on !memcg after readahead page
> charged") added the warning in folio_lruvec (older name was
> mem_cgroup_page_lruvec) for !memcg when charging of readahead pages were
> added to the kernel. Basically lru pages on a memcg enabled system were
> always expected to be charged to a memcg.
> 
> However a recent functionality to allow metadata of btrfs, which is in
> page cache, to be uncharged is added to the kernel. We can either change
> the condition to only check anon pages or file pages which does not have
> AS_UNCHARGED in their mapping. Instead of such complicated check, let's
> just remove the warning as it is not really helpful anymore.

This has to go before patch 3 (and I'd put it before patch 1) in order
to preserve bisectability..  That requires changing the tenses in the
commit message, but that's perfectly acceptable.

