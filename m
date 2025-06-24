Return-Path: <linux-fsdevel+bounces-52746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F9AE62EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74573B0208
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DDA28540E;
	Tue, 24 Jun 2025 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNhdahwb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3408223704;
	Tue, 24 Jun 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762418; cv=none; b=oHLr1+0NW6A8qY/PtPqWHyn+Y7JELZDS+XiihWzhDDs3Pgl/vVc/oUtU2LnezmYehReeE9hohlXIvQ3nfsFwj9H4PzL6GAxKNT2OqNl/jAsvji6etdK63ljOFPdVVho5LB/zNnActgKnrKL/uruvoJL54mw6cS8/uQJQRaxQPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762418; c=relaxed/simple;
	bh=45nk+8zGQtLrYGgqO86tfw2+k3rD/oNMKk9MezrSvJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7E24Mjl0nspK7UGAQilW2AFGn3ykWn9u6UlHWeA+EI0HrZLs0XTsZl940pORQ22cBzpz/+f3zSDRQ9Yqn25JzBNhDCWavDElZyQMO9jpUlMUTdWtBdh3UBJlWO3LebHVeaf1ut/zxdH/X9kk6OUy4B4OwshSaqVUvKH35DLdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNhdahwb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acb5ec407b1so862499866b.1;
        Tue, 24 Jun 2025 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750762414; x=1751367214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+7PumorwZUGjFOmFAYkRbYRUnDcMqo0iY74xjCwez0=;
        b=fNhdahwb+jCAq1CLBDzZx0DB5ujOdpH/4J24JKHPm4vuVcrpNjSqX72h28Eohlv+xB
         UNIgZkGg5J/YBrniM95vAIMueARQfeony2cjlA8k+6LJPgLpSvUMtGkqjNcPIzPnt3qX
         CoJR0StR0MoU+k0uz1zsZxH3glqpeimdc7Li7yJ0P26Koh/eaA9AEMNKdKF2BPI+Pi+4
         1Mz2j859e+FHZVtu1kR6nCr/J58vfGsnm3b827W87YbcJPdGHRX6SjWXxXj+pnucgv/y
         NsZRhHKNqtDSTi0ZQZ06irZV3iorMOpLF08h7v9ShcmkrVOFEVcGiVIiUYRysRerR4X/
         g4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762414; x=1751367214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+7PumorwZUGjFOmFAYkRbYRUnDcMqo0iY74xjCwez0=;
        b=VjYUJ+LYA38Q5ZJPotHEOwY59WOxihYsCNi9skCk/q7EyU2jn4cIddoi0SeP7Ovqti
         Ay3+9Djndaxjzc9oInaVooawNEkwT4OgEKdSuJRHXMssOxY6wFBaL0JBqCbpU47/NSH4
         VnmmE/2S1JY6dsAM/4lFlUoUEvpw+KAgAm3rxP0gKD+EpXROhr5ZWZyTvWvkyyupiioe
         5fSG9ox0fqSj8qJ0/YTMCy4aC53tq55tdMHR1SrT4/Gu3WOWtVUj6H2V277XSXcOKiHI
         XgNmsQtGVpgGdsnTTZL+xWvDhSZKjmnay0wwkPetRxpxuBdWll4cs1aHC2s2nYc+VHFp
         NrEg==
X-Forwarded-Encrypted: i=1; AJvYcCWMwU5gf9LuTLLM65N2Sj6ensAX/uZpRorxsAxbrlZv35sBR5ozgS1J/Dn0LW/lQRj621B9VS4V+T5vFQVY@vger.kernel.org, AJvYcCXJpu+Xq4O7Qa9ylut5Lwn8/pLfMOnSZgzyGQmAX8fiKOKv+gyiUezG7oZZ/KvT0eHioAmshVUaQTPh@vger.kernel.org
X-Gm-Message-State: AOJu0YwIoT74NDtHRObOxpzuyo0GQgYogbrLV9DYvGqf/qqxPO3w1Leg
	g6tgpFc+TiwMEc8LUU7iEreBWKqm7kJlu/aEsgRo5heG1erD+XrwBaRjKMKYhZ7BiKvoV3JoVfY
	1cQKMW8bTiDeh9JE9AlyZLJ2sYWwTddDktQLDqg0=
