Return-Path: <linux-fsdevel+bounces-41644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904EA33FE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED251882106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05A823F41B;
	Thu, 13 Feb 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV6dwiN0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508823F400;
	Thu, 13 Feb 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452101; cv=none; b=M/8ML20uDPd0YD2SjKPZvVg2MmXB+Wj0ZvYzKdZkOPUorwXcm9x6FVFpXsQe90EQK//r+dUiQW/NcU5Xco+EGOjwPcjZ24FAbR1Fg2L2w8Mh2hJ3OTb0Z5bU3COc32XiF8o+R27+W+M3ogcFDDFeEGzyDm3XJWSfPD85dx8IaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452101; c=relaxed/simple;
	bh=bSk0Hj/FyM593T3rKpHDAYfymSX6ObFE0W2NcT1pn+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDsNEteYrh+B5+0jEsjviTZqxF5f7MaSfh2nsozI7wYjgoJ+x5ot0Yjh83RWuXyL1YdnbepQGhp+i5OuMNzhUhm7IucbuYcW7+f8tQcvkalE7Uz+L+3xdZ+IahCC5ayjN0cgWjGgVGJqO4xrPxNekXAO/0vtZP1atho7SaQmRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV6dwiN0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7d58aa674so132367766b.0;
        Thu, 13 Feb 2025 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739452098; x=1740056898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUTp6AuhiLhqO2Q9yLQzvCOyNBqKEFt3i2WwkPPjzIU=;
        b=gV6dwiN0F0jePTT7swIx91ZnJ8fXLGEfD6P4we7ZuDetNS9QaIJQtk3tEc+/8PyQDO
         2P7SKEc3POAnB2XkgNDvqKwPYMf5HZ09tlylREp0lw+YmqraiT7bWwOo8pmafexgdjle
         NP15ui/cOI5McxxR2xH3J8GTIROZbo/YL/x5CQS6ly/yKxU0f/tpuijxjO55z+rEb4Rf
         Bi2oggs27okktBiM8WkHP9rH+0TKJU92mjHcgrqxEIs/8plzq3yUM6cIU7XbwZkI7vYJ
         s4OG1WV4Z+XjBBCD7JeyxJTOt6bE8XtBHHrV1UufvVNjxuKygTy3BW1x3PidoowBFc8c
         OhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452098; x=1740056898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUTp6AuhiLhqO2Q9yLQzvCOyNBqKEFt3i2WwkPPjzIU=;
        b=c2dHqdvxsRFn+ZMY+NhFj1E3WGhbPVqjKncscxcdXO7vWxh4u/9nzO8vh7W3VNp7Dd
         BOx2o1teRqhwt8jxLs/EafFICM8LT2zvtbrwwth7Q0AuvzGId4iyHdKl6rI55FaykDjz
         V/9fDrKda4xHwCSNuUqZGI8vNSjzI/E0DTx5tMjMhmtVdm8T0d6ZpVItTR9ykMbtaAeo
         cF2jM9dgAZUcBUW5VY/D8qXdz29sUqIciA/TXBm2jbzxXN1DoR80u6ZlQgAmkoliZB0I
         3oWJkeqQKjFowx3HB4qEiTms3HGIoxryeAQNU9joa7bwsvYJKh6OKbLJ9XcKiq9AeFWY
         fSNg==
X-Forwarded-Encrypted: i=1; AJvYcCUGFBM+8K3KgaSmLAykYNJ2r4rhceQ7rM+GU0q8aDrQFzoZlBTw+RsDxpQoUsT2tfSmClLpH5ECn3A3VtJPt28vSLs=@vger.kernel.org, AJvYcCVTZwm2gYn+HlKEvUO/jA4TypvhH6C8GcuADkeNxfWroljF38xzDLLSj+fQjEsvn75UmZ2nMRe/FQ==@vger.kernel.org, AJvYcCWOyE+fHYbsWC8nAaxrkV8Yp7TBTIktSOCJtqnKk93wEcl79DZ9fKaxvcML8hhVdeb5I49GGrWoSZ00BAjg@vger.kernel.org, AJvYcCWczGHN43tB0dIqhtHAzt/3yUxbp80o+skJN76CyxlojyO4HqfSGs33J/f3hginfLVGoFyb29TZ2DiYLH+FBa0elK7kVewV@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5/dSgORyQziGUfLpfHK7rXIIS1wKwx4gNdSAnWTthJS7CSSG
	Y4XW8X/HXwmKTWV1BPRGLpBVSJNiu7fY8mF6o0rJ9yq+krAnfIYlbSHuZ+9VIp2pG1JT+ygeZg3
	OW55+TqSSPO6mXKb+ha3xsTLV0hY=
