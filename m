Return-Path: <linux-fsdevel+bounces-29197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B8D976FD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648A7285555
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109851BF7FD;
	Thu, 12 Sep 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URDyy9E4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BEE189526;
	Thu, 12 Sep 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163663; cv=none; b=lkZKOgyagzUPYPhP3wxJErH9XBSzUKrWe+FPUkDErUCKooEv84lCao8rd1aHHzZ5sa7hZuKWZ+zZ/eFAYWTB+Z6X9r/OqoCnHOv63aR4eBr5XTOtaw4yQt0ymAO8q0Q5qBwWDxcZ47J2lK+KtajiyQ/VcBA9eKUR9ohAnd2uToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163663; c=relaxed/simple;
	bh=ZGpQPaBFuEV+YoNpMCj27zCrCaWjnrStrM1jKZMyO/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NX9Tl63tC9DyuKXSn4k3tQSdP9x/rixfxELdG7DWadpuYsHgTUJByh4OGPB3qyquBONpu2AyzyehuZQXQEwLnvHjYJ3g13NdQnKIUF0nSz+x+LXBNi0hH+plgLx1Lxj+IY/uXd/R27FlFdJqyBGpYsEZ+dbhx4t4Gky3PPZWvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URDyy9E4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc47abc040so11944355ad.0;
        Thu, 12 Sep 2024 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726163661; x=1726768461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnI/woVTgkNTSrRDHq2roOu8tQNQ4D8UQtZh3Y6WuYw=;
        b=URDyy9E4jhSxoayM2h6QzUo4PEbQzKr4vgQJFQXns2ik3Zj1S85mQCxwBDETDVINfM
         IzOyVrmW4ExnHGPD6gzOiayXSp5hGTlPoUM/adlqJpTrjWV3Jz6QSBgcfoZc7mwUJFw5
         nc0M8wwJWJFNl9aL4QA9w74GnEl1neZdiq4YFQsWGWs7NlcBj8h23OfrRQazbVh6ezi2
         nuyZg5imlwr3CBSjOWsqWGaINYECAljMGfvzDWDrrvX36BvvInJFlY3g1gXIeCJi/zX0
         Hr7/P1WSx+BSkEEpmSQS2iX6KZ/ss8TnJl/pNVV9Rhb9OO8JJEk+6TuZBRTh9OFq2DUa
         gydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163661; x=1726768461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnI/woVTgkNTSrRDHq2roOu8tQNQ4D8UQtZh3Y6WuYw=;
        b=kJ4L8LDRZ5KOv6FznRUBvXN2yGGpLa8L26S3tG4W7o2AKJFEG+S3jZUnzqKJ9yy7is
         uq9ydoNQKMArDnN440xsFNSaDwHRnyUvkUKOZXKEABeEtrAR22uwN6ec/eaDysoAc0YU
         iPUkDh0CmXhym4LNajI8oyQ3IB9wojJ50w00In2F4jDVcX0XOU9STWsdmyW/ydElqT7n
         xIBhYkpE5sF8QDIMwjjJwN8ucynSKQ0+Gi9LZJ8Nnzxi1pY4SIsSCD6htOg83Tb4dwJo
         r6SMpgMK1tOnGvmwqE5Vq5V/23Vdenk9OKuba4c5XQpqw4gXuzbSj7n8PXZaeFPB06X1
         WCAA==
X-Forwarded-Encrypted: i=1; AJvYcCUIYzqBvk5qbBwfJn20njQkIc/7Zz8u/0SMz9ggUYP7clz+F6l8zzZQRFuvQ+4rduX1Nn+/7g3A5h5+HddbNA==@vger.kernel.org, AJvYcCW6aJExT+KJxvtsNA71iQAZnqZLLB3e/X4kKL1T5GFJ0OcqrHrJtScpxdHPBhkAL2qrBXBJtIOXiot2w7MlQyLPpuCS@vger.kernel.org, AJvYcCWnElpWAsnXg1FOPNrAGqPKstJeAC/vI39uVArCuY2UJQ3/fwBsgI71qlmA45eVKqjRsg3shfphl9sPMQha@vger.kernel.org, AJvYcCXln2qRS1EIwva7m/HGt1pyth9wFctlV1iQx3SW+dXRvvfSeUCTZoVjmJc9BKPNZ4oUWP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAR1rSvIs9m2k330FQawXPaHMwQyPBHVEvujLphv81eZ7Y3gHs
	7PM5J26TbOuZF8EOJLT4/Sj3mo3oJX/+V5EES2IQhcSj9LW38jRQG8lAQp+wX5CB7WHMUoLPn+k
	SsdtZKDWh9pqtHLtufme7KjGWAMLMXg==
