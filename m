Return-Path: <linux-fsdevel+bounces-40573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C6A2549E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A40C7A1BF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868331FBC8B;
	Mon,  3 Feb 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTnlTc6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3D1D7E50;
	Mon,  3 Feb 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572011; cv=none; b=cM5LpnVnOt7nyhOVUEkxA9eKix6HKCbXLwYYiQadZ/hNUNBe6GEN8Ven2qxzwpCeqDF7NhJ0CIf0nV8jzloFzFnPXQDrtvFrU7u6Q67VPKkqS5ID0LB6W/ZO2UJ86zxOwZoPxKZpPo774P2eD5+lhRIn8X7ApSvbP8PTnsEHH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572011; c=relaxed/simple;
	bh=7nb8HRa0cFbzBFBnN4bI0GsAQD01kUzx8HOrS7jz88s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPYuRk6PoZJqZ9J/Mcv12c900tB8VCaX4S8WrwjydnOqPRH9LxRTCgCPGJuLLDoX8w+gRgMm9yTR4Zr7rhI0nuQkrBuz9AffO4jkG0TiRHVfoVyH81uJw/JJ+jpTtdwxOYKGnCFlHMyJSAzYCM3TzRzLTSAOdGoDlKh/jI1LCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTnlTc6W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738572009; x=1770108009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7nb8HRa0cFbzBFBnN4bI0GsAQD01kUzx8HOrS7jz88s=;
  b=PTnlTc6WMsypsE1aCRyIwVH3LbvAzQESdXgB91gx+wQp/OhtD6WrcHKr
   tf2u0D13J1kzFzg1mJbFlFXveOy/UTtlXZqWkEvC7mAEe/b7CHJz9sQw8
   knLr7zHdkLtxPRd+kMXPoBaomMR+Z9jkMBZhcsELTMBrTVT5VvXT4/yxz
   05URi/U0LzEiYpLNlEODEPsqYCV9i61gLqEES7nmu/KRXLRsVS531/KWA
   oXAFYbrU2BUmgbII5qa67S5PyLeu3UP/+4wxrNbYwd/Pppr4o2bowLLrV
   yDtXsCUFdvrCD2SGrQbZAJbkWhAQ+eVxIdz8vQFAF5T0SsuyorZuA+7PJ
   Q==;
X-CSE-ConnectionGUID: lgpPdlxPR6OimqkatQlqYw==
X-CSE-MsgGUID: ZdN7GR0pT/G23mrNpPTXEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="26657675"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="26657675"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:40:08 -0800
X-CSE-ConnectionGUID: /pEpuut2SbaCB2xPbjWkbA==
X-CSE-MsgGUID: th6k5N9TR0e9cGBt5VIk/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="141100533"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 Feb 2025 00:40:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CF435214; Mon, 03 Feb 2025 10:39:58 +0200 (EET)
Date: Mon, 3 Feb 2025 10:39:58 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kairui Song <ryncsn@gmail.com>
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
Message-ID: <42h65xowqe36eymr6pcomo7wzpe26kzwvyzg44hftqqczc5n6y@w2z5wvdrvktm>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
 <20250130100050.1868208-7-kirill.shutemov@linux.intel.com>
 <CAMgjq7AWZg0Y7+v3_Z8-YVUXrANB29mCDSyzF39dtAM_TQ0aKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7AWZg0Y7+v3_Z8-YVUXrANB29mCDSyzF39dtAM_TQ0aKw@mail.gmail.com>

On Sat, Feb 01, 2025 at 04:01:43PM +0800, Kairui Song wrote:
> On Thu, Jan 30, 2025 at 6:02 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > The recently introduced PG_dropbehind allows for freeing folios
> > immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> > to be involved to get the folio freed.
> >
> > Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> > pageout().
> >
> > It is safe to leave PG_dropbehind on the folio if, for some reason
> > (bug?), the folio is not in a writeback state after ->writepage().
> > In these cases, the kernel had to clear PG_reclaim as it shared a page
> > flag bit with PG_readahead.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/vmscan.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bc1826020159..c97adb0fdaa4 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -692,19 +692,16 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
> >                 if (shmem_mapping(mapping) && folio_test_large(folio))
> >                         wbc.list = folio_list;
> >
> > -               folio_set_reclaim(folio);
> > +               folio_set_dropbehind(folio);
> > +
> >                 res = mapping->a_ops->writepage(&folio->page, &wbc);
> >                 if (res < 0)
> >                         handle_write_error(mapping, folio, res);
> >                 if (res == AOP_WRITEPAGE_ACTIVATE) {
> > -                       folio_clear_reclaim(folio);
> > +                       folio_clear_dropbehind(folio);
> >                         return PAGE_ACTIVATE;
> >                 }
> >
> > -               if (!folio_test_writeback(folio)) {
> > -                       /* synchronous write or broken a_ops? */
> > -                       folio_clear_reclaim(folio);
> > -               }
> >                 trace_mm_vmscan_write_folio(folio);
> >                 node_stat_add_folio(folio, NR_VMSCAN_WRITE);
> >                 return PAGE_SUCCESS;
> > --
> > 2.47.2
> >
> 
> Hi, I'm seeing following panic with SWAP after this commit:
> 
> [   29.672319] Oops: general protection fault, probably for
> non-canonical address 0xffff88909a3be3: 0000 [#1] PREEMPT SMP NOPTI
> [   29.675503] CPU: 82 UID: 0 PID: 5145 Comm: tar Kdump: loaded Not
> tainted 6.13.0.ptch-g1fe9ea48ec98 #917
> [   29.677508] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
> [   29.678886] RIP: 0010:__lock_acquire+0x20/0x15d0

Ouch.

I failed to trigger it my setup. Could you share your reproducer?

> I'm testing with PROVE_LOCKING on. It seems folio_unmap_invalidate is
> called for swapcache folio and it doesn't work well, following PATCH
> on top of mm-unstable seems fix it well:

Right. I don't understand swapping good enough. I missed this.

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4fe551037bf7..98493443d120 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1605,8 +1605,9 @@ static void folio_end_reclaim_write(struct folio *folio)
>          * invalidation in that case.
>          */
>         if (in_task() && folio_trylock(folio)) {
> -               if (folio->mapping)
> -                       folio_unmap_invalidate(folio->mapping, folio, 0);
> +               struct address_space *mapping = folio_mapping(folio);
> +               if (mapping)
> +                       folio_unmap_invalidate(mapping, folio, 0);
>                 folio_unlock(folio);
>         }
>  }

Once you do this, folio_unmap_invalidate() will never succeed for
swapcache as folio->mapping != mapping check will always be true and it
will fail with -EBUSY.

I guess we need to do something similar to what __remove_mapping() does
for swapcache folios.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

