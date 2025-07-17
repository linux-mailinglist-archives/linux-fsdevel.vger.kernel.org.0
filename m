Return-Path: <linux-fsdevel+bounces-55206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB5B084B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB658581B79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 06:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97921322F;
	Thu, 17 Jul 2025 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHiJW8bA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EE86348;
	Thu, 17 Jul 2025 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732940; cv=none; b=U+jHcIex43EBEcOB0RU1HpPYk6E9cw4vAEtds5CMW6XSYZcTUYGBDYE5776+Cl/RakHEpz7XpMOHfGcyg6pWc9RBf8xJEdiDDQapSZOEd+sTCyhktLBIGdxsxzf38l/C0dbq8r3GppodhuTYTYooxW1vSGHYP1wkXDdl+MaCeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732940; c=relaxed/simple;
	bh=J7HZAi4MxMctytbEEW6jtB54JzLRiv6fOuFT8HQ+un0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXWMLa7C4ur9gOybKN5tsdFR1SMqL4b3mLlD9so0MO9Hrpf/xNn8EwFD4wSpYJvYbZXl+tC8rYBAxnRX1feSiPMMHpga+z4Qpam111VbNF/tjz5hchJsrk81EHG+Lhgebe34wbBceRJjQLNDq5BAh2sFoN7FFQ5HQ8dH4rf6hVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHiJW8bA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae9be1697easo306454666b.1;
        Wed, 16 Jul 2025 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752732936; x=1753337736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWK9T7uxShveKv2OINKVI60wo/1EKz/74tfEQ+WLpxE=;
        b=fHiJW8bA3I3lBZCul9JdKXl1FvT8kQhc0f4qDM4qBncQbL0ZHTPT5N8FGltxfFgnj/
         vMFViAZnKIL3PccM9HXSVhnnQPoJLz4J10rCRzHGcq6Pzh0SqwW/edJW622oVnySkcyR
         AT2YtI8/5bjzyJXiYZjjz4lBIx9wJolDgyiWiKUKSc3D1oV99/dsDCVbtqZV54Y1BnMR
         MhQw+eMK3sxmwHbbYZ4OCCAIzeR9LOcVWmJCBcXWCSMWlbgqOXWG1xGbS5t36xTXE7PJ
         vmeoDSUmucA5vU+CJDgJuuWLw/exuTON8DOFCsqW7ctlcZNzf0NcWa6Nzlljyi9fN0Ac
         xUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732936; x=1753337736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWK9T7uxShveKv2OINKVI60wo/1EKz/74tfEQ+WLpxE=;
        b=IF+RLJViSEjdPpSHF6h2dFuxZsj7SaCWQYHsrlX7eSxzqJrbnZLkDKiAvZ40DSeHW6
         L3wyzwPwlRTX/q2OBaABwuLqw4+3W69GQw526qc/V7OgIUpci7DByEFXeD74XeVYBewS
         wX9+wEkkkPPpPH2aOvGZ0hpnyk2avOZUAihlgiBZKESh8dIbK8Jg+/HRSDJtAS6jqiQg
         tG7WsBp2At2JNp+xZJl/NbQVJ9V9jfyUr7Ubcy8B+fcLGhc+a74f7XRKm4wVAZrw7I2m
         5pJ6ikvl4KmLpvKurOSzcejqgk3Jq2MAtLW1EQD7pfANkkIupGNf86gDExaomy4Wiwl3
         czJw==
X-Forwarded-Encrypted: i=1; AJvYcCVsPFEbWJoFEd3SkVPeq8iA6h43T+xTdfiZJjmAKL+TgvQ5Lf8zA3KFPD+WIbEXwQDPK6pdoQfAJwSQpL7Z@vger.kernel.org, AJvYcCXxP3VznvpyafIo9TWSfPvnBF6gMBcETQp9fJj4qSHayd+ACcTMo7gsWlxejfR2oouqCO3Y+lNLgU+QZDOi@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDb4jBr14C+rTpEWKeJMyBa7U86sw8t26wNWiAOR3ofKi5PgI
	+Fe14H7d6+UbiJvyC5gMDhrjthz5IHu886qBptYMTsoT09MfOrqlqiQcmA70hLOdoxPzovtmS/G
	Dg/b00zbXKE//ueIu2Zgf9KXFEKQBmek=
