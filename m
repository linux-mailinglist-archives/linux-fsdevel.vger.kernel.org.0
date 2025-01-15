Return-Path: <linux-fsdevel+bounces-39329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C456A12C53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679F6165C05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F591D8E10;
	Wed, 15 Jan 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="siiJZmgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA801D63EF
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972009; cv=none; b=APdinlJvoT3B/Nqpn4lYqVclA9DKp09EkJnXMAkuxaDX80uOinSgIGQ9OFLXGL9vGf57PAQlY1TCmm/sVGoxOYSDFn6JyeOBEhQhiAVEiEx1VHBiMDWNnQLdz53P8cIBt7Shitu+Atz29I9fegb3I2ob6nxLTRIJGBOCtXG5/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972009; c=relaxed/simple;
	bh=obL59OqvVsLb3h0JUfcLhYG6T3UZLnSVbdV4KF6DQRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laAROzX6z31zgh8VLa3qZd0xIPUOkVLM6yBO/AgG3vyBacqm0BuFqilsMYb670x4E3ViJlxUia/mrGA1vc14loIghFl2zivBKQCU0yYE3K4ojjZxtDsPFS0ActAs30G0URQ2dXEjc1y+XX8Yx52PKODDEku51Ymr8xh3kbSZctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=siiJZmgn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso1320895ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736972007; x=1737576807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10HfpUL4vbzTE8z3sE1cNiKFmGmMremYjdqrg8+vicQ=;
        b=siiJZmgnXJHaDwrPsMMx8d9Sz7R1T6/gguYOvfG/LdtmewBKeskJR+LWjcVKRevxRj
         wAYDMkU586Y0YfZWrQ7SACMY7U+1p2LhU/I30B9z7gZRAQo0upZut97RIVJcB/et9cN/
         O422VsIAd4G/0FpgtvvaKye6zN8URPYylIVv23XLMKob/vJPngw6qCMkWBsvFIIAtXH9
         9b2rLUp+MamX1I0XxczlDi70CC8UGS1CaKTz3SnPg+ulmCEpQTlbwVrcjierU5ycptkT
         StOVtAiGSzdX0LZSSmqG/2hbUF751bu5oLKhg353h3M1W/kSyHRsMgRYzdK+u/Cs1jLV
         7k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972007; x=1737576807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10HfpUL4vbzTE8z3sE1cNiKFmGmMremYjdqrg8+vicQ=;
        b=SNXhi7/VV9yJsdor+GgnaXrpnM8ghMUekD2sSY6XEFST5Jic5zl7yN8Net740l0yOM
         +mxi8oLMigR7jhg01+Zu/AJSSW8EveXfqvD9ws8aSxo4shJYJJB/e4CqzWDrd1SuK3Gm
         ybuZnWSGAZB408btlBBkGDdDProXFKcQtQ5jyOyN6QybHOV149paz0acc6IAYEel5uhb
         L+Ac05/VnFB77keklsScX7Yuotaq+V+VfFhLdG93fDlL5elYCYcWabonYKUvmnYl+utM
         htVjGJxUpQd3bJDQgFFqts4YPflgUroM0cqGhscVTTOa73Yz4hHLlGx7tmf8qoOibJCU
         Oo5A==
X-Forwarded-Encrypted: i=1; AJvYcCWNuBt3tVoFgO1uVQXmADRZ6AC3c8D8VW4G2L6c83ePHp9InSdgtc+lj4l5LBTUyanE5vYH/iR/NN18kZj+@vger.kernel.org
X-Gm-Message-State: AOJu0YyKeyqq6UGj/DLBzPWl8laWR47jKDIwwjJZwh1+XM7q4rMbsGcM
	8yTjUQ571FVGBAVGCEOn3tiym7/+w6Uhgv5tX99KKVzTdk+ZIK/LI8DaQ0Xbn0Y=
X-Gm-Gg: ASbGncshn0lxuUPab58HsDRIw9BP1mziOv2TiE03lBVk2S+H9KmPiOuNgowZUPhPPpi
	+Vwq3RG0a9jbVSDYNTgp7f5eKJ6c19TaLjEa5AQtfiaCkkDlKKykU7SsrLQLYFuseN0LN2tPzai
	VYw6SG6keR07mP9cEu1pscWOoJftLNiQpWw9PkdWk131LgtdjlHI9LdXbrFlhK/H3mJ1TUKzcUA
	Z43pfnfNPsAfJNht8TLj/ZFnqQ8rnOoE6irUZ19Hcd5KNeHlqpeWOJnUxfZmNuUGDiw/YyhKR6X
	f8zwcORByUZU4Z7yNpdiadeg+bJJSF0z
X-Google-Smtp-Source: AGHT+IHnPTYH1M0KygFma+wZwcgjOIPDIchY7x9E9r6aOBRHS7OOYUKAFanmi2DmZuTGwBHC8Eg84w==
X-Received: by 2002:a17:903:32ce:b0:215:b8c6:338a with SMTP id d9443c01a7336-21a83f338a5mr470115445ad.4.1736972006983;
        Wed, 15 Jan 2025 12:13:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219f0dsm86031465ad.139.2025.01.15.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:13:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tY9lT-00000006JFt-3Jp5;
	Thu, 16 Jan 2025 07:13:23 +1100
Date: Thu, 16 Jan 2025 07:13:23 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 6/8] dcache: use lockref_init for d_lockref
Message-ID: <Z4gW4wFx__n6fu0e@dread.disaster.area>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115094702.504610-7-hch@lst.de>

On Wed, Jan 15, 2025 at 10:46:42AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dcache.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b4d5e9e1e43d..1a01d7a6a7a9 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  	/* Make sure we always see the terminating NUL character */
>  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
>  
> -	dentry->d_lockref.count = 1;
>  	dentry->d_flags = 0;
> -	spin_lock_init(&dentry->d_lock);

Looks wrong -  dentry->d_lock is not part of dentry->d_lockref...

-Dave.

> +	lockref_init(&dentry->d_lockref, 1);
>  	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
>  	dentry->d_inode = NULL;
>  	dentry->d_parent = dentry;
> -- 
> 2.45.2
> 
> 
> 

-- 
Dave Chinner
david@fromorbit.com

