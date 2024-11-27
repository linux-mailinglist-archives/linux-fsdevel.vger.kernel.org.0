Return-Path: <linux-fsdevel+bounces-35984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95229DA7B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D2CB28FBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B841FBEA9;
	Wed, 27 Nov 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB1F9Utm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54431FA82B;
	Wed, 27 Nov 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710068; cv=none; b=T6RCe6FrEPEGfe7CZa3oZGnNdskBLMVUOfbdxmABG+xtblpyCZKpXdOfJaIrsisYLrXVXGK+RQehF2tzNN18LPEr5sU4jOQccCK3/3JAkmiN5KwtzlJCO8i+ehu+IpayZBmZdTbDki7P4UIrtbtY9Gt1KDihPuSeYnoiYvusQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710068; c=relaxed/simple;
	bh=YoYm/8Gmv4T6pcFqBQPC/t9x+Y5EzGkzxsEPtGJyWxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY3MJl4OVu8OUoDGcOaZn5AR4b+/vzz+CU0kmgUBL3YtYdSSgTijFKm9ohbfHs0dySlpRjr4LkU5QLHJTDOUM4xCbWmiqHclb9AhEz01MGbmrr+Hx/bbt6VSlFixpgP26b+7JogbFB2b2K+40Ek8hnLQjjzl/BVyUxroiiI1BJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB1F9Utm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso637065766b.2;
        Wed, 27 Nov 2024 04:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732710065; x=1733314865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4AJxcgbGXlGttAV3Sp9Te5JfEMnLRstmnBehcMGYgI=;
        b=nB1F9UtmOKHdS2GV6WVqbh28V1k48wgKVHdxUvBqqxX1n/ymEjCawj9m4jBEQ8oEaQ
         Feohw4ptelSu/Yk78NNPkbVRzwCOIAREdqc7i9o34CQwfOIvxkW0VSIy334UDvU3hcUG
         QvTmMfqpH+cv2+mNLwc4JN4V/ykFZBpZkAbaekkPLilukFBNdmDsALCRlj/sUQ/vpsoc
         d91oECNBKd/vEG3E60r3okLSauO/92uFvSn39ei7cCyrEece4gOWCrbQM7T5LCGi7wEs
         PX19G/gZp6FnZEAI0nG/RiFpXVuPSkJQc4oIpvSlI2/b+D0/GgaZ29jS1qfdbAAF1Ifb
         9h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710065; x=1733314865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4AJxcgbGXlGttAV3Sp9Te5JfEMnLRstmnBehcMGYgI=;
        b=ve4qXIaXOTC18GjdBNrLhJDQklTn2yFSD9KtKoAoex064fZAW28ebrGJ3h7Ol6r1z/
         RR9PIEKuXBeTFJDxt1WwYoUTiDFGKekt4+83KyYO6DONf61MdnrvopmeNrJCHD5h4Wrb
         qvQPV5gMLqos7Ts5nIdBS8oUNGfyDP0tEVg4N+kGP2BNUdqSCzcmkK6GPpBmh02NWs+J
         r8CbafgOHITnAm+fNFdqhyLNePOFQwy/OLxESzdnTC41XLwTeBZiqR1x0+KoR6izHGXO
         +F//ibuCkgZcfg3zYfpZ0IZwnKCYHIKR4wyzQ8V7oLoECIKYzJCsSneFOJ6Bn2FAnUUG
         qrGw==
X-Forwarded-Encrypted: i=1; AJvYcCUTg4A3FKHsbFbmRXrSy9d6/HNESTC2uDg9GNWluSoWspDOlqjk3t6bZ8YgpM8Pf1Bgl1jzpUuAJmqC@vger.kernel.org, AJvYcCUey/64BtCsRIh3knYixLJ2GMwTzwjug8kcws86ci1lx7KWIJpIRgjohuvZXrhFyCbNh2+UGpfCXvW48GjJzQ==@vger.kernel.org, AJvYcCXh8qzEscH9+UuZ+2AyZtyVJ/nfB64qedgE0JMzcv9BDFazWKgo4rpt0PQ7A1LKpmvnRp7sksQS+lICiA==@vger.kernel.org, AJvYcCXq+aEHGHzxx4SA3f6Ueh7ksR6uBJSmHC8/Iq9E6ksqKEoMserYX3Bql3vyykNushi1l18+wH8krNWZdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72zmDE5k1d2TbmT8A217J5qOwjlOGrZndsfO1xkVh5pTt3yjk
	pphpqFBLghZbREMH+Q8Fu1rC5aU89FiYUdQHzuhVS0NdXgIRlmeKrYdJZMw3W8GQjXmO4c+3nu7
	+GsNxpFe/a+LNkWF5ttYlvIARUkc+mn/R
