Return-Path: <linux-fsdevel+bounces-35706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466459D76F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CE0B39FBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDBD1AF0A8;
	Sun, 24 Nov 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcrBBkS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6F15DBB3;
	Sun, 24 Nov 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732460395; cv=none; b=D6jNzNKvctK0g/KLzXhmHygjfrBIMGmTyA1FDV7dOW85359NQW/EO0PIaRuXbQ1TN5NsFpUg2NxZdFsyqRz9OOmls8zJ9ryqgws1caKuSQI6CMC6TzU/UclOO/8Bc1qlEnN8T/buC7loE7dX2OioG6otoxArghxxRdlXy1C0QIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732460395; c=relaxed/simple;
	bh=SEtXSw2Le5/KTp6yMgBN6q1EYBWl9fk8+kQYU/3lWBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOgJuvBnOaYFcChpMjqK2ECGhrmQeDmE2JnRvd41dT3uAMvlXNg61QJNcx2G2ikARL5wjXNYn58oHx91cyn5Rmdl7SJGD5kETp4ucAUyERKmQtxwwt5nScIJDnqKQKG/P2wWvCAi1yzY6FQtkQG97TSaCusUbDSG4MoeZdPpunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcrBBkS2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so4650334a12.0;
        Sun, 24 Nov 2024 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732460392; x=1733065192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoymuV+Blz4duIFtsVKG+gnAG4HvW5E5TWUieMKOUNE=;
        b=YcrBBkS2tx0y5hUmbiG9T5nxeTOvaX3TCb+/CHiNXloWFeQ7/F1/yuQaXBDdIocfnt
         3Q6tfaZtSQkyAgCPP1n27MjEJCnDMCH8l3usJ0hvEbBlmvm8yYPYl0Rokf06AHaz36oy
         pHWzrU/uopG4ze8l4UBcaJEd/wYON26ym5Wj66jjIz6nEg3nr9RYW0KNUbedpN4wIiSR
         3VQbwasq8gFkgtQ2TjdaZRVY7ZZXNf+MT9qW/2a4zupX9zCgNWCoquoeEqSGMiX3JZyB
         XuSzMeClYv7liq7s9OafiKADpzx5Hj4G5gI58c2QpqbEV1FekfF13QBgxcZNNSF1QMWn
         M/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732460392; x=1733065192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoymuV+Blz4duIFtsVKG+gnAG4HvW5E5TWUieMKOUNE=;
        b=l/8AhUANGJhnXAzeoeZK7F0tHqStl/HeZ3DS7z+kZFmOoTKnULQLNzlGdPO2Y7ZZvZ
         81pR3KBMge2EAhEGHXU4Qzg2DGZuJjsw682vmsih5CNvlexZeZTKSgIYdEM4uo2ZNe0K
         /vuheGlAo2zcONqdq29W1TzfJR3JqnHtj6D1u47v7bj4LavP2hrKAQIti3F9zZpR6UIF
         beHb9eahcKoX+Yxcqk7tGwXzygRbRvqhyiFu3VPpAz2jNOwchVYcLPcgrmZvFFnbViea
         FykkuV89j+pzg5HP/vxqp+TUlVgh0Xu4SOQjvD/TynWSPPMEggiwSwxzz0dPlpW0iyI3
         zaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4D7C/13/jk1wdoaEjiXTkHi/PHGBtw5WX1Tziclfala1F24s4P0mUAet52VuyweTq4/gpL0CSjTUxpsxF@vger.kernel.org, AJvYcCXOM+92oJJ14J71TECQ/Nqv53SGwmC8jJ0fTRfQqRtwVT8NawTbLV+LlepYM3/+GLpqbsOX+wb8YzuX9jK1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2qn6ZVGbna83V/RtvEpZTEch5EtgMclMDYR6RghumUs/ECx1
	QrLFqsWr3ChnRGrYaNenRQ2A3wIAp5GvrcLpQEfiZtmUWAWKzqUAVbv/nXFG8BDEs4F1cD4BVoQ
	4JuLkBZeXL1vX9gQFshczkYM5uPY=
X-Gm-Gg: ASbGncsUzQn6iehhJS79heKb20DhlEhVXHwH/ebQxrLR5yQhlxqIAKoOw2BoFCGgYlI
	suLU7bn4d7QmT8w9sl8cGkl+jR4vxVRg=
X-Google-Smtp-Source: AGHT+IG7PXoopzKLGOXM5cXiNmmhYrw8LRXD7PwAT7gmZzZ1cpmVTzSO7rrWsGqkRTFWqQag0lqiEq2cTDfmahdviz8=
X-Received: by 2002:a17:907:778b:b0:aa4:9ab1:197d with SMTP id
 a640c23a62f3a-aa509985c90mr836990366b.35.1732460392031; Sun, 24 Nov 2024
 06:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org> <20241124-work-cred-v1-18-f352241c3970@kernel.org>
In-Reply-To: <20241124-work-cred-v1-18-f352241c3970@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Nov 2024 15:59:40 +0100
Message-ID: <CAOQ4uxhmzShcqBjY-HhHH7JhSpxJ9BVGe1H6C3w-=FcH_fUJQg@mail.gmail.com>
Subject: Re: [PATCH 18/26] ovl: avoid pointless cred reference count bump
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 2:44=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> No need for the extra reference count bump.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/copy_up.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 439bd9a5ceecc4d2f4dc5dfda7cea14c3d9411ba..39f08531abc7e99c32e709a46=
988939f072a9abe 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -741,17 +741,15 @@ static int ovl_prep_cu_creds(struct dentry *dentry,=
 struct ovl_cu_creds *cc)
>                 return err;
>
>         if (cc->new)
> -               cc->old =3D override_creds(get_new_cred(cc->new));
> +               cc->old =3D override_creds(cc->new);
>
>         return 0;
>  }
>
>  static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
>  {
> -       if (cc->new) {
> +       if (cc->new)
>                 put_cred(revert_creds(cc->old));
> -               put_cred(cc->new);
> -       }

Same comment here, I think this will read more clearly as
               revert_creds(cc->old));
               put_cred(cc->new);

and better reflects the counterpart of ovl_prep_cu_creds().

Thanks,
Amir.

