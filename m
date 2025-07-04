Return-Path: <linux-fsdevel+bounces-53922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63052AF8FE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA2A5A099F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F42EACEE;
	Fri,  4 Jul 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmqdORvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3AC184
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624542; cv=none; b=sCcv1AMXUdFTZsIPaf7hm/fvsLhUXGZeuSydjpYvKgK8bNLL/PKPa0fcaHU2ENmtw8KJIbA85i3UzFis0SsNvVNXpJG+eqwcHwcM7+xHKX5aDsr6LFsqhr/WKK523dG+KZC59iFv1eE0F8/G31pS0VQM9CxPL7tPxHjc89g9cvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624542; c=relaxed/simple;
	bh=qYl6nbaov20xpMvD8i+rPokBm2sADWCNw/lQN+3u6SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHXb14hWMTKagyjYJKaOXQDF6rJWSmho2KcE5tT6tDlxQxvyz9S1FOzlETYWorADVadKE1mQCU6/kDJsxCFuDAkirrGe7SFwTiwNXGoYdXAfZmxCNx1IMpc9ti/maKNCbieDg8NjhlClP/jPdz4NJZqj8aJ01TnNd/4e4Mku+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmqdORvS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso698402f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751624539; x=1752229339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6Fj/7ntpAGpPREGRnDyUXH90+4aQzqp7viFdiOVfCo=;
        b=KmqdORvSx6m3h6rb7+qACAmHLqsh9kSlnLafpBzrWZOgF98Htg2h1mtJBCFDMsSUdc
         IqWW60OrenpGjKDEayAOnWznh1H41hP28HRjzJXtWJ4p2aLw07LYCZ+F0AtIFM9dnkSJ
         x5jmqFbXO/uBj2RlbjjS92+wm7emjPwyc4tj3ko0dw+WSfj6AdoaFuQi0BIlTpqC47x6
         C1PD4ADPmlcuMDT3dVD4oD1ynI5J9Eo80ZxmUOYhhjHUtkkAyGvSMPKo7d8PM6y4vHMB
         esPn5fkYr7RSJZVH4RWJ72v8n6f72i2h8J/MrWdrxqc8eLXy3a/ne6QROdapl0fmvPjp
         9RjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624539; x=1752229339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6Fj/7ntpAGpPREGRnDyUXH90+4aQzqp7viFdiOVfCo=;
        b=EQDVXawKzPP3C872pReLj1ZTTObf5nipXRPxGVMllihtqc14fOXvGlQju28IgoIxZ/
         V6dPr4FN+GxbYSLBgYx3TiSZDyBjnpoApbTcISTU4iYnNzvvW7Rvu09OteZ6rSJJsfsr
         3EitI1RSgCChKvxHZLqd9lUJO0CNthcuFu28096AxetjLbIMR7T0No7zBmDCgo0jHsje
         +Qv2oCBiNfsYvlzKCosFo0iA9stvsmgHZw4lZqeveZuv10yJdg88jDVH5Kc3tkPgfkmC
         xD5Rb9dVi5H5IB8eG1n6XJCHLdk2z7OVvcoITLm+W6C2sRumPeVAkiBruOaGjoLdrOn2
         fHSw==
X-Forwarded-Encrypted: i=1; AJvYcCWnXRVTBbPU8vQYdJTP0vycon0SYDUg+WFiIpfgLibiaiLHkCAP6+h3KZS4H1pPhf5pkpdBGC9kxVKzZ9TT@vger.kernel.org
X-Gm-Message-State: AOJu0YydsEAjpRt97cAUMprvlw5e0enCcwqT+wbwezU5i6KMUem+eAcu
	vl8VSBrZlOkRrVtQOQ5B4sr4Lwagvf6j+ysrOj97JlaSkkOBQ4RYkoxYJk13v7cX5l3Kmr7346O
	tORvelLDlkle66FSrMa7nyJNYQjowID8=
