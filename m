Return-Path: <linux-fsdevel+bounces-13361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D486EFF6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 10:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76511F21BB6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC41754E;
	Sat,  2 Mar 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjzLYDSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE49168A8
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709373507; cv=none; b=rTYbV5YA7y4gRlyn0YTQwULuuZ720ohr4MaOIZaF17sWBqCkoKJxRiaPnC0GYTJkJJBQmw3CtpqFp4VUKlcMWEkkLq/fR63ZCzWUel7vGKWlT8z+n2vOsYQFLwYjDgp1lfkQZveMtRITjYRfXNEHPsdVy0kd/W3mb5nOhxyXeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709373507; c=relaxed/simple;
	bh=cFAVzIBKyWhB4tJd2qIKQd15JGJMtLdlZVJR7ttoYIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWwyAvIvK8chUuJbWzCab9AlD5RPLPEn1UOpQVfrEjBifklFTSY1gajzNyCCme2R9tOWTZn0PIe1T7qSBJ/YNBUq1QmRhnZAcLzKmeUUBg55UeIPTfsQLluR4pgmcylHVkmsijcITgX53DxRYfRhUtE35Asl5BmunjQtx27zRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjzLYDSu; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a04dd6721dso878964eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709373505; x=1709978305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQP2S44rlugSzYTmSOMpO47ui2mTVjd+h3dyvmIHHBk=;
        b=ZjzLYDSunmScvZsxxVkAvpmt/itGOM4HQMj0E+JHGy186kyE9w8zUkW+AixBwgUHMG
         4GYgU0xwmqWgQwNo/vzm3i8631FUENwuL0Q+Umt1QQcyCZey6cLh4/sVa/X6GWxb3imw
         A6KPiUkpolB0sU3KBDgP1Ty4c7VKe9aezldnYbHhOnyYLi2oqpyuUUvE+6FaBqD3e3Sm
         hpHu7Nk7z928L2xpFRtqOm3H/WrXsiH6YUdXXdAzGlZrcsTqHQbIm1TQc/XN4/MiaEdB
         r1ePDk9K1X6oj1b0BpHCEoNd6s+xlRBWqaZopuVw2RVuA7M+rZVs5hlDDlXLRuVTxKmh
         THcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709373505; x=1709978305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQP2S44rlugSzYTmSOMpO47ui2mTVjd+h3dyvmIHHBk=;
        b=KjXu2asIuV9aIdI1ffFnS6IfoYOnZN4wTtL3Q9Pfl4I0UTZuXZ/2y29yL5YIgkgByl
         d6gDOPMgZ4VaEHwYXqGESdSqRXPJU9s6kL6oQk1UT0Q3MqD7+6nGvJvk4JqSHu5nYbRK
         8nmf6xh9ZhDS9yspfxAde3zHorv65fKUMxCD1Rdd/w/ei+2obdSNIAXiWGSrnq0XFheW
         i6MjstZU/R34D53w4egMQA5aNSNCmWLUIyqlOllDleipDOWsOYZVlYBMKVqfkkkOjWpD
         ABMcX6i4nhNEV+nrC5m4Z/ISQatmwWk5fFXJBiDFR8kmV568gWwHczGtuWmfETEGXtNc
         qkOA==
X-Forwarded-Encrypted: i=1; AJvYcCVxWEe49nEJAHqpLF1jayjoKNolbZlG8aTsGG1rEZ2xR1QZ+Dnskd4R4wLlx1x29TAnAnHST7DZTxAQt6I+WaLBfnwZRZ17aexEVaJAkg==
X-Gm-Message-State: AOJu0YywxBDt0UB07MOqG0T93QRGqbWxMt76zgtnuCCZOLEP8fkcPuHp
	CI1ahariTz6BFLxUMmYP8a3qhj3EHevgvuFjUe5dG+WeMqEIe4vSH5SZEtmbhnu4VIBigMb+MFb
	X33Ql5O9R6BxhM941zWxyFK/0rPw=
