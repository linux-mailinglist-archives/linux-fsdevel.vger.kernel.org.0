Return-Path: <linux-fsdevel+bounces-74280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52640D38AF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 01:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D67C030596BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5F019A2A3;
	Sat, 17 Jan 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bteuUTAU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013582BB17
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768611491; cv=none; b=HIUDhB3WPfRv1t3XTzR6wMgndlD++Ucv8GLmfNXYrni22ZVElb/D/RsZk8JgULQo20nNXKHjiflQ/xH6MBHa8OmG7a19oLIvwPclDQBlV8TaiQmumB3oLA5Vg6RwT+hZlgW6BBlDg6W04tMutDKdVqp4eYRbE4BmIWMySDKighA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768611491; c=relaxed/simple;
	bh=c3U9bFEnMLpoKBsAjUxcr86pA7RNL+CpWEHvY5Jjjfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSV7SkMSL/HufwkRCDp1Hkh5ooaBM8l0gEJIJ/Z4RYsw+PEECnVkimT5uGUuNxR0WAF9KRNTBQHD1LNl41UqJ0qwP+yV0OLglr0cPUVx0rZf7+ytK6gJKW1gsfroGc5qCi1HsBN4bCw5re/FoU/9CcJEnJc+G6+4NWaeV6pToXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bteuUTAU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6df3d6b4so3104392e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768611488; x=1769216288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g7OCgOBLB6nmoPhAPFeCmBJR0G99F5xLfDJS00i6P1k=;
        b=bteuUTAUEWGB95NqiEOq/YFlA34gn5towcoG/NpvrlC0E1ets/zKN7E2F3PO4ZCMhc
         JlYDd5vOdyVTJC6+8YPgGKy8VfPzN+SoEytpgMvNGONdQGb9vqS486SmgfB9pOdbdJ0e
         D3HfEHJS0kahYWBNh1PF7abWR8R7VPnc7Na89zifpfpialPvE3XFHt2VrnEu2Uc0z4tc
         Scc2L7RZ7EiK7q8P67imnDUv/GLuLrMKIezwzz2YGvd6rdCxd/0KVGruvNn2S3EOSmiZ
         5oPRbenKWZ1In6W3eNGlifk2y0AJvstU7big0eHEsq8YuUqVum2ByCiYDptGW6v7i13t
         fv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768611488; x=1769216288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7OCgOBLB6nmoPhAPFeCmBJR0G99F5xLfDJS00i6P1k=;
        b=Zg/79yW1o/iZDeggDvrdwkRoqqqpxwcfVPRcSBg/p3OvqRNsh+XCNUvgy884Qvj9ki
         qe/9WmvVhMLApD1gUJHrIEA7QxnaDNmULKd+JMeVnEN5MkI5nE43qP7DkpGF2h4JNfhA
         bzKsgng14ECdkuvpQNw3wevVGDMxRJ787YbMsb+dqEG96XKizWiIwpfWuJR4fmBKD0gs
         ZjiGkUs63U9hIMd83dDJEUsX6f9bGvkdwRclTdAbYlmjS20QhMe6Efnk7MCTqBqS2Zqb
         pNcPQJ+Ip+ZclnbqDvJR0dRJE06NR+1Mve6SQgTXNlWnvZVuTOJwRuWYXSlc5srp7be0
         T2LQ==
X-Gm-Message-State: AOJu0YzxLny7QRA7+IKXh2PJu53md/YmGZU0+s2qtRPtsMVT8/Ej9iF7
	R8btCKOOjQ1Eyi1psikwcFlQyM4w53z4m4MefViCXVSBAuc7ddLFbGnFoRHBYft0wvKBws1RKL9
	WgYW4shwBfOxmiyCAYc3yG/3KlZ6ZO/cOKDPpAsZBxg==
X-Gm-Gg: AY/fxX7BjCHdBflK+WUBk2c0yhaggbC+lrBzPrveWTg4YyOtNFDVrpf/8iSF8cZgzOj
	Ciz3IKjLRM84McUB2Aw34fA/j8JgRrO8KkwBW/WdbUPOSQOc7xEFvswmHD5HLftFujtPdD3vx1z
	YHj3SF0Vo8dtYoBPrcpQF2/ffT9JWtvtXBY4Qxxqli+ASnfIf+DVHgzfM+bt+vRHJoZCJwyhpcm
	sFh/MfVTj/2jkwXrEap2EiE7nWaIJhc95UY1ZJbm30cA6ERjSHaM9/6ZQXJUu1/77tbihd5nyYm
	tjkTmA==
X-Received: by 2002:a05:6512:690:b0:59b:7291:9cc2 with SMTP id
 2adb3069b0e04-59baeef8967mr1320623e87.37.1768611488023; Fri, 16 Jan 2026
 16:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119101540.106441-1-zhangfei.gao@linaro.org>
In-Reply-To: <20251119101540.106441-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 17 Jan 2026 08:57:56 +0800
X-Gm-Features: AZwV_QhaATamjAzKiCbztyI4Neihn1O5wUBmT0cVKfj5IlGDxo1FujEHJPeaMQY
Message-ID: <CABQgh9E00m5WZti1_ugw3LfMX51JKbsPGVmssybNPYiJjeHRRQ@mail.gmail.com>
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

Any comments, Thanks

