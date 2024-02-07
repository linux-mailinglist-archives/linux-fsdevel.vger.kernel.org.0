Return-Path: <linux-fsdevel+bounces-10602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE4584CA9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 13:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAE6287305
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABEF5A11D;
	Wed,  7 Feb 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CD5Y07JU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4A5A10B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308401; cv=none; b=mYZ1ygNeNF5kiak+o0K8wIP9NqOYe2R9C4Qi0Qhk2NLHgWO35ECGks8bYzcqBmyiGQtWi+ZkuD145ZLcO5Ith2F5u40Ys+YKYb62GrtP+0EB3lUiGgxrK2OsValZa2ux1MB8Iu1kqxC7ilv3hDyLrNwdWT3tZGGm8Efi+aAk+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308401; c=relaxed/simple;
	bh=VxHyCQHmmWVFgH5PeO7vMYEFUMu8X9qb6MlTex58/bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfXgOGchNcorK/YKe+1aAx3BRxji9f+D+z+/r53LNGOsFL8juDQIwLQGkOUn32JAM6FCsndambguKg+kY+mNliosjvldnLRD89k0EiXwIQ3BjYj+WN8wP0JDIZ5CUiFPn+GOwDw0f95zXNqvKEWjMqq+X96mXKVAmWsN8Hxed3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CD5Y07JU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a388c5542e9so50144066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707308398; x=1707913198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zDDMQO/u1F7IHrBB5QtsezbFNTZVMkbylHAKSxKrCA=;
        b=CD5Y07JUcCPJJb+yz034svMye1nvUSLCv1D3WcQfJK1w18eZG9lELCoZS7Pe6iDwRm
         UG4U2Qn6Z/MJEWjuTZNZuCXl4j8FwjRd2YIkbJc/zqGpRw6gTPA447/taFrrpGRY3cRW
         QcFpAYAmz81hO3NyDvQTqPUVfQOqCne2pYUNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707308398; x=1707913198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zDDMQO/u1F7IHrBB5QtsezbFNTZVMkbylHAKSxKrCA=;
        b=DewwbYoeYgdStWrYBKcDO3FX84XuMmn6fzbIStmacZnyIgGgmO5hJDmtLkgN0E6UXv
         K9Q5G6po9o3rD0nmVbw4XOt8NYLPa4n7Jd7XLEGK2+Di4qkZMf8reguGM9Uy7C8ZdVuH
         IobBuBPPZo2ausyRyw+puAKOOUWeWZT56HCpbrZR55xnPENNATrU52+04YdfqwoergRb
         D4XIH4uF5e618POZRgfUh4DIx9egiPxzvI3jriyINqSRQz2P68yqJI73KN+wV9cLrrme
         dJyJtj35rvp6lIuScY4Ns/OrIuHxtGA9x9OGuen+ujCxRIA4E7S+FRjy9wrrLW4PMBFs
         WDaw==
X-Forwarded-Encrypted: i=1; AJvYcCV7i28xqzkXNtQcwCZvjPX8oZ5T68KWo4WgS/ITMVHKbtxBVcn9WxYd23B3Y9x54y1ITBzmhO2vfpEiLrl2VNnoXd8Ge6unV7jVTdxuaA==
X-Gm-Message-State: AOJu0YzBlgdw4+Ys5BCeR2RLtltTAv/HJHSuRza2OUBlIvSzI2d3AmlS
	mlSgv4i2/dIbSCOpVHwtNh9WQgQNCqt4XmLXb1SgfT8H/TXJ2rfweORHMv5wf6bfy1RxpmkQunw
	+L0h1UR2PyKFj1RB9b2HGIl1jUFKo6/ZKzrArxQ==
X-Google-Smtp-Source: AGHT+IHzKQ0RYqAT/GDn4Hmr1R2HRVZELwU6NMz1FXiolA++wwYj9diX44wqd6JLXXbOK1o7LQA9USbuPopflB4CpWI=
X-Received: by 2002:a17:907:7703:b0:a38:5b3c:7c9b with SMTP id
 kw3-20020a170907770300b00a385b3c7c9bmr2616933ejc.18.1707308397758; Wed, 07
 Feb 2024 04:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <20240207110041.fwypjtzsgrcdhalv@quack3> <CAJfpegvkP5dic7CXB=ZtwTF4ZhRth1xyUY36svoM9c1pcx=f+A@mail.gmail.com>
 <ZcNw-ek8s3AHxxCB@casper.infradead.org>
In-Reply-To: <ZcNw-ek8s3AHxxCB@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Feb 2024 13:19:46 +0100
Message-ID: <CAJfpegssQ73Wv2w0F6oHm7yhUP3Q2n2vmqAPWw2E72Xa2MMSSw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] tracing the source of errors
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 13:00, Matthew Wilcox <willy@infradead.org> wrote:

> To be perfectly clear, you're suggesting two things.
>
> Option (a) change "all" code like this:
> -       ret = -EINVAL;
> +       ret = -ERR(EINVAL);
>
> where ERR would do some magic with __func__ and __LINE__.
>
> Option (b)
>
> -#define EINVAL         22
> +#define E_INVAL        22
> +#define EINVAL         ERR(E_INVAL)
>
> and then change all code that does something like:
>
>         if (err == -EINVAL)
> to
>         if (err == -E_INVAL)
>
> Or have I misunderstood?

Something like that, yes.

Thanks,
Miklos

