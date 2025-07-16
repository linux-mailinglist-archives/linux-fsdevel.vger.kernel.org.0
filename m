Return-Path: <linux-fsdevel+bounces-55071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71145B06B50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 03:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AC34A5B18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D7B2E36F9;
	Wed, 16 Jul 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs2/xm5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966A26E179
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630635; cv=none; b=WrDk9EHtTHjHQ88RWTY8Wax+t+rOD2twO9l4fkBWfTQQzH/hHL/hTs4wv0Q7PGiTuiraItBujxk7O0Lq1h6iovALJZWPr0/dfaYjaGKGknnGsjd/SamkMiskbfQOwDrEXp/6DGcBe65y68WhL967zlLiir+ea49TrDrGdAYHNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630635; c=relaxed/simple;
	bh=ulR2r4497/Knb1dtpDQYAGcd1xmbs3Ul1QUB5HiAxTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMZYLnsewPAJ5kAwM54SLE12iSJBTgVS+hIjir6ikqv7QMkSbhmKwKyeHoKU7ip2Hu1blalJTverJF5UAmbvQOM0bnxEsGrnBiEPGpxVdxBfs2g4S2yaTgWkT0GEpepon5jwmEoM3FfXKXAnh8TV+zzQXSs1fBhaWbfx6EuBePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fs2/xm5T; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab86a29c98so246561cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752630633; x=1753235433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI+BpmLhrBZFyCshwZnktNusgYyVbEvS1xUVnNwBsk0=;
        b=fs2/xm5TN2QMZsm6Pg6eQefSs+ddRsmyoDXrOiRisD/bREIA51q/EYyUzsaQEx/BpH
         FgjyUAeTl9s05lTEtTpBMdVuBcWuVQYLe8EDMiXdNqJa0kK6SBTUqbXmxkSJ09rChCn1
         n3pf93/4b6abSbrZNvhmpISWnYW1sxQ8igizLXXd1B4lfJ7NMWGSL/ryhKIZN8w6KEAW
         6xKvcUD18gcCBBAUvBa3VRfCZWdXtgxZQAMlX6XKHmrZwvII8d5Pxn/4ob9jk/4ZJ5K6
         /IAetKg/1jupdtdYqxzFBw98+gtFphftJCZYATtM0PjMsKDa0KwBGfNJV8MJe8XE4Vby
         2UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752630633; x=1753235433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI+BpmLhrBZFyCshwZnktNusgYyVbEvS1xUVnNwBsk0=;
        b=mWi/mdaD6U6oY7WvSdOuXSTtrGA0Syo17xoTgwX7i+zl509bH2kwSJQiJjNb3WtCus
         NP0P1DUzv/a6401RbhVRHZvDL840OSNTK/+rtbi2prvq2jEW72PLj5ep2pXadsmNlRWX
         mDY4+Sl8O0M11+LAjX2l0/Da5RcfxCCPzwW0aLDOnmZMO1ovkx7UAwrnR+Vpu00UlwJx
         bbq1loybxhfLjUpyLeIPaZaFtz7dpuroqHUJ1WpTahx60dQd5LzcpojulCvXRfgrS+vT
         tPRRAhonJPtppqTxDoXsjKxyalQ/80wqILxLAaR89LRpmP/sTUwi6jijpGswp/Xl8P61
         H4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOz/MeyuA6cfzpCHiCuOQK9nyu3J13XNB0pv8aiMFEQkRfkzGyU18YX3M2NbA7wLTJPHt30o1Qb111WquN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9df/kpGOGFXE7KlgdNAJ63x0skDLliEJ1zURSt32KYuO9YsWH
	P7iE1AVp5ERUJIh52R76upABJiuOdqtMyA2DW1UEcQAvjUrdzzVXS9ezUVlXjtTVMDS19hEYvVr
	Kk/I26IoXXpBieErzjhJOqzl2RcqDH+aZmjZEEwGt
X-Gm-Gg: ASbGncv+/zeXQMuO1t6EKxeNhmI2sbMulB1GJLIVMPzgAttawD5xZlqYEobQ9JsVJSp
	bfivlS6r1gYEuwMM6a+/dSGfYHrRWJ1xtcHwLlfRY5rxDMZc4vG9gc4UoglVNS+pZgpH/F0B7Mb
	HsiJSTlROkvcBydDnlky0/J08fvCzNuzBt0g4twBeXlhpCnE6nq4fQvgv9bCpiRqjTm8XiNB7U/
	HGMnlGoTKy5rVAU/RpC3kaE47UidXnb3Y4q
