Return-Path: <linux-fsdevel+bounces-18180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A148B61C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42F9286C70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482713AD31;
	Mon, 29 Apr 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6le/KRO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771112B73;
	Mon, 29 Apr 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418064; cv=none; b=Lldaj84dxb5NO2uQDoIDwHrgVFNf1DlY+5tP2tgA7434BCEfD/G18CMsCypIIWhCY+nc8KexzBp4CetRifuvZEolv4eaK+VVrIGunHXksoiEQRXxo+oOnV2MOPPX4yYKGgD2uSI4D2Hg2FFMRszVjmqi8v0uUVsFDyjALxuIJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418064; c=relaxed/simple;
	bh=zODzf1KptBMmuo06vCReSia1Rwp41xsxcE7rbHPQpKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQYMzS/psAMM9aLyLtIzp2SCZnQ7WBsNU6uxakBFwSveOzSFiB/BxAsi80WTArYO1L9Vr1vWWKLhRhfq3b3jmf6ax5E4GB41Rls8868uSda5BeU+wNm+q4pxciWZulwN36W2d4325hwtUHHZUWVhBpbv76ks3rTnB5+sPaURUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z6le/KRO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T8mi5fuQMjyC+zCauZm3C5RMQMUvqEO4+XbkT4fjPOk=; b=Z6le/KROYcC+NFOlYV92v27bVl
	D7LvXRrBcHno7hue80XlJt4wr3n1KKwZKSza2q//ky7/hy/weTSkhBfFOqb/3rHpoZ5CNozamhiAD
	gsILdQ1+0QDHy9ylsXFFBScu0S5yiehlE1eKkqNkqCYa9211wEUgG4z2HT+Xp+d2dCbpnIrToTRMs
	w/qlTEBN3nUZf7lMgiU4vxCRlKAciMqJRrM2lfFjOlCyG9EBxoDvWtcl467Jf5Xq4fVXCL+hfkzSz
	NctnbUk1cVBDLbyvA/k1qDgOhXkLr8+mFPEiqcPl6FWjUKrddNmyLciXh4KSIXOG7acTHLJfYTSkB
	f9TvWQWA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1WRs-0000000D975-0t3R;
	Mon, 29 Apr 2024 19:14:00 +0000
Date: Mon, 29 Apr 2024 20:14:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v3 02/12] nilfs2: drop usage of page_index
Message-ID: <Zi_xeKUSD6C8TNYK@casper.infradead.org>
References: <20240429190500.30979-1-ryncsn@gmail.com>
 <20240429190500.30979-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429190500.30979-3-ryncsn@gmail.com>

On Tue, Apr 30, 2024 at 03:04:50AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> page_index is only for mixed usage of page cache and swap cache, for
> pure page cache usage, the caller can just use page->index instead.
> 
> It can't be a swap cache page here (being part of buffer head),
> so just drop it, also convert it to use folio.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: linux-nilfs@vger.kernel.org
> ---
>  fs/nilfs2/bmap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index 383f0afa2cea..f4e5df0cd720 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -453,9 +453,8 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap *bmap,
>  	struct buffer_head *pbh;
>  	__u64 key;
>  
> -	key = page_index(bh->b_page) << (PAGE_SHIFT -
> -					 bmap->b_inode->i_blkbits);
> -	for (pbh = page_buffers(bh->b_page); pbh != bh; pbh = pbh->b_this_page)
> +	key = bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkbits);
> +	for (pbh = folio_buffers(bh->b_folio); pbh != bh; pbh = pbh->b_this_page)
>  		key++;
>  
>  	return key;

Why isn't this entire function simply:

	return bh->b_blocknr;

