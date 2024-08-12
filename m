Return-Path: <linux-fsdevel+bounces-25713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7394F683
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6979CB21F46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397EA189BBF;
	Mon, 12 Aug 2024 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aJrVN9OH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA916EB7A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486657; cv=none; b=TCGRwGhG7eE+H0Fs/A9nXM8nVp+iNKn9VCdDbHMNpnFKz1VnI6ad0elTFWhojYl8P+siZDXhvFLYP0z990qRWfbpSW6yaucWxGQ03WI5PPRZE139EoElNhI5FA1y4o+gEL6ycMYO0b+zWESPs3TqjIJLr1nPcjAwiswFeebf9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486657; c=relaxed/simple;
	bh=65A6yjlvaO8a4JP9BVc6J/BurYuEASN/Y8gPrLaXmao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED3HQSFTJYPr8WZLJMiPX6eshWp/WcyMF2kk/PRmJJLS4Z8OgEGbrK0UnXb6mbKB2EWH/l96jsGIQDqYsv67LW9L0pAwOBfRW9dy5UufhxiuHX66UhYtQVkEX0Tl5czfC3iAaAnDYvoWNztWbMj72mnl7ci5KxT95KPYjFwIUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aJrVN9OH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso4052655276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723486655; x=1724091455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slgta0Rtur2N8FWsbCOg/ch3Efeg4rWJ0wt2B+Eo6zc=;
        b=aJrVN9OHlx/yt0YQ+Ov2XfPn9RLWYHhaeeQkviWXf5aUjS1/kXsnaMEIBAVi4ldl3E
         J5ZbglKMalhL+CCd59RZOtDxHCLezMvOh+KJlrfioOO3fASZ5cjh+rs5bZ+sbFK841EC
         mH80WiY5ihYf740gu+c6j65zguxLW0patKl+R3HvUTgdn52hUZ7xkbG8PP1THxCzDp8s
         lLBsiTRIznmWzGG/klZGxwqHQJOSXWp9oQMYa6Dkv04nVV+Ul6ofZq7eyazcLq3CbcIq
         W9M63dVhsyMAGIMXfBUH2RQVlvkl9hDOhYa9rmD2dD23PCY+clm8kJ00ab02RqBQ0EhG
         jUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486655; x=1724091455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slgta0Rtur2N8FWsbCOg/ch3Efeg4rWJ0wt2B+Eo6zc=;
        b=uPTT42vRTGW60L8o8VK5gwLSXVHUdbfuyjbE4zoSVO/Y9BwTRGEsELd156ARcwHMs7
         cU0BjF97E+214hTxzvVKiXs1Q8bzmrhumgjxu+Gn8sSK7vKp8j7PwulaQ0cBe5ldsPwT
         nPvXWJ5/w0nI6ASMDdQwAn21YEWWL2HkSybzTJG6i6TJfcD+Qg+CPG/2crpnlrNUCa/U
         HqiO6q4Mo5il6ZsL2OsJJQXodX8hTfJYBGlxrbrAJbFnkzGY6MmkLxqV9i5o9ODk6J1h
         f+wqESrdCgJCuDuVvWh500u3oXCxPMqKPLS7HgMMe/CSolXieOhYlMLPOYtxMGe+/cZr
         ERgw==
X-Forwarded-Encrypted: i=1; AJvYcCXHlPilXtX+ADse0/96fG98OBLWS/X10a7mOvpsdadUSExIjyYZ2UH5+VUFrNQ1EDLVNE4eednTYzYDdcEfPaDGnzARfCqt+J+ZEZ78ZA==
X-Gm-Message-State: AOJu0YzlS+xtz/VTU4lI0ZVF0Me9nb+SMo9oyI+BQWaWAkGou90UscGh
	5yZk3GdPOcrLXGqhuIo0lWEsWDtyG+thqVwYBTZLlPjujTHpsVWL1vkl/8fRvnMNMvBQwxGFZic
	/gad4O3uhaMkEC3bIN+lOtSQVmABheLKUknoC
