Return-Path: <linux-fsdevel+bounces-42384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33247A4146F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 05:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB75188FB85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 04:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD851AAA1D;
	Mon, 24 Feb 2025 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVRthAn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0861EB3E;
	Mon, 24 Feb 2025 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740370455; cv=none; b=DAScDczAf6spQp4UrX7sl7XFV8rVb+6pkqP6Xsd5OsToCRmrBHtPlyOV+qNda9MIFE4HTMi0B6o2ShqCikNWxFpPvaD1bX4HE6/FvBsVgE2PbZ6YoyPZO6FKY+c1PS6dJDrF7feAPPwQ3Gr9Rv6aTuCd7ExENawIe+YxknSHXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740370455; c=relaxed/simple;
	bh=v4fYCedTc0qTMnm4Gc512gs9yjcyXyOH3zKeTar6uQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdahPK0f3ZWqbPdKlIh+4tEpG1uQmcTFBHbVLQFeQsTy7IZ6z5TVRUqhANnaBNSg6FYgU0qQeqF99OJ2nRjb5Dwuh0aU6YhsBvTlDNwBi/1OuDXgnH2RTBKgZftth8h9tE6vSURn9PlAipOv6WR8FzyVGoRznQ1rYVC1JmhJXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pVRthAn+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JoCq6Jz0t//yAHagLSB8UGfdvTzUw8oFXQk1EBIFNr4=; b=pVRthAn+XtisXAj11CGbPJxxZZ
	DN0KL99xN6g/0s+OJJ70cuDGYu8lzWYZ2On/bWtXlRJQBQEajWRh994WtYsGVUXbne6hWZDaqy3oW
	JJKVqPskYuBZ+QvxwvhnC0Ok9EBsZt8DM3ECakjlc35qB8gIZcxaVY7KriVEKraU2V12TAyItoX3V
	9eiS+YicI+T9uLmiF5rv4qOE3LUfC8bvQiF0b2WM3KprjaSufIPE/n2u4M2WvIXWbK9JMjqlFfKIk
	uwYpeRS/cLfg7nEIdUggwWutRtySsC4eWYU/BPvfsNDou043NwBVipPXUxhX4Turo6lqZfY21qlHr
	Z6gLMiMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmPr8-00000005mAP-0DQO;
	Mon, 24 Feb 2025 04:14:10 +0000
Date: Mon, 24 Feb 2025 04:14:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, Dave Chinner <david@fromorbit.com>, hch@lst.de
Subject: Re: [PATCH] mm: Fix error handling in __filemap_get_folio() with
 FGP_NOWAIT
Message-ID: <Z7vyEdJ3SqjFkE9q@casper.infradead.org>
References: <20250223235719.66576-1-raphaelsc@scylladb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223235719.66576-1-raphaelsc@scylladb.com>

On Sun, Feb 23, 2025 at 08:57:19PM -0300, Raphael S. Carvalho wrote:
> This is likely a regression caused by 66dabbb65d67 ("mm: return an ERR_PTR
> from __filemap_get_folio"), which performed the following changes:
>     --- a/fs/iomap/buffered-io.c
>     +++ b/fs/iomap/buffered-io.c
>     @@ -468,19 +468,12 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>     struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
>     {
>             unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
>     -       struct folio *folio;
> 
>             if (iter->flags & IOMAP_NOWAIT)
>                     fgp |= FGP_NOWAIT;
> 
>     -       folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
>     +       return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
>                             fgp, mapping_gfp_mask(iter->inode->i_mapping));
>     -       if (folio)
>     -               return folio;
>     -
>     -       if (iter->flags & IOMAP_NOWAIT)
>     -               return ERR_PTR(-EAGAIN);
>     -       return ERR_PTR(-ENOMEM);
>     }

We don't usually put this in the changelog ...

> Essentially, that patch is moving error picking decision to
> __filemap_get_folio, but it missed proper FGP_NOWAIT handling, so ENOMEM
> is being escaped to user space. Had it correctly returned -EAGAIN with NOWAIT,
> either io_uring or user space itself would be able to retry the request.
> It's not enough to patch io_uring since the iomap interface is the one
> responsible for it, and pwritev2(RWF_NOWAIT) and AIO interfaces must return
> the proper error too.
> 
> The patch was tested with scylladb test suite (its original reproducer), and
> the tests all pass now when memory is pressured.
> 
> Signed-off-by: Raphael S. Carvalho <raphaelsc@scylladb.com>

Instead, we add:

Fixes: 66dabbb65d67 (mm: return an ERR_PTR from __filemap_get_folio)

> ---
>  mm/filemap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 804d7365680c..b06bd6eedaf7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1986,8 +1986,15 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  
>  		if (err == -EEXIST)
>  			goto repeat;
> -		if (err)
> +		if (err) {
> +			/*
> +			 * Presumably ENOMEM, either from when allocating or
> +			 * adding folio (this one for xarray node)
> +			 */

I don't like the comment.  Better to do that in code:

			if ((fgp_flags & FGP_NOWAIT) && (err == -ENOMEM))

> +			if (fgp_flags & FGP_NOWAIT)
> +				err = -EAGAIN;
>  			return ERR_PTR(err);
> +		}
>  		/*
>  		 * filemap_add_folio locks the page, and for mmap
>  		 * we expect an unlocked page.
> -- 
> 2.48.1
> 

