Return-Path: <linux-fsdevel+bounces-34668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1BD9C7775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44FE1F22498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE77C15AAC1;
	Wed, 13 Nov 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILA8DqJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874370833
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512323; cv=none; b=FCJhxOeGUm0dT1tDnsNTHYkZR+hllpGZ/AJh4b5Z94dfnSNU8nNbFONuXpSdEk//0Ne/GeSUcEPDSS+RG8j4Oaq5lvTelDdu9IepPklrvfeZy4qMkYdMG+B5BWCe2uman+kCU4RrZ+sRB34u2zL9mPHCHDOUF85JNtJnX+Oe+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512323; c=relaxed/simple;
	bh=XOzTSlvM4wXHZ/UK/y4h8NEpKM6weYAyxOmJOvgpRL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FROjicgYay34wnA7ngPMLpzNQ7KGsfZan9HzA/hEiLjUd+jgW3vZX3SJMMCzVphlW7C6BId8P+CqAHHbWXdvDFfMpEkP+xItiLOhEnp6cMMDJEcsXqaQU6fS79EJ3QMcAR2rmTRgcAXuk9x9u0kSIM/USPdxWydQTQGxvGd7E80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILA8DqJd; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460c2418e37so52393821cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 07:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731512319; x=1732117119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4L5+ZzcMx3DEJUn7tEnafWLWnYgIeesNAYVFfjjHC0=;
        b=ILA8DqJdRTOa8O+Kq3pMgmXOWXZQwbiKKvbRN7INlP03l5+vbU9d9z12a86C8dpADI
         EidvmAMtC25oK7ppHZNReEBLJZNEi+q48LZQQGtJDLjAV/CI3AUS5m7Wg7iVwSKHglP1
         73E+F59aIJaUyF1+U7fX45PTMRDkRqLdBGOsiddq8oX9eAh3MIesoowqxhABpzfv3mB3
         i1GJNAFZp95IH25xYwbPq8K+mPfhnUZRCHT5owyEImNMQql5QIsARQogOdxxwyCeEXNy
         m/cAFy3yDioO2L8vlfzXoX/1ODuXg55rQC9eFH9VyN3L9UL54mXFByOVWX6sdAWuTBs3
         kSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512319; x=1732117119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4L5+ZzcMx3DEJUn7tEnafWLWnYgIeesNAYVFfjjHC0=;
        b=PEZjWjQ5T99byxL3rNHnTiwKAfQ2u/sMhEFJgTmOIiEH2MqP+b82bGJlIEVJP3QEu1
         soSuTpwpxUlM9A1Be+avwBtqlT/OrTJI0Th3X7AmEclyT2eUqg9KDXy+V4g9JyzMZRGn
         yj336LGJDMaO9GvHwDOVNkZsKTP7TJNuGjBM+7JzkDCr6lKdtjtD9X0KPrZ4f46BAmnn
         K4Re9O1DsE2GnyKDwCBG4LRc9RFNEfMVt9mX08VSmEfNXR7mbUDPt8kJAEJWWlI7lvJX
         Ia51eZeTRgsYw6gGDvzjKl/dbFs0SgonAtdZ5RUbJkDJSSFBhKg8Qrv8gXgbLjxjxfvF
         nAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfpwHFQA49pvDP1ghnjrkmH+Injr3YfU9bSqYtx7XLOqsQWKK+wwTPmYVD5va+sO5vT95JYS201/WfamXW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5iUu6ticL2DjO5cbGrAkzUm//t/mP3+n/JxFQfBdKVlTbphV5
	SxcOnnqeWv7MBj2Yf/b9sHUn8l2dEaxJ9q3ONpDX0eqzPxnYz/GySDQFixjM5m+uIwBePUqdiJG
	imFzlcA1MV0vl0ltsIS/uiTpB7lA3u7Ex
X-Google-Smtp-Source: AGHT+IGXgzvJ9bxJmXY+Sai6GC7E4j1x/OOIZ5YUMwislu38XW0KrXfBfYVBa5KxZ/qRadh2Y6q45EjKClfDBEcqcgM=
X-Received: by 2002:a05:622a:1b8f:b0:461:169e:d2de with SMTP id
 d75a77b69052e-4634b55c48bmr47567781cf.48.1731512319261; Wed, 13 Nov 2024
 07:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111201101.177412-1-amir73il@gmail.com> <20241113134258.524nduvn3piqqkco@quack3>
 <CAOQ4uxhswHmgJ0fxVp2PKvkYuVO0uX9rzoGs8HZt2mVBDcfQTA@mail.gmail.com> <20241113153605.bezoibnq236gliyo@quack3>
