Return-Path: <linux-fsdevel+bounces-51181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C0AAD40DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 19:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798BC179D4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAD24397A;
	Tue, 10 Jun 2025 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceJ3xECC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51E2441A0;
	Tue, 10 Jun 2025 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576397; cv=none; b=WNuGA+dlhRqtd3cjJSb392xxM1eoS+78bnh2ZQQAdtycvSnE7KnbWZ6s/Di7LrtsirQx2mW0For5CUOdgX4L1HS30y3bQLV0/gjk1X9TEM9Tw2ociWvoiO5hLxVFCnDIMQrCzlnbOSpLU0CyL3/0o4sz3zyo69CPS/taCsKlb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576397; c=relaxed/simple;
	bh=f64BzYbWwrcswaFdSrDpPjRWyUJjPC8m2gBNkU6g2pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+bV/+d6ZtrSbloYk8GpaRZNEuI3LtqwuhkKXPiGwyYv3g3dvQdUji4tHQtFIj0Vr7BzTmgUghRGqCbR1Ih8wT5IGzU5kPw553Qv3V9LpjCkhJ0hDKdBmOYjv4iqzHP11oxjcEWJsgnvI/pGu3g66ESXDVz/2+mYPDDE8azaFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceJ3xECC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD601C4CEF0;
	Tue, 10 Jun 2025 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749576396;
	bh=f64BzYbWwrcswaFdSrDpPjRWyUJjPC8m2gBNkU6g2pU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ceJ3xECC0Kl+gtIZbbu8XnZ3pFCDr5UfOPXrAgHFnsL9LU0utUKP2JU6SPJkKT+lH
	 hNazbcpD7ejB21Gnk4A3fPHS2HJOZnPUnW3aRujkfGNJdctyvZ1LSGXT5RPRDebug1
	 nZxCC0HO9vpuISQVZYTy3SmbdKufXm40oryTNOFpJJVPtIxAbI3sUurAhFPi0GpgET
	 DdPFPGnxq900KRutkNRaCnFrQ6RHhtl5DURkP18dOHKylpTn4kExBH2zgbJeRfcFne
	 hvJRTiDz+mXBvLeMElfLcTeuBAoq/dY84NkQX+3SsKNSI19ixpAPFnfjwoc0bdAagm
	 S0zfKQWozkrZQ==
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58c2430edso781711cf.1;
        Tue, 10 Jun 2025 10:26:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqJgqZ5X0wjqevfxG6yfu/ec0OayOIjoppJNRMdd+l4T7cszkOkFpcimMrTOLEyH1udy2GBn4oGxTGssLa@vger.kernel.org, AJvYcCWuOhQUJrPRyNY7ZVUiS2LojfR5XhAhZrlKl1HHokoj6rOGzvUNlPpeWWwJ1KW4TWZBnjO1gowDoL+aRDE/@vger.kernel.org, AJvYcCXqcxFeFFavN6eMvQZwQnN52JIL3egnCSXnC0Prz5ofwF+3pUJXbSL2qWvVdkiiIWxuHqXKdxRAeWd42ZXr8rA3664HrKyG@vger.kernel.org
X-Gm-Message-State: AOJu0YzNtLjx+0GEGBu0fgeDIGoqPTWeIqga94aHj35VITuZ4dOodCig
	VOelO0VKi8wlNGBbDrO+YR3iEaDK5NYYL/zQ7gVu8hV9iNauSTm/WGf2P8X+Ci025yJPyL004r4
	Zu1V0X2weYQbyGr1qrgOCSPAY7esWPyA=
X-Google-Smtp-Source: AGHT+IGFc2+k1iCnhuGoGqscF+tifHIl1pEkK+0lLMlrzW9eFNzUpsFwybkLvs3KvX7SPR8qouSN1Qa2cBTv6F08xjA=
X-Received: by 2002:ac8:5cc9:0:b0:4a6:fac6:fa1e with SMTP id
 d75a77b69052e-4a713bf27cdmr4370421cf.8.1749576384973; Tue, 10 Jun 2025
 10:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606213015.255134-1-song@kernel.org> <20250606213015.255134-2-song@kernel.org>
 <20250610.rox7aeGhi7zi@digikod.net>
