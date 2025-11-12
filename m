Return-Path: <linux-fsdevel+bounces-68053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B2C51FA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56EA3AC3B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867BA30DD0E;
	Wed, 12 Nov 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqre9r0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CABA45
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946425; cv=none; b=GgxroG85CFuW22PpD/Ct5NVdRQRjnhJ5YODkOo3lM03YGLduG1uJL4/u2AvAlvlyehwNkn11U7uZernrSuGOWSQ7+c0StFJOpEd1o59UpnhUkBvor0tWMoIbyZiaqvyp3BpCItzn4c6iA8H7F898s6YlMDk9J0ZK1x/KG1DooBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946425; c=relaxed/simple;
	bh=Knk4ujiX8WU3ociFntVm9Iw7JEzNqyZTnRUVewgSDYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjFmD1xnrGfFXnzvyhUrcPkH2GrhlNRx5VGyLAQrxRqtImdHfn6vVSDyw36ePqrfcaWfHSMe2EKJeNf1vZoPBeDcq0TnV5ELpRjXhifKYTtGKlCijr2dvhzcXbV4zLrV/bK7xlNf1cqOlvS8LmJApEOMU0kFle9PlA8DbLxGCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqre9r0n; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b472842981fso101263966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946422; x=1763551222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN5e9QaZYINqmL7C9pPTFE+y1JKslvRnzLuWM0BGZbs=;
        b=Wqre9r0nbPJ+Mor7ePhdXLd2pq+ceduhqCftS3bn2fVMIGVTVRF0QT76IFD7SlcCkv
         A8E9XBmVoWk5qXlCCyk489w9yMdDdGUZh7JxN5l8Dzsjgyaad1VSZmELBE/DmvwTtSne
         8BeeFrnTfb2PAdJ/WT71446uRw8I8pmgrpczQj34uKKnS/AKYJXdGPgcpgRKDP8bFABV
         MHQiXu6uy+jbQ+1IH5Vp4kgyjDRTI/3T/t0L1AW2OYBT29dIJlSJgTJrTFaXwR9rym8C
         J+lrXSTxcPddFlv4MomLqIr0SuumIc4g69UFO1fc7pKuSYU+CaXGYPPRvhOrx736r9HC
         HPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946422; x=1763551222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN5e9QaZYINqmL7C9pPTFE+y1JKslvRnzLuWM0BGZbs=;
        b=jbbjBpD++wO4QWQd2MdFlmfDK99kcgx/z4dkvz8Rwmo5hxaLNv7Pq0myVB/Ald374O
         W/ijVY1MOxjeXkRmDtag6ccWmrU/ZsplrM5crM8vIvUJ47UYBAtmoZrXptv0czimNTvG
         AaWgWxSVuU33dX3kh49SeAKrp1lJTljhc7inzIHh2GPJTq/16pnvtTTTg+a2T2DKdk+v
         cbQJnY/wbglnIr09w80NjprPeURBVmvuaVTd1Pk1iSG4bqWynicCiB+JIofeTcCNR3VR
         gDOdRrR7CU2q1qTsmy0J8G5bdyTCONML5l1NBUoRCaC15AHzgQwn41P6bmVKNyop0YmB
         oiig==
X-Forwarded-Encrypted: i=1; AJvYcCW4DTMeXMJJOEj708+CT2Bagf9zilszhqLCrLYfZAAWk50GFVSkmVV7+IUt40FJdQwOS2xSRL7XL1p7W6Aw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc00dhU5l5jWAijgffVJHrRXW0bpRW4oii2+jIecGcPzdSmbjl
	RNv8gLmh1NpHOgwiHM0p8H8r0nNtoljPsPtghhCxWlk4Z3eB1tfDlh8zbpvmGUFF58Sm6Hfslls
	ccEObSTFqWGsbPhipd/01rZ1IbY3fmvE=
X-Gm-Gg: ASbGncvDmU60KeSDp0BAdQ2aLnPUezIKtp+MsbvA0JLMPsHcAlwh+sPx2InGjiU8fy0
	72W5zldyYiufdp61HUhIesV1FvZ2Bq7Z2gNgrbPjVlLrbXO4F6Q53pGD4oTxFpXFWK29BZjsKx8
	pR00m6/jjdFSbvYdqDi2RGCXUHvMnizsB/9bqRXwZ9qFw2oRt8gda5o8MQLhkDCKf4Zjnmu5jWN
	qKwco1wW8W6OvIWxLdvPVIyh+4jd7Cxujcy2RvFTAckakeI2dpU97fbyFEKNkJ1S1R466YPLkKN
	Saqhsb6K6/+9Dls=
X-Google-Smtp-Source: AGHT+IGNDAdeHAQwBdFpSJaoXJQGx7YCs8ZG107WfxsSGbmCdnZGEiPXex/Kcl5wI14bSDYMkO03S1ZtjbAfCbwDU28=
X-Received: by 2002:a17:906:dc89:b0:b72:62ca:d30c with SMTP id
 a640c23a62f3a-b7331ae8aabmr220157266b.59.1762946421421; Wed, 12 Nov 2025
 03:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105150630.756606-1-mjguzik@gmail.com>
