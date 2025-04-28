Return-Path: <linux-fsdevel+bounces-47461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A294EA9E580
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA26189B006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 00:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A778F4E;
	Mon, 28 Apr 2025 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T98fcr7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894D8BF8;
	Mon, 28 Apr 2025 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745800688; cv=none; b=Lg3S4DMYigtDlQIqEwn+GEcXsKoFn/Kd3nlV1dGUXkX6kSGqMLTW/yjid46F8G1GSyMtpkfGeaWyTBo7MS6J41e/XM2TQtPFYfvIOzfvV1DWSHUFM3HB17zszehVH0LeTlYbjaz+g8DD2/aJ5sFuuE+PdmVsTkgD25s+LfePM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745800688; c=relaxed/simple;
	bh=X93ENz4hZ9SghUIv/n963X0gxLuWiGrP0pFJLjKpsSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH1BI2+zyLbU9VoSDwk6Tuh7aG1gqVESVPoGL1men+YxhYOov8eKbnbYy91v0UACEAZSvtNp6aY8DRMfpvAqHQVXFWnnJAihgDtuKrRsUVAKB2eg0gF3/to++goPTPSBG0aYcjx6fRFOJNtWbjuz3w1aQcDkaBbkE90VcaBx/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T98fcr7o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WwuY/6ttiqKGxuiZxXTw1pq5GZbsJP4t0dCyVGoDwXg=; b=T98fcr7okBkuiBWbdzq0KStxgu
	umKA8nfSz3IUntLKD9imBZ9mgjMydQgtVoRWFQa98SrZltEw4jaWcTDdSEC68GcEkGi2IalBR8f3V
	eGWyQ9kwIvYWbaI3Qegv4BgikQaEaFmT10qJxtH704B0V69FdqofAku90hZCFn3KFvBh4V/WkS0ra
	1feaPdT1TkFkrSYxBGuGYXxoc2MpVxS8eqBKBY4K3iWZMR5sqcCcGNXFljbPl0X1w2pfov9IkPBiM
	dPEsfuAGULpUBPOIQpgvsp6RVdCPjmBrwDhcSQo8m00+jv8hmnS4xLUyvQUWGW7Oi2hoB6NkmTjRh
	xEZcWOwg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9CVC-00000004ewq-0kBu;
	Mon, 28 Apr 2025 00:37:42 +0000
Date: Mon, 28 Apr 2025 01:37:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fuse: drop usage of folio_index
Message-ID: <aA7N1SHoR-tY4PJW@casper.infradead.org>
References: <20250427185908.90450-1-ryncsn@gmail.com>
 <20250427185908.90450-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427185908.90450-2-ryncsn@gmail.com>

On Mon, Apr 28, 2025 at 02:59:03AM +0800, Kairui Song wrote:
> folio_index is only needed for mixed usage of page cache and swap
> cache, for pure page cache usage, the caller can just use
> folio->index instead.
> 
> It can't be a swap cache folio here.  Swap mapping may only call into fs
> through `swap_rw` and that is not supported for fuse.  So just drop it
> and use folio->index instead.
> 
> uigned-off-by: Kairui Song <kasong@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> @@ -2349,7 +2349,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
>  		return true;
>  
>  	/* Discontinuity */
> -	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
> +	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio->index)
>  		return true;

This looks like a pre-existing bug.

-	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	prev_folio = data->orig_folios[ap->num_folios - 1];
+	if (prev_folio->index + folio_nr_pages(prev_folio) != folio->index)
		return true;

