Return-Path: <linux-fsdevel+bounces-61208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C411B5610B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 15:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911151B259B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523FC2ED84B;
	Sat, 13 Sep 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ16S2Tz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7A1F09AD
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757769074; cv=none; b=mCrYVZZQybLZ9+2imHZX/lBxPFFH1D1yeMAwqwu26CBe4SOa3PgpzDw4KlETXO5kfbyDnJeHWUngX+7b1Q9vq/TyzueM6xWuIpUnu9UAIfPN7q5f0lEzh3G/jM6/8wnnlXTU2PPabro//h3r8H4enHIqnAkmc8a1vZAANOpPVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757769074; c=relaxed/simple;
	bh=oKJpDAv/IgzpjfgwUgdYGRiJ0C5lJdTjcz+qAOTK/kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/VSB2fTYurb5kZjQv0onjA9AEDm455Q43bp25SueK+icHK56Q1vkdHU4RnGLZbnjmMja6xgPx1YNtYtjEvzYqpyppx0i/U0nZscTG+xL8J8DEJ4zTIcdygQqwso5ECuyPoos4T5uGx49f9Up0mOBiekMftkEjr2mbr2/ypFsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ16S2Tz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336a85b8fc5so24121751fa.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757769070; x=1758373870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWxwIgbTiJWjsGEavEfT0kkniKrODy1r+jAuDGwG3dA=;
        b=NZ16S2Tz+d2OYoxBdvbOczEP00GfPVLHQRzFmSrII9ZPWj2BxoKC5HVTMM1AtR8lRb
         frFEEfXhh6dDoLlrGluu/Op4RpDF1WmIa3n7+oqmk5+7iMtVPt7L+t07JncnL8z/9BR2
         z/fk91bvXxOac67AGyPqfdoP6PkGWziKlT38T3Ew9iceUHTypIkr99omj1ZowSiJt1Z0
         vOauwCGtklVDiNKVMXZGkFCAR5uCgqpHA7iAG+rOZyXROXTmpfBs4mhvPNlb6b4yjlkJ
         dD/uND9lgA+LWaWES5eershn8v5bjpwSO4ohXZQr6Ejf80vLMsGemqW4kWTGydWE8VG1
         Ub7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757769070; x=1758373870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWxwIgbTiJWjsGEavEfT0kkniKrODy1r+jAuDGwG3dA=;
        b=AGb5/4RvPYe9R9O42Iil1FD7RvRB54Hb3rLQhROiRYvPyGOnSNamWikb0QJY4Xp4Tq
         E6Hm1IuePPHYi0l3fb4EuCT27GBmueuZcyvwVB+J/u32R8NkLNJZy/c8IFu80xx86I0q
         c038JmTDpq7S7Dtwb1+abx/8dVJ749cS7fD59e4qE3Jkm3nYr+WaZDD1PLZtYIDUUVSs
         BFwzXknkUOBlg7PVrvuo+iwl7dJUft/qxCVjVJbVBEcoKxKiX7wtLkCDt6WvsgFFUvc2
         Za8sCuUtld98Jpng2e625AWj/cnGJF4GFYm/1e6jjcf//dlXz9+gny+WyNkuzI2B1SAU
         ktpw==
X-Forwarded-Encrypted: i=1; AJvYcCXJOv+jSroErev0MMvRoRAi7IxtzGOCnIbpx8AW/RW0j+xqEJwPYkkx/q2i2diJiVCYbfnXp3am8aF0Ib2s@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpiEJzx8esmLRNrL3tCzcNaqw+kM7TQocDpzc2YqHrH7A0pwP
	Zn0UL/hzcaCP3PI9NbWl5ii31JDymH6rdHsZ6mhlGsjP7EVzzYBIIn3H
X-Gm-Gg: ASbGncuhuZfakyqddvD1K7kueM1oexSV/7BCqn3RzoAEVH1byLU76KCSXVoYZwmnKz3
	rFZ390SvtdB1wlS0bMFsxo4vmu7VdCmi0uvjs5d30uKSRRn5vox3QG/mCW2azoqmY1uHD2G+Zeb
	iuz/4xeQ83cIOAKPDqmAnyuSrPtlO53gE75Sbsh/cJqOg7Xo+wdDPre+M6WCivQm83bAQ0+qMuT
	IzmcNa+ZmdGoUoXKvdvk9OSOicRmPr2Ixbvkp+nfGbkr9TZ/9xUbaP91UDwc4jRV33dWR2hNpqB
	1Wcqc02+OuA9sTbAj1YxZL7p+cwZLbjoXVTopAe7M4vKHMGAWKyIMEvEiLeCc3EgNlYnRPGOndy
	7IIEtAjI25EsCzLZu839NLT+0SdtJYkOslADB
X-Google-Smtp-Source: AGHT+IFW3X/biyePEhlGPyL2QecOAnqaoRAKpWNM3rOTQZRDK64Zl3Y9eY7OF5QskdIkE2Rwq3bT2Q==
X-Received: by 2002:a05:6512:404c:b0:55f:5526:602a with SMTP id 2adb3069b0e04-5704ad8326amr2165663e87.15.1757769069492;
        Sat, 13 Sep 2025 06:11:09 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-56e65a34096sm1924029e87.136.2025.09.13.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 06:11:09 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:11:08 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: Remove unnecessary goto label 'successful_load'
Message-ID: <o2ijjlbcicrrfflp54o53sj5v6morqedtkkzizhhyvl6cqvezw@yl7hx3naojcn>
References: <20250913121514.1789204-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913121514.1789204-1-thorsten.blum@linux.dev>

Hi,

On 2025-09-13 14:15:14 +0200, Thorsten Blum wrote:
> The goto label 'successful_load' isn't really necessary. Set 'res = 1'
> immediately and let 'goto done' handle the rest.
> 
> No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  init/do_mounts_rd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index ac021ae6e6fa..97ddcdaba893 100644
> --- a/init/do_mounts_rd.c
> +++ b/init/do_mounts_rd.c
> @@ -210,7 +210,7 @@ int __init rd_load_image(char *from)
>  

>  	if (nblocks == 0) {
>  		if (crd_load(decompressor) == 0)
> -			goto successful_load;
> +			res = 1; /* load successful */
>  		goto done;
>  	}

This is now the only place where res will be set to 1.

>  
> @@ -264,8 +264,6 @@ int __init rd_load_image(char *from)
>  	}
>  	pr_cont("done.\n");
>  

> -successful_load:
> -	res = 1;

This does not seem correct? After this patch res is not updated to 1 anymore
if execution reaches here without taking another goto, i.e. the return
value is changed by this patch.

Regards,
Klara Modin

>  done:
>  	fput(in_file);
>  noclose_input:
> -- 
> 2.51.0
> 

