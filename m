Return-Path: <linux-fsdevel+bounces-56876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF250B1CC12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BE918C4340
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449FA29DB92;
	Wed,  6 Aug 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOQaAiRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844282E36E7
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505810; cv=none; b=PwXpBErlNPAjctT/zGknqq/n91/FQw1D5khp3FUz9DG7lExiUD11pQ0svBLBvBz2iZQXcYGmAjH7QvzePNzumMCJgP7I9NSIfFoxeBKe9VnaWWqTwy8ldXyQaFsR0Rafv6U/JOuNBDT+koR/y5JauQjS/1l7Odc/1zVIXLllfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505810; c=relaxed/simple;
	bh=9QSVwX9oFoZVqljTyX8yt7lfkEFKxSojDWUswnbqZ7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmximjEvW3Z8koPsuabQlMgDlXksqYtaDC9fkd4Wqz/5+kBgqXCyqy2cKEN75gr/GBHBQRS3RJ2EqbIMUUVDexYm5iH4wpYMQECpvbYHqBdecrWWVo8+iF1aa3L2vJULK96/Xgm9liDPv/u01mzQOs8JxSYha68hgPXN1JLDy8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DOQaAiRL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b099118fedso72211cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 11:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754505806; x=1755110606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXVMjl2ENwPs+sngCAI8ptho3dmgSlq6SfHqbvBpUp0=;
        b=DOQaAiRL5MznGPQnbdV2EpQaoz197mSfNH7bK7sUFcaJ1hxcEwoVYyhej2TWLbOify
         VhLYNMRWOulWqnt8sQJ3DQhaB6J49H1jx5vPItaKl6D3/PFXzktz9vrdmO+ORWn7jgrh
         8rj20d5j5ohhCrl65xP4cSJmifumCkpH4/J9Tlap0H07RUQoSaDILFSkOq1Ud6mYdlSE
         nrU3RjEWPe9DLJRz9yU6GvWvTmH5em8CH9z6tBEc4Stf1DHpeqNg1+aG8PpFjPfL8h/t
         KKXmcjFWvGgRCqFSQObc0HMJk3dZfUrMxtTalw4hhFMN2D+Tco62Hlb+p69m+SxF8aBg
         L0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505806; x=1755110606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXVMjl2ENwPs+sngCAI8ptho3dmgSlq6SfHqbvBpUp0=;
        b=esedtXIgGzdLllTwzuCegwZfN6cTrnhei1xlrnR5qF/Dmm157zZHxaZVix4dKDQowC
         gVky71dzyN+eKaixa21LqxDLsU0E2JcipYO9YtamfIat2/U7WzEI6lQShQZsKkEiD13Y
         ue3tjK9ItYA3Hb4Chr5hCMy20gTlV/rtX6SV8LhbdHh4nUXfyy+41Hj3+bDlhGKE90SC
         KF4JsWBxqjnsFhi+H+755IfPH86ere6kU3bql/6xUAur/6BC2ep4OhrKgWH6qMpl2+Gn
         lo0NRGSQI+8O8rF+9AkdWbb1gWm582lNTsvEpBRmenTq6AoqsM0MosX+4tIot3w9ZbS0
         bpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoeWZ+oQ1CmZQZUAbS1LM4S/8wnZKuRMFUToBJidtesy7uVZ4/Iea70V3dpHRt2Tx3qE+Y8g+ooeu1hdTc@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnzlDLOBdZPFeZIKA8IC6FN2zs7V6Zb5QGk7peilvFSMWHLNv
	rgdkGhEqovq3kUJdBKAZmyuJknk2mgD8jqn92T5xFQ0t3AfnGHIoHDCj3NXCd8TATK8RU/0vlb4
	CIL8Fj1tTvWdurrdzTm52tInvCO8tTXsn3IIEpVQw