In-Reply-To: <20241113153605.bezoibnq236gliyo@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 16:38:27 +0100
Message-ID: <CAOQ4uxj_C1xnXFnmC=GqnyHmq_gmC1j_Ur6DurHZYPk-9TXwBw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: fix sending inotify event with unexpected filename
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-11-24 15:22:50, Amir Goldstein wrote:
> > On Wed, Nov 13, 2024 at 2:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 11-11-24 21:11:01, Amir Goldstein wrote:
> > > > We got a report that adding a fanotify filsystem watch prevents tai=
l -f
> > > > from receiving events.
> > > >
> > > > Reproducer:
> > > >
> > > > 1. Create 3 windows / login sessions. Become root in each session.
> > > > 2. Choose a mounted filesystem that is pretty quiet; I picked /boot=
.
> > > > 3. In the first window, run: fsnotifywait -S -m /boot
> > > > 4. In the second window, run: echo data >> /boot/foo
> > > > 5. In the third window, run: tail -f /boot/foo
> > > > 6. Go back to the second window and run: echo more data >> /boot/fo=
o
> > > > 7. Observe that the tail command doesn't show the new data.
> > > > 8. In the first window, hit control-C to interrupt fsnotifywait.
> > > > 9. In the second window, run: echo still more data >> /boot/foo
> > > > 10. Observe that the tail command in the third window has now print=
ed
> > > > the missing data.
> > > >
> > > > When stracing tail, we observed that when fanotify filesystem mark =
is
> > > > set, tail does get the inotify event, but the event is receieved wi=
th
> > > > the filename:
> > > >
> > > > read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0=
\0\0",
> > > > 50) =3D 32
> > > >
> > > > This is unexpected, because tail is watching the file itself and no=
t its
> > > > parent and is inconsistent with the inotify event received by tail =
when
> > > > fanotify filesystem mark is not set:
> > > >
> > > > read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) =3D 16
> > > >
> > > > The inteference between different fsnotify groups was caused by the=
 fact
> > > > that the mark on the sb requires the filename, so the filename is p=
assed
> > > > to fsnotify().  Later on, fsnotify_handle_event() tries to take car=
e of
> > > > not passing the filename to groups (such as inotify) that are inter=
ested
> > > > in the filename only when the parent is watching.
> > > >
> > > > But the logic was incorrect for the case that no group is watching =
the
> > > > parent, some groups are watching the sb and some watching the inode=
.
> > > >
> > > > Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> > > > Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info wi=
th watched parent")
> > > > Cc: stable@vger.kernel.org # 5.10+
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Thanks for analysis, Amir!
> > >
> > > > @@ -333,12 +333,14 @@ static int fsnotify_handle_event(struct fsnot=
ify_group *group, __u32 mask,
> > > >       if (!inode_mark)
> > > >               return 0;
> > > >
> > > > -     if (mask & FS_EVENT_ON_CHILD) {
> > > > +     if (mask & FS_EVENTS_POSS_ON_CHILD) {
> > >
> > > So this is going to work but as far as I'm reading the code in
> > > fsnotify_handle_event() I would be maybe calmer if we instead wrote t=
he
> > > condition as:
> > >
> > >         if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS))
> >
> > The problem is that the comment below
> > "Some events can be sent on both parent dir and child marks..."
> > is relevant in the context of FS_EVENTS_POSS_ON_CHILD
> > and FS_EVENT_ON_CHILD, meaning those are exactly the set of
> > events that could be sent to parent with FS_EVENT_ON_CHILD
> > and to child without it.
> >
> > The comment makes no sense in the context of the
> > ALL_FSNOTIFY_DIRENT_EVENTS check,
> > Unless we add a comment saying the dirent events set has
> > zero intersection with events possible on child.
>
> Good point and what I *actually* wanted to do is:
>
>         /*
>          * Some events can be sent on both parent dir and child marks (e.=
g.
>          * FS_ATTRIB).  If both parent dir and child are watching, report=
 the
>          * event once to parent dir with name (if interested) and once to=
 child
>          * without name (if interested).
>          *
>          * In any case regardless whether the parent is watching or not, =
the
>          * child watcher is expecting an event without the FS_EVENT_ON_CH=
ILD
>          * flag. The file name is expected if and only if this is a direc=
tory
>          * event.
>          */
>         mask &=3D ~FS_EVENT_ON_CHILD;
>         if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS)) {
>                 dir =3D NULL;
>                 name =3D NULL;
>         }
>
> Hmm?

Ok, that works for me :)

Thanks,
Amir.

