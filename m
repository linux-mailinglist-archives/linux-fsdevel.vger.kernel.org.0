Return-Path: <linux-fsdevel+bounces-22547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F891997D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 22:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE422834D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F4019306A;
	Wed, 26 Jun 2024 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WjjofFyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B48F47;
	Wed, 26 Jun 2024 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435284; cv=none; b=pwkTR1GiWa/RsFEGYgwFUlqLswfkdc/yNyqbzpeUspQkohJx62Cg9P6UciMw+BfTYcM42xaGkpZEMlNw2EVLc8HRg8gUSqVVXw5L9I7c7S1zm8ZZx5gNynacYzQYkXNM6l5mjuEg4tcF2belEKr+Jooa6vUDIyms5RhZc+kw+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435284; c=relaxed/simple;
	bh=zEMXbnBoRRda3mdOzdaRMplmfd7vbWJnu3aq+jGq+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/KI38tLKrRqImlxByVXBEejR/edYKorYqWs3WDREW9mz1ipVFwfk4+TS3VFbal8Ae1jYU1Lsw5ushfWtX834UwrztIAd3ja7uX7glZRqnenmiYyg5RJt6Z5ta1NndKtLzD8ZekpbGK6imQXPdvGWgcDiT1raU2CEDUngePVBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WjjofFyt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0MaWDSzUymrD19+o4vqZ4gUCAu6OrygEIztpx1MGf1w=; b=WjjofFytOFt+muSmGP6W8FRO/F
	ogy5ZKRWrwtYxOMni6oqwKFkjpN0NwfCS4PQKP95FyfyKmZQ7VOxlr9a5plK+99kfFpsOfe4i0ry+
	lh5a4b3Wcdar0cmVRifQfpzEjh0u/nvqzg/rHczCixX4m9nkZn6pJW+J2ZEhwInQRS0LmAGQMDfFw
	9lvSLfjUUE77tUO3F8TuPum3gG/5e2WZZNPI526tv+N15OUDBgpmkL/QIYem32xteQqTrG6g8kYys
	lfNXXBRpWANiIoxeyYzz5rT9jWHwILEa/DDC9o+vU08ODcHhE+/QUKnUvg1JlnK6m7gDKjfR76r1V
	4OBT1DwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMZf5-0000000Clbm-2fdN;
	Wed, 26 Jun 2024 20:54:39 +0000
Date: Wed, 26 Jun 2024 21:54:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gavin Shan <gshan@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, hughd@google.com, torvalds@linux-foundation.org,
	zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
Message-ID: <ZnyAD24AQFzlKAhD@casper.infradead.org>
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
 <33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
 <20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
 <f27d4fa3-0b0f-4646-b6c3-45874f005b46@redhat.com>
 <4b05bdae-22e8-4906-b255-5edd381b3d21@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b05bdae-22e8-4906-b255-5edd381b3d21@redhat.com>

On Wed, Jun 26, 2024 at 10:37:00AM +1000, Gavin Shan wrote:
> On 6/26/24 5:05 AM, David Hildenbrand wrote:
> > On 25.06.24 20:58, Andrew Morton wrote:
> > > On Tue, 25 Jun 2024 20:51:13 +0200 David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > > > I could split them and feed 1&2 into 6.10-rcX and 3&4 into 6.11-rc1.  A
> > > > > problem with this approach is that we're putting a basically untested
> > > > > combination into -stable: 1&2 might have bugs which were accidentally
> > > > > fixed in 3&4.  A way to avoid this is to add cc:stable to all four
> > > > > patches.
> > > > > 
> > > > > What are your thoughts on this matter?
> > > > 
> > > > Especially 4 should also be CC stable, so likely we should just do it
> > > > for all of them.
> > > 
> > > Fine.  A Fixes: for 3 & 4 would be good.  Otherwise we're potentially
> > > asking for those to be backported further than 1 & 2, which seems
> > > wrong.
> > 
> > 4 is shmem fix, which likely dates back a bit longer.
> > 
> > > 
> > > Then again, by having different Fixes: in the various patches we're
> > > suggesting that people split the patch series apart as they slot things
> > > into the indicated places.  In other words, it's not a patch series at
> > > all - it's a sprinkle of independent fixes.  Are we OK thinking of it
> > > in that fashion?
> > 
> > The common themes is "pagecache cannot handle > order-11", #1-3 tackle "ordinary" file THP, #4 tackles shmem THP.
> > 
> > So I'm not sure we should be splitting it apart. It's just that shmem THP arrived before file THP :)
> > 
> 
> I rechecked the history, it's a bit hard to have precise fix tag for PATCH[4].
> Please let me know if you have a better one for PATCH[4].
> 
> #4
>   Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>   Cc: stable@kernel.org # v4.10+
>   Fixes: 552446a41661 ("shmem: Convert shmem_add_to_page_cache to XArray")
>   Cc: stable@kernel.org # v4.20+
> #3
>   Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>   Cc: stable@kernel.org # v5.18+
> #2
>   Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
>   Cc: stable@kernel.org # v5.18+
> #1
>   Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>   Cc: stable@kernel.org # v5.18+

I actually think it's this:

commit 6b24ca4a1a8d
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sat Jun 27 22:19:08 2020 -0400

    mm: Use multi-index entries in the page cache

    We currently store large folios as 2^N consecutive entries.  While this
    consumes rather more memory than necessary, it also turns out to be buggy.
    A writeback operation which starts within a tail page of a dirty folio will
    not write back the folio as the xarray's dirty bit is only set on the
    head index.  With multi-index entries, the dirty bit will be found no
    matter where in the folio the operation starts.

    This does end up simplifying the page cache slightly, although not as
    much as I had hoped.

    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
    Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Before this, we could split an arbitrary size folio to order 0.  After
it, we're limited to whatever the xarray allows us to split.