X-Gm-Gg: ASbGnctpGGWAgzFmSZIZ/rcInUkyiTzrmtuGCE9rFLHeG8ijGZnkg108EihdIC0Wueo
	2i31PpkY77MJOHi7a9cetc9HojhyUTUaRvGfD8VaOmw2UGPneg01zO9tO+qP73j5PKtHZBhSyp0
	5SuLFqwP4Hgs0LxAQFVU4TNVrHSJOWqgoUN3F40MvX01xupt4xcjwGsG2zff6bJmN/Jlcczmvcx
	KHuJ2eBOow0DCOeuT/dchoza7tigDP37xjcRQ==
X-Google-Smtp-Source: AGHT+IH/vu3AEPEMg1lWhWr6c5i1Hk7l+MHr3ajLJbommv99ZScZpBMyjMSwyw60o5voAFBY5O9vUyZH8Zz3a0jPmgA=
X-Received: by 2002:a05:622a:646:b0:4b0:85d7:b884 with SMTP id
 d75a77b69052e-4b0a1f66a26mr272861cf.21.1754505805730; Wed, 06 Aug 2025
 11:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806155905.824388-1-surenb@google.com> <20250806155905.824388-3-surenb@google.com>
 <01bedec6-53f8-4c1c-9c47-c943ca0f7b4b@lucifer.local>
