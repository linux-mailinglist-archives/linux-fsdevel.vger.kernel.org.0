Return-Path: <linux-fsdevel+bounces-25552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9547A94D55A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210E3B20E35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF361FFE;
	Fri,  9 Aug 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv1qewTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53E61FD8;
	Fri,  9 Aug 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224203; cv=none; b=MHICQOYM1b4DfuooSHq1goofCAN8COneY1KSJVj0Bz7RkcacnKP39mTKbHs5XSa0pGpWPNOTfJe4km7e/i6C1WLvVXzofNnbz6G9sSpIYso+9HWhD7SlmdfQFwr9LkeMV7eSiyM/T1e+JH2rpTTKwt0LC1KEfM30xRfw7Ea6V30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224203; c=relaxed/simple;
	bh=0PZo/Ac9ke36wG6AVSpgHrTHheHjhZfH3xagdecugsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUbSD+VKgP+yUXR7dlLEJLG7mR3Pl94IbcnEUFIlUlb0f3AUCDUgOebntton7J2kpzo1EQRMWGdwScbMbEoRhkFABF9edn63FWK/tHONIbo0YpgIvFzYB7muccOdcve7AYq8+PKdYNHL0w1Og6KBfLHOqueMDUGuUWSiQ9Qzm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv1qewTm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2caff99b1c9so1927374a91.3;
        Fri, 09 Aug 2024 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723224200; x=1723829000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4nf2vVsE4rNUghEnE6rx77U4NSKcuKPAo9x1pxrGbo=;
        b=jv1qewTmpmPgxMvEDzSH1CBdK07PWwrGOxnzORqGIigBvrarMwPkMevUO1mWizxphm
         TA4jVXmE0tyVrgFP4xEMUPg5c8gJgRq61aY1ttVffFZGsWZeCO5oM1rlzwdGUmlbLyLz
         OVp73wgIy7Odh2UfLpwUSefi5Kek3Ic4nxo6BsXQyRSNC7xlMg0tYJHZ1fIWrEg8QHrv
         aR0TbQxZEQu1xC7sJYQ28HtRI0EMf4UBMvcpHfM0P6SNQjmtK1iytNGU1ISh/damRgVC
         /62/HrzyiH/d2cN6PM/+XyT9tLZFxSPAa9RbNGTf/SBN9vt7m9S4g+XTXP/lQSOtrVG+
         uYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224200; x=1723829000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4nf2vVsE4rNUghEnE6rx77U4NSKcuKPAo9x1pxrGbo=;
        b=TRvaFUe3P5edMVQ1MvEknu6qPvIUcKkUSaKxB/8vQhxvdQ1syPwIuU7ZAlkYbmF4DI
         9bkFY3VI0/pi5irNJA3R59uoQavxmIWEMkElrEOUbVoaBfsITizh4KtHzpKjM/VIn3wC
         vYj4dQ+awPiK5nJwaVxo/CNupHzSUGeO6uaVxBkGtg8g/3PdUR0b7t0Z68tTtEkame+/
         5pLkIG7DQLtAeLC0CyvoG6hGQeNusy2OMsrm8BRUuB3XjF9DGcLbKyD+dRM+eB9qPRAs
         M97uDGSMHNYM1+6ltFDaxLQnpkSLyAIYUFC9uzhCajVYATouuz8IA7nEIN8712ZUGLWU
         p3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCV70eiijf6W1sjI6/MFVhzOo4sv3o39eR0l80TdpyW0Axsa1M+yvTBToi6xMBFRI1RGuchbQp4/YOvDOXvQZ7/9eYtI0wm4wx6eyiaALKTWCRrSi3iRJ7F94Yu2o2QOGCyLQoBzkYUZJabGyW/uYlDy8TZ2JFihWG+oeBgadDF7WzZTP0+QfuYqjT/K9ze2KtMVHTD3dJspsQFxnFbw8+rFxPLOr3kyvho=