X-Gm-Gg: ASbGncuGB+a3qzTh28XUghXbd+1wZSfHIF3LnElUURJwgN3cpGCvZlFoaR+l5c9vwdn
	M/r9Jtas9K4IWOFWVhdxZBdUFi1G2O9U95ur2qcSw1c6A73Hzf4MCVW68ZZ7wg+o9NzNvMAMXHZ
	kF2yetmtkhSShP71MI/U8saO0LJY483MyrHF+Bziq7OYY=
X-Google-Smtp-Source: AGHT+IES6b0wac9j6EyKCxbVfJ40DCT4RUDHycMmOIJ08d4ujL/1XTBGGcf255PHbypbjxnZguHCA14JdZx4BLDoKwA=
X-Received: by 2002:a05:6000:2504:b0:3b3:a6c2:1d1b with SMTP id
 ffacd0b85a97d-3b497029501mr1369687f8f.28.1751624538872; Fri, 04 Jul 2025
 03:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703130539.1696938-1-mszeredi@redhat.com> <eybdb3wqnod644u2nmmasd34uxhnjbvte4p2ued6dyy2vzt3sv@tsc4wysiypvr>
In-Reply-To: <eybdb3wqnod644u2nmmasd34uxhnjbvte4p2ued6dyy2vzt3sv@tsc4wysiypvr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Jul 2025 12:22:07 +0200
X-Gm-Features: Ac12FXxZ2CEN0bS68DGElY4ZzCkrnm-MfW4kfgAnJX7aDPuoG5InBNNuXUdGE_M
Message-ID: <CAOQ4uxi6GjWynhY5A_TxRMzX84PJp-KsHq=NOK=wSzbqqb_Ejg@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: add watchdog for permission events
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Ian Kent <raven@themaw.net>, Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 11:56=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 03-07-25 15:05:37, Miklos Szeredi wrote:
> > This is to make it easier to debug issues with AV software, which time =
and
> > again deadlocks with no indication of where the issue comes from, and t=
he
> > kernel being blamed for the deadlock.  Then we need to analyze dumps to
> > prove that the kernel is not in fact at fault.
>
> I share the pain. I had to do quite some of these analyses myself :).
> Luckily our support guys have trained to do the analysis themselves over
> the years so it rarely reaches my table anymore.
>
> > With this patch a warning is printed when permission event is received =
by
> > userspace but not answered for more than 20 seconds.
> >
> > The timeout is very coarse (20-40s) but I guess it's good enough for th=
e
> > purpose.
>
> I'm not opposed to the idea (although I agree with Amir that it should be
> tunable - we have /proc/sys/fs/fanotify/ for similar things). Just I'm no=
t
> sure it will have the desired deterring effect for fanotify users wanting
> to blame the kernel. What usually convinces them is showing where their
> tasks supposed to write reply to permission event (i.e., those that have
> corresponding event fds in their fdtable) are blocked and hence they cann=
ot
> reply. But with some education I suppose it can work. After all the
> messages you print contain the task responsible to answer which is alread=
y
> helpful.
>
> > +config FANOTIFY_PERM_WATCHDOG
> > +       bool "fanotify permission event watchdog"
> > +       depends on FANOTIFY_ACCESS_PERMISSIONS
> > +       default n
>
> As Amir wrote, I don't think we need a kconfig for this, configuration
> through /proc/sys/fs/fanotify/ will be much more flexible.
>
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotif=
y.h
> > index b44e70e44be6..8b60fbb9594f 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -438,10 +438,14 @@ FANOTIFY_ME(struct fanotify_event *event)
> >  struct fanotify_perm_event {
> >       struct fanotify_event fae;
> >       struct path path;
> > -     const loff_t *ppos;             /* optional file range info */
> > +     union {
> > +             const loff_t *ppos;     /* optional file range info */
> > +             pid_t pid;              /* pid of task processing the eve=
nt */
> > +     };
>
> I think Amir complained about the generic 'pid' name already. Maybe
> processing_pid? Also I'd just get rid of the union. We don't have *that*
> many permission events that 4 bytes would matter and possible interaction=
s
> between pre-content events and this watchdog using the same space make me
> somewhat uneasy.

fae.pid is not used after copy_event_to_user() so it can be reused
to hold struct pid of processing task while waiting for response.
But anyway, I think there is a hole in the struct after int fd.

Thanks,
Amir.