X-Google-Smtp-Source: AGHT+IF5Dr9dgApZdKn5lLwhFKi8T2rVtPmatqXg6u6KtfnDgDB7BVjPS6bSH+Hg14686iMVSU6nPTe/fII7VydFM+c=
X-Received: by 2002:a17:902:f68e:b0:205:7829:9d83 with SMTP id
 d9443c01a7336-2076e412fafmr36150895ad.38.1726163660914; Thu, 12 Sep 2024
 10:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com>
 <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
 <CAJuCfpEhCm3QoZqemO=bX0snO16fxOssMWzLsiewkioiRV_aOA@mail.gmail.com>
 <CAEf4Bzbh_HWuHEZqHZ7MHFLtp+jFf2yiCWyd-RqY-hvm09d5Ow@mail.gmail.com> <20240912-urenkel-umorientieren-c27ce893af09@brauner>
In-Reply-To: <20240912-urenkel-umorientieren-c27ce893af09@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 10:54:09 -0700
Message-ID: <CAEf4BzbMN49GXu3B83=k=4vKpLts9Rk8xt50i_xzQL_Tht4m5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Christian Brauner <brauner@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Jann Horn <jannh@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:17=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Sep 10, 2024 at 01:58:10PM GMT, Andrii Nakryiko wrote:
> > On Tue, Sep 10, 2024 at 9:32=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Mon, Sep 9, 2024 at 2:29=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 9, 2024 at 6:13=E2=80=AFAM Jann Horn <jannh@google.com>=
 wrote:
> > > > >
> > > > > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@ke=
rnel.org> wrote:
> > > > > > Given filp_cachep is already marked SLAB_TYPESAFE_BY_RCU, we ca=
n safely
> > > > > > access vma->vm_file->f_inode field locklessly under just rcu_re=
ad_lock()
> > > > >
> > > > > No, not every file is SLAB_TYPESAFE_BY_RCU - see for example
> > > > > ovl_mmap(), which uses backing_file_mmap(), which does
> > > > > vma_set_file(vma, file) where "file" comes from ovl_mmap()'s
> > > > > "realfile", which comes from file->private_data, which is set in
> > > > > ovl_open() to the return value of ovl_open_realfile(), which come=
s
> > > > > from backing_file_open(), which allocates a file with
> > > > > alloc_empty_backing_file(), which uses a normal kzalloc() without=
 any
> > > > > RCU stuff, with this comment:
> > > > >
> > > > >  * This is only for kernel internal use, and the allocate file mu=
st not be
> > > > >  * installed into file tables or such.
> > > > >
> > > > > And when a backing_file is freed, you can see on the path
> > > > > __fput() -> file_free()
> > > > > that files with FMODE_BACKING are directly freed with kfree(), no=
 RCU delay.
> > > >
> > > > Good catch on FMODE_BACKING, I didn't realize there is this excepti=
on, thanks!
> > > >
> > > > I think the way forward would be to detect that the backing file is=
 in
> > > > FMODE_BACKING and fall back to mmap_lock-protected code path.
> > > >
> > > > I guess I have the question to Liam and Suren, do you think it woul=
d
> > > > be ok to add another bool after `bool detached` in struct
> > > > vm_area_struct (guarded by CONFIG_PER_VMA_LOCK), or should we try t=
o
> > > > add an extra bit into vm_flags_t? The latter would work without
> > > > CONFIG_PER_VMA_LOCK, but I don't know what's acceptable with mm fol=
ks.
> > > >
> > > > This flag can be set in vma_set_file() when swapping backing file a=
nd
> > > > wherever else vma->vm_file might be set/updated (I need to audit th=
e
> > > > code).
> > >
> > > I understand that this would work but I'm not very eager to leak
> > > vm_file attributes like FMODE_BACKING into vm_area_struct.
> > > Instead maybe that exception can be avoided? Treating all vm_files
> >
> > I agree, that would be best, of course. It seems like [1] was an
> > optimization to avoid kfree_rcu() calls, not sure how big of a deal it
> > is to undo that, given we do have a use case that calls for it now.
> > Let's see what Christian thinks.
>
> Do you just mean?
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 7ce4d5dac080..03e58b28e539 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -68,7 +68,7 @@ static inline void file_free(struct file *f)
>         put_cred(f->f_cred);
>         if (unlikely(f->f_mode & FMODE_BACKING)) {
>                 path_put(backing_file_user_path(f));
> -               kfree(backing_file(f));
> +               kfree_rcu(backing_file(f));
>         } else {
>                 kmem_cache_free(filp_cachep, f);
>         }
>
> Then the only thing you can do with FMODE_BACKING is to skip it. I think
> that should be fine since backing files right now are only used by
> overlayfs and I don't think the kfree_rcu() will be a performance issue.

Yes, something along those lines. Ok, great, if it's ok to add back
kfree_rcu(), then I think that resolves the main problem I was running
into. I'll incorporate adding back RCU-delated freeing as a separate
patch into the future patch set, thanks!

