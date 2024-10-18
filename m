Return-Path: <linux-fsdevel+bounces-32381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692959A478F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 22:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E025C1F252EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768D91EE00E;
	Fri, 18 Oct 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Zv4kv3kZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028C383
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281771; cv=none; b=cmEwiWrIWW+Kdel6oPjSVTXJiiBphaTzhE0xklzJ3LmVQ/MIjQAT8J7gcHNVdZoJtTd2BSimr00eTl+ar43lwvHLdbexP+zAcqsnOlAdg9JMovxokyiKFVJ4f0n2PD6QyfKPiIZVux3yx4m1moxtuH4YqIXL+95dQhm5216wI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281771; c=relaxed/simple;
	bh=4nmIWhDv439GcRD7q0WyZ1m6EG1yeWDSnhKWZ2QBFdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzs5B84maX1VBPlBgjynzcGfNheX4pmdigNYafiS7X4SdaslN8LGLvvyUuQVA50CwTZs8MUIK3N3EeB/WiHV3RcQx1YMr1MNr3ru/SniWeEFY/kn+0CFOwwb97B6RsGcPCKg+nlUfNAOGMc6yedEfxz4Vdvhwloh9jZzuyv1suE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Zv4kv3kZ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1418058bbso172704385a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1729281769; x=1729886569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLlZLrJ+T1VVSm7YBIEkbL8hjICk9SmIQeyQ8r2ACUA=;
        b=Zv4kv3kZmsVz7D25khHVwcUdsMwQKGOtT9f7ialXKIsBUtVf9EqXjexzXxMQWeeDzq
         Zg/xr2EWdedfs+0/BAn0hXdrCjgwDYFpIzA0XbT8dKSn24EafBw+gzX2IGEXG4d/DvoB
         qag2UPrxB5T7gtDHG6AajOv427DvqJjYZvDdtXNWGP/Q+17t0Gy8YDshf4WEipdcO+KD
         c2b6DmoPnZquliAfgsvKw2zkPxoJe4UKaEMI8klm/P+xqaJfCwIxCrwjuO5CyPu5V2bt
         a9ktgNdbzoUKt3T7bRhVP1QGkSs421YfwxFef4HK1HB6uEKZkUNsrgH+BrT/lpG9mTUK
         PCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281769; x=1729886569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLlZLrJ+T1VVSm7YBIEkbL8hjICk9SmIQeyQ8r2ACUA=;
        b=kGaWcsiG3VK8Kz+m8WbsB0yT2rykJWbbnNKa9MQ5XYGXnYjRvU2lC75l6MGq+ctVOU
         wJRI0llmxLSOEggMsiuj47de/iPWrQvLeE78iHL9OSfsSZepqZFTGx9GLGc1mIk47LPY
         kymPQRAf/zyqi15g4jkUyGwyOQ7NL7Yk4ZE8LyH0kWGR3km+zvjnhHjF2Z6SNCiT4Y0U
         w0GyNGI5uo4PLCd34t63clbl3KUrvotB/+n2Voqu6Us3f8te0ZkU+kuQklBkvgg53GoJ
         RTC/4ef1sKmP+ELmxpDEFGDsEyVMQXYbbArCA8/a/nzGeedOrLwIdD0prLCUziEA6ho1
         KmKA==
X-Forwarded-Encrypted: i=1; AJvYcCWlkfZYZAVMI3Q4goUUjLByPAdcCx6QJNa4+EE+FFWI4PDMKX4mPi+tbjEV4uFjDseRm0vS21UUZN72a7tj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpm6qMDHkXoBPCxdTLsNeu2EltmSA+1TJw12vc2xWwko0z1ttw
	eW09CvAUl84j9a7gi/64HHcdS1MWSATrOGGhH0ebOWU4oePqSZHvTctf2zidEwo=
X-Google-Smtp-Source: AGHT+IGOQ7PhkgYOyPF8+g3sICgTBG32pGwUbWSxRVxZiiVINNA2mtJP8GhT/Q/9yyxOyLfcIeC2hQ==
X-Received: by 2002:a05:6214:3901:b0:6cb:c9bb:b040 with SMTP id 6a1803df08f44-6cde14c5adamr52877356d6.3.1729281767781;
        Fri, 18 Oct 2024 13:02:47 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114ea2asm10113076d6.31.2024.10.18.13.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:02:46 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:02:45 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, willy@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH 12/13] fuse: convert direct io to use folios
Message-ID: <20241018200245.GC2473677@perftesting>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
 <20241002165253.3872513-13-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002165253.3872513-13-joannelkoong@gmail.com>