In-Reply-To: <01bedec6-53f8-4c1c-9c47-c943ca0f7b4b@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 11:43:14 -0700
X-Gm-Features: Ac12FXyS4v5I4rD9FZQ1-uYMFEt8OMTd5btwqy6XpYscekLqviMpnC9QC0UOhos
Message-ID: <CAJuCfpGf6w5-Hxg8tb_3H+2m0JR_3NutLjd=nmN0X=cJyTz+yg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs/proc/task_mmu: factor out proc_maps_private
 fields used by PROCMAP_QUERY
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:04=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Aug 06, 2025 at 08:59:03AM -0700, Suren Baghdasaryan wrote:
> > Refactor struct proc_maps_private so that the fields used by PROCMAP_QU=
ERY
> > ioctl are moved into a separate structure. In the next patch this allow=
s
> > ioctl to reuse some of the functions used for reading /proc/pid/maps
> > without using file->private_data. This prevents concurrent modification
> > of file->private_data members by ioctl and /proc/pid/maps readers.
> >
> > The change is pure code refactoring and has no functional changes.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  fs/proc/internal.h   | 15 ++++++----
> >  fs/proc/task_mmu.c   | 70 ++++++++++++++++++++++----------------------
> >  fs/proc/task_nommu.c | 14 ++++-----
> >  3 files changed, 52 insertions(+), 47 deletions(-)
> >
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index e737401d7383..d1598576506c 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -378,16 +378,21 @@ extern void proc_self_init(void);
> >   * task_[no]mmu.c
> >   */
> >  struct mem_size_stats;
> > -struct proc_maps_private {
> > -     struct inode *inode;
> > -     struct task_struct *task;
> > +
> > +struct proc_maps_locking_ctx {
>
> Decent name :)
>
> >       struct mm_struct *mm;
> > -     struct vma_iterator iter;
> > -     loff_t last_pos;
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       bool mmap_locked;
> >       struct vm_area_struct *locked_vma;
> >  #endif
> > +};
> > +
> > +struct proc_maps_private {
> > +     struct inode *inode;
> > +     struct task_struct *task;
> > +     struct vma_iterator iter;
> > +     loff_t last_pos;
> > +     struct proc_maps_locking_ctx lock_ctx;
> >  #ifdef CONFIG_NUMA
> >       struct mempolicy *task_mempolicy;
> >  #endif
>
> I was going to ask why we have these in internal.h, but then noticed we h=
ave to
> have a nommu version of the task_mmu stuff for museum pieces and
> why-do-they-exist arches, sigh.
>
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index ee1e4ccd33bd..45134335e086 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -132,11 +132,11 @@ static void release_task_mempolicy(struct proc_ma=
ps_private *priv)
> >
> >  #ifdef CONFIG_PER_VMA_LOCK
> >
> > -static void unlock_vma(struct proc_maps_private *priv)
> > +static void unlock_vma(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     if (priv->locked_vma) {
> > -             vma_end_read(priv->locked_vma);
> > -             priv->locked_vma =3D NULL;
> > +     if (lock_ctx->locked_vma) {
> > +             vma_end_read(lock_ctx->locked_vma);
> > +             lock_ctx->locked_vma =3D NULL;
> >       }
> >  }
> >
> > @@ -151,14 +151,14 @@ static inline bool lock_vma_range(struct seq_file=
 *m,
> >        * walking the vma tree under rcu read protection.
> >        */
> >       if (m->op !=3D &proc_pid_maps_op) {
> > -             if (mmap_read_lock_killable(priv->mm))
> > +             if (mmap_read_lock_killable(priv->lock_ctx.mm))
> >                       return false;
> >
> > -             priv->mmap_locked =3D true;
> > +             priv->lock_ctx.mmap_locked =3D true;
> >       } else {
> >               rcu_read_lock();
> > -             priv->locked_vma =3D NULL;
> > -             priv->mmap_locked =3D false;
> > +             priv->lock_ctx.locked_vma =3D NULL;
> > +             priv->lock_ctx.mmap_locked =3D false;
> >       }
> >
> >       return true;
> > @@ -166,10 +166,10 @@ static inline bool lock_vma_range(struct seq_file=
 *m,
> >
> >  static inline void unlock_vma_range(struct proc_maps_private *priv)
> >  {
>
> Not sure why we have unlock_vma() parameterised by proc_maps_locking_ctx =
but
> this is parameerised by proc_maps_private?
>
> Seems more consistent to have both parameterised by proc_maps_locking_ctx=
.

True, we can pass just proc_maps_locking_ctx to both lock_vma_range()
and unlock_vma_range(). Will update.

>
> Maybe we'd want lock() forms this way too for consistency?
>
> > -     if (priv->mmap_locked) {
> > -             mmap_read_unlock(priv->mm);
> > +     if (priv->lock_ctx.mmap_locked) {
> > +             mmap_read_unlock(priv->lock_ctx.mm);
> >       } else {
> > -             unlock_vma(priv);
> > +             unlock_vma(&priv->lock_ctx);
> >               rcu_read_unlock();
> >       }
> >  }
> > @@ -179,13 +179,13 @@ static struct vm_area_struct *get_next_vma(struct=
 proc_maps_private *priv,
> >  {
> >       struct vm_area_struct *vma;
> >
>
> We reference priv->lock_ctx 3 times here, either extract as helper var or=
 pass
> in direct perhaps?
>
> > -     if (priv->mmap_locked)
> > +     if (priv->lock_ctx.mmap_locked)
> >               return vma_next(&priv->iter);
> >
> > -     unlock_vma(priv);
> > -     vma =3D lock_next_vma(priv->mm, &priv->iter, last_pos);
> > +     unlock_vma(&priv->lock_ctx);
> > +     vma =3D lock_next_vma(priv->lock_ctx.mm, &priv->iter, last_pos);
> >       if (!IS_ERR_OR_NULL(vma))
> > -             priv->locked_vma =3D vma;
> > +             priv->lock_ctx.locked_vma =3D vma;
> >
> >       return vma;
> >  }
> > @@ -193,14 +193,14 @@ static struct vm_area_struct *get_next_vma(struct=
 proc_maps_private *priv,
> >  static inline bool fallback_to_mmap_lock(struct proc_maps_private *pri=
v,
> >                                        loff_t pos)
> >  {
>
> (Also)
>
> We reference priv->lock_ctx 3 times here, either extract as helper var or=
 pass
> in direct perhaps?
>
> > -     if (priv->mmap_locked)
> > +     if (priv->lock_ctx.mmap_locked)
> >               return false;
> >
> >       rcu_read_unlock();
> > -     mmap_read_lock(priv->mm);
> > +     mmap_read_lock(priv->lock_ctx.mm);
> >       /* Reinitialize the iterator after taking mmap_lock */
> >       vma_iter_set(&priv->iter, pos);
> > -     priv->mmap_locked =3D true;
> > +     priv->lock_ctx.mmap_locked =3D true;
> >
> >       return true;
> >  }
> > @@ -210,12 +210,12 @@ static inline bool fallback_to_mmap_lock(struct p=
roc_maps_private *priv,
> >  static inline bool lock_vma_range(struct seq_file *m,
> >                                 struct proc_maps_private *priv)
> >  {
> > -     return mmap_read_lock_killable(priv->mm) =3D=3D 0;
> > +     return mmap_read_lock_killable(priv->lock_ctx.mm) =3D=3D 0;
> >  }
> >
> >  static inline void unlock_vma_range(struct proc_maps_private *priv)
> >  {
> > -     mmap_read_unlock(priv->mm);
> > +     mmap_read_unlock(priv->lock_ctx.mm);
> >  }
> >
> >  static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> > @@ -258,7 +258,7 @@ static struct vm_area_struct *proc_get_vma(struct s=
eq_file *m, loff_t *ppos)
> >               *ppos =3D vma->vm_end;
> >       } else {
> >               *ppos =3D SENTINEL_VMA_GATE;
> > -             vma =3D get_gate_vma(priv->mm);
> > +             vma =3D get_gate_vma(priv->lock_ctx.mm);
> >       }
> >
> >       return vma;
> > @@ -278,7 +278,7 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >       if (!priv->task)
> >               return ERR_PTR(-ESRCH);
> >
> > -     mm =3D priv->mm;
> > +     mm =3D priv->lock_ctx.mm;
> >       if (!mm || !mmget_not_zero(mm)) {
> >               put_task_struct(priv->task);
> >               priv->task =3D NULL;
> > @@ -318,7 +318,7 @@ static void *m_next(struct seq_file *m, void *v, lo=
ff_t *ppos)
> >  static void m_stop(struct seq_file *m, void *v)
> >  {
> >       struct proc_maps_private *priv =3D m->private;
> > -     struct mm_struct *mm =3D priv->mm;
> > +     struct mm_struct *mm =3D priv->lock_ctx.mm;
> >
> >       if (!priv->task)
> >               return;
> > @@ -339,9 +339,9 @@ static int proc_maps_open(struct inode *inode, stru=
ct file *file,
> >               return -ENOMEM;
> >
> >       priv->inode =3D inode;
> > -     priv->mm =3D proc_mem_open(inode, PTRACE_MODE_READ);
> > -     if (IS_ERR_OR_NULL(priv->mm)) {
> > -             int err =3D priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->lock_ctx.mm =3D proc_mem_open(inode, PTRACE_MODE_READ);
> > +     if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
> > +             int err =3D priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm=
) : -ESRCH;
> >
> >               seq_release_private(inode, file);
> >               return err;
> > @@ -355,8 +355,8 @@ static int proc_map_release(struct inode *inode, st=
ruct file *file)
> >       struct seq_file *seq =3D file->private_data;
> >       struct proc_maps_private *priv =3D seq->private;
> >
> > -     if (priv->mm)
> > -             mmdrop(priv->mm);
> > +     if (priv->lock_ctx.mm)
> > +             mmdrop(priv->lock_ctx.mm);
> >
> >       return seq_release_private(inode, file);
> >  }
> > @@ -610,7 +610,7 @@ static int do_procmap_query(struct proc_maps_privat=
e *priv, void __user *uarg)
> >       if (!!karg.build_id_size !=3D !!karg.build_id_addr)
> >               return -EINVAL;
> >
> > -     mm =3D priv->mm;
> > +     mm =3D priv->lock_ctx.mm;
> >       if (!mm || !mmget_not_zero(mm))
> >               return -ESRCH;
> >
> > @@ -1311,7 +1311,7 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
> >  {
> >       struct proc_maps_private *priv =3D m->private;
> >       struct mem_size_stats mss =3D {};
> > -     struct mm_struct *mm =3D priv->mm;
> > +     struct mm_struct *mm =3D priv->lock_ctx.mm;
>
> Nit, but maybe add a
>
>         struct proc_maps_locking_ctx *lock_ctx =3D priv->lock_ctx;
>
> Here to reduce 'priv->lock_ctx' stuff?

Yep, will do that in all the places. Thanks!

>
> >       struct vm_area_struct *vma;
> >       unsigned long vma_start =3D 0, last_vma_end =3D 0;
> >       int ret =3D 0;
> > @@ -1456,9 +1456,9 @@ static int smaps_rollup_open(struct inode *inode,=
 struct file *file)
> >               goto out_free;
> >
> >       priv->inode =3D inode;
> > -     priv->mm =3D proc_mem_open(inode, PTRACE_MODE_READ);
> > -     if (IS_ERR_OR_NULL(priv->mm)) {
> > -             ret =3D priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->lock_ctx.mm =3D proc_mem_open(inode, PTRACE_MODE_READ);
> > +     if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
> > +             ret =3D priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : =
-ESRCH;
> >
> >               single_release(inode, file);
> >               goto out_free;
> > @@ -1476,8 +1476,8 @@ static int smaps_rollup_release(struct inode *ino=
de, struct file *file)
> >       struct seq_file *seq =3D file->private_data;
> >       struct proc_maps_private *priv =3D seq->private;
> >
> > -     if (priv->mm)
> > -             mmdrop(priv->mm);
> > +     if (priv->lock_ctx.mm)
> > +             mmdrop(priv->lock_ctx.mm);
> >
> >       kfree(priv);
> >       return single_release(inode, file);
> > diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> > index 59bfd61d653a..d362919f4f68 100644
> > --- a/fs/proc/task_nommu.c
> > +++ b/fs/proc/task_nommu.c
> > @@ -204,7 +204,7 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >       if (!priv->task)
> >               return ERR_PTR(-ESRCH);
> >
> > -     mm =3D priv->mm;
> > +     mm =3D priv->lock_ctx.mm;
> >       if (!mm || !mmget_not_zero(mm)) {
> >               put_task_struct(priv->task);
> >               priv->task =3D NULL;
> > @@ -226,7 +226,7 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >  static void m_stop(struct seq_file *m, void *v)
> >  {
> >       struct proc_maps_private *priv =3D m->private;
> > -     struct mm_struct *mm =3D priv->mm;
>
> (same as above, I reviewed this upsidedown :P)
>
> NIT, but seems sensible to have a
>
>         struct proc_maps_locking_ctx *lock_ctx =3D priv->lock_ctx;
>
> Here so we can avoid the ugly 'priv->lock_ctx' stuff below.
>
> > +     struct mm_struct *mm =3D priv->lock_ctx.mm;
> >
> >       if (!priv->task)
> >               return;
> > @@ -259,9 +259,9 @@ static int maps_open(struct inode *inode, struct fi=
le *file,
> >               return -ENOMEM;
> >
> >       priv->inode =3D inode;
> > -     priv->mm =3D proc_mem_open(inode, PTRACE_MODE_READ);
> > -     if (IS_ERR_OR_NULL(priv->mm)) {
> > -             int err =3D priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->lock_ctx.mm =3D proc_mem_open(inode, PTRACE_MODE_READ);
> > +     if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
> > +             int err =3D priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm=
) : -ESRCH;
>
> >
> >               seq_release_private(inode, file);
> >               return err;
> > @@ -276,8 +276,8 @@ static int map_release(struct inode *inode, struct =
file *file)
> >       struct seq_file *seq =3D file->private_data;
> >       struct proc_maps_private *priv =3D seq->private;
> >
> > -     if (priv->mm)
> > -             mmdrop(priv->mm);
> > +     if (priv->lock_ctx.mm)
> > +             mmdrop(priv->lock_ctx.mm);
> >
> >       return seq_release_private(inode, file);
> >  }
> > --
> > 2.50.1.565.gc32cd1483b-goog
> >