X-Google-Smtp-Source: AGHT+IHCg+f2SRiasNxdJkrEKNuGbh9xZYXJvQGmeeJjG3KgEFz3sgPhzYgXYmLj4OYwx+pHUCqgGKirOmOnIfjgX4s=
X-Received: by 2002:a05:6358:7e53:b0:17b:f109:c7f3 with SMTP id
 p19-20020a0563587e5300b0017bf109c7f3mr4284213rwm.22.1709373504658; Sat, 02
 Mar 2024 01:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229174145.3405638-1-meted@linux.ibm.com> <CAOQ4uxh+Od_+ZuLDorbFw6nOnsuabOreH4OE=uP_JE53f0rotA@mail.gmail.com>
 <fc1ac345-6ec5-49dc-81db-c46aa62c8ae1@linux.ibm.com>
In-Reply-To: <fc1ac345-6ec5-49dc-81db-c46aa62c8ae1@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 2 Mar 2024 11:58:13 +0200
Message-ID: <CAOQ4uxje7JGvSrrsBC=wLugjqtGMfADMqUBKPhcOULErZQjmGA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: move path permission and security check
To: Mete Durlu <meted@linux.ibm.com>
Cc: jack@suse.cz, repnop@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:16=E2=80=AFPM Mete Durlu <meted@linux.ibm.com> wro=
te:
>
> On 3/1/24 10:52, Amir Goldstein wrote:
> > On Thu, Feb 29, 2024 at 7:53=E2=80=AFPM Mete Durlu <meted@linux.ibm.com=
> wrote:
> >>
> >> In current state do_fanotify_mark() does path permission and security
> >> checking before doing the event configuration checks. In the case
> >> where user configures mount and sb marks with kernel internal pseudo
> >> fs, security_path_notify() yields an EACESS and causes an earlier
> >> exit. Instead, this particular case should have been handled by
> >> fanotify_events_supported() and exited with an EINVAL.
> >
> > What makes you say that this is the expected outcome?
> > I'd say that the expected outcome is undefined and we have no reason
> > to commit to either  EACCESS or EINVAL outcome.
>
> TLDR; I saw the failing ltp test(fanotify14) started investigating, read
> the comments on the related commits and noticed that the fanotify
> documentation does not mention any EACESS as an errno. For these reasons
> I made an attempt to provide a fix. The placement of the checks aim
> minimal change, I just tried not to alter the logic more than needed.
> Thanks for the feedback, will apply suggestions.
>

Generally speaking, the reasons above themselves are good enough
reasons for fixing the documentation and fixing the test code, but not
enough reasons to change the code.

There may be other good reasons for changing the code, but I am not
sure they apply here.

