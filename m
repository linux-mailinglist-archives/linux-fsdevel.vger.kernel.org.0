Return-Path: <linux-fsdevel+bounces-52783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16492AE68E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 16:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041FD18923F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67323741;
	Tue, 24 Jun 2025 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgkSecGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E31C84DF;
	Tue, 24 Jun 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775345; cv=none; b=hgRLtv1+DT520YjXbGERvLSme3Y0EfZJmNrTAri2HZtI6XsDJ6KwbdUU1q18KXVU2pPYaMLiMk7ZEmJ7D911uGF1yb6r95m2aj/6iZYzdfpa+5FuwbLW7N6/PGg150f+5kTcjpP1PXYVLaTHPNGl298kulOF/9rPZm4ghwBkEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775345; c=relaxed/simple;
	bh=5MN6uNUQRZyCIUK95PgqVlhMXf+1t2U1BLeFKEiYmoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EamtV+2BziM6d8Vf5MPGhOTelDaZp6i6v4TzmC461PtUIXs+Vg48MI1EuDlWmwTSev5J6ZaEZtcZECYg/WHLHv/4Wu3A3hJXwa1HBKMCgHYq1hLkUUBGj24wIkmDAX6AZwvuE03PUvgl/KBQdykHcA2AtXTwNnoY8OuQXpvgm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgkSecGz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so12328275a12.0;
        Tue, 24 Jun 2025 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750775342; x=1751380142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7Ub3HWzxgZGTyETvsdidBVZkJmivzQg2Ys8H1wC3MY=;
        b=BgkSecGzC6m1vQRmAV+/F5wBqAiHuoLiXYsN/1tg28fqZJA7Ply7wn9epGiLmiJwd0
         Zx7dBGguplNpyHZ/Tp2vXPk9Tj/3w91eYQ/60LRSc8l6TeZnpIllJzs1994i1romK2w5
         Y4mdfOa0gd+umtiYx+8ufTs2/iXFsfo8ezliGvmnZmZUpG+MChONM+8mw7hQ4T6uWhXZ
         50z0HUddNhttQfAHBXBvnZEI6MR0JwI38yiCUhQRa+DagZO9b8+1kev1wDcZWCi3Dqjs
         VQbURVYPq5KBLDXeVxpEqfiF2vcqydxExxq+Vv7ytmVLuwmNHqu/HqHyq0EDJr9r3sLK
         BQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775342; x=1751380142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7Ub3HWzxgZGTyETvsdidBVZkJmivzQg2Ys8H1wC3MY=;
        b=udrVRXV0DcUKnE1PVOUeLrdx4J3tR+0e+tDqcUZA1V0OWAM9s1S5rjRZvWLnAnmqnH
         8XTFaYxvsV0dQPGFeNK1BaH0AkeR499M+Brdj4lvhkT7M6q3PWlEz+pxSJgmXKyXV2hm
         dcdWSKU/ArWbvS8enYa/1TpNScH5VE43L070wPKOOLIlYK7/vWSYDtWDyncwMtlWBcd+
         6XwjsJJANz8hzc3SYyk2xq7dbzQGq0jCy4QNLkiwPHojiMRqtU1fISw0zG+vW1biTx5s
         YPjelPEioZtd+yj8SKy4BgIKgzkC/RJBUi1wo+xWlCgXG0Cf+rU/59kv35RNRjt18G+f
         EHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBBa86CNcafAln0Fi6KtL9/Ii0BUWLNQJYgYdZjmBk875AMgEDdobU0fqTBbxcdwRFw/XLnunIktjVYdX6@vger.kernel.org, AJvYcCVxNk0QwNErFrmEzKtbLMSzmWiHM9DOy/fxmlxkX3/PvuL/zA+LNI209GD9C4znXb/Fx3+rePARnaA8@vger.kernel.org
X-Gm-Message-State: AOJu0YxytPHtlipyHO+g8nrfFaF+2eeFZGBvAOphLqZJommOX5nVV/Fe
	yNiP+DMc4HY+05SVw9E8sT+xakSWr48ugLxFc5hBKDK4Iwe3UWR241gTXW+kce0Y0fFYvEGAInl
	GelnjePzvF21e5MZQngE3gzXg+f5Ev28=
X-Gm-Gg: ASbGncubDRxmlm2AXKF908XpizKMvxgBrd+2HqFr2Apn5TSlyT49ndg0AWsSW8MRPh+
	vc58220uhjZzvTHY5xETVgTzq/aVB1rAv7fg8AYlhKlw7F6qhMUeGZ7x3ZncREL8GE7ZFoymrcM
	LE26afiEwnPjyBdu21ZwOEYp2liGz2KiiqXMrnGpItAcU=
