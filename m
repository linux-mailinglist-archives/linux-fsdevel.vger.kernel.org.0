Return-Path: <linux-fsdevel+bounces-15668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3305F8916CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 11:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D653B2385D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A84AEDF;
	Fri, 29 Mar 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dyuwjWZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1822E5D8FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708055; cv=none; b=RtywXbJNMhwNKXc0JwWGAjhRk4ZRlzqv4TR3+25mGhiYVvRUVgb0CLMp7iEPWZ8VkUMzX+Q+QyzH+4AbM8LWO7wd9xfd1ABlp3ERAkLKvPXL/o+dJHiXyxMEkVQSPmG9seVI5NWA96t0cNLsYmhLkZx4Lg1GTlKQ9vVq7Dz7xPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708055; c=relaxed/simple;
	bh=n8h0843dN8D5vA/PkugrZHKUYOVTJ3ipk22+mvTL/rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRZW6bI5bEVb1FoBiEqBo4Ri+zz4QvZziSYzIg5avc87Rh5cpSW2z1RvKiEVXRMQ4veOW+KScCnUqRFu/a7jKLkQNSzBzBPcusMkQtzq6IKu6qKGytCMPz+bBz9xGjOyRxE9uV58XVix3p74QBpdoGoKIK4USOjbqdeOMH4mP+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dyuwjWZU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso26548381fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711708050; x=1712312850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPUqPHiAYDsvF7c6mpbUarOnTLvyyWG07eUiOIJt2gQ=;
        b=dyuwjWZUfGWzJVysscD30kfuI2gyGOnYyqbGUlDCiWGyqIwspDyRcAC9eFt55TQL4N
         WILwNtOpVmkAH6RhWJ5Env6RPZV06CR7mPyYYVYbhe3cH5Lkf2lHDRGq8DvyUcF8mDZK
         RY4O9ESRZG2Von8kNqG99fYZs1oYfSfZ6QPfSiXa0Whm+GooCBUofQDP8KzW+V2gl/Ks
         m4V83+ciic4KyZm5qF+aYKpJ6koSYpKheZAUuqpjyqFKfTpxRWd+WM0zyf54/DaM9Cfu
         hEIMEmDg629P+tLfaGcJ5JJkJPLzByeLVH5rL9j0QQUHqoxyFDOj2qrT845zjvviERic
         cYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708050; x=1712312850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPUqPHiAYDsvF7c6mpbUarOnTLvyyWG07eUiOIJt2gQ=;
        b=q5+qRjb2Ki0ae8LhzFuPzXC1JdvPtwsBMSJcSrf0TIPaM9419b8YqKYlow929kvGxY
         cYJkeZhIJJQouUqWHlpv5OS+O61So0D2TH5Ln5XBZJ45jZ1WbacAPU5GZuhSHtVbP1NS
         RukzG+DGazlvPnMBunDEvuThxgNz7aIu43NY1iVBVAO6NgBxzzC0Jw3XDAcfbxl1v5VL
         bJh2A6jOthlPfn0BsPrSvopO6ZJ1NsVnsi/WEuAjA63UU5bWCZ+EbSz/k42VTg7OMt7Z
         sdgTf30TpbTpsB5YjoiE+fJVmR8HWnb/qfZs9G4yJ7DLIAMBCl4cqtrUjwJiDYAOKuFI
         LjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzYhKi6wuZBrststQ6cT05haDF07WSwdexDlchN2y6m402boYWQfciB/svFOComYwRHXswjA/v3/a3FHilvnIkJ/a+BaYERTbfoqjpXg==
X-Gm-Message-State: AOJu0Ywn98H0K7MKMxtabgNOSzKdFLPyDHyImhDt8c5twbn+Mzpao3rk
	+Pmuw1d6rFqQMHsBTSoHSX/glKI5s5KWb03wGVBBdA9EE9IK0giqC0m+alJs3HwscCafH630UJE
	cbY4uiCVWY3+hvs9F8WgFCHFlVsYE4OQ+SdPXKw==
X-Google-Smtp-Source: AGHT+IGkJetMoIDH9w2TQurNFFXLK7XsHfl+lPbtCC+0MeMFYTkyF7Alb8el7pzIkiwo9JvBX9h3ULKBGoxrg4XKpUU=
X-Received: by 2002:a05:6512:33ce:b0:513:af27:df1c with SMTP id
 d14-20020a05651233ce00b00513af27df1cmr1559870lfg.11.1711708050041; Fri, 29
 Mar 2024 03:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org> <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 29 Mar 2024 11:27:19 +0100
Message-ID: <CAMRc=McY6PJj7fmLkNv07ogcYq=8fUb2o6w2uA1=D9cbzyoRoA@mail.gmail.com>
Subject: Re: [PATCH 09/22] gpio: virtio: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, virtualization@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	netdev@vger.kernel.org, v9fs@lists.linux.dev, kvm@vger.kernel.org, 
	linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:45=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> virtio core already sets the .owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Depends on the first patch.
> ---
>  drivers/gpio/gpio-virtio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index fcc5e8c08973..9fae8e396c58 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -653,7 +653,6 @@ static struct virtio_driver virtio_gpio_driver =3D {
>         .remove                 =3D virtio_gpio_remove,
>         .driver                 =3D {
>                 .name           =3D KBUILD_MODNAME,
> -               .owner          =3D THIS_MODULE,
>         },
>  };
>  module_virtio_driver(virtio_gpio_driver);
>
> --
> 2.34.1
>

Applied, thanks!

Bart

