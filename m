Return-Path: <linux-fsdevel+bounces-20372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172CD8D2604
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 22:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF0F1C245DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F59179202;
	Tue, 28 May 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk5SsJiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923675809;
	Tue, 28 May 2024 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928617; cv=none; b=G8Bs6J0CKXAaJX0kUdQGZ9NpjI8F7M410vxd+o+qlWU239LHc+Q71AImUItYVH/6y5r53Mdi8g7JTV7xSbBBOB74yqJ49gjRSiJjKqPw6wVGL4F96rXo4I8/YUu2s2qV2GVl+bvma9ywRnEob0T9w2SUq8QhJixUybV3FKWFUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928617; c=relaxed/simple;
	bh=ulwdA7kgSS1yzkdDFfJhanLMiaSrjQN9Ozxf+YqYC8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=P6T1TlUHfJE4lrFLVj5lwGOEt0bYJzy0qghTrUD/VzkJjDkuhljVVMbj6GkLB8DDLtKCJNi59ZD6DwrxEsnJ/UtI0ZEmBq4jRaW7owyFCDfS2tk9ujaptPVpI0rIhuZmOrwK7LfYRoPDSHLE4VEUYL8I8n11z5MHfYyHlfa1wbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bk5SsJiQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bdf446f3d1so1042997a91.3;
        Tue, 28 May 2024 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716928615; x=1717533415; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShhpbTYkbNzOOiZyKHXPgvAm+XC4MBjMN7onACro4uw=;
        b=Bk5SsJiQbnW99BgJWl7ZkuCHXroexP17FP+ctUFEso78D+2G7tHSnTyN29F8RG1pTv
         H3mON5dgA3o1TfwQoKe4RNe5K36X7EtV828O8cBskeBBRexYRnbrxmGFKSSgQe6e9t88
         TBmrq5ObmQ6NX3aJjWnq33K3zR5+7uDMbf6BGyhufBpTQT3abpsDBVwHahc3X6Q11qot
         kDUXuP5TUFc/qg9P0svaz3d/44wbjYiGPxBjoAF0qzeSsXAW5fmu3hYS+vVJxRWcGr4o
         +MwvV/Q7jL7oVZTii02bg8sYEDhxFSyHZgmboj5LsuNqYfYFTO3RGjs7tO/fU5g3UA3G
         RGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928615; x=1717533415;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShhpbTYkbNzOOiZyKHXPgvAm+XC4MBjMN7onACro4uw=;
        b=wq9vCDxxIbxMsKowYhg5kVX5jUrO1nVpOJGSFxcgo36ZLRjCHuXktT44rXBDpmP/YD
         tOBSraOrMvkY6rLl4iXIMlyamyRMz827OWOu9Hf9ntnWIGdl6J1vs5OCRqlVS2FSvDGN
         9sd+vlZoNTewcuuHrt1NTsmv7ZBUxm4yH4zMcrrI61K9ZzuUfE0Dq7hTb7gE1jtH0rpv
         47YykV0LCfIuGo8FA24ToyqoSRrckdLqbUadkpZ5RQiWu4/cqyb9hfnJb7YJErOtqGz+
         3dL59QmaFOaaiEZhyqtx9WfyItcr7EHP+Q/Ca50L8ji4YlqGYIrWpNsGbYcfFQnh4QGc
         6CbA==
X-Forwarded-Encrypted: i=1; AJvYcCUmsILGQ2C8WYxM2dtbF3vUUcFLk0hUEAnaD6PGacLVh/iSA0PaTfHc/yyXHgKw0mZ3gj++19+Ra2Hkj+xRhnOqstOgSD3AtNJT0s84gpwiUfjWYdDvaJHvQMwYMBGrWschck5hAj0GenXIxiLKSAKLPU17g1opzlr5/tOAfrwf5g==
X-Gm-Message-State: AOJu0YydlPrMksJReHJYWJ3YEFwjSy7zmRxwP1YERfTFHJebKNV69pIR
	Sw6CC5E0BMQOmfXvI0lExkAyHHNzfVZvd5yxxasbg5vIYiKadN/NXScpSgIcu2go57nZmHjh2yY
	Wlc5IgoZOxaCUmxMdIiMmE17a9P0=
