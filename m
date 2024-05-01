Return-Path: <linux-fsdevel+bounces-18446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6208B8F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 19:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A68BB22A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B961B7F4;
	Wed,  1 May 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg1VHinU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40E18C22;
	Wed,  1 May 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584531; cv=none; b=Wyonh3asWBf14p1sNrHT90I9BsNEiDmrg79s9BLcq5R1uPeY0CE7/LzMNwWxq31d8dVSEmpWnpNePn0CaBipYC2B2usnDlib8UmgFDRIaqXyvvGJRtXnGzpQ2Xjw2VGRAVeo/Q0aKlj+xEDndDKG5DD7MFV7plLYmFxOkRFogFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584531; c=relaxed/simple;
	bh=+hjBT4f2fglD+v2rS4MciZgOO8UjEC7rc5M9uGPcJwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdQEKFXMps0ZYyzU2EspJMvtkq6oo0izoAHRMx5Rvh2SzkvbqOS5R1dNx+v8tqwzhOTan3pJdLkPy8+f16JO0fZ2mdxYtB3hS7suCr8wRuvbfA7z+xZ/2duH8/6j0qHDnOzMp+3NW10MGiDDiUFzZnziYloJMsZCS+WaN8mzJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg1VHinU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed627829e6so8300543b3a.1;
        Wed, 01 May 2024 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714584530; x=1715189330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z3qwZ2T0f1AcIzMY8k1DdsGurc58CRUSveN9mEOGBw=;
        b=Kg1VHinUK78MX+5aSthlCmKrAggOfU7/U4FxZfFKCgdBUiyNljhsbKy34xCH1ug6tK
         5t2NaCA6qNK1oUVaRvY16BBRErJ3jtoxpjPGtBlO/9RFGYdM6+vUnKaUZyGE1loavbb3
         PXiPDBJ4I6e5mREB7KMG9OC3Iaj6TB64cjOZoqzw4De9vLP/2reak3ascZTsT54UGWUw
         OiGbbUd2nNKUTLxWJb8sNm7YK23ZNCtmhw/OBPggH1lN4lhv3C5T2Tn49sqM2mYvrqEA
         LmdgcoZFtyjieb7/SFTVYG6gaxsdMTAwMAmTBC118Geg3S10pSAAAeyY0pw4061hm3m0
         AnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714584530; x=1715189330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/z3qwZ2T0f1AcIzMY8k1DdsGurc58CRUSveN9mEOGBw=;
        b=A+7oJzrGOWd2zKfBJtANRkbS/2+l3cOBFWsZbbWHVBQ1t38PBDnHgNJ8PYUQy1H2E0
         9/XlApdEovY3XVPOHbtIe2wBw4aQAvcAV91Faowo//EYWDRM+ClKZroEq1CI777fEILY
         BboBWyqrs6E1FqSk7oC4AIEgRkoCVzEti57yGzGbFPmmRFc6HKvtA9lZf2re3yKV7jne
         3djzt7y8phJEucqbptUUi4134minfpJNWN+NkG+z7kHDn5SYD0XbvCooxS7wc1yFbCZo
         6sKTKu6aP/Wjb/Fbkbw5PUVJ9cOm5YsP/m/CzMUHwAQsSbQ3MGzQuE61CNi/jAJbkkZi
         12Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWlnySztmKvEOxFHHL8oGoO77taGv83oTsWTJyEwNZMzjRmCmENbfTjw4HfkEyttK6I7/zbASg2xc3UzrfCHo3jQe9O4wWsriE3WdGByjFSaK6Zg4FsJOh8f1+4zvg4t1MO0obIL+OhY/0Tew==
X-Gm-Message-State: AOJu0YwjxRHT28j3kVPfDlUI86nKbpPPI4bSyfuIJWNVRNG0b9DJygNp
	Wl45D3kbseMRQPR4pVHxfNkbyC3IHdUMLkX+T94QtDk1UT9o/veT
X-Google-Smtp-Source: AGHT+IH+nW1nZbrDkFK5KLEoS5L4brAnP2C/EKD2m8b1DlKQM6YyKuTyZE5zX/wqdIzp611O87FXWw==
X-Received: by 2002:a05:6a00:4655:b0:6ea:dfbf:13d4 with SMTP id kp21-20020a056a00465500b006eadfbf13d4mr3353946pfb.18.1714584528767;
        Wed, 01 May 2024 10:28:48 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id j16-20020a62b610000000b006f423ab373bsm1156887pff.126.2024.05.01.10.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:28:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 07:28:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] writeback: factor out wb_dirty_exceeded to remove
 repeated code
Message-ID: <ZjJ7z0j8T2rTicLD@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-10-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-10-shikemeng@huaweicloud.com>

On Mon, Apr 29, 2024 at 11:47:37AM +0800, Kemeng Shi wrote:
> Factor out wb_dirty_exceeded to remove repeated code
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/page-writeback.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 68ae4c90ce8b..26b638cc58c5 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -140,6 +140,7 @@ struct dirty_throttle_control {
>  
>  	unsigned long		pos_ratio;
>  	bool			freerun;
> +	bool			dirty_exceeded;

Can you try making the function return bool? That or collect dtc setup into
a single function which takes flags to initialize different parts? It can
become pretty error-prone to keep partially storing results in the struct.

Thanks.

-- 
tejun

