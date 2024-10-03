Return-Path: <linux-fsdevel+bounces-30846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D544898EC2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8451F230D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B013DDA7;
	Thu,  3 Oct 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdovzOO2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3F13D278
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947100; cv=none; b=YVS8T8K7lgT53xiKPCUaMspSGU9TR3Q5g4W4llJsBv4XOX5HmX4+fVmIKAj3Yvou6Hk5pqNwml+gCcBUi7Ivf41M6O3BjSOPVWL5LHGePxJe6UM8XTpCqrj7geG8WbowC/6EaXalD+CkhBaBlveZ9P/MtZa5ffcrixMIIgLcfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947100; c=relaxed/simple;
	bh=15bsU0HbITQ3+oiuRp/G0tZQ0ATd6GnQtB2srh/nO6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQwuUqyZKkQIRMLjKxXI+9GU82bdAwriHS0PYlQWjLwg+c2P04sCLt3DDTrMJX9jiJrJAGKeMMyUucaAmvqX/Qubv7ZxWpIN2IIU0zLXfSWWFDT+Pqw4OftM5VEeLaNgbF5cpoN0CgiCo6knWK8InIaPMf4SuM3buH5NoXfUu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdovzOO2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7ac83a98e5eso68216785a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727947098; x=1728551898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15bsU0HbITQ3+oiuRp/G0tZQ0ATd6GnQtB2srh/nO6c=;
        b=PdovzOO2HFylhjXvHq+Xbrpyt2huI6yKmINOgxL+U8QcSNU74h8WXdsdeGEIejuGrp
         CXDLZoz9PkaF2eUj6t84O2Gn1GiupH72bsib+fW2BedAJtbwu9bna1QcbiXD+QlEMjoN
         hjiifbdiXrDcsfuil6+xiT7lXXXd2YaykzhWZ08hM9GUEmiOc/zZK43Ac8OhyEpmlcxz
         ljYPUOGrh5JP0TKlIbd/0o6yDom0ortZZVBvkiztpNm9NWfNYF3RpUT8rHtG72mUOGUb
         h1q1Fd0GxdfA+cNLbqo/l/wsX04VZP8KY6gqvY9ppNeGQLytV5mJRO6g4lGBd8SFsmEm
         Bn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727947098; x=1728551898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15bsU0HbITQ3+oiuRp/G0tZQ0ATd6GnQtB2srh/nO6c=;
        b=VukE8ZYei7COeKUKmw6IQPjk68jat4EC28FQOmxNiYfao/X1UbXip/93Ac0vjY37bl
         O6IvDUqTyBBr+sUpI7kRJvwu1lt1wmqFxM3kh89PgXS+G/6pbysRBrDDtlar+iz7wdLq
         2heqPWvtFVrj5UPFNnYh4EEdN0tvHtxAzH9nx6oOKm9wJCJ9RMmiqpJgLn8hQTILcMyX
         T9NhtPqM4yyPLlfVtoPxuNPPeE9qtJLbKoV64vO9okGc652qIDW7WoXRRFnaB7fvhbOu
         ub6i2GS5gSvb4N4TvJ9JHNxH66YqVIO+fipXDnDVApm4OUuv3C3a7/3L2TUR9CyxbEGB
         vg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7DfjAc+Wo5RKfYNaayxBBYo1vXzeAM+MkcBsSLX+SlU/rLOofZd9cd+JQM6w+nfkzwXXQL3kECu1I2dgf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BVOz0FwQgzoq+Unq0uXvytAyAo3efzY2K4IzDXscdAbSat/j
	WoieBG/2mQitKMUZZo8bSCtqtEutAZr6dtoVCsKrxq/ACTmYcdDs+61qSSZlgkrN6E1Q02rW1w7
	hz+VsUcT5OLu6+/zKfiLRltAD5OU=
X-Google-Smtp-Source: AGHT+IG6/mKVmnuYrJQTUn6inhgP4WmfvvwWksg5tjEi0jB1xKgq1YmXqrTKKQRIw/Iy1PXNYr04fhnt9ohLHyLeev4=
X-Received: by 2002:a05:620a:c42:b0:7a6:4da7:8325 with SMTP id
 af79cd13be357-7ae67e2a8e5mr412301485a.6.1727947097654; Thu, 03 Oct 2024
 02:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927125624.2198202-1-amir73il@gmail.com> <20240930154249.4oqs5cg4n6wzftzs@quack3>
 <CAOQ4uxg-peR_1iy8SL64LD919BGP3TK5nde_4ZiAjJg5F_qOjQ@mail.gmail.com>
 <20241002130103.ofnborpit3tcm7iw@quack3> <CAOQ4uxgo=0ignH-2gSyWYmcCoAvQJA=o8ABS+u2_=iiBDvsLgQ@mail.gmail.com>
 <20241002144749.zi7d56ndvvj3ieol@quack3>
