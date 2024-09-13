Return-Path: <linux-fsdevel+bounces-29274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D19776DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 04:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C361F224C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4A1D362C;
	Fri, 13 Sep 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQo+NXvp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4901D131A;
	Fri, 13 Sep 2024 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194236; cv=none; b=a9f34iLXSAG3xAazadfSzu3j2pYtuOH9LEOOog4i8U8YKNEWk5rmtLkC6jbzfcFbPhArMSEb6dPNa3P++Iweto9cm4gX5bBhgwtvxWDneJJ8Z7u0IJ8bL8v04u5C66CvoLCjNcpT07wOBsZq5eO22UEGWeln0UR5jV//J0UmF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194236; c=relaxed/simple;
	bh=qsNRyJ6AahyrLAzbp/5eacdSJ8jCyWQ12rPk4N4oy48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbOX2o/paemX+wvWJrniTyYlHQUH1ewGJz5B5vj44Z2r+xWJSAtdPOGASZSz6V6nPZ+9l1zMHPR3uRhpZyEsUG5/JTUtHLVBtI5pckqwmQ9N/qOT98qOe4oXvQKMPYHVjkwcouQ0h8SetDnO1jtkDR95zPjcSmmGjzxmSHI1j3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQo+NXvp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-458366791aaso8506801cf.1;
        Thu, 12 Sep 2024 19:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726194234; x=1726799034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPVsVFceR0WWI5d/ojpASw6tDyoPFdiM2e1qY8KWSm4=;
        b=KQo+NXvpzOhqrt+oLn9YrIUYLmZSpUhsBbZbL9reO70fDX0tsuzEwitiQ9fb65SFme
         82fmjU8+bE/ZMZW6FmLv4bsVT7EGpNIDt75mg5JxGCrbxD9lWGmxwaulXW37FU+qTq6S
         nVTTjPhRltQdacQKimrPRDUrIPcu8mxSVf+L9CnFCV0/MX7mO+f///s5wp4T2bgNQmho
         DtRK/S3DH//yhrjynApLNbsIqGYUu6PRvDJH210C/rUuU7SdoZdWqQuLQRHTyvhsigLY
         ce9SQBOPH86CTzxV4r/Gp7Wk4H8ne/wW5N4eHDOAgAWzctO/EVH6dVVbAv2ajCNrdM9g
         oeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726194234; x=1726799034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPVsVFceR0WWI5d/ojpASw6tDyoPFdiM2e1qY8KWSm4=;
        b=DIEMLIVhFgDsfv/urSMPO30MHttNR1mrinaiC3JIy2y2k8wRGCutBPiCnygh0TpGo6
         YNtU6kcpt1QeKACv0QTvMxkXhkWjJEO0zVpQFAVXwQ8wyZymTUp8uC400+qbFAsOWuzS
         qu6i+0L3bDBW5b4D0wWobNfWfUt8uCFii5M+z6SOtyM0/Yb5CrkOYKwPF915gvMW69h1
         JlgWbEiqju2SXVlPeZ4YdJQ/VTQNdGn+Sj7GNZG8ULEBAiwvlKgqan85o0tCorc4clpd
         hDnXqIVeOXE7bTGudrkK3FYznyi9Hxi0cZjGMjza3xkKK3+YLDvNjYXadSIzqugvj9YH
         9mrw==
X-Forwarded-Encrypted: i=1; AJvYcCU0+ULigQWsEr/d7nffy1alt9WXvNzzj7Rg4TqWVsgq/BPMfPSyt9q9XqIEHnSA6+8n7y2a@vger.kernel.org, AJvYcCUYrOD5zBl1Y2y3dUo2p08Ua7reDAMqUGhIIlTiLm+YB+NSgCgEot12OoT8W0SNZ6QZqacKuIo1@vger.kernel.org, AJvYcCV1zpCyAPYtdj7+HS/ngjHToKcaPKr8AuzOnT0tFlhBduiWQrs3XAYsp7SsOQgKiPBxi6PEzQ==@vger.kernel.org, AJvYcCVIS1x4yE0YjpZqFHUe/036nMLu86CzXEsVWvcbPyHi+XjzxrJmV5//HCmhsO9VZdcR5fCCutaug1ydqqDds16rE+Ix@vger.kernel.org, AJvYcCWScf1/IeeJ3biAx5NifqaF4eQ/8BtC1mSOxUYGNVK5r/+WlKVs69OhyyjdHyU7CC67+0IepX7FB2EO46IlJQ==@vger.kernel.org, AJvYcCWXmmDpd/psT1/GvJfwDBWsGedZAH4FxXMFmV1KFoG6hBBSLgdiOR2tg3L7MmUqoSZabS4dPh1jw81g94nPDWFLNkUBJsnJ@vger.kernel.org, AJvYcCWw9QeP0WPeBAppqLvel3/11Np9c8V5/QKQwl9CwiwJsCJ9bysMlWRo+VdgMaSNChaqjllIBIdbtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXr1ZMDIKhaaG3kMcD8cGAekcKMZYmw82ZGM095/02UQIB2ga
	uJ0y5qOeRANfzwt0QaIqIL5JGT9+NXF8xt909whdPk73+1xILCZwhmCSIbK/khEG9NPc8OKNVWy
	ZntctymiVyP8b2IEdSnG8ddsYHDo=
