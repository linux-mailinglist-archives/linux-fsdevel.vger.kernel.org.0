Return-Path: <linux-fsdevel+bounces-28578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A196C2CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8959E1C246BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0E1DB94D;
	Wed,  4 Sep 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wq9GkgRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449EC1DFE06
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464853; cv=none; b=GwCKbuRc91mIHunqpmEq006YwIQ8vI+hbcDNL+UTxanHe2ZSKWYoD/b8MptggU15bRMkl8nKfUkjJKG6DiA9XZXOoJR4Lqlz5tO1OlafJhAURxkgxxhYeV0Uq8HLNL0/oe5qgRAhSvM+25B75X74plA/I7mjUXyuVb3F7IRUW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464853; c=relaxed/simple;
	bh=UjzmLjJOXba+O58W6lN7ropuPpnphTrksm8F5eOJ0Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeXOoxnByB96UaFhKtiZFld1xT5VIfU2xesP+dNIrEimjkzpXBEdXyusWCT6tUhH5ZllQ1hTTE0+BpsPKoEW7zs+Z3t95VcGbOsq/2JMdTYIUgl1vjBDObbITutKJHZjsJQsRete8v/4L6H+cqjGsnFmsji1QvjH09n3HYw6T2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wq9GkgRo; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39fd6a9acb6so2799365ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725464849; x=1726069649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ETPY7jrk9cXk6ajatBVkKE4D/1sJXnbxZJ6VDDYMzE=;
        b=Wq9GkgRo2Nt4Be8wTtLolA5/4vf0/qj6TFb1Tg0kAmvtYxt/GDj/7Anh2xCfVb9ioE
         nsCraapgDg9ZAyDJtejj3p/IgGPd/D59u8ONRa1tRsL6R9KtZxGn79P3/trkLLIUuSm6
         fbO9Zs6C3HJNF94W9BPaE5KglKV6nAHgElTARoT9r6ImJH77y1QgR6cWbG2nXpRkLZvc
         QNOVj9gGkpKZnHBR2ttszva1PpMmCGfXNQgq4Ds+SytNiLXKwHILTBM+4GUW0Lx8jaQu
         g6/qAZB69cL5vAbOtvwS4Kvnywpw80cRfPZaORb6sOmhRIo4GkTC68Cgxv7eClaX7gI8
         PkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464849; x=1726069649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ETPY7jrk9cXk6ajatBVkKE4D/1sJXnbxZJ6VDDYMzE=;
        b=kiy+MO5xOJrNawny6EtCuGsgAC5DmScn1zVyeqSUytDcYWRD5pswRSYyQhM7IMLrZT
         gQIhVaWFJ4+tFfuONZNdlyAglU5Cn8VmZ6ANJfIuZKcoaTJDIELVdCKNCcbRTVahKcIA
         3MksiUjvBfkZehz8qirip9Fm+B9zZyfuFIfHDAKL1/ifhC5x25q0FPf+SzyR7KoyAAvQ
         YEl0+CZ5DmCi3BORVjReDOQSCVs/qHbTX3BjRAIm1zwPx7uGb7fsRpAKKzGbphEAOd9D
         DCznZKmtgy9FxkQ1Wk58mrkqSZyeKxV8NvhyF8/X1YElR/dRjRrOAUSdnpsSNIjQ71Vz
         eFFg==
X-Gm-Message-State: AOJu0YzDUFPdyWfc966PzSaQQZUG8CqmKXTLDf6Q7LOl4/ZTbQGDiePG
	Wf9e9ODLf+0QmnS//bp20P4jLiMZ1wRz6dMyeAQ9D09mAgaytTNrfgH3C1Hft6E1Va4NIyEU/qN
	9
X-Google-Smtp-Source: AGHT+IHbYB4lJjyZpltc3TEqU0myz9wnmGrDfl3Ig6UpxPNUOY157KOqWvwnYUJVbEeyOK1b7msNMg==
X-Received: by 2002:a05:6e02:58f:b0:3a0:463d:ce1e with SMTP id e9e14a558f8ab-3a0463dcfb1mr1389545ab.12.1725464849332;
        Wed, 04 Sep 2024 08:47:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f4f5e2603sm27166715ab.66.2024.09.04.08.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 08:47:28 -0700 (PDT)
Message-ID: <9a0e31ff-06ad-4065-8218-84b9206fc8a5@kernel.dk>
Date: Wed, 4 Sep 2024 09:47:28 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 17/17] fuse: {uring} Pin the user buffer
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, bernd@fastmail.fm
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Amir Goldstein <amir73il@gmail.com>
References: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-0-9207f7391444@ddn.com>
 <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-17-9207f7391444@ddn.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-17-9207f7391444@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/24 7:37 AM, Bernd Schubert wrote:
> This is to allow copying into the buffer from the application
> without the need to copy in ring context (and with that,
> the need that the ring task is active in kernel space).
> 
> Also absolutely needed for now to avoid this teardown issue

I'm fine using these helpers, but they are absolutely not needed to
avoid that teardown issue - well they may help because it's already
mapped, but it's really the fault of your handler from attempting to map
in user pages from when it's teardown/fallback task_work. If invoked and
the ring is dying or not in the right task (as per the patch from
Pavel), then just cleanup and return -ECANCELED.

> +/*
> + * Copy from memmap.c, should be exported
> + */
> +static void io_pages_free(struct page ***pages, int npages)
> +{
> +	struct page **page_array = *pages;
> +
> +	if (!page_array)
> +		return;
> +
> +	unpin_user_pages(page_array, npages);
> +	kvfree(page_array);
> +	*pages = NULL;
> +}

I noticed this and the mapping helper being copied before seeing the
comments - just export them from memmap.c and use those rather than
copying in the code. Add that as a prep patch.

> @@ -417,6 +437,7 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
>  		goto seterr;
>  	}
>  
> +	/* FIXME copied from dev.c, check what 512 means  */
>  	if (oh->error <= -512 || oh->error > 0) {
>  		err = -EINVAL;
>  		goto seterr;

-512 is -ERESTARTSYS

-- 
Jens Axboe


