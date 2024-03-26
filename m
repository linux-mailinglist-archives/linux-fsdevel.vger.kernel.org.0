Return-Path: <linux-fsdevel+bounces-15325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 938A888C30A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF278B25DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0874BE8;
	Tue, 26 Mar 2024 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hG+b/dpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB78745E2
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458592; cv=none; b=UiTynikZy3Dq3k9HECe0Wd0+TzCTkv/JfDcMfxyQo796sgijkAcFESF5f4RLyWA0ANoaIAlWLUiRKzLiKOugFx1NukkUfPxdFOOlL0zHkUgg0wc+q6CPfaz/F7bILgnLQDEoQaNtQ+dkvQdRtOBab2Wc2y/UXFSXamdTks9Is1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458592; c=relaxed/simple;
	bh=ebTObtm0sD8Cer1bCQSS15gzK3xT8Q/69O7Kqc6cJYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LukfGKaCXn0DAM/UlFqVlKd6eNPVI3zfOh4Xoa0p7CcUaOAioAO5gdoocUfCuI4cYeglDMVezJ6xmdnu9gownu77aJ0dZ2P0XucbI4YMpkYXXklMn999n7+EHG6uIComXk/gGqI7HrMnSXFBrYTvtGSV9fgYMwymxaykesnm1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hG+b/dpj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0815e3f9so83149407b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711458589; x=1712063389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzP2CCUVdCYdG6Z2oZuafIfjQL3zpbJlRZ1Y/vZXh6A=;
        b=hG+b/dpjD4UcBnZR1VnyJBeoIN9kcn4+XU8WSur2F2eA4maVh4mtB5nkF/6VJF5zgz
         Ax0m0RHsU4mBBezl4GaZruuKFQUdQI2GhggaUkZXI9HQ62cBWc+AVL4fzScQhHIpthBN
         tjXrrn9f8QTqjQkSAwtjQ/N1Pw5E3TRKLqkMirjG85hacRsSf+HqKO6z4udnVs7soavG
         3cYr0ABcJGxCHP28UcJwHJ0Z2A/7JtcsZkXrE6L+XVMuDArUbTKQqkmX2JLmSzz78NxO
         SC0s1kap4t6FYsSSydtddnOTdaQZRmxdk+KI9/nbxcpezdo4pPlQ7MNJ7uqXAE7ld2W+
         m2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458589; x=1712063389;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NzP2CCUVdCYdG6Z2oZuafIfjQL3zpbJlRZ1Y/vZXh6A=;
        b=RtDrkpLJVPS8jKn20p3k0mVgLcF4dXtySBL6Vvd3X7za+J0002io3y6VoVJICUeyZY
         zuADFvAXHW+vQ9lD5ojEVLpKwqHil1x2oojgXSqFb84k08VVIy6nnTFFlhPgZgSVSyv7
         OtH7Gyp5YUAVVF9ul5UB/ZUSu3I8F0zLn3MvOqZTpqc0kPTdIysoWsbXYK/Tv5kZatFx
         UG0u1jSk/x6wyEIbBSCNLTtWymn+gOYgvn7pVorE/7dmtM9Fu5yoO0/7110EH76Mz5Hh
         IqUERDuQDCOvLk7nY2kLkLelYAcXvE3CIW/ZdfM+GcEcSFVUu6CepRktqThz9U9ukp54
         7Ssw==
X-Forwarded-Encrypted: i=1; AJvYcCVS6ARbWuoptsu6Q9/trnbWshBie0tzFLgI9pqz6Y29b7FyR0JKitvq4q/JUnHnFaOv1xaScSwr8S1VH3WxBkImrW8UWibqItFZgpBk6w==
X-Gm-Message-State: AOJu0YxOOTXLgOspybCkza8wLaI0Wp+JDHKDp7Rjz0D4QvBK7XY/EmzS
	a1h5/JRI1a/aWTNlmZUXbFzu3/T6oyQtA9EaPCw/Cp5bUELQb4h9WMPl3ov4Nuj3O80dG1RvncT
	Mdw==
X-Google-Smtp-Source: AGHT+IEUwLWU4LZfecEsq4dTBQYeNqu7eWfbD0LdWXMXrH5wFJBdab+iFQZnjEs0NErmOBTQ4tDm00NQItY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:9a0b:0:b0:611:a424:3c66 with SMTP id
 r11-20020a819a0b000000b00611a4243c66mr468282ywg.5.1711458589679; Tue, 26 Mar
 2024 06:09:49 -0700 (PDT)
Date: Tue, 26 Mar 2024 14:09:47 +0100
In-Reply-To: <b6a2a782-894a-461c-8fc1-9a3669545633@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com> <20240325134004.4074874-2-gnoack@google.com>
 <80221152-70dd-4749-8231-9bf334ea7160@app.fastmail.com> <20240326.pie9eiF2Weis@digikod.net>
 <83b0f28a-92a5-401a-a7f0-d0b0539fc1e5@app.fastmail.com> <20240326.ahyaaPa0ohs6@digikod.net>
 <b6a2a782-894a-461c-8fc1-9a3669545633@app.fastmail.com>
