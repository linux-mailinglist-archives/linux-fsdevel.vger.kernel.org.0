Return-Path: <linux-fsdevel+bounces-29059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4441974468
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 22:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F8A281EA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C31AAE32;
	Tue, 10 Sep 2024 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXT1uW35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E85175D4A;
	Tue, 10 Sep 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001906; cv=none; b=omYzom1uCCSgYwc2IIF631Vo5hvEjxYeWD9/UPzJH2OnSVq2bdfiw/+V3a165UI7LtcMm17uL5fkOjpFd3Ys07sBaZJ564inmqWV8LVa4VLgLE6qs7TgR2Zznu8nrbUNarbCFPNqhO4tdevVCtmlWbr03/4S9GAY2DqqX+Lq73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001906; c=relaxed/simple;
	bh=0M2cahX01JCcUlUOeIR6y6jKS3Uqr4MlbjeurlmXh9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBIC+ZhVO8ERQMimYi9yRf7VA7Ixfm5bLgD2F+QSx5iR1Qy0a9GFjB7i+0pzH/GhoTUd4iIDEb7ZKYoIcziTBgXlt07yZ7h7dI5HPlCq/5sL1gToIPZAKInk8VFL/KM623pDSj8CQneBPUwBU3y2l6JHmwx3TxbrH7KlMpWBK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXT1uW35; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so916215a91.1;
        Tue, 10 Sep 2024 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726001904; x=1726606704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZZkUf2WC6mfIlygG90tFs2dYgOhX5oqJ1ZGT74jCV0=;
        b=AXT1uW35VpgcmbwflIa/N1Gon2ljboAVmwSJa8Ah2xXEx4T4Osur8tem4EM4jhW214
         DVQRAzgr127wLXIqCuXje4qhfIo+PuRFEkIqETNMvER8NVbXztEYeBYD4Z42bzcsUNgg
         TmnOqeI9aHt7JIjLN0lmfgF7TQ/XO+gpYx+jlxKin9eSYF1pPrY4iDSNRD9ciGAf+Pv6
         Z4Hknw1bHLuFaIroqzL2QFpILfCDC19BgMvZfQY8p6Xs3hGg4lf5QHEJn5IgQEtVV9LB
         nGHr62+ixBudCboZMWGTXX6bHaPtl+P9vyRYRVRfHfoHnIhNVCzMg+NbYN3+muw8QidM
         +TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726001904; x=1726606704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZZkUf2WC6mfIlygG90tFs2dYgOhX5oqJ1ZGT74jCV0=;
        b=f8QOeM7puBNqlDmuJW29u63wkPN5opBOsYFIbFp0KZqKsZu8zMlM2nnKtcW7CsOKv9
         8cbg4PkZT7Xil8d9DulGJ3uIVfP9dnd64UlY/eTBsHFau+YTt8kcwXH0RqR8/fGbH/rC
         LocShh+B9jjipKY0+KwV3zGhfsiyn5fxplgkmqcagm39vp8iW1PQl1VCT0uJt+yNF253
         oEJTts824vOsgzmwNHEm1da/Zb48RWgg8FELTLHCbPACtyq9xRPlyzgeAwvGHlcn+z+z
         UjN3B4cwUX/RJTF1/RQbK42R+bP+l6F7SqMLU306L+vXqVFUSarumXkusqthSm5NsnQZ
         oE3g==
X-Forwarded-Encrypted: i=1; AJvYcCVRRipicU+WP5lRciPCtTJ6tV6s4hrC4+rQ2FamFR0nSUuu+iIJ9bywwsOYG9PDouN3nAcYuALYDdT4bbn7Ig==@vger.kernel.org, AJvYcCWB8QQ9QJ4Dm5F8/oVY40wunZiQXzLEKe01AbORnZacUpf8X0sPUJ5T/+37ygUh9BzonB8Q7vsso3qLzyvjL0QZ6Oth@vger.kernel.org, AJvYcCWOyqlQHyfJflt+2XPLCPpojX8sgLU16H25+sk3aIKVL3uIvxvFN1x3mgzZjYp9uXM4WLI=@vger.kernel.org, AJvYcCWeaDFLsVz0fLGut8A/fDa/MKHNaOIlmWnP8rWdJ7KdOhBB/f7FWMdsQt+cRnXGuCze3NBUA2+Sg96cLyoG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75sAJlVdLTDC6HkOi9B116U8nkKHIEIattEwHTqY02+hDLEdg
	0chF1TGvow2sQpHAwBItmLN3dtIKc2sKwyTyV7UloG3wC7XOAK/f9HZaPZuKOaQpt3AX83v/k+C
	AEd4ueShgUs5Oz4OE5ty3i94Hc60=
X-Google-Smtp-Source: AGHT+IFlYwX3ooMzADHl3WRC56Z25rc41qODOOier4HGtUasmVGD5FRx8r8/jNu4rZMhmraa47eo2BEJ07U35fQBNJg=
X-Received: by 2002:a17:90a:f004:b0:2d8:d254:6cda with SMTP id
 98e67ed59e1d1-2db82fec7admr1019356a91.20.1726001904425; Tue, 10 Sep 2024
 13:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com>
 <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com> <CAJuCfpEhCm3QoZqemO=bX0snO16fxOssMWzLsiewkioiRV_aOA@mail.gmail.com>
