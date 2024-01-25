Return-Path: <linux-fsdevel+bounces-9010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C514083CEAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 22:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D0C2921B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835613A27C;
	Thu, 25 Jan 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srzbOUGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D713A26D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218315; cv=none; b=uH3Z8C/Pwh4+283YpYsQ1P0ng9ORXxqP944B//OH2RkBjrq6bNzUBpT73PTFtCTBpioGNgV3NxreNyZGC2GFXgC4YtlfN7LbRxReDoLOusvGseY2fKOw0cN9sk0BOEMN1NLdVAjhLFdAyefITHIMb/OGZGaKcsbuZHcCLsEYJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218315; c=relaxed/simple;
	bh=1bwMv1tBPDePDj2+jGs24r4q5thTXKItthHgYw29SeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBiDzO3YY3LJYSNWJ2vIUkA/SCcyKnabGKaxkCbMnp6iF9ThDqstrW3pUmBKx5Z8hZMRnXLcmPGswTKW2pHu7+Iqr3HzWaaeE5e+XQ6jWQuafwV7VD+7Qn6DvtkXkRASQ9pOyyxJ22kJRo0aBfWW8FhmP2/J4nxkShET+/DsQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srzbOUGd; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc227feab99so7015668276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 13:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706218313; x=1706823113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zla3H72Ilwvo/eWpxYhoN+6CJQRd1jb7Ae4lq+rRb1c=;
        b=srzbOUGdQg5VSujRqo2VGtg0Zi+yfRnshYAdZ0cWXMfgAzCY5fvat2LA4VpSyQpxCW
         vLeqIH9e3AorTTmczudldLPYMo1htufRnDEpMvK0WP5Kps9G8eXAlphn7s9XG7mY9nFy
         vlDSxQjSAiecH5htNUVA5yYk9NKzHDh7TVwkOjjkSkHWkn2aaVR/yD5PVjv/xj6rcVSZ
         iP8zk+fhuD/tHZa+ln71l4jxnvhfnMLsMQJdyIRnMxLzHUdFcuHIK/+tfQ0AgyBv3iWo
         c7s0Hytt8a8J4YPwLs+pgGR5xFVO4G3FsaTxLBPOOJZnN77FpzxHpzYYkt6ztujPnJ5Z
         fnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706218313; x=1706823113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zla3H72Ilwvo/eWpxYhoN+6CJQRd1jb7Ae4lq+rRb1c=;
        b=VziGky2Z436Ci2Bp90yCDKtJ18Cq8hI5PZMYXp9Ci3ErRWUhquZ3ePEb+eNzPie9Xb
         tv5DJhhL9KUq4GyxE9QuPgLehdlMiMY+dDIsVGyFoJcV3E58i8UYyP7yKZfJkHXm3hnY
         MILMRODpGmiypUs+M5ru+uL3LelUDDIn6BErS3VvYcp1NTv37N4GZcfVbOC4MNUGsGYn
         /V6xaQdSuILiW2dR0ailPrnLExTsn+4PtsTbqmiSPMIExolLqqXxEwc8UWMN8KL+EuYH
         RUId+y89N51MCefZzHHMtVc3/F8UoAi0efB9PhqNGuQ+CDKsjpxC7TJj9TEVaT1Xd6BM
         +6UA==
X-Gm-Message-State: AOJu0Yw7buBkLKu1F0Ek0s4oNeZVTNwU3ayAZr5UJ2VBlPaGFo1SvN92
	tf4Q0dwl6fo6x5+j9hjewY+7N16R5N4GK55vZyytG/mjZSj4CKNc5aAmFz7UpVOE9xtwIYH9qQl
	NbIXmzaB4pVi6i9YRhhFJu/Ijz6DEtNhk9wBd
X-Google-Smtp-Source: AGHT+IGXm6ZV7XipOpIRJJkQ3M5Lk73qTFNsJKi41d/hkr6pxGn4JRC7wlmQvXAm/UpfGcKzyqbwuqpqleP8yOj0aPs=
X-Received: by 2002:a25:2b43:0:b0:dbe:a31e:712a with SMTP id
 r64-20020a252b43000000b00dbea31e712amr441292ybr.109.1706218312759; Thu, 25
 Jan 2024 13:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123231014.3801041-1-surenb@google.com> <20240123231014.3801041-3-surenb@google.com>
