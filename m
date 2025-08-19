Return-Path: <linux-fsdevel+bounces-58253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D59CB2B868
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C450527BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADC30E0D4;
	Tue, 19 Aug 2025 04:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk51uCSl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE072614
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755578689; cv=none; b=CcVNitA8vogq24s9uM2zISa8fFGvsqzr+CfaPvVQIDLfzrPOmmHw7TTNBircSCKCa36xsOQcLguDScBYNQR29DHuuVcRmg75JxI/cKUugzIvYBQJdH4YafqKNh7ZXXioOzyi7VJxy6lVOCgitRHZGBnMaZJQjWPnTVKICqB8gto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755578689; c=relaxed/simple;
	bh=eme+/wzGg5tK0ATslDtZvYaCfBUHT2Vf3l0cp+skzeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvXQsXm31bq+mjeQifPa2qxbTIVzMVms8r4fwcgUkwKdTP8n4VPZ5hKsEsNwJY39TAkduksv/teVpcG9dCOxpiMH9gSqcUTHymmSWl/OYw+QC+L07yNXDwpHLgYOGPvPaUbWWpVfR3BTWkxgfCjcJtBtsPJxdiLBNysnntd4oRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk51uCSl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445811e19dso38257265ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 21:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755578687; x=1756183487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnBdZnLyD9FDzEWrFnfA32WtfidhQGGaAkYwgkMvvrc=;
        b=dk51uCSlP4bLAZXQnxtxb00rF82QoB+wFK6A1KoFzNlA/bwU2HHZ3U7QQ7nFotbVRa
         zpVLQQIl7M/OmU7LaBbn9TNIdIz+WR4SBIx136xJ+MFNLl5QTX825V7LZeCi4yuPw9GQ
         9uizHUw1lE5LXEkHt46eIi1g8m//R7wwmzy6TAtGfCNtQmD5JAJy+5XGid1kYdsKrkEW
         owz2pRIRZGj3A5sU0jjXHDcqZoKXk93Grdjp4sFG4JN6eVnIwXr1lCCfV1u9Yzr8XF7O
         lR1j3NWFpjQKd5/0nI7NuVOVzPEsYNE7JJCVRyYbtW4RkGVh5EtgOuNjA1Uc0KuIxne8
         dxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755578687; x=1756183487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnBdZnLyD9FDzEWrFnfA32WtfidhQGGaAkYwgkMvvrc=;
        b=OliAkY6cUfxKaRQLdJCWI8KOSdC7rQtSLV6DzV+M23/kIH8wR7Q3aQqdHf+DLCTma6
         w1QisY0oX2txLHT3ROAJbndvWH60JLaE16ZCBOeGCaMrVJ5QnH8CR9wfhpYFpP9ZSHzV
         EdDnviTIpYrpJ+x+2rw/3CAllGQEGvcNcTSEcI1mKRY2mbIt/7nKZl0RM6jJ9zE26hEP
         spEG/FMkdBiV1Da0g1MsHE4tVQiuy6l4cEUYhoxFTUwF7zbzpKJP4e+bNlG/ZMtBBRCF
         dXnrzeUsEciNaVj4VxHSoQ69MMD04d5RgeF6humwE4un3vN1eNkRHogybCqhdQC4qMLO
         dceg==
X-Gm-Message-State: AOJu0YwKJxQ/TNIXTHUPfGQBXuLBjptkN0QIuUu5XuaoNkPDnAk8MP7H
	3aekDDgG+rINOvFVzXp2KYSicH/PsuGLLk2EjMwW6rj7DKizQKmHtCYYGZTX+AplQo6NbWlpLpF
	pP5SGiVKNbTDHF6YdxLcpfBVywSE/932IAAnF
X-Gm-Gg: ASbGncuGsoLOQiblsHsjb3VCr+jbshtpq6UE4dQIn8pe6rX5O9X0l/+mmbpKFG3h+cq
	FUBQv0RHL6zX43U3rjZSZ34Q3A5KDhPGe4iNQAA5U64pA2ZXTD7K7rSBIEjYQzkNVxPSFjikdpo
	+oJfmbUjVZPn56L4FvMK6tEoyUk6izy487ny1rAPpJRlj54PnrGQeiwDxtm889J+wQSTnWp0G0M
	RpV1Dwk+Q==
