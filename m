Return-Path: <linux-fsdevel+bounces-47005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB38A97AA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 00:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB365A1069
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840C2C257B;
	Tue, 22 Apr 2025 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR6vj2B/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EC1F09B1;
	Tue, 22 Apr 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362147; cv=none; b=NQbka/QPKek0aDXTfom+aaQOk0p2SfGtee26ECeY+eL6Rww8If6NT16Zv6Jiqors+2zrA1axF8qDnS1ayGkOgDR5yGPXOvHheccimszCS9q1eVO8S+1MNXSccVR4Rp06b5fMPaIFG3piZfFzRcJOykJgbevK2fNkuodrkuUDwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362147; c=relaxed/simple;
	bh=BTr87Fgzo1JalzQRSpB9bFJSGNfR8KB/0vLhjYFtx24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHfFV5D1B3cD6K2MjsQf5eZ31P4mRYGRUUl8BfO27PCgCa6tB0spzxu3SZhk2UYchQ5Twc8v2SrsbdIYj4RIuRFdzm4IdLipY5a3vFaGZjbmQLNIPSHBr3wvaKpvlIvwVpAxw0VH/D9scxa/OlxLAz7m+I/sfFShwPhld6ZXi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR6vj2B/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b03bc416962so4170962a12.0;
        Tue, 22 Apr 2025 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362145; x=1745966945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b87Z6hdoHcNORRcYRXz71HmcfEiLW2krrwaT/icFFxI=;
        b=PR6vj2B/HibkDrY0vvArdNEecpcEJv0Qc6WnJWq5Y4J0Mnzz1LjRSRUMLJwPXNFETd
         Yt/HtBGsEx+T4SDnPuf9yZoVoNhrXi2bMJv0gE/hSV4aW3Fkct6Px0AWBbrNpBsCXPUk
         hjvQD7HdmHMyCWCfDPaklL+dUGDyXi4ATMfBZrhMVxaR1Bs4MqTA1Qm/Ng53N2cHXm4t
         0UBD9RvKxmy5lBd8FBnQUhD6brd7qyXl7AKku02GejOmEMLtz9csxRk8H4Mu6SeQoYnM
         pzNtDprzlJ+QZnS0N5sRIEykkhZbCtTcBIMp9VPhj/HWzZR985e/fyClQVOIUpMLoT8T
         hOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362145; x=1745966945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b87Z6hdoHcNORRcYRXz71HmcfEiLW2krrwaT/icFFxI=;
        b=wq0dl2zphv9cnteOWp002XJy0DgcLnxKpF88tUHxCFWSoYk366agi5WY0mUYwdzeOE
         F+6nWgYryee7+icxgRUhnfvKnBQAtQP/rPCb+q7UHfFBQRbJMtL3bcUVndSh9XSngawy
         KEKuQ7TtyqGUKQ2zufGxf4dm5h3awPwg9zMCU5RcOBiVkNpLTv3gk/TjQNDvBJlj+9ss
         zwsZz1QBxWshXY8dxFoX9FP9eu9VmqNgYL05Q9IpWgsN+d8ov3/pYCZccnX3bYLRoXnB
         MH4dY3c/Iy+fOvWdCzhQ1LpAAlteNrAubMlCqrD1PTibalFG4xdsmv6CMxMagY2ZOYuw
         ookQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHq6epSRXTOAC2Bu2zpAmOmQ7agaBTXjujR49/vtCXUaAT7+PSlFZPrbIyLRe3XxF+ODpe8Wyv/sNo9EehwL/w@vger.kernel.org, AJvYcCUJul5zE+yct07rsNZZmijEhIWdqDFIykimyIn0ak2UeVtDkB9NFNa2uf6vvxBJWtYWvsk39/k6zRt1U+c6@vger.kernel.org, AJvYcCV6EJ3BMgY15k4DPd6ivPPX+qumyJIq1An2dUqkt+Tjs0HsLMXSre6t88qrSv4xkAN59kKuTaJAK+qRLzVH@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbddjwI9xczcODCPVkHoaKFUtF7U6WPKoVu6FpFvmbqn27OXn
	UbqHQyP3qzurBMxIoID6Mqh1upMmr41VxW89s/zLPApAPkr8JM01QvubpGhkVTpnXUCEdp1Au3Q
	Lf97c3Fvj+2ldwYruTIoRdUa/JJY=
X-Gm-Gg: ASbGncsTLN80StHLujhydEDDuKlXAYaFk9fpd+fE5ODM7VNrOgr9PAhK1FCZcPJo6e3
	wNl9lmi9yupvY7UMPQmX2ei6vwGl/krZw5dctluAeklaFExXwpsuRQjWbHyodNta3c33wWdvIZ6
	isMnLaKgbOeKldAMAj9WqAHvvVvXYkkXszKmUp4A==
