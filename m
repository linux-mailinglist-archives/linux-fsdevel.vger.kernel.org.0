Return-Path: <linux-fsdevel+bounces-57437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B8CB21786
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 23:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5272A135C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9AF2E3AF0;
	Mon, 11 Aug 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="EKqL0vot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C6311C0E;
	Mon, 11 Aug 2025 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948287; cv=none; b=tbP+JMCWRt8lJvaUSZjcFVqHcB9un5A2mzXtXT2gkjPvDS/pgtaZVr46fnNv4Sq62wX6VATqKV0e/X+Uya6Ra+ueEeEgjJQAWFQ4Q7oqF3KK/3WT10pzM1OTqN9C7n/ez40YGZ0SV7JMX3mLRw5MMsTUtHlxKNv77LIkDs4MAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948287; c=relaxed/simple;
	bh=HjyGdOGLYqC7ab18LfpaxPJTKS3Yx7XdT8RLH/XbFKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnUUPoNM2xe02Oir28hVAyzH8t/J1MvDCBYkVFnGcAdRHyR2umATI7McRVPqCfYLOALx29xxqKxyvH+t6dCniEXTph0RyHp/dWlH0Mm2uZxECBR3AtLeCTpo4QKcxZ1Id0e9cRiM14zS18Q1LEcNRYpWOPczRbKEL6YThZ4hE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=EKqL0vot; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3155F14C2D3;
	Mon, 11 Aug 2025 23:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1754948282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KuxWLbpcJT3VlmZVqc2OQpXyttswEbc/sHxkepGM9E=;
	b=EKqL0votUNnCF6qo5E8bBmNRyJd+MBtp61wniZY0+tazDObV62wwWmH7rAgLJoxoE9WJ2Q
	Dx5sKNQt+YN3xbunO809CS4xhHpBVgyleAbiZQNf7sDAu/gPw2SuovDGaPfE4sH4R0kEgE
	z9O8O4DK1BvosELxyLVFIfg3k8fjtCtjz1yrmeIsV5uJ2Af6E+xI/ZtW3t9otjeOQqLXIY
	Bxx3zU8mn9CG9ZCh/xkA0hH0EcgFGpqqbwvKA8/LPo4MHv9szIIN7bVyLRK+lETWgUhJjU
	CT5gZ7YnwA6Lla+5S/CswMDOOTp06yPMjzf6DL6Es13PnP/xdcqkZTZUP2Iy2A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d8bc4c7b;
	Mon, 11 Aug 2025 21:37:57 +0000 (UTC)
Date: Tue, 12 Aug 2025 06:37:42 +0900
From: asmadeus@codewreck.org
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <aJpipiVk0zneTxXl@codewreck.org>
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
 <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
 <385673.1754923063@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <385673.1754923063@warthog.procyon.org.uk>

David Howells wrote on Mon, Aug 11, 2025 at 03:37:43PM +0100:
> Dominique Martinet via B4 Relay wrote:
> > It's apparently possible to get an iov forwarded all the way up to the
> 
> By "forwarded" I presume you mean "advanced"?

Thanks, swapped words in v2

> > This should have been because we're only in the 2nd slot and there's
> > another one after this, but iterate_folioq should not try to map a
> > folio that skips the whole size, and more importantly part here does
> > not end up zero (because 'PAGE_SIZE - skip % PAGE_SIZE' ends up
> > PAGE_SIZE and not zero..), so skip forward to the "advance to next
> > folio" code.
> 
> Note that things get complicated because folioqs form a segmented list that
> can be under construction as it advances.  So if there's no next folioq
> segment at the time you advance to the end of the current one, it will end up
> parked at the end of the last folio or with slot==nr_slots because there's
> nowhere for it to advance to.

Hmm, I've already sent a v2 with other things fixed but now you made me
look at the "we're at the end of the iov_iter" case I think this won't
work well either?
folioq_folio() always returns something, and the advance code only
advances if folioq->next is set and doesn't bail out if it's unset.

There should be a `if (slot == folioq_nr_slots(folioq)) break` check
somewhere as well? Or is the iov_iter guaranteed to always 1/ have some
data and 2/ either be big enough or have remaining data in a step?

I can believe the former but wouldn't trust the later...

> Note that extract_folioq_to_sg() already does this as does
> iov_iter_extract_folioq_pages().

Yes we're not quite consistent here, some functions like the plain
iov_iter_advance will get you on an invalid slot to check for
folioq->next on next invocations while others point at the end of the
last folio in the queue (like iov_iter_extract_folioq_pages(), and
iov_folioq_get_pages() before patch 2);
I think either pattern is valid; I've changed iov_folioq_get_pages()
because it was a bit weird to have an iov_iter with offset > count and
iov_iter_advance wouldn't do this, but I agree either should work, we
just probably want to be more consistent.

Thanks,
-- 
Dominique Martinet | Asmadeus

