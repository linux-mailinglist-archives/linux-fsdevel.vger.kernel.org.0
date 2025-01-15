Return-Path: <linux-fsdevel+bounces-39337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C29A12DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 22:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35379165947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8201DB366;
	Wed, 15 Jan 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ToVkVfF9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E5156F57;
	Wed, 15 Jan 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976962; cv=none; b=X8XFKSgsQKzoUcspr04GNv+galD0hVFZnqG810k394TR1vYztkLa+4tCGt9a3lisSVLyq30assSknwVvu8xxL4WRBo0QkU4Wh2BgL114UEhHnaNFu/jE3+8/0lQjXQmvZlaUm1kDP0nd8TMwKQ+yoBZTpJpwN9pm6vWtcPkzSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976962; c=relaxed/simple;
	bh=uexnwH3WY1Eo3zHvsjBwlvsQXyN0iY45WLMUVpn5ihU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+joh2kb0F7rJBq9td5sPSwsCBB6hCKTej4nvIKb6c9DiFMUw1nT+UooQxWomWDpLfVDDgDuFcqZbK6wcXnC1A8TNhxJGQCDO9vnhoca9EZPwUZxWZ57rkr3wMCtrdQtRtzBThCYK3dFZmGQ1AlbVjXuPboycva8d+3C2F6pD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ToVkVfF9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0OijV5p7C7RviN2UZr1cmsa6u4crmEp6ronCk1lgptI=; b=ToVkVfF9/LpCeHgqRA5mEb2Asr
	5IiQa1pSVMQ6mQ6jaE+0AsazgzqSxYkpPEmBGojEh8PatZnK/5QthRSP/VYH6rh70nn6Ke/EJPSqR
	pQvIeA+gO9O286BzuBzwiq2/nIhxNeuYTGDoy1KPurQxuR3srMkbURdzu+yYH6lHGZbedKnufVhtr
	S9bwMcCETcS5GTTW5WKl/k/od94Vb1K4FfaL3nYNNeJ4VYYUz82ygpQr3Bbz68Mw9tcQMJoi4Lsda
	Ph6zvEZ4kSPPfC4N68dEshZ6RHmhrllQtU2V+OMl8wsC0eInunxvmZ41WLChbyJSb3Mcunp/jP/Ca
	pMZOl1QA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYB30-00000002AHj-3YDk;
	Wed, 15 Jan 2025 21:35:34 +0000
Date: Wed, 15 Jan 2025 21:35:34 +0000
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
Subject: Re: [PATCHv2 05/11] mm/truncate: Use folio_set_dropbehind() instead
 of deactivate_file_folio()
Message-ID: <Z4gqJqcO8wau0sgN@casper.infradead.org>
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
 <20250115093135.3288234-6-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115093135.3288234-6-kirill.shutemov@linux.intel.com>

On Wed, Jan 15, 2025 at 11:31:29AM +0200, Kirill A. Shutemov wrote:
> -static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
> -{
> -	bool active = folio_test_active(folio) || lru_gen_enabled();
> -	long nr_pages = folio_nr_pages(folio);
> -
> -	if (folio_test_unevictable(folio))
> -		return;
> -
> -	/* Some processes are using the folio */
> -	if (folio_mapped(folio))
> -		return;
> -
> -	lruvec_del_folio(lruvec, folio);
> -	folio_clear_active(folio);
> -	folio_clear_referenced(folio);
> -
> -	if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
> -		/*
> -		 * Setting the reclaim flag could race with
> -		 * folio_end_writeback() and confuse readahead.  But the
> -		 * race window is _really_ small and  it's not a critical
> -		 * problem.
> -		 */
> -		lruvec_add_folio(lruvec, folio);
> -		folio_set_reclaim(folio);
> -	} else {
> -		/*
> -		 * The folio's writeback ended while it was in the batch.
> -		 * We move that folio to the tail of the inactive list.
> -		 */
> -		lruvec_add_folio_tail(lruvec, folio);
> -		__count_vm_events(PGROTATED, nr_pages);
> -	}
> -
> -	if (active) {
> -		__count_vm_events(PGDEACTIVATE, nr_pages);
> -		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
> -				     nr_pages);
> -	}
> -}

> +++ b/mm/truncate.c
> @@ -486,7 +486,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
>  			 * of interest and try to speed up its reclaim.
>  			 */
>  			if (!ret) {
> -				deactivate_file_folio(folio);
> +				folio_set_dropbehind(folio);

brr.

This is a fairly substantial change in semantics, and maybe it's fine.

At a high level, we're trying to remove pages from an inode that aren't
in use.  But we might find that some of them are in use (eg they're
mapped or under writeback).  If they are mapped, we don't currently
try to accelerate their reclaim, but now we're going to mark them
as dropbehind.  I think that's wrong.

If they're dirty or under writeback, then yes, mark them as dropbehind, but
I think we need to be a little more surgical here.  Maybe preserve the
unevictable check too.