X-Gm-Message-State: AOJu0Yx9TQ6zOypQ488WpjEkJKe9ugMU3eJfx1DRi9f+X+NvVi8HLyTR
	hzabhWEjfY88FcZo4sRCsRDRxNDqJ8PcPOcm7lo2bKiydYpjrPZZtsT5GHp7QaWTjs6+xtfIeCC
	dH+/aB0g7iOY9TKPSXXMxaWRjvPl9Fw==
X-Google-Smtp-Source: AGHT+IEpnb6/gaAmxrz4Xp5pn0+3G4YQxfp9iu1mxL9WijR0M987FyzWp5uOkoCxw99MaeryCykCUqfcrz831oW7wsA=
X-Received: by 2002:a17:90a:b113:b0:2cd:b915:c80b with SMTP id
 98e67ed59e1d1-2d1e8082b97mr2434499a91.27.1723224200505; Fri, 09 Aug 2024
 10:23:20 -0700 (PDT)
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
 <CAEf4Bzauw1tD4UsyhX1PmRs_Y1MzfPqsoRUf40cmNuu7SJKi9w@mail.gmail.com> <CAADnVQ+55NKkEaAsjGh52=VsSgr9G-qvjBCPmaPrTxiN6eCZOw@mail.gmail.com>
In-Reply-To: <CAADnVQ+55NKkEaAsjGh52=VsSgr9G-qvjBCPmaPrTxiN6eCZOw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 10:23:08 -0700
Message-ID: <CAEf4BzYLQhO_UwaQLfpwoiQMvb0-wLQM6Yr7v-5CYLvoa8qzkA@mail.gmail.com>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@kernel.org, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, kvm@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:23=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 8, 2024 at 1:35=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Aug 8, 2024 at 9:51=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 8:31=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Aug 7, 2024 at 3:30=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:
> > > > >
> > > > > On Tue, Aug 06, 2024 at 03:32:20PM GMT, Andrii Nakryiko wrote:
> > > > > > On Mon, Jul 29, 2024 at 10:20=E2=80=AFPM <viro@kernel.org> wrot=
e:
> > > > > > >
> > > > > > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > > > > >
> > > > > > > Equivalent transformation.  For one thing, it's easier to fol=
low that way.
> > > > > > > For another, that simplifies the control flow in the vicinity=
 of struct fd
> > > > > > > handling in there, which will allow a switch to CLASS(fd) and=
 make the
> > > > > > > thing much easier to verify wrt leaks.
> > > > > > >
> > > > > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > > > > ---
> > > > > > >  kernel/bpf/verifier.c | 342 +++++++++++++++++++++-----------=
----------
> > > > > > >  1 file changed, 172 insertions(+), 170 deletions(-)
> > > > > > >
> > > > > >
> > > > > > This looks unnecessarily intrusive. I think it's best to extrac=
t the
> > > > > > logic of fetching and adding bpf_map by fd into a helper and th=
at way
> > > > > > contain fdget + fdput logic nicely. Something like below, which=
 I can