X-Gm-Gg: ASbGncuSHKRln7mWtzOKXT83pJBlx6xjpt67ZRTrellRpgqV+27Gi6qtT1ei5hwF/jk
	W4Id4KWBrqqTr9K/AHuhb0qhzultrY3xh5nmBgi3leR5PQ1b9+0N+bQ+eCcATbH22h9hn3avf
X-Google-Smtp-Source: AGHT+IEIALstVYu3cDxkEPtjAZqx9bJqNL+AJl9CVv+xsffpsTYOrZGLAzrGmbsNN1f1CV+Xf2LjM/0osE2ACK25KOU=
X-Received: by 2002:a17:907:720d:b0:ab7:86af:9e19 with SMTP id
 a640c23a62f3a-ab7f34af3a5mr637030066b.43.1739452097409; Thu, 13 Feb 2025
 05:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <7fjcocufagvqgytwiqvbcehovmehgwytz67jv76327c52jrz2y@5re5g57otcws> <CAJfpegs2qoZHG4P+WiopDo92MxHQ_0QrZi0qMz7niannGFiPDQ@mail.gmail.com>
In-Reply-To: <CAJfpegs2qoZHG4P+WiopDo92MxHQ_0QrZi0qMz7niannGFiPDQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Feb 2025 14:08:05 +0100
X-Gm-Features: AWEUYZk768_4685HNZwQTbBM11mfG4zvZDgHs1ea8YV4kaLv6t1_0XExpCDgqrI
Message-ID: <CAOQ4uxjdMeMq9OCkoJVH1GTgUQHN2-03B-T531eCdKmw0kc=rA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 1:00=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 11 Feb 2025 at 16:50, Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 29-01-25 17:58:00, Miklos Szeredi wrote:
>
> > >       fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > > -     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> > > +     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_=
EVENT_FLAGS) &&
> >
> > I understand why you need this but the condition is really hard to
> > understand now and the comment above it becomes out of date. Perhaps I'=
d
> > move this and the following two checks for FAN_RENAME and
> > FANOTIFY_PRE_CONTENT_EVENTS into !FAN_GROUP_FLAG(group, FAN_REPORT_MNT)
> > branch to make things more obvious?
>
> Okay.  git diff -w below.
>
> Thanks,
> Miklos
>
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1936,6 +1936,8 @@ static int do_fanotify_mark(int fanotify_fd,
> unsigned int flags, __u64 mask,
>              mark_type !=3D FAN_MARK_INODE)
>                 return -EINVAL;
>
> +       /* The following checks are not relevant to mount events */
> +       if (!FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {

Sorry for nit picking, but you already have this !FAN_REPORT_MNT
branch above:

+       /* Only report mount events on mnt namespace */
+       if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
+               if (mask & ~FANOTIFY_MOUNT_EVENTS)
+                       return -EINVAL;
...
+       } else {
+               if (mask & FANOTIFY_MOUNT_EVENTS)

Which can be easily moved down here and then we get in one place:

if (FAN_REPORT_MNT) {
    /* event rules for FAN_REPORT_MNT */
} else {
    /* event rules for !FAN_REPORT_MNT */
}

TBH, with the check for (mask & ~FANOTIFY_MOUNT_EVENTS)
I personally wouldn't mind leaving checks for FAN_RENAME and
 FANOTIFY_PRE_CONTENT_EVENTS outside of the else branch,
but I don't have a strong objection to including them in the else branch.

Thanks,
Amir.

