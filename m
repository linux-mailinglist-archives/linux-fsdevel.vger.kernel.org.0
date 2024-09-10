Return-Path: <linux-fsdevel+bounces-29040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C9B973D5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC65F287D34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE91A38CB;
	Tue, 10 Sep 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8dAvcEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976181A2854
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985944; cv=none; b=D3wYDnWtRB0DO8pHiqiZyNzGusvUoO59IMc+9iEFJaDfyxwrSDSDF3cEY+wfjZ/cFpRjx0M8gFM6FXvcEu9wk5Jkf5QsXMdHQMin9L/2B7F8p+pG5gldbjCxyeDnyNVeNVD+4GIga9677AUp2VzGJ8dzM9rY8O6Nc5VHHdYXqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985944; c=relaxed/simple;
	bh=EWuKgeWWA5soGhYyTDYq01t+mi3z5zhIMP8gGZF/Wtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpZQXjw7+s5Ndu1kfxIZp1UUmqic3kAFGueKzjVriJr/o8ZkE9p0rSZ0DztThJwcEgiYAkyElicWD2VkF8RkLI+XZSm7HMpneFaqX5vCGi+jMjUp7nTtn9QKX074qbZo5O2a1elD1upCClqpx3/U5+Cs18FBuQynRyAgFbM38Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8dAvcEs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4582fa01090so317691cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 09:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725985941; x=1726590741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9ncZWKOVJEsq4iDNvlY1nT7hu4+4z6i+c0WR3K9aTs=;
        b=W8dAvcEsr7Ieae5tsEHO0pK0X2LyYTHWTQOIiMCrCjRiiARRWqQF1zE8AZ/glE6RRw
         BzleGHWCbtGOR5NQGuWXphdBNZBNU90S54Dts6tC9Aa4QZHbTYjoyoUhp0nHir6f55UA
         upnMp0QobcOWd63d0/Mt9sVFYbJFhmasxl2Pm5bqsGKPbgwta5eBUEy+3vmxqUn/QmB6
         dC4PjWdFbYCENO3FjKjm4xTIyEpQlN27Lk6vJ6289IZpwfy2joiyvMlKi4jVAcuF87yR
         4KDcVjzjLpMu5dxHpvbJ13EdpL+Dp0XK/602/OpWBL/N36qwA1TlE5eVIMF/ZJJg95w1
         7giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985941; x=1726590741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9ncZWKOVJEsq4iDNvlY1nT7hu4+4z6i+c0WR3K9aTs=;
        b=N1M2BxOCKzUuxZ2JvzKIBIqqPBHKNLnp0FCcJXv+RYEH/X3qrewrEkx9ordzyglLzm
         xTwCgxD/an132YO8mFW3Zjt+WU5ia+RyfVLAEdyjfWrXn3REbgHz3AzFTHlRNfuwDS8V
         uVVPua/aefqGWccL967clexMttp+tlq4cC3ofK3PyCewTR59k+HThBoDpGwThkWfwRxO
         b+nmTIAfzlzg4yMmNadqjnzeqsitPwyimXemTKq7UR4Tlw1sxaK0S/F5y6ZGkDMnGYex
         BdYeyjNfwjTurBllSxndJrXOcgxlU8pGEtojoBWNRrH15MBQDFLaIch5UnDCOWSoTSqe
         3n7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv6/xxtfl8TE6zrONaHVHwajamsXG4DdTLb7kWnpLKLELgJlgnNBG1LgzISl0Fhb7rfvaxIhi948F7t4eE@vger.kernel.org
X-Gm-Message-State: AOJu0YxpF6BIqqE4rETdw2mp23s/XY185/jRDK8UA/+xckyGCVZDrPpO
	YEfrzbFlC6cxWPYIHq5bQf7vHrSRmU2Bat6PsVi9LUcnWVjgEkoCVxm2QCD2SHF+nb2yRuhPZ8Z
	MZNMkkhTAUZSUirrpln4kBDDjb6ZI2mGIorD7
X-Google-Smtp-Source: AGHT+IGzGAumkHrr2bDnkqRNDINvDYeTyLaFVCvxRDWY8NaodXVwMYUWwwjnEltyVzzl/ubtMR1u/3thAFVQbJZiYv0=
X-Received: by 2002:a05:622a:11c8:b0:456:7228:c0a2 with SMTP id
 d75a77b69052e-4583efc8c1fmr3705951cf.13.1725985941140; Tue, 10 Sep 2024
 09:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com> <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Sep 2024 09:32:08 -0700
