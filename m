Return-Path: <linux-fsdevel+bounces-32380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFCC9A478E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 22:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B52BB249F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 20:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865C20969C;
	Fri, 18 Oct 2024 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pRgapvTe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F14205AD5
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281704; cv=none; b=c8CW1MRE1sHjBXTCcVPNEEKoVLmLtNo3tGvZcAzPcHCgF2O2WgrNzdporWXKSICv8PoegQuGHr8Dn8I4/TnGdOHksb8c1sjjOUtSunzH+SaWZIGZAh+pR1PyTyX/hWBAMOkYeJ+LgffJvEbfM0avumu+SNdLGtCWvHOAhK7u3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281704; c=relaxed/simple;
	bh=Ycsq+hHxPm1QuZd4qsZx/47ZChJvUWlTHijj1a92UgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSTIDFuDP+L8gfTn4+yspr0yTiBqmsZix/Ro1Zo7HeEFgB69GqQp25Ti29svYcDyqk2fnM1k9/cSl5xzO/tT2fLaQ8JgGjkF1gb1DMdJe/mhhjLblYCADQ6Rsw/IBI7X4wAfnvlnM2g5WUvbhq/J1/bV8ICqJzA+MNPGmP3Qzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pRgapvTe; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71807ad76a8so1429095a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1729281701; x=1729886501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFFd8ZiZqQP0xoSa5AwcGy3ur/TerrfcqWoBAh/ynbQ=;
        b=pRgapvTeu5J73bMRsBgbSBm7Yt4Op3fO5StBcUbO6MqfiXwdUAYmOe1ruCHEm8S24K
         k1Y1lWwPwdSbOSHUZIubCOUK+F6pZkqdzltWin7cGohy/jjllC/0z0IPMhTILqvGAjJt
         OIXZLngof35VSnPMX4512bub6lblqCdVllk/UXNJOp3LmFDicGojqHDcrtn1MQbCdHLA
         mxdG/F56WMhX15nloIyhcqAOtuvvic+4vPyg/IwTIDLHN7NVsqGUnAb2AJzQOZfW+rtk
         eqTwetAB8hByRjOYTxUPxLf4HVZV5E5n96NGoc714BQkRQbyXBMDlJmARkERwU+AfbPi
         2OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281701; x=1729886501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFFd8ZiZqQP0xoSa5AwcGy3ur/TerrfcqWoBAh/ynbQ=;
        b=xNrSLZnY2EeJrRQGhnnHTRWcqWqBTs8yPAefZCdQ2cc8QK69yrSTs+BkTqzEJkdXL/
         Z+oT+g6f+LuFpIHYo8qvGFxgWG4Ex1bx5dcYnWEenRkyfuOMQFZq7j8J6qSNcXp/K7pY
         cvIPIjZAm6mVBi4X8xvXOtJ+E+VMr4NVFiutsFZOFEXyDquljeo1sKk2u1Tj8qvtt85T
         5KotY9VLYVTPs2ACu5VxY51/nmJGJ+1h4nVpDksWeOOTRD5fh7H8HcVkStJUFg5jT2uS
         WeJ1JXIcnuYGrIseLYNbv55QeXku0Z8VnJSfnQhj+7E6tbwIBmdlGVKIPFH13qPsdyld
         Xm/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLJuQJAh1AqW91fc4gU9+MxT8aoI6nYZO/roXpryuHvrgAi5KtChScOZOh7otZGyp7BXhhRH3r/ZPqbJ5E@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGt9nkjCMq+Eupf2Zl6wQmhYXVhN6KYa6H4nyRIM7+fFS1HpW
	kF5acPsyWgeRLliXZ0TJd7GgPek/hPRe+xitCZHZUT/MafC8+uPhz5ko90AZchk=
X-Google-Smtp-Source: AGHT+IHKgxg6JXUxcUdo1NNTaS0ZjwlskSsuzQuz5++V3N6G0Uff6gE/ckMGncqCUN4ug0ExIe0ARg==
X-Received: by 2002:a05:6358:7e89:b0:1b5:f81c:875f with SMTP id e5c5f4694b2df-1c39de6d316mr275541255d.5.1729281701614;
        Fri, 18 Oct 2024 13:01:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae97199esm10395151cf.39.2024.10.18.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:01:40 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:01:39 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, willy@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH 11/13] mm/writeback: add folio_mark_dirty_lock()
Message-ID: <20241018200139.GB2473677@perftesting>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
 <20241002165253.3872513-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002165253.3872513-12-joannelkoong@gmail.com>

On Wed, Oct 02, 2024 at 09:52:51AM -0700, Joanne Koong wrote:
> Add a new convenience helper folio_mark_dirty_lock() that grabs the
> folio lock before calling folio_mark_dirty().
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/mm.h  |  1 +
>  mm/page-writeback.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecf63d2b0582..446d7096c48f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2539,6 +2539,7 @@ struct kvec;
>  struct page *get_dump_page(unsigned long addr);
>  
>  bool folio_mark_dirty(struct folio *folio);
> +bool folio_mark_dirty_lock(struct folio *folio);
>  bool set_page_dirty(struct page *page);
>  int set_page_dirty_lock(struct page *page);
>  
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index fcd4c1439cb9..9b1c95dd219c 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2913,6 +2913,18 @@ bool folio_mark_dirty(struct folio *folio)
>  }
>  EXPORT_SYMBOL(folio_mark_dirty);
>  

I think you should include the comment description from set_page_dirty_lock() as
well here, generally good to keep documentation consistent.  Thanks,

Josef

