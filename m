Return-Path: <linux-fsdevel+bounces-26012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D6952621
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 01:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D40282860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626314E2D6;
	Wed, 14 Aug 2024 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYAAYsoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298B143748;
	Wed, 14 Aug 2024 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723677460; cv=none; b=L6KCkCTPhxuBed47NV8xANH6i7nkSzqrFV3bRhjfxSH15EQwNg5Vf2vQW8Y2SZ+VWpv+9jOqpx07RXUjDvJB/CQ51sdxE+lOhnzWPPmQe7XfUz6msFqMvK06/If+JevMulI6eW1PQ2P/wGgK87d/kcR0eCGmvhjOx7X1GgFCbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723677460; c=relaxed/simple;
	bh=6P5Sf1tLHK77YZ/7H49513aGplraseyEymSyPX8onHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nutdf9UrYVScVGrpXDsrd/cpllv4evAFc/WIJvVk6AhYqvaFghymdwCK3XtyLi9tG6LxrqODgG6XarOz2TuJq6Go96mhORAq/FmIHuZjMmIwvPFevW1WagNMdUayovXN+Lfyg237O9uk5ON7BcjIjGtLyO5huIQ4K7BrNYJvLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYAAYsoz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3bdab22b1so250141a91.0;
        Wed, 14 Aug 2024 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723677458; x=1724282258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dsmt7PofX/6vqTcTWZf5lQLEqw46EkJZz305dvn1YTI=;
        b=DYAAYsozUVrxgfqpUS9JPVItlEyykMnXlK0TCnchRQ6R+L2l0N4X0Dlt14DXShipg7
         AMTrQf6CP9X5og3JoBlGRTFwnsEBzl1cWvHOarCkKQV/CJ+vDDZlpVJmhgf2hZHZB+VW
         d2k+PLYOx8IfFduHRoECEDhTUZwB7dU3uizOOvvYPhq3Y/y9Hx9CIfBJs2hEhm/sDsQ3
         wciOPcodYK42P/I5pjMWq3NWF3Le9B3RxQbxygFPztxb4d9uDaX+TwZJQRxvUbHmA3v6
         c5fAy0/R4MicR/6RNx6mKpElf/sbOJtyd2h8ROHCcg8C4ZZMdpuOhAhkSLq6PeSS24yz
         x8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723677458; x=1724282258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsmt7PofX/6vqTcTWZf5lQLEqw46EkJZz305dvn1YTI=;
        b=BvUk8oDK05lqNFD7h5tKmYgq7zlL9UIcqYQjSut96FPhTjNsl36rnLaAcv30Zj0rqv
         DnbA/hVW/7XoRxphB4enUsvCEFmgbQ+LFJaSlo5EvVL8HUJewO4flVkX1f30ia/ydw9p
         BB0jRCoLzI/q6/VUhC3N/XheA25CjHNgnSP0KU2nOKJS3i9t8pfmlsAlXZ0Ewo8Ut+/Z
         4DLDA1yqs8o/TSCU0NZXJq6Eld+zAP43V8mCKU4kVhJCS5cGfesp9rST9Zbx+0TQtDYm
         OgnMGHR1kYMGoNrYNnKnj/eMCCa2hdekBuaqjVolKaJYDl3irGBLwZh32XkDlo2HZ6YI
         /Eaw==
X-Forwarded-Encrypted: i=1; AJvYcCUiTHNHBvuqBkOPtJ/5QXh9AMiTK3qRyt2dar84F8CKsF0RWS5qxMUyX/w/f1ofER9W+mivNQs2k2Om6nUXayaI4Kgw49sx1f4fIch76BOb8JmmW5cOHtdBzW3bLNHspnCvRg==
X-Gm-Message-State: AOJu0YyKZQIkkz0UWZ0cwEPC2IbTfb6PyGzK3cmfp4E3l8eVNCzWE460
	7ioLOjYHwWJwvXwWnh/982ouRC9YoU7T/ZHRJEXrKP2gFR/JmECBVcz9JiWF4X0PxZ/7GVdGC+p
	r06gVyQkVx+uvkCvFkWpOHoum6PM=
X-Google-Smtp-Source: AGHT+IF7zEO6TOwIaZLOsjSzZTn/Bf0jDNRTBkavterMLVDPAXCr9bLu+sq0vwpCMcujo6ViwNwk7DIrhJuH/9b67JQ=
X-Received: by 2002:a17:90a:fc81:b0:2d3:c0ea:72b3 with SMTP id
 98e67ed59e1d1-2d3c0ea72dbmr1824092a91.34.1723677457867; Wed, 14 Aug 2024
 16:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230300.915127-1-andrii@kernel.org> <20240813230300.915127-4-andrii@kernel.org>
 <Zr0j_mYCtM-P-vlK@krava>
In-Reply-To: <Zr0j_mYCtM-P-vlK@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 Aug 2024 16:17:25 -0700
Message-ID: <CAEf4BzbSWG=mZXx1tn1n1OEvOwinpXMJ2fJhPRpVUqP7u_RY8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/8] bpf: factor out fetching bpf_map from FD and
 adding it to used_maps list
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, viro@kernel.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 2:39=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Aug 13, 2024 at 04:02:55PM -0700, Andrii Nakryiko wrote:
> > Factor out the logic to extract bpf_map instances from FD embedded in
> > bpf_insns, adding it to the list of used_maps (unless it's already
> > there, in which case we just reuse map's index). This simplifies the
> > logic in resolve_pseudo_ldimm64(), especially around `struct fd`
> > handling, as all that is now neatly contained in the helper and doesn't
> > leak into a dozen error handling paths.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 115 ++++++++++++++++++++++++------------------
> >  1 file changed, 66 insertions(+), 49 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index df3be12096cf..14e4ef687a59 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(struct b=
pf_map *map)
> >               map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> >  }
> >
> > +/* Add map behind fd to used maps list, if it's not already there, and=
 return
> > + * its index. Also set *reused to true if this map was already in the =
list of
> > + * used maps.
> > + * Returns <0 on error, or >=3D 0 index, on success.
> > + */
> > +static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, =
bool *reused)
> > +{
> > +     struct fd f =3D fdget(fd);
>
> using 'CLASS(fd, f)(fd)' would remove few fdput lines below?

That's done in the next patch once we change __bpf_map_get() behavior
to allow usage of CLASS(fd, ...)

>
> jirka
>
> > +     struct bpf_map *map;
> > +     int i;
> > +
> > +     map =3D __bpf_map_get(f);
> > +     if (IS_ERR(map)) {
> > +             verbose(env, "fd %d is not pointing to valid bpf_map\n", =
fd);
> > +             return PTR_ERR(map);
> > +     }
> > +

[...]

