Return-Path: <linux-fsdevel+bounces-44332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE1A67809
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2466B164F90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA920764A;
	Tue, 18 Mar 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="QZd7DN4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9345022094
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312145; cv=none; b=DDsiXWhSqf3juQKfboY5k4Td86yDF36ZB6xpsR7IYCRMrhHTbi2bf2T3gvmww/HT+Nt/F/G5TAwhPL+chm/Sxtsfe8iJemhGuK1V4LNpo9MImv1OZeFbz4wdp9zefRKPpk7RRWcYdmaa5mAf5blA92kvW/K7uvk7bZ32q99p5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312145; c=relaxed/simple;
	bh=rjSHBZfvGbuKnjb6orx+Eag32m8zChJL/2d4fmNqHEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L25fDf+kbhV4nBTkBqCsHqqbls61HovATK6gKiPblMF4vDtV6rBupXU2uvyHZarm7GO+X3uQXj+aSrQGHxa/2PlidwJhz7R4IJgkJ4EY/UZhLPA9NwiWDfzKDFhslnHIwE4Smu3UELF3bTpL6PWqYA2e1PCCe6e34kaYdUBk1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=QZd7DN4h; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b58d26336so458725939f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1742312142; x=1742916942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB4wQt+hXwTfKdBYmNtfrnfOJ/tSYMzGg+erg760nKo=;
        b=QZd7DN4hMGqRHVuGyPThWVAxkEsFCkdNVK2cgvEpPVEg6RlCmYzl3Ww8GGY2KJwjbG
         BUhZooDp8qe6dssJcdAwY4jMlvaCfJhoizmNEzBfGE59UFjzAwAa6tzab14f/1s5rLnZ
         IMSxH+lynUpjnF6YpOj1lteLTV8pL+OyZgjMxhyffWh2kVVibD4iY7VcaVTjEIlm0t0K
         La0tz3t2eV2wnPLInACa6GmI56NZQraCB7hgQmB5aQImOdC5scfDIofnQaoIm6lVh1hg
         uQJQ/TL1AYJ0+fS4hlwyGGTSQNpmLpV2f/ssWB3HAkbJCi73RwEmL4Abpv8TjaN/QfV7
         FIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312142; x=1742916942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB4wQt+hXwTfKdBYmNtfrnfOJ/tSYMzGg+erg760nKo=;
        b=CSf/pFxm+/AE9AaFqqYFPbN5TtG5SmIT0hwQHG/C3Da6k375/tirtc4NgZbjCSWWAX
         5Dti+7Zq28A4oS/KYFsfJFZA0KeI058PAGUNi0XgQhZZH6S9kljDbPL019limoKEKCRq
         Yrmd6m00af+TjqbUlkMOXLqSpfIjJOcUg6v1u+HRpo6T5tpyNzeWkJsLxvy/nvv7uuqR
         tuVCV/kt/zDY75s+7ydKyR0yScJvZqesWJIF79QjcN0lU3zq8jeNt078p7Lgw7htLLD4
         lONvE7LZUmDIIl3+dadBVHRsw5ZsXiMCMl4belvBiZAZA/7kogmMQfbHfRoI9W3hfN5R
         FDtw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ltDZpXoMA6aaETtqeLMsShNzbPlxJgJ5LOyH1KzgxLXW7P3/xzoCMSCzj0e0/19r9kBsWxSLpzEuBjGS@vger.kernel.org
X-Gm-Message-State: AOJu0YxkISr2P5yqTXVn3aghf38XK/AX/Wg8s/jfL7xMTuyrF73+FQ5Q
	knVrPjyXagIcQcTxyc3NQ/Mo3U2cKM5splvN/EifH7QPQ/PHMfhDlplvhl/4JAIMw76x8HR4ycN
	cxdKhXQAPZBhFG4WU1zGctnUwFZvpr+B9b4Df
X-Gm-Gg: ASbGncu49u3vTyo3AxRDfVzo0lKZvBxHVQVs1ae6ix5Q/VN5sPATlBm2ruzPV+qZxF4
	ue6RnQjlvrxPpg7DRs4G/BUR7ZSw7WjyJssccXUiA2Fi14gNGtufwb2arzYAXFHGSBqpd2sJLiH
	5KqYXMtqsSSMeiy/VxXI7zbYl0cbbjci0o3sDLfHWD9+unjz15
X-Google-Smtp-Source: AGHT+IFZmDZErlEvObrUGR6mGQcHglkPZoGXLncV/C2NMKSfWfeDM2JWDi/aOM6Xz2HZbZtdQ92cvp5wJKGQSQZxVCQ=
X-Received: by 2002:a05:6e02:3397:b0:3d3:dd60:bc37 with SMTP id
 e9e14a558f8ab-3d483a90667mr218164675ab.22.1742312142567; Tue, 18 Mar 2025
 08:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305204734.1475264-1-willy@infradead.org> <20250305204734.1475264-2-willy@infradead.org>
In-Reply-To: <20250305204734.1475264-2-willy@infradead.org>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 18 Mar 2025 11:35:31 -0400
X-Gm-Features: AQ5f1JryUbGq_KnBzTvU7679Ld-7xoa3_KkN0meSuXXj53OlWjhXwmBWtUg-ChA
Message-ID: <CAOg9mSS3Hy4nG396jo2EPfFoQxGLo42c_nu4BEM7Y0Z-WbZARw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] orangefs: Do not truncate file size
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, devel@lists.orangefs.org, 
	linux-fsdevel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew... I've run version 2 of your "orangefs folio" patch
through xfstests with no regressions...

-Mike

On Wed, Mar 5, 2025 at 3:47=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> 'len' is used to store the result of i_size_read(), so making 'len'
> a size_t results in truncation to 4GiB on 32-bit systems.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Mike Marshall <hubcap@omnibond.com>
> ---
>  fs/orangefs/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index aae6d2b8767d..63d7c1ca0dfd 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -23,9 +23,9 @@ static int orangefs_writepage_locked(struct page *page,
>         struct orangefs_write_range *wr =3D NULL;
>         struct iov_iter iter;
>         struct bio_vec bv;
> -       size_t len, wlen;
> +       size_t wlen;
>         ssize_t ret;
> -       loff_t off;
> +       loff_t len, off;
>
>         set_page_writeback(page);
>
> @@ -91,8 +91,7 @@ static int orangefs_writepages_work(struct orangefs_wri=
tepages *ow,
>         struct orangefs_write_range *wrp, wr;
>         struct iov_iter iter;
>         ssize_t ret;
> -       size_t len;
> -       loff_t off;
> +       loff_t len, off;
>         int i;
>
>         len =3D i_size_read(inode);
> --
> 2.47.2
>

