Return-Path: <linux-fsdevel+bounces-33260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 726B19B692D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0773B22B49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F309214420;
	Wed, 30 Oct 2024 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl2LV8xT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89025213120
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305750; cv=none; b=PhF7Xcs3Edh+5HmU4JMbTSSl0N+WbN/b0NrQTdtoYIO2RrcbBYR6p8ekoWH2FMAKolVh3N/MPWe6OVb1mupEYtc7j2nMpyR41WyS6bFWNsXHq6xHZkPiy/E7zTfAQJUT0TmVt89T3/m5RmEm2dQ3uyOQQZaze1vrELIOFNORqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305750; c=relaxed/simple;
	bh=aw+PaUhb2P+V5LoUP0c7Xm1ui2h/VxbHR+P/qskA9Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4HTcMWck6FNSsuWCmzMOzwC8rBomVrKuL2KtOsVW+F4P2PXJclLCfSt7DNy2ZkZGEHN9OSaChQpcx9XzAy+Y6O6tMSp8FbP6E7EqKJTsJ9lCWtts1xAhX3UqwBuvaNrBtE2QQXAaDSLfkMelTR4+BxBVy5VyqduV/DvgIIr0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl2LV8xT; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebc1af8f10so37250eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730305747; x=1730910547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xaYmoWQF6LlSespu713bKkqGPFuMGeu7IuRT9OwfEw=;
        b=Yl2LV8xTShzL0MSbLcGxJf1K6kmsiGyehHFaiQu+6+qJuo5bq1qbD201CTrg+OUvL+
         g+oAxrbQsB3QlVG+ZY3j24ipiov/ICUo3QTCnfOcPm3Ly4NkzK0VjimDeYV5EZ3mYM5v
         m2y9MCaLdo3JEAYPa+BBhC1YTrFDN1YsRdmDAcGpZLpRunz/i3ZV/GRjCOmq7qyPYsce
         tpZ+6D+KyeKvXMW3ialMBeXcANryXHgnVxK0XLs4HPK+qdalPlbboC/XjsH3lTBdCdrr
         lWNP8rUuKWcDbZ9cz4DCglxftkkJaU8JWqKv7EMkKJQf2wEpvRAVQGLFJAiQBokKhdF5
         iYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305747; x=1730910547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xaYmoWQF6LlSespu713bKkqGPFuMGeu7IuRT9OwfEw=;
        b=Gyn2WXm4eSn6x7/+leHhNMEBLdTkOuAN+Z/UUVQNCoFdywR77jj70Vb4xaEDKEC1bj
         0yFajHnEeifOq1LLRHJLxubBGRhL1KneTKBYeGqN4tnz4uywQ32pyFicabxoMeMOaTnf
         FewSIzwMN8bS7cbyu+44C/dQG6ld6kjeAQB6NCrGMeXRLuPu6R0tyHk/E3YdB3d9dLzp
         kJwYQHKEQGk/PmBOBYgUMhXWSYg5i7abcPg+1brIEXuHBm6guPw8VQ72Q14975IC8jfl
         rWB6l/W8SwLr5yqlpk/TfSeI7b0PNL5rMajY1DXaCgz4qLLoSMSEzhnGt6ituc2tqfUC
         i4tw==
X-Forwarded-Encrypted: i=1; AJvYcCUL2V9XEqlII72bpZ6HlLECJc+lX7Hn6rv1vNp+9Fi7lTpT0msVbMfszIy3k1rjaidZ7kFRBXmCpiIoF8W+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qrcEyiKwNgBrCd/baDPJxOZKBytVC2izy6vh3NurYQ0Nh3Y8
	wz5Jm5a/1Q6CCAzPrjZG21yv74n0uTAUEDJ7zDjlZE4iJKDYQikGYMuVf7JAu1luccY+0zfOzho
	gmHhIbhXiVAGao7Z1pQjAc6VLkks=
X-Google-Smtp-Source: AGHT+IEOLIm93xa9jsbI6lma3PmoQYeJCWNc7z0yQ1/u0I8TwyQqgs4Scvhx5vjkyPAMGUq1q9v9+7aUWlR77XIMwDA=
X-Received: by 2002:a05:6358:9108:b0:1c3:9cf5:2866 with SMTP id
 e5c5f4694b2df-1c3f9d4b9c5mr838208855d.6.1730305747433; Wed, 30 Oct 2024
 09:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011191320.91592-1-joannelkoong@gmail.com>
 <20241011191320.91592-2-joannelkoong@gmail.com> <676b106a-d60f-46fc-848c-dd67a6e2d36e@fastmail.fm>
