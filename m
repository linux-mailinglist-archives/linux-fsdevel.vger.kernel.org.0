Return-Path: <linux-fsdevel+bounces-28331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ADD9697D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1480B2565B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586319F414;
	Tue,  3 Sep 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVg3XG9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431519F407;
	Tue,  3 Sep 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353462; cv=none; b=CaKLFxbYM8wa9DCXc3RJmwNGCeZzanJzDFRgrVhmqYFFF67vxiwpryWcL/4IwDWshJTooO4OBNM/cEMWX6SjDWO6MCWgo5y6+6zFCw4BR4hXDD36dDy6GzSmJgtmMD4hPwoeM6wD4AKQFYb8vTd8F7K9xp26VNwBfLAnf1EzfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353462; c=relaxed/simple;
	bh=5T93OmOW6XAozlR+lnXNg9ncGTbLriUTGFcNAKu7E9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ju1dvRFS6QNJXezxDky9Fvrr6tRNa5F1W42Yje5ZuCCG8V+CkvRfLwEcJiDCeAU2k3luzMwYIKk5dj1Xops/KJ7cqn8k/K9PHyN3uu559uhmtXkVHTOiYOhognNnQg0tky78bIdINdgJN4wbeTOw7YslHBHt0rnU8p+3cj+c/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVg3XG9m; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53343652ec0so392773e87.2;
        Tue, 03 Sep 2024 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725353459; x=1725958259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVlvyt6BFQoRacvXrglL9Jau+QFUUZlrFsU3ZgitFTU=;
        b=cVg3XG9mf5HlsFZ4I2NKwpXnOljRDskPi883sNsEwBdb8QU+7xgjkN0Wbtx0KPIxua
         hnkI5ODNRXzYoM9xYQF8nknOMrT+VIDmKJrc3ra22RHFcMnVbQavKKOAjqeRx5qWpmcO
         vZe289v/E3Jq6yAsHNIqDC2KeRgnb1GRmCuTGTCThUrcv+4beHr7iYaIgpN67AmK+NqA
         6gb3ivfPqVejhvBY5bMungKxg0x5hhU8XRRRaahPs9aifD2atFLk6RVtWjsfFAZAxne9
         0DWiqpWXUQt1eAXD15stLCEfGmULUkCzJCmiBTl/fwcTWnYPncOIngnbNjcxN+NBI/FE
         eMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353459; x=1725958259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVlvyt6BFQoRacvXrglL9Jau+QFUUZlrFsU3ZgitFTU=;
        b=Jns6LnqBVjDVq3i3PX5FnimwL71q1QwceupI3JuIRYdyCUenbm6VIkEn872qdDkvNz
         WgRhgiAvb8mkuBv4QDBVHBYw/ZZfrh8+q5SPMwLGUM9yC7XsZzzKFVfaL29ON2U3MkmS
         XeS5SbvKz6XHHz2a+pK6RSOj4MweJr6cPUVaPfOf4CfFoGAzsB2e9ixTWIJARVUsxD8J
         KFUZjEFJI6Vb9d5JAO/f1Nvy/DQxoDQteXM03TvTgW/tEs2/hkSjpHsgNLhmKSkTVpH8
         nRCjHSlneE/d+N65ryilklglTBnViPYK42O54thiv8ZsrwEGfjWlfnFc0khfEGrtB59F
         bJXg==
X-Forwarded-Encrypted: i=1; AJvYcCUDlSKWAV2KKP9Zhl+8GC29jgBOFYOJ4wTwCga8/wHY/K1UfOPTIKjP7uigXybMh1Rj04LCBZ4pGwiXZJ78Yw==@vger.kernel.org, AJvYcCWPAvSYEwqw4H+9oOx2h1BeAzlG6WLKHsqUmexvTDwnzGFDqDUkqJ7Gn4L4KGLktjlnoP2ilpHKv7fU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0c0vcBoxKGTY+z4VSdKm2ejK+B/dlsghIHCZhh4I/EzezVmV
	yPcX2rVwv8z8PDeNjsUBWoQl/VIg9uS3ohfW2vGgsE14a1f3AX7o1/aoQ6FEr5R/x8WHSIDHaZ3
	+YdcM3ttgqlY4oItbT7tri7cKXOM=
X-Google-Smtp-Source: AGHT+IFjt4tsY7sJ3tOTx8HvcE5a6xuQdW1RCnZd+Y2hSgKvHKFkS6mqjyUcS5RyIJ0uNZXEG6061dySrJs8Ffw72UU=
X-Received: by 2002:a05:6512:131f:b0:530:b78c:445c with SMTP id
 2adb3069b0e04-53546ba3693mr3568331e87.8.1725353458060; Tue, 03 Sep 2024
 01:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com> <20240903022902.GP9627@mit.edu>
In-Reply-To: <20240903022902.GP9627@mit.edu>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 3 Sep 2024 16:50:46 +0800
Message-ID: <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:29=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Fri, Aug 23, 2024 at 04:22:37PM +0800, zhaoyang.huang wrote:
> >
> > +#ifndef CONFIG_CMA
> >       bh =3D sb_getblk(inode->i_sb, map.m_pblk);
> > +#else
> > +     bh =3D sb_getblk_gfp(inode->i_sb, map.m_pblk, 0);
> > +#endif
>
> So all of these patches to try to work around your issue with CMA are
> a bit ugly.  But passing in a GFP mask of zero is definitely not the
> right way to go about thing, since there might be certain GFP masks
> that are required by a particular block device.  What I think you are
> trying to do is to avoid setting the __GFP_MOVEABLE flag.  So in that
> case, in the CMA path something like this is what you want:
>
>         bh =3D getblk_unmoveable(sb->s_bdev, map.m_pblk, sb->s_blocksize)=
;
>
> I'd also sugest only trying to use this is the file system has
> journaling enabled.  If the file system is an ext2 file system without
> a journal, there's no reason avoid using the CMA region
agree.
> assume the reason why the buffer cache is trying to use the moveable
> flag is because the amount of non-CMA memory might be a precious
> resource in some systems.
I don't think so. All migrate type page blocks possess the same
position as each other as they could fallback to all migrate types
when current fails. I guess the purpose could be to enlarge the scope
of available memory as __GFP_MOVEABLE has the capability of recruiting
CMA.
>
>                                 - Ted

