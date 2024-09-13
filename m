Return-Path: <linux-fsdevel+bounces-29303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D780977E29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8701E1F277FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C51D7E58;
	Fri, 13 Sep 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMn+MTsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEF3716D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225513; cv=none; b=bUv/GcpBDUCutaWB65gFxgMC1glrIlh5b42lnX+Fmz8df+OkXOxQ2cbU4okDtR6GGA75O3qv3bS+MfY3Cw8my9CFWy3pPz+KI9Y33bsXLZCt3PQQByWVYOFu+DVDfBRYTiPqoCUOQeXYiupVJBZk/ntCsAkkbbExuURBjO4mqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225513; c=relaxed/simple;
	bh=5+3Od5LitGUy8NCH8QyEEDIBCr8PbUNmDD/ed1deJck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8zDuRy/UWL7ZJ/eIn1OokmAwjuwQsUpCMIcXZG13aOuV689RU1I6vGP/DlzgRokpv1aj99z+vWVA5qpQf7HG+aSOuqNhppohvAPnOh9KH5vWmXk8eJDYpokUoebO9U7OGjf8tGHmAm5+fKsFJ7ufxUoGz3d/LR3dLewQAhubPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMn+MTsy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9acc6f22dso181827585a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726225511; x=1726830311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzotvH0KJ8dnYQ/0fguot5Gc1NDw23Za0jad5UqgBPM=;
        b=LMn+MTsyqfAI1k54I36Q5rce/XhZdkxJJ7xUON8XR++WSHbAaSESFzGq29btyozFd/
         RjisTWdX/sX1e1hEfTASZxaTmaADDqEcJfdYqkMRnUPN8hvrM14N9Q/rSL5BUHLgR42r
         3+t2yvcn53uAZtFbnPFxOix0wYYvTXI1nCkB9S9TEY4hCcPD4anULKPHcSylZeDj6nXh
         vztnjtezrRFDlu8DaJRLKI7SQ3Dn2cxrqjF5hJentNqtg+ysY0FEqi1DpPpsU1PM2jtS
         PPYWNC8z+cv9Fs3r8klXX44/VL5mgDoAu6M6YvUvs+lRBMuAyVbqPiSa6W0vCuvQlzro
         hyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726225511; x=1726830311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzotvH0KJ8dnYQ/0fguot5Gc1NDw23Za0jad5UqgBPM=;
        b=FpbyDX9RghV4/pYkbIfRKJZ8dHCeZ5QIgRwPCh0h2esZjoYrToOLPmwKgzs5uUX4aH
         Aomne4NLys5SXoowSqIw8CIUQCVN79hRYhX37t7dnhAuXWlbW+3cfnRexviuSGgFEVsf
         P7TZk8raYbdm4p0wQvCClhZkxaLY+jk+KYjjeQwIZlMsl5wnHZ6Qk3ihY3TUPVAKBcKN
         HAHWHTU+3ijqBc/wS43mB+NTVxQ2qUmROVtkgHsmazfkiShOTC08btb2ZMwGV1LLOZu8
         loCmkYZSGtK5nlkhp+RuFY4xaGe7GsrhJncFzyiW2Kys4Il+aU6yKOX+GFeoQxQJTl3F
         5lyw==
X-Gm-Message-State: AOJu0YwlOhkO1vHhuKuTfUF8Rm/SHUaj7YvWXUgCXRYWyptsSfrtgtLE
	mRJPQVoglV3BiyLF/j0yPeXs3gOkZNIj9gxz5mDlPmzkk4pLngAe0s0DNeQgZojo2UsOxQbhbrt
	WuSx4zdGpMCEQMkGL6tWCA59mIGY=
X-Google-Smtp-Source: AGHT+IEbnVg7grNysCUtuvvb0G6q+TwoWny42M6klbRBM1y4Qw4u8HPXL8/2wvFfyAnawXxDaiQpt95AQRdujGA/0Ig=
X-Received: by 2002:a05:620a:2a13:b0:7a9:c146:a9e9 with SMTP id
 af79cd13be357-7a9e5f0308fmr809811985a.15.1726225510728; Fri, 13 Sep 2024
 04:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913104703.1673180-1-mszeredi@redhat.com>
In-Reply-To: <20240913104703.1673180-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Sep 2024 13:04:59 +0200
Message-ID: <CAOQ4uxiQxQeAd6oEWkKTyEj1SttkWhOC+uPZMZX6+ziV1FVc+w@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 12:50=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> Only f_path is used from backing files registered with
> FUSE_DEV_IOC_BACKING_OPEN, so it makes sense to allow O_PATH descriptors.
>
> O_PATH files have an empty f_op, so don't check read_iter/write_iter.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Agreed.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/passthrough.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 9666d13884ce..ba3207f6c4ce 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -228,15 +228,11 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
fuse_backing_map *map)
>         if (map->flags || map->padding)
>                 goto out;
>
> -       file =3D fget(map->fd);
> +       file =3D fget_raw(map->fd);
>         res =3D -EBADF;
>         if (!file)
>                 goto out;
>
> -       res =3D -EOPNOTSUPP;
> -       if (!file->f_op->read_iter || !file->f_op->write_iter)
> -               goto out_fput;
> -

FWIW, I have made those sanity checks opt-in in my
fuse-backing-inode-wip branch:
https://github.com/amir73il/linux/commit/24c9a87bb11d76414b85960c0e3638a655=
a9c9a1

But that could be added later.

Thanks,
Amir.