In-Reply-To: <20241002144749.zi7d56ndvvj3ieol@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Oct 2024 11:18:06 +0200
Message-ID: <CAOQ4uxjY0hAVVEbWCU1C02xqGPej67JsQk06BTj6=f=NGc6d5Q@mail.gmail.com>
Subject: Re: [PATCH] fanotify: allow reporting errors on failure to open fd
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 4:47=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 02-10-24 15:54:02, Amir Goldstein wrote:
> > On Wed, Oct 2, 2024 at 3:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 30-09-24 18:14:33, Amir Goldstein wrote:
> > > > On Mon, Sep 30, 2024 at 5:42=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > >
> > > > > On Fri 27-09-24 14:56:24, Amir Goldstein wrote:
> > > > > > When working in "fd mode", fanotify_read() needs to open an fd
> > > > > > from a dentry to report event->fd to userspace.
> > > > > >
> > > > > > Opening an fd from dentry can fail for several reasons.
> > > > > > For example, when tasks are gone and we try to open their
> > > > > > /proc files or we try to open a WRONLY file like in sysfs
> > > > > > or when trying to open a file that was deleted on the
> > > > > > remote network server.
> > > > > >
> > > > > > Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
> > > > > > For a group with FAN_REPORT_FD_ERROR, we will send the
> > > > > > event with the error instead of the open fd, otherwise
> > > > > > userspace may not get the error at all.
> > > > > >
> > > > > > In any case, userspace will not know which file failed to
> > > > > > open, so leave a warning in ksmg for further investigation.
> > > > > >
> > > > > > Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
> > > > > > Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F34=
24619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > ---
> > > > > >
> > > > > > Jan,
> > > > > >
> > > > > > This is my proposal for a slightly better UAPI for error report=
ing.
> > > > > > I have a vague memory that we discussed this before and that yo=
u preferred
> > > > > > to report errno in an extra info field (?), but I have a strong=
 repulsion
> > > > > > from this altenative, which seems like way over design for the =
case.
> > > > >
> > > > > Hum, I don't remember a proposal for extra info field to hold err=
no. What I
> > > > > rather think we talked about was that we would return only the su=
ccessfully
> > > > > formatted events, push back the problematic one and on next read =
from
> > > > > fanotify group the first event will be the one with error so that=
 will get
> > > > > returned to userspace. Now this would work but I agree that from =
userspace
> > > > > it is kind of difficult to know what went wrong when the read fai=
led (were
> > > > > the arguments somehow wrong, is this temporary or permanent probl=
em, is it
> > > > > the fd or something else in the event, etc.) so reporting the err=
or in
> > > > > place of fd looks like a more convenient option.
> > > > >
> > > > > But I wonder: Do we really need to report the error code? We alre=
ady have
> > > > > FAN_NOFD with -1 value (which corresponds to EPERM), with pidfd w=
e are
> > > > > reporting FAN_EPIDFD when its open fails so here we could have FA=
N_EFD =3D=3D
> > > > > -2 in case opening of fd fails for whatever reason?
> > > > >
> > > >
> > > > Well it is hard as it is to understand that went wrong, so the erro=
r
> > > > codes provide some clues for the bug report.
> > > > ENOENT, ENXIO, EROFS kind of point to the likely reason of
> > > > failures, so it does not make sense for me to hide this information=
,
> > > > which is available.
> > >
> > > OK, fair enough. I was kind of hoping we could avoid the feature flag=
 but
> > > probably we cannot even if we added just FAN_EFD. But I still have a =
bit of
> > > problem with FAN_NOFD overlapping with -EPERM. I guess it kind of mak=
es
> > > sense to return -EPERM in that field for unpriviledged groups but we =
return
> > > FAN_NOFD also for events without path attached and there it gets
> > > somewhat confusing... Perhaps we should refuse FAN_REPORT_FD_ERROR fo=
r
> > > groups in fid mode?
> >
> > Makes sense.
> >
> > > That would still leave overflow events so instead of
> > > setting fd to FAN_NOFD, we could set it to -EINVAL to preserve the pr=
operty
> > > that fd is either -errno or fd number?
> > >
> >
> > EOVERFLOW? nah, witty but irrelevant.
> > I think EBADF would be a good substitute for FAN_NOFD,
> > but I can live with EINVAL as well.
>
> EBADF is fine with me, probably even better.
>
> > > And then I have a second question about pidfd. Should FAN_REPORT_FD_E=
RROR
> > > influence it in the same way? Something like -ESRCH if the process al=
ready
> > > exited and otherwise pass back the errno?
> >
> > Yeh that sounds useful.
>
> OK, I guess we have an agreement :) Will you send an updated patch please=
?
>

Sure. Will do.

Please note that I intend to funnel this API change to stable.
That is why I have annotated the patch with Reported-by and Closes.
While this is not a traditional stable backport candidate, this API can
really be used by the user that reported the issue to solve a problem
or get better insights once the distro picks up this API.

Also, considering the recent backport of the entire fanotify API from
v6.6 back to v5.10, I no longer feel compelled to obey no the legacy
no new features rule for the stable trees.

Thanks,
Amir.

