Return-Path: <linux-fsdevel+bounces-56138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB80FB13D74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90E8189AE00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2477426D4FC;
	Mon, 28 Jul 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxb9+1T1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2641C69;
	Mon, 28 Jul 2025 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713736; cv=none; b=FRQ8h1n/S1Pv/W41sLiwnhmFIXlnQl36P8t+0MjYHtFzLM0h3pB7K0fJ9rC4zO2NQplZfeo5v45NfMyyty3dEtrz3+2PerHQZKFOLGWsY+4kD+GM6UlXqxdfaa4JpQ3nBD7PaAe75zD1+VAhdgwse46t5K+nWcbGZG7MOWaCPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713736; c=relaxed/simple;
	bh=DpSLhLqLtoWAjPFAhnRpQHnfDl9Bzi+xdOubih9rq88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdR9W+FVWvDc++dsv12jFn5OeqrUDy2rE24qa1SdpkEU5q1LT7+I4FsAp/Y8Fd3NIk5JZOIJHhA2HPy6KZj1uVL1ir8Hv3R/nrc0qnc9xe06PDSW79ylfZYW6xVjDWyDngzrvblk1K7t7OTk90e36z848fkl52QE0jXpzE/rmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uxb9+1T1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RAL2l+mv1I/nlkTDSZpeQJroASTk9g9BfKekJFqLpnU=; b=uxb9+1T1LM5dvw47xw+vfNiyOo
	fWbKXCXKA4JX3NK5bN2EeZtNzN1g+Du5wHEj8EA8XzPJ+Hx1+K2hg6BRZcvP2WcELAo9PoU3TqJVS
	Ge74rh2DpJBR8Wth+ZY4zToRb0D3ooqzdD9Sw0BTU+IW/LzeOjrIYTvc/HYfQ1/dN7QefWsf9t76F
	A2ROoklabS/RHbkJpUy24zN2ijVkiDQQGP5wInAs5GWeEBvMTQMMV0qZV+aT0wm/cxyuOK0qEpMi2
	LOL6nTTLt5WE0uOirBL9VsF2nxX36RE88T4+pJcgvRHBsBPTxud5bWldJeI1t3DOD3q7xoMq5G2YG
	jUXYgWjw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugP3J-0000000D2AA-3mtL;
	Mon, 28 Jul 2025 14:42:09 +0000
Date: Mon, 28 Jul 2025 15:42:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: laishangzhen <laishangzhen@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Removing the card during write
Message-ID: <aIeMQfVNucc3_RRa@casper.infradead.org>
References: <20250728141306.23451-1-laishangzhen@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728141306.23451-1-laishangzhen@163.com>

On Mon, Jul 28, 2025 at 07:13:06AM -0700, laishangzhen wrote:
> When formatting an SD card to ext4 using mkfs.ext4,
> if the card is ejected during the process,
> the formatting process blocks at
> balance_dirty_pages_ratelimited.

You're fixing this in the wrong place; it should be in mm/page-writeback.c
somewhere.

But it really needs a more thorough analysis than this.  To date we do
not handle removable media well.  I wrote up a proposal in 2018 here:
http://www.wil.cx/~willy/banbury.html but I haven't done any work
towards it.

You're proposing an entirely different approach which is to just,
well, kill applications.  This leaves pages in the page cache which are
effectively leaked.  If we continue on this path, we'd also want a way to
release all the pages in the page cache associated with this block device.
And that's a harder problem than you might think.

