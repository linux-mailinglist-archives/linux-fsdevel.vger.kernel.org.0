Return-Path: <linux-fsdevel+bounces-42024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597FA3ACF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 01:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CBA189085A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCF0C125;
	Wed, 19 Feb 2025 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CSaauxeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5D8F58
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923869; cv=none; b=VuiIQET4AQCzcv3szRoZnyL2lYznEWfOyjqfvYjlnH9624ZrGNQRaieQsNO5IZsYtBHLlx706Wp7PZqNLf2brKb1B/z/U6jNTpLuSvl5YKFcIW6Z2rdHh9qCRh2BjXHeW6D2ZybGWoxTljrGVBmD1X8Trllk2Jq9++Owcx+MprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923869; c=relaxed/simple;
	bh=GKth8OgfzFdg1eI08wTLXySe0/ivwrF4OJZlEoIUS3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2eQgmnQirur4FTntOIAEjtnVMdUHhOvUUeLkIICj8lq4hYKfa/eG8A5yYb1c9ve/XLyl+ehtjiAqTkLCgXiKTRVFusRDJD68TMbdC2j8hHxIZnARZRTiczACr2sZL0vIybOc6BL+XBAnzAO5qGaC0q1lvBF3pX9vnddNdQuZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CSaauxeo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22113560c57so65432925ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 16:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739923866; x=1740528666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wje+37OUw3EOY3E8DdGEm6PdRUyXBW2L3woHBy7T6PU=;
        b=CSaauxeosHvEhvX7OJSF9HR/qn2/ZC5RoSq5l5l69nbJreEo6zEzKaYQE1VeGlM8qO
         BfELA0Ur6tlUHqwaF766krLn+YOUDQ/GlfakF6txn0jRFi1F8p+8c9z0mVf9pruWe6MZ
         UPY9g/M3AB12EvW9Kvyu0zTwN/0miKCvrpWFwcDrW70deVgwZGcFCgbuugjQEheX9hxT
         OFLDofbRAdf3/gQOa3dVwQEzLaki2zusN6lYU5hSVD0NW3cwmKjnvhOEsiQnJxlipmmF
         ZlnXJE08/RCyjRIPQbSvLUsd7B09JYYVXS5qd0JM32xpph4fKoc6yKywmWvabmar+tEU
         2z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739923866; x=1740528666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wje+37OUw3EOY3E8DdGEm6PdRUyXBW2L3woHBy7T6PU=;
        b=I2p0nRA+XiDc29vcbIMPefDCAOFQAE4X/U5qm9/gy/Te86S0h7cPOd/O+bp9rvHqcD
         h+xHkpq0TiNSJzQilq8VWS6jAVyKMnw/m8BjJotm1htBSDiEelsYISp+0VAHjoPHijH1
         37w1XoZO6L4k6FJKu/v5piCRP84+Ry+YKerTtG2OMpAqPKpF85bQwcG54D8UdbLRtWgK
         y5FKr4eYC1ZWA/a0+Zy//0zWU+/h800eJdpQDaLqEwtZHWH6OSdkMctQuTYCOF04ts/2
         UJuOr7m/CgNYLJmEr9RsL0ZrK8F9f8RPdiUGRzZ7KKw9DbX2FndLsLigGe75t+bHnOKa
         YE1w==
X-Forwarded-Encrypted: i=1; AJvYcCX0rHUhj8lkd5hSqQMNjlFjWxJuA4ZwKbbLWd02FbjyO15Q0yKQYu3FpjPs34voEaxMhzrs4hJ7DmlKJQ+g@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTArFv2TMQrfZE3mmSn6Jm1zaW1ySa+YsmVG7usrxXqhxFqST
	BIRwaLfPi/CiM6N3+ahbMitkQgfCsvWWlNyKoeuNth7ZGtCXzv2oNJR9YTb/gQw=
X-Gm-Gg: ASbGncsj+/9ZQb+92v1c+lCMlK4dELQOTwM9CjoF/lCtr56/w+U2PGW/fOlRKpCgc8G
	WpuuU4DHH+O+eBZeE9k98dYb+tSkOGhn45GYJl9QHGRpX0WuAGYCn+08arflV0qkRGZhtgsg0pb
	0s7mkcSDPWqWr9R1KrBqwS+PWrQh1OW/oTMIfXlAVzJ7gEtcN5dXZSRbxL0qiJxgF1METHbiCO1
	0Y8/ZXzeJ9vmQdKMbIr/OBWm+LsRJ3AGmkY2Wlhs2f5ISVIhVlgsA9dXBPyP5TfeXdCE41GwNjY
	Xq3k0pRxAonc1THD7M6+ysr+H5e3+l4JZjcVT8pfUyaT671CAq84PHm4bjdWrTtiRXc=
X-Google-Smtp-Source: AGHT+IGzNw9N6vIVHFFoSDN7U/7f25cr4Ncvov37jFAYdeOGbe9w5NFdAS1CNJKBD1dXb4wW4OuzXQ==
X-Received: by 2002:a05:6a00:3d42:b0:730:8d0c:1066 with SMTP id d2e1a72fcca58-73261911238mr28880688b3a.24.1739923865977;
        Tue, 18 Feb 2025 16:11:05 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73272a28fe5sm5802089b3a.101.2025.02.18.16.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 16:11:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkXg7-0000000314I-00od;
	Wed, 19 Feb 2025 11:11:03 +1100
Date: Wed, 19 Feb 2025 11:11:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	brauner@kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/2] mm/truncate: don't skip dirty page in
 folio_unmap_invalidate()
Message-ID: <Z7UhllvPUxVuYOqf@dread.disaster.area>
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-3-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218120209.88093-3-jefflexu@linux.alibaba.com>

On Tue, Feb 18, 2025 at 08:02:09PM +0800, Jingbo Xu wrote:
> ... otherwise this is a behavior change for the previous callers of
> invalidate_complete_folio2(), e.g. the page invalidation routine.
> 
> Fixes: 4a9e23159fd3 ("mm/truncate: add folio_unmap_invalidate() helper")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  mm/truncate.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index e2e115adfbc5..76d8fcd89bd0 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -548,8 +548,6 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
> -	if (folio_test_dirty(folio))
> -		return 0;

Shouldn't that actually return -EBUSY because the folio could not be
invalidated?

Indeed, further down the function the folio gets locked and the
dirty test is repeated. If it fails there it returns -EBUSY....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

