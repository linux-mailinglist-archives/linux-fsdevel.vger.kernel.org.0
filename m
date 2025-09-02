Return-Path: <linux-fsdevel+bounces-60030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D8B40FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F46B1B62ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C635AAC5;
	Tue,  2 Sep 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfEIxkHY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4CC32F77A
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850039; cv=none; b=eUEP9behGkFpQotZJH+QaOWhz3hATDdqzzgYey3N9nbcFHrDxWCJFL8xXuHyW7y+rnIFU6AxzYWnrIU4oM/iWPO8VJKRzs7R9PUvQNmtJfMVAe448kSmS0vRERdKX5Oqd8VMigINzf+uKUQj+Qa8H2L2UGwmk4FQOo/s9ciH3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850039; c=relaxed/simple;
	bh=kCVhrmjVw4jOp1yCWAxEPt4ZH0DFm9YuoqI/DEg/GSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW6G/E4OfA9B3fEiFg68NQoEPHZ2ORoW46i8cQZAjaDa98M8YMtYFNISSEzjsNCz5zY5BN5JzwhtSoRpyrv5VfMMdoYf6xpoFLAhLiX7/cBQeiiS4Tmii7MoF7nMuueuax0Ax74minB0c+ChXkjm7pjxG4WfrP87fkbdOKclHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfEIxkHY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b338d7a540so26397041cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756850036; x=1757454836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3cKNQOtPNM7hz0KXA6jse6dn9CSdJc/tTa7BYP2bho=;
        b=FfEIxkHYHTnDON92KnooBGKulIzHhxPtPn7RWD0F/xSLBdQH5j9n5sJzlKwyInEAqH
         HUDSRV6dTzkNYlq+VqJCdHEPL4LGWr9h4nf0loFEkkNDfB9EL0ed9XIaVcAHDZ1nXpNt
         /nehMcGOSmaL08+yMm2o0wkB3S+aco66DAnz5uo6HlpW0gdkqLDHdjXtC+OWHYLaTfWy
         3hJWjakK0g4rTkCt/I2JdE3KCtqyBm5opj/w7fkCmRdVqhSUvDZIZ5tFYXtgv0KWo2qG
         Btemm9XgCBXmwmbaji4zDL+agpwFfxD67wS20d/Rn2Dd/Dv6LtXHi8QYhIYNawDelH7b
         5qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756850036; x=1757454836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3cKNQOtPNM7hz0KXA6jse6dn9CSdJc/tTa7BYP2bho=;
        b=oPz7uik2JiAS6Ob1DP68K2e6Zg6stah/jx2KN6uwwwDdy2ICVS5+5ymFqgECoihohK
         srE1y0yu1tbJi71K9rRPztGQHfCsjYnLZ9fI7S6/fqnT5CKdYHNMnCS74Ns41UurAFCH
         2bky7uRrZ1F5xZ+ccL7atTbGbzPjw5sZ0XBdBuVzNwBwKBPxaPEVjLkM2gT+ADF1uq/k
         M9RecNe99qHMTio2Ar5ypXhg5U/WI37DMaWjD3yQfGqQVF7z7i4oKS9W/UcSnDpQ9JBV
         PjL/7ZE01KZqnR5tAkDxcn+NqEvZbsyIoCsjHIe1pmEy9+otZ75j2r66HBmnhy0itxdi
         iIow==
X-Gm-Message-State: AOJu0Yzh9uG8ZKX1+rfja1EmqOfj3gutNfiPqpcgcfJEbqrPZav1/k76
	G7DfHMrz96Tgm9H6xToM7pO9ji4Fxr7lC9GpOYKPr7n+jpGtj5yXTZ1OhPm1gH/ge1IWmTjmsrc
	7qdVxpSsosaAtLTc0Zhc5ZFs/xDUiUi8=
X-Gm-Gg: ASbGncuv2l+8mNpJYqcDVBTUKFvMO7uCn4WnSyWGD0XIITiFjFrzvpwTW47of6zqjqK
	MyHlmLrgqvE2965Gfxdf5osJAZYfnBrjrDuPUykkP4YydBPYFq2SyyeoNwLByKHkGodFShz1Bl2
	5qnsOczR3NI+ExIzWmbswIXiSdUasOQ/FKJOhSJEqLENCtjD2XAcAKcQP6+sNocjyuQKl0H9lJo
	gJNhwo+
X-Google-Smtp-Source: AGHT+IHIkrPbcDIAccC0GCmbcHgspseSAzsQFa2Rcwj8OUfCyo14loBBw0BUAGIbL+EahaY+w5xXBt5PcBbbI4/XDvo=
X-Received: by 2002:a05:622a:2d5:b0:4b0:da5c:de57 with SMTP id
 d75a77b69052e-4b31db6a651mr148142651cf.54.1756850036439; Tue, 02 Sep 2025
 14:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902144148.716383-1-mszeredi@redhat.com> <20250902144148.716383-3-mszeredi@redhat.com>
In-Reply-To: <20250902144148.716383-3-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 14:53:45 -0700
X-Gm-Features: Ac12FXyMQdDFMlFxQqeGUQECsYSvKVFMgoK0QCbfmw3y4lQOE7aDzeZww-La8rY
Message-ID: <CAJnrk1bk9jDzTzGn38S4Aq8UeDHyA11GBovpkzOD+S2o63++Bg@mail.gmail.com>
Subject: Re: [PATCH 3/4] fuse: remove redundant calls to fuse_copy_finish() in fuse_notify()
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jim Harris <jiharris@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:44=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Remove tail calls of fuse_copy_finish(), since it's now done from
> fuse_dev_do_write().
>
> No functional change.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev.c | 79 +++++++++++++++------------------------------------
>  1 file changed, 23 insertions(+), 56 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 85d05a5e40e9..1258acee9704 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1622,35 +1622,31 @@ static int fuse_notify_poll(struct fuse_conn *fc,=
 unsigned int size,
>                             struct fuse_copy_state *cs)
>  {
>         struct fuse_notify_poll_wakeup_out outarg;
> -       int err =3D -EINVAL;
> +       int err;
>
>         if (size !=3D sizeof(outarg))
> -               goto err;
> +               return -EINVAL;
>
>         err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
>         if (err)
> -               goto err;
> +               return err;
>
>         fuse_copy_finish(cs);

Maybe worth also removing fuse_copy_finish() here (and for the other
notify handlers) since it's going to get called anyways?

Thanks,
Joanne

>         return fuse_notify_poll_wakeup(fc, &outarg);
> -

