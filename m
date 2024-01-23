Return-Path: <linux-fsdevel+bounces-8630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB254839D13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 00:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131F11F2A953
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 23:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE9E54673;
	Tue, 23 Jan 2024 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FU2yj83S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51855E5A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051578; cv=none; b=myPGXqyhS85F20TqQWHJUTZKvNVNNisuvuTCXBovfCXBFFnGhTRo0BMgI6U95xTf30EZgout2HWhwVats4cbub6IvoNA2rCdrMGfXGWjcGfoNBsUpgulHSI96ecFfBSanSz7F0PxkUx8IySP0guKkSNJjrXQ/iBgAR5s+HirMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051578; c=relaxed/simple;
	bh=IT1yX/5pSaASDPUefrl4cbROJ3hoQNolYaMjN53IYOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAM8cMVluudbjLeJMzHzxuEir88BUwhxkuqg8PPhfeNIK3vsQwmrEM9G9lBb/HK5ktmBflmiTQ0EAKkI/X0I2E9nRuQDBqbML7BrpuNdcfn0RmEYwXtd6WEjgUuJPsckqdCYjBqfZSLUu2NwS1jxDEwY1mxeReb/cunyjLOH3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FU2yj83S; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed179f0faso4485983276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706051575; x=1706656375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWIDmaprRDXC791QIR9l6bk++1KT2d3jHI2j8t0C6Rc=;
        b=FU2yj83SgzJkvZPVWsPw8wy6fBFYjDN3zdYt5n6x2nOP5goY/kiWTYl6qp+lbSmI/Z
         B0rBUAtrIj7MaEGSsMW4H5ar4F78opcQCxrPdFST3wmhC/rP3F8NWgGVLBchfcDskG+N
         s41m/PrGZtj9UnNHs86ROskpmQCq8cRZOYnuagMETLjNqur9ekNHtwubTKUXO2NLn1h3
         gz88CSBwPgpD0Aw9JklFDN1eekIiQ1VkjDD57nmZw7Z3UOZdcIasF2cob1hMqxSKrbO4
         LO2vaILlgrc7fW+VOm4ybx+uc6ZH6Ki8kvMfDTlj61ah6popx5yzkrpjrgzOLeUHEetS
         RXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051575; x=1706656375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWIDmaprRDXC791QIR9l6bk++1KT2d3jHI2j8t0C6Rc=;
        b=J0KICpEuFoQQ1IC2JYGqVj2eMW27cbPZr8p7jiwO1cnrokPjYMlY8bRgO/PdsZunvn
         tgRHX0Jid/4aJv+3azOMWfbX8aQQPaTc0BrxF11fwo2ppJxgAP9y3xhyp8ijNZOU8AyF
         J61cEYRmL/d/zkAP50Xs7Ad6ZW+EHZ1vI1n9RWbuXZaK5pCB2R+TtXSW6FofU0LklX5f
         0SzfmLfxP6p+VX6fgLlSlmrbvAZHmWgCO/JHyi6H7aJGWfweCNETzpbNMUzUdU8y8iGV
         l9+A7gXhOa6QOWUudg+9ZtsEWzGOUVnBHia/zLchr6QuUik8HqvN0uahgzpSXfp6MYFN
         Sw5g==
X-Gm-Message-State: AOJu0YyDSYp4fcxocS1XP0C8lKEuMJqjyOHLFGHIqJoqjhB4i/3/1iRH
	CyRryKq+nifUV+GPNgXWumJ8rUiJVIdZwx7OdA9lP6FgIDqFcbhnB0Cu/SAAW+INp6VMzg9fo8e
	PuzyeBSU/aAAkmSvk1cKrIAULnOEuAx1GHBfj
X-Google-Smtp-Source: AGHT+IEOH964Zn3SaV2E3HbQp+INXxfDthex+muRsVBygWUg/Q34ZfkyYcFb5cy7eUhUJWQtKoj32YvR84V9Gy5W+3U=
X-Received: by 2002:a05:6902:50c:b0:dbd:2ae7:f363 with SMTP id
 x12-20020a056902050c00b00dbd2ae7f363mr253766ybs.4.1706051575076; Tue, 23 Jan
 2024 15:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122071324.2099712-3-surenb@google.com> <20240123053629.365673-1-sj@kernel.org>
 <CAJuCfpHpujSbPcR2_jNTBu6+DTXvLBUoi2PjkYNJyTp62xaP9w@mail.gmail.com>
In-Reply-To: <CAJuCfpHpujSbPcR2_jNTBu6+DTXvLBUoi2PjkYNJyTp62xaP9w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 23 Jan 2024 15:12:44 -0800
Message-ID: <CAJuCfpHgScS4tud7yLn24RGMMwTaM=G4THOCgBZKGEoYkNPvtg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/maps: read proc/pid/maps under RCU
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, dchinner@redhat.com, casey@schaufler-ca.com, 
	ben.wolsieffer@hefring.com, paulmck@kernel.org, david@redhat.com, 
	avagin@google.com, usama.anjum@collabora.com, peterx@redhat.com, 
	hughd@google.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	Liam.Howlett@oracle.com, yuzhao@google.com, axelrasmussen@google.com, 
	lstoakes@gmail.com, talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:07=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Jan 22, 2024 at 9:36=E2=80=AFPM SeongJae Park <sj@kernel.org> wro=