X-Gm-Gg: ASbGncsFs2oqItRVGFUJ44hocNzvR5d+JMByX/vlCbHr2ZhH9tPeLIfGNBz+K8D/hE4
	Eu0mEHp9j1uiQgdZm8Wg0EqIkHJZQfKk=
X-Google-Smtp-Source: AGHT+IFZo9o4G9xu1yI2+N8EIMu+e3DL435vyXxWc0NrJTLb0aMbN7osMheigvrNa3XxJ9bTAmpltIRm5/4kmYOjn4g=
X-Received: by 2002:a17:906:315b:b0:aa5:3853:553e with SMTP id
 a640c23a62f3a-aa58103dbb5mr264470966b.47.1732710064815; Wed, 27 Nov 2024
 04:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
 <20241121104428.wtlrfhadcvipkjia@quack3> <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
 <20241121163618.ubz7zplrnh66aajw@quack3> <CAOQ4uxhsEA2zj-a6H+==S+6G8nv+BQEJDoGjJeimX0yRhHso2w@mail.gmail.com>
 <CAOQ4uxgsjKwX7eoYcjU8SRWjRw39MNv=CMjjO1mQGr9Cd4iafQ@mail.gmail.com>
 <20241122124215.3k3udv5o6eys6ffy@quack3> <CAOQ4uxgCU6fETZTMdyzQmfyE4oBF_xgqpBdVjP20K1Yp1BSDxQ@mail.gmail.com>
 <20241127121838.3fmhjx26cfxcegro@quack3>
In-Reply-To: <20241127121838.3fmhjx26cfxcegro@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Nov 2024 13:20:52 +0100
Message-ID: <CAOQ4uxjSQQr88W9z7xK5LbotvpiPon8nk=L33J5Z5RamEGHNCw@mail.gmail.com>
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:18=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 22-11-24 14:51:23, Amir Goldstein wrote:
> > On Fri, Nov 22, 2024 at 1:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 21-11-24 19:37:43, Amir Goldstein wrote:
> > > > On Thu, Nov 21, 2024 at 7:31=E2=80=AFPM Amir Goldstein <amir73il@gm=
ail.com> wrote:
> > > > > On Thu, Nov 21, 2024 at 5:36=E2=80=AFPM Jan Kara <jack@suse.cz> w=
rote:
> > > > > > On Thu 21-11-24 15:18:36, Amir Goldstein wrote:
> > > > > > > On Thu, Nov 21, 2024 at 11:44=E2=80=AFAM Jan Kara <jack@suse.=
cz> wrote:
> > > > > > > and also always emitted ACCESS_PERM.
> > > > > >
> > > > > > I know that and it's one of those mostly useless events AFAICT.
> > > > > >
> > > > > > > my POC is using that PRE_ACCESS to populate
> > > > > > > directories on-demand, although the functionality is incomple=
te without the
> > > > > > > "populate on lookup" event.
> > > > > >
> > > > > > Exactly. Without "populate on lookup" doing "populate on readdi=
r" is ok for
> > > > > > a demo but not really usable in practice because you can get sp=
urious
> > > > > > ENOENT from a lookup.
> > > > > >
> > > > > > > > avoid the mistake of original fanotify which had some event=
s available on
> > > > > > > > directories but they did nothing and then you have to ponde=
r hard whether
> > > > > > > > you're going to break userspace if you actually start emitt=
ing them...
> > > > > > >
> > > > > > > But in any case, the FAN_ONDIR built-in filter is applicable =
to PRE_ACCESS.
> > > > > >
> > > > > > Well, I'm not so concerned about filtering out uninteresting ev=
ents. I'm
> > > > > > more concerned about emitting the event now and figuring out la=
ter that we
> > > > > > need to emit it in different places or with some other info whe=
n actual
> > > > > > production users appear.
> > > > > >
> > > > > > But I've realized we must allow pre-content marks to be placed =
on dirs so
> > > > > > that such marks can be placed on parents watching children. Wha=
t we'd need
> > > > > > to forbid is a combination of FAN_ONDIR and FAN_PRE_ACCESS, wou=
ldn't we?
> > > > >
> > > > > Yes, I think that can work well for now.
> > > > >
> > > >
> > > > Only it does not require only check at API time that both flags are=
 not