X-Google-Smtp-Source: AGHT+IE7ATrua7rsyqeOcJseYjVtTnE4hssxQiNmRKzesjoiGraR/SEm091yrLZIkqiIIy/oAkVbRqThLd1lUTb523s=
X-Received: by 2002:a05:6214:2e4a:b0:6c5:31d6:7749 with SMTP id
 6a1803df08f44-6c5736ea189mr65801846d6.44.1726194233773; Thu, 12 Sep 2024
 19:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828030321.20688-1-laoar.shao@gmail.com> <20240828030321.20688-9-laoar.shao@gmail.com>
 <qqpiar6nlyuill6eng7safauo2xzzpx46cv6wku4xe42qsw47m@rirhsxrdzm2z>
In-Reply-To: <qqpiar6nlyuill6eng7safauo2xzzpx46cv6wku4xe42qsw47m@rirhsxrdzm2z>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 13 Sep 2024 10:23:17 +0800
Message-ID: <CALOAHbCRnqg8q-9KxNHZVfGUm5aO5_60X_sZB7TPB68EMz7mZA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] drm: Replace strcpy() with strscpy()
To: Justin Stitt <justinstitt@google.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, alx@kernel.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:28=E2=80=AFAM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Wed, Aug 28, 2024 at 11:03:21AM GMT, Yafang Shao wrote:
> > To prevent erros from occurring when the src string is longer than the
> > dst string in strcpy(), we should use strscpy() instead. This
> > approach also facilitates future extensions to the task comm.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_framebuffer.c     | 2 +-
> >  drivers/gpu/drm/i915/i915_gpu_error.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_fr=
amebuffer.c
> > index 888aadb6a4ac..2d6993539474 100644
> > --- a/drivers/gpu/drm/drm_framebuffer.c
> > +++ b/drivers/gpu/drm/drm_framebuffer.c
> > @@ -868,7 +868,7 @@ int drm_framebuffer_init(struct drm_device *dev, st=
ruct drm_framebuffer *fb,
> >       INIT_LIST_HEAD(&fb->filp_head);
> >
> >       fb->funcs =3D funcs;
> > -     strcpy(fb->comm, current->comm);
> > +     strscpy(fb->comm, current->comm);
> >
> >       ret =3D __drm_mode_object_add(dev, &fb->base, DRM_MODE_OBJECT_FB,
> >                                   false, drm_framebuffer_free);
> > diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i9=
15/i915_gpu_error.c
>
> There are other strcpy() in this file but it seems all control paths to
> the copies themselves stem from string literals, so it is probably fine
> not to also change those ones. But, if a v9 is required and you're
> feeling up to it, we should probably replace them too, as per [1].

will change them in the next version.
Thanks for your suggestion.

>
>
> > index 96c6cafd5b9e..afa9dae39378 100644
> > --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> > +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> > @@ -1412,7 +1412,7 @@ static bool record_context(struct i915_gem_contex=
t_coredump *e,
> >       rcu_read_lock();
> >       task =3D pid_task(ctx->pid, PIDTYPE_PID);
> >       if (task) {
> > -             strcpy(e->comm, task->comm);
> > +             strscpy(e->comm, task->comm);
> >               e->pid =3D task->pid;
> >       }
> >       rcu_read_unlock();
> > --
> > 2.43.5
> >
> >
>
>
> Reviewed-by: Justin Stitt <justinstitt@google.com>
>
> [1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcp=
y
>
> Thanks
> Justin



--=20
Regards
Yafang

