Return-Path: <linux-fsdevel+bounces-25443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB694C315
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A4E282C3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB06190668;
	Thu,  8 Aug 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEswavS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74618EFD6;
	Thu,  8 Aug 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135908; cv=none; b=h9D2jm5FYc898WcPObVuIj3GS9EStJ11PfswJKpAD/rLTdLxZVbMtUSZxhtKCqPkiWsN8/z4IEDNkYhV4PSXCzpYd4lmpc2MY9AL3hc7itj1nEZlq8C5nxgWoNxzqp2QtPeMZ7qx5QQWOie+E+84EduhoQle1b2loEEUIScq/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135908; c=relaxed/simple;
	bh=Ahxb0BeAC+IzyZ0zPvTEkKoa6qEGzOeVrdvkyRL4udE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XT2+YpTQvxKzJA/Ma25PtfsMfNHxCeb+Wr3bxy5E/ypZkeeN412XW7d9p6LHgTZt0ymdjUvAuZolLcdofoFZPrMtkBLLDgtebWR0EPnKKhB3jFgt6t3nq+l/oVjx4VDsG0JOmAxCyCPV+StAe0xdKqkbhkmchc62QMAYTPEf29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEswavS+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36ba3b06186so608779f8f.2;
        Thu, 08 Aug 2024 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723135905; x=1723740705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwUfNPOLxl+TaZQIeJUM4EzBxGTEYjuduvorsIk5Zhc=;
        b=KEswavS+JbDNTfr83I9eTksMt+NGXAVbkQdtHDDWFa7I7J1IkWWSVRBPzyYSe+DF1P
         ZQ9OWtD4vNClHjgCsTfAGx3Fpq1bsR/6IjP9D/Zm4ZZLd7Ah3jk/QJeO8UBQEgLShYMM
         Vid6PJFwL+FCl273QSlqf4/O414KNCfNmqr6s+FrgiwLs52pS7hvf5zc0Rjp1qLV2N/H
         LvaN/LQ+q88lxjMnRz8JMT0mvTICHcqxW/rjBhzlI2NGVwrf2fzR329Nwvhg8jyXITUu
         KvvLbmWape5CUV4dXnC8v9BPbFZ8HkI/JqrOxTq/AnqoqXjU5Y4ka1MbzgKZKQvJvgSA
         3Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723135905; x=1723740705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwUfNPOLxl+TaZQIeJUM4EzBxGTEYjuduvorsIk5Zhc=;
        b=o/ieBmerEga04bNOTMM5SWsEEu2vYltG5C/kesYYzrR9LGKrbfsrq2tAc9ZmAlcEoN
         rNZoIVnI6lnOb2YIb8t8W7YoDuDmImRRWWQv3YuGIYWQzQdV/UncUmw/6DhfdXRLNHlM
         QMIP0HrP90GEy7Bv4I/lZ9Lgh00f639X+32FQ25gSRwATUfWyuFbn3zqfl8yZRl3ef9Z
         SlzEw9cPoZ0Kx4AEEE5iAsgP6qq31VCYKkfSMlDkOMymldMHYAErD21YCX6Nsb4/4DsZ
         r7wvX6e/TKpUMY5qxjdiVowe5x+dIiTkM9YGHFnhFmoIJe+a9Ksfolp8v9FBJvMsSU2Q
         xOQw==
X-Forwarded-Encrypted: i=1; AJvYcCUOP1tB3ckCRZZRophtwhgYrHxeT3LPqGgNGKdpIk9OszlV0LIwHjtrJIgrKfBFzrmMEUhnGJaSzOR6+o6gw0x5u+T9kk7nfaRfVEAZeA/m3rNtJMDDHNDlc6SMlvjzD+pYNgH0JO5qIJvYKjgsOQTQmi0qKWRpsV938lmoK/2MV+w7jF43q+/Q9DYW8UjqC8Iuh3ixKeT77+6fJhu4BJvbZj+1oUzj0+M=
X-Gm-Message-State: AOJu0YxJ766/ObmsVyCBuCEC7FKZrkY1uDSXzRoK39sBJKtuRTR586kq
	yzfFH/03bHCF/vRDs6hhfT5lWusdnVkBrYwPOQf9C+cuBFDQCS0iL5M5emLixiBlfeN2shmKmA4
	Qm30iWvfpsOdESRF/Hk7e+P8b0BQ=
