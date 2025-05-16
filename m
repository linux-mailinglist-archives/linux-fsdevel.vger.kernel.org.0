Return-Path: <linux-fsdevel+bounces-49279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28067AB9FE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00E8500250
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11BE1B4F09;
	Fri, 16 May 2025 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/cAL7Kz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F27D07D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409560; cv=none; b=f5soIoX8JdTuMpIykE+UNOacwFUBHGq/StWqgQhCpPEb+gx3fn3hsCFe2IbRVwDEWRDGgHU/xb5X+Z294cQeUPduCZuPyGMlHsp6hRdy3Nu+I4Od5k4/4oVgaHEgrxikVB53Ztc1qzuLRkx7KlbH+qtD1D7c5ebGmMgeR1W1H8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409560; c=relaxed/simple;
	bh=5c4FndS0FPBIofzOdmVNQxOEMt/DgaERRWId9DFnmFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGTPo3O8NnnJ1b6lN92wonbN6ADeVZWAHzcTXERMKt2FLKVanrLc5UAYRYR81sxhiQSCtxBeUQ2w0xwFn6vYwZPoCefYyzIvlXC9ZnqbdP3rWC7FXYj/S37bsBWKG1XPc7fl2YcYUdsQ7SlelYwxd+sSIjpDjYj87QapmfWnXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/cAL7Kz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad2452e877aso339334866b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747409557; x=1748014357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnZktM+CotQBLFaFb+IyVyAJfg4YceN9GS4oeMLwC4s=;
        b=Z/cAL7Kz2araBozREAAs0ZNp3SyKe3KCpQYGWQCg5/AM82WJxHPbizzbefZGFt44h+
         GTLCR7h7/kTCjOf49loYFgGBhqbLbEpeuzLZT7hJ7rAkqqiUAQZGmnFj7RkvgDGx4ogg
         JSVOwopYnuS8C1Plg35rmTkezXK0su28/BxFBiYLKk036YJbiaVDW1DX7MYnAAXCNbEq
         XhhFUfGydFYzU7anQntRp0bIyV3fEMY7fX+zdvdU9ZclkNWzlzM8dIQEUjzSBibtv2Z3
         MhKZNj//aEKJjdnmKE0XlIaxkZhMuwREJrK5u3NOlK+rfkvoCmvQS8yBQmhQQz1P81L0
         xWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747409557; x=1748014357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnZktM+CotQBLFaFb+IyVyAJfg4YceN9GS4oeMLwC4s=;
        b=RIgegyBukw9asbcGiE8NCayyWMH0Nfi48B1Eis1rsRk8rn+UqZSCvoswGInlR/Suv4
         6QNr5ynNsP7fUeF2YHLClmkkjl6kUom8qKaj/5umorREfrlO+qZM0gghNJeMosrSsYLb
         H0CQahYRwjjO8Na02XvI2rVm0e98KJkJ46s2OncNkqUN4xf5isJb1bVStMk0YPLZ8q0N
         rUqp7obqUhqED0BDubPtd+AAoyNg6QKpAwrRlWNJEy2ob9TuAX6ytKXgF+4tAXtBkRRC
         an/+gUTo/uxPahrfDjYZl/gEegFP/krJpoUDYCGnEbLCLszDSUxtkM1T0UxDLXJxdu5g
         UMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNY/ZX1h2nxKzZZ/fBZGgFxJpzH+TbQPIw8XHU+4jSU6grbxq7n4Oed6+zaE4Z2K/ZIm6WYU17GCp4Cke/@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiqOGmQrdonZH6lu/yklPafG3VnrWqADLA9kIFf/pufNqcXfB
	FWk53wDU4HKvcO3Sz5dAwEkFVfR1taFOs0tKDzZmtUhN/76/BVqcOIIZ8wKpPzK1uBTGNhbJPII
	x/9nKA9uKvP1vdA0a5/NV3QV8xBSGbFM8yXdg95Cavg==
X-Gm-Gg: ASbGncu5y3/m75La+uDZWTh83v3DHSxw+f+0/8E0FqO6VVuEBcNENt1mmC2kCPwEPGM
	FMhTb4SYLZVzMkfLpWNk4yhIM9wnqSYwClL86zoi5YnikN3klWzYhyL7s7CJbCex5gNoBF8Vv/j
	mayTQw/y4UTg5GfUPjVwIsL5oIkKeEeEogKjjNPEwFG+s=
X-Google-Smtp-Source: AGHT+IHVeCrhZf29cvgvq5PIXSuEET2HDdaI5oz1ivkVZFbAEgwSpeiE5pBhpEi0pBiu9ooEbEV8L+YC3hc/7Pilb4E=
X-Received: by 2002:a17:907:7fa1:b0:ad5:24ee:515d with SMTP id
 a640c23a62f3a-ad536bca810mr311476866b.27.1747409556625; Fri, 16 May 2025
 08:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com> <20250419100657.2654744-3-amir73il@gmail.com>
 <CAJfpeguGj0=SmmD3uLECgByh1rOHA+Gp3tbsxsga0K3ay2ML_Q@mail.gmail.com>
In-Reply-To: <CAJfpeguGj0=SmmD3uLECgByh1rOHA+Gp3tbsxsga0K3ay2ML_Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 May 2025 17:32:24 +0200
X-Gm-Features: AX0GCFuCWNlUW4W_TchuOootPFeXPYXzX-L2_rNO-Gxgm2_kuo6_y9EBZOTvQS0
Message-ID: <CAOQ4uxi98+Bng+gPWNDhgGdJvYXHoWx5cn7iWEYgE5x4fon+yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: support watching filesystems and mounts
 inside userns
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 3:22=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sat, 19 Apr 2025 at 12:07, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > @@ -1987,12 +1988,27 @@ static int do_fanotify_mark(int fanotify_fd, un=
signed int flags, __u64 mask,
> >                 obj =3D inode;
> >         } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
> >                 obj =3D path.mnt;
> > +               user_ns =3D real_mount(obj)->mnt_ns->user_ns;
> >         } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
> >                 obj =3D path.mnt->mnt_sb;
> > +               user_ns =3D path.mnt->mnt_sb->s_user_ns;
>
> The patch header notes that user_ns !=3D &init_user_ns implies
> FS_USERNS_MOUNT, but it'd be nice to document this with a WARN_ON() in
> the code as well.
>

Can't do that because the commit message is wrong...
An sb *can* have non-init s_user_ns without FS_USERNS_MOUNT
if the mounter was running in non-init user ns, but had CAP_SYS_ADMIN
in init_user_ns.

Maybe not a very likely use case, but still cannot be asserted,
so we better remove the (*FS_USERNS_MOUNT*) remark
from comment and commit message.

> >         } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) {
> >                 obj =3D mnt_ns_from_dentry(path.dentry);
> > +               user_ns =3D ((struct mnt_namespace *)obj)->user_ns;
>
> It would be much more elegant if the type wasn't lost before this assignm=
ent.

True.
We can make it:

        struct mnt_namespace *mntns =3D mnt_ns_from_dentry(path.dentry);
        user_ns =3D mntns->user_ns;
        obj =3D mntns;

>
> Otherwise looks good:
>
> Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
>

Thanks for the review!

Amir.

