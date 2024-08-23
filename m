Return-Path: <linux-fsdevel+bounces-26986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434AC95D607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 21:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6813B1C21D35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7321922E4;
	Fri, 23 Aug 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zY/FN2wl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5A8F6B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724441069; cv=none; b=AourKrMrI2gUbfsl6wYUBCV5ott3Mg53+LJzWMQt01NRX77vRF4c9W+o5kot8RFQUE7sEzxsucdkZGvP0DSYRH+ISYCFPc19QO3nO+nmHMxa1PXzNHJaI30oC+S/UaIb9OoPsb7b2cq1bqBcUpbj1tgm4U4w8icvDr9d460R/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724441069; c=relaxed/simple;
	bh=WU01GnnMC2BBB89ODV7P6mjROQZvqdXGnVmeYvMjzUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdF3bozWoTtxtU5hso+Or25/pGaL8j2hPf3DD1mYTHG19lHalaPPuLbhNL5dzkArT/twhYrnccIVYdqsMuKpQdA/Lcui+XVH7ln4K82OTAQRg/ifY6ey9s4kuU154ZJqr9/giFVsjPw239qvY1YoYjOq4nIAsKnQbMcgNgvEiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zY/FN2wl; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6bd3407a12aso22029037b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724441067; x=1725045867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXMSAQ3i41p4ywSmIBkAHewLwvvbhnXpASefznpqmlU=;
        b=zY/FN2wlzHGRFTKtZra6Qdi8JaXc44eDMzk/npaHUrozCC8ver6WxVqsQVfho8ZOP3
         OD1ci7fWOMmrCZh78bClTbUB2gXJjkUQBJri7kmKuvREVYjZeAGN6mA+ifxtoA8aGOxf
         g/oj4vn2/9G3cnh48Jt4FE2e5dMaDduIXfUyVDiFfo9GN+S70h9rM9Prc54pBHqlXJ3b
         Mnq0wTY+wgc6e4v+5lXeFEScdTazIvW+iv9daP80rhVIdRxweGumETUT3rO+VsonwKOK
         hZ27r+GcpvKRenhC6K2xSa76SCyZSAhxDv5Z3p6vFNzcS3meyQylKcX3szJkYyNykn/3
         Nijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724441067; x=1725045867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXMSAQ3i41p4ywSmIBkAHewLwvvbhnXpASefznpqmlU=;
        b=rZkJqhVftjDMi2RHhxuwPfKdkpTB7etta4nFWY9E090s2Tap/Owp82RGK7K3PuGRTW
         t/tFCFTA9FAaFHM+Cf3yFBoDh6StbKzKBPzNxhWbFFNAcflGPw2XORjMqgKr2ckedYLj
         jrxiwiwXRPsiBe8wyaII8dItTU30nEtp4J7wyuZHMaCde65QI+ItxyYbshXiTjFHPW5q
         cFw7Zi9tMMtgKTH3YVW4podRestS/gzD6JWAT6+5DKKMlUXuoVh3l8Euh4q8wtyhkPDy
         36KFwES95wWfRslCDiMl1ARpS5kKHZT0JDusMSam5ImqvREI87VL89yM9fK8hHcdcu4H
         GvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6x9bm4IwUoKYouWLWnoZ9MbYgl6sD/xODhYZ8fndwV1GB7uXz+w//f5o4I+3RQq+dEPbaP1qbybwC3tCH@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpolow68zjcpSm3+te5fYbCeZUOKVj1O0Q/EZBeJxQV6NCQ+K
	6CXgkBdyIf5kRg//5wR4ocnXDw12MmIBe9P6OFZoIRqqNY9cEz4R2/aglXJs3CU=
X-Google-Smtp-Source: AGHT+IHmc2pP1mAWPpMp2BnM6urJWh6j640nDRRXh8xqV3gjCflCjGDjE2BqN9MYfMAQkUu4UPoOkg==
X-Received: by 2002:a05:690c:f84:b0:6ae:93bf:6cbf with SMTP id 00721157ae682-6c625a4c76emr40418917b3.20.1724441066933;
        Fri, 23 Aug 2024 12:24:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb4f82sm6498237b3.1.2024.08.23.12.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:24:26 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:24:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 9/9] fuse: refactor out shared logic in
 fuse_writepages_fill() and fuse_writepage_locked()
Message-ID: <20240823192425.GC2237731@perftesting>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
 <20240823162730.521499-10-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823162730.521499-10-joannelkoong@gmail.com>

On Fri, Aug 23, 2024 at 09:27:30AM -0700, Joanne Koong wrote:
> This change refactors the shared logic in fuse_writepages_fill() and
> fuse_writepages_locked() into two separate helper functions,
> fuse_writepage_args_page_fill() and fuse_writepage_args_setup().
> 
> No functional changes added.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 99 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 55 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2348baf2521c..88f872c02349 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2047,50 +2047,77 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
>  	rcu_read_unlock();
>  }
>  
> +static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
> +					  struct folio *tmp_folio, uint32_t page_index)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	struct fuse_args_pages *ap = &wpa->ia.ap;
> +
> +	folio_copy(tmp_folio, folio);
> +
> +	ap->pages[page_index] = &tmp_folio->page;
> +	ap->descs[page_index].offset = 0;
> +	ap->descs[page_index].length = PAGE_SIZE;
> +
> +	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> +	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);

Same comment here as before.  Thanks,

Josef

