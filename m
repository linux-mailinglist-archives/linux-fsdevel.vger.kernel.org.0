Return-Path: <linux-fsdevel+bounces-34596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD89C6A38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9437D282E17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464C1898E8;
	Wed, 13 Nov 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX/6mOl/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CB1F949;
	Wed, 13 Nov 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731484897; cv=none; b=uGbBDvVm9AgMeVZJUCMPTa7hJp+039//zGgeys1uEOYztnXLsqvYXc0gRm1ASqxxhDMq4Gw1jTka5Gh9xCic6ieAG8HiVLkOWwRH87gUqnNZOslaDxYsrAAvEeej4RzlVywl6HCkSLYFtszL+n9yjlbjNNJVKLKLbptqpE4v+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731484897; c=relaxed/simple;
	bh=uLQsI70T7yS1tYSMnz7C3DyPJAfZuPq69aWIELkLEhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swyzpdTvesnvpj+q1KfPXbOmcvIQBvi6n6TkKZd/JnekyQ+3uIHeia1+EpgjFRGdqg8h6L6RStZOfA2um1yhiHszojKKST6KoeiydkgjKKQJlupaYdFdiy2hh7/FQcP9Fi+F9yli0KPt3bMwbZGQnpJD5F30yuq9QKvdKitKNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX/6mOl/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46101120e70so44781311cf.1;
        Wed, 13 Nov 2024 00:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731484894; x=1732089694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYfwaLE1hyoE7GDcwHi6ktY8zN+SHsx3UX3Cn64nl8A=;
        b=TX/6mOl/S4wGKno1WxWhV+c0fpsZf21XdEkWq4HeqlgKSv/SS0Utey4zx5BFKMA/QG
         5SKXV2k7f8weilrTufozTALCxcI1eCZBm+i37OuLAT2n+uYvw1IVKp+CanjtkvrE5w/l
         YYJk8YXNIy832WXcUxlAK8GDiHbxGrcs4XIRC2aGcdZ2F2yF2z8x+RLnChyHf8aZpqpW
         xPIUDyIMv4TUpv8I74tdnhpShIYP1MhKdMzOS2eQ94ZrnLn2a4mJQbic2rC8G6s7Ux3s
         TFjjd7yN1iiNXv8OQLuWIPmkoi7+fSGlch/AglB+ZtQhwZQtBdljnywIsMo85v+TEg4f
         TP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731484894; x=1732089694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYfwaLE1hyoE7GDcwHi6ktY8zN+SHsx3UX3Cn64nl8A=;
        b=cChNmlRHd59a/ZU4KJ068h5MY1fe8VJaHIe07DZqZ475HMZbxcfp+P0UuIfMuKUhXg
         fC0y+7kLfXCCE8DOqoMJ/xrGH4PoPXsvQUf6p3FYn4d2dsxL8YxWrDblHX84l8LcyzSy
         wZ0hDhgn4odRwomHez3vE5TNBtqeQ8pPeFyyr55hNGx2v396x05FkR0sp387LVOurgqc
         eITSyS6GU3XbV6Mik6137escJinaRp9mBxZM421LwBAK5DnYZkDyUa7vcFbOA5hHo6Vp
         oJIt/oOJCxg72kUs8uQ4NN7cX4m4LvqbkLPn4NrLNY9khIeM5TILbRa4tIgu7fhePd7n
         CouA==
X-Forwarded-Encrypted: i=1; AJvYcCWivi4u63dKXO+y21yUUJbx1FfGUqgFPtJJjzw4o7HBznVLhxHvYCskffPzy6+7VsDSabp8DicdIv04FlQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhNrk51fIgv9WUOioXQzkmOyVVAspzfs6fluQddpGtQY00uVh
	PaDXNkRYAUZlvZsrm3DW2B2C866CqPpcHB/ZiOjQwbTJUge1rxx5yFga6qJ7v/+PNrL2SXY7mWX
	6NQbXscqER6njfY8HFHEg+yLlhqA=
X-Google-Smtp-Source: AGHT+IHkZLxXLJDJkCqESfuAri+gDWqFWuggZU3LGk83aKCuu77JSLHt5h4/uyV3Jda+sF/p5057emvZvCNGC6W0jBc=
X-Received: by 2002:a05:622a:1352:b0:460:3f8a:f9a2 with SMTP id
 d75a77b69052e-46340381a68mr56112621cf.56.1731484893899; Wed, 13 Nov 2024
 00:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101135452.19359-1-erin.shepherd@e43.eu> <20241101135452.19359-5-erin.shepherd@e43.eu>
 <08d15335925b4fa70467546dd7c08c4e23918220.camel@kernel.org>
In-Reply-To: <08d15335925b4fa70467546dd7c08c4e23918220.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 09:01:23 +0100
Message-ID: <CAOQ4uxg96V3FBpnn0JvPFvqjK8_R=4gHbJjTPVTxDPzyns52hw@mail.gmail.com>
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
To: Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:34=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-11-01 at 13:54 +0000, Erin Shepherd wrote:
> > This enables userspace to use name_to_handle_at to recover a pidfd
> > to a process.
> >
> > We stash the process' PID in the root pid namespace inside the handle,
> > and use that to recover the pid (validating that pid->ino matches the
> > value in the handle, i.e. that the pid has not been reused).
> >
> > We use the root namespace in order to ensure that file handles can be
> > moved across namespaces; however, we validate that the PID exists in
> > the current namespace before returning the inode.
> >
> > Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> > ---
> >  fs/pidfs.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 43 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index c8e7e9011550..2d66610ef385 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -348,23 +348,59 @@ static const struct dentry_operations pidfs_dentr=
y_operations =3D {
> >       .d_prune        =3D stashed_dentry_prune,
> >  };
> >
> > -static int pidfs_encode_fh(struct inode *inode, __u32 *fh, int *max_le=
n,
> > +#define PIDFD_FID_LEN 3
> > +
> > +struct pidfd_fid {
> > +     u64 ino;
> > +     s32 pid;
> > +} __packed;
> > +
> > +static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> >                          struct inode *parent)
> >  {
> >       struct pid *pid =3D inode->i_private;
> > -
> > -     if (*max_len < 2) {
> > -             *max_len =3D 2;
> > +     struct pidfd_fid *fid =3D (struct pidfd_fid *)fh;
> > +
> > +     if (*max_len < PIDFD_FID_LEN) {
> > +             *max_len =3D PIDFD_FID_LEN;
> >               return FILEID_INVALID;
> >       }
> >
> > -     *max_len =3D 2;
> > -     *(u64 *)fh =3D pid->ino;
> > -     return FILEID_KERNFS;
> > +     fid->ino =3D pid->ino;
> > +     fid->pid =3D pid_nr(pid);
>
> I worry a little here. A container being able to discover its pid in
> the root namespace seems a little sketchy. This makes that fairly
> simple to figure out.
>
> Maybe generate a random 32 bit value at boot time, and then xor that
> into this? Then you could just reverse that and look up the pid.
>

I don't like playing pseudo cryptographic games, we are not
crypto experts so we are bound to lose in this game.

My thinking is the other way around -
- encode FILEID_INO32_GEN with pid_nr + i_generation
- pid_nr is obviously not unique across pidns and reusable
  but that makes it just like i_ino across filesystems
- the resulting file handle is thus usable only in the pidns where
  it was encoded - is that a bad thing?

Erin,

You write that "To ensure file handles are invariant and can move
between pid namespaces, we stash a pid from the initial namespace
inside the file handle."

Why is it a requirement for userspace that pidfs file handles are
invariant to pidns?

Thanks,
Amir.

