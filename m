Return-Path: <linux-fsdevel+bounces-24926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2D946A94
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34CB281BFE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772C14A84;
	Sat,  3 Aug 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkR5miN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A511078B
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704773; cv=none; b=rifCxVm4smOqwf/imKkX2O6eUcSk0LILruT97prLKQVebdZDU1Ypqom9JEkhCUv7Lloj/TgfaiCjo+IvHlB5ON2g7ms+YxVrfrAXhYYflrdKldRnkDZqb4AHTSmHuxg2DwYpJLHeS2ESHWSIqdMDw6jT+m9IzGObC/xU1FiJ35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704773; c=relaxed/simple;
	bh=AvozvX9rFpfrjge9qVIu4Lpkp8h9oFJyHO+fPphLNB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl0BT2Y6PWJviqee3X+g7sDPJufj0JD5n/s3c91zHivUFLALbfmR8OAqmjMA9ebEWSNcn5DzZn+7MXafwT9HXHQxeLyZnnWkpf0F+nrUpXKT2vylK5Q+SeOVvooIBKvyixkMbgNUxsykQJfvdJAxkmYCCNZhX7mjvc7rg/o7NCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkR5miN8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1e0ff6871so514913385a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722704771; x=1723309571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOjWvc2CxQzrfY0RlVzIJ1LY/w0zrHllNgng1y0TnGo=;
        b=VkR5miN8dIrnELy7rZmCCwaRjPhyLwvfkUTDomKbdcgfayUhNhHzkv5nSmowg5l9id
         cfL2Vd3pTx6Eev6BNqlcAmMqliLQOASDypUWZCMzXdMqIBH9Yh19JUlfWaPwsu/+KCTv
         JVI25fQQAqa+h5P2Ejy88ycYbOOcATRT3dypzvY7Bne7629hoodw5Lc3lN66RQKbqIyw
         xvLN/IMPEchQYwAce1D67rdtOxG50X2HNZgfljVDiySKIIGgJyERMWLtg3xuOubL9p8Q
         Ziq4Y/Wu68FfJvF0GdMax72FO2LNImHpDSskCbWNwQKdP6Wxh73H5rzqHKPYrZ68AZA4
         dC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722704771; x=1723309571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOjWvc2CxQzrfY0RlVzIJ1LY/w0zrHllNgng1y0TnGo=;
        b=HLJOZTGp5i/jiFmKJg/F6kzuF6s7cyJapSqxu6kgmhf0FTIKNrjE4aj/QDWVwB1w/l
         W3VXcm2FMMSmPO+eM+ypUw2Z8LihMbsUoY9czRFlpq8JL9GdQPnxRZ/LsUDOHm7X0itZ
         /4q/iOuZv4LZmp8X0/A+2S/rJxiAbNo1+c1fZvVAwbBTSHjsoNHQVOHA7TAw2883w5Xa
         3E4WmCDq9klkR3x1Zhgl5P/DJXPYEhEnSKWTbLp1eoyCkG2sYFHf0AodqKcup7xgzqFf
         drUfpyQFufBZGT6YPDXPAhpNOxJw5ubvvS1zyPwV9okZKWweif2U3mndXEJ9PUj8bIqB
         LW5g==
X-Forwarded-Encrypted: i=1; AJvYcCVhxN92P9uMrwRYE5NAyTGXS5s2yvwoGucycpnzdY2F9L7jOmJjMHZSIvsauaiWV7Rxub9Abulw/JibRFyP3e6YXkNB7kDGIPIQvD8U8w==
X-Gm-Message-State: AOJu0YxCzX1kAtWGLNWiCxSfO0rD5RdwAaqhhcdMSv+dJAss4D5R9lkm
	crrSvwnmW0wnprytvrsWksHS4CqoNOfwlUUQhMC86qF1Ac5IGEEoTLxr7mr8txkq9L98VvCAkn7
	crEJSXr8pX1yxNaJxkDazBLAtvyD2gFqY
X-Google-Smtp-Source: AGHT+IEB/t32jrRwk+ukjlSSSVSPquf+qlhBsaanizHjwJ7nG+GfgxC3Csf5KWQEDXn1Pin/AIIpyIF91PZpx8gLnEs=
X-Received: by 2002:a05:620a:28c8:b0:7a1:e989:7aed with SMTP id
 af79cd13be357-7a34efba611mr744790185a.62.1722704770832; Sat, 03 Aug 2024
 10:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <fe7827974f5aec3403b07e8e70c020422126deaa.1721931241.git.josef@toxicpanda.com>
 <20240801211432.4u6gwkbyfzvobvhf@quack3>