On Wed, Oct 02, 2024 at 09:52:52AM -0700, Joanne Koong wrote:
> Convert direct io requests to use folios instead of pages.
> 
> No functional changes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 88 ++++++++++++++++++++++----------------------------
>  1 file changed, 38 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 1fa870fb3cc4..38ed9026f286 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -665,11 +665,11 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap,
>  {
>  	unsigned int i;
>  
> -	for (i = 0; i < ap->num_pages; i++) {
> +	for (i = 0; i < ap->num_folios; i++) {
>  		if (should_dirty)
> -			set_page_dirty_lock(ap->pages[i]);
> +			folio_mark_dirty_lock(ap->folios[i]);
>  		if (ap->args.is_pinned)
> -			unpin_user_page(ap->pages[i]);
> +			unpin_folio(ap->folios[i]);
>  	}
>  }
>  
> @@ -739,24 +739,6 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>  	kref_put(&io->refcnt, fuse_io_release);
>  }
>  
> -static struct fuse_io_args *fuse_io_alloc(struct fuse_io_priv *io,
> -					  unsigned int npages)
> -{
> -	struct fuse_io_args *ia;
> -
> -	ia = kzalloc(sizeof(*ia), GFP_KERNEL);
> -	if (ia) {
> -		ia->io = io;
> -		ia->ap.pages = fuse_pages_alloc(npages, GFP_KERNEL,
> -						&ia->ap.descs);
> -		if (!ia->ap.pages) {
> -			kfree(ia);
> -			ia = NULL;
> -		}
> -	}
> -	return ia;
> -}
> -
>  static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
>  						 unsigned int nfolios)
>  {
> @@ -776,12 +758,6 @@ static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
>  	return ia;
>  }
>  
> -static void fuse_io_free(struct fuse_io_args *ia)
> -{
> -	kfree(ia->ap.pages);
> -	kfree(ia);
> -}
> -
>  static void fuse_io_folios_free(struct fuse_io_args *ia)
>  {
>  	kfree(ia->ap.folios);
> @@ -814,7 +790,7 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
>  	}
>  
>  	fuse_aio_complete(io, err, pos);
> -	fuse_io_free(ia);
> +	fuse_io_folios_free(ia);
>  }
>  
>  static ssize_t fuse_async_req_send(struct fuse_mount *fm,
> @@ -1518,10 +1494,11 @@ static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
>  
>  static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  			       size_t *nbytesp, int write,
> -			       unsigned int max_pages)
> +			       unsigned int max_folios)
>  {
>  	size_t nbytes = 0;  /* # bytes already packed in req */
>  	ssize_t ret = 0;
> +	ssize_t i = 0;
>  
>  	/* Special case for kernel I/O: can copy directly into the buffer */
>  	if (iov_iter_is_kvec(ii)) {
> @@ -1538,15 +1515,23 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  		return 0;
>  	}
>  
> -	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
> -		unsigned npages;
> +	/*
> +	 * Until there is support for iov_iter_extract_folios(), we have to
> +	 * manually extract pages using iov_iter_extract_pages() and then
> +	 * copy that to a folios array.
> +	 */
> +	struct page **pages = kzalloc((max_folios - ap->num_folios) * sizeof(struct page *),
> +				      GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	while (nbytes < *nbytesp && ap->num_folios < max_folios) {
> +		unsigned nfolios;
>  		size_t start;
> -		struct page **pt_pages;
>  
> -		pt_pages = &ap->pages[ap->num_pages];
> -		ret = iov_iter_extract_pages(ii, &pt_pages,
> +		ret = iov_iter_extract_pages(ii, &pages,
>  					     *nbytesp - nbytes,
> -					     max_pages - ap->num_pages,
> +					     max_folios - ap->num_folios,
>  					     0, &start);
>  		if (ret < 0)
>  			break;
> @@ -1554,15 +1539,18 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  		nbytes += ret;
>  
>  		ret += start;
> -		npages = DIV_ROUND_UP(ret, PAGE_SIZE);
> +		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
>  
> -		ap->descs[ap->num_pages].offset = start;
> -		fuse_page_descs_length_init(ap->descs, ap->num_pages, npages);
> +		ap->folio_descs[ap->num_folios].offset = start;
> +		fuse_folio_descs_length_init(ap->folio_descs, ap->num_folios, nfolios);

With this conversion fuse_page_descs_length_init now has no users, so I'd add a
followup patch at the end of the series to remove it.  Thanks,

Josef

