Return-Path: <linux-fsdevel+bounces-36834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B759E9AE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA6A18880E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C912B169;
	Mon,  9 Dec 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nwRYSmwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3978C9C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759447; cv=none; b=Bdni8a4A1fieoFyfCQEQyfi4ojUw+YCHWm/IlYqYVK+IPh16aOnuC3A0QMJNNJZBgjqks8uVxftrfTKnmfMUnn0WHoiqzOzAt2/BxumGu2uO0pjMTiwRXKij4L0fI7BGyqw9P+y6IEA7p7LEszAkE09j8d/IeQc3xQf1y97Msuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759447; c=relaxed/simple;
	bh=j4PyurvNex5nCaX9qPfIDavuEqwBP6SYOK8AtGlYn0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk6d93itZqtwxh2Ap6vX/UknjaM7ejGFzuU3WnlF0wn88CSS9wcbpX4wkXuRTS8Jtf7IKH+KkzkOd20hHeHELjcPFqxNI64nHQwGIaV/InuITlCuHLd6m+VZfca7d28CDexv1Q4C0RkAG06K9oWhMLLOlObtX0ZshbRKROSoZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nwRYSmwt; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8fd060e27so18026096d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1733759444; x=1734364244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXcCCdKluEXVgGyQs+rBus1w/VvIp4GJX7IRFye339s=;
        b=nwRYSmwt5zlvxXMTeuRFLCNXQyNnFhqKBKtJzbRGJ2aRnkR8CSI1SHo7MahXBfnbEC
         DK+4nwvanXuoPFVhHAZJj95wfvCcmq/SP1YUHd4dB7Mbesw5pe9XIGWV10KL2xN3EzgE
         E+IszMsZqrwwZnGmQsTNDVpeWHrFCzVa2+WuvI12n8Z/5UZvA1UV2CH6oNsdmV2Cme/I
         Uc+mMXNcKiLSn+ZNLDT6i3WvqjOsS2prTXaTH9DuUBRNJDghCIfpZJhHhHlffiyZ6+OO
         7KaO/0FwlDBXoKqEIhJ5rHcPhhkxHadyALMVdmwpSRxQpGaxDEwDgL6BasuwIGUhV9nG
         GhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733759444; x=1734364244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXcCCdKluEXVgGyQs+rBus1w/VvIp4GJX7IRFye339s=;
        b=rhx6Zwce+WhxSzstBfq+0KZ8Jp+SnpHVpgrPALfZEB77SnNuRe0VEkqPg9NN5omxf4
         wmQQXl6KPKdnTIPahhAIlOWHKoEg8sV5WGw1LQ1ASspME1E4PmYwigPrZiBUz3J3/kRl
         Tv7X9JL6D8IqrSwv/D25I8bFL4NKEk9ObF5RJJItDtSjwswYjGG/PUrjQOkvd68Ohsjb
         ih1Lz4AAbcOJp3si4atv6rtT2NTU35XCfO8incs4imKS80slgwCBopYuloaS/7wSzge2
         wO/MDBN96kbtjraxykNbpVAWR69VoX05qYxx4OonRTdYCLvw+Kln4UO97PqWEc5DbJ/+
         yEMg==
X-Forwarded-Encrypted: i=1; AJvYcCXAA7+fuCMaWAEOxWOxnrI8kYVeT3aiS4L/9muEsJQFWm3o0sPP5N58N0bJC7TlwCNttB3MIKvoqAQstSzu@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZ22029zBPN1xrzElpo+1dfxtyF+iAmxn1RZrF5tdzTvm0EoN
	EB5OsDu59xreeVjQFyOhtaZBiG4moEpSSoPa+EUWl/jLZucbKLuGKbP006GcBt8=
X-Gm-Gg: ASbGncvTNSSAJbqW2xIGgsxOMnr+7TcsmagGpU9HNSc7j2KDNjXWuDAcSqi0MV5EoPy
	eE96EjVaYUzUyOhK9y9MI6zIm84uTxxPsg8rmNfWHu992cculhT3rIkJBsZRAqnu6mj12D/Rec8
	zX7fAETalIIM+or2IzwoINgG3/NLjrFcuhRu1EZMIKLnBp/6TeoPcOGOh4XdcB57cADgKY/b3kn
	S2OY14ehywMhrbcYMQo1wUzs4PJymXgYUrP617ja9xFW8yf5LqJuiu9HMwZMWMC6xVg7HZHqnpH
	46gtnmo1sZg=
X-Google-Smtp-Source: AGHT+IFvFDFZtnSawvlkHJZocNpG2Ly71aiWb/41k1AkQv7WNfZkYkDaI3sdvp8RGv1fUTgw01IXwQ==
X-Received: by 2002:ad4:5d69:0:b0:6d4:1d4a:70e9 with SMTP id 6a1803df08f44-6d8e70e9247mr183633896d6.19.1733759444440;
        Mon, 09 Dec 2024 07:50:44 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dabfb7a4sm50236616d6.104.2024.12.09.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:50:43 -0800 (PST)
Date: Mon, 9 Dec 2024 10:50:42 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 10/12] fuse: support large folios for direct io
Message-ID: <20241209155042.GB2843669@perftesting>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <20241125220537.3663725-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125220537.3663725-11-joannelkoong@gmail.com>

On Mon, Nov 25, 2024 at 02:05:35PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for direct io.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/file.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 590a3f2fa310..a907848f387a 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1482,7 +1482,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  		return -ENOMEM;
>  
>  	while (nbytes < *nbytesp && nr_pages < max_pages) {
> -		unsigned nfolios, i;
> +		unsigned npages;
> +		unsigned i = 0;
>  		size_t start;
>  
>  		ret = iov_iter_extract_pages(ii, &pages,
> @@ -1494,19 +1495,28 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  
>  		nbytes += ret;
>  
> -		ret += start;
> -		/* Currently, all folios in FUSE are one page */
> -		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
> +		npages = DIV_ROUND_UP(ret + start, PAGE_SIZE);
>  
> -		ap->descs[ap->num_folios].offset = start;
> -		fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
> -		for (i = 0; i < nfolios; i++)
> -			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> +		while (ret && i < npages) {
> +			struct folio *folio;
> +			unsigned int folio_offset;
> +			unsigned int len;
>  
> -		ap->num_folios += nfolios;
> -		ap->descs[ap->num_folios - 1].length -=
> -			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
> -		nr_pages += nfolios;
> +			folio = page_folio(pages[i]);
> +			folio_offset = ((size_t)folio_page_idx(folio, pages[i]) <<
> +				       PAGE_SHIFT) + start;
> +			len = min_t(ssize_t, ret, folio_size(folio) - folio_offset);
> +
> +			ap->folios[ap->num_folios] = folio;
> +			ap->descs[ap->num_folios].offset = folio_offset;
> +			ap->descs[ap->num_folios].length = len;
> +			ap->num_folios++;
> +
> +			ret -= len;
> +			i += DIV_ROUND_UP(start + len, PAGE_SIZE);
> +			start = 0;

As we've noticed in the upstream bug report for your initial work here, this
isn't quite correct, as we could have gotten a large folio in from userspace.  I
think the better thing here is to do the page extraction, and then keep track of
the last folio we saw, and simply skip any folios that are the same for the
pages we have.  This way we can handle large folios correctly.  Thanks,

Josef

