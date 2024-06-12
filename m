Return-Path: <linux-fsdevel+bounces-21557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE67905AD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 20:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAE11F24304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0640867;
	Wed, 12 Jun 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXSn4v3p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81C31A83;
	Wed, 12 Jun 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216856; cv=none; b=q9eYkv/TwJWD9FYPqHk7dsVuxWgm1XbXH1Nd/B5TppAjORQu0gcESwj0UD41uThK7+QrZQokdj9d/u8kIHaG743nTIbYlH8DIFUE0ZT5eodpzojX5X80k2Er+JFlr7EcSYlyosqUTI71WL7E5fjF7WDfx4QnJzJW4oLUM7K3flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216856; c=relaxed/simple;
	bh=WYLiTDYrtmqxZDYMH2fKtRR5JLxjg/IcLpait4AyIuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqVGkDNhFUXt7dtMgO5t5K3y/TWFsTNCqjN0uvaKdDYt+COrYmuRB0yEgzzRwNTuJeL4rmzZpCEV0b6NsgdXJQzBb3qkY4QxCLdX2dRwj494iQMhxG1sf595HX8eDyotXpYTBLMbDjLHvO4KNcoO8QZBH/CtV6Ud9RsSQUecpvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXSn4v3p; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so323501e87.0;
        Wed, 12 Jun 2024 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718216853; x=1718821653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQSGxEg3iN0gqxDb6TEEcUHjyTvJD6k44q7b9dlYWfg=;
        b=KXSn4v3p90NHcxgoa2l7BWcpf463nlNa1tlrS7r9Vsr3Wa715EGKcRF2e0o8C9vvoF
         bjde44/S+OOstn9XoS72pfQQJElcsniHMCfYrMr3ZyzN1h1Lp+M6CAYOCni8XnUiYfns
         /8AbGHYJS3/W1k0gxZ6wQ+VEh7C3PHPgOOjyxQtvi5lvPtfsD0SzG5JdG4ie21Nr3dIv
         wnv/qt6iah5qx7jhqknl5nKDav3kmhd5nnGUP2JaR/VUrE79VJw3F9Tjd1KnxdQXTl9Z
         l1B7x/fsFbyp3iswKF4bZcBSrhpOR0MWjXY7O49g1Gnf2BiaLgUJN1ARszmkwztxzj0r
         cSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216853; x=1718821653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQSGxEg3iN0gqxDb6TEEcUHjyTvJD6k44q7b9dlYWfg=;
        b=iUhcPLAQiSMDVL7PsL4HyP/OFZ3awKSz0uyU/bz5s/jHSAHE+NgVYrqNkJNsvD3TEu
         3+9LJ3pPm+sk/UHibxXGm5YtHFKZYPYj/yP3suu0wLEpBLq8jn6hZ1yZc+AhmqaiK5mP
         UGD1pLGbp8yaPNy79maU6AWIXx/A1b73q0i8EK1eO7tAwK2T01X+jMnxpIrM3iBZRZvZ
         OcJFTTf/U345H37O6Zb+RyIq63Wg89fF09XF/cbER1/7oKFsM9fu82QH3+9afgmAkgP9
         qUfWo8akdJArQ4nIq3kgaaWGjugXzesWIkGzPqVDuy7ACV6mKHk0fX4fDV1xyVOi/j70
         6gvw==
X-Forwarded-Encrypted: i=1; AJvYcCUEcOkGJlSnMCSJErndD79CUe38QxSmHTc3aHLa8o1aR5u+JdXirjURqAfrXIpxUnxq5i2MZCtNKNMbVn8MfMaLMxjACwDS6LEqpw21nVs6aZXfuiurAvuMbFHrir40Byqz571gRW2MeA4eXQ==
X-Gm-Message-State: AOJu0YxYIXbBHgp8wKvh4zcaA186Se8UheMYNyk0fx7pJyTxlmV83iUa
	/3uI35BcixtbWZ+6m1dEzhKO9/UGuTFCOo1OC77eG/V4k9UX/lFWUXNZIpu9sSQDq0DqB8oq7/t
	AtdyPvc+Q/agyeSBjeP7TWc5xKFU=
