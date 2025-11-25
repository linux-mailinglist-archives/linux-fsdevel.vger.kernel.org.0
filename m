Return-Path: <linux-fsdevel+bounces-69802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF603C85C94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 16:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F5D3B25B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19EC32826B;
	Tue, 25 Nov 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0fqWk8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A2A95E
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084779; cv=none; b=F+nTU0zGJMd49ig24EZ11td4vjhXuXHIRDC8Q1mmShhe7HrFJ92I2+o1UhgDgvW+nzxLdHhLIiKS/NYgtm0b9n4IBtO5+XyxmEatVM7I8/VymuM0Wl+EFCTiCfAGtlAmeu6BNzphaogfc3PRWas25MGnUVg20KGjkbFlcsc3WKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084779; c=relaxed/simple;
	bh=+D0qZo3N90oYA5wt4Ru61IQRuEIF3yuAc94EU9ZumCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxk0TwvWAHdyTSZPSkLV72zMw7QQYjpAxkBHHF/S3O301eNWcFQ/SeD1Q3FE5PkHzvidugOVQnoEJTSFtRG/39/hLQCUKvofmTU+ZVsAfeOWtpZAxj7TS6Ycq00a0JaK6UPh32BH8rDe8H50S+5dDA2ir5dR8bj9Ld29cq4O7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0fqWk8M; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a48fc491aso49645151fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764084775; x=1764689575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=niUyRUvISfOu1QSHIeqxi84KoCIwPbsczTynNWbCjmo=;
        b=i0fqWk8MLPZ3BCsy1suKqiO0Q/rag4Q2+3pIyEumek48EjXfSaIrMVx/AlGC3CZxIk
         n76kIzH+4pTGcK4M9eH2dnQST5N3xgkq+4zh36ke512gs6JLa+dBgk60hSl1BjE32Xjs
         9KzlXg+jnyrauZxojkVGW+s5Ksg2bRr3NMkDk4dIGZ1AOlCe0W/OGSHyHOoobFhr2fGo
         eU3CTmc3H9r1Xrq7hmoW5NwJMSuUZWWDSKqVU8wDECkhTmUrr98AFJUWqg3DOB4j0NgY
         55J/A6XqTAsFEhJuXDIZTJZUFc2AloiuGOW1cCjsuO69nQyNAfkeRtrsnTF0dZMCdphV
         lxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764084775; x=1764689575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niUyRUvISfOu1QSHIeqxi84KoCIwPbsczTynNWbCjmo=;
        b=xTEgEEhBKGm6VWqxuBQc/wplzp03PoK7ecwYEJ9o5VZa6Zk6XZT2YXXmQ/V18tSB39
         JPNatJZCSPz6YJ20o5TWFB/q61YdEz4f3GErjkNs8/7vZOv1OxREg/3Cosqx6gzLSQo8
         13je1drQNcVnvyg2DF38T3xRmwL3UkFL7TyFphSv0iUFtQ8vw1kdDmtSLabXfsfYGVx1
         tQaFQboZ7EhqHUR9WcyJZOPBhuTJvAcFV5nyoekallmGXOHi8r6MzwWCUqY3f1BLUTjD
         fe/UjwXS5MeZJykayO8Jqo/hGB1RNW+iY5PxxRhsUDwJxI/ByrX6RlvYCi7to0guby2B
         FxJg==
X-Gm-Message-State: AOJu0YwN+8wl2D/LKe/KgUS62rCcVP3mUBKj/hNtRB6fVoL50LziITBL
	NG370QflPNGE0KbwbhMrnR8woYv8fgiOrnSRn8EcVuH5MsFlvGIjm7uDCSmN3/hdKwmnFGO50LW
	MsflryBkqEpuYbczCRBytmbGpFNUHIcY8BbXVM1ncGw==
X-Gm-Gg: ASbGncs1psF5zJ8BPYz3zHngqgsBR6Q/M8WxQISOazT0AWG1wKJcxXFgjJkPy6zjgx3
	X6T3K3gNI+S3nqlyD61VsxspDCsxOvPl9obRvXu7/f9mfNneRKH8Ung1j9wiXeLYW2C/+t+f8uf
	EVD5OnchRCC97k1jL9uivjXWW72PBDh3LWdP12liar4DVqlCDPXUw6YAER7Ag6SeI6xSyFpN6et
	B36KYRHVXRkEcQnAcVUSfyIBqf3yN46htbrIxEV4M0pB/cYGuaU3HMrlfYPI+1w2y7GCEU=
X-Google-Smtp-Source: AGHT+IFp/S/rXkh4ft6DFZDN4q/WES0cNKLrt1fLsA3tB49U97PFztPLbBJ4OhkuYiLe1tur/0/oEYJKz+0uwrkH070=
X-Received: by 2002:a2e:9b03:0:b0:37b:ba8d:c0e5 with SMTP id
 38308e7fff4ca-37cd923e038mr31914541fa.21.1764084774601; Tue, 25 Nov 2025
 07:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119101540.106441-1-zhangfei.gao@linaro.org>
In-Reply-To: <20251119101540.106441-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 25 Nov 2025 23:32:43 +0800
X-Gm-Features: AWmQ_bmv4TRQUkcwc0sKZ2sKSLRk4MDYz6_YTu5y8i5ShmIE9-fSG0Wp4ukEefw
Message-ID: <CABQgh9HTCQ-rYAHQGhKPfuMWYJ=2bnL5-UJeQQxRik9Q93qHOw@mail.gmail.com>
Subject: Re: [PATCH] chardev: fix consistent error handling in cdev_device_add
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Wenkai Lin <linwenkai6@hisilicon.com>, 
	Chenghai Huang <huangchenghai2@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 18:15, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Currently cdev_device_add has inconsistent error handling:
>
> - If device_add fails, it calls cdev_del(cdev)
> - If cdev_add fails, it only returns error without cleanup
>
> This creates a problem because cdev_set_parent(cdev, &dev->kobj)
> establishes a parent-child relationship.
> When callers use cdev_del(cdev) to clean up after cdev_add failure,
> it also decrements the dev's refcount due to the parent relationship,
> causing refcount mismatch.
>
> To unify error handling:
> - Set cdev->kobj.parent = NULL first to break the parent relationship
> - Then call cdev_del(cdev) for cleanup
>
> This ensures that in both error paths,
> the dev's refcount remains consistent and callers don't need
> special handling for different failure scenarios.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  fs/char_dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index c2ddb998f3c9..fef6ee1aba66 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -549,8 +549,11 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
>                 cdev_set_parent(cdev, &dev->kobj);
>
>                 rc = cdev_add(cdev, dev->devt, 1);
> -               if (rc)
> +               if (rc) {
> +                       cdev->kobj.parent = NULL;
> +                       cdev_del(cdev);
>                         return rc;
> +               }
>         }
>
>         rc = device_add(dev);
> --
> 2.25.1
>

Any comments?

Thanks

