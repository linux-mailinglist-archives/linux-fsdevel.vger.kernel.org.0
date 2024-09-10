Return-Path: <linux-fsdevel+bounces-29058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46972974462
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 22:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634A61C25028
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 20:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95F1AAE27;
	Tue, 10 Sep 2024 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsQy+O5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9A183CA0;
	Tue, 10 Sep 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001835; cv=none; b=aOuA6enzywln6bxg0IAjoDo20rp4YBVMIjqBK/bjM548yyfPlmcuvVgFbynIxAfVq9Y+W+RjTjebu9zPxvdVoDMyYUb+fN7CWX0SZv4sppSukzPEdxN0ygV+TO1rr7kwiOaAeZR8371pLnHi+eFFIlDuWb94eADSQ2bAazfZcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001835; c=relaxed/simple;
	bh=faM/BMQ2vimssAaLBqKtdnKV6Toowm0WUHQfbpSXJgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnRucqSMU3jhG5+wnd2spcN6yc8+69S3hbSqARwKuCZO4aCv1cwLy8R/flUl1PW5jcwswmujXUBG0YL3CtunMfRovIiAhRqApJ0vSYIy0fE11OPfw1hql8r6JdFQk5UAfnlr8uAie9jbxUzAgE5asN6iIIrkNS0Xkdknzr1ns0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsQy+O5h; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so4383834a91.2;
        Tue, 10 Sep 2024 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726001834; x=1726606634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0na4dQJa2L1cmen5wGJM2Op9qiKCCHHFdeDVlG5p8P0=;
        b=EsQy+O5hJ9ED6TRAYqTMbd5pP0isz0hG13Qufrk4QtoFM1yXFEI9Nyz8HAf4x8+k9z
         BebAWxHsheuH/R7bksLwVqjEqCfenChI0uFSjiNp8z17gGdPQTEYxnQdP+dBaFIC6vQS
         +KvP6TPBXDIgTcxTV7KfyJErD3OdVFj5jVT+6rC3wnh5FOfQzBwVTHVUD9mKEv+xrREJ
         qU3DlAzt6EW8QdGp4DogCd1fFKq/LIcJt7MDYPuu1DYUHiwtKIbbDo3xw13H/TWwa9yy
         utgbusWpNe0pmw0wJEff8J44vaFTh0wSBv89brE3/rdxY/pRe6PhsSMpr/q9pHBU8o6v
         f+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726001834; x=1726606634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0na4dQJa2L1cmen5wGJM2Op9qiKCCHHFdeDVlG5p8P0=;
        b=UkcKLGKjulyqjOMm++/js4Lt5uma9Ztg41gvjSx0DLC8MxJsFeHz/Hz2fpgLhNU9nk
         t0EePX+rqKQyVhaVU07Fy6ZX6WAt+NsQU2fohVpw4Y4eVd7oMCPWV+Ec3LTOjjb17/5B
         lAq/PIgK/U5M0vobnvtm5DhaeLqYlPSLewv1inYqXj1m/TGH6LNk5Pm5uj/Tsx9Tfdrb
         c6znMTY/wPuSBjP4DdahSeLec6PNE/BfBhRk1RsqvmQHNkAGt08saeZP+D1nUZSoqu0C
         Ql+kDxVwUhiwJoCd7YGInA1RTRmxSlbXg7n4txr8TFpQgt1WEf1UOO7lc6K5bAqxn58X
         SqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCURpI0BE+V8Kp7SPZz2IdBsoCgPyEfzO3oJ4vx0yeS4OxzQhZyg3m4Dy4kgSBVUVD4O5b3SfQHOh4cfJnDhyFt5aOV1@vger.kernel.org, AJvYcCWRa4vaR9RbRdIJOtD0/wF5uSpX9/hOy/uHhvjib3AwfgnNEyO2nGQRe9DYY1y9j9KqWDinMFqOIrpsPgFt@vger.kernel.org, AJvYcCX9Mo19U91t1/x6XlisnaPppUpAVqq/Pyyb560svgB7yqlKGBrSg/ydh1gZxb7hYOPxbHKVnB2+MfzYxmNBHA==@vger.kernel.org, AJvYcCXpA7/gkcbsEpmY2XU3s75C7zj+//Fz8Kfg/TS/EVwAr+B1+pxc7J9w2PCKdK+ZYeWfC04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6SqN5E/zS+XwwiqEVZYap4UW/Bagb0RIC9QX3O4w2gDonPKD
	wwCWpdL6Lg9ocGkWnD3a292rdnTs3czDV6fpxDW1oE2tt1l7zKi53dk5aKXEzWh6GyW7dtFTk92
	Estkhx/lyEvRG0nDgmagqwZE6TBE=