X-Google-Smtp-Source: AGHT+IHE2u7bq8RlQP5/SHfWvC1F277raGWkjpZrHWs1rSZohmb9Dws1p52jKqTwp6CnTOoFDhbJ8wrhrtmgKGZnhf0=
X-Received: by 2002:ac2:494b:0:b0:52c:868f:a28d with SMTP id
 2adb3069b0e04-52c9a4036d2mr1943419e87.50.1718216852798; Wed, 12 Jun 2024
 11:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612164715.614843-1-mjguzik@gmail.com>
In-Reply-To: <20240612164715.614843-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 12 Jun 2024 20:27:20 +0200
Message-ID: <CAGudoHFc3NiC+GS68BcU0QX8zjtWFUcJsN5QsZuwLvMBnnVGLw@mail.gmail.com>
Subject: Re: [PATCH] vfs: move d_lockref out of the area used by RCU lookup
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While I 100% stand behind the patch I found the lockref issue
mentioned below reproduces almost reliably on my box if given enough
time, thus I'm going to need to fix it first.

As such consider this patch posting as a heads up, don't pull it.

On Wed, Jun 12, 2024 at 6:47=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Stock kernel scales worse than FreeBSD when doing a 20-way stat(2) on
> the same tmpfs-backed file.
>
> According to perf top:
>   38.09%  [kernel]              [k] lockref_put_return
>   26.08%  [kernel]              [k] lockref_get_not_dead
>   25.60%  [kernel]              [k] __d_lookup_rcu
>    0.89%  [kernel]              [k] clear_bhb_loop
>
> __d_lookup_rcu is participating in cacheline ping pong due to the
> embedded name sharing a cacheline with lockref.
>
> Moving it out resolves the problem:
>   41.50%  [kernel]                  [k] lockref_put_return
>   41.03%  [kernel]                  [k] lockref_get_not_dead
>    1.54%  [kernel]                  [k] clear_bhb_loop
>
> benchmark (will-it-scale, Sapphire Rapids, tmpfs, ops/s):
> FreeBSD:7219334
> before: 5038006
> after:  7842883 (+55%)
>
> One minor remark: the 'after' result is unstable, fluctuating between
> ~7.8 mln and ~9 mln between restarts of the test. I picked the lower
> bound.
>
> An important remark: lockref API has a deficiency where if the spinlock
> is taken for any reason and there is a continuous stream of incs/decs,
> it will never recover back to atomic op -- everyone will be stuck taking
> the lock. I used to run into it on occasion when spawning 'perf top'
> while benchmarking, but now that the pressure on lockref itself is
> increased I randomly see it merely when benchmarking.
>
> It looks like this:
> min:308703 max:429561 total:8217844     <-- nice start
> min:152207 max:178380 total:3501879     <-- things are degrading
> min:65563 max:70106 total:1349677       <-- everyone is stuck locking
> min:69001 max:72873 total:1424714
> min:68993 max:73084 total:1425902
>
> The fix would be to add a variant which will wait for the lock to be
> released for some number of spins, and only take it after to still
> guarantee forward progress. I'm going to look into it. Mentioned in the
> commit message if someone runs into it as is.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  include/linux/dcache.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index bf53e3894aae..326dbccc3736 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -89,13 +89,18 @@ struct dentry {
>         struct inode *d_inode;          /* Where the name belongs to - NU=
LL is
>                                          * negative */
>         unsigned char d_iname[DNAME_INLINE_LEN];        /* small names */
> +       /* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
>
>         /* Ref lookup also touches following */
> -       struct lockref d_lockref;       /* per-dentry lock and refcount *=
/
>         const struct dentry_operations *d_op;
>         struct super_block *d_sb;       /* The root of the dentry tree */
>         unsigned long d_time;           /* used by d_revalidate */
>         void *d_fsdata;                 /* fs-specific data */
> +       /* --- cacheline 2 boundary (128 bytes) --- */
> +       struct lockref d_lockref;       /* per-dentry lock and refcount
> +                                        * keep separate from RCU lookup =
area if
> +                                        * possible!
> +                                        */
>
>         union {
>                 struct list_head d_lru;         /* LRU list */
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

