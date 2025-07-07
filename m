Return-Path: <linux-fsdevel+bounces-54195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B79AFBE86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC713424616
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E82877FE;
	Mon,  7 Jul 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clYNQoc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36C2641D8
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929983; cv=none; b=qNa3h5qd0+0+kkQZc9vlnycGtw1knz186VXG+KpwvDIc/0GsMjpeRF88GH+/DZH8HVtB3Szx7O1xRKhq/MkBQMWD2nkcaw+eZfSb8dzSCBRWFqRjOelqEZbEuungo6dXG0bMpui+Q4BcoUHthmVV74qiRiapDZxClY6zN3+qYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929983; c=relaxed/simple;
	bh=FcQzMUEKplX3RtPf8/6VoVZ0YEngYG1giDO8E/Tpyxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AoqCXUZ6IDExkhFAVNcoWXPPhFRJp0NER759PxxhcRZjnHx6XDtlqENmuyx3Mp/8X9FCTNc8zcnxkfrFfVvafLOtawAsoaameEvyRzBCF/RMpT0xhj6J2AoIPa7UDHwsMxLZ3kjbMpe9H4i0bFwv9VulbaDdnFpG7qXYl+w5SHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clYNQoc4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso82611cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751929980; x=1752534780; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb25O4aO4UT3lbamHRx0zE908q3J7m7Kv8tAjLvZ3wo=;
        b=clYNQoc433GJhYHwVSwzCDPSQ4DwNsBOynBfS8uP+ceFw4aZJ5eSTle3oiGeaS/iC5
         B1tD5p0wigDstJs6LA3gA9m2bW53YvAelpU8BALNQlIvTN1oZ8+yYtD6c+hsB/gH2gXL
         Vc/tCbzDwoJX3xwig9ITazpGfVupZ2x9xUr6Nm/vniNdoctHTDWcobsG1Gi5A6LGLyjE
         vvRrptryfsjBAczA3HLfF9Tp4u03KtTzAryxPuqTnsu0dHX6nnztqXeRe6pzk85myihZ
         F68T4rQRTGgcAXSulusS+dPFr6BruTMU4jxjLBwjFTyE+byPohRQ++2hDQ40Po9+gaxb
         e40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751929980; x=1752534780;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vb25O4aO4UT3lbamHRx0zE908q3J7m7Kv8tAjLvZ3wo=;
        b=BAXp+JQzsbdkGFEczDPLclJLCqgGrmpL+k1jogi6+iv3GSZwrhNPRzckZC49m9DRuK
         l/8WMWCDZey3LDIv0mpgtPDYUn2TyjXp1+bv3InyUwmMBlV8XVLX4vxFlQo4WCr98Hm7
         dRwjS61BeZfLKAx22l4pMXbKpZd2cqac/1cLhbTzMdKdDlFt99IiovWfLeqQPpJy9qk5
         CFm303yRD0BSvLZELCfk2mEuIGvnzssKFsdeA6Oh+orJ098mqJX289aziCfwQA/nLgl+
         v1hsdaceJImAttLC7/CGmviFzDchuTnZ2YyvG6FhasmO6y8YNbDZ4DHHYnmOfFw6PrhK
         1Kkw==
X-Forwarded-Encrypted: i=1; AJvYcCW7MJcScI06Hg43GrqlAs4uL2VXw2coKM9rn/vasHbtecLC/Sz9buiHHJPIqHzS0hOczweN6xjXg634qb9f@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWJKrUq+/3LCtLz618osh8wH78NQi0PfW75E5JqavC7IkhqmP
	I2U9+dDuRD64evvt9KbG/Frow+LetTsaMhmcytLgVIRTnC+41wrPIdmr34wZrzKAHWmMrtF3n4U
	qgov2NMEo1bisZwnZo25H/i6yE1XpABGL53AX2OCN
X-Gm-Gg: ASbGnctRSLidaEe2s7DvlpdTNXn+RvRMgFdg8AYyZaIu0a9D4vp8y+AzXuuPjwFX4e1
	UKigRBXfOA9cJi8/Ig4l7y1Y7JpaFPFKNlawxrNX1R6XlpHQrTcLV1ve7I/Uf2pE9fDEVBLNPLk
	vJcbZPPk+6dAtShGT0jVwEjGvUqa57cC+wngsTipwOwA==