>
> The main reason is the following commit;
> * linux: 69562eb0bd3e ("fanotify: disallow mount/sb marks on kernel
> internal pseudo fs")
>
> fanotify_user: fanotify_events_supported()
>      /*
>       * mount and sb marks are not allowed on kernel internal pseudo
>           * fs, like pipe_mnt, because that would subscribe to events on
>           * all the anonynous pipes in the system.
>       */
>      if (mark_type !=3D FAN_MARK_INODE &&
>          path->mnt->mnt_sb->s_flags & SB_NOUSER)
>          return -EINVAL;
>
> It looks to me as, when configuring fanotify_mark with pipes and
> FAN_MARK_MOUNT or FAN_MARK_FILESYSTEM, the path above should be taken
> instead of an early return with EACCES.
>

It is a subjective opinion. I do not agree with it, but it does not matter =
if
I agree with this statement or not, what matters it that there is no clear
definition across system calls of what SHOULD happen in this case
and IMO there is no reason for us to commit to this behavior or the other.

> Also the following commit on linux test project(ltp) expects EINVAL as
> expected errno.
>
> * ltp: 8e897008c ("fanotify14: Test disallow sb/mount mark on anonymous
> pipe")
>
> To be honest, the test added on above commit is the main reason why I
> started investigating this.
>

This is something that I don't understand.
If you are running LTP in a setup that rejects fanotify_mark() due to
security policy, how do the rest of the fanotify tests pass?
I feel like I am missing information about the test regression report.
I never test with a security policy applied so I have no idea what
might be expected.

> > I don't really mind the change of outcome, but to me it seems
> > nicer that those tests are inside fanotify_find_path(), so I will
> > want to get a good reason for moving them out.
>
> I agree, when those tests are inside fanotify_find_path() it looks much
> cleaner but then the check for psuedo fs in fanotify_events_supported()
> is not made. And I believe when configuring fanotify an EINVAL makes
> more sense than EACCES, it just seems more informative(at least to me).
> Would it maybe make sense to put them in a separate helper function,
> sth like:
>
> static int fanotify_path_security(struct path *path,
>                                   __u64 mask,
>                                   unsigned int obj_type) {
>         int ret;
>
>         ret =3D path_permission(path, MAY_READ);
>         if (ret)
>                 return ret;
>         ret =3D security_path_notify(path, mask, obj_type);
>         return ret;
> }
>

*if* we agree that a change to code is needed, then this helper
would be very nice.

> ...
>
> ret =3D fanotify_path_security(...)
> if (ret)
>         goto path_put_and_out;
>
> >>
> >> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/f=
anotify_user.c
> >> index fbdc63cc10d9..14121ad0e10d 100644
> >> --- a/fs/notify/fanotify/fanotify_user.c
> >> +++ b/fs/notify/fanotify/fanotify_user.c
> >> @@ -1015,7 +1015,7 @@ static int fanotify_find_path(int dfd, const cha=
r __user *filename,
> >>                          fdput(f);
> >>                          goto out;
> >>                  }
> >> -
> >> +               ret =3D 0;
> >
> > Better convert all gotos in this helper to return.
> > There is nothing in the out label.
> >
> Good point, will do!
>
> >>                  *path =3D f.file->f_path;
> >>                  path_get(path);
> >>                  fdput(f);
> >> @@ -1028,21 +1028,7 @@ static int fanotify_find_path(int dfd, const ch=
ar __user *filename,
> >>                          lookup_flags |=3D LOOKUP_DIRECTORY;
> >>
> >>                  ret =3D user_path_at(dfd, filename, lookup_flags, pat=
h);
> >> -               if (ret)
> >> -                       goto out;
> >>          }
> >> -
> >> -       /* you can only watch an inode if you have read permissions on=
 it */
> >> -       ret =3D path_permission(path, MAY_READ);
> >> -       if (ret) {
> >> -               path_put(path);
> >> -               goto out;
> >> -       }
> >> -
> >> -       ret =3D security_path_notify(path, mask, obj_type);
> >> -       if (ret)
> >> -               path_put(path);
> >> -
> >>   out:
> >>          return ret;
> >>   }
> >> @@ -1894,6 +1880,14 @@ static int do_fanotify_mark(int fanotify_fd, un=
signed int flags, __u64 mask,
> >>                  if (ret)
> >>                          goto path_put_and_out;
> >>          }
> >> +       /* you can only watch an inode if you have read permissions on=
 it */
> >> +       ret =3D path_permission(&path, MAY_READ);
> >> +       if (ret)
> >> +               goto path_put_and_out;
> >> +
> >> +       ret =3D security_path_notify(&path, mask, obj_type);
> >> +       if (ret)
> >> +               goto path_put_and_out;
> >>
> >>          if (fid_mode) {
> >>                  ret =3D fanotify_test_fsid(path.dentry, flags, &__fsi=
d);
> >
> > If we do accept your argument that security_path_notify() should be
> > after fanotify_events_supported(). Why not also after fanotify_test_fsi=
d()
> > and fanotify_test_fid()?
>
> I tried to place the checks as close as possible to their original
> position, that is why I placed them right after
> fanotify_events_supported(). I wanted to keep the ordering as close as
> possible to original to not break any other check. I am open to
> suggestions regarding this.
>

It is a matter of principle IMO.
If you argue that access permission errors have priority over validity
of API arguments, then  fanotify_test_{fsid,fid}() are not that much
different (priority-wise) from fanotify_events_supported().

My preference is to not change the code, but maybe Jan will
have a different opinion.

Thanks,
Amir.

