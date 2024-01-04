Return-Path: <linux-fsdevel+bounces-7424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF9A8249FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 22:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A176285CBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5702C6A2;
	Thu,  4 Jan 2024 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jCQNvj5s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B32C191;
	Thu,  4 Jan 2024 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cOfSf5C8D1sJUiWQ/RlTxPDbyCpmXzMJ+TOzMFfAhf0=; b=jCQNvj5sCf7R/im7v+/FGKmHFd
	oV/yyDZymsV0NB7nHUIa1Tfu5USCEst/mhUYmJ4A/qOCY8VbMCe4o3ZLMajwGhyPE2hnM7jm7e6mH
	BG4PUsUhUW9nSN1UAOE+WJanlUmvX3hk1lk6PbBpmShVHjlvPxjaZyo5NdO2DnMo7ZvyIjXGgQGH/
	8AvtNCcfeFj2YKC4J4Xt3rTIhvvSmXtqu3OLDmGzhgOHETrxaow6zIXfOoBHdIfQTwej0k4ieFoDd
	x0VaGGGNX+S1WTOZmWqYlr+g8qIZ58NqznE5NBItJI3CUfhIxf+FxCi5qHNY5283Agksl1V3w28gw
	Ef8g3WiQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLUxJ-00FEgP-0Q;
	Thu, 04 Jan 2024 21:08:45 +0000
Message-ID: <8fd06532-0ae8-47a7-a4f2-f5b01a25bf93@infradead.org>
Date: Thu, 4 Jan 2024 13:08:44 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] doc: Improve the description of __folio_mark_dirty
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-2-willy@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240104163652.3705753-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/4/24 08:36, Matthew Wilcox (Oracle) wrote:
> I've learned why it's safe to call __folio_mark_dirty() from
> mark_buffer_dirty() without holding the folio lock, so update
> the description to explain why.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/page-writeback.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index cd4e4ae77c40..96da6716cb86 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2652,11 +2652,15 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
>   * If warn is true, then emit a warning if the folio is not uptodate and has
>   * not been truncated.
>   *
> - * The caller must hold folio_memcg_lock().  Most callers have the folio
> - * locked.  A few have the folio blocked from truncation through other
> - * means (eg zap_vma_pages() has it mapped and is holding the page table
> - * lock).  This can also be called from mark_buffer_dirty(), which I
> - * cannot prove is always protected against truncate.
> + * The caller must hold folio_memcg_lock().  It is the caller's
> + * responsibility to prevent the folio from being truncated while
> + * this function is in progress, although it may have been truncated
> + * before this function is called.  Most callers have the folio locked.
> + * A few have the folio blocked from truncation through other means (eg

preferably s/eg/e.g./

> + * zap_vma_pages() has it mapped and is holding the page table lock).
> + * When called from mark_buffer_dirty(), the filesystem should hold a
> + * reference to the buffer_head that is being marked dirty, which causes
> + * try_to_free_buffers() to fail.
>   */
>  void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
>  			     int warn)

-- 
#Randy