X-Google-Smtp-Source: AGHT+IGTa7/I6EUj/yuXkVqFoy+raj2iiaSBVMXMmjcxIlG12dAcKZKVy/KvDkZBF9JOiEPh3wRQXRLJmsc/qN/WdrA=
X-Received: by 2002:a05:6902:2211:b0:e0b:3c9d:12a2 with SMTP id
 3f1490d57ef6-e113ced1c22mr1309871276.25.1723486655003; Mon, 12 Aug 2024
 11:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net> <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
 <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
 <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com>
 <CAHC9VhS6=s9o4niaLzkDG6Egir4WL=ieDdyeKk4qzQo1WFi=WQ@mail.gmail.com>
 <CAG48ez2tvHgv7sOVP14gCF1MAGE-UzJoMCfZqdmY1nXX4FFV4Q@mail.gmail.com>
 <CAHC9VhQY+H7n2zCn8ST0Vu672UA=_eiUikRDW2sUDSN3c=gVQw@mail.gmail.com> <20240812.Fie3aCh2eiwi@digikod.net>
In-Reply-To: <20240812.Fie3aCh2eiwi@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 14:17:24 -0400
Message-ID: <CAHC9VhRh3gBLv=qmbz35UHing_qz7xJe1T98UJSN=bd5zeAwVg@mail.gmail.com>
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Mon, Aug 12, 2024 at 12:30:03PM -0400, Paul Moore wrote:
> > On Mon, Aug 12, 2024 at 11:06=E2=80=AFAM Jann Horn <jannh@google.com> w=
rote:
> > > On Mon, Aug 12, 2024 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Mon, Aug 12, 2024 at 9:09=E2=80=AFAM Jann Horn <jannh@google.com=
> wrote:
> > > > > On Mon, Aug 12, 2024 at 12:04=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > >
> > > > ...
> > > >
> > > > > > From a LSM perspective I suspect we are always going to need so=
me sort
> > > > > > of hook in the F_SETOWN code path as the LSM needs to potential=
ly
> > > > > > capture state/attributes/something-LSM-specific at that
> > > > > > context/point-in-time.
> > > > >
> > > > > The only thing LSMs currently do there is capture state from
> > > > > current->cred. So if the VFS takes care of capturing current->cre=
d
> > > > > there, we should be able to rip out all the file_set_fowner stuff=
.
> > > > > Something like this (totally untested):
> > > >
> > > > I've very hesitant to drop the LSM hook from the F_SETOWN path both
> > > > because it is reasonable that other LSMs may want to do other thing=
s
> > > > here,
> > >
> > > What is an example for other things an LSM might want to do there? As
> > > far as I understand, the whole point of this hook is to record the
> > > identity of the sender of signals - are you talking about an LSM that
> > > might not be storing credentials in struct cred, or something like
> > > that?
> >
> > Sure.  The LSM framework is intentionally very vague and limited on
> > what restrictions it places on individual LSMs; we want to be able to
> > support a wide range of security models and concepts.  I view the
> > F_SETOWN hook are important because it is a control point that is used
> > to set/copy/transfer/whatever security attributes from the current
> > process to a file/fd for the purpose of managing signals on the fd.
> >
> > > > and adding a LSM hook to the kernel, even if it is re-adding a
> > > > hook that was previously removed, is a difficult and painful proces=
s
> > > > with an uncertain outcome.
> > >
> > > Do you mean that even if the LSM hook ends up with zero users
> > > remaining, you'd still want to keep it around in case it's needed
> > > again later?
> >
> > I want the security_file_set_fowner() hook to remain a viable hook for
> > capturing the current task's security attributes, regardless of what
> > security attributes the LSM is interested in capturing and where those
> > attributes are stored.
>
> I don't see the point to keep an unused hook, we could add it back later
> if there is a valid use case, but I'll send a v2 without this removal.

If it was simple to add LSM hooks, then I would agree, but history has
shown that not to be the case.

--=20
paul-moore.com

