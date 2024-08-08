Return-Path: <linux-fsdevel+bounces-25471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7D94C5C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9541C2235A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41401591F3;
	Thu,  8 Aug 2024 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsn9B0oC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D652F88;
	Thu,  8 Aug 2024 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149332; cv=none; b=ax9CTXRbbJiSWAwHJMWdkE097oPMMfaaQtl2zPI/ojIeBAmN8PNh64tgw7Xa90hKhU0gC8oYuVA+DV7WP0uhuLEvLFKxFnuDO6UWDT81qszLCrKznlstF0pp+iiouRGaxVKtqsTNwIKyDjQBOUt53hvRTUhfnFI5e+5mjNiezMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149332; c=relaxed/simple;
	bh=Z3cZHo0C5dOGdJs4XsVHj5/15eTWcTCsSV4t/f39zoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie11jfkxkNayKhQUGyNSKslbDq2ZnyX8fkUeqHtWhyO5DA8XZ5KKR3HZgnOYCUoQNeKf4dJ3S/AWkwus0goXLJ8ArRusSjkaxzu/e3a7MgEyoCwxsCiKuJRqqdylWM0x1qtzyqQ96eLLs6P3M8qb+PrfxOUJScmoY59IDAggaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsn9B0oC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so1704290a12.2;
        Thu, 08 Aug 2024 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723149329; x=1723754129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BckQp3equBHDw/iWdFm9ZpTvFrdGPYRY5a2tKkfZo0=;
        b=Vsn9B0oCUqBUHTVYVRgdKVGiJNqt7okkcANodbc8v/6+WkhW2mp8as0lfl9i0QYx19
         9izdxq+sMlQv2UKXUkJuNImP5tqoViZkG/F4wsg6cJbojHuwop2tWydEa//iZzpbckvj
         oln8RZe3eqwk76zrr7jSq0whvCmzYeB+KJhK4NeJhr76yh2IBx2DXLFxxV7s0dPMQGnm
         j0R2iVx8od5nxvuIdnaA2+FHxdfQYyLZlZQSY5JqrDaPQZZ/6USmDyvo3jy+6mxty5tr
         7iGMKePFmoBdorEsJG6itRsh1bjYjKAhRA7M+NmlOpQVVHKVqwEPNIKF/MD1fIbjVPQR
         HJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149329; x=1723754129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BckQp3equBHDw/iWdFm9ZpTvFrdGPYRY5a2tKkfZo0=;
        b=NqnUI7Q5VmwHxcPud0yz3IUncC4xp4i1nkKIj4D4nldGMa/L9xomUvZ2CH8KcjuHL6
         Px6Yln91wRZxlxL5WyzQcfgTKYfpi1XOZDsnqhymob3JlQ3+JXvtrWDYXaZDzkekJskD
         S9kLu8kuyoeqXrQ1UH2WQL5qcDXY2FXMTtrnbxEky8Ob6BulacWlVvZbWNMJGnkdK4OP
         m9gXM5j60dvZ+/AlKtnQNXHxwy/1t0ksXFOiWSfAtjc0n1psn0UMfKkajQTFGlN2bnrr
         z+UOPzqFcSLKZASDd/ISUBjRht4rtl/usXWJ1sIoZINIaZdxOrIuC+G/dhujB7opr0qv
         yrAg==
X-Forwarded-Encrypted: i=1; AJvYcCX0gzcMzL0frQuTASKwmRrpLhxMb3zH6KM84/MYc4wbTCMUoHlCpiU4bZoPGKWnSShYypyze/y9s5zL/9kSXSxanQyJNb+iLvwBJNbSfCTkfK8Qxcb0kCjGPP88Zqy/BrRzxFydhiYkvITUuB7nPK7YAmALQ3KAvyhW3GQ47aMpXcqNpgYN3w1L0NwzOTUunBXjhZwivNoRnwOAbxKDkzjryXF06U+3AwM=
X-Gm-Message-State: AOJu0YyRZqE3N/DqaYJu33LP9N8hGlRFdldLsNLQvFnUKBpSltNcj86i
	0pw0uFZHbRSMoU0b15JHfrWzOhpJmStV8HWSG7cw73uDUIumsirMeCliyWz36sytgxZKjvTihEe
	Na4BygOkrGMjDmPA4oPhpmGat5Pazyw==
X-Google-Smtp-Source: AGHT+IG4oe0p6bZ+T5aZ4llYKbhvvCigDfXVXTLyvXUGYJ3vy2BD0AdCsmhO+xVhCMcs3KROzGsFRQjEW1tbCe49jCg=
X-Received: by 2002:a17:907:f701:b0:a7d:c148:ec85 with SMTP id
 a640c23a62f3a-a8090f2dad8mr204887866b.62.1723149328292; Thu, 08 Aug 2024
 13:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org> <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
 <20240807-fehlschlag-entfiel-f03a6df0e735@brauner> <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
 <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com>
