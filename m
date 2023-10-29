Return-Path: <linux-fsdevel+bounces-1508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196A07DAE3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 21:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CE42814B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A00C8E4;
	Sun, 29 Oct 2023 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zk7tjG5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7F20FD
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 20:40:44 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A5B6;
	Sun, 29 Oct 2023 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6waNhTR+o+oIxNaOT4t0XGJ4/XH/ruK+m0W6clw3ZeA=; b=Zk7tjG5wKVi6QbIzzn68YStq16
	57v23MVZQgD9Aaslc6J29o8nzcPpfIaCNICUhBsZBFWuGIm8XfEb4vxCMaSF+dMJyfRZZi07/CGgV
	sq9JWVeF3tzdsytUaezhQGt7uEt3kznNRVGydmi4wwesl92UY36yqjC/Y0/egKMQP8n3B2Ox84iJE
	Lck0evHllaksBJxlVP8BALQSRbqJCSTILL45M6shVjKVkGevDSdjIYf7zH7U6neFoLVVttXDNmj/J
	GqUIRdN4WvbO8XPzALUPUTaYd/OG6DQWnwXvOBFQ6TZazcr+wnSIt0nL0HzyPXE0cerIxNEfumU2Q
	FN5UO73A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qxCaJ-00HaHF-Ko; Sun, 29 Oct 2023 20:40:36 +0000
Date: Sun, 29 Oct 2023 20:40:35 +0000
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
Subject: Re: [RFC PATCH 05/11] shmem: account for large order folios
Message-ID: <ZT7DQ3Ye/k6HDIpm@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211543eucas1p2c980dda91fdccaa0b5af3734c357b2f7@eucas1p2.samsung.com>
 <20231028211518.3424020-6-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-6-da.gomez@samsung.com>

On Sat, Oct 28, 2023 at 09:15:42PM +0000, Daniel Gomez wrote:
> @@ -856,16 +856,16 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>  						pgoff_t start, pgoff_t end)
>  {
>  	XA_STATE(xas, &mapping->i_pages, start);
> -	struct page *page;
> +	struct folio *folio;
>  	unsigned long swapped = 0;
>  	unsigned long max = end - 1;
>  
>  	rcu_read_lock();
> -	xas_for_each(&xas, page, max) {
> -		if (xas_retry(&xas, page))
> +	xas_for_each(&xas, folio, max) {
> +		if (xas_retry(&xas, folio))
>  			continue;
> -		if (xa_is_value(page))
> -			swapped++;
> +		if (xa_is_value(folio))
> +			swapped += folio_nr_pages(folio);

... you can't call folio_nr_pages() if xa_is_value().


