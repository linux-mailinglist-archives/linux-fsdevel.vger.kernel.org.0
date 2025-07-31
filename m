Return-Path: <linux-fsdevel+bounces-56366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6867B16A84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 04:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1082D1AA0F19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 02:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49E239E95;
	Thu, 31 Jul 2025 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf0S6QkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267A18A6B0;
	Thu, 31 Jul 2025 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929653; cv=none; b=glmYFDSp/1KWd7d+algUf0qntf3slRBSM272IMoM0oQJZ6Z8d4evouQQj0IPiDJXkY64VoLctHdU75UalhQ7WTt13xqc8CTqYxap76xt5U8Lv9mooshqbKc9DU3ZuvF3QnCwLMohu6XUXxkRm2/vq8HHkOQxUn9Zch6jHSszHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929653; c=relaxed/simple;
	bh=3a12tHqij9N3PVZUPClnk9cypm9n4czLihZ6VU4IrEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlxriqR7F1Hh0R1svxpD+n2H4mupSzuYK4fRtOoZZAJDTeV3QbUArsop/aBz7YuRvWIAoAzMgSUY+WoaynxAHE2Nvwuem5PmnR3q4R8E2A33djybVkLpVcQ37rh3DAcULezYeV28Oi5gsGabvdTYS8Wmrhml2Yy6ft+ysVpCZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf0S6QkR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso431710a12.2;
        Wed, 30 Jul 2025 19:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753929651; x=1754534451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CQqvk7Q1Awqd0peVfmJpjnN11IYasMyTNsOJwXbWQU=;
        b=Rf0S6QkRzzxbJzaPU0IucJ/Dv+555gYZzENDOgnOlKNAybD3lm1uldy69CTELq/3nc
         Uw1Csw9GKnaamAH1TV0yhHW4b8HA9lQIZdATIzXEYlKNVsXCG5gMrG71dElUmOquixiM
         faGg5DLMykUbJVU55ziWSXGS5DLDKzUT5HMEpZukYawvRD4gAhA0BYqB0LIRag1cDYzc
         N3eTcQ6rOJiPCl41VwfK3T9NqcKtw32zCaNXolDnyldfU0p6yudMgoNg7UtAxr42rIqx
         a80VvM/GhhnG+zqiXL5Pnw59hLGHEf91vpHvke6DgcKNfQrOI6MC2pVfwoFJA1Q8HLTs
         NooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753929651; x=1754534451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CQqvk7Q1Awqd0peVfmJpjnN11IYasMyTNsOJwXbWQU=;
        b=n96aeZf+p/Ad8489FSdprdkJn9OTQtnK3+yfGvp9dxUTRnopD47xYYFUTmp71wZapR
         cbPr9D23qU0TML4iH2vFUkjBDwQxWH0hnNx87y8WezF4elLL+iaK7cXXkry7Ecru8ENU
         xQYDKTmjI9uZ80AN88Aafxsy7FxcUV5obDp7kHj4kTeBezDeIhTqOU9W+Wlf2KtvJIyE
         vMeleLsoZCFbg1DcjZaDAd7xZ0seXMFENZk88sr1Acg+T/GspjQ1Av1tldXmpY8IPql5
         n/pqbf8/gRKGVYYepzF0diwoMLZTz0tId0DQyJ4Acy6nr2QufU2TmcxAOrDAcWuEtVB4
         vFEg==
X-Forwarded-Encrypted: i=1; AJvYcCV4w5sDvUJhfsJ7zHMIYZ9hz5iptkK3EQp7XryagOH8FRVFEl53cICctzU2AbjS76gsLT6uc0+mDT5Sg7TxyQ==@vger.kernel.org, AJvYcCVS4YXibjph+2beS+A+4NAwBaGDofJkYlu0wAfsmC2A7QlJxZZ9Cb9tXynvW5MwhPNu4H+X9mnFQr0=@vger.kernel.org, AJvYcCWMDR4tIp/cuoP+xNy42LGTN2kopqDj0OAvVjqSEG21syZ34/BtwPR9Bud7AfPBkwsIuIk0/w35@vger.kernel.org, AJvYcCXjG+zCIEx+s0eRJRhNf5s5gd/ZcBMIx36cEpCJxmHmfAVogJKDJ8wnNaRm7GEs8m0H5g4deR6BMxM85vFw@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2HJy01PGGh6uL+d0j2LCs3DRaRpP+E8CpqfjQoBwx2EA6qxc
	VZKbIcR424ijt4hc8VkYXEL93nxD8GxFzQWWuw+HHqnxf6q5vnNS6owGNT0NhVynrtWq9X/JDMB
	W4LZLFlOmK/KVlOQ7altyWh1xbS93XOE=
