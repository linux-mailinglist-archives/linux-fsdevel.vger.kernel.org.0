Return-Path: <linux-fsdevel+bounces-54648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C035BB01E13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF96F1CC0C86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283C2D949C;
	Fri, 11 Jul 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS3Zox72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF42D780D;
	Fri, 11 Jul 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241358; cv=none; b=uUn6yBzXePecpFbPL2UstFU8FsEbZgBV78lE2DlrIrPiVi1jOy4TUY2j9XUT5N5+3xF9xq91gWkBisatbyD3xt4Ne+R94POBLnHibbdWlJEOZ03AJGCnpkLgKUO4sqqcupJgzg349MTnxZ9cpvgKvCPYI866ndqLgvgThCjvz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241358; c=relaxed/simple;
	bh=3vy+2Az+3YBxg3A152tbx7KLucblp3JTo3PC4yxoXwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pemz1Qx8W0irv41ubynMIqohjyup8zl5sK7JudDb4utjCHnS5TA1oHoA/YJYQqIMASydA5kz0RNjYppDjD0okzwUa3clWFS98HJQSAuhleuCSzFCH6nF2nRzHNV5wkTvp/E7FtYAp+8HhT62+bt3Q8LiLorT3xkgddRx6Xlg1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS3Zox72; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae36e88a5daso417036366b.1;
        Fri, 11 Jul 2025 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752241355; x=1752846155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g631eWxBpL52MQ7Q4G698RubNUrT+329q3IYmq/ElwA=;
        b=nS3Zox723JcpVDd2tzLX+lcQufPE+Ew9B1L5JB1MtzEOusYDjMnKhEYcqRQaHR4H69
         xHNbm2zdpJu8JGDSa1rrdYYoHvGTWLER3ctwzc0JCMZd5ArVRhgn1xmhM7Yutw+bzWaE
         8x27mGVuZptrloCj1G2v2zzAyDHOOv4BBrLZbhmmrGZZX67GJaor1DvxUT8x5i22nnCj
         CYN2G/KrEDtNHiXHobIXe0H3gQQMl8qwnc0sHuXUTsdYZQF1XmZl+bVQ564QQgJWSq6F
         VNrz0unmRLKf8zI9BQTagcBSA5oiiu8wQe21eREuZljblO9+zk7B3Gt2jcZ+FEAIN9Z9
         bYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241355; x=1752846155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g631eWxBpL52MQ7Q4G698RubNUrT+329q3IYmq/ElwA=;
        b=abv+/VRdcUo+Wo8dNju1n33FPPXLEPhnnPDs+6K173QwvLxa4fvCk34PovawgMyi7r
         nuDKgs4g8jgC1DSvghcwjBsXvDyNpZPku5CYwqDjhUlWZYjhOV5LVx+hbCCIYaa4Fa4o
         NIOD1jQ3LMf1mQH5tCOskFZfHz4fVvOoBOBfCmjljdiOPGKkOasn53V8AoTTyGRsHSq7
         hAm1bsbcbwJZhyYc6Oi9usHKdxM5AVcQpUMZV5SBb2qFD/Ewh4lOu6a7L1T4CVBBX6N4
         UBuqccrEJYeLNhJWetKX5Bwb1emInuQfoAE3Hh7Qrbpe/e0hKK9D97fdUFf4kuEYFaLR
         N7dg==
X-Forwarded-Encrypted: i=1; AJvYcCUk6gczMbptqgvOnqPgiRBAPaUje2zPudrs4mY7r2kjVXpxDy1w+sATZRluqUYRg1Z6wyw8RVF8z0b3wdlS@vger.kernel.org, AJvYcCWpbg+zGShvmbU6AjhMJaQ52l4ju/TzsEXulsyccfF7Xqa1o3A/JbpIXY3KAR/Zu12TiAyZSRNato9to2uOcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWH1tLNBP2ucQ4d8lRN+611RFTOpc47GNtOKYN5ZWeuoXj1nD
	r87JFpCgl8NXi4HtbiBWP+PNDAROT3yrB6sGnOki9oRJuF73wxfBrHXmP9d8BOHtrW8Armbhs06
	VmPLEBvDTZ+q/51kaah2dice8jR/18FGe7Gx5c00=
