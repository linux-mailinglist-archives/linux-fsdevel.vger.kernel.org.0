Return-Path: <linux-fsdevel+bounces-34201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62929C3AA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 10:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54300B213F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30C15B554;
	Mon, 11 Nov 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="vpkqrXfy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YkH0erlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CA4A3E;
	Mon, 11 Nov 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316527; cv=none; b=iT7LX3kmtG5v12IQvB5C0h+9F6RlbSEwKyUkeMG6VdHzW4HVAyfhZNJrRZdpG88sfDc1L8wkVGWyJXQfbjXo07WJdecW8qryoJryK298eSfnp1fGB4YcpU0TRG722Z+EAKNkJv84+bVhwntFhn3xmrgBry+ZyE5IIX7olqUA9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316527; c=relaxed/simple;
	bh=mKPK3wrmkFyCumj0Ae7KAGXGFgBgbe0+fybLWDH91CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXTwJ6yh/jPuhRayLV2vU0w+NAIl3dtKrZhpF6y4BHB2clGYe8PJvMG4jUdhWVaWbuLiMzcTL+q7saMX2lL7tNraaW6279N/krbYbbvSrXcnneLPutMGiHN9vGQUFj8xEM5sCqsCD4hfDDCBZMyzK1fijReJUqMa2//UssYxduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=vpkqrXfy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YkH0erlT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 091BB114019A;
	Mon, 11 Nov 2024 04:15:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 11 Nov 2024 04:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731316523; x=
	1731402923; bh=2EuvaPmNkNvZwvgVke3OldybsScSc3h+cb5ManvZGQY=; b=v
	pkqrXfywcQ1vJuLJM2Ii/R4SNkVjRp2reZXj1EBd1HBTVUC3ft4u/aNuouWss0T/
	DAAWoS3BPDBwNI7l6806JLVs5jk1TI3TNS9HECh/hmL9l8uAIqCRHpwT9afHA7ID
	Q1b6GT1BZWoHbZ7a+l3lp0vHYkX4GOKq2tP9vQCixctufWQXOP/3EghF8FZn0vz1
	lATVLUaTbinT/W3bsD8PrhePGo3gnEuaLqr3oWhOmR7nS/IQ6wV5WD35qRiWzGIf
	VS/0hio2B+cGZ7Ic7OVGG0mJKF0R/6v+ZCaWTXb3hw1J7ClVPdH91cGt4dd2pXN6
	fjCGlOmfjHQAMCd+PGVaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731316523; x=1731402923; bh=2EuvaPmNkNvZwvgVke3OldybsScSc3h+cb5
	ManvZGQY=; b=YkH0erlTqgfmMbLC5gRMWzYn8rBgzDjOPRhz6S4lROZkNimdxdk
	IM8ubshIu5tXcVDtJ8kBLaV/O9ZlmkVW6ix1vufdogddxn2nZX38GBdOuidCahWO
	SPi4OV1OmhVOd7JH8PtOnL8eKyUVXOQ2wezMnGzdCqsj//jCrnQ9E5Lusn0zvdEd
	l+SQPVH2aDDYXG6MAE3d3HgSxPwSY261R4QxsAhPSKJlRsYxMaPmChpeEMThoyO1
	hbM90oyOMHRM8D6Q8gmovOt1cDwfudRhwFgjRQ+mpCsVymyq5Dq15rFw+ZAbrRCZ
	ywnxP95HQRd3GRVNSFVm4D/78tk7N1MWpIQ==
X-ME-Sender: <xms:K8sxZ1aK2XGxRTwnD4e29hB-FdU7iewA6gWZEccYGWtVjNjZahsZhQ>
    <xme:K8sxZ8ZGJ0--JZ3Ab2hCfYsaez16nuUDJjhy7lKu7patCarMT7quH_rTZAZHBYixQ
    WbzXhxooIjQ9bYsbUE>
