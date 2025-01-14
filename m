Return-Path: <linux-fsdevel+bounces-39188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B464AA11312
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FCB1889C4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DAA1FBE92;
	Tue, 14 Jan 2025 21:31:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-09.prod.sxb1.secureserver.net (sxb1plsmtpa01-09.prod.sxb1.secureserver.net [188.121.53.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502029406
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890314; cv=none; b=VukoSVOV/04zzvaxPk9+2kpEP5uXh4yUpaK6xau05SMNWi1K0P+WP6Sh2+/VwClUOw/2ZsK2E14WSqzS/X8RgHIPDh4+YwgbBAoWWgzck5c78dynU77iifBHLd2ULe3jKd3+heUripE9EEUMv9wWjG0IhC/9PvWipNZZDizqedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890314; c=relaxed/simple;
	bh=J5dMHKjSPmADJhd7H0B1fTZCmYHfvmUHv7uHPRGJkPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to2tJuRTJYc5qcFg8JbgZQUzhsD0RZbK5XvfK/Gwb5b5+oHg8EqIrSF6WULSD2lH/EobHpnKQ26Z+YUyC0eS5R2fJO4Ock9PaEUUUaOh46hWOXjnXJzuEsx70vbVscYdqtaPq8SbBLus1wRmy9Wnd5ULoWGdYeiHWZraLiT8QSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id XoDKtCgY0KQZ7XoDLtwM5S; Tue, 14 Jan 2025 14:12:43 -0700
X-CMAE-Analysis: v=2.4 cv=H/Ahw/Yi c=1 sm=1 tr=0 ts=6786d34b
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=W2xiLW0GlORWcRYWJokA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <20e18047-4671-4578-8f11-0f7341b2cc71@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:12:17 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241220224634.723899-1-willy@infradead.org>
 <20241220224634.723899-5-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241220224634.723899-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfL5PzJWsNGzoW9sbHRLf5s+HMK+vzCO2+tE+knm1a44qXF4qvHJo3UyK3suwcVtHmlDz1judjwID3PXx1qkDgHCsJGyijBPSo9dAosmBWGQF93N8whZL
 tTlZPQEL7t4G0LYqHCkmAZN81aAkKGdCOVpwOSHo5xRRKrLuLRqBd/RF9ui63l8ZIFShibEGoGX/nG+GP9V8Jqk19ADXeOpvjJ2LgUjYTHpoFR3g1gbQeFas
 RCaMk94R3I/zhtClIBa5kNuN8ZCGLAiEOvgy2JxP9JQ=



On 12/20/24 22:46, Matthew Wilcox (Oracle) wrote:
> squashfs_fill_page is only used in this file, so make it static.
> Use kmap_local instead of kmap_atomic, and return a bool so that
> the caller can use folio_end_read() which saves an atomic operation
> over calling folio_mark_uptodate() followed by folio_unlock().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
Tested-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   fs/squashfs/file.c     | 21 ++++++++++++---------
>   fs/squashfs/squashfs.h |  1 -
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 1f27e8161319..da25d6fa45ce 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -362,19 +362,21 @@ static int read_blocklist(struct inode *inode, int index, u64 *block)
>   	return squashfs_block_size(size);
>   }
>   
> -void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer, int offset, int avail)
> +static bool squashfs_fill_page(struct folio *folio,
> +		struct squashfs_cache_entry *buffer, size_t offset,
> +		size_t avail)
>   {
> -	int copied;
> +	size_t copied;
>   	void *pageaddr;
>   
> -	pageaddr = kmap_atomic(page);
> +	pageaddr = kmap_local_folio(folio, 0);
>   	copied = squashfs_copy_data(pageaddr, buffer, offset, avail);
>   	memset(pageaddr + copied, 0, PAGE_SIZE - copied);
> -	kunmap_atomic(pageaddr);
> +	kunmap_local(pageaddr);
>   
> -	flush_dcache_page(page);
> -	if (copied == avail)
> -		SetPageUptodate(page);
> +	flush_dcache_folio(folio);
> +
> +	return copied == avail;
>   }
>   
>   /* Copy data into page cache  */
> @@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
>   			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
>   		struct folio *push_folio;
>   		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
> +		bool uptodate = true;
>   
>   		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>   
> @@ -412,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
>   		if (folio_test_uptodate(push_folio))
>   			goto skip_folio;
>   
> -		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
> +		uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
>   skip_folio:
> -		folio_unlock(push_folio);
> +		folio_end_read(push_folio, uptodate);
>   		if (i != folio->index)
>   			folio_put(push_folio);
>   	}
> diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
> index 9295556ecfd0..37f3518a804a 100644
> --- a/fs/squashfs/squashfs.h
> +++ b/fs/squashfs/squashfs.h
> @@ -67,7 +67,6 @@ extern __le64 *squashfs_read_fragment_index_table(struct super_block *,
>   				u64, u64, unsigned int);
>   
>   /* file.c */
> -void squashfs_fill_page(struct page *, struct squashfs_cache_entry *, int, int);
>   void squashfs_copy_cache(struct folio *, struct squashfs_cache_entry *,
>   		size_t bytes, size_t offset);
>   

