Return-Path: <linux-fsdevel+bounces-65196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ECCBFD945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D73D34F2E6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120F2BE65E;
	Wed, 22 Oct 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpEHlYWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969432BD5BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154116; cv=none; b=YPZivOJPOjOWXjT7ZR4yLG0at1/McRgkc3C35xfvlH2kXTcWOd9sXWpLM8Fit5s6Ee8PahMonLScIIQlhvBgxSFCNkLVbSX66w88Qhft5/rKjT7jdDyOG0Yn9qJBgTHvVNshwodl3nNUiRpdOLJlmkIkeDtN3Y0dwiDyUpfbDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154116; c=relaxed/simple;
	bh=4YcXtctYV2QGdrVgyb+riPaOUdGtyDlP3mwCnCVuCdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErNZwJiA2shkzDjLulg1upF/AM0Hbuzv4qRRjRFBXsJhwFTLuYFbGrg/Pk5ekKVG3Gu3ouFAJZUqAl4BotLvtMJCY3nzlomTqDWfSfB+4hdUtUt5ql8gyMGZECp3NbzKWcxY+24FRq+yrCMGe9ARdvfeMhG1euTeQiiThyJvzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpEHlYWm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761154112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ersH+A2YnVEG4u4wWpk7ksHDpnwZb29+THsgHlY+RNw=;
	b=EpEHlYWmwXtWAj4DgDTmjAKzz0wZkQCRQUHkrgwN+iUzXqVy6fIL9+scQ9EjaHZluxnJnn
	NOvzzPGP1SOVEn3qyfdcLIlKe+ZubGzexKPzXLAK5toI6FxD/lEuxufotu1UpFKuVWevPW
	+tyJAcEEFE4Gg+M9nonxMIatKwozAvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Y4PCXjqmNoW36mFSJaueWQ-1; Wed, 22 Oct 2025 13:28:31 -0400
X-MC-Unique: Y4PCXjqmNoW36mFSJaueWQ-1
X-Mimecast-MFC-AGG-ID: Y4PCXjqmNoW36mFSJaueWQ_1761154110
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47114d373d5so64530005e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 10:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154110; x=1761758910;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ersH+A2YnVEG4u4wWpk7ksHDpnwZb29+THsgHlY+RNw=;
        b=RXrmL/aoIoegincOWInlgqECkpWlN+Rqkbxh4NCuHJVQSW6RrL2z8TtY89KjZmHi6t
         VjMKIV7KNbHwvpREwacQ8+ENz3c8KY2CAj65lElG2V05LCAQ0NAs/OzIWY6AXe+Gtjf/
         zCLZMbJjW99ikixga3q8ycS61lG/mvmIJKfrabJbtaRuDZBNVewemx2LIZ0RRL7itGuI
         u9LuD1/UnqzHk3ustkczNJnom4cOjGgSmcTXKjAEL3bin7vIn7WOuUBSk70wx9kJijut
         bzYujlpEIXx7RX+0m2Qrn2jg00wZtrfNE/q/EfK9E/BP47iFKjOCFMWW97bWJE7Crt0R
         XAIg==
X-Forwarded-Encrypted: i=1; AJvYcCXU+SSSTgBkiIcj5jlItm5A3dkmSsekmwufS6o1w3eqiUonPYrVlMGnPVan1QuFRVM/SoO+A5thTS8MD/5l@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFQcptsdzJahwCEC0qUfgHlof+U7nxSiEcIP66d7IWNs02g1j
	InNiZubkRli8XlXOaLso/XT8I5JZQvXlMX9EFkm2jO9EYmWl7Yv7SFZjCI3H9g1mVO3vHXRDRNW
	TBDYNVhVLBpKOvE0d0MN3X0a8gCuQRHHAWBzTL2q3hZqJhoUoQwzdDJ+e4/OgniT1UhU=
X-Gm-Gg: ASbGncvPCH/oSrJczHdh6md4ofeIOP641WBda4/Q6AGuCtziI0esreXskZZ5IRD+eIK
	6tlEeZjmcMRe7xlCCKTEASbDx9XhfRSe9nct96XOKSHnHDoeZaEIWB/rSnle0XBpyIlUr/wIFBy
	NaXa1o4Qac8nfGrwR31TvhqmnU4V8C6hnAC83uLJGH9kjB2Z/lmmEDN/Vr4nUhjRPvjnSNl+XfB
	MgqLWL06/Gs72ITjcxd8rM5hKHok6JbGz4JcyXLebrVlpcJXljbUZQIVCh83b0N/1/4pPBgJad8
	cgZ/dvavFLdd2uq2xH6ZfqTtZT7UlmjFpmbRirVSs6ZYrxfgeEgrtP47+4XOq8yrOQ92MIrSZnZ
	lTCo1dYX2wPJmh70rPr2mX/rV55GvDsLnPmCJ31WKp+cKm9wPJnyoLc6cGK3qNbICznJI29kuNp
	MzmGxXktXFm2OUCeKeDfMJcZ5iauM=
