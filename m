Return-Path: <linux-fsdevel+bounces-35587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA79D60BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AA6281287
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F17580C;
	Fri, 22 Nov 2024 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="h0KvaHU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4A182D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286859; cv=none; b=kKtbvOqkZk1V8TGd2SYFTfMHnCyxCQAOy+9aoDiV6SALJkjRSDwJOr+KOqsqfFa/qHzqSyNgXpyvb4nvgaePX6/LCu9rMolPNxADG3SZ6T75qxdP/gaWXrz8U3W3eCQhw2Oy5k/LzQfXm6ZbrCWj8RrEzzHR2qh/d/U93bPMgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286859; c=relaxed/simple;
	bh=RHZ3XrSmylTQF9vJy81QyahgwTGG7cOwGmS+6tGErb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8Rfa1AzXrulddgrRhZMFLPDgpdhQYj98yX4klMrWIkw+YfHO4FEd+AhfLjoXXFiFovlA2eIGMprXAm9Mh+WAhG6vqp/0pJBlC1gzaQ1FbCUs1VcDx0WxUdyOooEW6PsJncznstGobvKNqNi3N6M7wltAhTnDnnw73FGwvY+XKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=h0KvaHU3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460d1145cd8so14322921cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732286857; x=1732891657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ1w/1fNhL4tbt5dzl7UAMhA13QdVwwPQiLkMDy1kzM=;
        b=h0KvaHU3QAkQ/xUrQfEnW9OfbF/i/WL2Cp5ZOcOoofZIoFTIdni8Q2fdr1rPgLoVzo
         8XU/5MGW1zIsrS8J1W0Ks+YLRSk1h2IPoVjITYQPWkOTSQUsy1pSFKYTUvuy2Wuzyn4w
         pl43LBKRAJfkSvvdRB8gAgMcP1zU/n5DpVgXKTWGLApSq3XpXybxRAXO3ueH38ApFJgU
         9rmIL9S34QEr/cK+MNL1cPWB3L04OJHYhP75hsGmb/OSwcj5xxUvFDjlexpN0cf+4Zdj
         CxicJ0Rm1KB06R3e2DCG7TwBlVym1yeSZ5nOpVz6Ed13BhwFgp3gkAw+9oBwAuYkfU8I
         ij2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286857; x=1732891657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ1w/1fNhL4tbt5dzl7UAMhA13QdVwwPQiLkMDy1kzM=;
        b=UiJWVfMJbXc4qUzmg/fhID4HJXs4+6+1ybep/Zi4mtqd2EejWN+3M1czXYNWA5NLVs
         /ai6JNHWegd/aBD+W9MtlTdokAzv11vWIQsIZnpAvxN8YfLISGbGTRViGWBIdnhqjUBi
         +cloVbzB+kXowyHIZ1MwAQz3RCWloxDkJmNgD00d9V9M0uAU4pspRMqHzLbkWD5DwZH/
         Kz8Cd+ZlXdskjX/mNMTjSTURHwai0BhD/92yccPL6qb72qooDUn3uq1PxZJJOqGP20bb
         LUH15UBCj8Qv1wOSWTeskK9ICuDbvnHxJBxrzV9UBdMUKVThp82m/TnySNiYj5J/uSYq
         FJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLUnUKahBBgXUkcq9nzl8xMYN7W8bH+giukNisgYz9H4atqIzaU8vgYKYnEgJ55T0jBMvIOa6QUXHTgQGV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pyI3zwgbbg9Ihoc+XWriIXl4lnZqXDHL8VfJEfAAY2bsKj2G
	r4Fa0YfuHWPOkl5n/o44uf7a4WCwQqe9b1K256pY4Ydd5xFfJy7xJmwkrKcniUw=
X-Gm-Gg: ASbGncv//nZhQ9bgIyW/mZa/r82wZQXiVHZteBRshJNJyzhDJhyeTFn1V1nC15T3LWM
	rGRN9wIE2MlCdYNwGTWElin7EeTJ6N2YHKmeWBSEEMTLyJi5HWDVyXxKBbteTRc/XApgvuwKRUa
	Te31cICF97qxC6Ri58nA6lxgs3rwy6vmHwLrub4TI1+Ye/CSYvflby0qr87XlQYj369Qduj4hib
	zjTFGFg/h2xzkOds2b4jdmYc+j8cYDTcqnEwaOhtcwP1MkaZyiUOT38VE7e0SaM6ORBRAXMSSlm
	vQV8X9d5we0=
X-Google-Smtp-Source: AGHT+IGPku3D5XsRBnmxpA04rtoGShb8KHnBLvea2h4Ly9Kgk11UbIHGLQ9uIGX5z7eFHu0rjiU9cQ==
X-Received: by 2002:a05:622a:2294:b0:464:b81c:3171 with SMTP id d75a77b69052e-4653d52263bmr41375071cf.6.1732286857091;
        Fri, 22 Nov 2024 06:47:37 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3ee8a1sm12236071cf.27.2024.11.22.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:47:36 -0800 (PST)
Date: Fri, 22 Nov 2024 09:47:35 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 09/12] fuse: support large folios for readahead
Message-ID: <20241122144735.GE2001301@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-10-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-10-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:55PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for readahead.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 44a65bdfe8fb..255c7f2f2ed4 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -885,14 +885,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>  	fuse_io_free(ia);
>  }
>  
> -static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
> +static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
> +				unsigned int count)
>  {
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_mount *fm = ff->fm;
>  	struct fuse_args_pages *ap = &ia->ap;
>  	loff_t pos = folio_pos(ap->folios[0]);
> -	/* Currently, all folios in FUSE are one page */
> -	size_t count = ap->num_folios << PAGE_SHIFT;
>  	ssize_t res;
>  	int err;
>  
> @@ -929,6 +928,7 @@ static void fuse_readahead(struct readahead_control *rac)
>  	unsigned int max_pages, nr_pages;
>  	loff_t first = readahead_pos(rac);
>  	loff_t last = first + readahead_length(rac) - 1;
> +	struct folio *folio = NULL;
>  
>  	if (fuse_is_bad(inode))
>  		return;
> @@ -952,8 +952,8 @@ static void fuse_readahead(struct readahead_control *rac)
>  	while (nr_pages) {
>  		struct fuse_io_args *ia;
>  		struct fuse_args_pages *ap;
> -		struct folio *folio;
>  		unsigned cur_pages = min(max_pages, nr_pages);
> +		unsigned int pages = 0;
>  
>  		if (fc->num_background >= fc->congestion_threshold &&
>  		    rac->ra->async_size >= readahead_count(rac))
> @@ -968,14 +968,24 @@ static void fuse_readahead(struct readahead_control *rac)
>  			return;
>  		ap = &ia->ap;
>  
> -		while (ap->num_folios < cur_pages) {
> -			folio = readahead_folio(rac);
> +		while (pages < cur_pages) {
> +			unsigned int folio_pages;
> +
> +			if (!folio)
> +				folio = readahead_folio(rac);
> +
> +			folio_pages = folio_nr_pages(folio);
> +			if (folio_pages > cur_pages - pages)
> +				break;
> +
>  			ap->folios[ap->num_folios] = folio;
> -			ap->descs[ap->num_folios].length = folio_size(folio);
> +			ap->descs[ap->num_folios].length = folio_pages << PAGE_SHIFT;

Why change this?  Aren't these equivalent?  Thanks,

Josef

