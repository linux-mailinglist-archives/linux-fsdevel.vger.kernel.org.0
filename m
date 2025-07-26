Return-Path: <linux-fsdevel+bounces-56092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6744DB12C82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 23:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A783B177CF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E2215F5C;
	Sat, 26 Jul 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzNPhLLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14942063F0
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753563694; cv=none; b=X0Jinl2b2Ec0p0hFq64chBuBVPZuUaA/OaZnjvgwCV7ygjBtin5WJOFM3NFi+Khspgym21PUlqEXx517D/DDPLyHP92S30ALrtH2TWayOXdbX81H0PA80cfM5rKbWmQkAAF1gOz7oCG9+V+xlpv7DfJfFg4dnfe3mcfITnTur4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753563694; c=relaxed/simple;
	bh=GOOK+NKSqEawB65E8IgBt4psR5xQS3I+Ix0GnU5cvbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXNaWlzvM9FHC3Hq57cqDY1PLzrgY4xxhlNs1CFbar65TSQ9rtMxnPm+Ok+irjQAQLIPGnYtUdtOcUCFUEqiUlL4t7XEhZU7Au48iBPPlUIoXq4BltW8xjlPpdowB/KjifqtsY7/RWe7n6DH+8q5Fczdm8iju4MLbBoed/6v82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzNPhLLo; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e283b2d065so153285ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753563692; x=1754168492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x4fJxfKzaOWGYLSu6UptUSjwhrzaz0p9fgAriJd8/o=;
        b=dzNPhLLoPrnwwuVwkdGMUHlGGzqygzbnBOncbw2UTpcBu4goNE2AriuImgCpl5oaEL
         smS9azGCX3obUllUHLltFbN/2dhvPIPjomOpxDpmxZaLsmZqzfoEu1hy7IYMiwkS4B/U
         /UGdndgd0bpawluqE54nOnStV6ovBG0cEXSVhe0VvyHzzju3I+MvoYBSFPIQPUKM6808
         e+Vgui9ImsVcOOtIDX337+WA1fl6u7mVvgj7M7gUgl4aN/3/Hzadi31fwMGNWddTMtNJ
         gZ+GpuyBW8GdcJOsDRn9QiqlDul/SfQEOFeNOqF91QjkPhqfK3gXmEeU9ZQOZs3+zHeq
         svmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753563692; x=1754168492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x4fJxfKzaOWGYLSu6UptUSjwhrzaz0p9fgAriJd8/o=;
        b=bI4tgm3XM2NJJSIczFzNq5UHyYfXAOoLoTCZR+8DL3AcMriXZyxESGLahOtUMlNEUm
         KNqRMmY0NGm804iOvNbuXrrzwfEAO0LVZ7Nhni14L6QF9PH9MqMpE4u7y35IIX8oFh4S
         g/46+Xj6nUsVS38jvWNlWaG8Zj2lXkpWgATxiFrM0fY2ow2xUyuqXgY2AmLlxGf2proz
         bloDgHhsIhlya2d98ptfVA02DBkYcQ1uh/b0IaSipBq9TF7+uN1VKBW8iJg2LJBUEUSn
         y0nFlr3Y24/1neQn+QtjRcRqfzEG99VFd5HQEfFGy+a+UiRvEnNDki6GWFuoFwBWWHo7
         tu0w==
X-Forwarded-Encrypted: i=1; AJvYcCVVN2MauChOrxUe7xexaIP7WQwBoTfhRek6rz3c4ic0cwt3r9GgosrV0jPVgbV6UQj/1hJ7n3V1Fzp0mAaU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoig1C7xH20ZLBbtPYb3bdq4C3mGMrkjqMZ40cURt1JN4s3n5E
	VETpAxsvnAakWUrMnHnaOdYxty4BSTwv9VxUI9DygoK1JHaedPtOMD/QLyhtYBnkWfLWYDfMNiI
	EkjGQ/NAJtfATAO5SrOz1mXr4wbI74c1LF4OAO40H
X-Gm-Gg: ASbGncseed2yi/8i+PvlMSJ76Z8kB2uL7osNNLdjrgNiKXnYGB7xnTK33KoBrZnXO5E
	S0BNgJP1SSdCkEkOgod38wN8+UnqlQ6CHrSe1B9HYbrSK5na+6rgvBHdY2zXfL1tzEVWCrEClt7
	9XTfE9enLbs6jV/Kw6hUuCN5AJPwiTiVzCn9sXT+NFabPeV447YMYDy001Gd+o86l6efnmu+ObU
	gg7rYad
X-Google-Smtp-Source: AGHT+IEmA1DUIGHQb1RhToZt+PXTE893jXnkv9Gcbost3232KkW59jU5rvsNSTpPTWHOWmtITWmZ8sfC05S61MmnGZo=
X-Received: by 2002:a05:6e02:3786:b0:3e3:b0ed:2170 with SMTP id
 e9e14a558f8ab-3e3cbf79f02mr2916975ab.6.1753563691516; Sat, 26 Jul 2025
 14:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV> <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
In-Reply-To: <20250726175310.GB222315@ZenIV>
From: Andrei Vagin <avagin@google.com>
Date: Sat, 26 Jul 2025 14:01:20 -0700
X-Gm-Features: Ac12FXyA3quU2h7NGWT-ipBC-zbAngmnxqJ3Jg4xKgmnSzqf6a1vVrUdwUoL6Fs
Message-ID: <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	criu@lists.linux.dev, Linux API <linux-api@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 10:53=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Sat, Jul 26, 2025 at 10:12:34AM -0700, Andrei Vagin wrote:
> > On Thu, Jul 24, 2025 at 4:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > > > Hi Al and Christian,
> > > >
> > > > The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> > > > unmounted/not ours mounts") introduced an ABI backward compatibilit=
y
> > > > break. CRIU depends on the previous behavior, and users are now
> > > > reporting criu restore failures following the kernel update. This c=
hange
> > > > has been propagated to stable kernels. Is this check strictly requi=
red?
> > >
> > > Yes.
> > >
> > > > Would it be possible to check only if the current process has
> > > > CAP_SYS_ADMIN within the mount user namespace?
> > >
> > > Not enough, both in terms of permissions *and* in terms of "thou
> > > shalt not bugger the kernel data structures - nobody's priveleged
> > > enough for that".
> >
> > Al,
> >
> > I am still thinking in terms of "Thou shalt not break userspace"...
> >
> > Seriously though, this original behavior has been in the kernel for 20
> > years, and it hasn't triggered any corruptions in all that time.
>
> For a very mild example of fun to be had there:
>         mount("none", "/mnt", "tmpfs", 0, "");
>         chdir("/mnt");
>         umount2(".", MNT_DETACH);
>         mount(NULL, ".", NULL, MS_SHARED, NULL);
> Repeat in a loop, watch mount group id leak.  That's a trivial example
> of violating the assertion ("a mount that had been through umount_tree()
> is out of propagation graph and related data structures for good").

I wasn't referring to detached mounts. CRIU modifies mounts from
non-current namespaces.

>
> As for the "CAP_SYS_ADMIN within the mount user namespace" - which
> userns do you have in mind?
>

The user namespace of the target mount:
ns_capable(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)

