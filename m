Return-Path: <linux-fsdevel+bounces-40688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29433A268E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 01:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8AA1883EE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 00:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFFC78F51;
	Tue,  4 Feb 2025 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="i9J0TpPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8B25A62E;
	Tue,  4 Feb 2025 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630055; cv=none; b=GbAmVvSNlt4XGEpBRClCh1ILMowroFjqmkMbiDSMIsUYzGC+/er34e+gIHMZf9AT/43rP5I5UNp92VzJhUhV3iu+TAbnJNF1KfuQwOmY5cwfQtb6JN2VDw3MZSAxLNJJE48zLz+vNh3TBXn2dl/k/auZ3daxHnDPjEbRTavMl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630055; c=relaxed/simple;
	bh=jmDmBKgdg+tglC1hAuRd+I3gUe9Geez71dH7vuTJP8o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VcrthwBv4nY1VEt8LgB6Xxbo7ynoa3arUOB3dBaNYBFct8OjSDnszt6cWtvd5yL3S7xq/61hfktd3j0kbs/Ia3N91bCx3LHALt3S563Jfoj/0iNgcU1pG386WpB7m8cPDbuh6PQbV/8U+4sAXiOa12U/xvNNdHZmtuJ7zxFhobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=i9J0TpPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD2BC4CEE4;
	Tue,  4 Feb 2025 00:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738630054;
	bh=jmDmBKgdg+tglC1hAuRd+I3gUe9Geez71dH7vuTJP8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i9J0TpPLqfCwqIhS4yhFauZVhJ4TuUZuMbvB3R02l6ePYKSpNO1W0zS6x3mHYYi7g
	 7Fg5HQqTWVm1ZBZwjcKxlLwfFwz/bbtYtagxrbQdIz3DeRqWX1PETn+wfCt+vq4vMi
	 /d3R4Mq9rATcGZhoTRTxbAC8v4fPS31ZNgZU2mvM=
Date: Mon, 3 Feb 2025 16:47:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter
 <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>, David
 Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, Jani Nikula
 <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik
 <josef@toxicpanda.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, Oscar Salvador
 <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, Steven Rostedt
 <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, Vlastimil
 Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao
 <yuzhao@google.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 06/11] mm/vmscan: Use PG_dropbehind instead of
 PG_reclaim
Message-Id: <20250203164733.f806902a6e5c91523c9e00fc@linux-foundation.org>
In-Reply-To: <42h65xowqe36eymr6pcomo7wzpe26kzwvyzg44hftqqczc5n6y@w2z5wvdrvktm>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
	<20250130100050.1868208-7-kirill.shutemov@linux.intel.com>
	<CAMgjq7AWZg0Y7+v3_Z8-YVUXrANB29mCDSyzF39dtAM_TQ0aKw@mail.gmail.com>
	<42h65xowqe36eymr6pcomo7wzpe26kzwvyzg44hftqqczc5n6y@w2z5wvdrvktm>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 10:39:58 +0200 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 4fe551037bf7..98493443d120 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1605,8 +1605,9 @@ static void folio_end_reclaim_write(struct folio *folio)
> >          * invalidation in that case.
> >          */
> >         if (in_task() && folio_trylock(folio)) {
> > -               if (folio->mapping)
> > -                       folio_unmap_invalidate(folio->mapping, folio, 0);
> > +               struct address_space *mapping = folio_mapping(folio);
> > +               if (mapping)
> > +                       folio_unmap_invalidate(mapping, folio, 0);
> >                 folio_unlock(folio);
> >         }
> >  }
> 
> Once you do this, folio_unmap_invalidate() will never succeed for
> swapcache as folio->mapping != mapping check will always be true and it
> will fail with -EBUSY.
> 
> I guess we need to do something similar to what __remove_mapping() does
> for swapcache folios.

Thanks, I'll drop the v3 series from mm.git.

