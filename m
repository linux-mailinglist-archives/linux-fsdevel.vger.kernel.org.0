Return-Path: <linux-fsdevel+bounces-71267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308ACBBC4F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 16:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 546DA3004414
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816A28A3FA;
	Sun, 14 Dec 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVEkrQ+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE026FDBF
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765725238; cv=none; b=G97CNWMzgyL5jAbpYzg1Oql/ML60qRQ0nuRyUTGQABM6Hf6lfN9DjcRXgpqg9jumM4T4HS2N4weun8kY9rrVieutXtpPedYUqBFFtHGWryU0G/0dTDF5tfi/k0xgGUH23htM1KOED46XTIke9DqqwGTt5N3iJdmOMBZwAWBjxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765725238; c=relaxed/simple;
	bh=OavCEQv2KVXXCf+vwZhrsR+ZYPRztm07nODDLtdUgVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDiZfeUo8V5yHRD23FyBYIci3j0/tDOH2bFCxuEcl0FXkXMWXOVhkaVnDnFRBFHhlrZwbIT9p9teVEbTaMp0XNl7kk8zvHSVRNX4vd6mtINpjBc9Z6sQ+rzn5EY1g5NF3YPdhyh7sn4dZY7nEXBQs8v9MeuFZu9sqMgdhW8INrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVEkrQ+x; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso2847339a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765725235; x=1766330035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mFoUQ0HHHHziFRfQItmkm9cx89j3cdlQJJW4CKWdCo=;
        b=VVEkrQ+xdkwajvtJ9JXE2r5Fd7ti4a+sHqMLN7lEt5gP5ZBuaFAQ8/GcaelI/qmlyl
         pQ1oBncTcCM4NhAl+nzFcIQdZEFl1zSb/0hWWD1a/RqUSzWzTdNVPYgucwFYebhX4kbd
         JGmTqumUf8k4RcCWcE/53ISLK+4nz1PukAAgVLdeZuZ1ilRnPeC6lWqSR9UB5EfaYSVU
         FyHSsHadhHL4brW6p7nEjLaM/m5nbJzr2lr3mJ4NeVsP2EhwoKKxcfHS61pkZru/FAoT
         pRb+NluIOOC6Jq/k5BxFjvGdvxEU4IAU3kDyxU9G1n9fBe4DujgJ0UanLNr03f0vGpCU
         Aeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765725235; x=1766330035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0mFoUQ0HHHHziFRfQItmkm9cx89j3cdlQJJW4CKWdCo=;
        b=bmOxqXtJAZ17ojNkXZhVOGvI4BfmjuKBxQ72v8Fe6tNBw2hpXawUwTdi31PuB0zpdb
         dPsm7cfHCjna8MsMSDXcS01AMWf4Fan3mXnDHhDCioJXG9iNG5RNSdTRKqVgg65svM5C
         GOtaJ9JgT5YwvzxEhzWEzAfcsU5M9r08Anxu1Kodu4SZ+jfmzmp5RmMM5+/uGycc+uyt
         RYochbe0dfl6Xy8T5vmp9ylXvTF6fCH35D8DesW54O04mNDt3dqvNaW/SOvcdN1/L9Du
         gmnz+7DdNujr2ikZgd1QT7H8A0eFT0ycznFLn527mlAvGp+RQTsmdB/f0V7won5Ue7Fm
         ngbg==
X-Forwarded-Encrypted: i=1; AJvYcCVvoLjOjMYmwsPU1xMfosmzNQ4G+Nh/pokX9fbJxlsdrT01lRy1YgGvJ2wUwUJ0HFGbAnXVrkNBQS77Yf2v@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcsticitU+VtmpRfZQHwZbFivtUtvJ3c5lotdfk3M3pruzXyC
	7OqNlcEZQ2z+dShmp9o5GGD6Ud9oSU6VnOV7l5KP1fGGJqdlMHfvBeMfxIb4YFXchZ+6q0l/KH6
	4T/QY8qnPOXydthWXBetXdonKpEIjaX0=
X-Gm-Gg: AY/fxX5MthY8K/QhqY+fU5n8IH/7O2FpEz8bZxupNYia9s8EKyErwlG3eLbnubQ0+N5
	K4YJ5P/6s4Q88asXu94VVFkWZjB72BCkTM40xxiJjVxD/9PGAX5YHq7x2R0NSaNSq3difsl3yYN
	AkpqSm6ACMOC8DpxgPwZasTg/mQ3Vfdfs9VkCuTWF/WbHltErmoQRJ1IP+p5G2uZokgatIhPgKk
	58efTM1ohFNZia5zDltd9MvMw4T1Y5DVqKNN+eV+s/YxzHVuI1g1s+OB/ThokvP6Fo+WtpSFUqX
	ZKEKdM8S3uRyFn0cMI1oaWKa7F+8Cg==
X-Google-Smtp-Source: AGHT+IFqhXw/XhcQxODOTeHTS2eEpfrhctKsvujp1BebDag3S9lcRGYeQ9oe+8mLHZjuE7WDZc/LfsW9dHAbHbOk6Bc=
X-Received: by 2002:a05:6402:d08:b0:645:dc9d:83bc with SMTP id
 4fb4d7f45d1cf-6499b1c18a5mr7220217a12.14.1765725234865; Sun, 14 Dec 2025
 07:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-6-luis@igalia.com>
In-Reply-To: <20251212181254.59365-6-luis@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 14 Dec 2025 16:13:43 +0100
X-Gm-Features: AQt7F2reJam8U7uBVP53PDoYKloJfQ5g2wg2ZEPON5cjMGmN08PbZ8SmHLu6I04
Message-ID: <CAOQ4uxgXdOpr_qYH9hg-nKMLFj06XJP4c1yZ8ZJzCvdCtUok9A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/6] fuse: factor out NFS export related code
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 7:13=E2=80=AFPM Luis Henriques <luis@igalia.com> wr=
ote:
>
> Move all the NFS-related code into a different file.  This is just
> preparatory work to be able to use the LOOKUP_HANDLE file handles as the =
NFS
> handles.
>
> Signed-off-by: Luis Henriques <luis@igalia.com>

Very nice.
Apart from minor nit below, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/Makefile |   2 +-
>  fs/fuse/dir.c    |   1 +
>  fs/fuse/export.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h |   6 ++
>  fs/fuse/inode.c  | 167 +--------------------------------------------
>  5 files changed, 183 insertions(+), 167 deletions(-)
>  create mode 100644 fs/fuse/export.c
>
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 22ad9538dfc4..1d1401658278 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
>
>  fuse-y :=3D trace.o      # put trace.o first so we see ftrace errors soo=
ner
>  fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
 ioctl.o
> -fuse-y +=3D iomode.o
> +fuse-y +=3D iomode.o export.o
>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
>  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index a6edb444180f..a885f1dc61eb 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -190,6 +190,7 @@ static void fuse_lookup_init(struct fuse_conn *fc, st=
ruct fuse_args *args,
>
>                 args->opcode =3D FUSE_LOOKUP_HANDLE;
>                 args->out_argvar =3D true;
> +               args->out_argvar_idx =3D 0;
>

This change looks out of place.

Keep in mind that it may take me some time to get to the rest of the patche=
s,
but this one was a low hanging review.

Thanks,
Amir.

