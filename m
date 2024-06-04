Return-Path: <linux-fsdevel+bounces-20935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780098FAF1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1851E1F24D79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9F1442F7;
	Tue,  4 Jun 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="BhxBAtgY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00F12B17B;
	Tue,  4 Jun 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494181; cv=none; b=omglR+4pu6aIoyRYLgE9HMTJKDtyDP9CvkUi5hT2SCh0vVczP6JrK32CtB3p2UFv7LXpgvAsFulTk4O6RbgwOveM1vB4hFP+89VsELF0ylDDk6wxR4pRhI3XDUSH/4hKfZK9+NfYr9XSTv7ACpwaZvynONXAxYk0ea8bAHtiZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494181; c=relaxed/simple;
	bh=MA1mKVUFSQbibfU52Ruzr7yQn+NzA2FeGtM1hmfDuTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML7StcBJ2SGpzGbOvAjQzLIqGONh1UZx6Kv1whUj2NyieRXDmKBi1XmpO7X6LcJsT3A0jJxEKRS3xgHBPeAy26MQGELt1lIJm7q7KM1LCCaemtNE0zzgWuEwozNiUSmSPN8a5zKpsKaDTuBgNNJJqQ+janJLNzFIBiaHm5jxs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=BhxBAtgY; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vtly2399bz9swF;
	Tue,  4 Jun 2024 11:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717494170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwfviVSUVjyzK7z0Oz8qcwUlgiOXWr8u7z2/yepDw0E=;
	b=BhxBAtgYhyhzPeOgmDqd34ZmUeefBR+MfK7CU65OVl+qKZoeSu7FVj9jW2Yr2xBqz9f+r9
	3ex9Ri1OiQGpL1UkdDImUVZUWHGVarixU1UKzZU9mfn2DHPiB6XHxoeeFKXEe/a40KTUxg
	sNFnRK149QKjw64Sa1vXgM2HIWt1zD9v+cxhjKCXMDBY+d3Q5/0wmj8vA5AbtfSoVDThLp
	igxWkSSOnahjECeHmWBYZFdIQxY8Ks1o1YVDyoVau8Hs8SyOKqbOT4t6IrIfgBW/9wYKet
	5BV2x1wNgCjnHAXATAQjCl4SiKrI+C+rBAuScByIpi7TjNNMCFQJMEya2imJaA==
Date: Tue, 4 Jun 2024 09:42:45 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, chandan.babu@oracle.com, akpm@linux-foundation.org,
	brauner@kernel.org, djwong@kernel.org, linux-kernel@vger.kernel.org,
	hare@suse.de, john.g.garry@oracle.com, gost.dev@samsung.com,
	yang@os.amperecomputing.com, p.raghav@samsung.com,
	cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
	mcgrof@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <20240604094245.zn5hqezd5q5eoehv@quentin>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-4-kernel@pankajraghav.com>
 <Zl20pc-YlIWCSy6Z@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl20pc-YlIWCSy6Z@casper.infradead.org>

On Mon, Jun 03, 2024 at 01:18:45PM +0100, Matthew Wilcox wrote:
> On Wed, May 29, 2024 at 03:45:01PM +0200, Pankaj Raghav (Samsung) wrote:
> > @@ -1919,8 +1921,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  		folio_wait_stable(folio);
> >  no_page:
> >  	if (!folio && (fgp_flags & FGP_CREAT)) {
> > -		unsigned order = FGF_GET_ORDER(fgp_flags);
> > +		unsigned int min_order = mapping_min_folio_order(mapping);
> > +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
> >  		int err;
> > +		index = mapping_align_start_index(mapping, index);
> >  
> >  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
> >  			gfp |= __GFP_WRITE;
> > @@ -1958,7 +1962,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  				break;
> >  			folio_put(folio);
> >  			folio = NULL;
> > -		} while (order-- > 0);
> > +		} while (order-- > min_order);
> 
> I'd argue you also need to change:
> 
> -                       if (order > 0)
> +			if (order > min_order)
>                                 alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> 
> since that is the last point at which we can fall back.  If we can't
> immediately allocate a min_order folio, we want to retry, and we
> want to warn if we can't get it.

That is a good point. It is also a feedback to the admin if they start
using LBS and assess the memory requirement based on memory alloc
warning?

--
Pankaj