X-Gm-Gg: ASbGncvckIBf5JvxbK7mhJbc1hmSaMXD01yi3eRhrzfNC2MUHy6Ihgj8VtLXu8rK0Bh
	pOM8o9u7ot61SsCUXqgt8qLfnGFeqwtMZ+NzfPVfjAfmSr8k5bWSagg3iLH4OpeK6Sz1b/+wn2v
	RGOKg4VDghiFpELs73UyhO2zwzrtxWCckDBknZKDNI/IKy7km5AX9mME9f5PHYQly9AhU70nN/f
	KG0mew=
X-Google-Smtp-Source: AGHT+IFC8scW10lYzd2u6wLdIAZ/rNq48Q+14emaGuR1DjHxMq6v9NTaq01vpPCUNtLLSKz9shHFfY2tdDwCf5f37bc=
X-Received: by 2002:a17:907:60cd:b0:ade:35fc:1a73 with SMTP id
 a640c23a62f3a-ae6fc21fdcdmr371292766b.55.1752241354468; Fri, 11 Jul 2025
 06:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-16-neil@brown.name>
In-Reply-To: <20250710232109.3014537-16-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:42:22 +0200
X-Gm-Features: Ac12FXycqARD7suPg74j8s6KnXoLXukAIYzEnOtUgYY-NdCwcSk0Ux906Omnt6w
Message-ID: <CAOQ4uxiv+UeEsGAihjGUajyOfX6P0QQ=xt9bMxZv+-WQM4rYjQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] ovl: narrow locking on ovl_remove_and_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Normally it is ok to include a lookup with the subsequent operation on
> the result.  However in this case ovl_cleanup_and_whiteout() already
> (potentially) creates a whiteout inode so we need separate locking.

The change itself looks fine and simple, but I didn't understand the text a=
bove.

Can you please explain?

Thanks,
Amir.

>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index d01e83f9d800..8580cd5c61e4 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -769,15 +769,11 @@ static int ovl_remove_and_whiteout(struct dentry *d=
entry,
>                         goto out;
>         }
>
> -       err =3D ovl_lock_rename_workdir(workdir, NULL, upperdir, NULL);
> -       if (err)
> -               goto out_dput;
> -
> -       upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> -                                dentry->d_name.len);
> +       upper =3D ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upp=
erdir,
> +                                         dentry->d_name.len);
>         err =3D PTR_ERR(upper);
>         if (IS_ERR(upper))
> -               goto out_unlock;
> +               goto out_dput;
>
>         err =3D -ESTALE;
>         if ((opaquedir && upper !=3D opaquedir) ||
> @@ -786,6 +782,10 @@ static int ovl_remove_and_whiteout(struct dentry *de=
ntry,
>                 goto out_dput_upper;
>         }
>
> +       err =3D ovl_lock_rename_workdir(workdir, NULL, upperdir, upper);
> +       if (err)
> +               goto out_dput_upper;
> +
>         err =3D ovl_cleanup_and_whiteout(ofs, upperdir, upper);
>         if (err)
>                 goto out_d_drop;
> @@ -793,10 +793,9 @@ static int ovl_remove_and_whiteout(struct dentry *de=
ntry,
>         ovl_dir_modified(dentry->d_parent, true);
>  out_d_drop:
>         d_drop(dentry);
> +       unlock_rename(workdir, upperdir);
>  out_dput_upper:
>         dput(upper);
> -out_unlock:
> -       unlock_rename(workdir, upperdir);
>  out_dput:
>         dput(opaquedir);
>  out:
> --
> 2.49.0
>