X-Gm-Gg: ASbGncu+IlrTQNPHPe1pgvtdXtp043zLSavGXATGf3yGNpg3vb0sDSmO07tGbkkGgyc
	AfhTHgLZZNOfu6GhvPyIALnOCRzRUEJyij9ejG6haE7JBzLbr0cia2dkX1l8St4h+Cfa8Il/uRN
	X+BBnt9jAQtzOxLvbvxk9DJOGB+GiwMNPv8iZzlQlFrBNrHxJ+oZxFzWDQUvZMGZgdFGlaYDLGH
	o5+qRs=
X-Google-Smtp-Source: AGHT+IEW1vd2j6/7Kl2E5AW+wNro2cyziOYCTWtBurrcxAOB5KKMqMZ9JVpsaZqw0H9v+74oRVg6qyHDJqRbvVns/F0=
X-Received: by 2002:a17:906:cad6:b0:ae8:8d00:76c3 with SMTP id
 a640c23a62f3a-aec4df557cbmr164793466b.29.1752732935897; Wed, 16 Jul 2025
 23:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716121036.250841-1-hanqi@vivo.com> <CAOQ4uxi5gwzkEYqpd+Bb825jwWME_AE0BNykZcownSz6OZjFWQ@mail.gmail.com>
 <aa24548c220134377b2c8a3d2d47620b9e492db1.camel@mediatek.com>
In-Reply-To: <aa24548c220134377b2c8a3d2d47620b9e492db1.camel@mediatek.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 17 Jul 2025 08:15:23 +0200
X-Gm-Features: Ac12FXwB1dfmkKHsC-8JhflLsZOybY0_pCAs9gjMvcn3Qh9JKagxp4AzGm-RlxI
Message-ID: <CAOQ4uxgMiQaMDOifxCuv1Vd=0gsWLjFj0h3t8W-yWB++4ftP0g@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: modification of FUSE passthrough call sequence
To: =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
Cc: "hanqi@vivo.com" <hanqi@vivo.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"liulei.rjpt@vivo.com" <liulei.rjpt@vivo.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:35=E2=80=AFAM Ed Tsai (=E8=94=A1=E5=AE=97=E8=BB=
=92) <Ed.Tsai@mediatek.com> wrote:
>
> On Wed, 2025-07-16 at 14:14 +0200, Amir Goldstein wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > On Wed, Jul 16, 2025 at 1:49=E2=80=AFPM Qi Han <hanqi@vivo.com> wrote:
> > >
> > > Hi, Amir
> >
> > Hi Qi,
> >
> > > In the commit [1], performing read/write operations with DIRECT_IO
> > > on
> > > a FUSE file path does not trigger FUSE passthrough. I am unclear
> > > about
> > > the reason behind this behavior. Is it possible to modify the call
> > > sequence to support passthrough for files opened with DIRECT_IO?
> >
> > Are you talking about files opened by user with O_DIRECT or
> > files open by server with FOPEN_DIRECT_IO?
> >
> > Those are two different things.
> > IIRC, O_DIRECT to a backing passthrough file should be possible.
> >
> > > Thank you!
> > >
> > > [1]
> > > https://lore.kernel.org/all/20240206142453.1906268-7-amir73il@gmail.c=
om/
> > >
> > > Reported-by: Lei Liu <liulei.rjpt@vivo.com>
> > > Signed-off-by: Qi Han <hanqi@vivo.com>
> > > ---
> > >  fs/fuse/file.c | 15 +++++++--------
> > >  1 file changed, 7 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 2ddfb3bb6483..689f9ee938f1 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -1711,11 +1711,11 @@ static ssize_t fuse_file_read_iter(struct
> > > kiocb *iocb, struct iov_iter *to)
> > >         if (FUSE_IS_DAX(inode))
> > >                 return fuse_dax_read_iter(iocb, to);
> > >
> > > -       /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> > > -       if (ff->open_flags & FOPEN_DIRECT_IO)
> > > -               return fuse_direct_read_iter(iocb, to);
> > > -       else if (fuse_file_passthrough(ff))
> > > +
> > > +       if (fuse_file_passthrough(ff))
> > >                 return fuse_passthrough_read_iter(iocb, to);
> > > +       else if (ff->open_flags & FOPEN_DIRECT_IO)
> > > +               return fuse_direct_read_iter(iocb, to);
> > >         else
> > >                 return fuse_cache_read_iter(iocb, to);
> > >  }
> > > @@ -1732,11 +1732,10 @@ static ssize_t fuse_file_write_iter(struct
> > > kiocb *iocb, struct iov_iter *from)
> > >         if (FUSE_IS_DAX(inode))
> > >                 return fuse_dax_write_iter(iocb, from);
> > >
> > > -       /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> > > -       if (ff->open_flags & FOPEN_DIRECT_IO)
> > > -               return fuse_direct_write_iter(iocb, from);
> > > -       else if (fuse_file_passthrough(ff))
> > > +       if (fuse_file_passthrough(ff))
> > >                 return fuse_passthrough_write_iter(iocb, from);
> > > +       else if (ff->open_flags & FOPEN_DIRECT_IO)
> > > +               return fuse_direct_write_iter(iocb, from);
> > >         else
> > >                 return fuse_cache_write_iter(iocb, from);
> > >  }
> > > --
> >
> > When server requests to open a file with FOPEN_DIRECT_IO,
> > it affects how FUSE_READ/FUSE_WRITE requests are made.
> >
> > When server requests to open a file with FOPEN_PASSTHROUGH,
> > it means that FUSE_READ/FUSE_WRITE requests are not to be
> > expected at all, so these two options are somewhat conflicting.
> >
> > Therefore, I do not know what you aim to achieve by your patch.
> >
> > However, please note this comment in iomode.c:
> >  * A combination of FOPEN_PASSTHROUGH and FOPEN_DIRECT_IO
> >    means that read/write
> >  * operations go directly to the server, but mmap is done on the
> > backing file.
> >
> > So this is a special mode that the server can request in order to do
> > passthrough mmap but still send FUSE_READ/FUSE_WRITE requests
> > to the server.
>
> Hi Amir,
>
> In most cases, when using passthrough, the server shouldn't set
> FOPEN_DIRECT_IO, since these two options are conceptually conflicting,
> unless the server specifically wants this special mode (passthrough
> mmap but still send r/w requests). Is that correct?
>