Message-ID: <ZgLJG0aN0psur5Z7@google.com>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for
 IOCTL hooks
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:58:42PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 26, 2024, at 11:10, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Tue, Mar 26, 2024 at 10:33:23AM +0100, Arnd Bergmann wrote:
> >> On Tue, Mar 26, 2024, at 09:32, Micka=C3=ABl Sala=C3=BCn wrote:
> >> >
> >> > This is indeed a simpler solution but unfortunately this doesn't fit
> >> > well with the requirements for an access control, especially when we
> >> > need to log denied accesses.  Indeed, with this approach, the LSM (o=
r
> >> > any other security mechanism) that returns ENOFILEOPS cannot know fo=
r
> >> > sure if the related request will allowed or not, and then it cannot
> >> > create reliable logs (unlike with EACCES or EPERM).
> >>=20
> >> Where does the requirement come from specifically, i.e.
> >> who is the consumer of that log?
> >
> > The audit framework may be used by LSMs to log denials.
> >
> >>=20
> >> Even if the log doesn't tell you directly whether the ioctl
> >> was ultimately denied, I would think logging the ENOFILEOPS
> >> along with the command number is enough to reconstruct what
> >> actually happened from reading the log later.
> >
> > We could indeed log ENOFILEOPS but that could include a lot of allowed
> > requests and we usually only want unlegitimate access requests to be
> > logged.  Recording all ENOFILEOPS would mean 1/ that logs would be
> > flooded by legitimate requests and 2/ that user space log parsers would
> > need to deduce if a request was allowed or not, which require to know
> > the list of IOCTL commands implemented by fs/ioctl.c, which would defea=
t
> > the goal of this specific patch.
>=20
> Right, makes sense. Unfortunately that means I don't see any
> option that I think is actually better than what we have today,
> but that forces the use of a custom whitelist or extra logic in
> landlock.
>=20
> I didn't really mind having an extra hook for the callbacks
> in addition to the top-level one, but that was already nacked.

Thank you both for the review!

I agree, this approach would break logging.

As you both also said, I also think this leads us back to the approach
where we hardcode the allow-list of permitted IOCTL commands in the
file_ioctl hook.

I think this approach has the following upsides:

  1. Landlock's (future) audit logging will be able to log exactly
     which IOCTL commands were denied.
  2. The allow-list of permitted IOCTL commands can be reasoned about
     locally and does not accidentally change as a side-effect of a
     change to the implementation of fs/ioctl.c.

A risk that we have is:

  3. We might miss changes to fs/ioctl.c which we might want to
     reflect in Landlock.


To think about 2 and 3 in more concrete terms, I categorized the
scenarios in which IOCTL cmd implementations can get added to or
removed from the do_vfs_ioctl() layer:

  Case A: New cmd added to do_vfs_ioctl layer

    We want to double check whether this cmd should be included in
    Landlock's allow list.  (Because the command is new, there are no
    existing users of the IOCTL command, so we can't break anyone and
    we it probably does not require to be made explicit in Landlock's
    ABI versioning scheme.)

    =3D=3D> We need to catch these changes early,
        and should do Landlock-side changes in sync.

  Case B: Existing cmd removed from do_vfs_ioctl layer

    (This case is unlikely, as it would be a backwards-incompatible
    change in the ioctl interface.)

  Case C: Existing cmd is moved from f_ops->..._ioctl() to do_vfs_ioctl()

    (For regular files, I think this has happened for the XFS
    "reflink" ioctls before, which became features in other COW file
    systems as well.)

    If such a change happens for device files (which are in scope for
    Landlock's IOCTL feature), we should catch these changes.  We
    should consider whether the affected IOCTL command should be
    allow-listed.  Strictly speaking, if we allow-list the cmd, which
    was previously not allow-listed, this would mean that Landlock's
    DEV_IOCTL feature would have different semantics than before
    (permitting an additional cmd), and it would potentially be a
    backwards-incompatible change that need to be made explicit in
    Landlock's ABI versioning.

  Case D: Existing cmd is moved from do_vfs_ioctl() to f_ops->..._ioctl()

    (This case seems also very unlikely to me because it decentralizes
    the reasoning about these IOCTL APIs which are currently centrally
    controlled and must stay backwards compatible.)



So -- a proposal:

* Keep the original implementation of fs/ioctl.c
* Implement Landlock's file_ioctl hook with a switch(cmd) where we list
  the permitted IOCTL commands from do_vfs_ioctl.
* Make sure Landlock maintainers learn about changes to do_vfs_ioctl():
  * Put a warning on top of do_vfs_ioctl() to loop in Landlock
    maintainers
  * Set up automation to catch such changes?


Open questions are:

* Micka=C3=ABl, do you think we should use a more device-file-specific
  subset of IOCTL commands again, or would you prefer to stick to the
  full list of all IOCTL commands implemented in do_vfs_ioctl()?

* Regarding automation:

  We could additionally set up some automation to watch changes to
  do_vfs_ioctl().  Given the low rate of change in that corner, we
  might get away with extracting the relevant portion of the C file
  (awk '/^static int do_vfs_ioctl/, /^\}/' fs/ioctl.c) and watching
  for any changes.  It is brittle, but the rate of changes is low, and
  reasoning about source code is difficult and error prone as well.

  In an ideal world this could maybe be part of the kernel test
  suites, but I still have not found the right place where this could
  be hooked in.  Do you have any thoughts on this?

Thanks,
=E2=80=94G=C3=BCnther