X-Google-Smtp-Source: AGHT+IFRoYNrGZsi78ioi0D/IyQNl6mT1EWrUhzkfH/dvDYP0fVTtAK98mGRRccPKMID7Qr/YTFbLde3DIE6EIaja3U=
X-Received: by 2002:a17:903:37c4:b0:243:963:2a70 with SMTP id
 d9443c01a7336-245e048a9f1mr14611455ad.25.1755578687001; Mon, 18 Aug 2025
 21:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815233316.GS222315@ZenIV> <20250815233524.GC2117906@ZenIV>
In-Reply-To: <20250815233524.GC2117906@ZenIV>
From: Pavel Tikhomirov <snorcht@gmail.com>
Date: Tue, 19 Aug 2025 12:44:35 +0800
X-Gm-Features: Ac12FXzAQuo3hTgCER1URccqXqXp8Y_LOHY1xTS5wXIfynfK9R8AvNsPuJo1JYo
Message-ID: <CAE1zp778Z+YiwXD2hNV-P94rtJAkgZSTzTj6pmu74DL4SLqC=g@mail.gmail.com>
Subject: Re: [PATCH 3/4] use uniform permission checks for all mount
 propagation changes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, "Lai, Yi" <yi1.lai@linux.intel.com>, 
	Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good! Thanks!

Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Tested-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
(CRIU tests PASS for the whole patchset)

On Sat, Aug 16, 2025 at 7:35=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> do_change_type() and do_set_group() are operating on different
> aspects of the same thing - propagation graph.  The latter
> asks for mounts involved to be mounted in namespace(s) the caller
> has CAP_SYS_ADMIN for.  The former is a mess - originally it
> didn't even check that mount *is* mounted.  That got fixed,
> but the resulting check turns out to be too strict for userland -
> in effect, we check that mount is in our namespace, having already
> checked that we have CAP_SYS_ADMIN there.
>
> What we really need (in both cases) is
>         * we only touch mounts that are mounted.  Hard requirement,
> data corruption if that's get violated.
>         * we don't allow to mess with a namespace unless you already
> have enough permissions to do so (i.e. CAP_SYS_ADMIN in its userns).
>
> That's an equivalent of what do_set_group() does; let's extract that
> into a helper (may_change_propagation()) and use it in both
> do_set_group() and do_change_type().
>
> Fixes: 12f147ddd6de "do_change_type(): refuse to operate on unmounted/not=
 ours mounts"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1c97f93d1865..88db58061919 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2859,6 +2859,19 @@ static int graft_tree(struct mount *mnt, struct mo=
unt *p, struct mountpoint *mp)
>         return attach_recursive_mnt(mnt, p, mp);
>  }
>
> +static int may_change_propagation(const struct mount *m)
> +{
> +        struct mnt_namespace *ns =3D m->mnt_ns;
> +
> +        // it must be mounted in some namespace
> +        if (IS_ERR_OR_NULL(ns))         // is_mounted()
> +                return -EINVAL;
> +        // and the caller must be admin in userns of that namespace
> +        if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
> +                return -EPERM;
> +        return 0;
> +}
> +
>  /*
>   * Sanity check the flags to change_mnt_propagation.
>   */
> @@ -2895,10 +2908,10 @@ static int do_change_type(struct path *path, int =
ms_flags)
>                 return -EINVAL;
>
>         namespace_lock();
> -       if (!check_mnt(mnt)) {
> -               err =3D -EINVAL;
> +       err =3D may_change_propagation(mnt);
> +       if (err)
>                 goto out_unlock;
> -       }
> +
>         if (type =3D=3D MS_SHARED) {
>                 err =3D invent_group_ids(mnt, recurse);
>                 if (err)
> @@ -3344,18 +3357,11 @@ static int do_set_group(struct path *from_path, s=
truct path *to_path)
>
>         namespace_lock();
>
> -       err =3D -EINVAL;
> -       /* To and From must be mounted */
> -       if (!is_mounted(&from->mnt))
> -               goto out;
> -       if (!is_mounted(&to->mnt))
> -               goto out;
> -
> -       err =3D -EPERM;
> -       /* We should be allowed to modify mount namespaces of both mounts=
 */
> -       if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +       err =3D may_change_propagation(from);
> +       if (err)
>                 goto out;
> -       if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +       err =3D may_change_propagation(to);
> +       if (err)
>                 goto out;
>
>         err =3D -EINVAL;
> --
> 2.47.2
>

