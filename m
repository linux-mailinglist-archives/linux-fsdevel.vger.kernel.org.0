Return-Path: <linux-fsdevel+bounces-60671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4401DB4FF85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF4F44E2FFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70DD3431F4;
	Tue,  9 Sep 2025 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rWz9WD8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844FE7081E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428483; cv=none; b=GqJN+VHn+Jap9TDNGQX04om7m0DWCx+8o2y0YIcLnjzNdbn2cCZeLdzAYvxoh4mKu1X0UjpvLtVQdsMjeaI39Iun4TKnVacn3+ahAlmK9ly67Q0TgJ+cm3Mk1+7AmlMT03+SmC6+tyP/EIEpxCkoTlDtysJ5N5y+f0m20cW4a4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428483; c=relaxed/simple;
	bh=TH7b62K9hUcjJnY//whtz0OiBkNJSS6JDwVyAcqipAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J22xOqUgcNf2ISjelf7jzWFc5LHl2BpYgcK125kSFEpPXdJZCmApN1GG31SOpDcXQLcAAKIX7ZD5iJwzF+rNIjidPAltIJ2XRnHz3vbiy1I7nG/DEkAas9WHo0TTGh/SeP+IwIU6wBDCvv5Ub0zFpi11WQvpqeY/ySo3UWDNp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rWz9WD8n; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b490287648so92997721cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757428479; x=1758033279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc5cudcr63yY/p/V+0xnXXc9aC2IDGfCVmN8zqPfnI0=;
        b=rWz9WD8n2sC4x6YPBNgcHLCTe7lB1y8Zs6ROEsNWyy1BDg/kbQqpcM8CfuDR+6Wa+M
         4LQ50IalA5QJda6/1YQ53m6lp+7iLUz1Dmbr/v/029Ms/ka+sQkOzoV8DAiN+S7BXVs8
         44NrkTqWfq2JaOpoOskbG8I38sBOtTmLZcNJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428479; x=1758033279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc5cudcr63yY/p/V+0xnXXc9aC2IDGfCVmN8zqPfnI0=;
        b=FTeCcBx+WbU8kUtugIO6MajmTL1P9e+DKTAu+Yu2Ux2f577bETjgv9RPlthpdzkV+G
         sQniZTdZdL7RSHpRqND2f7QXCUdIuN3Bg5b/cTASrseF8i0ilnZXIhmgRTPYKI5Q36e1
         zssiZVjZSuG8lVKOZxR8xrFsBmFfXmFKb0rWUmQtnHdnUH1eg237F5vHt3RbZZX2gEnD
         uXcsezsZTFpIjOnoczSj73M6L5x9pe9B2c+E63+rJ4qJfeJ9AjRvyWhkA1s6bBpP5Xfl
         +bkorz42ajD7QwiHmNZqm30fPQsy8OqOEVwtUd7WUqjJfWEXyfVrfWios6d3Nn42unkq
         QXxw==
X-Forwarded-Encrypted: i=1; AJvYcCVtcDlpRuJ+6idhp2sL5AFKYYoVgxRCSNYsX+gVVzzUYPAauwrC9V7VPefomS3SxW/RQJMV1JiPGZatR9nn@vger.kernel.org
X-Gm-Message-State: AOJu0YwMS5zsL1UrRtJF4WEyy1EJ2P+5lVXdZ0njSN+A7gtDGq3G3Poc
	PvUuXKfA7qe5Yya8GFg7FAp/VI9IQiaA+rCn0kTshzi+udIldJcLq6rLr+rp59DnPUXzQ1qd4H6
	SVN/jjKRrirvwhvdTUXFnc0q3kuYhVZH0xeQSsA8rFw==
X-Gm-Gg: ASbGnctOJyEN0Aydx7Dws48IAJsh0FwMajop4TP8oECfFgtssUGt7tmsJ8o/Ft69GUn
	J45MjUIe8yzjNbohmpM2CMJIBQy1WNtM24YQVCh9szmr4avvkE3PGUDTIl7NSUdQ3nfU9hOO7hA
	8Va7S+n11LP58s4RMBONI2yaOgXORMecauInmXuKvMUx7Wy2CfaEpW7oMcVDFOKDW0lhCblJi8R
	eBhSixrgQX61CJIP3wf1mhgqC1aD0V4uhT40xOtqRJ7HbyxpTbN