X-ME-Received: <xmr:K8sxZ39eN-cqNT0k--Tz1teT_TKIQKwiwO8_KdzAKW2qCmCMKKh_xT-XIVtaFFO4ZLqX9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffev
    lefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdr
    nhgrmhgvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqmhhmsehk
    vhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhr
    ghdprhgtphhtthhopegtlhhmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhih
    sehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:K8sxZzrCcLU-nF9iPur3ngwNCMYSK-955ROHhruImvIbPI5cDDMQCw>
    <xmx:K8sxZwqTPiUf7NF5us2kWRo8xPcR-h1g3igaJpiLNmYEN2tCPx9JPA>
    <xmx:K8sxZ5Qz3s0OsgxygPQdu8MK-LnzS4lxJr97SXWf6F5CVcRoBIM4VQ>
    <xmx:K8sxZ4p_AKH5Y_RWYErnKff5UY6ZYFyedtALpAUTeIUa0kg9zZASsw>
    <xmx:K8sxZ4IOqKtg-OtoIY17jr7oFjA3AgJpdqBdi3JLEUHM8aKVpgsJgNjh>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 04:15:20 -0500 (EST)
Date: Mon, 11 Nov 2024 11:15:16 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110152906.1747545-9-axboe@kernel.dk>

On Sun, Nov 10, 2024 at 08:28:00AM -0700, Jens Axboe wrote:
> Add RWF_UNCACHED as a read operation flag, which means that any data
> read wil be removed from the page cache upon completion. Uses the page
> cache to synchronize, and simply prunes folios that were instantiated
> when the operation completes. While it would be possible to use private
> pages for this, using the page cache as synchronization is handy for a
> variety of reasons:
> 
> 1) No special truncate magic is needed
> 2) Async buffered reads need some place to serialize, using the page
>    cache is a lot easier than writing extra code for this
> 3) The pruning cost is pretty reasonable
> 
> and the code to support this is much simpler as a result.
> 
> You can think of uncached buffered IO as being the much more attractive
> cousing of O_DIRECT - it has none of the restrictions of O_DIRECT. Yes,
> it will copy the data, but unlike regular buffered IO, it doesn't run
> into the unpredictability of the page cache in terms of reclaim. As an
> example, on a test box with 32 drives, reading them with buffered IO
> looks as follows:
> 
> Reading bs 65536, uncached 0
>   1s: 145945MB/sec
>   2s: 158067MB/sec
>   3s: 157007MB/sec
>   4s: 148622MB/sec
>   5s: 118824MB/sec
>   6s: 70494MB/sec
>   7s: 41754MB/sec
>   8s: 90811MB/sec
>   9s: 92204MB/sec
>  10s: 95178MB/sec
>  11s: 95488MB/sec
>  12s: 95552MB/sec
>  13s: 96275MB/sec
> 
> where it's quite easy to see where the page cache filled up, and
> performance went from good to erratic, and finally settles at a much
> lower rate. Looking at top while this is ongoing, we see:
> 
>  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> 7535 root      20   0  267004      0      0 S  3199   0.0   8:40.65 uncached
> 3326 root      20   0       0      0      0 R 100.0   0.0   0:16.40 kswapd4
> 3327 root      20   0       0      0      0 R 100.0   0.0   0:17.22 kswapd5
> 3328 root      20   0       0      0      0 R 100.0   0.0   0:13.29 kswapd6
> 3332 root      20   0       0      0      0 R 100.0   0.0   0:11.11 kswapd10
> 3339 root      20   0       0      0      0 R 100.0   0.0   0:16.25 kswapd17
> 3348 root      20   0       0      0      0 R 100.0   0.0   0:16.40 kswapd26
> 3343 root      20   0       0      0      0 R 100.0   0.0   0:16.30 kswapd21
> 3344 root      20   0       0      0      0 R 100.0   0.0   0:11.92 kswapd22
> 3349 root      20   0       0      0      0 R 100.0   0.0   0:16.28 kswapd27
> 3352 root      20   0       0      0      0 R  99.7   0.0   0:11.89 kswapd30
> 3353 root      20   0       0      0      0 R  96.7   0.0   0:16.04 kswapd31
> 3329 root      20   0       0      0      0 R  96.4   0.0   0:11.41 kswapd7
> 3345 root      20   0       0      0      0 R  96.4   0.0   0:13.40 kswapd23
> 3330 root      20   0       0      0      0 S  91.1   0.0   0:08.28 kswapd8
> 3350 root      20   0       0      0      0 S  86.8   0.0   0:11.13 kswapd28
> 3325 root      20   0       0      0      0 S  76.3   0.0   0:07.43 kswapd3
> 3341 root      20   0       0      0      0 S  74.7   0.0   0:08.85 kswapd19
> 3334 root      20   0       0      0      0 S  71.7   0.0   0:10.04 kswapd12
> 3351 root      20   0       0      0      0 R  60.5   0.0   0:09.59 kswapd29
> 3323 root      20   0       0      0      0 R  57.6   0.0   0:11.50 kswapd1
> [...]
> 
> which is just showing a partial list of the 32 kswapd threads that are
> running mostly full tilt, burning ~28 full CPU cores.
> 
> If the same test case is run with RWF_UNCACHED set for the buffered read,
> the output looks as follows:
> 
> Reading bs 65536, uncached 0
>   1s: 153144MB/sec
>   2s: 156760MB/sec
>   3s: 158110MB/sec
>   4s: 158009MB/sec
>   5s: 158043MB/sec
>   6s: 157638MB/sec
>   7s: 157999MB/sec
>   8s: 158024MB/sec
>   9s: 157764MB/sec
>  10s: 157477MB/sec
>  11s: 157417MB/sec
>  12s: 157455MB/sec
>  13s: 157233MB/sec
>  14s: 156692MB/sec
> 
> which is just chugging along at ~155GB/sec of read performance. Looking
> at top, we see:
> 
>  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> 7961 root      20   0  267004      0      0 S  3180   0.0   5:37.95 uncached
> 8024 axboe     20   0   14292   4096      0 R   1.0   0.0   0:00.13 top
> 
> where just the test app is using CPU, no reclaim is taking place outside
> of the main thread. Not only is performance 65% better, it's also using
> half the CPU to do it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  mm/filemap.c | 18 ++++++++++++++++--
>  mm/swap.c    |  2 ++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 38dc94b761b7..bd698340ef24 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2474,6 +2474,8 @@ static int filemap_create_folio(struct kiocb *iocb,
>  	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
>  	if (!folio)
>  		return -ENOMEM;
> +	if (iocb->ki_flags & IOCB_UNCACHED)
> +		__folio_set_uncached(folio);
>  
>  	/*
>  	 * Protect against truncate / hole punch. Grabbing invalidate_lock
> @@ -2519,6 +2521,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
>  
>  	if (iocb->ki_flags & IOCB_NOIO)
>  		return -EAGAIN;
> +	if (iocb->ki_flags & IOCB_UNCACHED)
> +		ractl.uncached = 1;
>  	page_cache_async_ra(&ractl, folio, last_index - folio->index);
>  	return 0;
>  }
> @@ -2548,6 +2552,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  			return -EAGAIN;
>  		if (iocb->ki_flags & IOCB_NOWAIT)
>  			flags = memalloc_noio_save();
> +		if (iocb->ki_flags & IOCB_UNCACHED)
> +			ractl.uncached = 1;
>  		page_cache_sync_ra(&ractl, last_index - index);
>  		if (iocb->ki_flags & IOCB_NOWAIT)
>  			memalloc_noio_restore(flags);
> @@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  			}
>  		}
>  put_folios:
> -		for (i = 0; i < folio_batch_count(&fbatch); i++)
> -			folio_put(fbatch.folios[i]);
> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> +			struct folio *folio = fbatch.folios[i];
> +
> +			if (folio_test_uncached(folio)) {
> +				folio_lock(folio);
> +				invalidate_complete_folio2(mapping, folio, 0);
> +				folio_unlock(folio);

I am not sure it is safe. What happens if it races with page fault?

The only current caller of invalidate_complete_folio2() unmaps the folio
explicitly before calling it. And folio lock prevents re-faulting.

I think we need to give up PG_uncached if we see folio_mapped(). And maybe
also mark the page accessed.

> +			}
> +			folio_put(folio);
> +		}
>  		folio_batch_init(&fbatch);
>  	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
>  
> diff --git a/mm/swap.c b/mm/swap.c
> index 835bdf324b76..f2457acae383 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -472,6 +472,8 @@ static void folio_inc_refs(struct folio *folio)
>   */
>  void folio_mark_accessed(struct folio *folio)
>  {
> +	if (folio_test_uncached(folio))
> +		return;

	if (folio_test_uncached(folio)) {
		if (folio_mapped(folio))
			folio_clear_uncached(folio);
		else
			return;
	}

>  	if (lru_gen_enabled()) {
>  		folio_inc_refs(folio);
>  		return;
> -- 
> 2.45.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

