Return-Path: <linux-fsdevel+bounces-29035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B2973C6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221CC28604A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B7A191476;
	Tue, 10 Sep 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkxX579T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5F1A08C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982801; cv=none; b=N5UbukRqjaOF19fIUMs2WHOHct4hWFn/8+s4LlP4dGm2JQzIs2P0b4/Q/0HUn/4dehfLsYqpZe7KXxUr/E1Fzz/egodX+98mahjd421VBbS++U1M9FPg7gbCwV7HfqYt48ovDHGAUjszPV9jbJBBBLXjfzlNztWukFGsLG/urx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982801; c=relaxed/simple;
	bh=Ns74kTojtvJ3PU+5k7XOrtvLmnYWyxeZra3a7dDi8iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6f2vzxONVj8s/d3t00MgB9SJUP6g4mciIFw8BP81W9qA7bo498rdrSrV/LaK/9UCzasszswXEnZlyzSyZl08REtL/bzURhtZSexGwhtSx+S7ZRttsGUpctIRxES+yKPgL6iH3Ms3Ao3BNrpajGwfF5QTMpcotypnhoB5DSvkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkxX579T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso22198a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725982796; x=1726587596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XmuAJaJABZEw22g1YelxW3d7dMoKbStEXHVKcdE10Q=;
        b=KkxX579TxaUCdpv3p/X3uPjIhH+CxHKAgcQIGs9HnpX0OOrMynUY8OtofIpDB5eUf0
         azEtEdzkTPYOxdFxS7om6lDUN2d5fa8UnQE62D8Qzwmyo7XeeLEWNL7OsDNMpov/si5P
         GcLFlkaBy143E0ZadbhJ4PNwx9TBRLldISeOvgYzeFozDNhctNN5X0HEPA7VzqRgNYft
         x3OBlWBbC4rP1JqdYu7wfcEXGI+G0lWPhDIUnClihkR2dDHKx9Ut8a+DHw493XzcnZly
         FlEPJbn5X66cJSevugWXVwdxr4s6g4bdcYd9iXP6PpzIq57wsGgyv8rv8YvlTtWkW9xa
         ekpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982796; x=1726587596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XmuAJaJABZEw22g1YelxW3d7dMoKbStEXHVKcdE10Q=;
        b=MuClNmJJN+f6ksrWWcCZpVb9Nzm+sbZ5R3tAQH/+vyQD1jwr4B7q/pReyJyYLT5H7l
         QAbgd8KHDWpBe3iK8PyMfbpfmoD7VNqWyPEgW1Zya6ZAREVsgt7Dzn3TAYL7JoqcdBbA
         X7Y1peL0Yj3T4MoCmo+6UWB0gzqAPOwARa6Z2h11Fult4gKUp6gKo89ZXzMPipk1UVh6
         W/hx5lLVEQI5s52s6tQNky1WcuS7UiRqnDDeMe4S4gpyyiXmUZsZKE2VxgVrMie11868
         qYwdMpqfX5lGOtrnNpabVUpl17Mq2ncULwowVUXIQXXlu52taDeGk8gpIujkvCiZX7eX
         MmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnA4eu2lNZttJDtOYuTVcuniiv5LMffmTwf3PxwD8UcvA0TSBBm8IL5pHcgq5R1cV7Z0ZrdEPH+/efybSi@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLSpBlOC+7wni+EuX8HqYd8Rn5V9Y7ZqMsCNmIv2TeuY+qRqC
	M6KrDGp6z6VuzJVUYvRwksMCNGXHmjl41o8+9xPiz3vhoi5Fm/MjO8Kt6K9SnMGi/PKUMQFtxXe
	qttGonj6IfiVUV9gwXixcWqdmKPGoB+i5Twm4
X-Google-Smtp-Source: AGHT+IHa5P3FNcyxK3dfRD8l0hNbFtul+gz/5r6bBqUtFkIT1a2ttnvtee4Q932fZkZ5xf7hLJPLJm4n3vKcBRhcD4g=
X-Received: by 2002:a05:6402:35d4:b0:5c3:c2fc:8de6 with SMTP id
 4fb4d7f45d1cf-5c4040d4f38mr311527a12.3.1725982795248; Tue, 10 Sep 2024
 08:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com> <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 17:39:19 +0200
Message-ID: <CAG48ez1d9tU7-QeRSjRuxovG-jjNAwJ8B_G2jd43_etYMUPV6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: surenb@google.com, Liam Howlett <liam.howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, brauner@kernel.org, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:29=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Sep 9, 2024 at 6:13=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > > +static struct uprobe *find_active_uprobe_speculative(unsigned long b=
p_vaddr)
> > > +{
> > > +       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSH=
ARE;
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       struct uprobe *uprobe;
> > > +       struct vm_area_struct *vma;
> > > +       struct file *vm_file;
> > > +       struct inode *vm_inode;
> > > +       unsigned long vm_pgoff, vm_start;
> > > +       int seq;
> > > +       loff_t offset;
> > > +
> > > +       if (!mmap_lock_speculation_start(mm, &seq))
> > > +               return NULL;
> > > +
> > > +       rcu_read_lock();
> > > +
> > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > +       if (!vma)
> > > +               goto bail;
> > > +
> > > +       vm_file =3D data_race(vma->vm_file);
> >
> > A plain "data_race()" says "I'm fine with this load tearing", but
> > you're relying on this load not tearing (since you access the vm_file
> > pointer below).
> > You're also relying on the "struct file" that vma->vm_file points to
> > being populated at this point, which means you need CONSUME semantics
> > here, which READ_ONCE() will give you, and something like RELEASE
> > semantics on any pairing store that populates vma->vm_file, which
> > means they'd all have to become something like smp_store_release()).
>
> vma->vm_file should be set in VMA before it is installed and is never
> modified afterwards, isn't that the case? So maybe no extra barrier
> are needed and READ_ONCE() would be enough.

Ah, right, I'm not sure what I was thinking there.

I... guess you only _really_ need the READ_ONCE() if something can
actually ever change the ->vm_file pointer, otherwise just a plain
load with no annotation whatsoever would be good enough? I'm fairly
sure nothing can ever change the ->vm_file pointer of a live VMA, and
I think _currently_ it looks like nothing will NULL out the ->vm_file
pointer on free either... though that last part is probably not
something you should rely on...

