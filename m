Return-Path: <linux-fsdevel+bounces-1514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C997DB152
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 00:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBC8B20D0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 23:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C9215487;
	Sun, 29 Oct 2023 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wo7WerlJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B412E51
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 23:32:20 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D836E9B;
	Sun, 29 Oct 2023 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=guqQZMi+S1KSEFshVxWJ2luwQG5HPiCtpJaksTTmti0=; b=Wo7WerlJhEgpQrY5ZBqa6AaM+u
	eR4dg/eHjvkTjQbqX3tLPPXvNPE/bgtdqm1WwiIVWjI11m6B+kDspU0GRBMULp/1I6L+mq3E66aQR
	G81NXlVt2ghXmGThaHLgGX+uWJWG68FiQYpLF5c/gYQ0+8U9ahKnxx8x7a2/gnce4PjMEvuxF6LcO
	e6b9sE5jh55LZ4Wic4UMfTL6J6IrCQnWpwdlV5NJfNbgu6FgVRFyhSvzl5p8UEUltyq4aPUR70u/B
	HeZ/L0OladO+JRwUOK4qruG0SWBCzPxw53IVJ+nOKiXvRld2K/OTG9HZdS2/pG3d/R2jC7WFHuN50
	vaepK3Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qxFGJ-000jDh-MM; Sun, 29 Oct 2023 23:32:07 +0000
Date: Sun, 29 Oct 2023 23:32:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "minchan@kernel.org" <minchan@kernel.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 10/11] shmem: add large folio support to the write
 path
Message-ID: <ZT7rd3CSr+VnKj7v@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211551eucas1p1552b7695f12c27f4ea1b92ecb6259b31@eucas1p1.samsung.com>
 <20231028211518.3424020-11-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-11-da.gomez@samsung.com>

On Sat, Oct 28, 2023 at 09:15:50PM +0000, Daniel Gomez wrote:
> +++ b/mm/shmem.c
> @@ -1621,6 +1621,9 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, struct shmem_inode_info *info,
>  	pgoff_t ilx;
>  	struct page *page;
>  
> +	if ((order != 0) && !(gfp & VM_HUGEPAGE))
> +		gfp |= __GFP_COMP;

This is silly.  Just set it unconditionally.

> +static inline unsigned int
> +shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
> +			 size_t size, struct shmem_sb_info *sbinfo)
> +{
> +	unsigned int order = ilog2(size);
> +
> +	if ((order <= PAGE_SHIFT) ||
> +	    (!mapping_large_folio_support(mapping) || !sbinfo->noswap))
> +		return 0;
> +
> +	order -= PAGE_SHIFT;

You know we have get_order(), right?