In-Reply-To: <676b106a-d60f-46fc-848c-dd67a6e2d36e@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 30 Oct 2024 09:28:56 -0700
Message-ID: <CAJnrk1Y26w=k0YLnjtXEfhMy1K0QhqFd=v-wenST4=LfX3zp3Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] fs_parser: add fsparam_u16 helper
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:58=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 10/11/24 21:13, Joanne Koong wrote:
> > Add a fsparam helper for unsigned 16 bit values.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fs_parser.c            | 14 ++++++++++++++
> >  include/linux/fs_parser.h |  9 ++++++---
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > index 24727ec34e5a..0e06f9618c89 100644
> > --- a/fs/fs_parser.c
> > +++ b/fs/fs_parser.c
> > @@ -210,6 +210,20 @@ int fs_param_is_bool(struct p_log *log, const stru=
ct fs_parameter_spec *p,
> >  }
> >  EXPORT_SYMBOL(fs_param_is_bool);
> >
> > +int fs_param_is_u16(struct p_log *log, const struct fs_parameter_spec =
*p,
> > +                 struct fs_parameter *param, struct fs_parse_result *r=
esult)
> > +{
> > +     int base =3D (unsigned long)p->data;
> > +     if (param->type !=3D fs_value_is_string)
> > +             return fs_param_bad_value(log, param);
> > +     if (!*param->string && (p->flags & fs_param_can_be_empty))
> > +             return 0;
> > +     if (kstrtou16(param->string, base, &result->uint_16) < 0)
> > +             return fs_param_bad_value(log, param);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(fs_param_is_u16);
> > +
> >  int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec =
*p,
> >                   struct fs_parameter *param, struct fs_parse_result *r=
esult)
> >  {
> > diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> > index 6cf713a7e6c6..1c940756300c 100644
> > --- a/include/linux/fs_parser.h
> > +++ b/include/linux/fs_parser.h
> > @@ -26,9 +26,10 @@ typedef int fs_param_type(struct p_log *,
> >  /*
> >   * The type of parameter expected.
> >   */
> > -fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_p=
aram_is_u64,
> > -     fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_=
is_blockdev,
> > -     fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gi=
d;
> > +fs_param_type fs_param_is_bool, fs_param_is_u16, fs_param_is_u32, fs_p=
aram_is_s32,
> > +     fs_param_is_u64, fs_param_is_enum, fs_param_is_string, fs_param_i=
s_blob,
> > +     fs_param_is_blockdev, fs_param_is_path, fs_param_is_fd, fs_param_=
is_uid,
> > +     fs_param_is_gid;
> >
> >  /*
> >   * Specification of the type of value a parameter wants.
> > @@ -55,6 +56,7 @@ struct fs_parse_result {
> >       union {
> >               bool            boolean;        /* For spec_bool */
> >               int             int_32;         /* For spec_s32/spec_enum=
 */
> > +             u16             uint_16;        /* For spec_u16 *
> >               unsigned int    uint_32;        /* For spec_u32{,_octal,_=
hex}/spec_enum */
>
> Given fs_param_is_u16() has "int base =3D (unsigned long)p->data;",
> shouldn't the comment also mention ",_octal,_hex}/spec_enum"?
> Or should the function get slightly modified to always use a base of 10?
> Or 0 with auto detection as for fs_param_is_u64()?

Thanks for taking a look at this patchset, Bernd!

I'm not sure what the correct answer here is either with whether this
should follow fs_param_is_u32() or fs_param_is_u64(). I leaned towards
fs_param_is_u32() because that seemed more permissive in supporting
octal/hex.

I see in the commit history (commit 328de5287b10a) that Al Viro added
both of these. After the fuse parts of this patchset gets feedback
from Miklos, I'll cc Al on the next iteration and hopefully that
should give us some more clarity.


Thanks,
Joanne

>
> >               u64             uint_64;        /* For spec_u64 */
> >               kuid_t          uid;
> > @@ -119,6 +121,7 @@ static inline bool fs_validate_description(const ch=
ar *name,
> >  #define fsparam_flag_no(NAME, OPT) \
> >                       __fsparam(NULL, NAME, OPT, fs_param_neg_with_no, =
NULL)
> >  #define fsparam_bool(NAME, OPT)      __fsparam(fs_param_is_bool, NAME,=
 OPT, 0, NULL)
> > +#define fsparam_u16(NAME, OPT)       __fsparam(fs_param_is_u16, NAME, =
OPT, 0, NULL)
> >  #define fsparam_u32(NAME, OPT)       __fsparam(fs_param_is_u32, NAME, =
OPT, 0, NULL)
> >  #define fsparam_u32oct(NAME, OPT) \
> >                       __fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)=
8)
>
>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

