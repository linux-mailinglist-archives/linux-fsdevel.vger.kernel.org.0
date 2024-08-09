Return-Path: <linux-fsdevel+bounces-25496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1855B94C804
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 03:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399CA1C21751
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1241168B7;
	Fri,  9 Aug 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAsI2n3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483916419;
	Fri,  9 Aug 2024 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166597; cv=none; b=Y+SvtgpUCTnHf4vR4K4gJtJo9x/K8+dXjdEwwi8t02pJYoTNrgLFA7+3WA6p0zaPkvb4ZAP14Hfw/2xy/p/jOO3E0gI426/k6gIF2HuComL0VRcv9+qhOTBWQ+F09WfzEMGyVRcSQxjhqFVmljkrjTsfVfbXNP6nVZ2O3ATPGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166597; c=relaxed/simple;
	bh=QfAZBS4GejPe4aSNdqRUxycvxP0gcOc3pmsy8Yr2lCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVXwxuWrTRMqpTwyHrymZK+hqUH7eD8Hlo9lEW5lK9QYEh3xoAwVqkKyTQRLDOjsPdwRMFmaWWja1aBp3+6deUYWG6hKSOiScpLHYXieVFKRv1Rxyer68r8Y3l7OyE9WXSkSfUggcIjM8ChwV1ktbRWf3L520Fs27hAdTuynmpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAsI2n3w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428243f928fso15258965e9.0;
        Thu, 08 Aug 2024 18:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723166594; x=1723771394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3DjGbT2aLpp9iseww7zvuSC6N2dborSRxte3s5JRsY=;
        b=JAsI2n3wT/XJb2rWBJzVW0YNq5a6n0XpFDc7yYSbchGpf7dJkzMYcisopiAkZU8tT1
         J6TpROrCUYxGw0QgC27lozRLQd5a4uUp30917I1bGqh8ZFgxIynuFA44/M2zVh8a0GOA
         zY/uMU6NYxM0YmM1wKDuMGgz3dHviwNtitKjzyCV2mgS3AYv7Vvo87ZiP9KoHmBGW3Fy
         YP/6bUFF3TkwU1kod7sPHIPuMNlNRHTdnMMegJrCjhx7TMeUod2MEKL9u+IlDyChF2X7
         YUZsPhdYTX/RP+l27qI2dE3uklxUt5trl4mNu97IFIxPtQAsx3ojyT38mbdEQ4bipU2x
         IwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723166594; x=1723771394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3DjGbT2aLpp9iseww7zvuSC6N2dborSRxte3s5JRsY=;
        b=nmkNojXpbetKFCLU3HqHWPUYJ1g95ypDeXpP52YPitaGvdZ/YPc3Mop6YkigSMLEcv
         thq3LYU1JnanVoPb2zW6oJNirPdcY+/bK+2r/vn6zUSTDVVe5aBzKGjA6e9L+F0/pgcT
         rg8jNtiTFIByGDYaYPThB3JBJ/yV0PM5g7sBUuQb/mZj/5yy8vx7gkkZLQCNhSVAe0Ne
         WLglqhyM2gHAUVzgJ5izBwKoRIpNBVqaFGozKuPniSipv2MpCm08WEk1zLkjCxrKLCyW
         nHj0boDdwvhjCfGs7DdKV1bsRi22BajA29qCKE09K71JXpT7fBbjFM0d4LesHh7NDZTg
         lkbg==
