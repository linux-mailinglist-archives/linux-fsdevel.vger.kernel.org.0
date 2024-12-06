Return-Path: <linux-fsdevel+bounces-36682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E09E7B31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 22:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1D91885EA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25B21DA0E0;
	Fri,  6 Dec 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmUVS8yi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D699522C6C3
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522093; cv=none; b=aZv16htwxyEVwfrclaEEKgVfCbJ7iJ2DEKllqakqy3t5b2IefgdYnJSORzlxubO21hnHhJ76nHV8ctDzKeLqWYrXB9VtKffg+8lhj3gI/R52UHzm+V2jKvCbJn0vEZHmyod+UamaiSyasvx1vPOH1Aztr0pbaKufk/pOXmRu0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522093; c=relaxed/simple;
	bh=AVhD0jOwwxyuUHk3rHvL1MBATeSIeNz7ZRT3127m7m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2xIfV9w7B0NcmdNfPSMxCEd/RL3dmpbIEWvzZ7ybPtv+ZCoYSBy8FcHeMfOBm3NSWHauWquqTYByB8ug04QeUxiEepyTTfpQSd/SyqJ4KvQqZPshQ2tgqY15V4BRbsHZ0JTvroxpz1HYP5sCNeIZN7EXp4GcZ2qakmNbIGad4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmUVS8yi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46684744070so24346941cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 13:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733522091; x=1734126891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LzRx70pIL40ruIIkPnVXmeZC/TQH14Qi4H1XuKgtQ0=;
        b=LmUVS8yi4bLhVJCdavbzJkezqd/RiboNvTPtEy/dVGwqrTu83CLRFP0dzddxAv69Dw
         mutanENRgHtutItB//8L3IFK4ekXg5tLynPB5KWTssr9d1W0Co6DXh2bzY/8sIvTVGHG
         H/lJ+mNlz28ht+j2E7/pi7EHuihv+TCKpJ4LD0p8iVMxenVKoPRsboFushgtGaW+/SKR
         BdSNgk4hTV928Ulop+K5S4aRivjYseoDxwjqO0ShFKRECsrnaD6oNTdkCi5Hgyi04WEn
         l5N+8Eo4hXVmcSZnq/cBzCm9YbL9OidnBV6+OmuOFuC74GJxcI8lF3OSU0n/Gtrr2y8u
         j61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733522091; x=1734126891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LzRx70pIL40ruIIkPnVXmeZC/TQH14Qi4H1XuKgtQ0=;
        b=vwrrH5+CzOg3WjgDKPjC7RLEe1V/q0QJO9XaGpkODaReoXG0ud5UGFSWHQHTHnAYVD
         GN9o3ZF4VRMViWMPR4cAtJkIuv107Y5oM6kYPI/kTzpWzEs512gNeR8KN6C9yQPhXICN
         ksvlZjwgDkbS/CfVZUlB+Zex0lakStrwraJ/QrPnHz5QpfiQk26/J+FpvDtiOW+I+ZJ8
         +Sfl2BZBgKl1MoQoPckyI5PMGcy881Q9wNmC0ZG5xb7mV5tPdDKbl5zvXTF6W8ntdJMb
         4yNLhENsZGhP3nAPJ+48l0lJvvSA6Bef7/uiOPmQqHRun+YVNH4zhl6gkATWZLHX9I20
         fZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCUeBU/KLXYLB1LQBKgj5zoARBJ8YxQkFAWvYXPVA76QUobyhwbJ6ds1vLa7yKnon29QKM1xy/o9SIg74GZt@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCDpmM+7dq3ZlY5rqif4lNlGVY6PG8QC17ASbj7ZN89mBfq4n
	gr+VBux5dcO2OvBGIYb9cvupYIj5kxd+UQ7VN4RGk0eHKYWT/tEwAJ1Blv/6YqSsE1Uye0FvW7J
	0bI7nAseLGFOdTqEBRHYQIC/c7ms=
