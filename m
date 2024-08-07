Return-Path: <linux-fsdevel+bounces-25328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4033694AD86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17360B213FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225412E1EE;
	Wed,  7 Aug 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcL40yfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3925823DE;
	Wed,  7 Aug 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044653; cv=none; b=kOo9bjICl2bGAcX/jwqSCpQylxr2pts4A8ryUUFSGM6AcevkTmfVKfHUgVsleeoQQ2OwBGZWglR32qywFpXiNlSmsV0jy6yh35866GokeD2+gjlkxGLGCZdVvNIaizJMttpKp1VHHNeBQ0hoaAKF9UAYQtJr9DAhTGHKpOTAhI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044653; c=relaxed/simple;
	bh=2XnifOrAEcvghCv0yWkE2XeW6zSqyK/G/NxfvmV+WMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMzj8SaWMAJdhJu8+irYp059Rv939vWEF11oNh7xTTlXSeJ9l2fkC9qTPfCPSqwRYDxZXyql8tdT3zz17B7IeR5QhgpYQfmVRkoRB3mwiy875tnQCKiiwfhlETQydrMtpDnmkjY6frgqhR3+T1vlHphAY49GAGzWQLnHkYxKvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcL40yfM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so260599366b.1;
        Wed, 07 Aug 2024 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723044650; x=1723649450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oyDFdnWOipjuzTZLeqx4CkLA/xSH6hcPg60gVyTjEU=;
        b=RcL40yfMEPctF9ipKMMohxB7MIt0yR9z9kbWh9sH/xoUlk/oaQugfGHQHh/099X720
         ofzVRyfje8rlWGMCFlU1X9DquHyNnv6c1c/8hMNgTqv1gNHxmYXhU4PP0tCPs8ouDKwp
         7Hq9GxK4dSlBcdVVCjWW1PTot3Q5jbvyEzZn6PNGbsBpD6/6ZXX6+YQWWbgA5Wren4A6
         Gmd87Qna/ZG6qaxhhJeJdJeugTIj/QSbne0JCbajq70DmgZlQaVFAQcYPPkivVj4PMOY
         KoBKgamoJSD7jHTS1yCxgLgU8fdYE2+3vZoy+MYLGZR4rd+P5cZrgDhW5biCEQXxgWXl
         iRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044650; x=1723649450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oyDFdnWOipjuzTZLeqx4CkLA/xSH6hcPg60gVyTjEU=;
        b=orknJc1llqymqPvomeVF8+viDo7ruwiHBlUmgQP5wyMtg0PITWqjFU9EM+WLvKnl1o
         TOHm5Fj5huvojNiLWbgTVxuQK/5b8Dnsz7Xuc4YG1j3S9y9stS9FtzhlOSPLY8haCB/i
         4ny+MKAKhR/yD40yxJSf/YZf6iCuWEkxr0K+MY81uMkKoUZfoHb8SlScTLxDZOUksfMD
         kXv2IadZ7alc8W9kC2GXwIwp/k8u8SdcbaFppyOHmuXpx7KSydpc1KT9SOCnRmH5ms5D
         MFzQw6/v+0W+fUUcL9bvmFG+yXBNnVh1q21sTjSnXVislkBz8n5F3uT1vMdin6Y+/c8j
         DD7A==
X-Forwarded-Encrypted: i=1; AJvYcCW+G84y613iIt5JUKxXep1zOn4ljLsTrZ0MQktFLU/YeaeQ0/5JyDOdtaB/IF05rdAmoBHOmhqchysDWjxSdb0T6/sVbiz6EJ6zymFJwbi9uDDukwO4GCk0rpHrSd2QGF1y9omjyR5L+XvmmdypkViauC11sv/z+vXMUS9+o9RkcEwggCLmpTBE4zmsAjx9SOdoxBfGFQgy9ds+J8kH/WPsFv+pfoSsNiY=
X-Gm-Message-State: AOJu0YwJSJy5bVG4i6AyTL6Hq72UxaLUlObKFWc77UU2Z5/pyjuS68vI
	k5K9IQ85AcwAMi7HBTh+ztZoyirr7KWSkJ3oBRi5wNo7L9PpVEIbiX80vViHDnLc858aWH57VKb
	JnL/OQki6yL4lRUp7e9U2kRSWwTU=
X-Google-Smtp-Source: AGHT+IHPnhrxKaIpMWXKHqgXceVSV50kDl3BgP7lMNWmdSEa++OzozUr5LaDBKhp5CX9UYbJBNGqE+rUFxssFg96rns=
X-Received: by 2002:a17:907:1c2a:b0:a7a:a138:dbd2 with SMTP id
 a640c23a62f3a-a7dc509f3bcmr1243934466b.50.1723044649601; Wed, 07 Aug 2024
 08:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org> <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
 <20240807-fehlschlag-entfiel-f03a6df0e735@brauner>
In-Reply-To: <20240807-fehlschlag-entfiel-f03a6df0e735@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 08:30:29 -0700
Message-ID: <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
To: Christian Brauner <brauner@kernel.org>
Cc: viro@kernel.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	amir73il@gmail.com, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 3:30=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Aug 06, 2024 at 03:32:20PM GMT, Andrii Nakryiko wrote:
> > On Mon, Jul 29, 2024 at 10:20=E2=80=AFPM <viro@kernel.org> wrote:
> > >
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > >
> > > Equivalent transformation.  For one thing, it's easier to follow that=
 way.
> > > For another, that simplifies the control flow in the vicinity of stru=
ct fd
> > > handling in there, which will allow a switch to CLASS(fd) and make th=
e
> > > thing much easier to verify wrt leaks.
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  kernel/bpf/verifier.c | 342 +++++++++++++++++++++-------------------=
--
> > >  1 file changed, 172 insertions(+), 170 deletions(-)
> > >
> >
> > This looks unnecessarily intrusive. I think it's best to extract the
> > logic of fetching and adding bpf_map by fd into a helper and that way
> > contain fdget + fdput logic nicely. Something like below, which I can
> > send to bpf-next.
> >
> > commit b5eec08241cc0263e560551de91eda73ccc5987d
> > Author: Andrii Nakryiko <andrii@kernel.org>
> > Date:   Tue Aug 6 14:31:34 2024 -0700
> >
> >     bpf: factor out fetching bpf_map from FD and adding it to used_maps=
 list
> >
> >     Factor out the logic to extract bpf_map instances from FD embedded =
in
> >     bpf_insns, adding it to the list of used_maps (unless it's already
> >     there, in which case we just reuse map's index). This simplifies th=
e
> >     logic in resolve_pseudo_ldimm64(), especially around `struct fd`
> >     handling, as all that is now neatly contained in the helper and doe=
sn't
> >     leak into a dozen error handling paths.
> >
> >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index df3be12096cf..14e4ef687a59 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(struct
> > bpf_map *map)
> >          map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> >  }
> >
> > +/* Add map behind fd to used maps list, if it's not already there, and=
 return
> > + * its index. Also set *reused to true if this map was already in the =
list of
> > + * used maps.
> > + * Returns <0 on error, or >=3D 0 index, on success.
> > + */
> > +static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd,
> > bool *reused)
> > +{
> > +    struct fd f =3D fdget(fd);
>
> Use CLASS(fd, f)(fd) and you can avoid all that fdput() stuff.

That was the point of Al's next patch in the series, so I didn't want
to do it in this one that just refactored the logic of adding maps.
But I can fold that in and send it to bpf-next.

