Return-Path: <linux-fsdevel+bounces-30072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820C985C0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2837728450F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84861A0BFF;
	Wed, 25 Sep 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFOhNF8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF281850A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265375; cv=none; b=gp0PAejnn/VFptGKgcIxToUT7Q/gGtAtQDtLM206eODRWgHQZzQU4ShVzO8zGzRiKfSpU16bQ4FkUv25EGlEmtYjGaWow+rgNfIDRDTzvG031ciihR4zeYjtK7RRblSwf2FxtNhU23jMcmvc8wXLDH0XZTfWKDy9vv0ucWUCAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265375; c=relaxed/simple;
	bh=mS4uhdRju8X5Td4QSd7Uw+4gWZ1W1SX8IC8aDIYTSh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z85AMQUODmNqLoniyqouzNU32qfv0XhuIYFmv3qz++jiECoG5XnKnkGkyM19YcX2zWS4LsiRsPA2ppyA3GfmXxM8qQ/yagROdK6xV00mRs41OChVRJF+8gKyWZCASnAjG0Nm0Y0EDPdTXwayPdxvI8T6aoVpk6YNlT4j+n7fri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFOhNF8H; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7acd7d9dbefso265904385a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727265372; x=1727870172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4cyAfr4fWqD7jvgUimcE1VahgNajaf5Yl9ON4qFTNc=;
        b=VFOhNF8HIrufecMFKij+t1bHhS1fDdw5rfMLDtXp9eUGP37Motxy4BbPLT64q2597d
         qj3DHi2cdHClQWfZ+uvYIp6jR0KjWNl+eTVjVZhMQKzMDaaF4dzzoeFWHGm/7LK5/fBX
         KzY5Xylo+upiJFm93mEjT1CNwiie7x8mkqddRgEsn3fEqh0P6vgT2G+jE2EOMzoohAWF
         8pUlBy785pA/uvlGnKBGfO5kul+hTOR5RJbYcxzWE0i9A8IAx0cmjS2vaOlbKC79YDIw
         m1g0KpdncDVgChZqccZNrPCf9OZD//YHMYJMTuWJhq+NKfb+BOqpqt3vJQizZVmCAm3w
         Xl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727265372; x=1727870172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4cyAfr4fWqD7jvgUimcE1VahgNajaf5Yl9ON4qFTNc=;
        b=g2DZLv3jzT6kSVmnfHXj3tiiT9coiOmYyD9mdLHZTZyy524w9M2kQoOKguzlafn5KC
         te6Dol14CO3EzYauaVAD9Y+nJIr87pZSdmuWvTnYZcJjZDbIe59Bpu7F2/fyabTDBN5D
         fS2MiQ9vmOCCoVL9a5vPwTkf8m3jJCDBQa7qb93vof5txUPnQxJ5H81FcsatXukZjLTO
         M0rIwG+E3LLidmnI8zr4Wk9PSbwBa/j9eUy8jZnnBuLp52Mh0JqLMFsNB7FNvchuIU/o
         3Fm1t1iOF11Ct0XroiLwRWKT7dKsGrwslkDXv2IxCvEVqgw7ycunD2wJxDsyvbZEwih+
         OAsg==
X-Forwarded-Encrypted: i=1; AJvYcCVeaDSUYwPSEJTjxCUQAzG7I8Eh8CdmippBd3y1rwsoaBEQhaViI0Mh5SZBTB8LGR7qdZX+EjL8n+j9nBJz@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDC6LBZ44voHGwI/NY2T5lKfNnjtzkidkI9037eK5TxdUm86O
	E/zp6k+yN5uT4Ywpo/B//kP+MVwLW8jf8cdRq53uEgjZszkPK8O36ezXT/nzSjpHSOhldsJDbfW
	yB9fjNHM6JgjBfqIEoMEzBuCNCnDKRHOtxmk=
