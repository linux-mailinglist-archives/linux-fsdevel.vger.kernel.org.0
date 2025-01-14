Return-Path: <linux-fsdevel+bounces-39119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6598A1020B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC2218825B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AF1CEEA4;
	Tue, 14 Jan 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFgyCgX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BB1C07C3;
	Tue, 14 Jan 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843457; cv=none; b=Kme8pmXW6imQlWWmzJ7LtI3oV6MhCLmFMCyNZkz6vMMoYr6GPmJzcJudMM2NVYDrromz5UK3QK404vkz1P3RT0l2eQ1TBiYX3R05QFQWuvdmJY3jT2VxvrNzB3mRNyW+3hNlxiM/EwhMEMrVk+G/nx6REchQXQZUpvk4PMHxeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843457; c=relaxed/simple;
	bh=d76ZuYXYGd5MhYXwKrUOaL/NFOW9yG6blep811EcGeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcqPS2uQGawWqWqUbFPb9xQxKociCVOIUdt3g3RWhFccTBGoRh0SSe778ywexuwSz5uEriu6np6RetFv92W57tHAuxUN07uQNVxW7Trj5gvPzDdc/MEAN1T7Cb8UXECx7NpqQy0IV0xqk+JsjhxKiZaNTrms6W6VMTscJAxNqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFgyCgX1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736843455; x=1768379455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d76ZuYXYGd5MhYXwKrUOaL/NFOW9yG6blep811EcGeg=;
  b=CFgyCgX16mwWlhGyfMpK3ByL7XgQN+9XpmFGjyVWnQf/9jFy/+ei+mHg
   +6vsYfHnXxT66Vmy7pNHxmhafPkXy2QYT/5ldBvhpTXfvszZSSjIt3xHq
   EIdIFHW0i8oneTIIcjiN16qALeguS79OwTdcl64aAo5TXauZSym8p8fBR
   QMQ5uLusJGsooY/QilHzw67ES2Bdh69Jl2lLYTAdwLlQAdyHsaTPnOs3P
   SvYZUZSp1xTi4rIjcVTr5ExAKnh1hFWESb9VT8nk43DwWuwRntzJE1uUq
   5tuQefcKTygKEd96Sft9ggemIuYfFHfPEVov4Ebit9DEteNhF9h+8tJ5w
   A==;
X-CSE-ConnectionGUID: TyWPe7nBS16NHAk99ORPRw==
X-CSE-MsgGUID: EPd2tT4lTvewxfTr71sEhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37241821"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37241821"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:30:54 -0800
X-CSE-ConnectionGUID: OGS8UdzDSvmjat/Rleu/Tg==
X-CSE-MsgGUID: Yr9g/hOpTTeh7GM4krWnuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109880457"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 14 Jan 2025 00:30:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B879339C; Tue, 14 Jan 2025 10:30:45 +0200 (EET)
Date: Tue, 14 Jan 2025 10:30:45 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
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
Subject: Re: [PATCH 8/8] mm: Remove PG_reclaim
Message-ID: <vpy2hikqvw3qrncjdlxp6uonpmbueoulhqipdkac7tav4t7m2s@3ebncdtepyv6>
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-9-kirill.shutemov@linux.intel.com>
 <Z4UxK_bsFD7TtL1l@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UxK_bsFD7TtL1l@casper.infradead.org>

On Mon, Jan 13, 2025 at 03:28:43PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 13, 2025 at 11:34:53AM +0200, Kirill A. Shutemov wrote:
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index caadbe393aa2..beba72da5e33 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -686,6 +686,8 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
> >  		folio_set_young(newfolio);
> >  	if (folio_test_idle(folio))
> >  		folio_set_idle(newfolio);
> > +	if (folio_test_readahead(folio))
> > +		folio_set_readahead(newfolio);
> >  
> >  	folio_migrate_refs(newfolio, folio);
> >  	/*
> 
> Not a problem with this patch ... but aren't we missing a
> test_dropbehind / set_dropbehind pair in this function?  Or are we
> prohibited from migrating a folio with the dropbehind flag set
> somewhere?

Hm. Good catch.

We might want to drop clean dropbehind pages instead migrating them.

But I am not sure about dirty ones. With slow backing storage it might be
better for the system to migrate them instead of keeping them in the old
place for potentially long time.

Any opinions?

> > +++ b/mm/swap.c
> > @@ -221,22 +221,6 @@ static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
> >  	__count_vm_events(PGROTATED, folio_nr_pages(folio));
> >  }
> >  
> > -/*
> > - * Writeback is about to end against a folio which has been marked for
> > - * immediate reclaim.  If it still appears to be reclaimable, move it
> > - * to the tail of the inactive list.
> > - *
> > - * folio_rotate_reclaimable() must disable IRQs, to prevent nasty races.
> > - */
> > -void folio_rotate_reclaimable(struct folio *folio)
> > -{
> > -	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
> > -	    folio_test_unevictable(folio))
> > -		return;
> > -
> > -	folio_batch_add_and_move(folio, lru_move_tail, true);
> > -}
> 
> I think this is the last caller of lru_move_tail(), which means we can
> get rid of fbatches->lru_move_tail and the local_lock that protects it.
> Or did I miss something?

I see lru_move_tail() being used by lru_add_drain_cpu().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

