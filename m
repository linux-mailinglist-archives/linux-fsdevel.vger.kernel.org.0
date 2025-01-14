Return-Path: <linux-fsdevel+bounces-39195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A580AA11375
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B45188A1E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7265220D507;
	Tue, 14 Jan 2025 21:53:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-07.prod.sxb1.secureserver.net (sxb1plsmtpa01-07.prod.sxb1.secureserver.net [92.204.81.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8FE1CDFC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891637; cv=none; b=sRTTolpLY4/POutVRjDI5A1XePl+XZwpABFmK1TEVKWbZRJS97wHp2H+YDrKfptXFtcja8v3YS3cMBtPK/4eMMOq58gBZjJFFlm1xx1mGFiGThP5VnaUnSaLB2JDjRM7nW6RAYDbRBhlZpA87O2IJXTwapXuqBek4W6I1Cols58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891637; c=relaxed/simple;
	bh=9tUaxhOx7+0yXfCtN4AVvJPL4qrrrMl7QRxeaUyXNcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGRxd19pRx2E+ohdVJoEcDjZ8dYdCYNNLBSl11ar9CcsEGp44VUYEfxv8b96q++WmorvXHmbHtrT7n80JwUhOhDH8giYuu7dWka5E4l1BSaZ8yiLAbJ4mjrBabXJCBe7K/ClHKivCwTvuf6sHEr5KxoAkz61uD/m3IzclkYnyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id Xo9qtxqGXOmR4Xo9rteqgO; Tue, 14 Jan 2025 14:09:07 -0700
X-CMAE-Analysis: v=2.4 cv=FN/hx/os c=1 sm=1 tr=0 ts=6786d273
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=W2xiLW0GlORWcRYWJokA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <41ed0b22-099a-40dd-b7e7-1e8719241fcc@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:08:41 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241216162701.57549-1-willy@infradead.org>
 <20241216162701.57549-5-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241216162701.57549-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCXhunHkNxoWSf35AGq1AS2ZxNymf8dCK3R07SZLZu5nJ3RksmXsoJ7y4Qe8N7NdOtLSSNf75fiveT2/Grvw4TiGMgYrUuXkMPybT+Y/pgWAFcw0fAXo
 B90QsaVPRVGjqebSFlXyXfphndQ6V4ctkTSj1nGGmCp2oE6BuVkiU4SA/4qaxfT95QIolXgQOpoV3yelLaIBJQbLhvGX04BL48giWtrg1sShrGMwfOoP+kyD
 HqKvjUYcGSzFxdyeEoUdtXaiQ3mm8T52snXv7rR/88RzGKJ7K9ifqjRLjS+nkzyf/vlQpmRdKMa5PoHSVteBmA==



On 12/16/24 16:26, Matthew Wilcox (Oracle) wrote:
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
> index 1f27e8161319..d363fb26c2c8 100644
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
> +		bool filled = false;
>   
>   		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>   
> @@ -412,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
>   		if (folio_test_uptodate(push_folio))
>   			goto skip_folio;
>   
> -		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
> +		filled = squashfs_fill_page(push_folio, buffer, offset, avail);
>   skip_folio:
> -		folio_unlock(push_folio);
> +		folio_end_read(folio, filled);
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