X-Google-Smtp-Source: AGHT+IHJ04WiSiy35NRTMc3WWIkd2SfCEXseDzaHeN1gqIlYXeRKeAVubBu/jrkqH3/2utVynOpfu2zfFcbgY0Lwsyk=
X-Received: by 2002:ac8:5988:0:b0:4b5:e8b9:30f7 with SMTP id
 d75a77b69052e-4b5f8447120mr130583021cf.46.1757428478908; Tue, 09 Sep 2025
 07:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703130539.1696938-1-mszeredi@redhat.com> <eybdb3wqnod644u2nmmasd34uxhnjbvte4p2ued6dyy2vzt3sv@tsc4wysiypvr>
 <CAOQ4uxi6GjWynhY5A_TxRMzX84PJp-KsHq=NOK=wSzbqqb_Ejg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi6GjWynhY5A_TxRMzX84PJp-KsHq=NOK=wSzbqqb_Ejg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Sep 2025 16:34:27 +0200
X-Gm-Features: Ac12FXyFCyNkM6amnseiWfTj6OvvfgcWvi9kddCcvSGSGDViIyuLa_0cihfAkLE
Message-ID: <CAJfpeguWVBKk8QcFChAAbdwpJK7iRqaEnW2gtHBTvR45O3mveg@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: add watchdog for permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Ian Kent <raven@themaw.net>, Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Jul 2025 at 12:22, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Jul 4, 2025 at 11:56=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 03-07-25 15:05:37, Miklos Szeredi wrote:
> > > This is to make it easier to debug issues with AV software, which tim=
e and
> > > again deadlocks with no indication of where the issue comes from, and=
 the
> > > kernel being blamed for the deadlock.  Then we need to analyze dumps =
to
> > > prove that the kernel is not in fact at fault.
> >
> > I share the pain. I had to do quite some of these analyses myself :).
> > Luckily our support guys have trained to do the analysis themselves ove=
r
> > the years so it rarely reaches my table anymore.
> >
> > > With this patch a warning is printed when permission event is receive=
d by
> > > userspace but not answered for more than 20 seconds.
> > >
> > > The timeout is very coarse (20-40s) but I guess it's good enough for =
the
> > > purpose.
> >
> > I'm not opposed to the idea (although I agree with Amir that it should =
be
> > tunable - we have /proc/sys/fs/fanotify/ for similar things). Just I'm =
not
> > sure it will have the desired deterring effect for fanotify users wanti=
ng
> > to blame the kernel. What usually convinces them is showing where their
> > tasks supposed to write reply to permission event (i.e., those that hav=
e
> > corresponding event fds in their fdtable) are blocked and hence they ca=
nnot
> > reply. But with some education I suppose it can work. After all the
> > messages you print contain the task responsible to answer which is alre=
ady
> > helpful.
> >
> > > +config FANOTIFY_PERM_WATCHDOG
> > > +       bool "fanotify permission event watchdog"
> > > +       depends on FANOTIFY_ACCESS_PERMISSIONS
> > > +       default n
> >
> > As Amir wrote, I don't think we need a kconfig for this, configuration
> > through /proc/sys/fs/fanotify/ will be much more flexible.
> >
> > > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanot=
ify.h
> > > index b44e70e44be6..8b60fbb9594f 100644
> > > --- a/fs/notify/fanotify/fanotify.h
> > > +++ b/fs/notify/fanotify/fanotify.h
> > > @@ -438,10 +438,14 @@ FANOTIFY_ME(struct fanotify_event *event)
> > >  struct fanotify_perm_event {
> > >       struct fanotify_event fae;
> > >       struct path path;
> > > -     const loff_t *ppos;             /* optional file range info */
> > > +     union {
> > > +             const loff_t *ppos;     /* optional file range info */
> > > +             pid_t pid;              /* pid of task processing the e=
vent */
> > > +     };
> >
> > I think Amir complained about the generic 'pid' name already. Maybe
> > processing_pid? Also I'd just get rid of the union. We don't have *that=
*
> > many permission events that 4 bytes would matter and possible interacti=
ons
> > between pre-content events and this watchdog using the same space make =
me
> > somewhat uneasy.

Amir, Jan, thanks for the reviews.

I forgot about this, but now dug it out again and hopefully addressed
all comments in v2:

  https://lore.kernel.org/linux-fsdevel/20250909143053.112171-1-mszeredi@re=
dhat.com/

Thanks,
Miklos

