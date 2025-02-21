Return-Path: <linux-fsdevel+bounces-42208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F6A3EBFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 05:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60A4189FF17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 04:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC51F8EF7;
	Fri, 21 Feb 2025 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pREs7JkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC26F9D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740113719; cv=none; b=Sk5KQSW40whFkGRPj6NtGTsupeTvci492wT28xiCp/wt1rA8sVWD+jJe4m9bu2eNCc2m+1TgtwukohS9s8fcLjEbKeroxR7QtP0BUQUkUUWnBaMHDsl3/jkng0ohgxA2ZV9vuKKQVeBPA9GVGyabRv51YPySSK3FmbfcCw48MN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740113719; c=relaxed/simple;
	bh=TRrzP0CzcVFMmpJmC4JuqExk9+bEFTrmjzrUl7P32zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p38ZUnuB8SfOlsLcxs6LA2z4T+WcyDaKRtgVPIF/RZLeOpIJZB0lPN/5NlcHPuXe+7IpQcTEAJ22/zdkqD2LGCyq7XXTPxGkEPhpiKanOaQyGnI3ztYzb9edfNPsAVIrOeLqDwzNNGGkhb95IgMu2ktt6eiRWKeUcGp9nWd3WWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pREs7JkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E556C4CEE2;
	Fri, 21 Feb 2025 04:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740113718;
	bh=TRrzP0CzcVFMmpJmC4JuqExk9+bEFTrmjzrUl7P32zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pREs7JkFO7CYYWH8ZpiN7cqx7xyHHCRaPb2iyeGo0yAlDCJtRaFsU4akHKcaEwXlG
	 QHOqiH75KyJoSXzpBxSukeffFi/B3HcJEjLMArOOBCqtFf+i7gzHQI7Pd4Dj7sDE/n
	 dbYDxP9h7sAWRC2hofXAIfLVb8t42TulN+taDuxEqU0K4IZVGVPp7c+xmRmtZ+ewSO
	 yWH7vwPrXx6kF0CXRN1PNIKeo7K3ZDX1xtISS4YmYmxvo67ZnNdpu8dW3Huap10RZj
	 ++yaDHIvpCLoVA/5LlxIvAkaR5p01adyV65/egDNhzeTc/90SJurTcb16i61yDAA6h
	 zbwi7l/PDCOVA==
Date: Fri, 21 Feb 2025 04:55:16 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/27] f2fs: Add f2fs_folio_put()
Message-ID: <Z7gHNEBYx5XdfQw5@google.com>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218055203.591403-4-willy@infradead.org>

On 02/18, Matthew Wilcox (Oracle) wrote:
> Convert f2fs_put_page() to f2fs_folio_put() and add a wrapper.
> Replaces three calls to compound_head() with one.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/f2fs/f2fs.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b05653f196dd..5e01a08afbd7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2806,16 +2806,21 @@ static inline struct page *f2fs_pagecache_get_page(
>  	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
>  }
>  
> -static inline void f2fs_put_page(struct page *page, int unlock)
> +static inline void f2fs_folio_put(struct folio *folio, bool unlock)
>  {
> -	if (!page)
> +	if (!folio)
>  		return;
>  
>  	if (unlock) {
> -		f2fs_bug_on(F2FS_P_SB(page), !PageLocked(page));
> -		unlock_page(page);
> +		f2fs_bug_on(F2FS_F_SB(folio), !folio_test_locked(folio));
> +		folio_unlock(folio);
>  	}
> -	put_page(page);
> +	folio_put(folio);
> +}
> +
> +static inline void f2fs_put_page(struct page *page, int unlock)
> +{

I got a kernel panic, since there are still several places to pass a null
page pointer, which feeds to page_folio() which doesn't expect the null.

Applying this can avoid the panic.

	if (!page)
		return;

> +	f2fs_folio_put(page_folio(page), unlock);
>  }
>  
>  static inline void f2fs_put_dnode(struct dnode_of_data *dn)
> -- 
> 2.47.2
> 

