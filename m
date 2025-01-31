Return-Path: <linux-fsdevel+bounces-40520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA3A244AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 22:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577B816443D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 21:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410CF1F3FFA;
	Fri, 31 Jan 2025 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jyD9gPXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1861E9B1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738359200; cv=none; b=RynhNajXKqkhbG9WjGurCQbT1EdUc0LggeWQ18sI0iYSIaRUT5ZYZrplJZktjdQWS91Ilh/UlkMxu7J9YTTFohZQwIcMkXtFpY2RwPE57n5PAlPyABULkoNTOjjNIuRX+yz46+bUaT93nLGfmnMfymRHfvzZ8gsjqSkZVZ1O+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738359200; c=relaxed/simple;
	bh=s6IiBELlRbJ9m5KhNZGC7jqONMebFZXJz0DSonG69f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCF2wh8iX03uEXNR738ea9ONU74uz3af7PyHsC/yjMl+5DFm8nQOGOPmhilLQ2a1QoyNi3IiuZu4aONFKG2PYl0frrN510jwIcS18I+wnuZgr8GvrczjsRZhsIeo5Kp+IuWi4qVM+kOik8o2Tu+fSXkPY4sPcgsowyjNWGtwiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jyD9gPXS; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 31 Jan 2025 13:32:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738359184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKADDN/gzLU5ps4Oe+ymmjbVA+yTOl27darYW9+bIr0=;
	b=jyD9gPXS1WTaul95TpeSAfE5cKe6GAm6eOkWb/GiX7s5qiCfSRB8BaOinWtNL/E622IZjh
	0QScNYaKTFt28s6IqWK1DsqmrG5njsWa/Py97/n3byOUomQBe9xiy4XrKkYlPSzhlhYxVK
	kdV1A0T7T9VIc3IRqV+q4ufc53+aXuY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 06/11] mm/vmscan: Use PG_dropbehind instead of
 PG_reclaim
Message-ID: <lpptopwuxbfixeigoxs44rrpg6sm5mviai3uy7sxvvng3twyer@xpul6sjcvvjj>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
 <20250130100050.1868208-7-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130100050.1868208-7-kirill.shutemov@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 12:00:44PM +0200, Kirill A. Shutemov wrote:
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
> 
> Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> pageout().
> 
> It is safe to leave PG_dropbehind on the folio if, for some reason
> (bug?), the folio is not in a writeback state after ->writepage().
> In these cases, the kernel had to clear PG_reclaim as it shared a page
> flag bit with PG_readahead.

Is it correct to say that leaving PG_dropbehind on folios which doesn't
have writeback state after ->writepage() (i.e. store to zswap) is fine
because PG_dropbehind is not in PAGE_FLAGS_CHECK_AT_FREE?

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/vmscan.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bc1826020159..c97adb0fdaa4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -692,19 +692,16 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>  		if (shmem_mapping(mapping) && folio_test_large(folio))
>  			wbc.list = folio_list;
>  
> -		folio_set_reclaim(folio);
> +		folio_set_dropbehind(folio);
> +
>  		res = mapping->a_ops->writepage(&folio->page, &wbc);
>  		if (res < 0)
>  			handle_write_error(mapping, folio, res);
>  		if (res == AOP_WRITEPAGE_ACTIVATE) {
> -			folio_clear_reclaim(folio);
> +			folio_clear_dropbehind(folio);
>  			return PAGE_ACTIVATE;
>  		}
>  
> -		if (!folio_test_writeback(folio)) {
> -			/* synchronous write or broken a_ops? */
> -			folio_clear_reclaim(folio);
> -		}
>  		trace_mm_vmscan_write_folio(folio);
>  		node_stat_add_folio(folio, NR_VMSCAN_WRITE);
>  		return PAGE_SUCCESS;
> -- 
> 2.47.2
> 