te:
> >
> > Hi Suren,
> >
> > On Sun, 21 Jan 2024 23:13:24 -0800 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > With maple_tree supporting vma tree traversal under RCU and per-vma l=
ocks
> > > making vma access RCU-safe, /proc/pid/maps can be read under RCU and
> > > without the need to read-lock mmap_lock. However vma content can chan=
ge
> > > from under us, therefore we make a copy of the vma and we pin pointer
> > > fields used when generating the output (currently only vm_file and
> > > anon_name). Afterwards we check for concurrent address space
> > > modifications, wait for them to end and retry. That last check is nee=
ded
> > > to avoid possibility of missing a vma during concurrent maple_tree
> > > node replacement, which might report a NULL when a vma is replaced
> > > with another one. While we take the mmap_lock for reading during such
> > > contention, we do that momentarily only to record new mm_wr_seq count=
er.
> > > This change is designed to reduce mmap_lock contention and prevent a
> > > process reading /proc/pid/maps files (often a low priority task, such=
 as
> > > monitoring/data collection services) from blocking address space upda=
tes.
> > >
> > > Note that this change has a userspace visible disadvantage: it allows=
 for
> > > sub-page data tearing as opposed to the previous mechanism where data
> > > tearing could happen only between pages of generated output data.
> > > Since current userspace considers data tearing between pages to be
> > > acceptable, we assume is will be able to handle sub-page data tearing
> > > as well.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  fs/proc/internal.h |   2 +
> > >  fs/proc/task_mmu.c | 114 ++++++++++++++++++++++++++++++++++++++++++-=
--
> > >  2 files changed, 109 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > > index a71ac5379584..e0247225bb68 100644
> > > --- a/fs/proc/internal.h
> > > +++ b/fs/proc/internal.h
> > > @@ -290,6 +290,8 @@ struct proc_maps_private {
> > >       struct task_struct *task;
> > >       struct mm_struct *mm;
> > >       struct vma_iterator iter;
> > > +     unsigned long mm_wr_seq;
> > > +     struct vm_area_struct vma_copy;
> > >  #ifdef CONFIG_NUMA
> > >       struct mempolicy *task_mempolicy;
> > >  #endif
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 3f78ebbb795f..3886d04afc01 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -126,11 +126,96 @@ static void release_task_mempolicy(struct proc_=
maps_private *priv)
> > >  }
> > >  #endif
> > >
> > > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private =
*priv,
> > > -                                             loff_t *ppos)
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +
> > > +static const struct seq_operations proc_pid_maps_op;
> > > +/*
> > > + * Take VMA snapshot and pin vm_file and anon_name as they are used =
by
> > > + * show_map_vma.
> > > + */
> > > +static int get_vma_snapshow(struct proc_maps_private *priv, struct v=
m_area_struct *vma)
> > >  {
> > > +     struct vm_area_struct *copy =3D &priv->vma_copy;
> > > +     int ret =3D -EAGAIN;
> > > +
> > > +     memcpy(copy, vma, sizeof(*vma));
> > > +     if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > > +             goto out;
> > > +
> > > +     if (copy->anon_name && !anon_vma_name_get_rcu(copy))
> > > +             goto put_file;
> >
> > From today updated mm-unstable which containing this patch, I'm getting=
 below
> > build error when CONFIG_ANON_VMA_NAME is not set.  Seems this patch nee=
ds to
> > handle the case?
>
> Hi SeongJae,
> Thanks for reporting! I'll post an updated version fixing this config.

Fix is posted at
https://lore.kernel.org/all/20240123231014.3801041-3-surenb@google.com/
as part of v2 of this patchset.
Thanks,
Suren.

> Suren.
>
>
> >
> >     .../linux/fs/proc/task_mmu.c: In function =E2=80=98get_vma_snapshow=
=E2=80=99:
> >     .../linux/fs/proc/task_mmu.c:145:19: error: =E2=80=98struct vm_area=
_struct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you m=
ean =E2=80=98anon_vma=E2=80=99?
> >       145 |         if (copy->anon_name && !anon_vma_name_get_rcu(copy)=
)
> >           |                   ^~~~~~~~~
> >           |                   anon_vma
> >     .../linux/fs/proc/task_mmu.c:161:19: error: =E2=80=98struct vm_area=
_struct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you m=
ean =E2=80=98anon_vma=E2=80=99?
> >       161 |         if (copy->anon_name)
> >           |                   ^~~~~~~~~
> >           |                   anon_vma
> >     .../linux/fs/proc/task_mmu.c:162:41: error: =E2=80=98struct vm_area=
_struct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you m=
ean =E2=80=98anon_vma=E2=80=99?
> >       162 |                 anon_vma_name_put(copy->anon_name);
> >           |                                         ^~~~~~~~~
> >           |                                         anon_vma
> >     .../linux/fs/proc/task_mmu.c: In function =E2=80=98put_vma_snapshot=
=E2=80=99:
> >     .../linux/fs/proc/task_mmu.c:174:18: error: =E2=80=98struct vm_area=
_struct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you m=
ean =E2=80=98anon_vma=E2=80=99?
> >       174 |         if (vma->anon_name)
> >           |                  ^~~~~~~~~
> >           |                  anon_vma
> >     .../linux/fs/proc/task_mmu.c:175:40: error: =E2=80=98struct vm_area=
_struct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you m=
ean =E2=80=98anon_vma=E2=80=99?
> >       175 |                 anon_vma_name_put(vma->anon_name);
> >           |                                        ^~~~~~~~~
> >           |                                        anon_vma
> >
> > [...]
> >
> >
> > Thanks,
> > SJ