X-Gm-Gg: ASbGnctDGoOmK0BIpylTlWSV1TPUDi8nks3Pqerbai0FT80JMlT6oxPY5VVZLt+4Ikf
	rydauoC4M3Gh5LQ8c9j1tjURtyTTCiiFIdwFJzgq+kadZDyBwWHl/WxkOHOTeTEs37+oI3aVtoS
	tTF4Uzla4J0/BJMy9Ou6YOioJrEsMtyqy25NDBA0NUrpA=
X-Google-Smtp-Source: AGHT+IFDAQP8Gr0alp1oy6eXypbhr6+NZtMZ/Amf4pBvemt9dHBkiDBXsjQNPpbpd+L9aab94Bs2Uma6Xd9ypa+3Y70=
X-Received: by 2002:a17:907:7ea1:b0:adb:229f:6b71 with SMTP id
 a640c23a62f3a-ae057927b27mr1377209766b.5.1750762413643; Tue, 24 Jun 2025
 03:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org> <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
In-Reply-To: <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 12:53:21 +0200
X-Gm-Features: Ac12FXw02AGUYHrOEJ4tWkLqbQY3PrxSZ15ScMlYz3DyWHeshCuYbNKF8up_H-k
Message-ID: <CAOQ4uxgB+01GsNh2hAJOqZF4oUaXqqCeiFVEwmm+_h9WhG-KdA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 11:30=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > Various filesystems such as pidfs (and likely drm in the future) have a
> > use-case to support opening files purely based on the handle without
> > having to require a file descriptor to another object. That's especiall=
y
> > the case for filesystems that don't do any lookup whatsoever and there'=
s
> > zero relationship between the objects. Such filesystems are also
> > singletons that stay around for the lifetime of the system meaning that
> > they can be uniquely identified and accessed purely based on the file
> > handle type. Enable that so that userspace doesn't have to allocate an
> > object needlessly especially if they can't do that for whatever reason.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/fhandle.c | 22 ++++++++++++++++++++--
> >  fs/pidfs.c   |  5 ++++-
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index ab4891925b52..54081e19f594 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const =
char __user *, name,
> >       return err;
> >  }
> >
> > -static int get_path_anchor(int fd, struct path *root)
> > +static int get_path_anchor(int fd, struct path *root, int handle_type)
> >  {
> >       if (fd >=3D 0) {
> >               CLASS(fd, f)(fd);
> > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *ro=
ot)
> >               return 0;
> >       }
> >
> > +     /*
> > +      * Only autonomous handles can be decoded without a file
> > +      * descriptor.
> > +      */
> > +     if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > +             return -EOPNOTSUPP;
>
> This somewhat ties to my comment to patch 5 that if someone passed invali=
d
> fd < 0 before, we'd be returning -EBADF and now we'd be returning -EINVAL
> or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care that
> much about it so feel free to ignore me but I think the following might b=
e
> more sensible error codes:
>
>         if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
>                 if (fd =3D=3D FD_INVALID)
>                         return -EOPNOTSUPP;
>                 return -EBADF;
>         }
>
>         if (fd !=3D FD_INVALID)
>                 return -EBADF; (or -EINVAL no strong preference here)

FWIW, I like -EBADF better.
it makes the error more descriptive and keeps the flow simple:

+       /*
+        * Only autonomous handles can be decoded without a file
+        * descriptor and only when FD_INVALID is provided.
+        */
+       if (fd !=3D FD_INVALID)
+               return -EBADF;
+
+       if (!(handle_type & FILEID_IS_AUTONOMOUS))
+               return -EOPNOTSUPP;

Thanks,
Amir.

