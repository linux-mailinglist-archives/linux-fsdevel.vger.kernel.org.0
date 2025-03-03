Return-Path: <linux-fsdevel+bounces-42937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234EFA4C4F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D287A9179
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE3521480C;
	Mon,  3 Mar 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K1Huiszw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD22144A2;
	Mon,  3 Mar 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015373; cv=none; b=iC1jTLCHt69D2n2J2HtdUfQVGHZVAbJMMMzRcnCk33701mU0/+KjfF/bNDuB/+2UIljN50qrozGjTcmHdf+sFzgKc7rFvLHKA9+xC+AEptyucekMdClNNKEVXVkU8rwNhPGjLH4hJj4IXOX0OP70+ztOujWqqmuta1Rf1yFumIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015373; c=relaxed/simple;
	bh=1mrD2NTQ2+v2UQCE4SLK2NFQpeu0yHMxJDAQr80UYcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T60HobwZA2cO8yJCK8+sfzWX5qRNVvQWyOZLh1OF3BCfK6bIym7ztF3Q/BinSK/s5JCA35VNJmY2zN+kxPqCGMETIvKlmkbPpEGLR3dnw9GHW9s/7JsSzWBM3wU+S9+Jj4vWTA0vNoZQ8iOgdoPqn1YBFiSO6Lch0a+GZUH8bno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K1Huiszw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KXh3QDCelMzVNiN0fLJTBXdfVAkCV6ng3JDBTJ3FCew=; b=K1HuiszwGF1n6BBMnuGD4Q/ArF
	+CCkLUv9UM6+BfNM/C0xOGSbEs7selFNzMDT6HXugyXpOp2YP5Na0SZVzhFObmkrouJlOt12VDiFL
	37iDOxdMA6N7KwCPhEiLro2sVhipD4fkVabgtdudNlipWPwpEm6sAQZPm1LmDOLMPfG98ACanwMGg
	N6BvIfbuypTVW1En3D3/roXNiG5M9fRzS399PHHnp9XIZ33388j7e4lWdOlUCnozWZdYZIAaksB6o
	oa8rcVrswzXsfXJi3wckGWRwi7UjHNG3sToahX7sbewGX4wugj2BkmxB/DwMPpmmdYS7KoQ8lQqYR
	d0gES47w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp7d2-0000000Bos9-1GNO;
	Mon, 03 Mar 2025 15:22:48 +0000
Date: Mon, 3 Mar 2025 15:22:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Heinz Mauelshagen <heinzm@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8XJSL-rSLUtx-NL@casper.infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <CAM23VxprhJgOPfhxQf6QNWzHd6+-ZwbjSo-oMHCD2WDQiKntMg@mail.gmail.com>
 <Z8XHLdh_YT1Z7ZSC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XHLdh_YT1Z7ZSC@infradead.org>

On Mon, Mar 03, 2025 at 07:13:49AM -0800, Christoph Hellwig wrote:
> No, ->bmap is fundamentally flawed.  No new code should be using it, and
> we need to move the places still using it (most notably swap and the md
> bitmap code) off it.  It can't deal with any kind of changes to the file
> system topology and is a risk to data corruption because if used in the
> I/O path it bypasses the file system entirely..  If it wasn't we'd use it
> in the loop driver.

Funnily, I was looking at the md bitmap code too.  It's the last part of
the kernel using buffer heads with not-a-pagecache page, so it's the
only caller of alloc_page_buffers() remaining.

I think it should just use the page cache to read/write the file data,
but I haven't looked into it in detail.

