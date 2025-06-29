Return-Path: <linux-fsdevel+bounces-53229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA5AECB87
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE941891EE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 06:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227F1E1A3D;
	Sun, 29 Jun 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu6sBZOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDDEEC3
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751179820; cv=none; b=H+Yr0ixuATXYfBrQ+ARp/4SwbXbQt7/i9Gc4cUKzUILquWTKk8L/rSA1fGjpQgGrVDZpfZaotjBNnqHxEjLOZ6jaD1ck+ckQjzSAjW96YKfb4k4e9QjaXxed+ss447c0pM/qIXYIOt49yj65KiGfjyym9/w3iGeDNzvzhgOdY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751179820; c=relaxed/simple;
	bh=KReKn6PEg+kOQ03BvphoNoHhvik7WoW07HS6tGxTfsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntO5LOmQ39od8VwV1jJoyaLgF6jONTiYeYtMCDpFrMO5Uk4q9x1VuEPKJrvlPorMLIq9/bdk323BRejtJU/O1+GiDGD0+I9hZigX7feJQwEtOYGP2I+105iVrZ7I+h2eHbAe1lKgmc1cBgLWCT7qQQyIkFCAUWTDRJkE09lzFKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu6sBZOf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae35f36da9dso227204466b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751179816; x=1751784616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr2r4I6UgAovwuGAcqfAJ84eB0BLOBiQmV+vT6skG/c=;
        b=Pu6sBZOfbRORb7oif4bmTYU+Ui+jwrCJSBhaChGNq9XWniA38Zj+xPEnIRB5oG85ba
         0+qoSE3yUvTxBKDsCLpmHifs8KTmmjeGBnk+J1syGEtuBE/iTCoZ5LYYp+p+UlifFEYv
         +tlors7d26vqIr1yd6gpuY3FU1Qu8ycZRO3i+kbUq2Gi7rG9GJ6AQe/Bq7RWJnB+oYKl
         Hlb2Na+JebDGjvFtYYxsjqaQRRGfE1vt5bF19vq8Mry/lX9AnYfajILqTeS4Lq8ugSU/
         rpQIK8qPEl0GaA6MvTcS4kRhpi8N/fJSV4SA9tjOmRArhyv4nG51tip1zq+bcuWvn5xb
         Tgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751179816; x=1751784616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sr2r4I6UgAovwuGAcqfAJ84eB0BLOBiQmV+vT6skG/c=;
        b=NCqjglRXKUHinExZLvCZX/wg9zy5P9QhzVkexAT+UnzE2nqKuHAVKSOsH1j838606D
         X81qMl6KZEjP0wJExEi/158zG17aaqyWXglg7bCn9UA2h+rEUMgjoLvfAvtVTd53j1Ty
         x/YaNlQJaBcQi0hBAEaHRM+WavyqQp6RyqZ+32gh9wvIfVxttWbzHeTWgJ9nxCxpO2VR
         3V61khcBH5lYR6GUonevQ3CWHU9WW8rIGGZaUMRmE0PxCrsDJipWwnwK5BzCCh3OMqGH
         qhCkk5wKtY8Q9I1wlg4NO6LBNLrtGheoEsZ3EBynaA/ijPTfyNju9qMGJTR0+cWe/7VM
         Tdow==
X-Forwarded-Encrypted: i=1; AJvYcCVdgmb0Nvaoif+vHYwOIR8G2RaShvUTUXy4R3nwfmTDxgbfPAZMn0zAOI71lbupQEfKGamDsVZzs1Ny9/CZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/kMyTfXITYkjTwMZkOWh0Xfv7eG6R8ivOOE8HVo9tS+ruuBB
	9jdXTk3RI6yy2OTwxpVY1HbxgPj+Ciw+Y3RCHRMrF457mKZ5S7LBJhgrsIyIk3yf2ZU+Dh3syDo
	Q+gi/upM8350o/vBaCtYDJrq+qWX9hPo=
X-Gm-Gg: ASbGnctAvDAWWfHJ8C6Z40nNVIFT+CyWX6pW5+JwIhVBDZEjabkUTQJ7vqdIDXoMp4e
	ICtgGoqdD4KrN7fvKYW6ePwTYVMTmxBrYilVxa3Npiem/3dnPZDf7dsG7fApEaPJF12AUjLFeJL
	kY02RlWn/66ij2mai2VzL+ocuXaDYIt6qe2vPBbfN7Pbg=