In-Reply-To: <20250610.rox7aeGhi7zi@digikod.net>
From: Song Liu <song@kernel.org>
Date: Tue, 10 Jun 2025 10:26:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5G0Th+9dRSmxDjo5E7CxV1E9N8AiKjw3cKyEhOBVWJFw@mail.gmail.com>
X-Gm-Features: AX0GCFtlUudIDDILbjkSliTETHB9ADLDpGB_tREWEmJbKZ4UGEbktaZJBtiHTAs
Message-ID: <CAPhsuW5G0Th+9dRSmxDjo5E7CxV1E9N8AiKjw3cKyEhOBVWJFw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 10:19=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> On Fri, Jun 06, 2025 at 02:30:11PM -0700, Song Liu wrote:
> > This helper walks an input path to its parent. Logic are added to handl=
e
> > walking across mount tree.
> >
> > This will be used by landlock, and BPF LSM.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  fs/namei.c            | 51 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/namei.h |  2 ++
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 4bb889fc980b..f02183e9c073 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1424,6 +1424,57 @@ static bool choose_mountpoint(struct mount *m, c=
onst struct path *root,
> >       return found;
> >  }
> >
> > +/**
> > + * path_walk_parent - Walk to the parent of path
> > + * @path: input and output path.
> > + * @root: root of the path walk, do not go beyond this root. If @root =
is
> > + *        zero'ed, walk all the way to real root.
> > + *
> > + * Given a path, find the parent path. Replace @path with the parent p=
ath.
> > + * If we were already at the real root or a disconnected root, @path i=
s
> > + * not changed.
> > + *
> > + * The logic of path_walk_parent() is similar to follow_dotdot(), exce=
pt
> > + * that path_walk_parent() will continue walking for !path_connected c=
ase.
> > + * This effectively means we are walking from disconnected bind mount =
to
> > + * the original mount. If this behavior is not desired, the caller can=
 add
> > + * a check like:
> > + *
> > + *   if (path_walk_parent(&path) && !path_connected(path.mnt, path.den=
try)
> > + *           // continue walking
> > + *   else
> > + *           // stop walking
> > + *
> > + * Returns:
> > + *  true  - if @path is updated to its parent.
> > + *  false - if @path is already the root (real root or @root).
> > + */
> > +bool path_walk_parent(struct path *path, const struct path *root)
> > +{
> > +     struct dentry *parent;
> > +
> > +     if (path_equal(path, root))
> > +             return false;
> > +
> > +     if (unlikely(path->dentry =3D=3D path->mnt->mnt_root)) {
> > +             struct path p;
> > +
> > +             if (!choose_mountpoint(real_mount(path->mnt), root, &p))
> > +                     return false;
> > +             path_put(path);
> > +             *path =3D p;
> > +     }
> > +
> > +     if (unlikely(IS_ROOT(path->dentry)))
>
> path would be updated while false is returned, which is not correct.

Good catch.. How about the following:

bool path_walk_parent(struct path *path, const struct path *root)
{
        struct dentry *parent;
        bool ret =3D false;

        if (path_equal(path, root))
                return false;

        if (unlikely(path->dentry =3D=3D path->mnt->mnt_root)) {
                struct path p;

                if (!choose_mountpoint(real_mount(path->mnt), root, &p))
                        return false;
                path_put(path);
                *path =3D p;
                ret =3D true;
        }

        if (unlikely(IS_ROOT(path->dentry)))
                return ret;

        parent =3D dget_parent(path->dentry);
        dput(path->dentry);
        path->dentry =3D parent;
        return true;
}

Thanks,
Song

