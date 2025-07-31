Return-Path: <linux-fsdevel+bounces-56369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6366BB16D43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919537B438B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDEE29E107;
	Thu, 31 Jul 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZddtZwXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639218D643;
	Thu, 31 Jul 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949530; cv=none; b=rd82YfRT7le6rJA3GB9Ketb2vGuZMu4pcDYbVi6LbHTlls2haHwFb3m9E7NCSvI5kMRZGnVcsn3/VkzZQiegGwefuZfa8bjExJKIAzZwm+aGHzQwJLlmID44ALbEWo1oP6AOr2LkLb2s1OWDfBKJVHEtIhG4pLAMk1nEBPDz3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949530; c=relaxed/simple;
	bh=t9y75WKgQEmwobPN1bDvg+pjhu7e04Y4adVtQiAwsPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtigsSzhZngLp54dfGNI1HMeHUgWNtJ4KhKc50ByA2gmVoTx7nf2orsF0bs9f2WIuo9bHCf0Yf8mWvu8yCSlDcX9L61owOZLBwwTNSN3Qt2CgkgMfekN5sriyHqZad/+R2CphtZukvVxCCSr03Hlnl+YB0hno7wBGIZYVW72jQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZddtZwXf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so182451a91.1;
        Thu, 31 Jul 2025 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753949528; x=1754554328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcCzSfZmMVWescppdqYD+o32Lrs8WKU2rFViCQiIMOY=;
        b=ZddtZwXfK0jxKiYPxXiBYGxBj8f+9/bHKBQpXDGCSV9hcqMkxbM496EO+LhU8LSS6I
         ceHWxGQJkPeBoPWFN1xGV4cIo/svYNakM469l1maAdyVRMcdwnphByh12iMK6k0dhpif
         rcVBT/KFB+FXjuCRZtl0p+PbT8qYLPDHCi+v09b4lI59RE1ECM7vAfxVrdyKdnlOOIq/
         ZcrN+9lofSPE+cDND2JmsxyDcQMVoyyCQ/E6UTWjkfGrA2UtvIEK43enTanAvlcDywtB
         DSKfsfBCqj9qwr4BhFxN1oS/XdRsX4DpxEdSltkne3LUF793qrDhaY55e5HO65Au31o3
         ZIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949528; x=1754554328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcCzSfZmMVWescppdqYD+o32Lrs8WKU2rFViCQiIMOY=;
        b=XMx/a47vmDb7S0M+JefWPw9Da1b7FpAZb7naSa5728GISOC8xvH7pRxDNTIaiaOC3N
         jiFo6sSSKAsBjuc/nkN32wCcQpjEjIUuHacCsGAQ4MS9hbcJBWOn7AucIC1RpKZz742c
         IgOVCCWylFyqanvTVrf0RMB+/xKBxgwAOAqo/Px1qqZAz7KkIDuFs9iw6aGc6eQTuGZ0
         W/6mz4qCPGZG5/hapCsEm/thHJvv4YQNBW4QCab6zqvYdR/5Ip1N7Fgn0ss4osQLnjgs
         RhXezdDZrr8xixElNFg7iZvnUr4l6vpmndTPGaIRQunUXGkgaKuZ0rxx6K7sOad+f0N6
         1oKw==
X-Forwarded-Encrypted: i=1; AJvYcCU5cOkyTvbFRfZ6L4DyEvY7ns399aUoqQTLsyIKTOZ7dU1AuZupebbSYmb9Z13AJHVvVzggFCAF@vger.kernel.org, AJvYcCUl+dgBFUu1JauFjoYv/q3gbWWPxMVS6eUMKwT8H85SCTwxLOa8HEHd6ieA7tM7aXVHEaM3zGGIZiQ=@vger.kernel.org, AJvYcCUlGgRF+q9lFft1pTMepzIkK8IaI7ij97ZQyAhZMCqMdpLAR1+ZKVtKg69vrWKX2T5j+6uh5N2XTZvnI31B2A==@vger.kernel.org, AJvYcCWMy8HxcQSVXToyJBHfB4pVeN3q4iLjt4W3J5sQR6f66iNsQ4Z2B1T0a/By2kN+Ki2jiNYwIL0wsidJt7CV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzle/9VMfuwNMrFlIVOd6qp1jE6TiS0Z8SqQ694aMgieElCWhWv
	kB/21L803JiYLVIKzq5BddXEKcQqchoyU/0brg7TJEnGX+9tfw7yggtCF2hbwzKgI+l3dBdgLQr
	0ipBfiLcceS5KT+aJeqKfQbTSwX8XCks=
X-Gm-Gg: ASbGncvLLIYuMw2uJAccHtChcIlq5q3FPhUbH1ANOc/nxQFEfK9AfYxTihSokrYDuCc
	JRLQdEplEyDR9wD45I2rt5giX8lMc8TJXGAfLQyJglKKsGlKm3Yp3mAYAD8vjnnXZ12d16Tx283
	uOlHvJQPuYhlD/vkPCcxn/zZ0Q36V3h+q71ncXT9dtHZ2ywV7d9cUN5t+byapeVxp7vrK3B2Kbt
	nykc59Czi7UzzHusFGb5zVDqQc5aLeJ8XhIhqE=
