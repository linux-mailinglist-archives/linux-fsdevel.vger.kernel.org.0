Return-Path: <linux-fsdevel+bounces-29147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60697976657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921D21C23351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3AF19F135;
	Thu, 12 Sep 2024 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4PPlACM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A919E998
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135576; cv=none; b=GKTeI9YHqUGA3WEYasK60Ajb8C6jqgLCR5qaD/BBR08AR7dQSyU4yC9A4uf39eT+CNMtZT1nEeHuyuRwTS+R0coYMF/lv1ajaiD6xvzuup9fMGmhHbwMVSL/GN/a0f1+6Txt5hBIRrotyHAriXWXZ97nxV03ArOMA1rUdTtf8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135576; c=relaxed/simple;
	bh=zNQtdJ5lwCWCDgDgMTf79bjuaQqupoYjQ0YseckHteQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw8lxgeipmWJn30NeRad5uGcXUwT0Lh004/zqzUxntJLvYPXDlfpG5wkr+PiUBF/54HxJ2R1RjxY7BmTUtO+t6VW9gfzbYv+0Z/LL/4IW/Tb2ear2Nt2c3e3bsB9NvSssnYG74k9/lvQ9vi+OHtncubTYxLmlVlNBgUta9ES8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4PPlACM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso6924925e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726135573; x=1726740373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9f9vw1hY5QrAMqb22ETyD6iQGuby4m6Ga+q6MMaPXKw=;
        b=s4PPlACMwcK1gaNXaeSKezzEtGmfB7QZI6TWYLv1GNI7PRO1DdAkMzin8WOdCeufPi
         hINCgoCzNNPb2FBonX6IdCkeNIvyqGxfsLV1hv5YsfAJHqI8yFE5ofHBRJDXfIXMSY5B
         aoi6d7u3HolF3ECudzAYcqj869YeAopmYU45jhE0Hn+lm3giCDwrN5DXAjF0sDHWgLLx
         EgD7aCb+qYySmWpE5y+7L1V5+MGooRtmuaCscniUiT/lCrk1xbaaRjFPlS6/aP+NCrIX
         huyIRpRMS/C+iB0u38T16gYKGn2eGvSafLo5g6Wsp6GxwxyXOrD1LcQ07z+pVJc/22NF
         5IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135573; x=1726740373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f9vw1hY5QrAMqb22ETyD6iQGuby4m6Ga+q6MMaPXKw=;
        b=ujA8GsoMj2H/OitMxD29MKaV6/uSJuJBxyDRVgU12xGuglcd7vVgBtp82ZuG3+MqNM
         cSC2up59YpdguZPpqBLMRZ5EZAd5/1KQkDRLLrb3bufKLqXYbULPzLQ9/N+LQI1UzvdJ
         g5DZCHl/QbvjKmWAxWrxeW74sSwuvca8uy6QnPfkJ2XkgidoORjdQyuZSsFh7bCaKSRd
         tRZh/XW+zdwqon1PUH4IYuozWE91TKheZ1ObE2LycnYWqmCvZqV4LY7Un7fPEZHY8JPT
         MDCnOIklJVvACxfziKvZB5Mj1HghQ0cifba8ZOL7zCkTLldQukBcBmaYOzZ4AVbhd27D
         PgJw==
X-Forwarded-Encrypted: i=1; AJvYcCVBLhWsnCDSP1vAt/iMx4xDhe8YGSFq7uW/jUed5GxLpmq5YS2w5d5k6c4LoI8xgwzg5VK65PZu/94pmDny@vger.kernel.org
X-Gm-Message-State: AOJu0YxPiqW1eJBWayDhP7KymI0SB9eukWoELMxG+J5Xy+N6wrNoo2KK
	VMKwvcMMuw2KKtcuO2jmDCXHcWsNRBniyKAE6pV0HHLlyODlZQLj4y4CxrbK5x0=
X-Google-Smtp-Source: AGHT+IFIVXMSjXI0WItlEkRGBkE4sVo1mzs3x8iYM6cm17R5bnyS11Apu3o6+MP2BwuX9mdLX1bomg==
X-Received: by 2002:a05:600c:4d06:b0:42c:acb0:ddb6 with SMTP id 5b1f17b1804b1-42cdb531b66mr19362125e9.9.1726135573210;
        Thu, 12 Sep 2024 03:06:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8ada3sm165339195e9.43.2024.09.12.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:06:12 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:06:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [bug report] fs/proc/task_mmu: implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <69e01b95-fcf1-4168-8aa9-708623ec3956@stanley.mountain>
References: <3a4e2a3e-b395-41e6-807d-0e6ad8722c7d@stanley.mountain>
 <b33db5d3-2407-4d25-a516-f0fd8d74a827@collabora.com>
 <d3db84fc-c107-423d-9f02-3cae0217b576@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3db84fc-c107-423d-9f02-3cae0217b576@collabora.com>

On Thu, Sep 12, 2024 at 02:34:54PM +0500, Muhammad Usama Anjum wrote:
> On 9/12/24 11:36 AM, Muhammad Usama Anjum wrote:
> > Hi Dan,
> > 
> > Thank you for reporting.
> I've debugged more and found out that no changes are required as
> access_ok() already deals well with the overflows. I've tested the
> corner cases on x86_64 and there are no issue found.
> 
> I'll add more test cases in the selftest for this ioctl. Please share
> your thoughts if I may have missed something.
> 

I don't understand what you are saying.  We are discussing three issues:

1)  We check the size and then make the size larger:

    check: if (!access_ok((void __user *)(long)arg->start, arg->end - arg->start))
    larger: arg->end = ALIGN(arg->end, PAGE_SIZE);

The ALIGN() can't make ->end go beyond the end of the page so it's possible that
if you have access_ok to the start of the page then you have access to the whole
page.  It just seems ugly to rely on that.  (I don't know mm very well).

2) Passing negative sizes to access_ok().

The access_ok() check will treat negative sizes as very large positive sizes and
it will be rejected.  So far as I can see this is fine.  Plus there is a check
at the start of walk_page_range() which says if (start >= end) return -EINVAL;

3) Integer overflow:
	access_ok((void __user *)(long)arg->vec, arg->vec_len * sizeof(struct page_region))
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This multiplication can overflow so access_ok() checks a smaller size than
intended.  It will absolutely return success when it shouldn't.  To determine
the impact then we have to look at do_pagemap_scan() but I don't know the code
well enough to say if it's harmless or what the impact is.

Integer overflows to access_ok() are always treated as a bug though even if it's
harmless.

regards,
dan carpenter


