Return-Path: <linux-fsdevel+bounces-28674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5096D0C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E21B25A78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD24194085;
	Thu,  5 Sep 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Py8miF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1F18A94F;
	Thu,  5 Sep 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522606; cv=none; b=AxK+RbP7R/MkMKe5ZYVbBNQwj8/rWuSf2g1o4tDjPvY1gV2dosNIO2WZxkqUOWNCFJyCgKjNZbwQOGZhM/nyqAFxD4WTlsu6B9dcbDsW/KqLLuQXoOSlgpXYzEfs0+T/qOF5Gkyy3K3QyCQvMzIre5rBT67ZZBe0kxEi2yTTp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522606; c=relaxed/simple;
	bh=V0dpBrY34w1of9Wfd593x+2vtoJgckPvvU/iE312/ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6O+QXZ9cIBi0m4eQ/LnMZflK3oyznwGuUS8JpEZOj9XLM3kwRc8deUfQIrieAYrrTYoj6QYWllSbMlSaj9RfFlqeHyVfn/cBLaiDjRafWI/K0EXQ/+OLIfwrlXB5E+4fXr/+P4/ACAdM57/VrZBLTUOcIhynSm+saIjztjKFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4Py8miF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86e9db75b9so69946266b.1;
        Thu, 05 Sep 2024 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725522603; x=1726127403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obKZt04JKsvNVi6u0/skPlG2/rQwZ50vJNCGCR1ZGE8=;
        b=V4Py8miFX0bajZNnezn1IOa2t/oBdXqNFEKI5xjcRS9g74wF/pEawqHD7S2xN3CUFZ
         ZZ1ZkUKIxEby5JfFSOtiQiTEXzM73yTFqg3mfXwWAhuw0MkeUCcVNpkOScl5F4BrVBgw
         dTChKme9ArR/2G+3tda7Ib4MGI1uMYGXRzPwS5UUBN6Q+jJ6ISi29X8AqIgJoRCJR316
         GObepzvAANnveOL3DCiWb0nziNZmuenaESQ+cMXHj2jZpn5AdSdgc0go+1+Me5KZCzZJ
         p3HzSuTTEcnQxKJZhxLuFGRIRYhr8KVO/WfuBHYlBRSDXTyPpItt+Hp02pX+NLyJ8Ola
         zX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522603; x=1726127403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obKZt04JKsvNVi6u0/skPlG2/rQwZ50vJNCGCR1ZGE8=;
        b=Ohb9fyz3MJW7E1fhpVvOoAzUJPk58aYgzQkv5VIHzKuNMLXOXXqoPWnLhdqhI7u+md
         ETTy7NryjZtauDbCADS3lCN8OFbkhQIi/E/XvN6XSUT0AoB51wVT2w1dUHMTfnGNtcRj
         ZOdaXo8BPIBO4YslYhdyi9HL/dkryqt1GKSgaGeu2URnJUyaVlZFx1+mHN1PkBDr0nfK
         idxeJj+856n8rXqeGXl+adpyVTEEXdTmRqMQ82unl69p9iFILsI8dOJGDhTQbs27EofT
         QRaOPCEW50z5eYqA+7dcYhCaCqSeTd8pvPZMisCLw9AdVcWhnGh1FvnnSok01idGZujP
         +b+A==
X-Forwarded-Encrypted: i=1; AJvYcCV6kRSjXWwUUEZi3EHTyHz99kLhhTpgojQX9EJu23HyERVoAvXLENHdjUYC6IdgleAYYkaeUtTjLHty@vger.kernel.org, AJvYcCWfzuTm+yLq3k5VuLJFQx+UlatxTQwE1dxy5ELh2GngJmvIyC/hSaBS07vn6ltK4Vbe/h68BvvW1dbHq+4=@vger.kernel.org, AJvYcCWxIAVyyYIUCkPGDh6TkXVw9sjUMGe4Xt6TuwmaMc9kMnl260pGxa3+jZ4OwS6MCGdemgMLcJjQAYKYP0ca/A==@vger.kernel.org, AJvYcCXTdIRaRUFXTndFEzdcbRmMNdAP/K7uKAqYkaNyDmQxm+nrxhAdiNLdpQVHg0B/uRhbc38ZQffzTGsR/3MF8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnscabWce0Z3FfSr3BaYYq1rBUwXl0/HNdvYeCXhC8X4a2FAKi
	UXSGzK7VATPKvmuDAuLHJtUH9tfHYaaMUT5z6Wm508zzGIpJVMZ4LJfpyNz3JShqLXXltjgW6zI
	GU/eSQ/48w9EkuFSZCtdktadoC5U=
X-Google-Smtp-Source: AGHT+IEHSNTpPFHkq0s7FK0k8QmUuli6ehAfPoksbiKPJcO4py5ijgctkPnEzs8y3xVPK4dpbF+h/76wGWLYfWSrqls=
X-Received: by 2002:a17:907:7ea3:b0:a86:82da:2c3c with SMTP id
 a640c23a62f3a-a8a1d32e2femr750791266b.40.1725522602045; Thu, 05 Sep 2024
 00:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <6a659625a0d08fae894cc47352453a6be2579788.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <6a659625a0d08fae894cc47352453a6be2579788.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 09:49:38 +0200
Message-ID: <CAOQ4uxjZy3paDxQ9=ME=9ukHYwpq6CRJtZ3BN=2wwa6YFtBTGg@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] fanotify: don't skip extra event info if no
 info_mode is set
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> New pre-content events will be path events but they will also carry
> additional range information. Remove the optimization to skip checking
> whether info structures need to be generated for path events. This
> results in no change in generated info structures for existing events.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify_user.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9ec313e9f6e1..2e2fba8a9d20 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -160,9 +160,6 @@ static size_t fanotify_event_len(unsigned int info_mo=
de,
>         int fh_len;
>         int dot_len =3D 0;
>
> -       if (!info_mode)
> -               return event_len;
> -
>         if (fanotify_is_error_event(event->mask))
>                 event_len +=3D FANOTIFY_ERROR_INFO_LEN;
>
> @@ -740,12 +737,10 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>         if (fanotify_is_perm_event(event->mask))
>                 FANOTIFY_PERM(event)->fd =3D fd;
>
> -       if (info_mode) {
> -               ret =3D copy_info_records_to_user(event, info, info_mode,=
 pidfd,
> -                                               buf, count);
> -               if (ret < 0)
> -                       goto out_close_fd;
> -       }
> +       ret =3D copy_info_records_to_user(event, info, info_mode, pidfd,
> +                                       buf, count);
> +       if (ret < 0)
> +               goto out_close_fd;
>
>         if (f)
>                 fd_install(fd, f);
> --
> 2.43.0
>