Yes, correct.

See this fix in libfuse for a similar confusion:
https://github.com/libfuse/libfuse/pull/1031

> It can be confusing. Maybe the documentation could clarify this special
> case,

Any documentation would be great.
Documentation patches are most welcome.

> or the passthrough flags for mmap and r/w could be separate...
>

I don't think that's the solution, but it's too hard to explain why
(read fs/fuse/iomode.c to get the idea)

direct_io mode is the mode for doing read/write to the server
without using page cache, so by definition it is not applicable
to mmap().
OTOH, passthrough mode is applicable to read/write/mmap

direct_io mode can be requested EITHER by user (O_DIRECT)
OR by server (FOPEN_DIRECT_IO), therefore setting
FOPEN_DIRECT_IO in server upon user request of O_DIRECT
is somewhat redundant.

However, it is a reason in the libfuse passthrough examples -
Unlike O_DIRECT, which the user can recall after open,
FOPEN_DIRECT_IO is sticky and cannot be changed on an
open file, so that's a way for the server to express, if a user
requested open O_DIRECT, the user cannot back down from this
request, which can be useful for enabling kernel features as parallel DIO.

> >
> > What is your use case? What are you trying to achieve that is not
> > currently possible?
> >
> > Thanks,
> > Amir.
> >
>
> Hi Qi,
>
> I just notice that Android's FuseDaemon doesn't seem to recognize this
> special mode. It sets both FOPEN_DIRECT_IO and FOPEN_PASSTHROUGH when
> the user sets O_DIRECT and the server has passthrough enabled.
>
> If that's your case, I think Android FuseDaemon may need some fixes.
>

Because there is no proper documentation for the interdependencies
of these two modes, let me just say when a server might need to set both fl=
ags.

If a server's decision to passthrough io is not always consistent for the s=
ame
inode, for example, server wants to passthrough opens for read and not
passthrough open for writes.

This situation is not allowed by kernel iomode restrictions if both
files are open at the same time in conflicting modes.

Unless, the non-passthrough files (e.g. open for write) are open with
FOPEN_DIRECT_IO | FOPEN_PASSTHROUGH.
This mode will not passthrough read/write on this file, but it does not
conflict with other files open (e.g. for read) in passthrough mode.

I know, it's confusing.
The way to think about it is that a passthrough-mostly server
should set FOPEN_PASSTHROUGH for all opens, but it can opt-out
of passthrough read/write on individual files with FOPEN_DIRECT_IO.

And none of this has any relation to O_DIRECT.

Thanks,
Amir.

