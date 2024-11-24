Return-Path: <linux-fsdevel+bounces-35705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A229D75C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9400B66E17
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A4D1AC8B9;
	Sun, 24 Nov 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3gxE3la"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7D18DF81;
	Sun, 24 Nov 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732460191; cv=none; b=Sn7VE/GirGq0Pg8I0ML8kEwAZflbLyLvwC/L8OddxPRFcuVJQvOxjXE5uXLiH/NT1bAkCEs9B+SbXdCwEZ8H1xGYHpyTLsMFwV3uS4hojTkAhw5Rx4qjOPyGCIbcZiYIMiiWpHzwqp2smSKtN9pbWmfAC8iQIqSB2dQU0IZ7Jwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732460191; c=relaxed/simple;
	bh=ducOvLjg/kmAfiYQQG2fvBYPqu/kKKB3AcwpBoC9U7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSIjl5O8iUe4V2V7YWrfVfoO4FJWtMO7nc/tAJF6sCuBjjxIultdj8yyyvSTjUhrC7LoDrEzg9WdKED5irstKWUcEnpmff80Dyx8rWWmcIJE7sfYAsv5vITfX2nlVBgU0cFWL5JuEMMMrm+egbWIK+FIjwPDWAFYNT+5zfnBZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3gxE3la; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa52edbcb63so235906466b.1;
        Sun, 24 Nov 2024 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732460188; x=1733064988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUWK7a89H1dLFK4PTmX9v8GonBQ8srMyNDaYcKlXFUA=;
        b=b3gxE3laGaZOX9RzT1gB6iciJkMvVAndqNWMYjrZKolaejzSxhFz8aac4k5SRLo7Co
         QtORDG3f7J4PPQOv7dEtc67qD6sVM2VhbsyvJrSXQLxci9yMKAayQyLOLeZCbw1LYgjp
         we+jrsivstsbrtKVl3t4GL3higLte7WzTkpML+nfEfvELO4AVpNCtf07EcZi1dBb8UX0
         g7OY3JWj73CuD2rHriz+W75Zx41fZeLvWQlnXyAq4laYb7a4D/ppgn2oVAdtkzJdLWE/
         NQGCatywFvo8mZ7/I6DPa4T1m06Smx1e68fWg6XBVRZWv3ap01M9QJlBMTSY7J9uvET2
         Y0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732460188; x=1733064988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUWK7a89H1dLFK4PTmX9v8GonBQ8srMyNDaYcKlXFUA=;
        b=NqTMawOX2y7G/tb4VuWErIztux1ZAcqOLeFdpcY6n3PrIa3d2iuXc0pWYA/zDw8d4T
         ol2ayWsKmAAXkoFUWJDVnMVsg9BFvA616ddy2VVt5yni0qZwkgMJbUFQ3GcToc6AtuEm
         89mvLaJwz3iZnLhz6nsEBMU4zjijBhSyd2pKQl+r2dMTVW1l+EdCSJbRTCFi+6H45pI1
         G4uZbw2n4VgosKPucK+T4jOIrkd2Urr+Y60mXNz8+qq1/s2hNgyzX4oIhyFXonxT9PDQ
         bf2L/qhhJWX9eoQ7ueVCW1zsvNcUBoMp1+ktyFdEerQzrdDF/Su1t3iC+26Ubzm/ONou
         XkBw==
X-Forwarded-Encrypted: i=1; AJvYcCUb74G9fflYUp07Pbx3+bONiS0kmwhBrnSrqAx9Pyv2NuFAmiuDryVOWZzfahg/9k721xJUpH0WEv5nX2GO@vger.kernel.org, AJvYcCXwZz6TzlgqsdAi/luFpXxyGerw06hpUc3E0peQRE7qejO9yA8vITyJYHyRb5iLWW7ream1QZYRsKe2ee/F@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGMMfn9CQxY/SYD4ic0fp7C0717Ef6/ANJpOcgCUyD1qwLd+h
	yg6IOYztJK9FODUvHYDZp1mef2PG6tkXBwhXdkidNctTPqzBhB708fyYG9JmpiwiEzcQCftccLF
	C/2YMTIeMEoHNEib5CNpmP+8+ib6/cErxn+g=
X-Gm-Gg: ASbGnctKT4Wum9g4+NbwQ+9GsQtTAzxwur+dj9vLpHBewGmyxbQ379UI8rkyboekdaT
	a6TS1UjLWM/cjFMNEKWGPNA93tNbZ9eM=
X-Google-Smtp-Source: AGHT+IEdVuwTRfTJVvUBWv3kZkO/qJuOV7ly3f6L1QNFSfHKds9adCE4unSyjw6HWc5ZVh1TbIY91LoYLv2R72EXLLs=
X-Received: by 2002:a17:907:98c:b0:a9e:c440:2c9f with SMTP id
 a640c23a62f3a-aa4efe2a3c2mr1309795966b.19.1732460187981; Sun, 24 Nov 2024
 06:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org> <20241124-work-cred-v1-7-f352241c3970@kernel.org>
In-Reply-To: <20241124-work-cred-v1-7-f352241c3970@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Nov 2024 15:56:16 +0100
Message-ID: <CAOQ4uxhUX9v4RvfXJUNODOpua+G97eDYwera664n0KRsexOmWw@mail.gmail.com>
Subject: Re: [PATCH 07/26] firmware: avoid pointless reference count bump
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 2:44=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> The creds are allocated via prepare_kernel_cred() which has already
> taken a reference.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  drivers/base/firmware_loader/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_=
loader/main.c
> index 96a2c3011ca82148b4ba547764a1f92e252dbf5f..740ef6223a62ca37e776d1558=
f840f09c7c46c95 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -912,7 +912,7 @@ _request_firmware(const struct firmware **firmware_p,=
 const char *name,
>                 ret =3D -ENOMEM;
>                 goto out;
>         }
> -       old_cred =3D override_creds(get_new_cred(kern_cred));
> +       old_cred =3D override_creds(kern_cred);
>
>         ret =3D fw_get_filesystem_firmware(device, fw->priv, "", NULL);
>
> @@ -945,7 +945,6 @@ _request_firmware(const struct firmware **firmware_p,=
 const char *name,
>                 ret =3D assign_fw(fw, device);
>
>         put_cred(revert_creds(old_cred));
> -       put_cred(kern_cred);

This may seem like nit picking, but I think that:
        revert_creds(old_cred));
        put_cred(kern_cred);

Is nicer. It is more balanced and it is more consistent with the majority o=
f
patches in this series which in a balanced manner remove both the
get_new_cred from the override_creds line and the put_cred from the
revert_creds line.

If someone wanted to, both old_cred and kern_cred could be converted
to use scoped cleanup handlers. This is more apparent when the cleanup
is explicit on the local kern_cred var.

The same comment applies to a few other patches in this series.

Thanks,
Amir.