X-Google-Smtp-Source: AGHT+IEaXVqyjeo1USfmvtnc/v5tnImw/+t4sFUD76JPWeBRBPX+uZBJiLyql0KdJsA4I9vGgTzuEP00QGXPqvZHShw=
X-Received: by 2002:a17:90b:4ecf:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-3087bccc3a5mr24129038a91.35.1745362144838; Tue, 22 Apr 2025
 15:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
In-Reply-To: <20250418174959.1431962-8-surenb@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 15:48:52 -0700
X-Gm-Features: ATxdqUG4dz3OGN13sHC4CHKb-O7jfQGss6KMOy-5UBi2V9AZVLsJCVhdcja1Qzc
Message-ID: <CAEf4BzYuA3ZRCwPsAxhQZDOOpjSTrphKEsgPAqgRP8Ly7+fTWw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> With maple_tree supporting vma tree traversal under RCU and vma and
> its important members being RCU-safe, /proc/pid/maps can be read under
> RCU and without the need to read-lock mmap_lock. However vma content
> can change from under us, therefore we make a copy of the vma and we
> pin pointer fields used when generating the output (currently only
> vm_file and anon_name). Afterwards we check for concurrent address
> space modifications, wait for them to end and retry. While we take
> the mmap_lock for reading during such contention, we do that momentarily
> only to record new mm_wr_seq counter. This change is designed to reduce

This is probably a stupid question, but why do we need to take a lock
just to record this counter? uprobes get away without taking mmap_lock
even for reads, and still record this seq counter. And then detect
whether there were any modifications in between. Why does this change
need more heavy-weight mmap_read_lock to do speculative reads?

> mmap_lock contention and prevent a process reading /proc/pid/maps files
> (often a low priority task, such as monitoring/data collection services)
> from blocking address space updates.
> Note that this change has a userspace visible disadvantage: it allows
> for sub-page data tearing as opposed to the previous mechanism where
> data tearing could happen only between pages of generated output data.
> Since current userspace considers data tearing between pages to be
> acceptable, we assume is will be able to handle sub-page data tearing
> as well.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/internal.h        |   6 ++
>  fs/proc/task_mmu.c        | 170 ++++++++++++++++++++++++++++++++++----
>  include/linux/mm_inline.h |  18 ++++
>  3 files changed, 177 insertions(+), 17 deletions(-)
>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 96122e91c645..6e1169c1f4df 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -379,6 +379,12 @@ struct proc_maps_private {
>         struct task_struct *task;
>         struct mm_struct *mm;
>         struct vma_iterator iter;
> +       bool mmap_locked;
> +       loff_t last_pos;
> +#ifdef CONFIG_PER_VMA_LOCK
> +       unsigned int mm_wr_seq;
> +       struct vm_area_struct vma_copy;
> +#endif
>  #ifdef CONFIG_NUMA
>         struct mempolicy *task_mempolicy;
>  #endif
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index b9e4fbbdf6e6..f9d50a61167c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -127,13 +127,130 @@ static void release_task_mempolicy(struct proc_map=
s_private *priv)
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
> +               goto out;
> +
> +       if (!anon_vma_name_get_if_valid(copy))
> +               goto put_file;

Given vm_file and anon_vma_name are both RCU-protected, if we take
rcu_read_lock() at m_start/m_next before fetching VMA, we shouldn't
even need getting/putting them, no?

I feel like I'm missing some important limitations, but I don't think
they are spelled out explicitly...

> +
> +       if (!mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq))
> +               return 0;
> +
> +       /* Address space got modified, vma might be stale. Re-lock and re=
try. */
> +       rcu_read_unlock();

Another question I have is whether we really need to copy vma into
priv->vma_copy to have a stable snapshot? Can't we just speculate like
with uprobes under assumption that data doesn't change. And once we
are done producing text output, confirm that speculation was
successful, and if not - retry?

We'd need an API for seq_file to rollback to previous good known
location for that, but that seems straightforward enough to do, no?
Just remember buffer position before speculation, write data, check
for no mm modifications, and if something changed, rollback seq file
to last position.


> +       ret =3D mmap_read_lock_killable(priv->mm);
> +       if (!ret) {
> +               /* mmap_lock_speculate_try_begin() succeeds when holding =
mmap_read_lock */
> +               mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq)=
;
> +               mmap_read_unlock(priv->mm);
> +               ret =3D -EAGAIN;
> +       }
> +
> +       rcu_read_lock();
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

[...]

