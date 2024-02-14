Return-Path: <linux-fsdevel+bounces-11532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90A8546E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE591F26F25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E017541;
	Wed, 14 Feb 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="dfPOhhPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C574171A6;
	Wed, 14 Feb 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905623; cv=none; b=BqDovX10X5svJk+3lz03aoGQB+Ehep4aMPlq+sy69mJVhPCmFiE5A7Fz6OErCpa++8XQtdCTqOQaDZ7hLwz0oczT78PEwX8+hGun1SyQGocWynIFos0qbefTzAikcfvQiUjadPjoFWrZgvAcoH0n+1sJUazkc4GW9ZEtb2BX03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905623; c=relaxed/simple;
	bh=zrB91wqBVkDC4s3OV3Y4T12bjoCXJSwWKQnWpDHyY1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpmSzEWpIlkB1VVBIrZRs3SS2JMFay+tw5RW4WMjDYlDm0tiUe5fW1WUFEnJ5zfttVO5DkwZ52EJEB+K4rTcyXCiYLFGdJzmTM3QLoPw97uhZ2M3jiZk/eVqsdVmyhPWOAFpUxyVPnHDmVMaksf1LArAVPv/dkl6pw4581A5Lrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=dfPOhhPg; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TZYtn2Pyrz9t7V;
	Wed, 14 Feb 2024 11:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707905617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tukJiiXHxlnAZSRWrSKvYIrOKtvtQgT2kcRjC7iKjgc=;
	b=dfPOhhPgpRh5rz/wIjBRF7DEF9ooEVW/TGmRGGvvJ4bRRbD9VBVGgWZsqHQyL2FAeBmbXr
	5kbQJlEP3G/FafnxH5LXfzU27cCWvRQFUhqCoBvFjv82vo9jted1y5DLLtdMLy7a2uD+z3
	1jYQfuGoLgxe5uVOZYbI0bpXYXls+9eNl/QUhBYcSyYp+6niCpZ9wxx0XPbW7vwaa7K5Q5
	9jPcNdvmGXtVYZftGaVdO3XyKKJ2Lu7hM8lC8/PA3CZpyUm97CwfMUJOBI+O5lXl+1OADF
	rnMpXX0+1KTzd851/9R0okrIHkxPOvxcbgEcr+oGS1AVeyAkn7cOpTKoFm8lxg==
Date: Wed, 14 Feb 2024 11:13:31 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 03/14] filemap: use mapping_min_order while allocating
 folios
Message-ID: <n7v4b4q6kyhwvbm66x4xvg7r6ttdqegikc7thf4o35vcff6mew@kjjh5db7tnc4>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-4-kernel@pankajraghav.com>
 <ZcvnlfyaBRhWaIzD@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcvnlfyaBRhWaIzD@dread.disaster.area>
X-Rspamd-Queue-Id: 4TZYtn2Pyrz9t7V

> > +++ b/mm/filemap.c
> > @@ -127,6 +127,7 @@
> >  static void page_cache_delete(struct address_space *mapping,
> >  				   struct folio *folio, void *shadow)
> >  {
> > +	unsigned int min_order = mapping_min_folio_order(mapping);
> >  	XA_STATE(xas, &mapping->i_pages, folio->index);
> >  	long nr = 1;
> >  
> > @@ -135,6 +136,7 @@ static void page_cache_delete(struct address_space *mapping,
> >  	xas_set_order(&xas, folio->index, folio_order(folio));
> >  	nr = folio_nr_pages(folio);
> >  
> > +	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
> >  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> 
> If you are only using min_order in the VM_BUG_ON_FOLIO() macro, then
> please just do:
> 
> 	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
> 			folio);
> 
> There is no need to clutter up the function with variables that are
> only used in one debug-only check.
> 
Got it. I will fold it in.

> > @@ -1847,6 +1853,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  		fgf_t fgp_flags, gfp_t gfp)
> >  {
> >  	struct folio *folio;
> > +	unsigned int min_order = mapping_min_folio_order(mapping);
> > +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> > +
> > +	index = round_down(index, min_nrpages);
> 
> 	index = mapping_align_start_index(mapping, index);

I will add this helper. Makes the intent more clear. Thanks.

> 
> The rest of the function only cares about min_order, not
> min_nrpages....
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