X-Google-Smtp-Source: AGHT+IFIKU8LRNjthnXGWB53ZSi2GAcwL6hTYP36TFmTzguRaNKaVZk5srgulC0aAUobh2XIR0/+fYvfyHAf+lqZzfo=
X-Received: by 2002:a17:90a:ce81:b0:2c9:1012:b323 with SMTP id
 98e67ed59e1d1-2dad50cbcf7mr19247342a91.27.1726001833546; Tue, 10 Sep 2024
 13:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com>
 <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com> <CAG48ez1d9tU7-QeRSjRuxovG-jjNAwJ8B_G2jd43_etYMUPV6g@mail.gmail.com>
In-Reply-To: <CAG48ez1d9tU7-QeRSjRuxovG-jjNAwJ8B_G2jd43_etYMUPV6g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 13:56:59 -0700
Message-ID: <CAEf4Bzb60-PjWXK3apuvxsJh70iXpoBo0WR2R4iXYsXwEChnsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Jann Horn <jannh@google.com>
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

On Tue, Sep 10, 2024 at 8:39=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Sep 9, 2024 at 11:29=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Mon, Sep 9, 2024 at 6:13=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > > > +static struct uprobe *find_active_uprobe_speculative(unsigned long=
 bp_vaddr)
> > > > +{
> > > > +       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAY=
SHARE;
> > > > +       struct mm_struct *mm =3D current->mm;
> > > > +       struct uprobe *uprobe;
> > > > +       struct vm_area_struct *vma;
> > > > +       struct file *vm_file;
> > > > +       struct inode *vm_inode;
> > > > +       unsigned long vm_pgoff, vm_start;
> > > > +       int seq;
> > > > +       loff_t offset;
> > > > +
> > > > +       if (!mmap_lock_speculation_start(mm, &seq))
> > > > +               return NULL;
> > > > +
> > > > +       rcu_read_lock();
> > > > +
> > > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > > +       if (!vma)
> > > > +               goto bail;
> > > > +
> > > > +       vm_file =3D data_race(vma->vm_file);
> > >
> > > A plain "data_race()" says "I'm fine with this load tearing", but
> > > you're relying on this load not tearing (since you access the vm_file
> > > pointer below).
> > > You're also relying on the "struct file" that vma->vm_file points to
> > > being populated at this point, which means you need CONSUME semantics
> > > here, which READ_ONCE() will give you, and something like RELEASE
> > > semantics on any pairing store that populates vma->vm_file, which
> > > means they'd all have to become something like smp_store_release()).
> >
> > vma->vm_file should be set in VMA before it is installed and is never
> > modified afterwards, isn't that the case? So maybe no extra barrier
> > are needed and READ_ONCE() would be enough.
>
> Ah, right, I'm not sure what I was thinking there.
>
> I... guess you only _really_ need the READ_ONCE() if something can
> actually ever change the ->vm_file pointer, otherwise just a plain
> load with no annotation whatsoever would be good enough? I'm fairly

yep, probably, I was just trying to be cautious :)

> sure nothing can ever change the ->vm_file pointer of a live VMA, and
> I think _currently_ it looks like nothing will NULL out the ->vm_file
> pointer on free either... though that last part is probably not
> something you should rely on...

This seems to be rather important, but similarly to how vm_file can't
be modified, it seems reasonable to assume that it won't be set to
NULL (it's a modification to set it to a new NULL value, isn't it?). I
mean, we can probably just add a NULL check and rely on the atomicity
of setting a pointer, so not a big deal, but seems like a pretty
reasonable assumption to make.