X-Gm-Gg: ASbGncvKWTHiWIDbIvr1QzYVifLw7CmGjGnCaPEQdtaV+X/7M4EDkPK+e2u59JDFdxp
	g/DsZHwAfsvn5Na60xTvfVE9IpPyC5vax9+1VitH0Esivmw6Th41BxQYnT3qFoqHd2lPCQPYpDL
	p/PLXmBwcfinLK8IpyMVrNjAHO9yWJzbogQy4WLqPFT9DaOw+oAzS3c9seJp/x2UyqKslnBGoHl
	WEokF2wF9HrwrCPsFNthxiwBW4T0BgGzIWJC6AZgJ0E4TTZCA==
X-Google-Smtp-Source: AGHT+IEer314JEfgtgZ9Pz5/zv9i5Zh9oeAvswURdKpH+l/Yga0+wQP5lxV1mHKZaEO7wk2zN/VJyrOfcdvA0n3d2MA=
X-Received: by 2002:a17:90b:39c5:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-31f5de3ceb7mr7878737a91.14.1753929651140; Wed, 30 Jul 2025
 19:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV> <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV> <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
In-Reply-To: <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
From: Pavel Tikhomirov <snorcht@gmail.com>
Date: Thu, 31 Jul 2025 10:40:40 +0800
X-Gm-Features: Ac12FXyQt4pEAVf5fhzS5ubdEtkRViMRFtrqLTmfPA4sKpgrINaSaazpM3ky72k
Message-ID: <CAE1zp74Myaab_U5ZswjCE=ND66bT907Y=vmsk14hV89R_ugbtg@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Andrei Vagin <avagin@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrei Vagin <avagin@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev, 
	Linux API <linux-api@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If detached mounts are our only concern, it looks like the check instead of=
:

if (!check_mnt(mnt)) {
        err =3D -EINVAL;
        goto out_unlock;
}

could've been a more relaxed one:

if (mnt_detached(mnt)) {
        err =3D -EINVAL;
        goto out_unlock;
}

bool mnt_detached(struct mount *mnt)
{
        return !mnt->mnt_ns;
}

not to allow propagation change only on detached mounts. (As
umount_tree sets mnt_ns to NULL.)

Also in do_mount_setattr we have a more relaxed check too:

if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
        goto out;

Best Regards, Tikhomirov Pavel.

On Sun, Jul 27, 2025 at 5:01=E2=80=AFAM Andrei Vagin <avagin@google.com> wr=
ote:
>
> On Sat, Jul 26, 2025 at 10:53=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> >
> > On Sat, Jul 26, 2025 at 10:12:34AM -0700, Andrei Vagin wrote:
> > > On Thu, Jul 24, 2025 at 4:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org=
.uk> wrote:
> > > >
> > > > On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > > > > Hi Al and Christian,
> > > > >
> > > > > The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> > > > > unmounted/not ours mounts") introduced an ABI backward compatibil=
ity
> > > > > break. CRIU depends on the previous behavior, and users are now
> > > > > reporting criu restore failures following the kernel update. This=
 change
> > > > > has been propagated to stable kernels. Is this check strictly req=
uired?
> > > >
> > > > Yes.
> > > >
> > > > > Would it be possible to check only if the current process has
> > > > > CAP_SYS_ADMIN within the mount user namespace?
> > > >
> > > > Not enough, both in terms of permissions *and* in terms of "thou
> > > > shalt not bugger the kernel data structures - nobody's priveleged
> > > > enough for that".
> > >
> > > Al,
> > >
> > > I am still thinking in terms of "Thou shalt not break userspace"...
> > >
> > > Seriously though, this original behavior has been in the kernel for 2=
0
> > > years, and it hasn't triggered any corruptions in all that time.
> >
> > For a very mild example of fun to be had there:
> >         mount("none", "/mnt", "tmpfs", 0, "");
> >         chdir("/mnt");
> >         umount2(".", MNT_DETACH);
> >         mount(NULL, ".", NULL, MS_SHARED, NULL);
> > Repeat in a loop, watch mount group id leak.  That's a trivial example
> > of violating the assertion ("a mount that had been through umount_tree(=
)
> > is out of propagation graph and related data structures for good").
>
> I wasn't referring to detached mounts. CRIU modifies mounts from
> non-current namespaces.
>
> >
> > As for the "CAP_SYS_ADMIN within the mount user namespace" - which
> > userns do you have in mind?
> >
>
> The user namespace of the target mount:
> ns_capable(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)
>

