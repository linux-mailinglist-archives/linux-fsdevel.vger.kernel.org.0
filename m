Return-Path: <linux-fsdevel+bounces-34691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139069C7B99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6105282896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35609204096;
	Wed, 13 Nov 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rt8QDIsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504732038B1;
	Wed, 13 Nov 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523822; cv=none; b=M/U5F3PGth6EjkoKG3YDcYS0hybx3pDu013h4Mce12EJBtmw1ixfh/B+sUol/PdskEkNN+Ep1q8qrOZs8yYXvyYd1lMj2z0IOW7i0EkoDmOIY8wMDEBPqDuLrZJ6qSCsVGxl1Db9meXZ0AWR0LbMIZGzRTMGfI6obfG7zIDYIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523822; c=relaxed/simple;
	bh=lroZCjWsJZyiMWEIuQQYqpMZWiIy0VXTc6cPD6rMTr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRIetDFfgWA6gUTV7/iKD6TJ805R3bPzz+XqAeo6wwPANieqj21vwRXljE8Y1ENsD+duL+KrzVVj6aWl6wUSY7y7hkcJiSvJHBu2dEPaZTSaCYnzQHrBJPRaJaDRZDBK32LuA6a+JWe1YVvOPeTECJ1PZvTVEK/bOT+4xTI+1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rt8QDIsl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nq4bIv/oWAf5S/k6VezA2o3s5y3i68pnNRbJOq/1fys=; b=rt8QDIslv6vKhdttNZX4KMHBgg
	5rl21C15AExxBj/UuxibOZ2pLvOH/X3tEz3ttM3USKRU5DH5BxqCMPo2D7155b2C5MVBhca4QsiBr
	Mgq35ZgaRJHrSu5zftli9ajbT1duhfPDFqr/hvIrY3y+IJM/G7i5VSGDMoD/ZKLApifIHrkVaygi7
	sZUkmgn8iqs/c5fd4iZFI7CMAvcAp9QEw3jwAyNqraRoxBtSDdBHkZPCwQmjAICvJFXJyXdtcJD6r
	mXXkAWh4dch5sGD4hQX9Vg0vPPGISrrf1RrQrh28zscIdV1AVQW7i8Z+o0/cV/rIfyEWvICM880k8
	2LDKjB8w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIRN-0000000GmSQ-0rjk;
	Wed, 13 Nov 2024 18:50:09 +0000
Date: Wed, 13 Nov 2024 18:50:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [RFC 3/8] fs/buffer: restart block_read_full_folio() to avoid
 array overflow
Message-ID: <ZzT04C0iwlkxg6aL@casper.infradead.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113094727.1497722-4-mcgrof@kernel.org>

On Wed, Nov 13, 2024 at 01:47:22AM -0800, Luis Chamberlain wrote:
> +++ b/fs/buffer.c
> @@ -2366,7 +2366,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	sector_t iblock, lblock;
> -	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
> +	struct buffer_head *bh, *head, *restart_bh = NULL, *arr[MAX_BUF_PER_PAGE];

MAX_BUF_PER_PAGE is a pain.  There are configs like hexagon which have
256kB pages and so this array ends up being 512 * 8 bytes = 4kB in size
which spews stack growth warnings.  Can we just make this 8?

> @@ -2385,6 +2385,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  	iblock = div_u64(folio_pos(folio), blocksize);
>  	lblock = div_u64(limit + blocksize - 1, blocksize);
>  	bh = head;
> +restart:
>  	nr = 0;
>  	i = 0;
>  
> @@ -2417,7 +2418,12 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  				continue;
>  		}
>  		arr[nr++] = bh;
> -	} while (i++, iblock++, (bh = bh->b_this_page) != head);
> +	} while (i++, iblock++, (bh = bh->b_this_page) != head && nr < MAX_BUF_PER_PAGE);
> +
> +	if (nr == MAX_BUF_PER_PAGE && bh != head)
> +		restart_bh = bh;
> +	else
> +		restart_bh = NULL;
>  
>  	if (fully_mapped)
>  		folio_set_mappedtodisk(folio);
> @@ -2450,6 +2456,15 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  		else
>  			submit_bh(REQ_OP_READ, bh);
>  	}
> +
> +	/*
> +	 * Found more buffers than 'arr' could hold,
> +	 * restart to submit the remaining ones.
> +	 */
> +	if (restart_bh) {
> +		bh = restart_bh;
> +		goto restart;
> +	}
>  	return 0;

This isn't right.

Let's assume we need 16 blocks to fill in this folio and we have 8
entries in 'arr'.

        nr = 0;
        i = 0;

        do {
                if (buffer_uptodate(bh))
                        continue;
...
                arr[nr++] = bh;
        } while (i++, iblock++, (bh = bh->b_this_page) != head);

        for (i = 0; i < nr; i++) {
                bh = arr[i];
                        submit_bh(REQ_OP_READ, bh);

OK, so first time round, we've submitted 8 I/Os.  Now we see that
restart_bh is not NULL and so we go round again.

This time, we happen to find that the last 8 BHs are uptodate.
And so we take this path:

        if (!nr) {
                /*
                 * All buffers are uptodate or get_block() returned an
                 * error when trying to map them - we can finish the read.
                 */
                folio_end_read(folio, !page_error);

oops, we forgot about the 8 buffers we already submitted for read.