In-Reply-To: <20240123231014.3801041-3-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Jan 2024 13:31:41 -0800
Message-ID: <CAJuCfpGCxaGuhufCz+_cmND=A6_Y2tC=NdTmaokC8TjL_Gz+kA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm/maps: read proc/pid/maps under RCU
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, sj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:10=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> With maple_tree supporting vma tree traversal under RCU and per-vma locks
> making vma access RCU-safe, /proc/pid/maps can be read under RCU and
> without the need to read-lock mmap_lock. However vma content can change
> from under us, therefore we make a copy of the vma and we pin pointer
> fields used when generating the output (currently only vm_file and
> anon_name). Afterwards we check for concurrent address space
> modifications, wait for them to end and retry. That last check is needed
> to avoid possibility of missing a vma during concurrent maple_tree
> node replacement, which might report a NULL when a vma is replaced
> with another one. While we take the mmap_lock for reading during such
> contention, we do that momentarily only to record new mm_wr_seq counter.
> This change is designed to reduce mmap_lock contention and prevent a
> process reading /proc/pid/maps files (often a low priority task, such as
> monitoring/data collection services) from blocking address space updates.
>
> Note that this change has a userspace visible disadvantage: it allows for
> sub-page data tearing as opposed to the previous mechanism where data
> tearing could happen only between pages of generated output data.
> Since current userspace considers data tearing between pages to be
> acceptable, we assume is will be able to handle sub-page data tearing
> as well.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Changes since v1 [1]:
> - Fixed CONFIG_ANON_VMA_NAME=3Dn build by introducing
> anon_vma_name_{get|put}_if_valid, per SeongJae Park
> - Fixed misspelling of get_vma_snapshot()
>
> [1] https://lore.kernel.org/all/20240122071324.2099712-3-surenb@google.co=
m/
>
>  fs/proc/internal.h        |   2 +
>  fs/proc/task_mmu.c        | 113 +++++++++++++++++++++++++++++++++++---
>  include/linux/mm_inline.h |  18 ++++++
>  3 files changed, 126 insertions(+), 7 deletions(-)
>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index a71ac5379584..e0247225bb68 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -290,6 +290,8 @@ struct proc_maps_private {
>         struct task_struct *task;
>         struct mm_struct *mm;
>         struct vma_iterator iter;
> +       unsigned long mm_wr_seq;
> +       struct vm_area_struct vma_copy;
>  #ifdef CONFIG_NUMA
>         struct mempolicy *task_mempolicy;
>  #endif
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3f78ebbb795f..0d5a515156ee 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -126,11 +126,95 @@ static void release_task_mempolicy(struct proc_maps=
_private *priv)
>  }
>  #endif
>
> -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *pri=
v,
> -                                               loff_t *ppos)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static const struct seq_operations proc_pid_maps_op;
> +
> +/*
> + * Take VMA snapshot and pin vm_file and anon_name as they are used by
> + * show_map_vma.
> + */
> +static int get_vma_snapshot(struct proc_maps_private *priv, struct vm_ar=
ea_struct *vma)
> +{
> +       struct vm_area_struct *copy =3D &priv->vma_copy;
> +       int ret =3D -EAGAIN;
> +
> +       memcpy(copy, vma, sizeof(*vma));
> +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))

There is a problem in this patchset. I assumed that get_file_rcu() can
be used against vma->vm_file but that's not true. vma->vm_file is
freed via a call to fput() which schedules its freeing using
schedule_delayed_work(..., 1) but I don't think that constitutes RCU
grace period, so it can be freed from under us.
Andrew, could you please remove this patchset from your tree until I
sort this out?
Thanks,
Suren.

