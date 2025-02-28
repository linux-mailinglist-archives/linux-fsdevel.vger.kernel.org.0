Return-Path: <linux-fsdevel+bounces-42831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB0A49252
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 08:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6490518939E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 07:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F911CAA65;
	Fri, 28 Feb 2025 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4KFZ823"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260CB1C84C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728261; cv=none; b=TaKMdzcRiak68eg3FIa+mM1zfqHA2Xc7bAVrr9P3ADGaXF8EVhxJqpQYoTL3gwxuwv0C5m99FXZMVLQbhf4WFQoRK4zIN5ed6bmL3PB2/PzPrkQbMD35tmIp4pcQ87vz1p8Oa3lIijR+/Ap/hreXDQwcudwZSX8jEC2WE4ZyWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728261; c=relaxed/simple;
	bh=/i7pKBavrU7LwqoFhsA71FIGQa6xI/pJc8DT9nTVvfQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UIB9QzRvctEr05dBzcCXJbF8m+o6sRphNTMg6K/MfMe9d0JVgarlAkx0zh8pfNEzFxhV6u8tbgtHeuCg2BmSvQcRS1llFYLcP61qnzV0tG/GbdVJodJj7qtrxUu9CqjG434PbYZfXr5JC9Dd8jie5p3CnTAJAAcXs1F6IHZACmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4KFZ823; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C000C4CED6;
	Fri, 28 Feb 2025 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740728260;
	bh=/i7pKBavrU7LwqoFhsA71FIGQa6xI/pJc8DT9nTVvfQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=V4KFZ823IH+WOsoC4pLuvmvEMJnF8QiumtVluJFWOpAqRDxL993lQnrteBU1rzxT8
	 WeNxIRiGUekKR/ZsSmOSqwCrVjjutpXmjoBlaDLA1HuY18xIaD2jvLmWpiey4beExZ
	 MPP2u+dj1S3JXDWbZZmDXdwekz9xXQ+e/y8g62c14CQA0n/gB+F8RMQ6PUhEL8iNnJ
	 thcI0uC6GBeFTdhTitodJtaaqbdSzP8tBkWgmVsSe+1+pHOsMXSKGyshvwjGstTqG6
	 CxcYLTQkCUVmuJASoBMt3Mpk0Y0keDlJYwjTbiBBcvWrjE4F6zDSD2+WWXsIqawigH
	 elKF0jxIsfk9Q==
Message-ID: <ef8f19e1-208c-4196-84f5-7d6095c9846e@kernel.org>
Date: Fri, 28 Feb 2025 15:37:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/27] f2fs: Add f2fs_get_lock_data_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-23-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250218055203.591403-23-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/18 13:51, Matthew Wilcox (Oracle) wrote:
> Convert f2fs_get_lock_data_page() to f2fs_get_lock_data_folio() and
> add a compatibility wrapper.  Removes three hidden calls to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/f2fs/data.c | 18 +++++++++---------
>   fs/f2fs/f2fs.h | 10 +++++++++-
>   2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f0747c7f669d..e891c95bc525 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1310,23 +1310,23 @@ struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index,
>    * Because, the callers, functions in dir.c and GC, should be able to know
>    * whether this page exists or not.
>    */
> -struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
> +struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
>   							bool for_write)
>   {
>   	struct address_space *mapping = inode->i_mapping;
> -	struct page *page;
> +	struct folio *folio;
>   
> -	page = f2fs_get_read_data_page(inode, index, 0, for_write, NULL);
> -	if (IS_ERR(page))
> -		return page;
> +	folio = f2fs_get_read_data_folio(inode, index, 0, for_write, NULL);
> +	if (IS_ERR(folio))
> +		return folio;
>   
>   	/* wait for read completion */
> -	lock_page(page);
> -	if (unlikely(page->mapping != mapping || !PageUptodate(page))) {
> -		f2fs_put_page(page, 1);
> +	folio_lock(folio);
> +	if (unlikely(folio->mapping != mapping || !folio_test_uptodate(folio))) {
> +		f2fs_folio_put(folio, true);
>   		return ERR_PTR(-EIO);
>   	}
> -	return page;
> +	return folio;
>   }
>   
>   /*
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3e02df63499e..c78ba3c7d642 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3899,7 +3899,7 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
>   		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
>   struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index,
>   							pgoff_t *next_pgofs);
> -struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
> +struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
>   			bool for_write);
>   struct page *f2fs_get_new_data_page(struct inode *inode,
>   			struct page *ipage, pgoff_t index, bool new_i_size);
> @@ -3936,6 +3936,14 @@ static inline struct page *f2fs_get_read_data_page(struct inode *inode,
>   	return &folio->page;
>   }
>   
> +static inline struct page *f2fs_get_lock_data_page(struct inode *inode,
> +		pgoff_t index, bool for_write)
> +{
> +	struct folio *folio = f2fs_get_lock_data_folio(inode, index, for_write);

	if (IS_ERR(folio))
		return ERR_CAST(folio));

> +
> +	return &folio->page;
> +}
> +
>   /*
>    * gc.c
>    */


