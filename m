Return-Path: <linux-fsdevel+bounces-13003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983486A066
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 20:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C954628C7EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D39143C48;
	Tue, 27 Feb 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6C83evW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1348CFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062972; cv=none; b=jmDr/+SM67+Xca7cgQn+0YGStIOSHdy5vgYZSvjhds1poQzqMPG00NtlJbP+6ElKz5gZ/W/pQtXSiGcxsFP5a0oJ6xFDpwsRpIqr40Z8azzuDMe0Q1qM34BthmOGgCvV+iEHnjUgnLsQlvHpPFHGyfEyttNHMgG99ILdHXt75UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062972; c=relaxed/simple;
	bh=RPUIGzhINGl6BpDsI73yII+EuG9ygI8IZoJIbVo3Dkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBhgM4HvgWKC3ptmsEgjzVphPT2Wnqk2NnvIeRqozPl53IZKGk4QjuuJN4ibWwAsX6qOm9XXtG7/ytPpXsNDsb/xpczBkd0ROZtsu3xuGHzjGo6L10SjqDUtlfVugRt3xTPW+/CZIX0OyPhYZOn3zu5syomWRC1JschpoCk5Le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6C83evW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e885c8885so8744831cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062969; x=1709667769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v1Ly1YaAgunUVG8+Va8Bz9BbGxc7Gq+aSFJLhr9uUc=;
        b=O6C83evWhUn/p8Prp12HfsGVn74/zBEaJd7xVHCryOAULD+9bwn6oAcht/Agj+440w
         DZCi98/36Nl+zp11kYj00irOTEFnEeRrIdlSgDC466qHowuu5inwl4yEeLh2hyNPdUBM
         5tkIok/DWZo2vNNBQWlf2lJgK98mr2YWHM2+8LOoY0R6aM5hi/u9M5hWuZE/C9TADMjL
         VRLzJbpf6kT1rYUNVZZQY8Y7MDae2w9EDXZfyhJ2z8YWGxhY21kp4sqeNV6hm7SrenVC
         gqz2ZLe6FAjNVwPHKA6Ll8THxOzD21GOJXGwa1T08T2i19TxaDhqoYijupOwyRBMJtuq
         Q0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062969; x=1709667769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v1Ly1YaAgunUVG8+Va8Bz9BbGxc7Gq+aSFJLhr9uUc=;
        b=bV5BXwbqFbMJF6LYpBE+OgVjHVdSugE8VrF0fy78S8Ez3Hi85xuwRVYzFtzCTP3xUy
         IuDEypFRB+EE9nMoGi5EFtBS3meHLi//u4khdtpAd8qxyP/lQIEZFThiB8e+E+5TErPF
         7IQB6E5Clr/W1RjOZN7WdjuDXTYaIgQkBISA1H1xC+UMe8pwSHW836ieMDpl0dEyUFgX
         kgrYDVX+8EgSzHo/j9BIBkLorBFLw8/mNe/2yGD235qtDq9hSxyPLo1vGC1wpWkn4gdX
         mPLjhe2Yu0wVumezjNsrWLTW1EXC45b1AceeWmj7ZXZRhvYMV95iBZXXFcgr2BlDOuVm
         PtJg==
X-Forwarded-Encrypted: i=1; AJvYcCVlXzWmzjsJqyg+ub75UtxNv+J6209gSM9uijrqo0pPA1dLXPgR13iiKelZyYLepjQpBU2piVJ6Xx9N0isdFdCZol6rb8XTPSjcq3sHwQ==
X-Gm-Message-State: AOJu0Yz/ge5PRbNTZQKDA67cnvFnLE452y5xfWljRXes/Wve2ZT0J1TJ
	LqVKBobg+AdadokJ5xFNXOBR/vN3Wsc+uueEUpQ01yteezXTM7yRX1q22InRQFYl6wyHGMrNuhd
	NUJuUzMB117Y9qbacyJukKzKCyDc=
X-Google-Smtp-Source: AGHT+IEJks7rWY0hudvFdBGda9EO3pUoZYqLS/sX9JkJo751x3ljU03ifkpAq4QIP8+mThLz4phyR/eQFa8HhZlDC40=
X-Received: by 2002:ac8:5715:0:b0:42e:5db4:2f8d with SMTP id
 21-20020ac85715000000b0042e5db42f8dmr13037679qtw.13.1709062969379; Tue, 27
 Feb 2024 11:42:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
 <20240205182718.lvtgfsxcd6htbqyy@quack3> <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
 <20240208183127.5onh65vyho4ds7o7@quack3> <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3> <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
 <20240215115139.rq6resdfgqiezw4t@quack3> <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
 <20240219110121.moeds3khqgnghuj2@quack3>
In-Reply-To: <20240219110121.moeds3khqgnghuj2@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Feb 2024 21:42:37 +0200
Message-ID: <CAOQ4uxizF_=PK9N9A8i8Q_QhpXe7MNrfUTRwR5jCVzgfSBm1dw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 1:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 15-02-24 17:40:07, Amir Goldstein wrote:
> > > > Last time we discussed this the conclusion was an API of a group-le=
ss
> > > > default mask, for example:
> > > >
> > > > 1. fanotify_mark(FAN_GROUP_DEFAULT,
> > > >                            FAN_MARK_ADD | FAN_MARK_MOUNT,
> > > >                            FAN_PRE_ACCESS, AT_FDCWD, path);
> > > > 2. this returns -EPERM for access until some group handles FAN_PRE_=
ACCESS
> > > > 3. then HSM is started and subscribes to FAN_PRE_ACCESS
> > > > 4. and then the mount is moved or bind mounted into a path exported=
 to users
