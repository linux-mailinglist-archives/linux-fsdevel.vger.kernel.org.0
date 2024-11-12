Return-Path: <linux-fsdevel+bounces-34485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FF19C5DCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE3E1F2343E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD1F2141A4;
	Tue, 12 Nov 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJZO7PgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DFA209660
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430350; cv=none; b=I2ux2bizIE9oJ5uRE0PxwS9ZLYUuTNxz5x63uJb1d90TjDSCAsdoNm3FhjgIOox+E4vc7Vlja0iq1wxfXP8XtLweQAj3nr/1oAtLv9IrFej8g5LUNtnrY6bS/MH4w17jt9zd6Cjzt+lfLgFL/7L0h3pPxyUhlC9TiEK2FCM9KBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430350; c=relaxed/simple;
	bh=p8iI6w9vyQm2br3NsUS0i12ELTjdwLIn3wCbe1CDl8o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sL5ecmOZCtdTOgmH068lkmJqgvvqsI/UjLVk5jt0xmbgZ6Jglu8S12Y9JZlCJDYyWrWdkdlEe7IdAHlvAt3n0rfJcTKH6Ze/ojk5aBj7ci2BQlgg9VCoFYLTc5B3wptxhKWKX755NTVunn4K03eji8feKk7idVrr3LDkRXtMsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJZO7PgZ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e60966297fso2743489b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731430347; x=1732035147; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOBOL99SRpizY4FPJmEvrpiHHSOq18Nth1K4leBXTMA=;
        b=kJZO7PgZOszLetiaYcKxlI1MfgyY1xcWvSAeScgXJdWVf83nI1xnjvmEQeHhVE9zF5
         YgEALsj1h6ChcvRAk5CiYHiRE3OYr5M1whNnNw6zueeozsMKkUZzMJ+KebfV4sehQkD8
         p7Ape6PJHDi8rXk+OX1pCtPgVD9uZEoa+3MK+Urs3WNWVMakJZz9/zkBaE+KZBBr0uvH
         xjxVfBiOsJXjDrxEOjIX6l/pYs0Mk4vCyCLqt9G4k6Ruy4bkhfy8k749IMtXiOsKTtaa
         wN0/jukVwFKnvQ2gM1mJxpaESpFXq3XPjyjunujP67TUw2PcTB7fCvq8qcbMrb/gyEfh
         QUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430347; x=1732035147;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOBOL99SRpizY4FPJmEvrpiHHSOq18Nth1K4leBXTMA=;
        b=U8m33SwTRpTyfeaoLdy2TPdvqzEf7QpyTJ6cxnOr/qaq5IhVGNP4ApNZU10GNCP2ms
         6sHkX9zLXAWL5SGD0/US6hqFPiUBirpmcJfWNBb/HfC21dU9qGgrY6gm3I4YLMH1tqk3
         hQmn+tM/dLM2yyvu4edrBDGgzgG+RK0bnamer0nCnpTTU5IhKm10lUkjj7KsjBgTPJ9t
         KBImpkQUhbiKOM5ydt4uW+sDKLnIND0Oi60nKTvEx4BIqmWLYpVbUVNA1h/hsBs/lZ1A
         WRrpPKdQVd7cq/lNpRg3+FdXbGGZjI6UP6SHEDPYXQ/8FTx96jsVMU9wKvWbU6VlWlGr
         oqrA==
X-Forwarded-Encrypted: i=1; AJvYcCVtmuEDRBqJ4yhsaErppWiAGAdIwPYkaOc9ZCn3XNw7s7Z9PSskb1hnA8MJLOtVOn+Vycq88UvM3dqERX3q@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqfC1pCXDZ/QieEUyWXaPHKkex5xQliwm4QNGV3QRhGPQHb9h
	vjOjWehztYxWs/CSFqV0pWXif01hpPP051M9zWx9W0AeukhRGS8tpjv8o7td8w==
X-Google-Smtp-Source: AGHT+IEJSSfaAuSN3BFmokAf11ZpFLAgR2jwLW5J6N+Yaq4VYsgk4I8RkwyB2vbmJgCjW77dbWkNdQ==
X-Received: by 2002:a05:6808:3a15:b0:3e6:943:63c9 with SMTP id 5614622812f47-3e79470a33cmr15619476b6e.33.1731430347030;
        Tue, 12 Nov 2024 08:52:27 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cca4fbfsm2632197b6e.24.2024.11.12.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:52:25 -0800 (PST)
Date: Tue, 12 Nov 2024 08:51:04 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Christian Brauner <brauner@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>, 
    David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() for highmem
In-Reply-To: <20241112-geregelt-hirte-ab810337e3c0@brauner>
Message-ID: <d2ede383-3f4e-fbe5-efff-dc5f63cead4c@google.com>
References: <20241112-geregelt-hirte-ab810337e3c0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 Nov 2024, Christian Brauner wrote:

> When fixing copy_page_from_iter_atomic() in c749d9b7ebbc ("iov_iter: fix
> copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP") the check for
> PageHighMem() got moved out of the loop. If copy_page_from_iter_atomic()
> crosses page boundaries it will use a stale PageHighMem() check for an
> earlier page.
> 
> Fixes: 908a1ad89466 ("iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()")
> Fixes: c749d9b7ebbc ("iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP")
> Cc: stable@vger.kernel.org
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Hey Linus,
> 
> I think the original fix was buggy but then again my knowledge of
> highmem isn't particularly detailed. Compile tested only. If correct, I
> would ask you to please apply it directly.

I haven't seen whatever discussion led up to this.  I don't believe
my commit was buggy (setting uses_kmap once at the top was intentional);
but I haven't looked at the other Fixee, and I've no objection if you all
prefer to add this on.

I imagine you're worried by the idea of a folio getting passed in, and
its first struct page is in a lowmem pageblock, but the folio somehow
spans pageblocks so that a later struct page is in a highmem pageblock.

That does not happen - except perhaps in the case of a hugetlb gigantic
folio, cobbled together from separate pageblocks.  But the code here,
before my change and after it and after this mod, does not allow for
that case anyway - the "page += offset / PAGE_SIZE" is assuming that
struct pages are contiguous.  If there is a worry here (I assumed not),
I think it would be that.

Cc'ing Matthew who is much more alert to such issues than I am.
Dashing out shortly, back in two hours,
Hugh

> 
> Thanks!
> Christian
> ---
>  lib/iov_iter.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 908e75a28d90..e90a5ababb11 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -457,12 +457,16 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_zero);
>  
> +static __always_inline bool iter_atomic_uses_kmap(struct page *page)
> +{
> +	return IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) ||
> +	       PageHighMem(page);
> +}
> +
>  size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
>  		size_t bytes, struct iov_iter *i)
>  {
>  	size_t n, copied = 0;
> -	bool uses_kmap = IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) ||
> -			 PageHighMem(page);
>  
>  	if (!page_copy_sane(page, offset, bytes))
>  		return 0;
> @@ -473,7 +477,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
>  		char *p;
>  
>  		n = bytes - copied;
> -		if (uses_kmap) {
> +		if (iter_atomic_uses_kmap(page)) {
>  			page += offset / PAGE_SIZE;
>  			offset %= PAGE_SIZE;
>  			n = min_t(size_t, n, PAGE_SIZE - offset);
> @@ -484,7 +488,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
>  		kunmap_atomic(p);
>  		copied += n;
>  		offset += n;
> -	} while (uses_kmap && copied != bytes && n > 0);
> +	} while (iter_atomic_uses_kmap(page) && copied != bytes && n > 0);
>  
>  	return copied;
>  }
> -- 
> 2.45.2