X-Google-Smtp-Source: AGHT+IEuu3Xtmd03e2LZqfSo6W08NEgHMK1D7VzWrLHB2VcoYOfess1nvNWDrQ9tfRV/Cwa7B9uEgxC6mDi2lgOiY9I=
X-Received: by 2002:a17:90b:184b:b0:31f:20a:b52c with SMTP id
 98e67ed59e1d1-31f5dcb65b7mr10284091a91.0.1753949528216; Thu, 31 Jul 2025
 01:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV> <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV> <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <CAE1zp74Myaab_U5ZswjCE=ND66bT907Y=vmsk14hV89R_ugbtg@mail.gmail.com> <20250731-masten-resolut-89aca1e3454f@brauner>
In-Reply-To: <20250731-masten-resolut-89aca1e3454f@brauner>
From: Pavel Tikhomirov <snorcht@gmail.com>
Date: Thu, 31 Jul 2025 16:11:56 +0800
X-Gm-Features: Ac12FXyl37r6ZBS-p3C5O5RMUMTHwr4FqgrQ33e-T_933d6pMVVs5IMF_9wnoA0
Message-ID: <CAE1zp76BLiPzBozViPDCFyWbd_JBOYbXN_91O1xbDumOqJr9Rg@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrei Vagin <avagin@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev, 
	Linux API <linux-api@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 3:53=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jul 31, 2025 at 10:40:40AM +0800, Pavel Tikhomirov wrote:
> > If detached mounts are our only concern, it looks like the check instea=
d of:
> >
> > if (!check_mnt(mnt)) {
> >         err =3D -EINVAL;
> >         goto out_unlock;
> > }
> >
> > could've been a more relaxed one:
> >
> > if (mnt_detached(mnt)) {
> >         err =3D -EINVAL;
> >         goto out_unlock;
> > }
> >
> > bool mnt_detached(struct mount *mnt)
> > {
> >         return !mnt->mnt_ns;
> > }
> >
> > not to allow propagation change only on detached mounts. (As
> > umount_tree sets mnt_ns to NULL.)
>
> Changing propagation settings on detached mounts is fine and shoud work?
> Changing propagation settings on unmounted mounts not so much...

Sorry, it's my confused terminology, here by "detached" mounts I mean
mounts which were unmounted with umount2(MNT_DETACH), maybe I should
call them "unmounted" (e.g. s/mnt_detached/mnt_unmounted/).

And yes, I understand why we need to allow changing propagation on
mounts in anonymous namespace without being inside it, because one
can't just enter anonymous namespace.

I don't think that we need to change anything, just sharing my
thoughts that it could be more relaxed and will still protect us from
propagation setting on unmounted mounts.

>
> >
> > Also in do_mount_setattr we have a more relaxed check too:
> >
> > if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt=
))
> >         goto out;
> >
> > Best Regards, Tikhomirov Pavel.
> >
> > On Sun, Jul 27, 2025 at 5:01=E2=80=AFAM Andrei Vagin <avagin@google.com=
> wrote:
> > >
> > > On Sat, Jul 26, 2025 at 10:53=E2=80=AFAM Al Viro <viro@zeniv.linux.or=
g.uk> wrote:
> > > >
> > > > On Sat, Jul 26, 2025 at 10:12:34AM -0700, Andrei Vagin wrote:
> > > > > On Thu, Jul 24, 2025 at 4:00=E2=80=AFPM Al Viro <viro@zeniv.linux=
.org.uk> wrote:
> > > > > >
> > > > > > On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > > > > > > Hi Al and Christian,
> > > > > > >
> > > > > > > The commit 12f147ddd6de ("do_change_type(): refuse to operate=
 on
> > > > > > > unmounted/not ours mounts") introduced an ABI backward compat=
ibility
> > > > > > > break. CRIU depends on the previous behavior, and users are n=
ow
> > > > > > > reporting criu restore failures following the kernel update. =
This change
> > > > > > > has been propagated to stable kernels. Is this check strictly=
 required?
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > > Would it be possible to check only if the current process has
> > > > > > > CAP_SYS_ADMIN within the mount user namespace?
> > > > > >
> > > > > > Not enough, both in terms of permissions *and* in terms of "tho=
u
> > > > > > shalt not bugger the kernel data structures - nobody's priveleg=
ed
> > > > > > enough for that".
> > > > >
> > > > > Al,
> > > > >
> > > > > I am still thinking in terms of "Thou shalt not break userspace".=
..
> > > > >
> > > > > Seriously though, this original behavior has been in the kernel f=
or 20
> > > > > years, and it hasn't triggered any corruptions in all that time.
> > > >
> > > > For a very mild example of fun to be had there:
> > > >         mount("none", "/mnt", "tmpfs", 0, "");
> > > >         chdir("/mnt");
> > > >         umount2(".", MNT_DETACH);
> > > >         mount(NULL, ".", NULL, MS_SHARED, NULL);
> > > > Repeat in a loop, watch mount group id leak.  That's a trivial exam=
ple
> > > > of violating the assertion ("a mount that had been through umount_t=
ree()
> > > > is out of propagation graph and related data structures for good").
> > >
> > > I wasn't referring to detached mounts. CRIU modifies mounts from
> > > non-current namespaces.
> > >
> > > >
> > > > As for the "CAP_SYS_ADMIN within the mount user namespace" - which
> > > > userns do you have in mind?
> > > >
> > >
> > > The user namespace of the target mount:
> > > ns_capable(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)
> > >

