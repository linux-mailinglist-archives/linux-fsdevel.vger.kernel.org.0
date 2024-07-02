Return-Path: <linux-fsdevel+bounces-22918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1A91F06A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE51C21A01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F5146010;
	Tue,  2 Jul 2024 07:42:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A0537E7;
	Tue,  2 Jul 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906131; cv=none; b=OH8VCf7EBlgHr2SMC/5SglnJ3ZegNZ4c7QTClz6soswiXMTOlYcS9z76A6gdelgyVQA8rJ61y+QRxM63ERIg2qNNNxVuJ4yudfSfAXw5bgDxagd9B6c27OjJKFeWlbtC7fsZEk7oSJN59mbU3Lxent56RMLg2udQoR9K+zWZJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906131; c=relaxed/simple;
	bh=XYA+tZcK3FwJGaNsBu0yee8YqNCuyxVDT51PYRw1Cik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5NgcILcQ7hEM8clpBOq9691+8CTnqNkgzBi5lyefkOlLKds3VI0m10xTihBpEZ6m2rztOzMCUIUqBFAUfT2i6cRHmnG6L8bvGLWn9U4FB3AcbiBFJnCrBzU3PhOJGUAmFucYdf8aY0io90j7VlDPl7VXU30WxIL0CM4JkiQZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D1EE68AFE; Tue,  2 Jul 2024 09:42:04 +0200 (CEST)
Date: Tue, 2 Jul 2024 09:42:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs >
 system page size
Message-ID: <20240702074203.GA29410@lst.de>
References: <20240625114420.719014-1-kernel@pankajraghav.com> <20240625114420.719014-7-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-7-kernel@pankajraghav.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 25, 2024 at 11:44:16AM +0000, Pankaj Raghav (Samsung) wrote:
> -static int __init iomap_init(void)
> +static int __init iomap_pagecache_init(void)
>  {
>  	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>  			   offsetof(struct iomap_ioend, io_bio),
>  			   BIOSET_NEED_BVECS);
>  }
> -fs_initcall(iomap_init);
> +fs_initcall(iomap_pagecache_init);

s/iomap_pagecache_init/iomap_buffered_init/

We don't use pagecache naming anywhere else in the file.

> +/*
> + * Used for sub block zeroing in iomap_dio_zero()
> + */
> +#define ZERO_PAGE_64K_SIZE (65536)

just use SZ_64K

> +#define ZERO_PAGE_64K_ORDER (get_order(ZERO_PAGE_64K_SIZE))

No really point in having this.

> +static struct page *zero_page_64k;

This should be a folio.  Encoding the size in the name is also really
weird and just creates churn when we have to increase it.


> +	/*
> +	 * Max block size supported is 64k
> +	 */
> +	WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);


A WARN_ON without actually erroring out here is highly dangerous. 

> +
>  	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);

Overly long line here.

> +
> +static int __init iomap_dio_init(void)
> +{
> +	zero_page_64k = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> +				    ZERO_PAGE_64K_ORDER);

> +
> +	if (!zero_page_64k)
> +		return -ENOMEM;
> +
> +	set_memory_ro((unsigned long)page_address(zero_page_64k),
> +		      1U << ZERO_PAGE_64K_ORDER);

What's the point of the set_memory_ro here?  Yes, we won't write to
it, but it's hardly an attack vector and fragments the direct map.


