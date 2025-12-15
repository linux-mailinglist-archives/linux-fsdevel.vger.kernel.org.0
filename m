Return-Path: <linux-fsdevel+bounces-71358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D4CBF37F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A435A3005E8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8B312803;
	Mon, 15 Dec 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUNX59KV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F52EB841
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818400; cv=none; b=A0a+Et5BmaAD1ICzF+r8UiK71HssEUgrlWX7ynFVGekRJypDLI00kkV3Dlc05h/Lb23TtsEjrXAFm8bUED0xev88ivrujyzNQLbMyDu7QRdlQ1gJWuQWvUKL0z7Z+I3gpnNNfTQBAX3iA6rnJ8vobtayvJU+WTbf+IUA8jRNRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818400; c=relaxed/simple;
	bh=mk6fxjeyf6WodUAMSDPR1+yVt9ZM8VPAQ+DpWb51X3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV2aVvVB36vPejsH4yCP0PwYL6OLfK6/S3/CGJCaxD6Y9ntTFqJEFddhueD/ndYJCXrQjqN96MJgGsdiIAIoOnUcW1aBhbQIsNLg9yyOMwnvG38VNN1fF6nWDoODkui+SWj9dU3bzdXHtP0Renw39G+jGGeExiU+Nh8z8gH4r7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUNX59KV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-649820b4b3aso1054629a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765818396; x=1766423196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3Lr5M1Eh3DlRWyLf7Ai9/rnPnHZwbuj9GGv2H1V150=;
        b=UUNX59KVmYfeowfm6TJJBf9SYSJ7zDkBZlYTSfVPBrJDPShVt0pCoudF58hB3n4zcL
         39PgurfPvy58zVi+1izQmkHNVOcWouc9SAhK6mPO+WtEMkr+/o41HVQAsxbK1yG4LRkJ
         863n5C+f1vrULbPujT9HrQSA/KGUb7x0nb5+tXNTZOTs1F9S49si0X6dw/PfgC0L5kpq
         Zw6a4gKu9sJnJj0fQQwTwJLRX1C/nIQINJ5JopVMwTMzrbZc9oiIKPPftQCYU5d+UP1X
         aw03CVTQHaaJGG4sjJYBySMYahWYDo6uDuWlTc4VV4/pIihlDDkJdWhgGodEY0ueecPL
         1Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765818396; x=1766423196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3Lr5M1Eh3DlRWyLf7Ai9/rnPnHZwbuj9GGv2H1V150=;
        b=LyUR5DWGQL/NwUwP0mnYo43Z8pznzJOmzX9t9qUCWWd0ELOtdnfTgP/jE1a+SDotH4
         HmTxQXpHhPlkryU7HScdEosr+CoqG1eoU9xuob2PNqX1i45GydFK/KHAnUJVrWYoYteV
         jrIQ6w5YxAII0Hh8SoNiAsQh9VefkpDxJ8Lut6cpIITsihWhXT2ac/k3xMlrGB++FM/6
         3SU5fm2sq9FQPhlDZWhNeYEVXK0WtdSrkTUMIKr3hiTv7bBxKSI8Bl8PQfuf9Zdv93Au
         GgFehwrAvLso92AF0oG9hI0bhmqeBC537JnfIpJI5zlnGzEktingQuMwsImdruSAIrJs
         NBGA==
X-Forwarded-Encrypted: i=1; AJvYcCUyA0UgZagKRobbxnYkLOqMrc6+D75Lr94jMfNx11MJHLGu2kxaOfFXYyKVEqlWfo+/LzVc6OMA3q7IFIqw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7ZEGQ0yLbSfnExJVEGuuhNymbb2uPelbiYslQie3ylLgidyI
	XxXPx93dCCWb8s4muzjaSzSd8+h6TsMml086/cjaZKvc+2GVdTw96B2mI9N2uZd5XlhqTrXlt0Z
	AQxaHn4fB98hyj33sR1N+mKAROUX2iZw=
X-Gm-Gg: AY/fxX5SsNGvV1eiVlFMH7H6tQsZa6klajllOzIlGfGoQgwZokKRaxtXnlRCUwgJHos
	wxtCrFz7MDYa3tvpVhLyip4arkr5/uIEknJM61c4mV8L0hXmb5u8JTM1VVnmA4xREcK5uoFu/kA
	/I12eaVN9lrUQ6ugiR/80owpqn5oB9ijCgaNhvaMllxSno/IkqOrxgxt1Gsjg9x/57o7O8lNNnd
	T6rjcwN9+/rHIZXk08yYXh+VokO6fUv1p9nsHZ7Z1+Cwo3YuM9PmPONhghRo0wVVFK5ZrVMPlkL
	LMd1cUHd9pHKs2Re4INYio3PEDygSJe8GiT57KPO
X-Google-Smtp-Source: AGHT+IF2ahviMuH2nyVFWFlr1seQH3VoPQWUSrp8MfEVoM51h7Hwp1WaZqcRCBflotRrz9q5Vmxdw72arjMb+Ez5ykE=
X-Received: by 2002:a05:6402:3482:b0:649:9268:1f43 with SMTP id
 4fb4d7f45d1cf-6499b1fa7d5mr9246854a12.21.1765818396247; Mon, 15 Dec 2025
 09:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-4-luis@igalia.com>
 <87f48f32-ddc4-4c57-98c1-75bc5e684390@ddn.com>