X-Forwarded-Encrypted: i=1; AJvYcCU6EGAeHkFskCExQ78EIOgi7VSZub8hjlBsYWyJQvhpvc1E6E9I+Qt2xHL0cvovDhdyn3NfkHJ8DA==@vger.kernel.org, AJvYcCUGEiLbvHkrQb5ALZfbbQW9niAEBYFmQXMAecxVLrPn348xmXz4SgQsSwH6GLFwP0xbE1k=@vger.kernel.org, AJvYcCUl86teQckyjraV2CBm91+RBw08XEylCfpqIttYiXybC5nXT1ON4nQwC6JF8V3YYrMso82cs7JZ@vger.kernel.org, AJvYcCWUv4KTYXa1g+P4HhrdR0vZCK+uftA8RJx6iYGLkXvtLNcyl02fLLKrHXJSt92S6Yk3MyS3@vger.kernel.org, AJvYcCWoMqpPYtod5oJwr+YsQchM5qt2NSzQ6KFQ7d2onfnpTjvPxlyVo1YG7cNlSaGwhnfJrrCrZ7QmgSZbur9iqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyerTHP0jztCEeLfZLn2fGmKl8m4emXLFb6oxS3gimT52Op8yg2
	SdJFxr8/l2Fu0t7FRhR07Ljcrk3KijyeKTQkDypwzydzf/zIIP63DdYwnchtfy5H4LdrJU43JVi
	y4HnPIh2UNfN+gdOXlOanu5Rh080=
X-Google-Smtp-Source: AGHT+IEczA4JxzigX7BfBtlnZI47DVmwIhzMmfVxMqZ+wK1QS6ljlNJAF+x8rFbhe+4uOEqkzsD12yK42LIMLMWG98Q=
X-Received: by 2002:a05:600c:1c27:b0:428:e30:fa8d with SMTP id
 5b1f17b1804b1-4290aedf987mr30435955e9.6.1723166593361; Thu, 08 Aug 2024
 18:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org> <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
 <20240807-fehlschlag-entfiel-f03a6df0e735@brauner> <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
 <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com> <CAEf4Bzauw1tD4UsyhX1PmRs_Y1MzfPqsoRUf40cmNuu7SJKi9w@mail.gmail.com>
In-Reply-To: <CAEf4Bzauw1tD4UsyhX1PmRs_Y1MzfPqsoRUf40cmNuu7SJKi9w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Aug 2024 18:23:02 -0700
Message-ID: <CAADnVQ+55NKkEaAsjGh52=VsSgr9G-qvjBCPmaPrTxiN6eCZOw@mail.gmail.com>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@kernel.org, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, kvm@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 8, 2024 at 9:51=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 8:31=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 3:30=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > >
> > > > On Tue, Aug 06, 2024 at 03:32:20PM GMT, Andrii Nakryiko wrote:
> > > > > On Mon, Jul 29, 2024 at 10:20=E2=80=AFPM <viro@kernel.org> wrote:
> > > > > >
> > > > > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > > > >
> > > > > > Equivalent transformation.  For one thing, it's easier to follo=
w that way.
> > > > > > For another, that simplifies the control flow in the vicinity o=
f struct fd
> > > > > > handling in there, which will allow a switch to CLASS(fd) and m=
ake the
> > > > > > thing much easier to verify wrt leaks.
> > > > > >
> > > > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > > > ---
> > > > > >  kernel/bpf/verifier.c | 342 +++++++++++++++++++++-------------=
--------
> > > > > >  1 file changed, 172 insertions(+), 170 deletions(-)
> > > > > >
> > > > >
> > > > > This looks unnecessarily intrusive. I think it's best to extract =
the
> > > > > logic of fetching and adding bpf_map by fd into a helper and that=
 way
> > > > > contain fdget + fdput logic nicely. Something like below, which I=
 can