X-Google-Smtp-Source: AGHT+IGR0WTwYGnXSBI8XRHWOYJPbbXh7XsNuCTcxnTYS+L6pg8ei978Z84/FWEufU+cbDEAmSgepCd9KE6lVWufvZ8=
X-Received: by 2002:a17:907:968a:b0:ad2:2146:3b89 with SMTP id
 a640c23a62f3a-ae35019cefbmr821499166b.47.1751179816197; Sat, 28 Jun 2025
 23:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxivt3h80Vzt_Udc1+uYDPr_5HU=E6SB53WXqpuqmo5zEQ@mail.gmail.com>
 <20250629062247.1758376-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250629062247.1758376-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 29 Jun 2025 08:50:05 +0200
X-Gm-Features: Ac12FXwYYqiFgQowhH0J5tFiFg3n3B00Q7vh8xqYNYbiKdfd0jNrGbjF3zpHKrc
Message-ID: <CAOQ4uxjiSepuQE-oorRFmVmVwOieteh8Nb2pfe5jjV2ud3MMWQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 8:24=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> > > > Do we prefer to scope this change to adding (s32) response id and n=
ot add new
> > > > event id field yet.
> > > >
> > > > > Thinking out loud, if we use idr to allocate an event id, as Jan =
suggested,
> > > > > and we do want to allow it along side event->fd,
> > > > > then we could also overload event->pid, i.e. the meaning of
> > > > > FAN_ERPORT_EVENT_ID would be "event->pid is an event id",
> > > > > Similarly to the way that we overloaded event->pid with FAN_REPOR=
T_TID.
> > > > > Users that need both event id and pid can use FAN_REPORT_PIDFD.
> > > > >
> > > >
> > > > At least for our usecase, having event->fd along with response id a=
vailable
> > > > would be helpful as we do not use fid mode mentioned above.
> > >
> > > You cannot use the fid mode mentioned above because it is not yet
> > > supported with pre-content events :)
> > >
> > > My argument goes like this:
> > > 1. We are planning to add fid support for pre-content events for othe=
r
> > >     reasons anyway (pre-dir-content events)
> > > 2. For this mode, event->fd will (probably) not be reported anyway,
> > >     so for this mode, we will have to use a different response id
> > > 3. Since event->fd will not be used, it would make a lot of sense and
> > >     very natural to reuse the field for a response id
> > >
> > > So if we accept the limitation that writing an advanced hsm service
> > > that supports non-interrupted restart requires that service to use th=
e
> > > new fid mode, we hit two birds with one event field ;)
> > >
> > > If we take into account that (the way I see it) an advanced hsm servi=
ce
> > > will need to also support pre-dir-content events, then the argument m=
akes
> > > even more sense.
> > >
>
> Ah I see this makes sense. And as long as we are still able to open files=
 via
> open_handle as the tests you shared below show, then at least for our cas=
e I
> don't see issue with switching to the new FAN_CLASS_PRE_CONTENT | FAN_REP=
ORT_FID
> mode.
>
> > > The fact that for your current use cases, you are ok with populating =
the
> > > entire directory tree in a non-lazy way, does not mean that the use c=
ase
> > > will not change in the future to require a lazy population of directo=
ry trees.
> > >
> > > I have another "hidden motive" with the nudge trying to push you over
> > > towards pre-content events in fid mode:
> > >
> > > Allowing pre-content events together with legacy events in the same
> > > mark/group brings up some ugly semantic issues that we did not
> > > see when we added the API.
> > >
> > > The flag combination FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
> > > was never supported, so when we support it, we can start fresh with n=
ew rules
> > > like "only pre-content events are allowed in this group" and that sim=
plifies
> > > some of the API questions.
> > >
> > > While I have your attention I wanted to ask, as possibly the only
> > > current user of pre-content events, is any of the Meta use cases
> > > setting any other events in the mask along with pre-content events?
> > >
>
> Regarding Meta usages of pre-content events as far as I am aware we are t=
he
> only ones, and we don't set other events in the mask, only pre-content. I=
 can
> confirm there are no other use cases relying on this and follow up here.
>
> > > *if* we agree to this course I can post a patch to add support for
> > > FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, temporarily
> > > leaving event->fd in use, so that you can later replace it with
> > > a response id.
> > >
> >
>
> Sounds great. If we do go that route, being able to overload event-fd for=
 now
> will definitely make this patch much simpler.
>

I may have mentioned this before, but I'll bring it up again.
If we want to overload event->fd with response id I would consider
allocating response_id with idr_alloc_cyclic() that starts at 256
and then set event->fd =3D -response_id.
We want to skip the range -1..-255 because it is used to report
fd open errors with FAN_REPORT_FD_ERROR.

Beyond a clear distinction of type by the value of the field, this will
avert bugs where programers leave old code to close(event->fd)
(or LLM coding agent grabs it from man page).

Thanks,
Amir.