X-Google-Smtp-Source: AGHT+IFXYJjv/rTRxsOtN2fZ2AMmazIebFUaeYLLCTxpkH/FUM1kIA1WEgJTWrurDtJ7rl2XjnuqPi70747pH++aGDc=
X-Received: by 2002:adf:f988:0:b0:368:5b78:c92e with SMTP id
 ffacd0b85a97d-36d274dea28mr1591175f8f.24.1723135905106; Thu, 08 Aug 2024
 09:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org> <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
 <20240807-fehlschlag-entfiel-f03a6df0e735@brauner> <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
In-Reply-To: <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Aug 2024 09:51:34 -0700
Message-ID: <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@kernel.org, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, kvm@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:31=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 7, 2024 at 3:30=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > On Tue, Aug 06, 2024 at 03:32:20PM GMT, Andrii Nakryiko wrote:
> > > On Mon, Jul 29, 2024 at 10:20=E2=80=AFPM <viro@kernel.org> wrote:
> > > >
> > > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > >
> > > > Equivalent transformation.  For one thing, it's easier to follow th=
at way.
> > > > For another, that simplifies the control flow in the vicinity of st=
ruct fd
> > > > handling in there, which will allow a switch to CLASS(fd) and make =
the
> > > > thing much easier to verify wrt leaks.
> > > >
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > ---
> > > >  kernel/bpf/verifier.c | 342 +++++++++++++++++++++-----------------=
----
> > > >  1 file changed, 172 insertions(+), 170 deletions(-)
> > > >
> > >
> > > This looks unnecessarily intrusive. I think it's best to extract the
> > > logic of fetching and adding bpf_map by fd into a helper and that way
> > > contain fdget + fdput logic nicely. Something like below, which I can
> > > send to bpf-next.
> > >
> > > commit b5eec08241cc0263e560551de91eda73ccc5987d
> > > Author: Andrii Nakryiko <andrii@kernel.org>
> > > Date:   Tue Aug 6 14:31:34 2024 -0700
> > >
> > >     bpf: factor out fetching bpf_map from FD and adding it to used_ma=
ps list
> > >
> > >     Factor out the logic to extract bpf_map instances from FD embedde=
d in
> > >     bpf_insns, adding it to the list of used_maps (unless it's alread=
y
> > >     there, in which case we just reuse map's index). This simplifies =
the
> > >     logic in resolve_pseudo_ldimm64(), especially around `struct fd`
> > >     handling, as all that is now neatly contained in the helper and d=
oesn't
> > >     leak into a dozen error handling paths.
> > >
> > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index df3be12096cf..14e4ef687a59 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(struct
> > > bpf_map *map)
> > >          map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> > >  }
> > >
> > > +/* Add map behind fd to used maps list, if it's not already there, a=
nd return
> > > + * its index. Also set *reused to true if this map was already in th=
e list of
> > > + * used maps.
> > > + * Returns <0 on error, or >=3D 0 index, on success.
> > > + */
> > > +static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd=
,
> > > bool *reused)
> > > +{
> > > +    struct fd f =3D fdget(fd);
> >
> > Use CLASS(fd, f)(fd) and you can avoid all that fdput() stuff.
>
> That was the point of Al's next patch in the series, so I didn't want
> to do it in this one that just refactored the logic of adding maps.
> But I can fold that in and send it to bpf-next.

+1.

The bpf changes look ok and Andrii's approach is easier to grasp.
It's better to route bpf conversion to CLASS(fd,..) via bpf-next,
so it goes through bpf CI and our other testing.

bpf patches don't seem to depend on newly added CLASS(fd_pos, ...
and fderr, so pretty much independent from other patches.