> +               goto out;
> +
> +       if (!anon_vma_name_get_if_valid(copy))
> +               goto put_file;
> +
> +       if (priv->mm_wr_seq =3D=3D mmap_write_seq_read(priv->mm))
> +               return 0;
> +
> +       /* Address space got modified, vma might be stale. Wait and retry=
. */
> +       rcu_read_unlock();
> +       ret =3D mmap_read_lock_killable(priv->mm);
> +       mmap_write_seq_record(priv->mm, &priv->mm_wr_seq);
> +       mmap_read_unlock(priv->mm);
> +       rcu_read_lock();
> +
> +       if (!ret)
> +               ret =3D -EAGAIN; /* no other errors, ok to retry */
> +
> +       anon_vma_name_put_if_valid(copy);
> +put_file:
> +       if (copy->vm_file)
> +               fput(copy->vm_file);
> +out:
> +       return ret;
> +}
> +
> +static void put_vma_snapshot(struct proc_maps_private *priv)
> +{
> +       struct vm_area_struct *vma =3D &priv->vma_copy;
> +
> +       anon_vma_name_put_if_valid(vma);
> +       if (vma->vm_file)
> +               fput(vma->vm_file);
> +}
> +
> +static inline bool needs_mmap_lock(struct seq_file *m)
> +{
> +       /*
> +        * smaps and numa_maps perform page table walk, therefore require
> +        * mmap_lock but maps can be read under RCU.
> +        */
> +       return m->op !=3D &proc_pid_maps_op;
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */
> +
> +/* Without per-vma locks VMA access is not RCU-safe */
> +static inline bool needs_mmap_lock(struct seq_file *m) { return true; }
> +
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
> +static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *p=
pos)
>  {
> +       struct proc_maps_private *priv =3D m->private;
>         struct vm_area_struct *vma =3D vma_next(&priv->iter);
>
> +#ifdef CONFIG_PER_VMA_LOCK
> +       if (vma && !needs_mmap_lock(m)) {
> +               int ret;
> +
> +               put_vma_snapshot(priv);
> +               while ((ret =3D get_vma_snapshot(priv, vma)) =3D=3D -EAGA=
IN) {
> +                       /* lookup the vma at the last position again */
> +                       vma_iter_init(&priv->iter, priv->mm, *ppos);
> +                       vma =3D vma_next(&priv->iter);
> +               }
> +
> +               if (ret) {
> +                       put_vma_snapshot(priv);
> +                       return NULL;
> +               }
> +               vma =3D &priv->vma_copy;
> +       }
> +#endif
>         if (vma) {
>                 *ppos =3D vma->vm_start;
>         } else {
> @@ -169,12 +253,20 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
>                 return ERR_PTR(-EINTR);
>         }
>
> +       /* Drop mmap_lock if possible */
> +       if (!needs_mmap_lock(m)) {
> +               mmap_write_seq_record(priv->mm, &priv->mm_wr_seq);
> +               mmap_read_unlock(priv->mm);
> +               rcu_read_lock();
> +               memset(&priv->vma_copy, 0, sizeof(priv->vma_copy));
> +       }
> +
>         vma_iter_init(&priv->iter, mm, last_addr);
>         hold_task_mempolicy(priv);
>         if (last_addr =3D=3D -2UL)
>                 return get_gate_vma(mm);
>
> -       return proc_get_vma(priv, ppos);
> +       return proc_get_vma(m, ppos);
>  }
>
>  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> @@ -183,7 +275,7 @@ static void *m_next(struct seq_file *m, void *v, loff=
_t *ppos)
>                 *ppos =3D -1UL;
>                 return NULL;
>         }
> -       return proc_get_vma(m->private, ppos);
> +       return proc_get_vma(m, ppos);
>  }
>
>  static void m_stop(struct seq_file *m, void *v)
> @@ -195,7 +287,10 @@ static void m_stop(struct seq_file *m, void *v)
>                 return;
>
>         release_task_mempolicy(priv);
> -       mmap_read_unlock(mm);
> +       if (needs_mmap_lock(m))
> +               mmap_read_unlock(mm);
> +       else
> +               rcu_read_unlock();
>         mmput(mm);
>         put_task_struct(priv->task);
>         priv->task =3D NULL;
> @@ -283,8 +378,10 @@ show_map_vma(struct seq_file *m, struct vm_area_stru=
ct *vma)
>         start =3D vma->vm_start;
>         end =3D vma->vm_end;
>         show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
> -       if (mm)
> -               anon_name =3D anon_vma_name(vma);
> +       if (mm) {
> +               anon_name =3D needs_mmap_lock(m) ? anon_vma_name(vma) :
> +                               anon_vma_name_get_rcu(vma);
> +       }
>
>         /*
>          * Print the dentry name for named mappings, and a
> @@ -338,6 +435,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struc=
t *vma)
>                 seq_puts(m, name);
>         }
>         seq_putc(m, '\n');
> +       if (anon_name && !needs_mmap_lock(m))
> +               anon_vma_name_put(anon_name);
>  }
>
>  static int show_map(struct seq_file *m, void *v)
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index bbdb0ca857f1..a4a644fe005e 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -413,6 +413,21 @@ static inline bool anon_vma_name_eq(struct anon_vma_=
name *anon_name1,
>
>  struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma);
>
> +/*
> + * Takes a reference if anon_vma is valid and stable (has references).
> + * Fails only if anon_vma is valid but we failed to get a reference.
> + */
> +static inline bool anon_vma_name_get_if_valid(struct vm_area_struct *vma=
)
> +{
> +       return !vma->anon_name || anon_vma_name_get_rcu(vma);
> +}
> +
> +static inline void anon_vma_name_put_if_valid(struct vm_area_struct *vma=
)
> +{
> +       if (vma->anon_name)
> +               anon_vma_name_put(vma->anon_name);
> +}
> +
>  #else /* CONFIG_ANON_VMA_NAME */
>  static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
>  static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
> @@ -432,6 +447,9 @@ struct anon_vma_name *anon_vma_name_get_rcu(struct vm=
_area_struct *vma)
>         return NULL;
>  }
>
> +static inline bool anon_vma_name_get_if_valid(struct vm_area_struct *vma=
) { return true; }
> +static inline void anon_vma_name_put_if_valid(struct vm_area_struct *vma=
) {}
> +
>  #endif  /* CONFIG_ANON_VMA_NAME */
>
>  static inline void init_tlb_flush_pending(struct mm_struct *mm)
> --
> 2.43.0.429.g432eaa2c6b-goog
>