> > > > > > send to bpf-next.
> > > > > >
> > > > > > commit b5eec08241cc0263e560551de91eda73ccc5987d
> > > > > > Author: Andrii Nakryiko <andrii@kernel.org>
> > > > > > Date:   Tue Aug 6 14:31:34 2024 -0700
> > > > > >
> > > > > >     bpf: factor out fetching bpf_map from FD and adding it to u=
sed_maps list
> > > > > >
> > > > > >     Factor out the logic to extract bpf_map instances from FD e=
mbedded in
> > > > > >     bpf_insns, adding it to the list of used_maps (unless it's =
already
> > > > > >     there, in which case we just reuse map's index). This simpl=
ifies the
> > > > > >     logic in resolve_pseudo_ldimm64(), especially around `struc=
t fd`
> > > > > >     handling, as all that is now neatly contained in the helper=
 and doesn't
> > > > > >     leak into a dozen error handling paths.
> > > > > >
> > > > > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > >
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index df3be12096cf..14e4ef687a59 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(=
struct
> > > > > > bpf_map *map)
> > > > > >          map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAG=
E);
> > > > > >  }
> > > > > >
> > > > > > +/* Add map behind fd to used maps list, if it's not already th=
ere, and return
> > > > > > + * its index. Also set *reused to true if this map was already=
 in the list of
> > > > > > + * used maps.
> > > > > > + * Returns <0 on error, or >=3D 0 index, on success.
> > > > > > + */
> > > > > > +static int add_used_map_from_fd(struct bpf_verifier_env *env, =
int fd,
> > > > > > bool *reused)
> > > > > > +{
> > > > > > +    struct fd f =3D fdget(fd);
> > > > >
> > > > > Use CLASS(fd, f)(fd) and you can avoid all that fdput() stuff.
> > > >
> > > > That was the point of Al's next patch in the series, so I didn't wa=
nt
> > > > to do it in this one that just refactored the logic of adding maps.
> > > > But I can fold that in and send it to bpf-next.
> > >
> > > +1.
> > >
> > > The bpf changes look ok and Andrii's approach is easier to grasp.
> > > It's better to route bpf conversion to CLASS(fd,..) via bpf-next,
> > > so it goes through bpf CI and our other testing.
> > >
> > > bpf patches don't seem to depend on newly added CLASS(fd_pos, ...
> > > and fderr, so pretty much independent from other patches.
> >
> > Ok, so CLASS(fd, f) won't work just yet because of peculiar
> > __bpf_map_get() contract: if it gets valid struct fd but it doesn't
> > contain a valid struct bpf_map, then __bpf_map_get() does fdput()
> > internally. In all other cases the caller has to do fdput() and
> > returned struct bpf_map's refcount has to be bumped by the caller
> > (__bpf_map_get() doesn't do that, I guess that's why it's
> > double-underscored).
> >
> > I think the reason it was done was just a convenience to not have to
> > get/put bpf_map for temporary uses (and instead rely on file's
> > reference keeping bpf_map alive), plus we have bpf_map_inc() and
> > bpf_map_inc_uref() variants, so in some cases we need to bump just
> > refcount, and in some both user and normal refcounts.
> >
> > So can't use CLASS(fd, ...) without some more clean up.
> >
> > Alexei, how about changing __bpf_map_get(struct fd f) to
> > __bpf_map_get_from_fd(int ufd), doing fdget/fdput internally, and
> > always returning bpf_map with (normal) refcount bumped (if successful,
> > of course). We can then split bpf_map_inc_with_uref() into just
> > bpf_map_inc() and bpf_map_inc_uref(), and callers will be able to do
> > extra uref-only increment, if necessary.
> >
> > I can do that as a pre-patch, there are about 15 callers, so not too
> > much work to clean this up. Let me know.
>
> Yeah. Let's kill __bpf_map_get(struct fd ..) altogether.
> This logic was added in 2014.
> fdget() had to be first and fdput() last to make sure
> the map won't disappear while sys_bpf command is running.
> All of the places can use bpf_map_get(), bpf_map_put() pair
> and rely on map->refcnt, but...
>
> - it's atomic64_inc(&map->refcnt); The cost is probably
> in the noise compared to all the work that map sys_bpf commands do.
>

agreed, not too worried about this

> - It also opens new fuzzing opportunity to do some map operation
> in one thread and close(map_fd) in the other, so map->usercnt can
> drop to zero and map_release_uref() cleanup can start while
> the other thread is still busy doing something like map_update_elem().
> It can be mitigated by doing bpf_map_get_with_uref(), but two
> atomic64_inc() is kinda too much.
>

yep, with_uref() is an overkill for most cases. I'd rather fix any
such bugs, if we have them.

> So let's remove __bpf_map_get() and replace all users with bpf_map_get(),
> but we may need to revisit that later.

Ok, I will probably send something next week.

