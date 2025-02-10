Return-Path: <linux-fsdevel+bounces-41479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C1A2FAC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25B91885C51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9272505AE;
	Mon, 10 Feb 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pW6SLPFq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60B24E4D8;
	Mon, 10 Feb 2025 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219792; cv=none; b=tadgirpa9vrz2i8rp1SrfX9Ha18tzb0VrsbHHcMFIB5sJ1lRyuZ2rlhQDCF41rKuHgP1hK97UwEhDBrfgbD/3dZv/bOB+d74VgGoY5qTaHcjZZewunlUUYTGGwLui6TlPm/8b1oN/nR7XgczIVWf+LpGlf+Hcl2WmTEKlGT2/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219792; c=relaxed/simple;
	bh=kG+TgB6S4wm9v0iuwdDvcIi4d4xowxqxXp22PZXJWcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1k210Ql0miJDTeujeJeHgMpuluJwlwRYfu2T/DiTFpZlkCMPClftePq+HbvOZLcDgIIh26Q4moA4thVUwj3Dhk7HIheOprGfolcnzp2p8Dj66O0NyxTncUPYknf7xzXZU8JSDQhX+O2IhAqRuDH9b/TeP6+eHOQLX243fd+I5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pW6SLPFq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dsSgA6Yf377jp8GIbPPXV+rVGw28eQh48UxX6W9rqVE=; b=pW6SLPFqOelwpYrNGOFGvsaKxd
	QKR8QBm80arRcVftyH8StJPacJE/G64qPiGExpOvNsYBWDZvTvkkpRxJj+4AaQiOsKt+IYbl23LGw
	tJJG9vkf2cyDggw+A5tgoWQ7oFb4S67fTwbPuPzEbUQrFQHcfoga8YwG1Wr17CBrR6YTM4cSE8Bpt
	6ZG8CgtTqg22DeMCq7iU/LPNOndTriqGQpsqvZobW2L8uEePA04hPAMSrEGKpszSDCOjD/H63bAGu
	5rfDYa3vJyaD/c0Hl4/T8blKiUL7qaac+PKWSNXmt+Wi7Mzev4qy6kom2CNo1jDx9agfPt1YWxSQq
	Av23hiQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thaW1-0000000GjmU-2iop;
	Mon, 10 Feb 2025 20:36:25 +0000
Date: Mon, 10 Feb 2025 20:36:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Heusel <christian@heusel.eu>,
	Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>,
	Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for
 FUSE/Flatpak related applications since v6.13
Message-ID: <Z6pjSYyzFJHaQo73@casper.infradead.org>
References: <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
 <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
 <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
 <Z6ct4bEdeZwmksxS@casper.infradead.org>
 <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
 <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz>
 <CAJnrk1aBc5uvL78s3kdpXojH-B11wtOPSDUJ0XnCzmHH+eO2Nw@mail.gmail.com>
 <20250210191235.GA2256827@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210191235.GA2256827@perftesting>

On Mon, Feb 10, 2025 at 02:12:35PM -0500, Josef Bacik wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> Date: Mon, 10 Feb 2025 14:06:40 -0500
> Subject: [PATCH] fuse: drop extra put of folio when using pipe splice
> 
> In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), I converted
> us to using the new folio readahead code, which drops the reference on
> the folio once it is locked, using an inferred reference on the folio.
> Previously we held a reference on the folio for the entire duration of
> the readpages call.
> 
> This is fine, however I failed to catch the case for splice pipe
> responses where we will remove the old folio and splice in the new
> folio.  Here we assumed that there is a reference held on the folio for
> ap->folios, which is no longer the case.
> 
> To fix this, simply drop the extra put to keep us consistent with the
> non-splice variation.  This will fix the UAF bug that was reported.
> 
> Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu/
> Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/dev.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5b5f789b37eb..5bd6e2e184c0 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -918,8 +918,6 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
>  	}
>  
>  	folio_unlock(oldfolio);
> -	/* Drop ref for ap->pages[] array */
> -	folio_put(oldfolio);
>  	cs->len = 0;

But aren't we now leaking a reference to newfolio?  ie shouldn't
we also:

-	folio_get(newfolio);

a few lines earlier?