In-Reply-To: <20251105150630.756606-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 12 Nov 2025 12:20:09 +0100
X-Gm-Features: AWmQ_bl9yil3WTlUosVOtwjPuwRCiZJUwpRvvlkwPbgkU3BJnU4rSe9g5zyKIgY
Message-ID: <CAGudoHFNDC_5=T3XKLzNpsMkZYaf_KbjHrL36rc0YWDWaJMS_w@mail.gmail.com>
Subject: Re: [PATCH] fs: touch up predicts in path lookup
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

any opinions on this one

On Wed, Nov 5, 2025 at 4:06=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> Rationale:
> - ND_ROOT_PRESET is only set in a condition already marked unlikely
> - LOOKUP_IS_SCOPED already has unlikely on it, but inconsistently
>   applied
> - set_root() only fails if there is a bug
> - most names are not empty (see !*s)
> - most of the time path_init() does not encounter LOOKUP_CACHED without
>   LOOKUP_RCU
> - LOOKUP_IN_ROOT is a rarely seen flag
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 39c4d52f5b54..a9f9d0453425 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -951,8 +951,8 @@ static int complete_walk(struct nameidata *nd)
>                  * We don't want to zero nd->root for scoped-lookups or
>                  * externally-managed nd->root.
>                  */
> -               if (!(nd->state & ND_ROOT_PRESET))
> -                       if (!(nd->flags & LOOKUP_IS_SCOPED))
> +               if (likely(!(nd->state & ND_ROOT_PRESET)))
> +                       if (likely(!(nd->flags & LOOKUP_IS_SCOPED)))
>                                 nd->root.mnt =3D NULL;
>                 nd->flags &=3D ~LOOKUP_CACHED;
>                 if (!try_to_unlazy(nd))
> @@ -1034,7 +1034,7 @@ static int nd_jump_root(struct nameidata *nd)
>         }
>         if (!nd->root.mnt) {
>                 int error =3D set_root(nd);
> -               if (error)
> +               if (unlikely(error))
>                         return error;
>         }
>         if (nd->flags & LOOKUP_RCU) {
> @@ -2101,7 +2101,7 @@ static const char *handle_dots(struct nameidata *nd=
, int type)
>
>                 if (!nd->root.mnt) {
>                         error =3D ERR_PTR(set_root(nd));
> -                       if (error)
> +                       if (unlikely(error))
>                                 return error;
>                 }
>                 if (nd->flags & LOOKUP_RCU)
> @@ -2543,10 +2543,10 @@ static const char *path_init(struct nameidata *nd=
, unsigned flags)
>         const char *s =3D nd->pathname;
>
>         /* LOOKUP_CACHED requires RCU, ask caller to retry */
> -       if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) =3D=3D LOOKUP_CACHED)
> +       if (unlikely((flags & (LOOKUP_RCU | LOOKUP_CACHED)) =3D=3D LOOKUP=
_CACHED))
>                 return ERR_PTR(-EAGAIN);
>
> -       if (!*s)
> +       if (unlikely(!*s))
>                 flags &=3D ~LOOKUP_RCU;
>         if (flags & LOOKUP_RCU)
>                 rcu_read_lock();
> @@ -2560,7 +2560,7 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>         nd->r_seq =3D __read_seqcount_begin(&rename_lock.seqcount);
>         smp_rmb();
>
> -       if (nd->state & ND_ROOT_PRESET) {
> +       if (unlikely(nd->state & ND_ROOT_PRESET)) {
>                 struct dentry *root =3D nd->root.dentry;
>                 struct inode *inode =3D root->d_inode;
>                 if (*s && unlikely(!d_can_lookup(root)))
> @@ -2579,7 +2579,7 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>         nd->root.mnt =3D NULL;
>
>         /* Absolute pathname -- fetch the root (LOOKUP_IN_ROOT uses nd->d=
fd). */
> -       if (*s =3D=3D '/' && !(flags & LOOKUP_IN_ROOT)) {
> +       if (*s =3D=3D '/' && likely(!(flags & LOOKUP_IN_ROOT))) {
>                 error =3D nd_jump_root(nd);
>                 if (unlikely(error))
>                         return ERR_PTR(error);
> @@ -2632,7 +2632,7 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>         }
>
>         /* For scoped-lookups we need to set the root to the dirfd as wel=
l. */
> -       if (flags & LOOKUP_IS_SCOPED) {
> +       if (unlikely(flags & LOOKUP_IS_SCOPED)) {
>                 nd->root =3D nd->path;
>                 if (flags & LOOKUP_RCU) {
>                         nd->root_seq =3D nd->seq;
> --
> 2.48.1
>

