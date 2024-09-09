Return-Path: <linux-fsdevel+bounces-28965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D0972487
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 23:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDFB2855A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F818C90B;
	Mon,  9 Sep 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6aOlpHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DF188CD9;
	Mon,  9 Sep 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917358; cv=none; b=QuRNibIVeFOGftI5yWL9ysBHayDqdgT1cCRBiPdBIxk69yFESJi8UI2L/ofYJS3M3/5Rw4RW1jAv4UvISju5jvg9hC1sJ6nVuuwAoiilzdPIwSmqlKrv57M2hZCeKJI3mjWK+LNeuscHxCw8T0Pqw6hX8kyhzJN+pG1dJ/S/RVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917358; c=relaxed/simple;
	bh=Fn/JhS/yoJtO1B9GjAvaamfyN3vOQPkUSPrqnzOC+9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPA73FjBF5A/SgFTCzAf/aGvdk+C24g2Pq3cqMEOp/GQNxrAfgWwaz44+k1V5c9E7D5LY60/ZrPL5Im5HhbXWlZzJDZi1pJuVWcLQeGpUCA9A02mqyDRJz5vVsfnOHqJdncDppk+pr3vRvadpfyHYEXB87x2q9qSF2a5OFE6mkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6aOlpHM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2054feabfc3so42770425ad.1;
        Mon, 09 Sep 2024 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725917356; x=1726522156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWEX4r7jK/WQUNLo3UpE/qaecNNCCFHIzAO2V+o4c/g=;
        b=N6aOlpHMO8gHPKzs1up90tVwaysJUuedl+NEC2VIvl/j8MU2z9YuRk66sN2f55jA0q
         2+K9tfpnqZVj+RwtjgTIOo4ZxFRE/3HHs6cMBFMtbD7/Pap2/P3RCiHeBvbDsghizbMJ
         wqjDDiykfIS8HBc6Mw6+GkBej0M3Nk3ivV0nJSUbueqq/iieYIVXjDLqetFztibt6jDW
         290JfN4Nh/KJZU36bg+mV0bQCaFPBIjdesQkE+b3Wi0uTb1gDLg2xzIXMIAXRxU3u5ZX
         1bZMgpT37XoWSgDGHOw1luWOuLP/kS7VPy98ZzIMUxgbm7utJX5AkT2yDOQCaFhn0C+H
         PPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725917356; x=1726522156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWEX4r7jK/WQUNLo3UpE/qaecNNCCFHIzAO2V+o4c/g=;
        b=jsFA4P0Af8Axj4DTxtWTB71a0xGrzGfHrVXQ7X17NDLizINBfBlnLeMiNQaYt0T8VA
         7A7HiF5RtH0/C3g3Z5Em9V/m4Av1wUsK7fKqJ48kb363GHI4RlVpwSCgj87s8GZVG+Bx
         X/vMP35gbYKBc/LkwSfvMhrj8gU2QDtGOjG37hzMLZOYtPxIJVMprpAF/wPLmz/0nTCC
         WNELGVxUb72emA47ds58+MMGIViqVgDuAnM7ieRbCybN6/Iw1VADF+vRagSeByPSTTHw
         Uv8G+tdqYNx+6tVf4Xccf5zWsQ38f/5A3Q9e4ZaEgyn9yDc+jxl4x+lfCzhf5i7aKqta
         SY/w==
X-Forwarded-Encrypted: i=1; AJvYcCWFzcjgghzmxC/lH2yD2AOWOuIhu75IxIdkZFGv+wNZ4uDDLYzc2HeHRUbyjRSFIbKCnaE=@vger.kernel.org, AJvYcCWi2oMfXlJ4pUGQs13qasz4qDhpREcOeQ26k9hNXaa3lRVU0OKtXU+7zcWDzAVFbafrmnhrJeMaDrY0awhA@vger.kernel.org, AJvYcCWkgrr0qJa+ydyy2aHJvVQMzxAgjemGRMwEx3aNRZSDBmuao3D6aequpUJnFuL+HGOJ/ojrAk6DkBB8FPcwOA==@vger.kernel.org, AJvYcCWoHk01sLZlP363tAwAvtPtR95zlOkufR+OvmuqWaqAI9jjUV/+gfjWkYKYsjwbbYjLUOJsrWn/7IjfBX+M9l7oDdDl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9q26WqF/0qi3gFBOaick8MS+3Dx70yJbJzGX33Dg3oPtQHkKo
	88pBdCYsnyJuZHze2XJNUya9Vtp5JBf+MJBOtHz2xEEISDV6IrcgD3Wd/C0hdOkzvziNk9ZEROn
	//JklDQM0VMzHUFZuDdL2RP1Wzu4=
X-Google-Smtp-Source: AGHT+IHfUYAO11AnWDKGYgcX7wXzZr4/bp0e2f3bLddaNkIUpBnk0YADB/36ETv0KpYGTGDAp3Yj81Vw4zn5LqPQIhU=
X-Received: by 2002:a17:902:dad1:b0:202:54b8:72e5 with SMTP id
 d9443c01a7336-206f0534658mr139583215ad.22.1725917356118; Mon, 09 Sep 2024
 14:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com>
