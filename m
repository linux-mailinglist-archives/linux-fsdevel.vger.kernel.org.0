Return-Path: <linux-fsdevel+bounces-54263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B82AFCDDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD0B1C21981
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE702E06C9;
	Tue,  8 Jul 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn/oQYIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663321E521B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985379; cv=none; b=iwttTv5dbgw9BjafZXDAwpr5UyxKgQfIqJMNdcN+PcPlNJLKm8N5ykwk7j0rQG+2c7OC4SEmio8aP/p/MjjsxMIx6Bt6VzqbwybonJY8PPLzSLi8MZcMNM2XYinlxRBsDDkOYgy0oqELjWsdv4pmYBcFpTQZT40Ioz6NB7KfNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985379; c=relaxed/simple;
	bh=eItTEC0AS4+h2MpLvRkfrNJoyNuylLvnOE8SHP5q41A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOr0An5REFo2EDV5YGdR3V5LilGSfRHMvWORi7KqpRKjfq5I3IX6Jw9zYz2H2lnIeggpuT1W1kCtNt/a4gmS0BcbXY/VjyuiV73bS3q9MzOS9vPSpT8pX6ocJLZK8Y/TGQjs8LptEXy2riytji3e2jPjVLQOUfFBGFP4/V4h22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn/oQYIe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad572ba1347so679057666b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985376; x=1752590176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg6hK8IwGMQCITUUgOiCjJbo0MywPHfvrNA1CIQ31xU=;
        b=Mn/oQYIe/LwnGyUVw6abX6FbGonG86JlrZiIUUBr3/bHg0JKLJXUjZu6GbFEuWxHqf
         u+wYfDHR4Dz3lbKDCfNkMWz4p+Fo+U9Jq0shyQYooADue8NEOxZtXg69sKaxzN0Kjhdm
         A2pH5OePeQsuKMLn5jSypHrmKqzNwaSzL4G1qIXMC9/h6KOO5k5SWExTwAfNi9DHnm/x
         cnhUf4Tt2D7QYVsm88h+I0E0TQRM8YO5x2vrANa4nVJrILi1ZcK2TuxbbHGcYLJpCqNn
         fDZxZHqZ2wg7lpWzMdVamKlydG3WE04/jo9x8EqVFx0doEXJKexJK3EhGJnPK4VpczM1
         A31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985376; x=1752590176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mg6hK8IwGMQCITUUgOiCjJbo0MywPHfvrNA1CIQ31xU=;
        b=GeWzXrC8j2BD+Td/ChyjPNoTrwrsa/a9sVqbaKhDz+wLRr5Kq7eB/ULXnos+eCAIhI
         WYVLnbDH9iBeCV/++Dk5ixaTRrYWENZKb8Sjconl0fV5sbILrbupqkcJO88penfHalnQ
         KT8JVwSTradUnWLaPe5y6S9RyvSi1UhBf/fVuCCeWPMR12ww7+1toqjFuNoV5UKvetJr
         KTdr1vdjAKY8guPBqCEVgPOi0N9SnS+oCWo3GwFKU2/bJOXfPZS1FbblfNer/xhhCnjx
         TtvOBepwA+4Uyia9dVrodmaKztnvMI0Nhdx/EmLIJ/3prFPTcP10a0Odk8usg/dMQhet
         qy3A==
X-Forwarded-Encrypted: i=1; AJvYcCWU0XbK9a1IHb9UjubJ8HC9aVYaHtcQwkxPWuMlQ9N8Ei2tC0yKbHnEJhnmRU+TafFmjFQ8rSBu/0TNc9Nx@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4qvv1K/ufb6vAcb4l2raKTVIhPOl9xJHWrMLkBCiNXrg04Wt
	nT34slWyLfoZSr+XKaZ1mvQkMs4hKsUxG15erbzKMDYkiaB6hBLYqCcHs4AOtat1k7+zg3plZUR
	Hdx5ACz73n6Pjdxfm5Gm47gmgRgnKOXo=
X-Gm-Gg: ASbGncsYER+aNkWsdUP/RJmhAk1GYtyjBJAmxztC8RmlEYPAor0alj1dgWii5NjR7yV
	vfMBlFMQOIkcFXJ/i+cZjHvRhscm6d1h2tBlvSHuD8qCfsG703Vew1qIFVTYbaTj1RWDgVM6mjT
	TWhgKRf+VWol9R9AqwPux+xtTsIdUGQ+nfYZ9w38qLj+Y=
