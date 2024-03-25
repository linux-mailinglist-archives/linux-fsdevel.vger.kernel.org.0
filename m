Return-Path: <linux-fsdevel+bounces-15242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91088AEDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDC31FA61AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0B5DF0E;
	Mon, 25 Mar 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fshS5v6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC155798;
	Mon, 25 Mar 2024 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392067; cv=none; b=surr+CYfFPviQSpp0xEHJE2/HtTnmsq7K9mAeJNOTCbtHiLN4BI7b/Yw1OAm9dtIOr1vsbUPGnHiWImWD2kALw2zHqP1jWqR0qQlK99l1z1YJZlD/6g//LAraLRQcfUkL1pF9ppKO2RYM4D6OerW4LQwi3ZtJJ+v4fqThkKd0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392067; c=relaxed/simple;
	bh=hl9tDRwDQKsW9LtTGgLdCiTOPJLvskJO2eBDzKut1dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT2Jemx0WXZ669UuQFBs7rZrl88SdAo9s4ZHDll2kPl6Pi4xGqYmKqMvWZYkagc8T6bOXQmvZWyR5qBeONnY1fvg1kpu1nKecS/WtCeexLDgsKopjZRIZ+34yGC/r1oIkvzwNaAfJNbiHVI2vTyJ6qqCOSuyaNyN06euAuBtzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fshS5v6/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GyHaUurcX/968cY6G8Evo8k5/1kOtA+IGwx5RE4txdg=; b=fshS5v6/H1+vcNiHKHJ4eI3/k2
	kRvn30zyth5jPfJWNf3A0fuUTOL6O9yB+oN/BSWsTWYY9LsGxkLySli6I2ropzZIqMTYf2iCnuqKc
	dMdm+4udG8q2NprRt2PxtwLhazt36yuGLydUWwisVi4vgSPrrUqfKy4xX103qcloQM3WVComDJzKQ
	GDq2NpkPTTw3NCK3cucNAgOfLzznMYfkd25JOReAC/ZgiJnP3DFMak8UB00PbBsOGyDArFLHlwjH1
	UVphT3YhFbiXUOv+CPCOs72Im93u2tyDhs+ryi1OxrYHc4TeCneP7KkMRtSjbYSshmbsXvjyTZaoT
	wi8fwebg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ropFl-0000000H5As-3Ade;
	Mon, 25 Mar 2024 18:41:01 +0000
Date: Mon, 25 Mar 2024 18:41:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de,
	mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 04/11] readahead: rework loop in
 page_cache_ra_unbounded()
Message-ID: <ZgHFPZ9tNLLjKZpz@casper.infradead.org>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-5-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313170253.2324812-5-kernel@pankajraghav.com>

On Wed, Mar 13, 2024 at 06:02:46PM +0100, Pankaj Raghav (Samsung) wrote:
> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			 * not worth getting one just for that.
>  			 */
>  			read_pages(ractl);
> -			ractl->_index++;
> -			i = ractl->_index + ractl->_nr_pages - index - 1;
> +			ractl->_index += folio_nr_pages(folio);
> +			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
>  
> @@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			folio_put(folio);
>  			read_pages(ractl);
>  			ractl->_index++;
> -			i = ractl->_index + ractl->_nr_pages - index - 1;
> +			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}

You changed index++ in the first hunk, but not the second hunk.  Is that
intentional?

