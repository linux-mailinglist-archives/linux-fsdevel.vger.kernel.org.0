Return-Path: <linux-fsdevel+bounces-72396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAF6CF4650
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 16:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6380B302BF60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 15:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09881F3D56;
	Mon,  5 Jan 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRSLmMTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF71D5CC6
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626845; cv=none; b=EzX30NZ5VFPN8XV/3Uq+vPtV7zPx7nJ1IQ9HzvWq1XToIDy8ddrzFoJzi2j3eu9jnNVvKAbG2ymOSv9zG7yOe2hNy25qmVi3BKzwoJX7TNSJZIZsCWbIZHAQx5wK4fSjpjiCNbXpupBl+qMVXTjsZXty3y9jQmfhAcpg3vG5YSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626845; c=relaxed/simple;
	bh=C5vrL1z6SnvH6Ygy1t0+EZnabdVjHODIVIGv4RRZCEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejwHYISup8SXEpwq+8h1+Ze6p7o47YFe0HT7gOyLQ2Ggv5+byfE+YoxHtVrAacb/3j4hwYjXN/H5XNVSXI2A7cDSCtH1wBHhX4YuKO8gyt3+jOtjHi78Jdvrq4jMUCCnS+Dbp31itHCUMj3TAXAUSfqM0IOrVwVelHaVi2nXoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRSLmMTs; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37ba5af5951so377811fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 07:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767626841; x=1768231641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn43i3LzpcaVKx8sZkO5nilSDYZhIbH7gusssvJywO0=;
        b=SRSLmMTs2UBHru+2q7kTmuwodhC/c8Gx/kvnJd9qPc2w+IRMXJ8MNAhgCNBhxOV6O4
         XwEEiUjwIEOZUHxlFPenRllsdIdQYp3pHDaMJlT89w97xzga43bH2FED8xpE2LDY9p5T
         MhRzqDT2UISNzNVbhL6LqIS6zwnPklPPgFS4BuUvJImr6pTPM2XiahhGIPlOZgGsXeaQ
         Mc9NHJWvDDmQrqBIa9dQi1bOUTNSuVV+U27WtGD88Tn8+NShOgsb+6DVnT3xqO4AxK2D
         GTnfq+2OBpmbX6epTziT3mrGDFnSq0aK331hCk+qJPcmgwwN+k2FOAJJkkWkXnVYYe4Q
         wpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767626841; x=1768231641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kn43i3LzpcaVKx8sZkO5nilSDYZhIbH7gusssvJywO0=;
        b=fImPUOvPaXhkB3yxkiAeRWw3upHeBWWQSjp/0jx1ynGpcaKETRJByl55hyjWPr1Nny
         Zl/ESPuETvFnsO0RsBMX9teTLV8SCeyF1WdKZ/WqA3l/Oz7Jt+wMrEf8xKVfMgvSEnNT
         sL7Wey3CXy3iDjtHOFnvNU4pHu7yOnJo5pZgJhXzRsF4vhKtGag5iAsazXRDKSEi7H8s
         5lpiFRwSVjMxGCfnkSPkjjDpDrh5hOkatV4qgrdj7qeHI14usfrYgD0VxAEI9OHVnA9g
         N+AdlMI1AbqcnO3DcVU6s5bDxyH384tIU5dAvvWtTEXhtJx9ohrJjpHCxOzgsLw+vcfq
         qjkA==
X-Forwarded-Encrypted: i=1; AJvYcCWrafOsJX9b0rZfHzZtWgrL1CdfiOwJZEm5eIsB2cqIFUZfdXJVVGbzyOlsQGM0LeMNjlM741vgNUsZYt0y@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4BRKZV8Mugbhc1tCc7gZdeMsFuIJKp0z+JR2+heyF3PMzeto
	27VRAxq4n4OWJshK0xjDZreH4w5kLLK5TL5suokRXeKq8jeFqpPgcm132livi9dSNjGi4bGnJ2t
	kbSAhZ0pSUgSjD5hgfgzwCqEbWLGJUCg=
X-Gm-Gg: AY/fxX4vwmt6Oxn+G//U6F77QRIGvYsDOrgZUle9428zd7tTPS1RswaaraDk3xdAswf
	yYSoBH0HWJSrVxOSc3qnIyAl1EPmiPD0P79xW9h7fiIuAsQrITlfYppU7/RZQwKCHlR5EXNVufG
	AzTqfZHCmX0E1wM9x62y3cY80UzW9Ikd67fl+u8qX1szDpNF7VPdEdsibrxoVj4Ph/DyuG/sN47
	FnzESwtA6cK11j1eVbq8HmjrkBHCQulVt282qluZhH8HAheC6tAhq5Gu44Gv0zFcGB66YQb8Rig
	yhZNv3OpAmaxBMKUgfQjIEtI6E9d3YMI3IxFgihxkaFcZZBe7iMl//G5c6gZ8R2LPhHJQZkqU/T
	UB9dNKuPElkZd/OcExqkNbD9PyPmugl3ZYX/JdygQ9g==
X-Google-Smtp-Source: AGHT+IHLPkk84HDbctsvqovRdNwO8VvPLDd80eOVW7PHacCQOYIdRdymbqSCwJh/PEO5EV8UmN/IUnVVjDjqV/oUkCU=
X-Received: by 2002:a05:651c:1a08:b0:372:628b:5cb4 with SMTP id
 38308e7fff4ca-381216a75b0mr155117721fa.45.1767626841435; Mon, 05 Jan 2026
 07:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com> <20260105-define-rust-helper-v2-27-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-27-51da5f454a67@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 5 Jan 2026 10:26:45 -0500
X-Gm-Features: AQt7F2qJLVbMjEOQg2dt-RJ8P2I5PmniDGVk1Kk9Jbi2wHHMLCGhrUjUoujZw4c
Message-ID: <CAJ-ks9mh9ni0_td285C+=o8TDshrKKzUE64-hQ5hx4pO0v0vXQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] rust: xarray: add __rust_helper to helpers
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:43=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code.
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Tamir Duberstein <tamird@gmail.com>

> ---
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Tamir Duberstein <tamird@gmail.com>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  rust/helpers/xarray.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
> index 60b299f11451d2c4a75e50e25dec4dac13f143f4..08979b3043410ff89d2adc0b2=
597825115c5100f 100644
> --- a/rust/helpers/xarray.c
> +++ b/rust/helpers/xarray.c
> @@ -2,27 +2,27 @@
>
>  #include <linux/xarray.h>
>
> -int rust_helper_xa_err(void *entry)
> +__rust_helper int rust_helper_xa_err(void *entry)
>  {
>         return xa_err(entry);
>  }
>
> -void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
> +__rust_helper void rust_helper_xa_init_flags(struct xarray *xa, gfp_t fl=
ags)
>  {
>         return xa_init_flags(xa, flags);
>  }
>
> -int rust_helper_xa_trylock(struct xarray *xa)
> +__rust_helper int rust_helper_xa_trylock(struct xarray *xa)
>  {
>         return xa_trylock(xa);
>  }
>
> -void rust_helper_xa_lock(struct xarray *xa)
> +__rust_helper void rust_helper_xa_lock(struct xarray *xa)
>  {
>         return xa_lock(xa);
>  }
>
> -void rust_helper_xa_unlock(struct xarray *xa)
> +__rust_helper void rust_helper_xa_unlock(struct xarray *xa)
>  {
>         return xa_unlock(xa);
>  }
>
> --
> 2.52.0.351.gbe84eed79e-goog
>