In-Reply-To: <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 13:35:13 -0700
Message-ID: <CAEf4Bzauw1tD4UsyhX1PmRs_Y1MzfPqsoRUf40cmNuu7SJKi9w@mail.gmail.com>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@kernel.org, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, kvm@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:51=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 7, 2024 at 8:31=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 3:30=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Tue, Aug 06, 2024 at 03:32:20PM GMT, Andrii Nakryiko wrote:
> > > > On Mon, Jul 29, 2024 at 10:20=E2=80=AFPM <viro@kernel.org> wrote:
> > > > >
> > > > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > > >
> > > > > Equivalent transformation.  For one thing, it's easier to follow =
that way.
> > > > > For another, that simplifies the control flow in the vicinity of =
struct fd
> > > > > handling in there, which will allow a switch to CLASS(fd) and mak=
e the
> > > > > thing much easier to verify wrt leaks.
> > > > >
> > > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > > ---
> > > > >  kernel/bpf/verifier.c | 342 +++++++++++++++++++++---------------=
------
> > > > >  1 file changed, 172 insertions(+), 170 deletions(-)
> > > > >
> > > >
> > > > This looks unnecessarily intrusive. I think it's best to extract th=
e
> > > > logic of fetching and adding bpf_map by fd into a helper and that w=
ay
> > > > contain fdget + fdput logic nicely. Something like below, which I c=
an
> > > > send to bpf-next.
> > > >
> > > > commit b5eec08241cc0263e560551de91eda73ccc5987d
> > > > Author: Andrii Nakryiko <andrii@kernel.org>
> > > > Date:   Tue Aug 6 14:31:34 2024 -0700
> > > >
> > > >     bpf: factor out fetching bpf_map from FD and adding it to used_=
maps list
> > > >
> > > >     Factor out the logic to extract bpf_map instances from FD embed=
ded in
> > > >     bpf_insns, adding it to the list of used_maps (unless it's alre=
ady
> > > >     there, in which case we just reuse map's index). This simplifie=
s the
> > > >     logic in resolve_pseudo_ldimm64(), especially around `struct fd=
`
> > > >     handling, as all that is now neatly contained in the helper and=
 doesn't
> > > >     leak into a dozen error handling paths.
> > > >
> > > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index df3be12096cf..14e4ef687a59 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(stru=
ct
> > > > bpf_map *map)
> > > >          map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> > > >  }
> > > >
> > > > +/* Add map behind fd to used maps list, if it's not already there,=
 and return
> > > > + * its index. Also set *reused to true if this map was already in =
the list of
> > > > + * used maps.
> > > > + * Returns <0 on error, or >=3D 0 index, on success.
> > > > + */
> > > > +static int add_used_map_from_fd(struct bpf_verifier_env *env, int =
fd,
> > > > bool *reused)
> > > > +{
> > > > +    struct fd f =3D fdget(fd);
> > >
> > > Use CLASS(fd, f)(fd) and you can avoid all that fdput() stuff.
> >
> > That was the point of Al's next patch in the series, so I didn't want
> > to do it in this one that just refactored the logic of adding maps.
> > But I can fold that in and send it to bpf-next.
>
> +1.
>
> The bpf changes look ok and Andrii's approach is easier to grasp.
> It's better to route bpf conversion to CLASS(fd,..) via bpf-next,
> so it goes through bpf CI and our other testing.
>
> bpf patches don't seem to depend on newly added CLASS(fd_pos, ...
> and fderr, so pretty much independent from other patches.

Ok, so CLASS(fd, f) won't work just yet because of peculiar
__bpf_map_get() contract: if it gets valid struct fd but it doesn't
contain a valid struct bpf_map, then __bpf_map_get() does fdput()
internally. In all other cases the caller has to do fdput() and
returned struct bpf_map's refcount has to be bumped by the caller
(__bpf_map_get() doesn't do that, I guess that's why it's
double-underscored).

I think the reason it was done was just a convenience to not have to
get/put bpf_map for temporary uses (and instead rely on file's
reference keeping bpf_map alive), plus we have bpf_map_inc() and
bpf_map_inc_uref() variants, so in some cases we need to bump just
refcount, and in some both user and normal refcounts.

So can't use CLASS(fd, ...) without some more clean up.

Alexei, how about changing __bpf_map_get(struct fd f) to
__bpf_map_get_from_fd(int ufd), doing fdget/fdput internally, and
always returning bpf_map with (normal) refcount bumped (if successful,
of course). We can then split bpf_map_inc_with_uref() into just
bpf_map_inc() and bpf_map_inc_uref(), and callers will be able to do
extra uref-only increment, if necessary.

I can do that as a pre-patch, there are about 15 callers, so not too
much work to clean this up. Let me know.