>
> >
> > > equally as RCU-safe would be a much simpler solution. I see that this
> > > exception was introduced in [1] and I don't know if this was done for
> > > performance reasons or something else. Christian, CCing you here to
> > > please clarify.
> > >
> > > [1] https://lore.kernel.org/all/20231005-sakralbau-wappnen-f5c31755ed=
70@brauner/
> > >
> > > >
> > > > >
> > > > > So the RCU-ness of "struct file" is an implementation detail of t=
he
> > > > > VFS, and you can't rely on it for ->vm_file unless you get the VF=
S to
> > > > > change how backing file lifetimes work, which might slow down som=
e
> > > > > other workload, or you find a way to figure out whether you're de=
aling
> > > > > with a backing file without actually accessing the file.
> > > > >
> > > > > > +static struct uprobe *find_active_uprobe_speculative(unsigned =
long bp_vaddr)
> > > > > > +{
> > > > > > +       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM=
_MAYSHARE;
> > > > > > +       struct mm_struct *mm =3D current->mm;
> > > > > > +       struct uprobe *uprobe;
> > > > > > +       struct vm_area_struct *vma;
> > > > > > +       struct file *vm_file;
> > > > > > +       struct inode *vm_inode;
> > > > > > +       unsigned long vm_pgoff, vm_start;
> > > > > > +       int seq;
> > > > > > +       loff_t offset;
> > > > > > +
> > > > > > +       if (!mmap_lock_speculation_start(mm, &seq))
> > > > > > +               return NULL;
> > > > > > +
> > > > > > +       rcu_read_lock();
> > > > > > +
> > > > > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > > > > +       if (!vma)
> > > > > > +               goto bail;
> > > > > > +
> > > > > > +       vm_file =3D data_race(vma->vm_file);
> > > > >
> > > > > A plain "data_race()" says "I'm fine with this load tearing", but
> > > > > you're relying on this load not tearing (since you access the vm_=
file
> > > > > pointer below).
> > > > > You're also relying on the "struct file" that vma->vm_file points=
 to
> > > > > being populated at this point, which means you need CONSUME seman=
tics
> > > > > here, which READ_ONCE() will give you, and something like RELEASE
> > > > > semantics on any pairing store that populates vma->vm_file, which
> > > > > means they'd all have to become something like smp_store_release(=
)).
> > > >
> > > > vma->vm_file should be set in VMA before it is installed and is nev=
er
> > > > modified afterwards, isn't that the case? So maybe no extra barrier
> > > > are needed and READ_ONCE() would be enough.
> > > >
> > > > >
> > > > > You might want to instead add another recheck of the sequence cou=
nt
> > > > > (which would involve at least a read memory barrier after the
> > > > > preceding patch is fixed) after loading the ->vm_file pointer to
> > > > > ensure that no one was concurrently changing the ->vm_file pointe=
r
> > > > > before you do memory accesses through it.
> > > > >
> > > > > > +       if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC=
)
> > > > > > +               goto bail;
> > > > >
> > > > > missing data_race() annotation on the vma->vm_flags access
> > > >
> > > > ack
> > > >
> > > > >
> > > > > > +       vm_inode =3D data_race(vm_file->f_inode);
> > > > >
> > > > > As noted above, this doesn't work because you can't rely on havin=
g RCU
> > > > > lifetime for the file. One *very* ugly hack you could do, if you =
think
> > > > > this code is so performance-sensitive that you're willing to do f=
airly
> > > > > atrocious things here, would be to do a "yes I am intentionally d=
oing
> > > > > a UAF read and I know the address might not even be mapped at thi=
s
> > > > > point, it's fine, trust me" pattern, where you use
> > > > > copy_from_kernel_nofault(), kind of like in prepend_copy() in
> > > > > fs/d_path.c, and then immediately recheck the sequence count befo=
re
> > > > > doing *anything* with this vm_inode pointer you just loaded.
> > > > >
> > > > >
> > > >
> > > > yeah, let's leave it as a very unfortunate plan B and try to solve =
it
> > > > a bit cleaner.
> > > >
> > > >
> > > > >
> > > > > > +       vm_pgoff =3D data_race(vma->vm_pgoff);
> > > > > > +       vm_start =3D data_race(vma->vm_start);
> > > > > > +
> > > > > > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr=
 - vm_start);
> > > > > > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > > > > +       if (!uprobe)
> > > > > > +               goto bail;
> > > > > > +
> > > > > > +       /* now double check that nothing about MM changed */
> > > > > > +       if (!mmap_lock_speculation_end(mm, seq))
> > > > > > +               goto bail;
> > > > > > +
> > > > > > +       rcu_read_unlock();
> > > > > > +
> > > > > > +       /* happy case, we speculated successfully */
> > > > > > +       return uprobe;
> > > > > > +bail:
> > > > > > +       rcu_read_unlock();
> > > > > > +       return NULL;
> > > > > > +}

