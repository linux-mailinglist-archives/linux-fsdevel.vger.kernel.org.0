Return-Path: <linux-fsdevel+bounces-14759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7EC87EF39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D61B1F2104C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7FA55E60;
	Mon, 18 Mar 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0JXT5jY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BC55C18
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784377; cv=none; b=Hg1ihkGzaEyouSZyEYNpQ00lW3bidH1AUbuCd0AQMsRNqzHirJgFTi/30xVvlTybjjt+I2pn7b3iBfGuMolGDzIgVTBcCuwcQZRrNwNaNGV8Rgca5hsqnzVCZ0w6XI3U5FYtfAXR0ywbX4gnbkyXoHJb+Oj51AKN/feBSPZ6bCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784377; c=relaxed/simple;
	bh=fS/Il+cK3HtI9bAeGxWw+BBtB0/QjJLvVKLFtR8tR+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxmjhSuev71mQNjcpLJWXM/Oe+ub21bhMsEXqK0SAaQu4Bg1NLCezpX8GuVDLwWtQkqa2WvJOBGwsOzV4z6n+kcu6mQRopad3emKA1MW84N2XRuqll+a323GEnIin1CdHtXWOz9w4bph+MwBPRDrZ2n8qcwrWRMZQpHoikE4tIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0JXT5jY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710784375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rAbeI/yN1CujlA/Yp2t7bafFqLrYgHBFMsaR1Wk9Jl0=;
	b=h0JXT5jYoWqk9OTwKNsk/w3d1hz//qfFPzOMc4GXj7c59lT90JJ9KdACDvnc9jGPTtcQHg
	8OvEPxyPxjKABx6uYs/YYkRq3hv1sGAkZ9IRQthQRB6ubGqlU/sOnk7WQbGJylChBTXdba
	3oPmGeoIW/EkBjfjVgQBVpShYIEcH2Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-23HSgxRMN_yRraD_fHQhag-1; Mon, 18 Mar 2024 13:52:51 -0400
X-MC-Unique: 23HSgxRMN_yRraD_fHQhag-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140408c7faso16337935e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 10:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710784370; x=1711389170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAbeI/yN1CujlA/Yp2t7bafFqLrYgHBFMsaR1Wk9Jl0=;
        b=sFKx4B4LxfXo+SU4f7ZlImRDz1BS+Kxk4SssCogq5JDprE5UGZulBpJHK+g0raUXwM
         a0bXxaRRbrqh25qY4BJV0UMAnBTAdZiyMwhUhNE6nBg+zLw/MCFlVb4WYLPJL0aO5LYK
         ASs7k5oW+2zQIfi2XSF4Wq/ryLs7mesCWY66DerbAJBrtUvd6Q3fbdZ6PZwT9FlFt3Vj
         QiotsnmL+KBVP7RK/KjqA2xtbJDpVch38E7YX/PxEsu8h7ojv7GfKlrxCGF3U5lLxSYT
         0PTNYmLUYd/tEaODTc/mk8l3iCcaE/UwBgMHIFZ7ozXfOlaUHMNMXaBCJ8WXKy4NtKb9
         d1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmOWq73bDRzOeh4JjjHTXiGaEKGGhY62KnXl3sCMjvDocu2eyDXwSizW/MwyG1itC2OqT5RjQ0fcd3hYAb/3YhM712+ZYi16itVyPgEg==
X-Gm-Message-State: AOJu0YwAivACXwWdS9NHAC4ubrqg8NfS4GYCj6zonHg6VHo7ke+wUXi3
	S2YFz7Hm66jCLRPMAJ9JnG+Pmg9BqodDjKebFPZEEZxk2+V2qR2EmEoEc7SF/uhO3ecbjSJpHUi
	dYGlmirD7p7pN3hprCYCDRxu2GwoggSPkvXtR1oNvViUq9OIohWjfuoVvIirHew==
X-Received: by 2002:adf:fdcc:0:b0:33e:c3ca:e9ff with SMTP id i12-20020adffdcc000000b0033ec3cae9ffmr8924110wrs.61.1710784369800;
        Mon, 18 Mar 2024 10:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy65n4nPmyObvMmHt58bqd/Rqxh6Qm3q5Bx3DsIXra1l+xAjekqM6JmSqoP5kkpnEFHwCAqA==
X-Received: by 2002:adf:fdcc:0:b0:33e:c3ca:e9ff with SMTP id i12-20020adffdcc000000b0033ec3cae9ffmr8924098wrs.61.1710784369301;
        Mon, 18 Mar 2024 10:52:49 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id bs26-20020a056000071a00b0034185c5ffbcsm77268wrb.117.2024.03.18.10.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:52:48 -0700 (PDT)
Date: Mon, 18 Mar 2024 18:52:48 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 36/40] xfs: don't store trailing zeroes of merkle tree
 blocks
Message-ID: <vo4rc3vopl4u77u2bmva3onln2ssmixuvq3gsdffltdr6a6nuj@mppvl5hbmvd3>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246485.2684506.6805355726574585050.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171069246485.2684506.6805355726574585050.stgit@frogsfrogsfrogs>

On 2024-03-17 09:32:47, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> As a minor space optimization, don't store trailing zeroes of merkle
> tree blocks to reduce space consumption and copying overhead.  This
> really only affects the rightmost blocks at each level of the tree.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

> ---
>  fs/xfs/xfs_verity.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> 
> diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> index 32891ae42c47..abd95bc1ba6e 100644
> --- a/fs/xfs/xfs_verity.c
> +++ b/fs/xfs/xfs_verity.c
> @@ -622,11 +622,6 @@ xfs_verity_read_merkle(
>  	if (error)
>  		goto out_new_mk;
>  
> -	if (!args.valuelen) {
> -		error = -ENODATA;
> -		goto out_new_mk;
> -	}
> -
>  	mk = xfs_verity_cache_store(ip, key, new_mk);
>  	if (mk != new_mk) {
>  		/*
> @@ -681,6 +676,12 @@ xfs_verity_write_merkle(
>  		.value			= (void *)buf,
>  		.valuelen		= size,
>  	};
> +	const char			*p = buf + size - 1;
> +
> +	/* Don't store trailing zeroes. */
> +	while (p >= (const char *)buf && *p == 0)
> +		p--;
> +	args.valuelen = p - (const char *)buf + 1;
>  
>  	xfs_verity_merkle_key_to_disk(&name, pos);
>  	return xfs_attr_set(&args);
> 

-- 
- Andrey