> > > > set, because FAN_ONDIR can be set earlier and then FAN_PRE_ACCESS
> > > > can be added later and vice versa, so need to do this in
> > > > fanotify_may_update_existing_mark() AFAICT.
> > >
> > > I have now something like:
> > >
> > > @@ -1356,7 +1356,7 @@ static int fanotify_group_init_error_pool(struc=
t fsnotify_group *group)
> > >  }
> > >
> > >  static int fanotify_may_update_existing_mark(struct fsnotify_mark *f=
sn_mark,
> > > -                                             unsigned int fan_flags)
> > > +                                            __u32 mask, unsigned int=
 fan_flags)
> > >  {
> > >         /*
> > >          * Non evictable mark cannot be downgraded to evictable mark.
> > > @@ -1383,6 +1383,11 @@ static int fanotify_may_update_existing_mark(s=
truct fsnotify_mark *fsn_mark,
> > >             fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
> > >                 return -EEXIST;
> > >
> > > +       /* For now pre-content events are not generated for directori=
es */
> > > +       mask |=3D fsn_mark->mask;
> > > +       if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> > > +               return -EEXIST;
> > > +
> >
> > EEXIST is going to be confusing if there was never any mark.
> > Either return -EINVAL here or also check this condition on the added ma=
sk
> > itself before calling fanotify_add_mark() and return -EINVAL there.
> >
> > I prefer two distinct errors, but probably one is also good enough.
>
> That's actually a good point. My previous change allowed setting
> FAN_PRE_ACCESS | FAN_ONDIR on a new mark because that doesn't get to
> fanotify_may_update_existing_mark(). So I now have:
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 0919ea735f4a..38a46865408e 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1356,7 +1356,7 @@ static int fanotify_group_init_error_pool(struct fs=
notify_group *group)
>  }
>
>  static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_m=
ark,
> -                                             unsigned int fan_flags)
> +                                            __u32 mask, unsigned int fan=
_flags)
>  {
>         /*
>          * Non evictable mark cannot be downgraded to evictable mark.
> @@ -1383,6 +1383,11 @@ static int fanotify_may_update_existing_mark(struc=
t fsnotify_mark *fsn_mark,
>             fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
>                 return -EEXIST;
>
> +       /* For now pre-content events are not generated for directories *=
/
> +       mask |=3D fsn_mark->mask;
> +       if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> +               return -EEXIST;
> +
>         return 0;
>  }
>
> @@ -1409,7 +1414,7 @@ static int fanotify_add_mark(struct fsnotify_group =
*group,
>         /*
>          * Check if requested mark flags conflict with an existing mark f=
lags.
>          */
> -       ret =3D fanotify_may_update_existing_mark(fsn_mark, fan_flags);
> +       ret =3D fanotify_may_update_existing_mark(fsn_mark, mask, fan_fla=
gs);
>         if (ret)
>                 goto out;
>
> @@ -1905,6 +1910,10 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>         if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
>                 goto fput_and_out;
>
> +       /* Pre-content events are not currently generated for directories=
. */
> +       if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> +               goto fput_and_out;
> +
>         if (mark_cmd =3D=3D FAN_MARK_FLUSH) {
>                 ret =3D 0;
>                 if (mark_type =3D=3D FAN_MARK_MOUNT)
> --
> 2.35.3
>

Looks good.

Thanks,
Amir.

