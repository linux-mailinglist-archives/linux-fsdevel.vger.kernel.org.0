Return-Path: <linux-fsdevel+bounces-31146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3709924EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 08:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655DB1F22F41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904DB1474D3;
	Mon,  7 Oct 2024 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQtvxt4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4B136352;
	Mon,  7 Oct 2024 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282913; cv=none; b=PjB1bdwpYGbpliYwqDdXZi0ppgoyISlm6bZ9CUEOBzgiJfHYQU+64uGWjvoD3xS4ukDSdAeKVq2W+E0ldR+MV+hJxmbQUUV8K1T+GyFloCu2l2cZLojplmBiIKcQCPhT+XNp21P3w3MXQVnidWLTe7jZWezj+8YgSFR3c+9vqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282913; c=relaxed/simple;
	bh=C9vugPantcq5Nz4JE3GaUG6PdXi5t8SIqvH3ct22xSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHu2fDATPfb0F08Jhmd8O3Xvg1DOkbUqL9S3KtzpipMwVq/FLukXhHSvKkWmsGT7zL6WytrFkSH+rGBJoAFhbFN7R6+7aEcs7v56KLhN7R2ua973t9gs76uBqWkhscyBsQgMbpEMvfAjlREwt6zCR+kYemiNQOyuRbo+4BhubMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQtvxt4f; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e262c652f99so3291217276.0;
        Sun, 06 Oct 2024 23:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728282910; x=1728887710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqOGhEN4NKZ9TINzXpkFzJ97YoJmNrWpexCIgAHOxuc=;
        b=FQtvxt4fPD7V5besdBcqtgRirQK3zF1NnAmlfbVExBl7KgruzlWXJQCpv8b/Rw8hEq
         sZt8kECUCg/sUxc/a45zUUwI5p3G2tKR1cJIMBB6a01sLLCzOjZKxwcJ8ft84EpkVx2m
         dC9pU79cFo0FqxEzhpXs6shNc5oQ2szNOK6py0EAYhT3+zyfLX4F1zT3chDhUtBbxPRv
         DUGCT+gGP0DNhDFHGdbABhtUu++ik9HFOMb7TSE/z/0N/TGnsdYcQxAZYdmPxCUOafM/
         Xr+Rs481tyDbQHtxgTFdMHXuUZ9+vjUEA66z4MfTKZ7h8pSQrsbNhQNRmy6MvNJvqG/8
         eeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728282910; x=1728887710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqOGhEN4NKZ9TINzXpkFzJ97YoJmNrWpexCIgAHOxuc=;
        b=svG+q1ltWoWwcFopmOQgID+QIg1ywoMP1HSxxdPlErADz89EJo8p7dwsAwpBuC6hmB
         Y3ggRfxO0puOHG7/CsO1EoWLFU+DwOEubwheGsEXUU5CPlGEsmr8pxejnqVyw4QHwVZx
         5LCQNNN7PUxbckNx19cOcZShgjo1z0bm7f2/pFQn/G2+GsVHUwt8XSWMQGVLCjWXOutA
         Ydjk+gYOkT4cegY/LazdGVT4Nww6H+gs2d6r+1VA2kK4hRlJBKRSQKUPwPXEs49wMePN
         HkPDfSc8M4IMBmApdbYXT/bbNlb+3QAhdpa35/6W2Vkze/H5f1LAxyG1y2pfRrSjkST+
         j3rA==
X-Forwarded-Encrypted: i=1; AJvYcCUur8cDB8xmoQamWEUdnQ6fbiyKqCsfC5AeImopYwuTcdS/5aHnu8KXT6ysAxdxrxjwbb8ak04KbhVhuAG3yQ==@vger.kernel.org, AJvYcCX05LE3DSZ/yU2WrUHhanfjh3402WrUEAD54rd57o9wghIGD4YtsOYPIynzTZ+xEB6yOs3URU5Jgrksb6e0@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMJJDFTrlmMmqbHbA1B7K961ChfDPnRlvav4mTZn1gEu582G9
	gS6KCE1B+a0rmBqnh3REPaQABHJ/Tiz87MNzEBCZQdXlZgSBHEEgB7AZPLUwpDTCN6Uh9P32JCz
	53UoK2LPNpD+Qg0zclw9X2DVwczw=
X-Google-Smtp-Source: AGHT+IFZAc+mZJNhsfBMUVuhqZKjS6Pt78MdzwhoT2PM7XFr+pkcTtxN1tIMVsHPPITy7qGs5KdqJKimYhl5octDCAY=
X-Received: by 2002:a05:6902:2289:b0:e22:3aea:edfb with SMTP id
 3f1490d57ef6-e2893922500mr7402968276.42.1728282910524; Sun, 06 Oct 2024
 23:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com> <20241006082359.263755-3-amir73il@gmail.com>
 <20241006210426.GG4017910@ZenIV> <20241007030313.GH4017910@ZenIV> <20241007034202.GJ4017910@ZenIV>
In-Reply-To: <20241007034202.GJ4017910@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 08:34:59 +0200
Message-ID: <CAOQ4uxi5qPyUJttWUWfq8ws0fYPnUfzPiQ27ijFdcKsqWnv6HA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ovl: stash upper real file in backing_file struct
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:42=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Mon, Oct 07, 2024 at 04:03:13AM +0100, Al Viro wrote:
>
> > > Hmm...  That still feels awkward.  Question: can we reach that code w=
ith
> > >     * non-NULL upperfile
> > >     * false ovl_is_real_file(upperfile, realpath)
> > >     * true ovl_is_real_file(realfile, realpath)
> > > Is that really possible?
> >
> > read() from metacopied file after fsync(), with the data still in lower
> > layer?  Or am I misreading that?
>
> Unless I'm misreading that thing, the logics would be
>
>         If what we are asked for is where the data used to be at open tim=
e
>                 just use what we'd opened back then and be done with that=
.
>
>         Either we'd been copied up since open, or it's a metadata fsync o=
f
>         a metacopied file; it doesn't matter which, since the upper layer
>         file will be the same either way.
>
>         If it hadn't been opened and stashed into the backing_file, do so=
.
>
>         If we end up using the reference stashed by somebody else (either
>         by finding it there in the first place, or by having cmpxchg tell
>         us we'd lost the race), verify that it _is_ in the right place;
>         it really should be, short of an equivalent of fs corruption
>         (=3D=3D somebody fucking around with the upper layer under us).
>
> Is that what's going on there?  If so, I think your current version is
> correct, but I'd probably put it in a different way:
>
>         if (!ovl_is_real_file(realfile, realpath) {
>                 /*
>                  * the place we want is not where the data used to be at
>                  * open time; either we'd been copied up, or it's an fsyn=
c
>                  * of metacopied file.  Should be the same location eithe=
r
>                  * way...
>                  */
>                 struct file *upperfile =3D backing_file_private(realfile)=
;
>                 struct file *old;
>
>                 if (!upperfile) { /* nobody opened it yet */
>                         upperfile =3D ovl_open_realfile(file, realpath);
>                         if (IS_ERR(upperfile))
>                                 return upperfile;
>                         old =3D cmpxchg_release(backing_file_private_ptr(=
realfile),
>                                               NULL, upperfile);
>                         if (old) { /* but they did while we were opening =
it */
>                                 fput(upperfile);
>                                 upperfile =3D old;
>                         }
>                 }
>                 /*
>                  * stashed file must have been from the right place, unle=
ss
>                  * someone's been corrupting the upper layer.
>                  */
>                 if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
>                         return ERR_PTR(-EIO);
>                 realfile =3D upperfile;
>         }

I like. I will use that.

Thanks,
Amir.

