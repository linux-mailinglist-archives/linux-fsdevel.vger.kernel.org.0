Return-Path: <linux-fsdevel+bounces-62795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2B9BA10CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F796C045F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230D31A561;
	Thu, 25 Sep 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deh4wj/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C33128AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825632; cv=none; b=sJ4gmLf1ndJMA2Pb4Lm2otR8dCT7SBlfiVqvXfL9O1et61IgdX/13e/uNMSzDy0IdHGetE7spcf5LRcnTcsntt0khbX46D83nl9QAhFv5ybmlZI+TLFHx2zJ8SXFvCDBRNBY0HoPCfSZVB1c+wf/43VRWEkGO645/MuVrIM8n08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825632; c=relaxed/simple;
	bh=VKy5h8z32L3a5Nft5729a8Jl/a8mRI7ll5FVLNCPPs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG8SuVk79NbhUeM9CpIFiQ9xyC1ZfB/J9X1aSeBde+7VGw6YHUBV22B2IjTABnrRZ02Fog5qlEkQiWFL/fSyk/N0AYTsp/j3ijL39DvgoLj3pMBJE8YEpt9lB+zbWpfDsnrFikb1CDYJrGRiVmTwHGGDIhWvppccI6Lk2QoTOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deh4wj/s; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-31d8778ce02so2012069fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825630; x=1759430430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkPEwM6gyKFRg1YTFhTHrq9lxPJrn5Ag5aYZF3Sy69o=;
        b=deh4wj/scPPuLtJvKD8DSUtGNSGMcZmOTSWhcLNY8VucIocM3e9RyixUwg26BmdLJb
         TNF+eqd49xJ8vB8jBk6A1BXnqXMIjBVVxaDyZY5m3Jrcl0voPYM76vp6WFX88wIuZd4F
         UAilOeZFbP5LIwS7E0LBRLgyKjP2msyuIB5T5EPf8tyneDx1v6piuFRUoqd6SYyWxz7i
         It3MFEKlOHKmcfcY2FVSbmATb6Zdc2KuZR7wNw5t2+G9HENa4h4eZmYpeZmqwfUmNcnv
         tVWoipK41+p8ujAa0we9UBBtTXN54jWWtH3HzF+IY6GsqS/U4Ee7JNheCtTe7WDTxj2V
         parQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825630; x=1759430430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkPEwM6gyKFRg1YTFhTHrq9lxPJrn5Ag5aYZF3Sy69o=;
        b=vz6uHAJ8yqT9d4WNDD7h6C9eBvMsrgtCJKaaiamPNMhoo5zhohHDGCR8Fp4XU15Gix
         Qb85E124Mf9CKnTti2oXMnhiQIyqceYikeKlDfROUAzHBwmEdm28dbLPlgEQ7ROLghNG
         goDMKjMlj+DrgOdfj6clkfjqX8Y32J6QQQRME+s9H/qNyalXmjnkkVxvXk8FsUjCLnx7
         4STsVl4Agf97mxxza88lsPiWA3XWLYfV2wl+LU29DHXvbDFcZslSymsUdMUlQx++t1k8
         Y+ZfI7HbUVGTIGfgdBwLu1Sl60cKIq/R8zXxhGr3CitBBAUUK0i4sedKDFu6kXex6wk3
         dOJw==
X-Gm-Message-State: AOJu0YwoV2qQIQNiBPgpYjLK4BMxvbqK2hvbn1lyuklSVZ+et8cfh1Y7
	g17NGEWjNdepZXFOI+W3M8Zs9gQmz+pEFsybx255yPFQEw3Ky60e+lgb8K/E7BxW+IHIrkB0bG1
	5FDwcDGichohI4k+cASQ+FyUmDWsA6PI=
X-Gm-Gg: ASbGnct4mqxsQeumH0F0b9lmOBf0gIjkVRNqGoy8nUeFx6T9O06R1WLeoBY1siuFu3D
	/azg6+y/B+AdEF+SCuW/EoNaj2VAQp+BhCnK614+oQcGbawQfvgfFW5MYdQ4R6/mcluGm58UkuD
	TaqO6mweaXMqQzMDlQOph1obllekOYutvqHSATvVNsT3W8EP+HuUFcPPjd6rRq1xF6TlAfVzxna
	faY
X-Google-Smtp-Source: AGHT+IHJuuV2O50+pWwhJ0nGSAv39tgEhc3Z/UMI+0DDtzPlW8WRAcQsfKxyhW9PzHsph5GF1V4ew2CgtmAK1oSly2Q=
X-Received: by 2002:a05:6871:5209:b0:2ea:1e58:7a69 with SMTP id
 586e51a60fabf-361fe73a7c1mr2382767fac.15.1758825629828; Thu, 25 Sep 2025
 11:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925183352.691557-1-ekffu200098@gmail.com>
In-Reply-To: <20250925183352.691557-1-ekffu200098@gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 26 Sep 2025 03:40:18 +0900
X-Gm-Features: AS18NWDr8-34BjVmUZRJZdClZW6Q5mrOgyA63kWCRBbOJFKIUXAtclUfV9Ag8uk
Message-ID: <CABFDxMEhuNFskeh1pCXsAO4L=KRTuyLQyRP+wPijsyohOV+cGQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix unhandled utf8 flag while reconfigure
To: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 3:34=E2=80=AFAM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---

Sorry, It's my mistake. I just sent my draft patch. Please Ignore this.

>  fs/exfat/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index e1cffa46eb73..0e3f33a26005 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -757,6 +757,11 @@ static int exfat_reconfigure(struct fs_context *fc)
>         if (new_opts->allow_utime =3D=3D (unsigned short)-1)
>                 new_opts->allow_utime =3D ~new_opts->fs_dmask & 0022;
>
> +       if (!strcmp(new_opts->iocharset, "utf8"))
> +               new_opts->utf8 =3D 1;
> +       else
> +               new_opts->utf8 =3D 0;
> +
>         /*
>          * Since the old settings of these mount options are cached in
>          * inodes or dentries, they cannot be modified dynamically.
> --
> 2.43.0
>

Best Regards,
Sang-Heon Jeon