X-Google-Smtp-Source: AGHT+IETgKmn3XFY+l1mIRl5sj+e0ujWE5WNG6Mi/bRZmR8SuoNbDS3rsbpkj/zI+wTZJ+gdFSV5n1X6kK9q13Q4UZA=
X-Received: by 2002:a05:622a:1cc3:b0:480:dde:aa4c with SMTP id
 d75a77b69052e-4a9cccdea97mr1590441cf.4.1751929979568; Mon, 07 Jul 2025
 16:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com>
 <uwbh4yo7x3yjkljibd2uy57qubev2xfmavqxwgjjqontxdle2z@yg2clwpvqzq2>
In-Reply-To: <uwbh4yo7x3yjkljibd2uy57qubev2xfmavqxwgjjqontxdle2z@yg2clwpvqzq2>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Jul 2025 16:12:48 -0700
X-Gm-Features: Ac12FXwi7079ioCO2E4qz_JGwtg_CyJBtiTMTTwcEur0H9sgldAVvNh2S8wJCxs
Message-ID: <CAJuCfpERjSEOoXaSsuYvnhTn6DJu4oN9Cx1LJ7NHdskDvS4AkQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, david@redhat.com, 
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

On Mon, Jul 7, 2025 at 11:21=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [250704 02:07]:
> > With maple_tree supporting vma tree traversal under RCU and per-vma
> > locks, /proc/pid/maps can be read while holding individual vma locks
> > instead of locking the entire address space.
> > Completely lockless approach (walking vma tree under RCU) would be quit=
e
> > complex with the main issue being get_vma_name() using callbacks which
> > might not work correctly with a stable vma copy, requiring original
> > (unstable) vma - see special_mapping_name() for an example.
> > When per-vma lock acquisition fails, we take the mmap_lock for reading,
> > lock the vma, release the mmap_lock and continue. This fallback to mmap
> > read lock guarantees the reader to make forward progress even during
> > lock contention. This will interfere with the writer but for a very
> > short time while we are acquiring the per-vma lock and only when there
> > was contention on the vma reader is interested in. We shouldn't see a
> > repeated fallback to mmap read locks in practice, as this require a
> > very unlikely series of lock contentions (for instance due to repeated
> > vma split operations). However even if this did somehow happen, we woul=
d
> > still progress.
> > One case requiring special handling is when vma changes between the
> > time it was found and the time it got locked. A problematic case would
> > be if vma got shrunk so that it's start moved higher in the address
> > space and a new vma was installed at the beginning:
> >
> > reader found:               |--------VMA A--------|
> > VMA is modified:            |-VMA B-|----VMA A----|
> > reader locks modified VMA A
> > reader reports VMA A:       |  gap  |----VMA A----|
> >
> > This would result in reporting a gap in the address space that does not
> > exist. To prevent this we retry the lookup after locking the vma, howev=
er
> > we do that only when we identify a gap and detect that the address spac=
e
> > was changed after we found the vma.
> > This change is designed to reduce mmap_lock contention and prevent a
> > process reading /proc/pid/maps files (often a low priority task, such
> > as monitoring/data collection services) from blocking address space
> > updates. Note that this change has a userspace visible disadvantage:
> > it allows for sub-page data tearing as opposed to the previous mechanis=
m
> > where data tearing could happen only between pages of generated output
> > data. Since current userspace considers data tearing between pages to b=
e
> > acceptable, we assume is will be able to handle sub-page data tearing
> > as well.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!
I'll update addressing Lorenzo's nits and will repost in a couple
days. Hopefully by then I can get some reviews for the tests in the
series.

