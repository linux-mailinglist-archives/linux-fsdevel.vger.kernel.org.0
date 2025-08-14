Return-Path: <linux-fsdevel+bounces-57950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3399CB26F45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1068B7A8D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78185225791;
	Thu, 14 Aug 2025 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZJnIokI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82721256C;
	Thu, 14 Aug 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197297; cv=none; b=s4JrNRCaCXnITgCQu8y+BI2zH2Ts372AUNOqB7FeGk87B3KdFl6IUfVcbmLum2AidH8x2k31FbYjyAUEtBHdspmmQJTJ9EtkgRYaWyS5KSscd0HNuXel9OMvT+roztXHpmoNniuYhInx2NaqpFndJzCPAfwmYUgA7/mYw6MOORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197297; c=relaxed/simple;
	bh=Ai0W7+FAaOOFezzPMPnsCxJmABCXV+znFREwbAviLH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKtntELG3saGTB920DT4w6vVIAJkRL9LwaH/VPAQHvlH3QwafY8BEq6nQ2EKPQRIHi/jQIUUTT1aOHvR7oGSQqlgFYB+jsQmRlu6pBvMBpMCqjANSl8qy8nlTYJC7paNpjcJVNEM9OVddvEvvw5FmaIdlJH3mZkxMpglv9CMmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZJnIokI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b654241so2487784a12.1;
        Thu, 14 Aug 2025 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197294; x=1755802094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOtwjOkDxIVqzxAKEv8z+PYK53kblfl7qoelNql2SS8=;
        b=DZJnIokI64RmEllvzigW4JWT+mRi970x+T5npvQ60GdmNS3zFWsHStd7QUWWX+5EUi
         I8Y2bKqqbWJbS6k6QEOprZRmBxzLs8+VJB60w2bxRSCqKQPIDobOoWkG8/uEMdQQUfdw
         FOj/g7VU17WAOu0bqmbYHO4QNxO0Owf/12a1kCM2isnFAc1vDsa/ar6y3d6uwcVUJXxa
         dTjhVOvFas77O0WXh80xDKPQy9dLrzF39p5xWb9IeiDQf0G0a2rS+QnGctzwuKcf16fU
         8TWyq+MnFCis5dS3Bh0UWIGikec9Zn/ceReW/0i65tVkz0g9YMZp/XfnoMvhfnvbKh7r
         irVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197294; x=1755802094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOtwjOkDxIVqzxAKEv8z+PYK53kblfl7qoelNql2SS8=;
        b=VAzyOM4RTP82uIqXeopESXn7SNOjmOMIZ+pReeapWAm1TNHZgd9H+h2bvGECGUIxra
         5iIPzuLeDf2iYOb+4t0hvkPvjI+xVukIwSxe2iQG2C0it/JkUIfkS7b5GRPZ/nD4Q4li
         n79L0cVefIf6mFJRWUZ8P0YSmjHbGOdhYxVYC+MltN87Cacx6iCdYzlBTI9L5V0AWkvS
         ErG4tG6NnxfMX71Nfoc9QZueK9g6R7JfHMhiFPMk8DYzJe+zC7zz7UO+JnQOasgCoL/o
         clGtc+1t8B0zrvqrCOlbYjxVYpky7X+JgfFYnSNfkT6jK+JQ7Ccj6pXgA4XOP3BgkLP3
         btVA==
X-Forwarded-Encrypted: i=1; AJvYcCVuLGLAo53q9Q9G8S0arADRLwu6Mb674qpQFyleFNSqsvurbPrTecIrlKbGk0Flfzx864QGzNDQM50pLLEXVw==@vger.kernel.org, AJvYcCWhQ+Yq69EFmM67obGyyIenBF9mnROoSvtP6veD5VE8wO9B75JCXask3szdW36ZlfgrXmO9egsH/4v8QV/A@vger.kernel.org, AJvYcCWnKD6xiOSzS/cmFMepcoe5x/gSk4lCuBf5+LKqfTR0zLdrddkYe0osIRmSkWw2XGQ/VsHnQo46GzORsXFE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9kBpwzErXHjsGGra4e1LimL8U+z/kxDp243aKKCaxb4k2Boyy
	ZQyFPn++TPfgNjaHL64BiTEmVVmoz+FxNMht6/m39+wRa0KshcIAQ04klN/D7hVZvT+qdtf7+lH
	cK3eeqlsCcUnum91VNIdksQ7qSgCJhPY=
X-Gm-Gg: ASbGncv6jB2WNFrgiFrFYF3MFd9BD9Dc4S32PQNAufVfxzuP2HfTxJyS9I/4D+E6a3P
	MmasD9r+etX9znuxsk1lyUNzWg0XWxwIduBR67W8Jo4jaSTpJMBN3RCoSO8bn6NS4wUjZl+73rm
	gOiZqCn3m9BVGtV1Hqhx5/qY1+bRTA0JR5WG9PaG40tcA8x0mpd7evUUHPIR9tVrSqAiujyZWlJ
	jmljxo15VUER4aRyg==
X-Google-Smtp-Source: AGHT+IFL0wawxZk4lGLrl6D0QP8iZIQwJ0flsaXMrJKZmkxfnNWk1VZVh4Fahc9KTSy5IwRVtKoD87DjiFQ0Fp2XAlo=
X-Received: by 2002:a17:907:9408:b0:af9:341b:7fd7 with SMTP id
 a640c23a62f3a-afcb9924a6dmr411078066b.49.1755197294085; Thu, 14 Aug 2025
 11:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com> <20250814-tonyk-overlayfs-v5-9-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-9-c5b80a909cbd@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 20:48:02 +0200
X-Gm-Features: Ac12FXwwTvmneC7ialuGsuW1gPmUKKs5_FF2nu3gQDO94y86on7WSa27B71wcHU
Message-ID: <CAOQ4uxiERO5g0RoG3s13jV6OfoqySt4pXfvOTPy+rbLwvfjOdQ@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] ovl: Support mounting case-insensitive enabled layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:22=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Drop the restriction for casefold dentries lookup to enable support for
> case-insensitive layers in overlayfs.
>
> Support case-insensitive layers with the condition that they should be
> uniformly enabled across the stack and (i.e. if the root mount dir has
> casefold enabled, so should all the dirs bellow for every layer).
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes from v4:
> - Move the dentry_weird relaxation to this patch
> - Reword the commit title and message
>
> Changes from v3:
> - New patch, splited from the patch that creates ofs->casefold
> ---
>  fs/overlayfs/namei.c | 17 +++++++++--------
>  fs/overlayfs/util.c  |  8 ++++----
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 76d6248b625e7c58e09685e421aef616aadea40a..e93bcc5727bcafdc18a499b47=
a7609fd41ecaec8 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -239,13 +239,14 @@ static int ovl_lookup_single(struct dentry *base, s=
truct ovl_lookup_data *d,
>         char val;
>
>         /*
> -        * We allow filesystems that are case-folding capable but deny co=
mposing
> -        * ovl stack from case-folded directories. If someone has enabled=
 case
> -        * folding on a directory on underlying layer, the warranty of th=
e ovl
> -        * stack is voided.
> +        * We allow filesystems that are case-folding capable as long as =
the
> +        * layers are consistently enabled in the stack, enabled for ever=
y dir
> +        * or disabled in all dirs. If someone has modified case folding =
on a
> +        * directory on underlying layer, the warranty of the ovl stack i=
s
> +        * voided.
>          */
> -       if (ovl_dentry_casefolded(base)) {
> -               warn =3D "case folded parent";
> +       if (ofs->casefold !=3D ovl_dentry_casefolded(base)) {
> +               warn =3D "parent wrong casefold";
>                 err =3D -ESTALE;
>                 goto out_warn;
>         }
> @@ -259,8 +260,8 @@ static int ovl_lookup_single(struct dentry *base, str=
uct ovl_lookup_data *d,
>                 goto out_err;
>         }
>
> -       if (ovl_dentry_casefolded(this)) {
> -               warn =3D "case folded child";
> +       if (ofs->casefold !=3D ovl_dentry_casefolded(this)) {
> +               warn =3D "child wrong casefold";
>                 err =3D -EREMOTE;
>                 goto out_warn;
>         }
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index a33115e7384c129c543746326642813add63f060..7a6ee058568283453350153c1=
720c35e11ad4d1b 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -210,11 +210,11 @@ bool ovl_dentry_weird(struct dentry *dentry)
>                 return true;
>
>         /*
> -        * Allow filesystems that are case-folding capable but deny compo=
sing
> -        * ovl stack from case-folded directories.
> +        * Exceptionally for casefold dentries, we accept that they have =
their
> +        * own hash and compare operations
>          */
> -       if (sb_has_encoding(dentry->d_sb))
> -               return IS_CASEFOLDED(d_inode(dentry));
> +       if (ovl_dentry_casefolded(dentry))
> +               return false;
>
>         return dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE);
>  }
>
> --
> 2.50.1
>

