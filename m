Return-Path: <linux-fsdevel+bounces-36527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1F49E5361
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 12:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8A4164959
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10F81DDA35;
	Thu,  5 Dec 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiP4plfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF51DC182
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396904; cv=none; b=t7+egS7zCHHLU4+OgXJpF9AxyXZn43U8WAqdmK8nQ4xsN6DEsM9B39aPVq+LQsnKVTM/8kOePnG7xhKocjJq5ioP655BmUdPktLRAaqZRMk508Gu3egt1iZ43Zu/g7x6mN81vIPBhxXH5TuVcMKq85VFLbh63euiq7fu81A8Rek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396904; c=relaxed/simple;
	bh=QhaKVJEnVwt4ttCG2AywWy82lO0amFGAAOxxsrqQzYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptAGUmJia3Soi1esFoIS26WKSTaOfyPC6iQp1WjzPCEsOknV81AK94gFV+4TpSi156D+rx0WU/g4gH3WZqYOtASCViTTbbn7BCIAQ5rwu3luElBZHqb5rEfoHspBUWtVBxM1dP/EsuURZP7tev1TPD26r4eblq1Lp/9sjildhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiP4plfh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2155c25e9a4so95035ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 03:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733396902; x=1734001702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkB0McviH035XkT87TJB0ADxHPrNc2Io5CD31vnh6AY=;
        b=LiP4plfhQ70sOr4HDf1hCtLjshQTMWiPp9QqLrA62Xn6bXC3z+RrE0T9iyhceIIDpC
         pGJFllNyWSZiO/NucxCoDVERZfex+O9mFzkpvZ6kWq8joEU0puk6FDGgODDvyWqLC8Br
         1T9zHevcW4I8EztWGCPEo902gijNy8/MwA1dOhPb2nqLQLqjP765KkQx5E0tL1uZYO6H
         2HGV2CbnW6Tk9I4BnwQ1k786FakscpP9nwzWxsHvsOLyq/IVR0t/wAd5YKucdRRDaiSf
         ZGcbvuKtB4/rFVlXWwhQseWcoc+fjg0wmeZaSaN6S3IjJbKlx3KQFL71a99If0vNbxRq
         AaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733396902; x=1734001702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkB0McviH035XkT87TJB0ADxHPrNc2Io5CD31vnh6AY=;
        b=KgFDNUkrnS4WfCplPq4+exSMudEXE3vvPbvqYkBevTz2X63R5GMJB+QGAqNSjr4bOt
         +5mFbRNVWPoyYzEUu9XSgA5MnGKk8J/FO5A6ew7m5dJm2E3w7OPUp6WS9NdGQbo0zfas
         X4U7YWFBS+Zy4o1oV/qtkVfyv+kVlNjzmw9bS+e9cKLG2VsGNKXBmOsK9tzZ0S/xY0ix
         9HXMUwJUyf9tGdiAz/B6+bRDbQU5nGWOF0ihRGTPybABbUfSGOSdN3+S12I1vkkYErlT
         AoO/C7LAZfkAZoHzYcykVhlofyZKriNYbr23ZfODYvw3PYji+taq1jWa1K6wkbkkI56E
         5ueQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBIW9m9B0J3Sy122rGGlZwCYckR2YFrS2W9rf+KX7swF8ykucGTrIpTofxOXXVwQWVU2watsUlogBmodYt@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7J9yHRxGllzZAx6I0eEEwEY4xFixIG4mxygvp5l37jz2u845
	cDlAYQLvuyb9aW+ORCz7MGJbJECSIGP6MB/TT5Ee0ex2jGRfbDmYNNoJ85RKGnB/DwA7OHFOlRB
	rA23Hk9rjrNsw9MouwReUpcHusWDMBz88QBT0
X-Gm-Gg: ASbGnctWKzccZVIqrdDi0Hx2xzT1MYD8MaUomT1ymRC7JujF8kRHcM+QOw9MDEvWcKA
	FiIUyS6YjKk/s7ekvCY3l+5UrtUE8Dg==
X-Google-Smtp-Source: AGHT+IEZBAa1HWXQvn98Qdt26cKMBX3N2xAIu6ONetygGsADoZO+uyG4gE/7k1Opq+NaPnJunCy0lZ1kbm6Lt+xN6EM=
X-Received: by 2002:a17:902:ce0e:b0:215:3717:4389 with SMTP id
 d9443c01a7336-215f8d2eeb0mr1770945ad.29.1733396901718; Thu, 05 Dec 2024
 03:08:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128104437.GB10431@google.com> <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>
 <20241128110942.GD10431@google.com> <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com>
 <20241128115455.GG10431@google.com> <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
 <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm> <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>
 <CAAFQd5B+CkvZDSa+tZ0_ZpF0fQRC9ryXsGqm2R-ofvVqNnAJ1Q@mail.gmail.com>
 <CADyq12xSgHVFf4-bxk_9uN5-KJWnCohz1VAZKH4QEKJLJpcUEA@mail.gmail.com> <20241205032349.GC16709@google.com>
In-Reply-To: <20241205032349.GC16709@google.com>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 5 Dec 2024 06:07:45 -0500
Message-ID: <CADyq12wzDSib5fPHO6p5aKPNBJQyKoRqW2sq4nwQ48SYSsEvTg@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Tomasz Figa <tfiga@chromium.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Bernd Schubert <bschubert@ddn.com>, 
	"miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>, "laoar.shao@gmail.com" <laoar.shao@gmail.com>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 10:23=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/12/04 09:51), Brian Geffon wrote:
> > > > > >>
> > > > > >> In those cases 1 minute fuse timeout will overshot HUNG_TASK_T=
IMEOUT
> > > > > >> and then the question is whether HUNG_TASK_PANIC is set.
> >
> > In my opinion this is a good argument for having the hung task timeout
> > and a fuse timeout independent. The hung task timeout is for hung
> > kernel threads
>
> Sorry, but no, it's not only for kernel threads.
>
> > in this situation we're potentially taking too long in
> > userspace but that doesn't necessarily mean the system is hung.
>
> And it's not for hung system.  It's for tasks that stuck unreasonably
> long waiting for a particular event or resource.  And those tasks very
> well can be user-space processes, being stuck in syscall waiting for
> something.
>
> > I think a loop which does an interruptible wait with a timeout of 1/2
> > the hung task timeout would make sense to ensure the hung task timeout
> > doesn't hit.
>
> The point here is not to silent watchdog, we might as well just disable
> it and call it a day.  The point here is that fuse can be used (and IS
> in our particular case) as a network filesystem, and the problem can be
> way outside of your system, so spinning in a wait loop doesn't fix any
> problem on that remote system no matter how long we spin, and that's
> what watchdog signals us.

Sergey, to clarify again what I was suggesting, I was not suggesting
that no timeout is appropriate. I suggested that the hung task timeout
is not appropriate and instead we should be using a different timeout.
My suggestion about looping was simply to say: **once we've
transitioned to userspace to service the request the hung task timeout
should not apply and instead a different fuse timeout should.**

The loop is nothing more than to allow the task to break out of the
wait so it's not triggering the hung task timeout and frankly an
implementation detail that I should have probably omitted. There are
situations where a timeout less than the hung task timeout might be
appropriate and there are situations where a timeout longer than the
hung task timeout might be appropriate.

