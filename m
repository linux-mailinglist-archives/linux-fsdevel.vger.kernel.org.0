Return-Path: <linux-fsdevel+bounces-55096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBD4B06E93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8925658CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F5A28B41E;
	Wed, 16 Jul 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7v61ycf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2228A1D1;
	Wed, 16 Jul 2025 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650006; cv=none; b=cPqpfpZWNwrLyLLfIuvi6cLFFkM/WPVQWQPeqB/lLwiydA0JMhNYy4DTB4Bc3gTmFzeq/PypLW2Nz1T2GhjnRxh+pZue+rG9U9EtzoL/tMkuiZmcUME4LU3LSIY7gBFFO0OFgz56m3eDMHdiaJs9K54kaeKWgqRFUspWd44rxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650006; c=relaxed/simple;
	bh=FD0opgX2rau1UT1gYZuGjED6Sduduz13AQZyp6wFqbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct2lcmbEkwEwOsG2pQyYEwDM5mu6uRboLr1ZU1DkuP+Nao5H+3ls3TWnJnjxvdWkFAGramsSLRiCb/Cu3TJHa/Fo29G0BSF+51NU3VSxNX4c3x0KPuVn0JzubdRFxw+lft+qYPT/ijCHZSG692ns0DFMd5gfJvqqc+RrqAKHmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7v61ycf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so1128601a12.0;
        Wed, 16 Jul 2025 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650003; x=1753254803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHkCypeEZtCZc3qXtwJnZP0snmQ+fokzjigJVHaNPf8=;
        b=m7v61ycfGV9VJXj+21R4gGH683N6C1OBgm0BKse+vLbs9cwixVD5h0l1LNyVTz3tum
         x7w1kNSALLnqzyV+VK6fO3nZdCgfggO7sbZgtg79sJq0xKDTkJC/07SOSB1JZYQpQ+8Y
         WhxeVl1laApy3VIxJa/pwNlsLHrH1px/HPpzBGildSBuUEX7+FbocoUXW5xjL4ccTBwK
         BlLrplzIO3sFW7prOg0DzaoAtdz7WH54WK+IT1BgY3pxhusqwBNK3l451aoXqS7/zCha
         hMsxuOWdBsFxAvw9t+RieS5ehMu3DFVQ/V/FznQC4uUKpTZsVnObcCEyjuq6HTXQbcAj
         4mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650003; x=1753254803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHkCypeEZtCZc3qXtwJnZP0snmQ+fokzjigJVHaNPf8=;
        b=g+vvqXx1sqHuDTM3Yc3WPXhjb28UgZFOxvHNoP1n2+kT4d7GwvpnkpbL5RBdnHKvwv
         rxvOE1CYWuq1tO26asrIPOXm0Az/jFbvaPcAKJxPYWyhoMpYNh7gtArjl8hPwjhm1ttM
         Z9u2/XnLfd3iz5DZvpAn5ZAUE+zkedj/DxEmwWZ7aqW3SZpw4Hu6PV+qRA+Suxbsrk+n
         sS/3QJGUVthFXUsFm+fsP3XqEQLVHUxGdZHXlHz5bMboZg1iIFiK7MzR7wJM4gaZ2q8C
         F7S8wtXKKzR7SAf/2t3ULt0QGs+xH+Z0hh8J2REaXmVFqb8s8JPjP3rHOZZumOw6XHsk
         4/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV/im/tMX2r0P4EHj1yVzMjyFpdDKl3wW5pjVzedqIdGdpFtYcHp6DwLog42jdhEMvhxScPL6EKJ/rIADZD@vger.kernel.org, AJvYcCWoC30qE3J4h4V1pxXBrEM10nfzTwkW5KM+AMnsxRGX11UnU96u96/2HYJ/bjHZ2A37fJWE5hkAt0Uh4opPOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhXs0uakhn8lcsTgyqc8pJd5H4irsEXKZnIAJQD5XHLjImfLm
	z2up8CMWdsDF1EcvCB07mLrYjbVPs54B78G7asFPcFJJFexR2YSZZ/eglhyXFn+7naHxwFIz7bf
	r2U7Zt5gG+YNTMG63p2U88LJzwS7GUAUV3aJgpeg=
X-Gm-Gg: ASbGncsjIb/kf/I0jAW8K+1dHgHBHFx0l/A3SOoHaB45wJBlZ6obKYOnMShpvCHX27J
	eBeN7RxHTrLORxxqPmxV1hLwbN7ivFL6upvhF9gPd4ag58uRdK6Kn04g+wOZsuDlikFIFW5/zys
	6Neq+i786/aoRYIDSoxnz2esjBbpqwrInWV70qu3z7pKAkKHvW+Ufllj5rt5X+9ASdmdsp2mS7E
	zCUhrM=
X-Google-Smtp-Source: AGHT+IFE0QCJupA7U7hZTwUCmSKZJ70aTBLgAAzv/iwvJuzaqrl9nAekFbA5CGyDM/7yKOUJo4B77Tm4NJG0LLClr1M=
X-Received: by 2002:a17:906:6a12:b0:ae6:d48e:f18d with SMTP id
 a640c23a62f3a-ae9b5c17841mr706476266b.12.1752650002761; Wed, 16 Jul 2025
 00:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-5-neil@brown.name>
In-Reply-To: <20250716004725.1206467-5-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:13:11 +0200
X-Gm-Features: Ac12FXwlF4wLteuFCxNFFZIJts-VlML-LGmXCQNPMNTsYdzevmN8i5hik4PuiBQ
Message-ID: <CAOQ4uxg8jKJqoRo9qonzW=0ocVRa2ggRCQU=w1hPGEegzxt8sg@mail.gmail.com>
Subject: Re: [PATCH v3 04/21] ovl: narrow the locked region in ovl_copy_up_workdir()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> In ovl_copy_up_workdir() unlock immediately after the rename.  There is
> nothing else in the function that needs the lock.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/copy_up.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index fef873d18b2d..8f8dbe8a1d54 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -829,9 +829,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>                 goto cleanup;
>
>         err =3D ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0=
);
> +       unlock_rename(c->workdir, c->destdir);
>         dput(upper);
>         if (err)
> -               goto cleanup;
> +               goto cleanup_unlocked;
>
>         inode =3D d_inode(c->dentry);
>         if (c->metacopy_digest)
> @@ -845,7 +846,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>         ovl_inode_update(inode, temp);
>         if (S_ISDIR(inode->i_mode))
>                 ovl_set_flag(OVL_WHITEOUTS, inode);
> -       unlock_rename(c->workdir, c->destdir);
>  out:
>         ovl_end_write(c->dentry);
>
> --
> 2.49.0
>