X-Google-Smtp-Source: AGHT+IE6S/geSCvAIOHME6wPTf87Pj245hn8wrq94Y+u/3lJJQqVVGTcUSg58tpAQ1CgaWAS+29p2Kj+iGhdGbbkHEY=
X-Received: by 2002:a05:622a:8d01:b0:4a9:95a6:3a69 with SMTP id
 d75a77b69052e-4ab953ab2b0mr763871cf.8.1752630632631; Tue, 15 Jul 2025
 18:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz> <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com> <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
 <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local> <CAEf4BzaEouFx8EuZF_PUKdc5wsq-5FYNyAE19VRxV7_YJkrfww@mail.gmail.com>
 <7568edfa-6992-452d-9eb2-2497221cb22a@lucifer.local> <7d878566-f445-4fc2-9d04-eb8b38024c9b@lucifer.local>
 <CAEf4BzYDktFt9R78tQifMrJ7okzA+1LhhiqCi+SpSdq3h4zKyw@mail.gmail.com> <CAJuCfpFx1vcv-a5Eez3AhoCUM2+jM6Sh0s9ms8FCWqZ8tFkTQg@mail.gmail.com>
In-Reply-To: <CAJuCfpFx1vcv-a5Eez3AhoCUM2+jM6Sh0s9ms8FCWqZ8tFkTQg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Jul 2025 18:50:21 -0700
X-Gm-Features: Ac12FXyGHcEwj0dROFdwa9pljKXvmZP0XFWCivJTUTBRwHJhx-DGskIWSfL3dJQ
Message-ID: <CAJuCfpEvH4vHXQ5YRWRdiFVXwyAcpcXEncOAWd1Zp4LahrxT_g@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:18=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Jul 15, 2025 at 10:29=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 10:21=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, Jul 15, 2025 at 06:10:16PM +0100, Lorenzo Stoakes wrote:
> > > > > For PROCMAP_QUERY, we need priv->mm, but the newly added locked_v=
ma
> > > > > and locked_vma don't need to be persisted between ioctl calls. So=
 we
> > > > > can just add those two fields into a small struct, and for seq_fi=
le
> > > > > case have it in priv, but for PROCMAP_QUERY just have it on the s=
tack.
> > > > > The code can be written to accept this struct to maintain the sta=
te,
> > > > > which for PROCMAP_QUERY ioctl will be very short-lived on the sta=
ck
> > > > > one.
> > > > >
> > > > > Would that work?
> > > >
> > > > Yeah that's a great idea actually, the stack would obviously give u=
s the
> > > > per-query invocation thing. Nice!
> > > >
> > > > I am kicking myself because I jokingly suggested (off-list) that a =
helper
> > > > struct would be the answer to everything (I do love them) and of
> > > > course... here we are :P
> > >
> > > Hm but actually we'd have to invert things I think, what I mean is - =
since
> > > these fields can be updated at any time by racing threads, we can't h=
ave
> > > _anything_ in the priv struct that is mutable.
> > >
> >
> > Exactly, and I guess I was just being incomplete with just listing two
> > of the fields that Suren make use of in PROCMAP_QUERY. See below.
> >
> > > So instead we should do something like:
> > >
> > > struct proc_maps_state {
> > >         const struct proc_maps_private *priv;
> > >         bool mmap_locked;
> > >         struct vm_area_struct *locked_vma;
> > >         struct vma_iterator iter;
> > >         loff_t last_pos;
> > > };
> > >
> > > static long procfs_procmap_ioctl(struct file *file, unsigned int cmd,=
 unsigned long arg)
> > > {
> > >         struct seq_file *seq =3D file->private_data;
> > >         struct proc_maps_private *priv =3D seq->private;
> > >         struct proc_maps_state state =3D {
> > >                 .priv =3D priv,
> > >         };
> > >
> > >         switch (cmd) {
> > >         case PROCMAP_QUERY:
> > >                 return do_procmap_query(state, (void __user *)arg);
> >
> > I guess it's a matter of preference, but I'd actually just pass
> > seq->priv->mm and arg into do_procmap_query(), which will make it
> > super obvious that priv is not used or mutated, and all the new stuff
> > that Suren needs for lockless VMA iteration, including iter (not sure
> > PROCMAP_QUERY needs last_pos, tbh), I'd just put into this new struct,
> > which do_procmap_query() can keep private to itself.
> >
> > Ultimately, I think we are on the same page, it's just a matter of
> > structuring code and types.
>
> That sounds cleaner to me too.
> I'll post a new version of my patchset today without the last patch to
> keep PROCMAP_QUERY changes separate, and then a follow-up patch that
> does this refactoring and changes PROCMAP_QUERY to use per-vma locks.
>
> Thanks folks! It's good to be back from vacation with the problem
> already figured out for you :)

Yes, Vlastimil was correct. Once I refactored the last patch so that
do_procmap_query() does not use seq->private at all, the reproducer
stopped failing.
I'll post the patchset without the last patch shortly and once Andrew
takes it into mm-unstable, will post the last patch as a follow-up.
Thanks,
Suren.

>
> >
> > >         default:
> > >                 return -ENOIOCTLCMD;
> > >         }
> > > }
> > >
> > > And then we have a stack-based thing with the bits that change and a
> > > read-only pointer to the bits that must remain static. And we can enf=
orce
> > > that with const...
> > >
> > > We'd have to move the VMI and last_pos out too to make it const.
> > >
> > > Anyway the general idea should work!