X-Google-Smtp-Source: AGHT+IEXBzP4RQp46CUAppadc/LfMIKUKhDwFcYT4rN+y8C2QEp33zWX28oS9DIBNpmrrQslGarLV15ZfxyomoRSBec=
X-Received: by 2002:a17:906:6a21:b0:ade:4f2:9077 with SMTP id
 a640c23a62f3a-ae0a71f4599mr415811166b.5.1750775341612; Tue, 24 Jun 2025
 07:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
 <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl> <CAOQ4uxgB+01GsNh2hAJOqZF4oUaXqqCeiFVEwmm+_h9WhG-KdA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgB+01GsNh2hAJOqZF4oUaXqqCeiFVEwmm+_h9WhG-KdA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 16:28:50 +0200
X-Gm-Features: AX0GCFtaZvA3yGy0FBmZxZgD1Oi-TeCxAceGj6ftnKud6FpnUfe6_3Cn2XYmvYg
Message-ID: <CAOQ4uxjYGipMt4t+ZzYEQgn3EhWh327iEyoKyeoqKKGzwuHRsg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:53=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Tue, Jun 24, 2025 at 11:30=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > > Various filesystems such as pidfs (and likely drm in the future) have=
 a
> > > use-case to support opening files purely based on the handle without
> > > having to require a file descriptor to another object. That's especia=
lly
> > > the case for filesystems that don't do any lookup whatsoever and ther=
e's
> > > zero relationship between the objects. Such filesystems are also
> > > singletons that stay around for the lifetime of the system meaning th=
at
> > > they can be uniquely identified and accessed purely based on the file
> > > handle type. Enable that so that userspace doesn't have to allocate a=
n
> > > object needlessly especially if they can't do that for whatever reaso=
n.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/fhandle.c | 22 ++++++++++++++++++++--
> > >  fs/pidfs.c   |  5 ++++-
> > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > index ab4891925b52..54081e19f594 100644
> > > --- a/fs/fhandle.c
> > > +++ b/fs/fhandle.c
> > > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, cons=
t char __user *, name,
> > >       return err;
> > >  }
> > >
> > > -static int get_path_anchor(int fd, struct path *root)
> > > +static int get_path_anchor(int fd, struct path *root, int handle_typ=
e)
> > >  {
> > >       if (fd >=3D 0) {
> > >               CLASS(fd, f)(fd);
> > > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *=
root)
> > >               return 0;
> > >       }
> > >
> > > +     /*
> > > +      * Only autonomous handles can be decoded without a file
> > > +      * descriptor.
> > > +      */
> > > +     if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > +             return -EOPNOTSUPP;
> >
> > This somewhat ties to my comment to patch 5 that if someone passed inva=
lid
> > fd < 0 before, we'd be returning -EBADF and now we'd be returning -EINV=
AL
> > or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care that
> > much about it so feel free to ignore me but I think the following might=
 be
> > more sensible error codes:
> >
> >         if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
> >                 if (fd =3D=3D FD_INVALID)
> >                         return -EOPNOTSUPP;
> >                 return -EBADF;
> >         }
> >
> >         if (fd !=3D FD_INVALID)
> >                 return -EBADF; (or -EINVAL no strong preference here)
>
> FWIW, I like -EBADF better.
> it makes the error more descriptive and keeps the flow simple:
>
> +       /*
> +        * Only autonomous handles can be decoded without a file
> +        * descriptor and only when FD_INVALID is provided.
> +        */
> +       if (fd !=3D FD_INVALID)
> +               return -EBADF;
> +
> +       if (!(handle_type & FILEID_IS_AUTONOMOUS))
> +               return -EOPNOTSUPP;
>

Thinking about it some more, as I am trying to address your concerns
about crafting autonomous file handles by systemd, as you already
decided to define a range for kernel reserved values for fd, why not,
instead of requiring FD_INVALID for autonomous file handle, that we
actually define a kernel fd value that translates to "the root of pidfs":

+       /*
+        * Autonomous handles can be decoded with a special file
+        * descriptor value that describes the filesystem.
+        */
+       switch (fd) {
+       case FD_PIDFS_ROOT:
+               pidfs_get_root(root);
+               break;
+       default:
+               return -EBADF;
+       }
+

Then you can toss all my old ideas, including FILEID_IS_AUTONOMOUS,
and EXPORT_OP_AUTONOMOUS_HANDLES and you do not even need
to define FILEID_PIDFS anymore, just keep exporting FILEID_KERNFS
as before (you can also keep the existing systemd code) and when you want
to open file by handle you just go
open_by_handle_at(FD_PIDFS, &handle, 0)
and that's it.

In the end, my one and only concern with autonomous file handles is that
there should be a user opt-in to request them.

Sorry for taking the long road to get to this simpler design.
WDYT?

Thanks,
Amir.

