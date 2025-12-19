Return-Path: <linux-fsdevel+bounces-71709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9390CCE5C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 04:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D09730399B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 03:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FBC2C0262;
	Fri, 19 Dec 2025 03:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YElitHjg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B72690EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766114677; cv=none; b=nIeV56R/jnHN2T00pBQIt7AuPqJSXUTzmhXHm0kJ8aPrGdxO52Im/qe0HbhjUSq0XCecStGwCiZvlOcvJfYVTAS9rKKQDYJ0VpHoDKw45xtEU2Oy8ZtCEKxBoQeTo5AWZ/UXIt8jqE3mJ048FDtxkwvgW0HDes339lEwnpccEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766114677; c=relaxed/simple;
	bh=4qeNSzNGWJlhgjvK+mL9X+ZYWUIq6lpCcwuMJzK77LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flfwbaLgurDqyno4VEbJJ2upjhOpHE6sAb9wTLq4hruRMZEc5Fmga+OBRKknvGcljSCndhB7x5V0uMtJ6z4itStJ5josPQqlxK63ApqxvP2LhRNCJh+2yX9y39W47Tmwf+xkBxcvPn693F9ch0QtMpSfCKGVyGPUb1uFK3ddHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YElitHjg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee257e56aaso12563851cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 19:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766114674; x=1766719474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtrnJ55siP03U+VyyU5Xt3eKmTVUCN57yQOh+/pa6EE=;
        b=YElitHjgSVNeYh2G2QVecOeuD8uAut5XT8MNV9ZGlgcytaEcAx9N/7cNefZ4teol+k
         1K9fc8aRM94nmDA/tio4fOErZsM7s2LAlgg7wpgvGvrbr9tz2XR8QDQ2Zf3Ayrh0SMDG
         k/Ijx/tphfzlbi/Qc4vA3KF3q3Y6nbFu0rbKBs1PjdAel2OvzYTHddZPJpEdNlzm1Haw
         xbct4/NLfv/Que8pp8J0k/L8cwhitV3nYrcMZg7yw4ekpGTkueVm+EIezif5V2/Q0XhX
         JvX988GgYmbRZhpkrjEH8k3mHLNyMoqs2fziI6Wr0H3xeWf50/dpmFJR+BEUTJB96Hq/
         UBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766114674; x=1766719474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtrnJ55siP03U+VyyU5Xt3eKmTVUCN57yQOh+/pa6EE=;
        b=OX29KkPE9YSG0cJSrchblkQOQ4cMkZqoamrtQ1MPtnkAxVS1AtImDfKSoaneqv/YO1
         nBK10MgCqGT5gaeSBV4XqeTs+SETO8VYhZTDBg6gGOfmRO8gkZTuTitOl1LpFXRIAawX
         fLQxsxBXssPA33eaMvLwKcNxgyzc2UqW6A5X1AeLXPcdomxBl0vq9F6ZPtuWB9It1jht
         nR02P8yL5U4cVJMgz28z2y8/cQR8i/KxoxMAKFS0w9p6+W7SIyJCRqt25eCl7b5Ts20a
         deoOZfwsLUls2Tpa6LtXAgbX2JtnBHfa2MZMyAauTehOafz5l1U1DF6kDrapLXH/6m6m
         PeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWBp/A1lWRUWspM0BnxCIbV32Y0aX9arE4VeBGwWuJDZ96/t8WobiwbmtsurnbT0VE+eCusKl99jh1IUWa@vger.kernel.org
X-Gm-Message-State: AOJu0YxovEM4mWBYZRKoq2pahQ0z3Yp28kZnfuLSIvieeZcq8HC7LkjA
	h8D3v/VQO3gGID42fZ7qn2wsqWEoHqeYg/CJcAeJ9a3vRGYf/oKoc/1uo1oZYH8GVB8e/bOzGGk
	JajozPWSq3ZBNdKXqVJZ7aqkEInxwPKo=
X-Gm-Gg: AY/fxX7Yz+6wG/LpBqTBeG0EACuTscVC23YnlSGQ8G9j2p1B7tNHHVAPHUgdo7EsDA5
	VwUC7uQQjaR6boYsFm+qgNd9e6EC7AH+v4PP0fYVIwXG44NJCzz36ZEciK8uQN9YvHZt3t/LTw5
	nViVcqQSqUxBYn/fz6R+29AsYsWROtNo5tAUkp0sg9LukQDe9NztKeMGvEavB6XOXib3BAWWOrd
	fUCba1/Jreiw9UJxUJTx5wRRi05RIakFn8CLKb+7vOUrH72xUhqCqbU8eHNYPvmt902/kbR+5Fq
	OnBPy8uKP3k=
X-Google-Smtp-Source: AGHT+IHbKjgEEABXdQvyp7KLjwi+A0JfYqY1AJA09IK5VmXIS/ba4LbUHDWJqbHBQhz4xDGkgnD5lkiqiN7J0hdG7X0=
X-Received: by 2002:ac8:7dc6:0:b0:4f1:8412:46e2 with SMTP id
 d75a77b69052e-4f35f45578bmr88249301cf.29.1766114673855; Thu, 18 Dec 2025
 19:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216141647.13911-1-david.laight.linux@gmail.com>
In-Reply-To: <20251216141647.13911-1-david.laight.linux@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Dec 2025 11:24:23 +0800
X-Gm-Features: AQt7F2oZcAQgA7H_kPynS7VuNpDVU2H_8xQYOrky0fXqJfgtvN6MGam6VKKFH1w
Message-ID: <CAJnrk1Zm7+-ha-Oyfamm0D1nEtzmYqP6cDF_mc7JftqWmENewg@mail.gmail.com>
Subject: Re: [PATCH] fuse: change fuse_wr_pages() to avoid signedness error
 from min()
To: david.laight.linux@gmail.com
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 12:22=E2=80=AFAM <david.laight.linux@gmail.com> wro=
te:
>
> From: David Laight <david.laight.linux@gmail.com>
>
> On 32bit builds the 'number of pages required' calculation is signed
> and min() complains because max_pages is unsigned.
> Change the calcualtion that determines the number of pages by adding the
> 'offset in page' to 'len' rather than subtracting the end and start pages=
.
> Although the 64bit value is still signed, the compiler knows it isn't
> negative so min() doesn't complain.
> The generated code is also slightly better.
>
> Forcing the calculation to 32 bits (eg len + (size_t)(pos & ...))
> generates much better code and is probably safe because len should
> be limited to 'INT_MAX - PAGE_SIZE).
>
> Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512160948.O7QqxHj2-lkp@i=
ntel.com/
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  fs/fuse/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 4f71eb5a9bac..98edb6a2255d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1323,7 +1323,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>  static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
>                                      unsigned int max_pages)
>  {
> -       return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) =
+ 1,
> +       return min(((len + (pos & (PAGE_SIZE - 1)) - 1) >> PAGE_SHIFT) + =
1,
>                    max_pages);

I find this logic a bit confusing to read still, what about something like:

unsigned int nr_pages =3D DIV_ROUND_UP(offset_in_page(pos) + len, PAGE_SIZE=
);
return min(nr_pages, max_pages);

instead? I think the compiler will automatically optimize the
DIV_ROUND_UP to use a bit shift.

Thanks,
Joanne
>  }
>
> --
> 2.39.5
>
>