In-Reply-To: <20240801211432.4u6gwkbyfzvobvhf@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 3 Aug 2024 19:06:00 +0200
Message-ID: <CAOQ4uxhAh9B6j5LaFb1LDsm1UbyZawUGmMAa86G=A9s58qrWEw@mail.gmail.com>
Subject: Re: [PATCH 09/10] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:14=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 25-07-24 14:19:46, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > With FAN_DENY response, user trying to perform the filesystem operation
> > gets an error with errno set to EPERM.
> >
> > It is useful for hierarchical storage management (HSM) service to be ab=
le
> > to deny access for reasons more diverse than EPERM, for example EAGAIN,
> > if HSM could retry the operation later.
> >
> > Allow fanotify groups with priority FAN_CLASSS_PRE_CONTENT to responsd
> > to permission events with the response value FAN_DENY_ERRNO(errno),
> > instead of FAN_DENY to return a custom error.
> >
> > Limit custom error to values to some errors expected on read(2)/write(2=
)
>         ^^^ parse error. Perhaps: "Limit custom error values to errors
> expected on read..."
>
> > and open(2) of regular files. This list could be extended in the future=
.
> > Userspace can test for legitimate values of FAN_DENY_ERRNO(errno) by
> > writing a response to an fanotify group fd with a value of FAN_NOFD
> > in the fd field of the response.
> >
> > The change in fanotify_response is backward compatible, because errno i=
s
> > written in the high 8 bits of the 32bit response field and old kernels
> > reject respose value with high bits set.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ...
>
> > @@ -258,18 +258,25 @@ static int fanotify_get_response(struct fsnotify_=
group *group,
> >       }
> >
> >       /* userspace responded, convert to something usable */
> > -     switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
> > +     switch (FAN_RESPONSE_ACCESS(event->response)) {
> >       case FAN_ALLOW:
> >               ret =3D 0;
> >               break;
> >       case FAN_DENY:
> > +             /* Check custom errno from pre-content events */
> > +             errno =3D FAN_RESPONSE_ERRNO(event->response);
> > +             if (errno) {
> > +                     ret =3D -errno;
> > +                     break;
> > +             }
> > +             fallthrough;
> >       default:
> >               ret =3D -EPERM;
> >       }
> >
> >       /* Check if the response should be audited */
> >       if (event->response & FAN_AUDIT)
> > -             audit_fanotify(event->response & ~FAN_AUDIT,
> > +             audit_fanotify(FAN_RESPONSE_ACCESS(event->response),
> >                              &event->audit_rule);
>
> I think you need to also keep FAN_INFO in the flags not to break some
> userspace possibly parsing audit requests.
>
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index c3c8b2ea80b6..b4d810168521 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -337,11 +337,12 @@ static int process_access_response(struct fsnotif=
y_group *group,
> >       struct fanotify_perm_event *event;
> >       int fd =3D response_struct->fd;
> >       u32 response =3D response_struct->response;
> > +     int errno =3D FAN_RESPONSE_ERRNO(response);
> >       int ret =3D info_len;
> >       struct fanotify_response_info_audit_rule friar;
> >
> > -     pr_debug("%s: group=3D%p fd=3D%d response=3D%u buf=3D%p size=3D%z=
u\n", __func__,
> > -              group, fd, response, info, info_len);
> > +     pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=3D%=
p size=3D%zu\n",
> > +              __func__, group, fd, response, errno, info, info_len);
> >       /*
> >        * make sure the response is valid, if invalid we do nothing and =
either
> >        * userspace can send a valid response or we will clean it up aft=
er the
> > @@ -350,9 +351,33 @@ static int process_access_response(struct fsnotify=
_group *group,
> >       if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
> >               return -EINVAL;
> >
> > -     switch (response & FANOTIFY_RESPONSE_ACCESS) {
> > +     switch (FAN_RESPONSE_ACCESS(response)) {
> >       case FAN_ALLOW:
> > +             if (errno)
> > +                     return -EINVAL;
> > +             break;
> >       case FAN_DENY:
> > +             /* Custom errno is supported only for pre-content groups =
*/
> > +             if (errno && group->priority !=3D FSNOTIFY_PRIO_PRE_CONTE=
NT)
> > +                     return -EINVAL;
> > +
> > +             /*
> > +              * Limit errno to values expected on open(2)/read(2)/writ=
e(2)
> > +              * of regular files.
> > +              */
> > +             switch (errno) {
> > +             case 0:
> > +             case EIO:
> > +             case EPERM:
> > +             case EBUSY:
> > +             case ETXTBSY:
> > +             case EAGAIN:
> > +             case ENOSPC:
> > +             case EDQUOT:
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >               break;
> >       default:
> >               return -EINVAL;
> > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > index ae6cb2688d52..76d818a7d654 100644
> > --- a/include/linux/fanotify.h
> > +++ b/include/linux/fanotify.h
> > @@ -132,7 +132,14 @@
> >  /* These masks check for invalid bits in permission responses. */
> >  #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
> >  #define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
> > -#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOT=
IFY_RESPONSE_FLAGS)
> > +#define FANOTIFY_RESPONSE_ERRNO      (FAN_ERRNO_MASK << FAN_ERRNO_SHIF=
T)
> > +#define FANOTIFY_RESPONSE_VALID_MASK \
> > +     (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
> > +      FANOTIFY_RESPONSE_ERRNO)
> > +
> > +/* errno other than EPERM can specified in upper byte of deny response=
 */
> > +#define FAN_RESPONSE_ACCESS(res)     ((res) & FANOTIFY_RESPONSE_ACCESS=
)
> > +#define FAN_RESPONSE_ERRNO(res)              ((int)((res) >> FAN_ERRNO=
_SHIFT))
>
> I have to say I find the names FANOTIFY_RESPONSE_ERRNO and
> FAN_RESPONSE_ERRNO() (and similarly with FAN_RESPONSE_ACCESS) very simila=
r
> and thus confusing. I was staring at it for 5 minutes wondering how comes
> it compiles before I realized one prefix is shorter than the other one so
> the indentifiers are indeed different. Maybe we'd make these inline
> functions instead of macros and name them like:
>
> fanotify_get_response_decision()
> fanotify_get_response_errno()

Sounds good to me.

Thanks,
Amir.