Message-ID: <CAJuCfpEhCm3QoZqemO=bX0snO16fxOssMWzLsiewkioiRV_aOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:29=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 9, 2024 at 6:13=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> >
> > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > > Given filp_cachep is already marked SLAB_TYPESAFE_BY_RCU, we can safe=
ly
> > > access vma->vm_file->f_inode field locklessly under just rcu_read_loc=
k()
> >
> > No, not every file is SLAB_TYPESAFE_BY_RCU - see for example
> > ovl_mmap(), which uses backing_file_mmap(), which does
> > vma_set_file(vma, file) where "file" comes from ovl_mmap()'s
> > "realfile", which comes from file->private_data, which is set in
> > ovl_open() to the return value of ovl_open_realfile(), which comes
> > from backing_file_open(), which allocates a file with
> > alloc_empty_backing_file(), which uses a normal kzalloc() without any
> > RCU stuff, with this comment:
> >
> >  * This is only for kernel internal use, and the allocate file must not=
 be
> >  * installed into file tables or such.
> >
> > And when a backing_file is freed, you can see on the path
> > __fput() -> file_free()
> > that files with FMODE_BACKING are directly freed with kfree(), no RCU d=
elay.
>
> Good catch on FMODE_BACKING, I didn't realize there is this exception, th=
anks!
>
> I think the way forward would be to detect that the backing file is in
> FMODE_BACKING and fall back to mmap_lock-protected code path.
>
> I guess I have the question to Liam and Suren, do you think it would
> be ok to add another bool after `bool detached` in struct
> vm_area_struct (guarded by CONFIG_PER_VMA_LOCK), or should we try to
> add an extra bit into vm_flags_t? The latter would work without
> CONFIG_PER_VMA_LOCK, but I don't know what's acceptable with mm folks.
>
> This flag can be set in vma_set_file() when swapping backing file and
> wherever else vma->vm_file might be set/updated (I need to audit the
> code).

I understand that this would work but I'm not very eager to leak
vm_file attributes like FMODE_BACKING into vm_area_struct.
Instead maybe that exception can be avoided? Treating all vm_files
equally as RCU-safe would be a much simpler solution. I see that this
exception was introduced in [1] and I don't know if this was done for
performance reasons or something else. Christian, CCing you here to
please clarify.

[1] https://lore.kernel.org/all/20231005-sakralbau-wappnen-f5c31755ed70@bra=
uner/

>
> >
> > So the RCU-ness of "struct file" is an implementation detail of the
> > VFS, and you can't rely on it for ->vm_file unless you get the VFS to
> > change how backing file lifetimes work, which might slow down some
> > other workload, or you find a way to figure out whether you're dealing
> > with a backing file without actually accessing the file.
> >
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
>
> >
> > You might want to instead add another recheck of the sequence count
> > (which would involve at least a read memory barrier after the
> > preceding patch is fixed) after loading the ->vm_file pointer to
> > ensure that no one was concurrently changing the ->vm_file pointer
> > before you do memory accesses through it.
> >
> > > +       if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> > > +               goto bail;
> >
> > missing data_race() annotation on the vma->vm_flags access
>
> ack
>
> >
> > > +       vm_inode =3D data_race(vm_file->f_inode);
> >
> > As noted above, this doesn't work because you can't rely on having RCU
> > lifetime for the file. One *very* ugly hack you could do, if you think
> > this code is so performance-sensitive that you're willing to do fairly
> > atrocious things here, would be to do a "yes I am intentionally doing
> > a UAF read and I know the address might not even be mapped at this
> > point, it's fine, trust me" pattern, where you use
> > copy_from_kernel_nofault(), kind of like in prepend_copy() in
> > fs/d_path.c, and then immediately recheck the sequence count before
> > doing *anything* with this vm_inode pointer you just loaded.
> >
> >
>
> yeah, let's leave it as a very unfortunate plan B and try to solve it
> a bit cleaner.
>
>
> >
> > > +       vm_pgoff =3D data_race(vma->vm_pgoff);
> > > +       vm_start =3D data_race(vma->vm_start);
> > > +
> > > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_=
start);
> > > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > +       if (!uprobe)
> > > +               goto bail;
> > > +
> > > +       /* now double check that nothing about MM changed */
> > > +       if (!mmap_lock_speculation_end(mm, seq))
> > > +               goto bail;
> > > +
> > > +       rcu_read_unlock();
> > > +
> > > +       /* happy case, we speculated successfully */
> > > +       return uprobe;
> > > +bail:
> > > +       rcu_read_unlock();
> > > +       return NULL;
> > > +}

