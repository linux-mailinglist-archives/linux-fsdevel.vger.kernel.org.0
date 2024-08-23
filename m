Return-Path: <linux-fsdevel+bounces-26984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC2F95D5C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 21:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AACB1F22701
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1547D18EFDB;
	Fri, 23 Aug 2024 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XSTve6jV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0580C02
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439834; cv=none; b=imT/tviDMlpSfxjfjP8aPVJg98uH1CWTdXzQzi2PNFiWtW0lCS8BZ4FufXrztWeHzts5NJPpPSaVOTLa+eXlD/E+NH1ZOBkJyZMYqp/ZcDgrOrULZGthBnsy4EZhfpdssujRc1ZUA06o+GOpxIo5Hru3vjlXoN3IN7qprDDuKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439834; c=relaxed/simple;
	bh=CQ+59OO7OcOeXAVYKXPow2DGLRYvomTmPHCvqcsYrKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/5KCd1qVrxljchLj2+1BbIRKrltmkki4/ukT+qoOleleQP8nvTDD22SmlUchvQmSe4xKuKaneUu62WdhYzilCHYbyCVgXH9dU1t07CmLoqTEwfz0UWCv0OWGT4sgrOhsjygM/9/7wxcfsbgmY8qXW4kFiOmRj/Oi/SBElxobsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XSTve6jV; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1882946276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724439828; x=1725044628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEDMT3wBqq+WCy/U4QV9MUneXkK/rbWyof3A0Wbh1cg=;
        b=XSTve6jV3oO3PBTlSaWBW3vxOC6IzdnW5UcFGITYNWM8RNDId5TzLEQLxMxintd6ho
         hu9Jw5NMOgJl+uX/giEMZl7OY5dSKUx4C9BExgzq1rYoAtzuuXS52NXwxBJhJcVsC9Up
         7Ok5J/no1T2UdAb1qusOzKjjifgIodanZDFEF/MnaQ1d/laEvgPeSndWEJ0JNDakQGFj
         OUTcukU8IEcQlz+QV1BSXCwbUhS4ptE/tVjATxdRB/aXp6FtDKcd4V+JwIruUggXWCPU
         ugQaCdGylHvnnfKojnWFW9I2rwWa79Sm7yyNuN5KCDwkjYVWo++MF0kh3AsZZ7bW9fnx
         xIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439828; x=1725044628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEDMT3wBqq+WCy/U4QV9MUneXkK/rbWyof3A0Wbh1cg=;
        b=wmAZCPm0LTY9DNQhRzUvG4xF0TDpMmjgjjNhLoSgaMojNeapvvnD4zz6tLobcO/2mQ
         g7kwULmRj++XNbdN5s2+P2I4DeCFbdG8eOudYGAv8OPQEsp8XxUCwDzPg/1W/erSLGhT
         vQ0c+50xLdrqxGsXT9b8yqj4pS8v0vw4QqdL/ulkxecEdw5e73H/g8cGRvJdLpdGakYh
         o6ylk7p1bm2Fs7FzeB/e6ZRs22peBGHatFCjHuw9sA4o52AQ3fNSHBfHmoS0BNmuFz12
         i0dPFQQdLl458n7dRo7NNWAoIr/uTpyquxOA0i5M2Z/ZgVd1/O29/VPSfJObxeOqFfRy
         pN6w==
X-Forwarded-Encrypted: i=1; AJvYcCWUHhc8RPpwLRjdFeswQVy0UEwPopF9Pc+CV48GsUC2VJxUfL1WMYCn/+qNSkS/BvDtVV8+dkBnsjmVeuIq@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJc8fAoEUryuL4IUODFBvwTVr8cqlyXxjkByhhSR24Q9lBI4c
	wnRAhk65Ghi5JA1IseyLM5oZgD+7KE9ejDwh9Xe3Sba0ociSX29A/DPmkJuqhEs=
X-Google-Smtp-Source: AGHT+IFPvCP8XJxIQk13xYhOZSVE+h3Ot9lvMb7KJ8PihzjVdbEDQHZsHhkIsKnJabelmCVCGxNKxw==
X-Received: by 2002:a05:6902:1684:b0:e03:5505:5b5b with SMTP id 3f1490d57ef6-e17a74cae11mr3141135276.0.1724439828605;
        Fri, 23 Aug 2024 12:03:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e681377sm758815276.62.2024.08.23.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:03:47 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:03:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 6/9] fuse: convert fuse_writepages_fill() to use a
 folio for its tmp page
Message-ID: <20240823190346.GB2237731@perftesting>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
 <20240823162730.521499-7-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823162730.521499-7-joannelkoong@gmail.com>

On Fri, Aug 23, 2024 at 09:27:27AM -0700, Joanne Koong wrote:
> To pave the way for refactoring out the shared logic in
> fuse_writepages_fill() and fuse_writepage_locked(), this change converts
> the temporary page in fuse_writepages_fill() to use the folio API.
> 
> This is similar to the change in e0887e095a80 ("fuse: Convert
> fuse_writepage_locked to take a folio"), which converted the tmp page in
> fuse_writepage_locked() to use the folio API.
> 
> inc_node_page_state() is intentionally preserved here instead of
> converting to node_stat_add_folio() since it is updating the stat of the
> underlying page and to better maintain API symmetry with
> dec_node_page_stat() in fuse_writepage_finish_stat().
> 
> No functional changes added.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a51b0b085616..905b202a7acd 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2260,7 +2260,7 @@ static int fuse_writepages_fill(struct folio *folio,
>  	struct inode *inode = data->inode;
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> -	struct page *tmp_page;
> +	struct folio *tmp_folio;
>  	int err;
>  
>  	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
> @@ -2269,8 +2269,8 @@ static int fuse_writepages_fill(struct folio *folio,
>  	}
>  
>  	err = -ENOMEM;
> -	tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> -	if (!tmp_page)
> +	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> +	if (!tmp_folio)
>  		goto out_unlock;
>  
>  	/*
> @@ -2290,7 +2290,7 @@ static int fuse_writepages_fill(struct folio *folio,
>  		err = -ENOMEM;
>  		wpa = fuse_writepage_args_alloc();
>  		if (!wpa) {
> -			__free_page(tmp_page);
> +			folio_put(tmp_folio);
>  			goto out_unlock;
>  		}
>  		fuse_writepage_add_to_bucket(fc, wpa);
> @@ -2308,14 +2308,14 @@ static int fuse_writepages_fill(struct folio *folio,
>  	}
>  	folio_start_writeback(folio);
>  
> -	copy_highpage(tmp_page, &folio->page);
> -	ap->pages[ap->num_pages] = tmp_page;
> +	folio_copy(tmp_folio, folio);
> +	ap->pages[ap->num_pages] = &tmp_folio->page;
>  	ap->descs[ap->num_pages].offset = 0;
>  	ap->descs[ap->num_pages].length = PAGE_SIZE;
>  	data->orig_pages[ap->num_pages] = &folio->page;
>  
>  	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> -	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
> +	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);

I *think* you can use

node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);

here instead of inc_node_page_state().  Thanks,

Josef