> > >
> > > Yes, this was the process I was talking about.
> > >
> > > > It is a simple solution that should be easy to implement.
> > > > But it does not involve "register the HSM app with the filesystem",
> > > > unless you mean that a process that opens an HSM group
> > > > (FAN_REPORT_FID|FAN_CLASS_PRE_CONTENT) should automatically
> > > > be given FMODE_NONOTIFY files?
> > >
> > > Two ideas: What you describe above seems like what the new mount API =
was
> > > intended for? What if we introduced something like an "hsm" mount opt=
ion
> > > which would basically enable calling into pre-content event handlers
> >
> > I like that.
> > I forgot that with my suggestion we'd need a path to setup
> > the default mask.
> >
> > > (for sb without this flag handlers wouldn't be called and you cannot =
place
> > > pre-content marks on such sb).
> >
> > IMO, that limitation (i.e. inside brackets) is too restrictive.
> > In many cases, the user running HSM may not have control over the
> > mount of the filesystem (inside containers?).
> > It is true that HSM without anti-crash protection is less reliable,
> > but I think that it is still useful enough that users will want the
> > option to run it (?).
> >
> > Think of my HttpDirFS demo - it's just a simple lazy mirroring
> > of a website. Even with low reliability I think it is useful (?).
>
> Yeah, ok, makes sense. But for such "unpriviledged" usecases we don't hav=
e
> a deadlock-free way to fill in the file contents because that requires a
> special mountpoint?
>

True, unless we also keep the FMODE_NONOTIFY event->fd
for the simple cases. I'll need to think about this some more.

> > > These handlers would return EACCESS unless
> > > there's somebody handling events and returning something else.
> > >
> > > You could then do:
> > >
> > > fan_fd =3D fanotify_init()
> > > ffd =3D fsopen()
> > > fsconfig(ffd, FSCONFIG_SET_STRING, "source", device, 0)
> > > fsconfig(ffd, FSCONFIG_SET_FLAG, "hsm", NULL, 0)
> > > rootfd =3D fsconfig(ffd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)
> > > fanotify_mark(fan_fd, FAN_MARK_ADD, ... , rootfd, NULL)
> > > <now you can move the superblock into the mount hierarchy>
> >
> > Not too bad.
> > I think that "hsm_deny_mask=3D" mount options would give more flexibili=
ty,
> > but I could be convinced otherwise.
> >
> > It's probably not a great idea to be running two different HSMs on the =
same
> > fs anyway, but if user has an old HSM version installed that handles on=
ly
> > pre-content events, I don't think that we want this old version if it h=
appens
> > to be run by mistake, to allow for unsupervised create,rename,delete if=
 the
> > admin wanted to atomically mount a fs that SHOULD be supervised by a
> > v2 HSM that knows how to handle pre-path events.
> >
> > IOW, and "HSM bit" on sb is too broad IMO.
>
> OK. So "hsm_deny_mask=3D" would esentially express events that we require=
 HSM
> to handle, the rest would just be accepted by default. That makes sense.

Yes.

> The only thing I kind of dislike is that this ties fanotify API with moun=
t
> API. So perhaps hsm_deny_mask should be specified as a string? Like
> preaccess,premodify,prelookup,... and transformed into a bitmask only
> inside the kernel? It gives us more maneuvering space for the future.
>

Urgh. I see what you are saying, but this seems so ugly to me.
I have a strong feeling that we are trying to reinvent something
and that we are going to reinvent it badly.
I need to look for precedents, maybe in other OS.
I believe that in Windows, there is an API to register as a
Cloud Engine Provider, so there is probably a way to have multiple HSMs
working on different sections of the filesystem in some reliable
crash safe manner.

> > > This would elegantly solve the "what if HSM handler dies" problem as =
well
> > > as cleanly handle the setup. And we don't have to come up with a conc=
ept of
> > > "default mask".
> >
> > We can still have a mask, it's just about the API to set it up.
> >
> > > Now we still have the problem how to fill in the filesystem
> > > on pre-content event without deadlocking. As I was thinking about it =
the
> > > most elegant solution would IMHO be if the HSM handler could have a p=
rivate
> > > mount flagged so that HSM is excluded from there (or it could place i=
gnore
> > > mark on this mount for HSM events).
> >
> > My HttpDirFS demo does it the other way around - HSM uses a mount
> > without a mark mount - but ignore mark works too.
>
> Yes, the HSM handler is free to setup whatever works for it. I was just
> thinking to make sure there is at least one sane way how to do it :)
>

Yeh, we need to write "best practice" guidelines.

> > > I think we've discarded similar ideas
> > > in the past because this is problematic with directory pre-content ev=
ents
> > > because security hooks don't get the mountpoint. But what if we used
> > > security_path_* hooks for directory pre-content events?
> >
> > No need for security_path_ * hooks.
> > In my POC, the pre-path hooks have the path argument.
> > For people who are not familiar with the term, here is man page draft
> > for "pre-path" events:
> > https://github.com/amir73il/man-pages/commits/fan_pre_path/
> >
> > This is an out of date branch from the time that I called them
> > FAN_PRE_{CREATE,DELETE,MOVE_*} events:
> > https://github.com/amir73il/linux/commit/29c60e4db3068ff2cd7b2c5a73108a=
fb2c19b868
> >
> > They are implemented by replacing the mnt_want_write() calls
> > with mnt_want_write_{path,parent,parents}() calls.
> >
> > This was done to make sure that they take the sb write srcu and call
> > the pre-path hook before taking sb writers freeze protection.
>
> Ok, so AFAIU you agree we don't need to rely on FMODE_NONOTIFY for HSM an=
d
> can just use access through dedicated mount for filling in the filesystem=
?
>

It seems like a decent and simple way to avoid difficult questions,
so I will try to start with that...
whenever I manage to context switch back ;)

Thanks,
Amir.