X-Google-Smtp-Source: AGHT+IFJGMjWM0oaiAOzZUjic1L3j6tHn6UXqILAkG6i/Sb+oHH/0asN0SkR8Q7HIs/mg0B+D/DbdaBbTGhAIpHFinE=
X-Received: by 2002:a05:620a:3721:b0:7a9:b618:16aa with SMTP id
 af79cd13be357-7ace73e1af5mr364103285a.10.1727265372124; Wed, 25 Sep 2024
 04:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com> <20240925113834.eywqa4zslz6b6dag@quack3>
In-Reply-To: <20240925113834.eywqa4zslz6b6dag@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Sep 2024 13:56:00 +0200
Message-ID: <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:38=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> [Adding 9p guys to CC]
>
> On Wed 25-09-24 12:51:38, Amir Goldstein wrote:
> > On Wed, Sep 25, 2024 at 10:18=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > On Wed 25-09-24 10:11:46, Jan Kara wrote:
> > > > On Tue 24-09-24 12:07:51, Krishna Vivek Vitta wrote:
> > > > > Please ignore the last line.
> > > > > Git clone operation is failing with fanotify example code as well=
.
> > > > >
> > > > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitC=
loneIssue# ./fanotify_ex /mnt/c
> > > > > Press enter key to terminate.
> > > > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitC=
loneIssue# ./fanotify_ex /mnt/c
> > > > > Press enter key to terminate.
> > > > > Listening for events.
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-appl=
ypatch.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-ap=
plypatch.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypat=
ch-msg.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/applyp=
atch-msg.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-m=
sg.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit=
-msg.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push=
.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-pu=
sh.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merg=
e-commit.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-me=
rge-commit.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-comm=
it.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-co=
mmit.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-upd=
ate.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-u=
pdate.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-=
checkout.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-t=
o-checkout.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonito=
r-watchman.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmoni=
tor-watchman.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.s=
ample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/update=
.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-reba=
se.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-re=
base.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rece=
ive.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-re=
ceive.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-=
commit-msg.sample
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepar=
e-commit-msg.sample
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/description
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/description
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/tNbqjiA
> > > > > read: No such file or directory
> > > > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitC=
loneIssue#
> > > >
> > > > OK, so it appears that dentry_open() is failing with ENOENT when we=
 try to
> > > > open the file descriptor to return with the event. This is indeed
> > > > unexpected from the filesystem.
> >
> > How did you conclude that is what is happening?
> > Were you able to reproduce, because I did not.
>
> No, I didn't reproduce. But checking the source of the reproducer the
> message "read: No such file or directory" means fanotify_read() has
> returned -ENOENT and within fanotify there's no way how that could happen=
.
> So the only possible explanation is that dentry_open() returns it.
>

Ah, I missed that bit in the report.

> > > > On the other hand we already do silently
> > > > fixup similar EOPENSTALE error that can come from NFS so perhaps we=
 should
> > > > be fixing ENOENT similarly? What do you thing Amir?
> > >
> >
> > But we never return this error to the caller for a non-permission event=
,
> > so what am I missing?
>
> Umm. If dentry_open() fails, we return the error from copy_event_to_user(=
)
> without copying anything. Then fanotify_read() does:
>
>                 ret =3D copy_event_to_user(group, event, buf, count);
>                 ...
>                 if (!fanotify_is_perm_event(event->mask)) {
>                         fsnotify_destroy_event(group, &event->fse);
>                         // unused event destroyed
>                 } else {
>                 ...
>                 }
>                 if (ret < 0)
>                         break;  // read loop aborted
>                 ...
>         }
>         ...
>         if (start !=3D buf && ret !=3D -EFAULT)
>                 ret =3D buf - start;
>         return ret;
>
> So the error *is* IMO returned to userspace if this was the first event.
>

Yes it is "returned to userspace" but it is returned to the fanotify listen=
er.

The original complaint is about the error returned to open(2) after rename(=
2)
in the rename_try.c reproducer (when fanotify is watching close events).

I admit that fanotify_read() randomly returning an error is sub-optimal,
but I do prefer it over dropping the error silently.

BTW, there are several other dentry_open() errors that are easy to
reproduce in this context:
ENXIO after an event on a pipe with no reader
ENODEV after an event on a device node with no backing instance

These were part of the reason that I excluded special files from
new pre-content events...

Thanks,
Amir.