X-Google-Smtp-Source: AGHT+IEMxVuWjlKRP7cK8e1gB4nozp44khtN1FIPB/5HLkz4EX7Aqb2EXlV+o1/CDvxjADY04jN8nwIUmL12oirCXjc=
X-Received: by 2002:a17:907:6ea3:b0:ae3:6744:3680 with SMTP id
 a640c23a62f3a-ae3fe7f4260mr1657071466b.42.1751985374691; Tue, 08 Jul 2025
 07:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxi8xjfhKLc7T0WGjOmtO4wRQT6b5MLUdaST2KE01BsKBg@mail.gmail.com>
 <20250701072209.1549495-1-ibrahimjirdeh@meta.com> <CAOQ4uxhrbN4k+YMd99h8jGyRc0d_n05H8q-gTuJ35jkO1aLO7A@mail.gmail.com>
 <pcyd4ejepc6akgw3uq2bxuf2e255zhirbpfxxe463zj2m7iyfl@6bgetglt74ei>
 <CAOQ4uxiAtKcdzpBP_ZA2hxpECULri+T9DTQRnT1iOCVJfYcryg@mail.gmail.com> <ggruapqox23obwimkajdj257ffdrhziwk3tbrorqx3wz7qcmm2@epcyf6cqxk27>
In-Reply-To: <ggruapqox23obwimkajdj257ffdrhziwk3tbrorqx3wz7qcmm2@epcyf6cqxk27>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Jul 2025 16:36:02 +0200
X-Gm-Features: Ac12FXxJ3eyevk8pYtQfVbVNNhgRIP1WYQtRXrQhz2EVTzs8DhOgg8wCXY8B5as
Message-ID: <CAOQ4uxjioLNeMV_9vBp94nkjic4D_4zfM-7oru0wTivG=x6+KA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 3:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 08-07-25 14:58:31, Amir Goldstein wrote:
> > On Tue, Jul 8, 2025 at 1:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > > --- a/fs/notify/fanotify/fanotify_user.c
> > > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > > @@ -1583,6 +1583,16 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int,
> > > > flags, unsigned int, event_f_flags)
> > > >             (class | fid_mode) !=3D FAN_CLASS_PRE_CONTENT_FID)
> > > >                 return -EINVAL;
> > > >
> > > > +       /*
> > > > +        * With group that reports fid info and allows only pre-con=
tent events,
> > > > +        * user may request to get a response id instead of event->=
fd.
> > > > +        * FAN_REPORT_FD_ERROR does not make sense in this case.
> > > > +        */
> > > > +       if ((flags & FAN_REPORT_RESPONSE_ID) &&
> > > > +           ((flag & FAN_REPORT_FD_ERROR) ||
> > > > +            !fid_mode || class !=3D FAN_CLASS_PRE_CONTENT_FID))
> > > > +               return -EINVAL;
> > > > +
> > > >
> > > >
> > > > This new group mode is safe, because:
> > > > 1. event->fd is redundant to target fid
> > > > 2. other group priorities allow mixing async events in the same gro=
up
> > > >     async event can have negative event->fd which signifies an erro=
r
> > > >     to open event->fd
> > >
> > > I'm not sure I follow here. I'd expect:
> > >
> > >         if ((flags & FAN_REPORT_RESPONSE_ID) && !fid_mode)
> > >                 return -EINVAL;
> > >
> > > I.e., if you ask for event ids, we don't return fds at all so you bet=
ter
> > > had FID enabled to see where the event happened. And then there's no =
need
> > > for FAN_CLASS_PRE_CONTENT_FID at all. Yes, you cannot mix async fanot=
ify
> > > events with fd with permission events using event id but is that a sa=
ne
> > > combination? What case do you have in mind that justifies this
> > > complication?
> >
> > Not sure what complication you are referring to.
> > Maybe this would have been more clear:
> >
> > +       if ((flags & FAN_REPORT_RESPONSE_ID) && (!fid_mode ||
> > +           ((flag & FAN_REPORT_FD_ERROR) || class =3D=3D FAN_CLASS_NOT=
IFY))
> > +               return -EINVAL;
> > +
>
> Right, I can understand this easily :) Thanks for clarification.
>
> > Yes, !fid_mode is the more important check.
> > The checks in the second line are because the combination of
> > FAN_REPORT_RESPONSE_ID with those other flags does not make sense.
>
> But FAN_REPORT_FD_ERROR influences also the behavior of pidfd (whether we
> report full errno there or only FAN_NOPIDFD / FAN_EPIDFD). Hence I think
> the exclusion with FAN_REPORT_FD_ERROR is wrong.

I keep forgetting about this one :)

Yeh, better leave it out then.
That should be enough:

+       if ((flags & FAN_REPORT_RESPONSE_ID) &&
+            (!fid_mode || class =3D=3D FAN_CLASS_NOTIFY))
+               return -EINVAL;

Thanks,
Amir.