In-Reply-To: <87f48f32-ddc4-4c57-98c1-75bc5e684390@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Dec 2025 18:06:24 +0100
X-Gm-Features: AQt7F2pu51pEzyBoPdDqMNTJ94ozn1tCzgFQ4BJcmKxur7T-oCJL5x8ulEFjzEY
Message-ID: <CAOQ4uxj_-_zbuCLdWuHQj4fx2sBOn04+-6F2WiC9SRdmcacsDA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
To: Bernd Schubert <bschubert@ddn.com>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 2:36=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> Hi Luis,
>
> I'm really sorry for late review.
>
> On 12/12/25 19:12, Luis Henriques wrote:
> > This patch adds the initial infrastructure to implement the LOOKUP_HAND=
LE
> > operation.  It simply defines the new operation and the extra fuse_init=
_out
> > field to set the maximum handle size.
> >
> > Signed-off-by: Luis Henriques <luis@igalia.com>
> > ---
> >   fs/fuse/fuse_i.h          | 4 ++++
> >   fs/fuse/inode.c           | 9 ++++++++-
> >   include/uapi/linux/fuse.h | 8 +++++++-
> >   3 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 1792ee6f5da6..fad05fae7e54 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -909,6 +909,10 @@ struct fuse_conn {
> >       /* Is synchronous FUSE_INIT allowed? */
> >       unsigned int sync_init:1;
> >
> > +     /** Is LOOKUP_HANDLE implemented by fs? */
> > +     unsigned int lookup_handle:1;
> > +     unsigned int max_handle_sz;
> > +
> >       /* Use io_uring for communication */
> >       unsigned int io_uring;
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index ef63300c634f..bc84e7ed1e3d 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1465,6 +1465,13 @@ static void process_init_reply(struct fuse_mount=
 *fm, struct fuse_args *args,
> >
> >                       if (flags & FUSE_REQUEST_TIMEOUT)
> >                               timeout =3D arg->request_timeout;
> > +
> > +                     if ((flags & FUSE_HAS_LOOKUP_HANDLE) &&
> > +                         (arg->max_handle_sz > 0) &&
> > +                         (arg->max_handle_sz <=3D FUSE_MAX_HANDLE_SZ))=
 {
> > +                             fc->lookup_handle =3D 1;
> > +                             fc->max_handle_sz =3D arg->max_handle_sz;
>
> I don't have a strong opinion on it, maybe
>
> if (flags & FUSE_HAS_LOOKUP_HANDLE) {
>         if (!arg->max_handle_sz || arg->max_handle_sz > FUSE_MAX_HANDLE_S=
Z) {
>                 pr_info_ratelimited("Invalid fuse handle size %d\n, arg->=
max_handle_sz)
>         } else {
>                 fc->lookup_handle =3D 1;
>                 fc->max_handle_sz =3D arg->max_handle_sz;

Why do we need both?
This seems redundant.
fc->max_handle_sz !=3D 0 is equivalent to fc->lookup_handle
isnt it?

Thanks,
Amir.

>         }
> }
>
>
> I.e. give developers a warning what is wrong?
>
>
> > +                     }
> >               } else {
> >                       ra_pages =3D fc->max_read / PAGE_SIZE;
> >                       fc->no_lock =3D 1;
> > @@ -1515,7 +1522,7 @@ static struct fuse_init_args *fuse_new_init(struc=
t fuse_mount *fm)
> >               FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
> >               FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
> >               FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDM=
AP |
> > -             FUSE_REQUEST_TIMEOUT;
> > +             FUSE_REQUEST_TIMEOUT | FUSE_LOOKUP_HANDLE;
> >   #ifdef CONFIG_FUSE_DAX
> >       if (fm->fc->dax)
> >               flags |=3D FUSE_MAP_ALIGNMENT;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index c13e1f9a2f12..4acf71b407c9 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
>
> I forget to do that all the time myself, I think it should also increase =
the
> minor version here and add add a comment for it.
>
> > @@ -495,6 +495,7 @@ struct fuse_file_lock {
> >   #define FUSE_ALLOW_IDMAP    (1ULL << 40)
> >   #define FUSE_OVER_IO_URING  (1ULL << 41)
> >   #define FUSE_REQUEST_TIMEOUT        (1ULL << 42)
> > +#define FUSE_HAS_LOOKUP_HANDLE       (1ULL << 43)
> >
> >   /**
> >    * CUSE INIT request/reply flags
> > @@ -663,6 +664,7 @@ enum fuse_opcode {
> >       FUSE_TMPFILE            =3D 51,
> >       FUSE_STATX              =3D 52,
> >       FUSE_COPY_FILE_RANGE_64 =3D 53,
> > +     FUSE_LOOKUP_HANDLE      =3D 54,
> >
> >       /* CUSE specific operations */
> >       CUSE_INIT               =3D 4096,
> > @@ -908,6 +910,9 @@ struct fuse_init_in {
> >       uint32_t        unused[11];
> >   };
> >
> > +/* Same value as MAX_HANDLE_SZ */
> > +#define FUSE_MAX_HANDLE_SZ 128
> > +
> >   #define FUSE_COMPAT_INIT_OUT_SIZE 8
> >   #define FUSE_COMPAT_22_INIT_OUT_SIZE 24
> >
> > @@ -925,7 +930,8 @@ struct fuse_init_out {
> >       uint32_t        flags2;
> >       uint32_t        max_stack_depth;
> >       uint16_t        request_timeout;
> > -     uint16_t        unused[11];
> > +     uint16_t        max_handle_sz;
> > +     uint16_t        unused[10];
> >   };
>
> No strong opinion either and just given we are slowly running out of
> available space. If we never expect to need more than 256 bytes,
> maybe uint8_t?
>
>
>
> Thanks,
> Bernd
>