> > > > > send to bpf-next.
> > > > >
> > > > > commit b5eec08241cc0263e560551de91eda73ccc5987d
> > > > > Author: Andrii Nakryiko <andrii@kernel.org>
> > > > > Date:   Tue Aug 6 14:31:34 2024 -0700
> > > > >
> > > > >     bpf: factor out fetching bpf_map from FD and adding it to use=
d_maps list
> > > > >
> > > > >     Factor out the logic to extract bpf_map instances from FD emb=
edded in
> > > > >     bpf_insns, adding it to the list of used_maps (unless it's al=
ready
> > > > >     there, in which case we just reuse map's index). This simplif=
ies the
> > > > >     logic in resolve_pseudo_ldimm64(), especially around `struct =
fd`
> > > > >     handling, as all that is now neatly contained in the helper a=
nd doesn't
> > > > >     leak into a dozen error handling paths.
> > > > >
> > > > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index df3be12096cf..14e4ef687a59 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(st=
ruct
> > > > > bpf_map *map)
> > > > >          map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)=
;
> > > > >  }
> > > > >
> > > > > +/* Add map behind fd to used maps list, if it's not already ther=
e, and return
> > > > > + * its index. Also set *reused to true if this map was already i=
n the list of
> > > > > + * used maps.
> > > > > + * Returns <0 on error, or >=3D 0 index, on success.
> > > > > + */
> > > > > +static int add_used_map_from_fd(struct bpf_verifier_env *env, in=
t fd,
> > > > > bool *reused)
> > > > > +{
> > > > > +    struct fd f =3D fdget(fd);
> > > >
> > > > Use CLASS(fd, f)(fd) and you can avoid all that fdput() stuff.
> > >
> > > That was the point of Al's next patch in the series, so I didn't want
> > > to do it in this one that just refactored the logic of adding maps.
> > > But I can fold that in and send it to bpf-next.
> >
> > +1.
> >
> > The bpf changes look ok and Andrii's approach is easier to grasp.
> > It's better to route bpf conversion to CLASS(fd,..) via bpf-next,
> > so it goes through bpf CI and our other testing.
> >
> > bpf patches don't seem to depend on newly added CLASS(fd_pos, ...
> > and fderr, so pretty much independent from other patches.
>
> Ok, so CLASS(fd, f) won't work just yet because of peculiar
> __bpf_map_get() contract: if it gets valid struct fd but it doesn't
> contain a valid struct bpf_map, then __bpf_map_get() does fdput()
> internally. In all other cases the caller has to do fdput() and
> returned struct bpf_map's refcount has to be bumped by the caller
> (__bpf_map_get() doesn't do that, I guess that's why it's
> double-underscored).
>
> I think the reason it was done was just a convenience to not have to
> get/put bpf_map for temporary uses (and instead rely on file's
> reference keeping bpf_map alive), plus we have bpf_map_inc() and
> bpf_map_inc_uref() variants, so in some cases we need to bump just
> refcount, and in some both user and normal refcounts.
>
> So can't use CLASS(fd, ...) without some more clean up.
>
> Alexei, how about changing __bpf_map_get(struct fd f) to
> __bpf_map_get_from_fd(int ufd), doing fdget/fdput internally, and
> always returning bpf_map with (normal) refcount bumped (if successful,
> of course). We can then split bpf_map_inc_with_uref() into just
> bpf_map_inc() and bpf_map_inc_uref(), and callers will be able to do
> extra uref-only increment, if necessary.
>
> I can do that as a pre-patch, there are about 15 callers, so not too
> much work to clean this up. Let me know.

Yeah. Let's kill __bpf_map_get(struct fd ..) altogether.
This logic was added in 2014.
fdget() had to be first and fdput() last to make sure
the map won't disappear while sys_bpf command is running.
All of the places can use bpf_map_get(), bpf_map_put() pair
and rely on map->refcnt, but...

- it's atomic64_inc(&map->refcnt); The cost is probably
in the noise compared to all the work that map sys_bpf commands do.

- It also opens new fuzzing opportunity to do some map operation
in one thread and close(map_fd) in the other, so map->usercnt can
drop to zero and map_release_uref() cleanup can start while
the other thread is still busy doing something like map_update_elem().
It can be mitigated by doing bpf_map_get_with_uref(), but two
atomic64_inc() is kinda too much.

So let's remove __bpf_map_get() and replace all users with bpf_map_get(),
but we may need to revisit that later.