In-Reply-To: <CAJuCfpEhCm3QoZqemO=bX0snO16fxOssMWzLsiewkioiRV_aOA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 13:58:10 -0700
Message-ID: <CAEf4Bzbh_HWuHEZqHZ7MHFLtp+jFf2yiCWyd-RqY-hvm09d5Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 9:32=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Sep 9, 2024 at 2:29=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Sep 9, 2024 at 6:13=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > >
> > > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > > > Given filp_cachep is already marked SLAB_TYPESAFE_BY_RCU, we can sa=
fely
> > > > access vma->vm_file->f_inode field locklessly under just rcu_read_l=
ock()
> > >
> > > No, not every file is SLAB_TYPESAFE_BY_RCU - see for example
> > > ovl_mmap(), which uses backing_file_mmap(), which does
> > > vma_set_file(vma, file) where "file" comes from ovl_mmap()'s
> > > "realfile", which comes from file->private_data, which is set in
> > > ovl_open() to the return value of ovl_open_realfile(), which comes
> > > from backing_file_open(), which allocates a file with
> > > alloc_empty_backing_file(), which uses a normal kzalloc() without any
> > > RCU stuff, with this comment:
> > >
> > >  * This is only for kernel internal use, and the allocate file must n=
ot be
> > >  * installed into file tables or such.
> > >
> > > And when a backing_file is freed, you can see on the path
> > > __fput() -> file_free()
> > > that files with FMODE_BACKING are directly freed with kfree(), no RCU=
 delay.
> >
> > Good catch on FMODE_BACKING, I didn't realize there is this exception, =
thanks!
> >
> > I think the way forward would be to detect that the backing file is in
> > FMODE_BACKING and fall back to mmap_lock-protected code path.
> >
> > I guess I have the question to Liam and Suren, do you think it would
> > be ok to add another bool after `bool detached` in struct
> > vm_area_struct (guarded by CONFIG_PER_VMA_LOCK), or should we try to
> > add an extra bit into vm_flags_t? The latter would work without
> > CONFIG_PER_VMA_LOCK, but I don't know what's acceptable with mm folks.
> >
> > This flag can be set in vma_set_file() when swapping backing file and
> > wherever else vma->vm_file might be set/updated (I need to audit the
> > code).
>
> I understand that this would work but I'm not very eager to leak
> vm_file attributes like FMODE_BACKING into vm_area_struct.
> Instead maybe that exception can be avoided? Treating all vm_files

I agree, that would be best, of course. It seems like [1] was an
optimization to avoid kfree_rcu() calls, not sure how big of a deal it
is to undo that, given we do have a use case that calls for it now.
Let's see what Christian thinks.

> equally as RCU-safe would be a much simpler solution. I see that this
> exception was introduced in [1] and I don't know if this was done for
> performance reasons or something else. Christian, CCing you here to
> please clarify.
>
> [1] https://lore.kernel.org/all/20231005-sakralbau-wappnen-f5c31755ed70@b=
rauner/
>
> >
> > >
> > > So the RCU-ness of "struct file" is an implementation detail of the
> > > VFS, and you can't rely on it for ->vm_file unless you get the VFS to
> > > change how backing file lifetimes work, which might slow down some
> > > other workload, or you find a way to figure out whether you're dealin=
g
> > > with a backing file without actually accessing the file.
> > >
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
> >
> > >
> > > You might want to instead add another recheck of the sequence count
> > > (which would involve at least a read memory barrier after the
> > > preceding patch is fixed) after loading the ->vm_file pointer to
> > > ensure that no one was concurrently changing the ->vm_file pointer
> > > before you do memory accesses through it.
> > >
> > > > +       if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> > > > +               goto bail;
> > >
> > > missing data_race() annotation on the vma->vm_flags access
> >
> > ack
> >
> > >
> > > > +       vm_inode =3D data_race(vm_file->f_inode);
> > >
> > > As noted above, this doesn't work because you can't rely on having RC=
U
> > > lifetime for the file. One *very* ugly hack you could do, if you thin=
k
> > > this code is so performance-sensitive that you're willing to do fairl=
y
> > > atrocious things here, would be to do a "yes I am intentionally doing
> > > a UAF read and I know the address might not even be mapped at this
> > > point, it's fine, trust me" pattern, where you use
> > > copy_from_kernel_nofault(), kind of like in prepend_copy() in
> > > fs/d_path.c, and then immediately recheck the sequence count before
> > > doing *anything* with this vm_inode pointer you just loaded.
> > >
> > >
> >
> > yeah, let's leave it as a very unfortunate plan B and try to solve it
> > a bit cleaner.
> >
> >
> > >
> > > > +       vm_pgoff =3D data_race(vma->vm_pgoff);
> > > > +       vm_start =3D data_race(vma->vm_start);
> > > > +
> > > > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - v=
m_start);
> > > > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > > +       if (!uprobe)
> > > > +               goto bail;
> > > > +
> > > > +       /* now double check that nothing about MM changed */
> > > > +       if (!mmap_lock_speculation_end(mm, seq))
> > > > +               goto bail;
> > > > +
> > > > +       rcu_read_unlock();
> > > > +
> > > > +       /* happy case, we speculated successfully */
> > > > +       return uprobe;
> > > > +bail:
> > > > +       rcu_read_unlock();
> > > > +       return NULL;
> > > > +}