X-Google-Smtp-Source: AGHT+IHCnozhEFi9S2dOEuRQWFG1HUI+x08ibqkACVSV+SfjqJkUqAwwhGL/3AemhXz6T/B8lXbnqnpNdb9tuIv4TSs=
X-Received: by 2002:a17:90a:f684:b0:2b4:32ae:8d29 with SMTP id
 98e67ed59e1d1-2bf5f754e0dmr10595116a91.45.1716928615104; Tue, 28 May 2024
 13:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524041032.1048094-1-andrii@kernel.org> <20240524041032.1048094-5-andrii@kernel.org>
 <eciqv22jtpw6uveqih3jarjqulm5g3nxhlec5ytk2pltlltxnw@47agja2den2b>
In-Reply-To: <eciqv22jtpw6uveqih3jarjqulm5g3nxhlec5ytk2pltlltxnw@47agja2den2b>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 May 2024 13:36:42 -0700
Message-ID: <CAEf4BzbphUBPnA7iDz5pis17GRwzpqsduftV_JHyf1Ce0MMqzw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, surenb@google.com, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 12:48=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Andrii Nakryiko <andrii@kernel.org> [240524 00:10]:
> > Attempt to use RCU-protected per-VAM lock when looking up requested VMA
> > as much as possible, only falling back to mmap_lock if per-VMA lock
> > failed. This is done so that querying of VMAs doesn't interfere with
> > other critical tasks, like page fault handling.
> >
> > This has been suggested by mm folks, and we make use of a newly added
> > internal API that works like find_vma(), but tries to use per-VMA lock.
>
> Thanks for doing this.
>
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  fs/proc/task_mmu.c | 42 ++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 34 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 8ad547efd38d..2b14d06d1def 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -389,12 +389,30 @@ static int pid_maps_open(struct inode *inode, str=
uct file *file)
> >  )
> >
> >  static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> > -                                              unsigned long addr, u32 =
flags)
> > +                                              unsigned long addr, u32 =
flags,
> > +                                              bool *mm_locked)
> >  {
> >       struct vm_area_struct *vma;
> > +     bool mmap_locked;
> > +
> > +     *mm_locked =3D mmap_locked =3D false;
> >
> >  next_vma:
> > -     vma =3D find_vma(mm, addr);
> > +     if (!mmap_locked) {
> > +             /* if we haven't yet acquired mmap_lock, try to use less =
disruptive per-VMA */
> > +             vma =3D find_and_lock_vma_rcu(mm, addr);
> > +             if (IS_ERR(vma)) {
>
> There is a chance that find_and_lock_vma_rcu() will return NULL when
> there should never be a NULL.
>
> If you follow the MAP_FIXED call to mmap(), you'll land in map_region()
> which does two operations: munmap(), then the mmap().  Since this was
> behind a lock, it was fine.  Now that we're transitioning to rcu
> readers, it's less ideal.  We have a race where we will see that gap.
> In this implementation we may return NULL if the MAP_FIXED is at the end
> of the address space.
>
> It might also cause issues if we are searching for a specific address
> and we will skip a VMA that is currently being inserted by MAP_FIXED.
>
> The page fault handler doesn't have this issue as it looks for a
> specific address then falls back to the lock if one is not found.
>
> This problem needs to be fixed prior to shifting the existing proc maps
> file to using rcu read locks as well.  We have a solution that isn't
> upstream or on the ML, but is being tested and will go upstream.

Ok, any ETA for that? Can it be retrofitted into
find_and_lock_vma_rcu() once the fix lands? It's not ideal, but I
think it's acceptable (for now) for this new API to have this race,
given it seems quite unlikely to be hit in practice.

Worst case, we can leave the per-VMA RCU-protected bits out until we
have this solution in place, and then add it back when ready.

>
> > +                     /* failed to take per-VMA lock, fallback to mmap_=
lock */
> > +                     if (mmap_read_lock_killable(mm))
> > +                             return ERR_PTR(-EINTR);
> > +
> > +                     *mm_locked =3D mmap_locked =3D true;
> > +                     vma =3D find_vma(mm, addr);
>
> If you lock the vma here then drop the mmap lock, then you should be
> able to simplify the code by avoiding the passing of the mmap_locked
> variable around.
>
> It also means we don't need to do an unlokc_vma() call, which indicates
> we are going to end the vma read but actually may be unlocking the mm.
>
> This is exactly why I think we need a common pattern and infrastructure
> to do this sort of walking.
>
> Please have a look at userfaultfd patches here [1].  Note that
> vma_start_read() cannot be used in the mmap_read_lock() critical
> section.

Ok, so you'd like me to do something like below, right?

vma =3D find_vma(mm, addr);
if (vma)
    down_read(&vma->vm_lock->lock)
mmap_read_unlock(mm);

... and for the rest of logic always assume having per-VMA lock. ...


The problem here is that I think we can't assume per-VMA lock, because
it's gated by CONFIG_PER_VMA_LOCK, so I think we'll have to deal with
this mmap_locked flag either way. Or am I missing anything?

I don't think the flag makes things that much worse, tbh, but I'm
happy to accommodate any better solution that would work regardless of
CONFIG_PER_VMA_LOCK.

>
> > +             }
> > +     } else {
> > +             /* if we have mmap_lock, get through the search as fast a=
s possible */
> > +             vma =3D find_vma(mm, addr);
>
> I think the only way we get here is if we are contending on the mmap
> lock.  This is actually where we should try to avoid holding the lock?
>
> > +     }
> >
> >       /* no VMA found */
> >       if (!vma)
> > @@ -428,18 +446,25 @@ static struct vm_area_struct *query_matching_vma(=
struct mm_struct *mm,
> >  skip_vma:
> >       /*
> >        * If the user needs closest matching VMA, keep iterating.
> > +      * But before we proceed we might need to unlock current VMA.
> >        */
> >       addr =3D vma->vm_end;
> > +     if (!mmap_locked)
> > +             vma_end_read(vma);
> >       if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
> >               goto next_vma;
> >  no_vma:
> > -     mmap_read_unlock(mm);
> > +     if (mmap_locked)
> > +             mmap_read_unlock(mm);
> >       return ERR_PTR(-ENOENT);
> >  }
> >
> > -static void unlock_vma(struct vm_area_struct *vma)
> > +static void unlock_vma(struct vm_area_struct *vma, bool mm_locked)
>
> Confusing function name, since it may not be doing anything with the
> vma lock.

Would "unlock_vma_or_mm()" be ok?

>
> >  {
> > -     mmap_read_unlock(vma->vm_mm);
> > +     if (mm_locked)
> > +             mmap_read_unlock(vma->vm_mm);
> > +     else
> > +             vma_end_read(vma);
> >  }
> >
> >  static int do_procmap_query(struct proc_maps_private *priv, void __use=
r *uarg)
> > @@ -447,6 +472,7 @@ static int do_procmap_query(struct proc_maps_privat=
e *priv, void __user *uarg)
> >       struct procmap_query karg;
> >       struct vm_area_struct *vma;
> >       struct mm_struct *mm;
> > +     bool mm_locked;
> >       const char *name =3D NULL;
> >       char *name_buf =3D NULL;
> >       __u64 usize;
> > @@ -475,7 +501,7 @@ static int do_procmap_query(struct proc_maps_privat=
e *priv, void __user *uarg)
> >       if (!mm || !mmget_not_zero(mm))
> >               return -ESRCH;
> >
> > -     vma =3D query_matching_vma(mm, karg.query_addr, karg.query_flags)=
;
> > +     vma =3D query_matching_vma(mm, karg.query_addr, karg.query_flags,=
 &mm_locked);
> >       if (IS_ERR(vma)) {
> >               mmput(mm);
> >               return PTR_ERR(vma);
> > @@ -542,7 +568,7 @@ static int do_procmap_query(struct proc_maps_privat=
e *priv, void __user *uarg)
> >       }
> >
> >       /* unlock vma/mm_struct and put mm_struct before copying data to =
user */
> > -     unlock_vma(vma);
> > +     unlock_vma(vma, mm_locked);
> >       mmput(mm);
> >
> >       if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_na=
me_addr,
> > @@ -558,7 +584,7 @@ static int do_procmap_query(struct proc_maps_privat=
e *priv, void __user *uarg)
> >       return 0;
> >
> >  out:
> > -     unlock_vma(vma);
> > +     unlock_vma(vma, mm_locked);
> >       mmput(mm);
> >       kfree(name_buf);
> >       return err;
> > --
> > 2.43.0
> >
>
> [1]. https://lore.kernel.org/linux-mm/20240215182756.3448972-5-lokeshgidr=
a@google.com/
>
> Thanks,
> Liam

