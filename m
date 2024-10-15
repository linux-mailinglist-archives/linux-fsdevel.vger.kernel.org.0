Return-Path: <linux-fsdevel+bounces-32018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB0D99F425
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20E1283E15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0661F76AA;
	Tue, 15 Oct 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWKZdw/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28D1AF0CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013597; cv=none; b=bU5jL6x6GN64Zw8OrCGwHzz9VGsHpJwnV3+27LeOBKe1wNlYq0yRcYVJBFWE61KWSzE8NuaXA7Gb60oh+dQ0fqoMsHiIH1SSWwysb++z0arJSSHJgE5YLGqhxl73N9N+c+ZL9Mx0MgTgcJPMOV1VwREp7aovmEVFIEmn3wAo5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013597; c=relaxed/simple;
	bh=rKw7OWOf27uaOWr2RrkI8trvD4XELSI8lUIUPymlHsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV2/2YGB1ypr9YTW7vAeaC86BUfPZrGRF14s9cbwbCHaMv+T1mVvW4e9fzHs/wPDkkGckLTwaE5Aw78KzEMX4QdZG1mbhJA8OIOw81yZLhFrDs8wiD+id3kNlPcPI25u0IAKCgZRQ/Yxfomia5+Djp65qKZiP3n5GlwzilW5MC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KWKZdw/k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jN1tSUu4ZmhBjWgxZuk/s0l3vJifj6qSHy2dO3NlJ6Q=; b=KWKZdw/kE7v0vgb1xgTQbIMDJF
	qgjFSMadwZfaIHp/rMQa4nAkHrh1OkMX4qIQ3MLEXXFtal9WE3gRkOk3/rFJxjAJdDU7ai8uynX/V
	LPq8QDtcZzVro2gjjmJf2rHrb8XF9LT0YdZQ36YhgleP/t3JQVhpi8NnA8IRk34aZ8rB3H9U8yrit
	anZm2Wkr6f6lBRzfEmNz3K1X7Wy1tWFL17cIh9mV+be/f1urkqFSE38QASeoXaFrbZH7fK/FwZIgk
	9UIgZ8pErsU++15IPvGz9ki7KN/JJ2EtH7FWf5pFba6rlgZfkMjovIwXVv1GwL/vR5DVJxgHXS9eI
	ZOI5BWlg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0lPz-00000005O4D-3lDr;
	Tue, 15 Oct 2024 17:33:11 +0000
Date: Tue, 15 Oct 2024 18:33:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v14] mm: don't set readahead flag on a folio when
 lookahead_size > nr_to_read
Message-ID: <Zw6nVz-Y6l-4bDbt@casper.infradead.org>
References: <20241015164106.465253-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015164106.465253-1-kernel@pankajraghav.com>

On Tue, Oct 15, 2024 at 06:41:06PM +0200, Pankaj Raghav (Samsung) wrote:

v14?  Where are v1..13 of this patch?  It's the first time I've seen it.

> The readahead flag is set on a folio based on the lookahead_size and
> nr_to_read. For example, when the readahead happens from index to index
> + nr_to_read, then the readahead `mark` offset from index is set at
> nr_to_read - lookahead_size.
> 
> There are some scenarios where the lookahead_size > nr_to_read. If this
> happens, readahead flag is not set on any folio on the current
> readahead window.

Please describe those scenarios, as that's the important bit.

> There are two problems at the moment in the way `mark` is calculated
> when lookahead_size > nr_to_read:
> 
> - unsigned long `mark` will be assigned a negative value which can lead
>   to unexpected results in extreme cases due to wrap around.

Can such an extreme case happen?

> - The current calculation for `mark` with mapping_min_order > 0 gives
>   incorrect results when lookahead_size > nr_to_read due to rounding
>   up operation.
> 
> Explicitly initialize `mark` to be ULONG_MAX and only calculate it
> when lookahead_size is within the readahead window.

You haven't really spelled out the consequences of this properly.
Perhaps a worked example would help.

I think the worst case scenario is that we set the flag on the wrong
folio, causing readahead to occur when it should not.  But maybe I'm
wrong?