>
> > ---
> >  fs/proc/internal.h        |   5 ++
> >  fs/proc/task_mmu.c        | 118 ++++++++++++++++++++++++++++++++++----
> >  include/linux/mmap_lock.h |  11 ++++
> >  mm/madvise.c              |   3 +-
> >  mm/mmap_lock.c            |  88 ++++++++++++++++++++++++++++
> >  5 files changed, 214 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index 3d48ffe72583..7c235451c5ea 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -384,6 +384,11 @@ struct proc_maps_private {
> >       struct task_struct *task;
> >       struct mm_struct *mm;
> >       struct vma_iterator iter;
> > +     loff_t last_pos;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     bool mmap_locked;
> > +     struct vm_area_struct *locked_vma;
> > +#endif
> >  #ifdef CONFIG_NUMA
> >       struct mempolicy *task_mempolicy;
> >  #endif
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index b8bc06d05a72..ff3fe488ce51 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -127,15 +127,107 @@ static void release_task_mempolicy(struct proc_m=
aps_private *priv)
> >  }
> >  #endif
> >
> > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *p=
riv,
> > -                                             loff_t *ppos)
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static void unlock_vma(struct proc_maps_private *priv)
> > +{
> > +     if (priv->locked_vma) {
> > +             vma_end_read(priv->locked_vma);
> > +             priv->locked_vma =3D NULL;
> > +     }
> > +}
> > +
> > +static const struct seq_operations proc_pid_maps_op;
> > +
> > +static inline bool lock_vma_range(struct seq_file *m,
> > +                               struct proc_maps_private *priv)
> > +{
> > +     /*
> > +      * smaps and numa_maps perform page table walk, therefore require
> > +      * mmap_lock but maps can be read with locking just the vma.
> > +      */
> > +     if (m->op !=3D &proc_pid_maps_op) {
> > +             if (mmap_read_lock_killable(priv->mm))
> > +                     return false;
> > +
> > +             priv->mmap_locked =3D true;
> > +     } else {
> > +             rcu_read_lock();
> > +             priv->locked_vma =3D NULL;
> > +             priv->mmap_locked =3D false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static inline void unlock_vma_range(struct proc_maps_private *priv)
> > +{
> > +     if (priv->mmap_locked) {
> > +             mmap_read_unlock(priv->mm);
> > +     } else {
> > +             unlock_vma(priv);
> > +             rcu_read_unlock();
> > +     }
> > +}
> > +
> > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> > +                                        loff_t last_pos)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     if (priv->mmap_locked)
> > +             return vma_next(&priv->iter);
> > +
> > +     unlock_vma(priv);
> > +     vma =3D lock_next_vma(priv->mm, &priv->iter, last_pos);
> > +     if (!IS_ERR_OR_NULL(vma))
> > +             priv->locked_vma =3D vma;
> > +
> > +     return vma;
> > +}
> > +
> > +#else /* CONFIG_PER_VMA_LOCK */
> > +
> > +static inline bool lock_vma_range(struct seq_file *m,
> > +                               struct proc_maps_private *priv)
> >  {
> > -     struct vm_area_struct *vma =3D vma_next(&priv->iter);
> > +     return mmap_read_lock_killable(priv->mm) =3D=3D 0;
> > +}
> > +
> > +static inline void unlock_vma_range(struct proc_maps_private *priv)
> > +{
> > +     mmap_read_unlock(priv->mm);
> > +}
> > +
> > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> > +                                        loff_t last_pos)
> > +{
> > +     return vma_next(&priv->iter);
> > +}
> >
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> > +static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t =
*ppos)
> > +{
> > +     struct proc_maps_private *priv =3D m->private;
> > +     struct vm_area_struct *vma;
> > +
> > +     vma =3D get_next_vma(priv, *ppos);
> > +     /* EINTR is possible */
> > +     if (IS_ERR(vma))
> > +             return vma;
> > +
> > +     /* Store previous position to be able to restart if needed */
> > +     priv->last_pos =3D *ppos;
> >       if (vma) {
> > -             *ppos =3D vma->vm_start;
> > +             /*
> > +              * Track the end of the reported vma to ensure position c=
hanges
> > +              * even if previous vma was merged with the next vma and =
we
> > +              * found the extended vma with the same vm_start.
> > +              */
> > +             *ppos =3D vma->vm_end;
> >       } else {
> > -             *ppos =3D -2;
> > +             *ppos =3D -2; /* -2 indicates gate vma */
> >               vma =3D get_gate_vma(priv->mm);
> >       }
> >
> > @@ -163,28 +255,34 @@ static void *m_start(struct seq_file *m, loff_t *=
ppos)
> >               return NULL;
> >       }
> >
> > -     if (mmap_read_lock_killable(mm)) {
> > +     if (!lock_vma_range(m, priv)) {
> >               mmput(mm);
> >               put_task_struct(priv->task);
> >               priv->task =3D NULL;
> >               return ERR_PTR(-EINTR);
> >       }
> >
> > +     /*
> > +      * Reset current position if last_addr was set before
> > +      * and it's not a sentinel.
> > +      */
> > +     if (last_addr > 0)
> > +             *ppos =3D last_addr =3D priv->last_pos;
> >       vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
> >       hold_task_mempolicy(priv);
> >       if (last_addr =3D=3D -2)
> >               return get_gate_vma(mm);
> >
> > -     return proc_get_vma(priv, ppos);
> > +     return proc_get_vma(m, ppos);
> >  }
> >
> >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> >  {
> >       if (*ppos =3D=3D -2) {
> > -             *ppos =3D -1;
> > +             *ppos =3D -1; /* -1 indicates no more vmas */
> >               return NULL;
> >       }
> > -     return proc_get_vma(m->private, ppos);
> > +     return proc_get_vma(m, ppos);
> >  }
> >
> >  static void m_stop(struct seq_file *m, void *v)
> > @@ -196,7 +294,7 @@ static void m_stop(struct seq_file *m, void *v)
> >               return;
> >
> >       release_task_mempolicy(priv);
> > -     mmap_read_unlock(mm);
> > +     unlock_vma_range(priv);
> >       mmput(mm);
> >       put_task_struct(priv->task);
> >       priv->task =3D NULL;
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 5da384bd0a26..1f4f44951abe 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -309,6 +309,17 @@ void vma_mark_detached(struct vm_area_struct *vma)=
;
> >  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >                                         unsigned long address);
> >
> > +/*
> > + * Locks next vma pointed by the iterator. Confirms the locked vma has=
 not
> > + * been modified and will retry under mmap_lock protection if modifica=
tion
> > + * was detected. Should be called from read RCU section.
> > + * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR i=
f the
> > + * process was interrupted.
> > + */
> > +struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> > +                                  struct vma_iterator *iter,
> > +                                  unsigned long address);
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index a34c2c89a53b..e61e32b2cd91 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -108,7 +108,8 @@ void anon_vma_name_free(struct kref *kref)
> >
> >  struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
> >  {
> > -     mmap_assert_locked(vma->vm_mm);
> > +     if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> > +             vma_assert_locked(vma);
> >
> >       return vma->anon_name;
> >  }
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 5f725cc67334..ed0e5e2171cd 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -178,6 +178,94 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
> >       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> >       return NULL;
> >  }
> > +
> > +static struct vm_area_struct *lock_vma_under_mmap_lock(struct mm_struc=
t *mm,
> > +                                                    struct vma_iterato=
r *iter,
> > +                                                    unsigned long addr=
ess)
> > +{
> > +     struct vm_area_struct *vma;
> > +     int ret;
> > +
> > +     ret =3D mmap_read_lock_killable(mm);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     /* Lookup the vma at the last position again under mmap_read_lock=
 */
> > +     vma_iter_init(iter, mm, address);
> > +     vma =3D vma_next(iter);
> > +     if (vma)
> > +             vma_start_read_locked(vma);
> > +
> > +     mmap_read_unlock(mm);
> > +
> > +     return vma;
> > +}
> > +
> > +struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> > +                                  struct vma_iterator *iter,
> > +                                  unsigned long address)
> > +{
> > +     struct vm_area_struct *vma;
> > +     unsigned int mm_wr_seq;
> > +     bool mmap_unlocked;
> > +
> > +     RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
> > +retry:
> > +     /* Start mmap_lock speculation in case we need to verify the vma =
later */
> > +     mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
> > +     vma =3D vma_next(iter);
> > +     if (!vma)
> > +             return NULL;
> > +
> > +     vma =3D vma_start_read(mm, vma);
> > +
> > +     if (IS_ERR_OR_NULL(vma)) {
> > +             /*
> > +              * Retry immediately if the vma gets detached from under =
us.
> > +              * Infinite loop should not happen because the vma we fin=
d will
> > +              * have to be constantly knocked out from under us.
> > +              */
> > +             if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > +                     vma_iter_init(iter, mm, address);
> > +                     goto retry;
> > +             }
> > +
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Verify the vma we locked belongs to the same address space and=
 it's
> > +      * not behind of the last search position.
> > +      */
> > +     if (unlikely(vma->vm_mm !=3D mm || address >=3D vma->vm_end))
> > +             goto out_unlock;
> > +
> > +     /*
> > +      * vma can be ahead of the last search position but we need to ve=
rify
> > +      * it was not shrunk after we found it and another vma has not be=
en
> > +      * installed ahead of it. Otherwise we might observe a gap that s=
hould
> > +      * not be there.
> > +      */
> > +     if (address < vma->vm_start) {
> > +             /* Verify only if the address space might have changed si=
nce vma lookup. */
> > +             if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr=
_seq)) {
> > +                     vma_iter_init(iter, mm, address);
> > +                     if (vma !=3D vma_next(iter))
> > +                             goto out_unlock;
> > +             }
> > +     }
> > +
> > +     return vma;
> > +
> > +out_unlock:
> > +     vma_end_read(vma);
> > +out:
> > +     rcu_read_unlock();
> > +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> > +     rcu_read_lock();
> > +
> > +     return vma;
> > +}
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> >  #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >

