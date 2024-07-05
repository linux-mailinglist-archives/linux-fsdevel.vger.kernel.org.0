Return-Path: <linux-fsdevel+bounces-23197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A679288AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 14:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF86286949
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB50F149E16;
	Fri,  5 Jul 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW1SzSLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2121442FD;
	Fri,  5 Jul 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182449; cv=none; b=IaiJ7Z8B7ZjdJKjN3z/g6uI4dab47XNN2LPl/Tmkwrg51b7fw28APfQJ7vDHUtz4dNycIzE8Wcmx6iFWJsT/FYQ/FdarUWgtN2p6yrFcQqEk5TQGFdhT4daZ782x+VJm0EjjdWJjvIXFt+GdJoMeg4cVVBlc/4730sqQMWpx3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182449; c=relaxed/simple;
	bh=9QyBsYxdjLLcScJNu38irPmguBA9F3rCD2vHtRIii98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZqrX4jTqo49wwijULkCQAHkuHgB0JKHg0qYa3R5zbXYvFmE4cgPcAGy2d+hAPeupU9GSyUbOGKHkr8ZIkp26RuuFzmRGPhTBhzbHa2gpV+hH0Wpm0MIGx8XnHbSPqM7JDlHnRbkV8cTfbusyRE6X2PkhlEPdUj2/htoMbBL1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW1SzSLq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so2290553a12.0;
        Fri, 05 Jul 2024 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720182446; x=1720787246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrFw5Lik5O3blKsw57AYQOVhdr+mQJkrP9zFc2yUWc4=;
        b=fW1SzSLqR4RjjyBWmh9f9Qp1RxkO3WbmuswT194FzyrZO68M6Dk+VTwLODPOCZ//H2
         /fmHuyjnVQCi61VDDIQ/71P8vQGG6vUFAt+cjOzCUfgVgZ+rfQy+ueu6csHNizRF26Fz
         25RDaC5g3FCGzxg5t+p4KeYPSR36O8sEWcN1zt6gpjp/Z+EkMbgSVMdf88NYAGdwoDwK
         voMhTxpbgOoQM7h5suCyleRaunA6l7QWQqykERxYD7sOQ8cr8jX+JnKU4Oa1UyDq5ycG
         olqOPHNhgBstFj13Ej7tWQxs8AZzOv3YonRn1q7uBSBavPKdLpaWKbabAeFScpz18rWS
         Tmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720182446; x=1720787246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrFw5Lik5O3blKsw57AYQOVhdr+mQJkrP9zFc2yUWc4=;
        b=U2KGt29xgyf0PTXWWjYfxGdLO4kd3W2CeBe5um7PTuuIpWNuVI9MyECO5PjjMP0IXR
         +4phbVPLoT+zvvkAQSpNBzcp8018OrlRlhrC+XtNA+daNdf4olcfHp5qO967DshsmjH7
         OaLYMJInkgthmb1/76VqDz+7xUvBkbOiLvIudtQlMCBzOGv5Ls4kH6eFC8VNc0LrU47N
         t7savDfkGrLsOB+7DV6Z7MHAYpyzPDcqSGlF+Sbyj0Z5eigFzqaw5sOL98gWmMYZ/VgL
         yoZQDgUBp5Qbl4CxEB5NjlWpzvR/vVpF3T4Fu3poBGCRdZxv29PtKoajQukBMoeQxAtV
         x3/g==
X-Forwarded-Encrypted: i=1; AJvYcCVF9keIqPbVUEWHcYI0wx1Ig7JbvZOBCX7+NHI9GQ8/0dCGzFh91yQtsFoU6Z4twAl8CZkCBUIAajTHiZQlLv8RKmEdf0tojt3Er/h46CEhZ/Tb9zB8WQKmE8rUo+UgCkw38Yj5WKTWyT4gPEveAzRzG3L3dwZYg3lLIdC565g6H5MUep6OYnQwANs=
X-Gm-Message-State: AOJu0YwJRruOfocX2EAJPy5NfGb3moGk1G4yuvRWBuH0H+Usb9S5cy5M
	OITfOjStX4Ad8gbv5gMpCp+chv4SXhu6qUfAdF7is2EAvMgWBVvtkGqqNwFDldkK0Q4jxNpTOln
	Z6Dh5yyaXjDeuA8F8dgMUs3CC21I=
X-Google-Smtp-Source: AGHT+IE/fmdXPB3EONv2sJvLDs8SLrR9Aygswq6SzO7JApr9zCVnZCFzQptSkhO23Z0bgNjdwrXPh75o4PlNnmmf7yY=
X-Received: by 2002:a17:906:2dc5:b0:a77:d52c:c431 with SMTP id
 a640c23a62f3a-a77d52cc489mr79643966b.22.1720182445705; Fri, 05 Jul 2024
 05:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705081642.12032-1-ed.tsai@mediatek.com>
In-Reply-To: <20240705081642.12032-1-ed.tsai@mediatek.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jul 2024 15:27:12 +0300
Message-ID: <CAOQ4uxitFgaO4D5pg54b0xj3Hnt61a+3BAHnEd_t3T9yzpXptg@mail.gmail.com>
Subject: Re: [PATCH 1/1] backing-file: covert to using fops->splice_write
To: ed.tsai@mediatek.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, wsd_upstream@mediatek.com, 
	chun-hung.wu@mediatek.com, casper.li@mediatek.com, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 11:17=E2=80=AFAM <ed.tsai@mediatek.com> wrote:
>
> From: Ed Tsai <ed.tsai@mediatek.com>
>
> Filesystems may define their own splice write. Therefore, use file
> fops instead of invoking iter_file_splice_write() directly.

This looks sane, but can you share the scenario where you ran into this?
or did you find this via code audit?

I can think of these cases:
1. overlayfs with fuse (virtiofs) upper
2. fuse passthrough over fuse
3. fuse passthrough over overlayfs
4. fuse passthrough over gfs2 or some out of tree fs

The first two will not cause any harm,
In case #3, according to the comment above ovl_splice_write()
the current code could even deadlock.

So do you have a reproduction?

Thanks,
Amir.

>
> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> ---
>  fs/backing-file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 740185198db3..687a7fae7d25 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -280,13 +280,16 @@ ssize_t backing_file_splice_write(struct pipe_inode=
_info *pipe,
>         if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
>                 return -EIO;
>
> +       if (out->f_op->splice_write)
> +               return -EINVAL;
> +
>         ret =3D file_remove_privs(ctx->user_file);
>         if (ret)
>                 return ret;
>
>         old_cred =3D override_creds(ctx->cred);
>         file_start_write(out);
> -       ret =3D iter_file_splice_write(pipe, out, ppos, len, flags);
> +       ret =3D out->f_op->splice_write(pipe, out, ppos, len, flags);
>         file_end_write(out);
>         revert_creds(old_cred);
>
> --
> 2.18.0
>

