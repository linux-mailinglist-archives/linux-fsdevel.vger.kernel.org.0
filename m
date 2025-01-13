Return-Path: <linux-fsdevel+bounces-39054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636FA0BBEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2343618828DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39D1CAA8D;
	Mon, 13 Jan 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CdjcRBsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC44D8CE;
	Mon, 13 Jan 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782143; cv=none; b=maAdcA0UB+dCXHyvpwA/qosXtD6QFaokoSNR+U6mne89LnBU1kfF2q4k7hiHFL56IgWbx6cFfLgJbRE6fpZcUGQuID4YOYvPnjzF1vpLeFeaRqhPmK2Gjw6nhTVllc9Oti4R5QeFEbXo3tHeWQSM24bheZO6YHGag5j+m97ryPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782143; c=relaxed/simple;
	bh=L7hV/X2qpfcKhObUVS1SQQq2WwBVl4N9jZeRy8RDvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWp7ZeCUU2fBrs+hTDRlrnevVPhfa4RCR6RPvZ9bBgcCTirARNnCXxbJoFxEceifXy4KGvHpjem2udLMPBghNi8s27cxFOpNVCFSPPvcElk/RoLkuChM5LOVvK6sgcwaPm3Hn7DyklAuBELDhs4BxNMTC7Bc3NkQF1Ss9zPUG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CdjcRBsR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9VqsxP5RvX30QYR7yuJXPx1d9hNGDEzEGpTQhe2nivM=; b=CdjcRBsRqWXwULJgsV1wbho1ct
	7bTBs6L7iQzmzycFuSKc3xawEIdDX6neDB+BsFao8dw/hNdqvsbqz16LmPfb6KE9Mcb0Dpn99jDPU
	SEpzMg53tgwVFDsj8XeyPgFhGYX9YNh13TaZrHq+5FGvlZ6odcMzl7yyIGXswughRIwhc83j7oaUm
	6IDxxbc+Slmv5umkq69QkuB1Ij7g/qM4xeV06Wx5aT2zsL98dSTqjDZ3AqlWb0KCHznpS4kBEbclG
	n2e52Je5nmDYIbBQFg9qHHQKjP/1tcEMkuoo013fhgQH3BPgsPjDBRHZ1jUqeZ060nyxQygSxdZG3
	mRr0GgSg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMMt-00000000snb-2w4K;
	Mon, 13 Jan 2025 15:28:43 +0000
Date: Mon, 13 Jan 2025 15:28:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Airlie <airlied@gmail.com>,
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] mm: Remove PG_reclaim
Message-ID: <Z4UxK_bsFD7TtL1l@casper.infradead.org>
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-9-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113093453.1932083-9-kirill.shutemov@linux.intel.com>

On Mon, Jan 13, 2025 at 11:34:53AM +0200, Kirill A. Shutemov wrote:
> diff --git a/mm/migrate.c b/mm/migrate.c
> index caadbe393aa2..beba72da5e33 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -686,6 +686,8 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>  		folio_set_young(newfolio);
>  	if (folio_test_idle(folio))
>  		folio_set_idle(newfolio);
> +	if (folio_test_readahead(folio))
> +		folio_set_readahead(newfolio);
>  
>  	folio_migrate_refs(newfolio, folio);
>  	/*

Not a problem with this patch ... but aren't we missing a
test_dropbehind / set_dropbehind pair in this function?  Or are we
prohibited from migrating a folio with the dropbehind flag set
somewhere?

> +++ b/mm/swap.c
> @@ -221,22 +221,6 @@ static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
>  	__count_vm_events(PGROTATED, folio_nr_pages(folio));
>  }
>  
> -/*
> - * Writeback is about to end against a folio which has been marked for
> - * immediate reclaim.  If it still appears to be reclaimable, move it
> - * to the tail of the inactive list.
> - *
> - * folio_rotate_reclaimable() must disable IRQs, to prevent nasty races.
> - */
> -void folio_rotate_reclaimable(struct folio *folio)
> -{
> -	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
> -	    folio_test_unevictable(folio))
> -		return;
> -
> -	folio_batch_add_and_move(folio, lru_move_tail, true);
> -}

I think this is the last caller of lru_move_tail(), which means we can
get rid of fbatches->lru_move_tail and the local_lock that protects it.
Or did I miss something?

