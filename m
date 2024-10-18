Return-Path: <linux-fsdevel+bounces-32377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD229A4766
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A55D1C20D88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1419205AB7;
	Fri, 18 Oct 2024 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LOwxsQnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45620262E
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280950; cv=none; b=cwUlI9uVdTFZh9B3Zt4EMK/l14mgCY7EKGflLxj6rbrdBdr98mt4qk8Our0kL6TcMIR72YH37QTXp3QixbQm6U+x4p4bu5xaPuu58r1n8ry1fLVEjCPLLwXpNozID3FrqBYYsBDFh3qDOke1F1vH0BzEWyKVtQxTmG1ss5RhbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280950; c=relaxed/simple;
	bh=M/KrgYouTo1vY8INYO1w4bOcWFw3XmjpdxHZ9ZEZs0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikKcOvYNlmXbHfmWOVSAp8PQBPzc6Maw5YUEeY2O8anD9yCR+gBQlskDRSsVhQvescI6VijjWvwTDQDgpIqh0fMoWmTGctlvvYKuqFIrwHTBDE7n8JpfjNJrxblo/lmKZdIQ1cXm4n4R7vr5VFu2sxetOFpvfrD9j5uPBHnNbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LOwxsQnT; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbf340fccaso20594536d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 12:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1729280938; x=1729885738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVT9I3VGpwUTJtGbgqlTHdaKtzxRAG8ncP9LOCRjZt8=;
        b=LOwxsQnThOX37Mqwgf3uUCn0I8auSoxFToj6o/0jFEUkavR1q0p/TRr+fb7bMmwCfF
         OLPDz1SeEKd8uo/rMimVw8MeamSq5VHC1ND2bK392pBL5YO1/YlyNUmnlJ5b7g2DC773
         ITS1V+GJXNsumLyoSMr/HiYHFE9sDEKY1UFCdaKuj6qyW3VkPahwdozFYkiAnKQnPvBF
         /raM8/Cje8/l0qG8Tfwpvaf58+SJli27ZoEmbdjPAYnNyEfNYzNeYr5jDg702hiud1rZ
         HrO7k4aqFxGgSTQdN8bdxmlSWGybMapbbZSA6wYtngyrIqBb8tJ2ttQWPCn20Ox1pMWJ
         NPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729280938; x=1729885738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVT9I3VGpwUTJtGbgqlTHdaKtzxRAG8ncP9LOCRjZt8=;
        b=YUAiWqr4spccI71l9R8V0xLcfIbBWzS3D59+XmcTX3HveIckp4mV7l7JNCsv5+6N26
         7oFf4o/cE01dlp1P488q6njKdcxskwO7w2nUTgB4LySI7nmiBrz3tDivnW+8XPgGzgdZ
         yKN4CsYKao2PGcrJ5ARCwlCg9Fi8M8YTsZZg67AnBeLKN8p4sB8XqFGZBb3apdWJ9484
         x/hGzt1HIhnpqguuiLQwWBD5NNqzVI69jlzbkUpIavEsmRKjFFnSFeIgNLqlGMoVoXph
         HDlBWNYoNvlbGKjdITurlxz0TITCPv9E4mWMka/omSkW6RJe6PiArou0fc7gXyr58kok
         uC8w==
X-Forwarded-Encrypted: i=1; AJvYcCXfXAsf7Ikpujn41lpJpfwJJ2l2UKrWjYrFBnfCcDQMhfYM3K6OLGXTtoPMSf/VJoIuIV7NaIto74WwJwaV@vger.kernel.org
X-Gm-Message-State: AOJu0YydmTmf3AwJ3VYpdgsRCOZEyBD7YCcsiGvZt2VEjjmLt/MRRAe7
	g2wEg2W3wowvx81xYhnRwfWK43XWoiMj0PjnP/LlyTOq9rj5I9NGl5k95MkJdXc=
X-Google-Smtp-Source: AGHT+IHYahWBhLKdIA3N0amtbH1s6x+k0pr67+7UULCSsV1aDn5Mhj0jXCCYMUxbv917tINr1+whYA==
X-Received: by 2002:a05:6214:5d08:b0:6cb:f904:4633 with SMTP id 6a1803df08f44-6cde18c94dcmr49254396d6.9.1729280938521;
        Fri, 18 Oct 2024 12:48:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde136afffsm9978846d6.123.2024.10.18.12.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 12:48:57 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:48:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, willy@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH 01/13] fuse: support folios in struct fuse_args_pages and
 fuse_copy_pages()
Message-ID: <20241018194856.GA2473677@perftesting>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
 <20241002165253.3872513-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002165253.3872513-2-joannelkoong@gmail.com>

On Wed, Oct 02, 2024 at 09:52:41AM -0700, Joanne Koong wrote:
> This adds support in struct fuse_args_pages and fuse_copy_pages() for
> using folios instead of pages for transferring data. Both folios and
> pages must be supported right now in struct fuse_args_pages and
> fuse_copy_pages() until all request types have been converted to use
> folios. Once all have been converted, then
> struct fuse_args_pages and fuse_copy_pages() will only support folios.
> 
> Right now in fuse, all folios are one page (large folios are not yet
> supported). As such, copying folio->page is sufficient for copying
> the entire folio in fuse_copy_pages().
> 
> No functional changes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c    | 36 ++++++++++++++++++++++++++++--------
>  fs/fuse/fuse_i.h | 22 +++++++++++++++++++---
>  2 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7e4c5be45aec..cd9c5e0eefca 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1028,17 +1028,37 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
>  	struct fuse_req *req = cs->req;
>  	struct fuse_args_pages *ap = container_of(req->args, typeof(*ap), args);
>  
> +	if (ap->uses_folios) {
> +		for (i = 0; i < ap->num_folios && (nbytes || zeroing); i++) {
> +			int err;
> +			unsigned int offset = ap->folio_descs[i].offset;
> +			unsigned int count = min(nbytes, ap->folio_descs[i].length);
> +			struct page *orig, *pagep;
>  
> -	for (i = 0; i < ap->num_pages && (nbytes || zeroing); i++) {
> -		int err;
> -		unsigned int offset = ap->descs[i].offset;
> -		unsigned int count = min(nbytes, ap->descs[i].length);
> +			orig = pagep = &ap->folios[i]->page;
>  
> -		err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing);
> -		if (err)
> -			return err;
> +			err = fuse_copy_page(cs, &pagep, offset, count, zeroing);
> +			if (err)
> +				return err;
> +
> +			nbytes -= count;
> +
> +			/* Check if the folio was replaced in the page cache */

This comment confused me, I think it would be better to say something like

/*
 * fuse_copy_page may have moved a page from a pipe instead of copying into our
 * given page, so update the folios if it was replaced.
 */

Or something like that.  Thanks,

Josef