In-Reply-To: <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 14:29:03 -0700
Message-ID: <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Jann Horn <jannh@google.com>, surenb@google.com, 
	Liam Howlett <liam.howlett@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, brauner@kernel.org, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 6:13=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> > Given filp_cachep is already marked SLAB_TYPESAFE_BY_RCU, we can safely
> > access vma->vm_file->f_inode field locklessly under just rcu_read_lock(=
)
>
> No, not every file is SLAB_TYPESAFE_BY_RCU - see for example
> ovl_mmap(), which uses backing_file_mmap(), which does
> vma_set_file(vma, file) where "file" comes from ovl_mmap()'s
> "realfile", which comes from file->private_data, which is set in
> ovl_open() to the return value of ovl_open_realfile(), which comes
> from backing_file_open(), which allocates a file with
> alloc_empty_backing_file(), which uses a normal kzalloc() without any
> RCU stuff, with this comment:
>
>  * This is only for kernel internal use, and the allocate file must not b=
e
>  * installed into file tables or such.
>
> And when a backing_file is freed, you can see on the path
> __fput() -> file_free()
> that files with FMODE_BACKING are directly freed with kfree(), no RCU del=
ay.

Good catch on FMODE_BACKING, I didn't realize there is this exception, than=
ks!

I think the way forward would be to detect that the backing file is in
FMODE_BACKING and fall back to mmap_lock-protected code path.

I guess I have the question to Liam and Suren, do you think it would
be ok to add another bool after `bool detached` in struct
vm_area_struct (guarded by CONFIG_PER_VMA_LOCK), or should we try to
add an extra bit into vm_flags_t? The latter would work without
CONFIG_PER_VMA_LOCK, but I don't know what's acceptable with mm folks.

This flag can be set in vma_set_file() when swapping backing file and
wherever else vma->vm_file might be set/updated (I need to audit the
code).

>
> So the RCU-ness of "struct file" is an implementation detail of the
> VFS, and you can't rely on it for ->vm_file unless you get the VFS to
> change how backing file lifetimes work, which might slow down some
> other workload, or you find a way to figure out whether you're dealing
> with a backing file without actually accessing the file.
>
> > +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_=
vaddr)
> > +{
> > +       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHAR=
E;
> > +       struct mm_struct *mm =3D current->mm;
> > +       struct uprobe *uprobe;
> > +       struct vm_area_struct *vma;
> > +       struct file *vm_file;
> > +       struct inode *vm_inode;
> > +       unsigned long vm_pgoff, vm_start;
> > +       int seq;
> > +       loff_t offset;
> > +
> > +       if (!mmap_lock_speculation_start(mm, &seq))
> > +               return NULL;
> > +
> > +       rcu_read_lock();
> > +
> > +       vma =3D vma_lookup(mm, bp_vaddr);
> > +       if (!vma)
> > +               goto bail;
> > +
> > +       vm_file =3D data_race(vma->vm_file);
>
> A plain "data_race()" says "I'm fine with this load tearing", but
> you're relying on this load not tearing (since you access the vm_file
> pointer below).
> You're also relying on the "struct file" that vma->vm_file points to
> being populated at this point, which means you need CONSUME semantics
> here, which READ_ONCE() will give you, and something like RELEASE
> semantics on any pairing store that populates vma->vm_file, which
> means they'd all have to become something like smp_store_release()).

vma->vm_file should be set in VMA before it is installed and is never
modified afterwards, isn't that the case? So maybe no extra barrier
are needed and READ_ONCE() would be enough.

>
> You might want to instead add another recheck of the sequence count
> (which would involve at least a read memory barrier after the
> preceding patch is fixed) after loading the ->vm_file pointer to
> ensure that no one was concurrently changing the ->vm_file pointer
> before you do memory accesses through it.
>
> > +       if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> > +               goto bail;
>
> missing data_race() annotation on the vma->vm_flags access

ack

>
> > +       vm_inode =3D data_race(vm_file->f_inode);
>
> As noted above, this doesn't work because you can't rely on having RCU
> lifetime for the file. One *very* ugly hack you could do, if you think
> this code is so performance-sensitive that you're willing to do fairly
> atrocious things here, would be to do a "yes I am intentionally doing
> a UAF read and I know the address might not even be mapped at this
> point, it's fine, trust me" pattern, where you use
> copy_from_kernel_nofault(), kind of like in prepend_copy() in
> fs/d_path.c, and then immediately recheck the sequence count before
> doing *anything* with this vm_inode pointer you just loaded.
>
>

yeah, let's leave it as a very unfortunate plan B and try to solve it
a bit cleaner.


>
> > +       vm_pgoff =3D data_race(vma->vm_pgoff);
> > +       vm_start =3D data_race(vma->vm_start);
> > +
> > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_st=
art);
> > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > +       if (!uprobe)
> > +               goto bail;
> > +
> > +       /* now double check that nothing about MM changed */
> > +       if (!mmap_lock_speculation_end(mm, seq))
> > +               goto bail;
> > +
> > +       rcu_read_unlock();
> > +
> > +       /* happy case, we speculated successfully */
> > +       return uprobe;
> > +bail:
> > +       rcu_read_unlock();
> > +       return NULL;
> > +}