X-Received: by 2002:a05:600c:6291:b0:471:a43:123f with SMTP id 5b1f17b1804b1-471178a6882mr170490345e9.9.1761154109941;
        Wed, 22 Oct 2025 10:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlRHaZovyGNJpfxC/RlqXuNv/7Z+a5XDpsqOCnLx0yEjUAljMFKF3SfTdCasSCmNwsHcnW1A==
X-Received: by 2002:a05:600c:6291:b0:471:a43:123f with SMTP id 5b1f17b1804b1-471178a6882mr170490155e9.9.1761154109456;
        Wed, 22 Oct 2025 10:28:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428c62fsm56170405e9.8.2025.10.22.10.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:28:28 -0700 (PDT)
Message-ID: <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
Date: Wed, 22 Oct 2025 19:28:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
References: <20251017141536.577466-1-kirill@shutemov.name>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251017141536.577466-1-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.25 16:15, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The protocol for page cache lookup is as follows:
> 
>    1. Locate a folio in XArray.
>    2. Obtain a reference on the folio using folio_try_get().
>    3. If successful, verify that the folio still belongs to
>       the mapping and has not been truncated or reclaimed.
>    4. Perform operations on the folio, such as copying data
>       to userspace.
>    5. Release the reference.
> 
> For short reads, the overhead of atomic operations on reference
> manipulation can be significant, particularly when multiple tasks access
> the same folio, leading to cache line bouncing.
> 
> To address this issue, introduce i_pages_delete_seqcnt, which increments
> each time a folio is deleted from the page cache and implement a modified
> page cache lookup protocol for short reads:
> 
>    1. Locate a folio in XArray.
>    2. Take note of the i_pages_delete_seqcnt.
>    3. Copy the data to a local buffer on the stack.
>    4. Verify that the i_pages_delete_seqcnt has not changed.
>    5. Copy the data from the local buffer to the iterator.
> 
> If any issues arise in the fast path, fallback to the slow path that
> relies on the refcount to stabilize the folio.
> 
> The new approach requires a local buffer in the stack. The size of the
> buffer determines which read requests are served by the fast path. Set
> the buffer to 1k. This seems to be a reasonable amount of stack usage
> for the function at the bottom of the call stack.
> 
> The fast read approach demonstrates significant performance
> improvements, particularly in contended cases.
> 
> 16 threads, reads from 4k file(s), mean MiB/s (StdDev)
> 
>   -------------------------------------------------------------
> | Block |  Baseline  |  Baseline   |  Patched   |  Patched    |
> | size  |  same file |  diff files |  same file | diff files  |
>   -------------------------------------------------------------
> |     1 |    10.96   |     27.56   |    30.42   |     30.4    |
> |       |    (0.497) |     (0.114) |    (0.130) |     (0.158) |
> |    32 |   350.8    |    886.2    |   980.6    |    981.8    |
> |       |   (13.64)  |     (2.863) |    (3.361) |     (1.303) |
> |   256 |  2798      |   7009.6    |  7641.4    |   7653.6    |
> |       |  (103.9)   |    (28.00)  |   (33.26)  |    (25.50)  |
> |  1024 | 10780      |  27040      | 29280      |  29320      |
> |       |  (389.8)   |    (89.44)  |  (130.3)   |    (83.66)  |
> |  4096 | 43700      | 103800      | 48420      | 102000      |
> |       | (1953)     |    (447.2)  | (2012)     |     (0)     |
>   -------------------------------------------------------------
> 
> 16 threads, reads from 1M file(s), mean MiB/s (StdDev)
> 
>   --------------------------------------------------------------
> | Block |  Baseline   |  Baseline   |  Patched    |  Patched   |
> | size  |  same file  |  diff files |  same file  | diff files |
>   ---------------------------------------------------------
> |     1 |     26.38   |     27.34   |     30.38   |    30.36   |
> |       |     (0.998) |     (0.114) |     (0.083) |    (0.089) |
> |    32 |    824.4    |    877.2    |    977.8    |   975.8    |
> |       |    (15.78)  |     (3.271) |     (2.683) |    (1.095) |
> |   256 |   6494      |   6992.8    |   7619.8    |   7625     |
> |       |   (116.0)   |    (32.39)  |    (10.66)  |    (28.19) |
> |  1024 |  24960      |  26840      |  29100      |  29180     |
> |       |   (606.6)   |   (151.6)   |   (122.4)   |    (83.66) |
> |  4096 |  94420      | 100520      |  95260      |  99760     |
> |       |  (3144)     |   (672.3)   |  (2874)     |   (134.1)  |
> | 32768 | 386000      | 402400      | 368600      | 397400     |
> |       | (36599)     | (10526)     | (47188)     |  (6107)    |
>   --------------------------------------------------------------
> 
> There's also improvement on kernel build:
> 
> Base line: 61.3462 +- 0.0597 seconds time elapsed  ( +-  0.10% )
> Patched:   60.6106 +- 0.0759 seconds time elapsed  ( +-  0.13% )
> 
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>   fs/inode.c         |   2 +
>   include/linux/fs.h |   1 +
>   mm/filemap.c       | 150 ++++++++++++++++++++++++++++++++++++++-------
>   3 files changed, 130 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index ec9339024ac3..52163d28d630 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -482,6 +482,8 @@ EXPORT_SYMBOL(inc_nlink);
>   static void __address_space_init_once(struct address_space *mapping)
>   {
>   	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
> +	seqcount_spinlock_init(&mapping->i_pages_delete_seqcnt,
> +			       &mapping->i_pages->xa_lock);
>   	init_rwsem(&mapping->i_mmap_rwsem);
>   	INIT_LIST_HEAD(&mapping->i_private_list);
>   	spin_lock_init(&mapping->i_private_lock);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..c9588d555f73 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -523,6 +523,7 @@ struct address_space {
>   	struct list_head	i_private_list;
>   	struct rw_semaphore	i_mmap_rwsem;
>   	void *			i_private_data;
> +	seqcount_spinlock_t	i_pages_delete_seqcnt;
>   } __attribute__((aligned(sizeof(long)))) __randomize_layout;
>   	/*
>   	 * On most architectures that alignment is already the case; but
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 13f0259d993c..51689c4f3773 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -138,8 +138,10 @@ static void page_cache_delete(struct address_space *mapping,
>   
>   	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>   
> +	write_seqcount_begin(&mapping->i_pages_delete_seqcnt);
>   	xas_store(&xas, shadow);
>   	xas_init_marks(&xas);
> +	write_seqcount_end(&mapping->i_pages_delete_seqcnt);
>   
>   	folio->mapping = NULL;
>   	/* Leave folio->index set: truncation lookup relies upon it */
> @@ -2695,21 +2697,98 @@ static void filemap_end_dropbehind_read(struct folio *folio)
>   	}
>   }
>   
> -/**
> - * filemap_read - Read data from the page cache.
> - * @iocb: The iocb to read.
> - * @iter: Destination for the data.
> - * @already_read: Number of bytes already read by the caller.
> - *
> - * Copies data from the page cache.  If the data is not currently present,
> - * uses the readahead and read_folio address_space operations to fetch it.
> - *
> - * Return: Total number of bytes copied, including those already read by
> - * the caller.  If an error happens before any bytes are copied, returns
> - * a negative error number.
> - */
> -ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
> -		ssize_t already_read)
> +static inline unsigned long filemap_read_fast_rcu(struct address_space *mapping,
> +						  loff_t pos, char *buffer,
> +						  size_t size)
> +{
> +	XA_STATE(xas, &mapping->i_pages, pos >> PAGE_SHIFT);
> +	struct folio *folio;
> +	loff_t file_size;
> +	unsigned int seq;
> +
> +	lockdep_assert_in_rcu_read_lock();
> +
> +	/* Give up and go to slow path if raced with page_cache_delete() */
> +	if (!raw_seqcount_try_begin(&mapping->i_pages_delete_seqcnt, seq))
> +		return false;
> +
> +	folio = xas_load(&xas);
> +	if (xas_retry(&xas, folio))
> +		return 0;
> +
> +	if (!folio || xa_is_value(folio))
> +		return 0;
> +
> +	if (!folio_test_uptodate(folio))
> +		return 0;
> +
> +	/* No fast-case if readahead is supposed to started */
> +	if (folio_test_readahead(folio))
> +		return 0;
> +	/* .. or mark it accessed */
> +	if (!folio_test_referenced(folio))
> +		return 0;
> +
> +	/* i_size check must be after folio_test_uptodate() */
> +	file_size = i_size_read(mapping->host);
> +	if (unlikely(pos >= file_size))
> +		return 0;
> +	if (size > file_size - pos)
> +		size = file_size - pos;
> +
> +	/* Do the data copy */
> +	size = memcpy_from_file_folio(buffer, folio, pos, size);

We can be racing with folio splitting or freeing+reallocation, right? So 
our folio might actually be suddenly a tail page I assume? Or change 
from small to large, or change from large to small. Or a large folio can 
change its size?

In that case things like folio_test_uptodate() won't be happy, because 
they will bail out if called on a tail page (see PF_NO_TAIL).


But also, are we sure memcpy_from_file_folio() is save to be used in 
that racy context?


offset_in_folio() which depends on folio_size(). When racing with 
concurrent folio reuse, folio_size()->folio_order() can be tricked into 
returning a wrong number I guess and making the result of 
offset_in_folio() rather bogus.

At least that's my understanding after taking a quick look.

The concern I would have in that case
(A) the page pointer we calculate in kmap_local_folio() could be garbage
(B) the "from" pointer we return could be garbage

"garbage" as in pointing at something without a direct map, something 
that's protected differently (MTE? weird CoCo protection?) or even worse 
MMIO with undesired read-effects.


I'll note that some of these concerns would be gone once folios are 
allocated separately: we would not suddenly see a tail page.

But concurrent folio splitting or size changes could still be an issue 
IIUC Willy today once I discussed the plans about "struct folio" freeing.

Maybe I'm wrong, just wanted to raise that these functions are not 
prepared to be called when we are not holding a refcount or cannot 
otherwise guarantee that the folio cannot concurrently be 
freed/reallocated/merged/split.

-- 
Cheers

David / dhildenb


