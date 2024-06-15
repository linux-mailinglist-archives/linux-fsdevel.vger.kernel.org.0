Return-Path: <linux-fsdevel+bounces-21750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A3C90964F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 08:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B10D1F23304
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 06:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD43D60;
	Sat, 15 Jun 2024 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyTV69L7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4D10979;
	Sat, 15 Jun 2024 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718433108; cv=none; b=OVHkRIzwKOBnvA9wmdQDtr6tZovRIgcP4uMrNbyZD/V6Ikxa9ifreOFJ1AL3OYWP1GgplZlGN6VYAJWelQzDA8Lt9Xp67nubUuLZ1IQnL7/p4SKOH6giuD9BiFokaQ36Ao+cmK3UO4l1Yyd16ULkDluRIQkLm8hR+X+8OoNClAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718433108; c=relaxed/simple;
	bh=wYMCYrJhD9c0luKvwDfwE90zFmR9p18SOwC9lxLZZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNmkKUsJpG+98KJ+uqHl9Vy1r+42Ohft1y82UQzOjEueQ44H7ibuKb8f+vm583zap0QOtuNLE7cvGxQw61c6QtMCl/9Gw7vibIQR1CHpC5gw8oX2bgFB+ZnNFc1KGCoijkDhh81FRmr/zNQATClupW2831KgIV/xGGsKUqIvHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyTV69L7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso23671115e9.1;
        Fri, 14 Jun 2024 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718433105; x=1719037905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dlc07LrL5tm0890LKo5QUPKD2CZc9L1NnPqHcPAZD1o=;
        b=SyTV69L7c1gSOAB9amqS3QHvvTh43tNf4QB5peE1tuufLPM+w+vCGlKglOvaezDZtO
         vdrDpNc4zrBHPeROJInsvkZ3gqZoeNiWD+EWNLId3T9VMouRJoHsi+fhslylO7pX3FiQ
         7b+gFzI0ITky8uaPSFNOIf17osGDFfvcUQjYYi6eDGiHf08eLuVT6FrbwqJ/bi7lhpsZ
         AbKzcw9ljcCudxCqVSJWkc/Xf2rxUYjAKDn8TUHQT3r7vJH7RCF6vCdFvOWQ2+4Wo3DD
         qespwcUAn45kEOquqgRPaReUityu/uSEqs3TrDXqOThJ2LdMtOFa+tXrRXUtPB2+aezc
         i4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718433105; x=1719037905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlc07LrL5tm0890LKo5QUPKD2CZc9L1NnPqHcPAZD1o=;
        b=vQzfEPMxP3BpwObuCsqzD42rSCB0k1lhufAwxyx8KoJ6416t89ea52YedYt6BHEzlW
         S6BcURKLmQ74vCJuuqmCH2W73Ilx0/o1g/o6TlfsqJgBY2t2cVVUiQwf1xVh1ElnqdY0
         AJCeEAJ3R0zmGrEFRiIk49iFihUX+Lix9jHkHEML3WXd86plEam8INRlTm6Cve/R/cmI
         pIlJaNuT7SiGStJLugGl2Fd0WUoPKgh5UPMlAyfgBQJs543y4Y5JrJzl4s0NRw+XVjNQ
         FSuw9fY1GudmeNptyTc8bOhgUhFhPPYnUgguo8FUlBfRa9kZ/WnBqfl1jB5m1YkO8D9i
         WpVA==
X-Forwarded-Encrypted: i=1; AJvYcCX8bvuojK8x/47o/Mrwyd1QgQPG9nGfFP4DYFkc5mMX8jmL2bDGDCvas/Cr/ow/uYRP+2oTwLMJVxQJvDPn26O9Zsr2OOI1JDpyXduU4dJ50vak7w82YrcQpx9RhWzKemECkwnxFPAS6w1oCQ==
X-Gm-Message-State: AOJu0YxJA0SwE8DocPmxEz/E3rLiMIOUE2ehMkvQ1w9G97Km7+FGfum5
	js4/A7ha48ciOxdmuLwiVOGR4zuVz4nhApmyJeOUa8tMV9RM55oP
X-Google-Smtp-Source: AGHT+IG1Ozq8tC1gl/GTHyfSORClzfmmuRTPoawNi7aQ51cG1cp2ZD8y1bGbsNrsEU5K4aos8mWozw==
X-Received: by 2002:a05:600c:4c23:b0:421:756f:b2e8 with SMTP id 5b1f17b1804b1-42304820d66mr48040755e9.11.1718433105084;
        Fri, 14 Jun 2024 23:31:45 -0700 (PDT)
Received: from f (cst-prg-88-61.cust.vodafone.cz. [46.135.88.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a666sm85550745e9.45.2024.06.14.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 23:31:44 -0700 (PDT)
Date: Sat, 15 Jun 2024 08:31:34 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Subject: Re: [PATCH 1/3] fs/file.c: add fast path in alloc_fd()
Message-ID: <egcrzi4bkw7lm2q4wml2y7pptpxos4nf5v3il3jmhptcurhxjj@fxtica52olsj>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-2-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614163416.728752-2-yu.ma@intel.com>

On Fri, Jun 14, 2024 at 12:34:14PM -0400, Yu Ma wrote:
> There is available fd in the lower 64 bits of open_fds bitmap for most cases
> when we look for an available fd slot. Skip 2-levels searching via
> find_next_zero_bit() for this common fast path.
> 
> Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
> free slot is available there, as:
> (1) The fd allocation algorithm would always allocate fd from small to large.
> Lower bits in open_fds bitmap would be used much more frequently than higher
> bits.
> (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
> it would never be shrunk. The search size increases but there are few open fds
> available here.
> (3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
> searching.
> 
> With the fast path added in alloc_fd() through one-time bitmap searching,
> pts/blogbench-1.1.0 read is improved by 20% and write by 10% on Intel ICX 160
> cores configuration with v6.8-rc6.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  fs/file.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 3b683b9101d8..e8d2f9ef7fd1 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -510,8 +510,13 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	if (fd < files->next_fd)
>  		fd = files->next_fd;
>  
> -	if (fd < fdt->max_fds)
> +	if (fd < fdt->max_fds) {
> +		if (~fdt->open_fds[0]) {
> +			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
> +			goto success;
> +		}
>  		fd = find_next_fd(fdt, fd);
> +	}
>  
>  	/*
>  	 * N.B. For clone tasks sharing a files structure, this test
> @@ -531,7 +536,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	 */
>  	if (error)
>  		goto repeat;
> -
> +success:
>  	if (start <= files->next_fd)
>  		files->next_fd = fd + 1;
>  

As indicated in my other e-mail it may be a process can reach a certain
fd number and then lower its rlimit(NOFILE). In that case the max_fds
field can happen to be higher and the above patch will fail to check for
the (fd < end) case.


> -- 
> 2.43.0
> 