X-Gm-Gg: ASbGncuCrnYmSH+hT0OfaXUteMf2VoRpYEf10xiGE/GOAF6B9ctEDZxH9wDfE0j93I7
	x9wbZ+oeLe8oVEsgdD3JPP3QSXnFv/Mi6MY0kkF2UoMzJuh0=
X-Google-Smtp-Source: AGHT+IG6goAMP3BvgOldp5AD0gw7MLV16hmkoZUKPyg+nJh6aNXHkpz6oMMnOe1h7pDUrElMSuQgCo181XOMS/b0RL8=
X-Received: by 2002:a05:622a:4c13:b0:466:a4f4:8950 with SMTP id
 d75a77b69052e-46734cac06dmr88863431cf.14.1733522090644; Fri, 06 Dec 2024
 13:54:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <4321a4aca4f67226165004b7096b417f88c11e7e.camel@kernel.org>
In-Reply-To: <4321a4aca4f67226165004b7096b417f88c11e7e.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Dec 2024 13:54:39 -0800
Message-ID: <CAJnrk1ZdPH5+gMqUEXFLJZ7fd9H7A_YsdU5jcM6kjp0WK_L4Aw@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Jeff Layton <jlayton@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:12=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2024-11-14 at 11:13 -0800, Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is deadlocked. Currently, there's no
> > good way to detect if a server is stuck and needs to be killed manually=
.
> >
> > This commit adds an option for enforcing a timeout (in minutes) for
> > requests where if the timeout elapses without the server responding to
> > the request, the connection will be automatically aborted.
> >
> > Please note that these timeouts are not 100% precise. The request may
> > take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> > timeout due to how it's internally implemented.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> > ---
> >  fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h | 21 +++++++++++++
> >  fs/fuse/inode.c  | 21 +++++++++++++
> >  3 files changed, 122 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 29fc61a072ba..536aa4525e8f 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> >               return -EINVAL;
> >       }
> > @@ -973,6 +979,8 @@ void fuse_conn_put(struct fuse_conn *fc)
> >
> >               if (IS_ENABLED(CONFIG_FUSE_DAX))
> >                       fuse_dax_conn_free(fc);
> > +             if (fc->timeout.req_timeout)
> > +                     timer_shutdown_sync(&fc->timeout.timer);
> >               if (fiq->ops->release)
> >                       fiq->ops->release(fiq);
> >               put_pid_ns(fc->pid_ns);
> > @@ -1691,6 +1699,18 @@ int fuse_init_fs_context_submount(struct fs_cont=
ext *fsc)
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
> >
> > +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_=
context *ctx)
> > +{
> > +     if (ctx->req_timeout) {
> > +             if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->ti=
meout.req_timeout))
> > +                     fc->timeout.req_timeout =3D ULONG_MAX;
> > +             timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> > +             mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIME=
R_FREQ);
> > +     } else {
> > +             fc->timeout.req_timeout =3D 0;
> > +     }
> > +}
> > +
>
>
> Does fuse_check_timeout need to run in IRQ context? It doesn't seem
> like it does. Have you considered setting up a recurring delayed
> workqueue job instead? That would run in process context, which might
> make the locking in that function less hairy.
>

Great idea, I'll use a recurring delayed workqueue job instead of a
kthread, since it's more lightweight.


Thanks,
Joanne
>
> >  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_cont=
ext *ctx)
> >  {
> >       struct fuse_dev *fud =3D NULL;
> > @@ -1753,6 +1773,7 @@ int fuse_fill_super_common(struct super_block *sb=
, struct fuse_fs_context *ctx)
> >       fc->destroy =3D ctx->destroy;
> >       fc->no_control =3D ctx->no_control;
> >       fc->no_force_umount =3D ctx->no_force_umount;
> > +     fuse_init_fc_timeout(fc, ctx);
> >
> >       err =3D -ENOMEM;
> >       root =3D fuse_get_root_inode(sb, ctx->rootmode);
>
> --
> Jeff Layton <jlayton@kernel.org>

