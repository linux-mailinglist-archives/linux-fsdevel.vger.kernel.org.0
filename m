Return-Path: <linux-fsdevel+bounces-47608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4894AA10AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C08453DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21022A7F3;
	Tue, 29 Apr 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igkPu5v2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B0227EB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941205; cv=none; b=WCJc8mWrhDgO14j2MR1UkyaW5nu/tNBSPbNpmazNxSMVoGh6SxpvTkyV1lUUh7HBZBfX3f5Flu9jZ86orik1ZuQW1OvwsnMhDSvs52GEe8+2coU1NbLHh3JdAiB6hEptOIJwiZIEfkDf6kWw98m8dffQdZpwALnPeR0pYX0sx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941205; c=relaxed/simple;
	bh=m4RIdnC33T+0DzN2pkMUmi2ZJdkLEyYSorF3bzhZmQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+CClPklu3hZNfclLlxNGbLthNHasDUhGDgax0F/xWlzAhapEn9IsVgu4GEU2pkGl0L2P3I5msVkuOCs2DU/K6Ggcrp4UmdQyvB7FVSjecnEZxGkJbQpHF2Q+kQwMw9xav0veULIO/MPbHX4zqIZ07+Sc1lJpgYbIITlMVQJE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igkPu5v2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so9154a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745941202; x=1746546002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrLjz0SO4NLZaGlZgmJ5ANLBwSUMQ+H6anEYSpKzKcw=;
        b=igkPu5v2E8TpJbmhkZaYMFhSI1L7Qtv4eKmpWL0Gina+4r8Qxihkactxa3ckTeS4it
         klnhE32dMbujO+Y1KfmfAdI/redH2erF39k/0T2zCF7m3MkvGKuASkcokX3gsONoO68/
         LydkD1sZwjDOA3Myo288fcZKl32BA7nsAQGdw849qvnwfoxKWl2XKBwf1ZEEMS+1rCEH
         RQxTEkCwT10Rh2ceVGJ83RsiN8VL7N0yaJU0Z2JOERwHvrc+VmDTm6UlvuoZ5WyTyTgb
         nxQstjnbhFD+H81RHNvsjTv55sCMOuTd+eSfh+LS7BQIlxa6CmKS9VqyBsL7/8285pz9
         0Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941202; x=1746546002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrLjz0SO4NLZaGlZgmJ5ANLBwSUMQ+H6anEYSpKzKcw=;
        b=H+3LrXbOSFy006aU9dRwCeQI1Cyo3TF442LnmdeJxj2Nk7URHRUYr+1hJju0rnakhJ
         C8h2YWX1xchAG0dNWbKsHpwpyck+njnkDV3llmnS6HfwOvE5ppbEjJLGAu6XVmXi6+cj
         x8Rw3eU+g2GsWgw3XZDBmiZkkIAmoPjSL/rrhVofXcsY6yov2mHBFXAxsmTEgnWdEhsw
         C4MOZgvX2iJwkraC4/8JS4ck9eH2vZif3ednl/mx8VINQJqSliR2+dT9WHtZxIwnhbhF
         HKFEhY3DJ34A5e0kdSoul1P0W2wewZhMuUu95j67FAy1RTaEKE+zEoyk5upVawZYQrYe
         vRxA==
X-Forwarded-Encrypted: i=1; AJvYcCUaQFes3CiKQn7to58WcO7902K10xDnaBAnftuqorL8xepXZ8qx6rM0YyiroboODJ6YuceuevL2BOqkL6aU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zytOHZZmZvkCW/QPTSKjyROZ/yLWVDQkkK7RRFt0gk41S4GP
	U3qOmEuIsCrDSWJDqmxGjolmBuiglYXWk392kQQ4RQSprhkZUEADIprBb3AUPN/H5nvmV55DOab
	m/5KvuCMBUXG1xkgKawL1WlUnRDarBj+07Ap0w4uXIQyBPOpw5Y47o7M=
X-Gm-Gg: ASbGncvEQhYR18c+dQEsCicAyI0siMPJVuS1b/dZuFqaNn55OUX7cGL+NczvTfkKXTn
	Q9B9Sd+QuCMCEo3k4NLV2GitVbfvgLOfXswnyvUF01Ca1j2p2/NR7bysGe4+Ruz+upEp60czNSX
	7ZxXzLiJH9gn4C9iyGD+2vhK+G8UOCB4jd/ZJzSpLsIMzzy2Mv/w==
X-Google-Smtp-Source: AGHT+IGTmRrDj58386rjJZziDq63lizkFMzj1lu/PM65c5dMEelMGMumc3qFR5YFmPkjXr20u694i69kdm2X64XfN50=
X-Received: by 2002:a50:8713:0:b0:5de:bcd9:4aa with SMTP id
 4fb4d7f45d1cf-5f83c1b5a2bmr96410a12.3.1745941201725; Tue, 29 Apr 2025
 08:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
In-Reply-To: <20250418174959.1431962-8-surenb@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Apr 2025 17:39:25 +0200
X-Gm-Features: ATxdqUE5eaCYmwGd2V3bpxMHfmJQqwTFsFKw7F4dJMhdfNXiMK8VuoXSkdfNDiE
Message-ID: <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Suren Baghdasaryan <surenb@google.com>, Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, josef@toxicpanda.com, 
	yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org, 
	osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 7:50=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> With maple_tree supporting vma tree traversal under RCU and vma and
> its important members being RCU-safe, /proc/pid/maps can be read under
> RCU and without the need to read-lock mmap_lock. However vma content
> can change from under us, therefore we make a copy of the vma and we
> pin pointer fields used when generating the output (currently only
> vm_file and anon_name). Afterwards we check for concurrent address
> space modifications, wait for them to end and retry. While we take
> the mmap_lock for reading during such contention, we do that momentarily
> only to record new mm_wr_seq counter. This change is designed to reduce
> mmap_lock contention and prevent a process reading /proc/pid/maps files
> (often a low priority task, such as monitoring/data collection services)
> from blocking address space updates.
[...]
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index b9e4fbbdf6e6..f9d50a61167c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
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

I think this uses get_file_rcu() in a different way than intended.

As I understand it, get_file_rcu() is supposed to be called on a
pointer which always points to a file with a non-zero refcount (except
when it is NULL). That's why it takes a file** instead of a file* - if
it observes a zero refcount, it assumes that the pointer must have
been updated in the meantime, and retries. Calling get_file_rcu() on a
pointer that points to a file with zero refcount, which I think can
happen with this patch, will cause an endless loop.
(Just as background: For other usecases, get_file_rcu() is supposed to
still behave nicely and not spuriously return NULL when the file* is
concurrently updated to point to another file*; that's what that loop
is for.)
(If my understanding is correct, maybe we should document that more
explicitly...)

Also, I think you are introducing an implicit assumption that
remove_vma() does not NULL out the ->vm_file pointer (because that
could cause tearing and could theoretically lead to a torn pointer
being accessed here).

One alternative might be to change the paths that drop references to
vma->vm_file (search for vma_close to find them) such that they first
NULL out ->vm_file with a WRITE_ONCE() and do the fput() after that,
maybe with a new helper like this:

static void vma_fput(struct vm_area_struct *vma)
{
  struct file *file =3D vma->vm_file;

  if (file) {
    WRITE_ONCE(vma->vm_file, NULL);
    fput(file);
  }
}

Then on the lockless lookup path you could use get_file_rcu() on the
->vm_file pointer _of the original VMA_, and store the returned file*
into copy->vm_file.

> +       if (!anon_vma_name_get_if_valid(copy))
> +               goto put_file;
> +
> +       if (!mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq))
> +               return 0;

We only check for concurrent updates at this point, so up to here,
anything we read from "copy" could contain torn pointers (both because
memcpy() is not guaranteed to copy pointers atomically and because the
updates to the original VMA are not done with WRITE_ONCE()).
That probably means that something like the preceding
anon_vma_name_get_if_valid() could crash on an access to a torn
pointer.
Please either do another mmap_lock_speculate_retry() check directly
after the memcpy(), or ensure nothing before this point reads from
"copy".

> +       /* Address space got modified, vma might be stale. Re-lock and re=
try. */
> +       rcu_read_unlock();
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
[...]
> @@ -266,39 +399,41 @@ static void get_vma_name(struct vm_area_struct *vma=
,
>                 } else {
>                         *path =3D file_user_path(vma->vm_file);
>                 }
> -               return;
> +               goto out;
>         }
>
>         if (vma->vm_ops && vma->vm_ops->name) {
>                 *name =3D vma->vm_ops->name(vma);

This seems to me like a big, subtle change of semantics. After this
change, vm_ops->name() will no longer receive a real VMA; and in
particular, I think the .name implementation special_mapping_name used
in special_mapping_vmops will have a UAF because it relies on
vma->vm_private_data pointing to a live object.

I think you'll need to fall back to using the mmap lock and the real
VMA if you see a non-NULL vma->vm_ops->name pointer.

>                 if (*name)
> -                       return;
> +                       goto out;
>         }
>
>         *name =3D arch_vma_name(vma);
>         if (*name)
> -               return;
> +               goto out;
>
>         if (!vma->vm_mm) {
>                 *name =3D "[vdso]";
> -               return;
> +               goto out;
>         }
>
>         if (vma_is_initial_heap(vma)) {
>                 *name =3D "[heap]";
> -               return;
> +               goto out;
>         }
>
>         if (vma_is_initial_stack(vma)) {
>                 *name =3D "[stack]";
> -               return;
> +               goto out;
>         }
>
>         if (anon_name) {
>                 *name_fmt =3D "[anon:%s]";
>                 *name =3D anon_name->name;
> -               return;
>         }
> +out:
> +       if (anon_name && !mmap_locked)
> +               anon_vma_name_put(anon_name);

Isn't this refcount drop too early, causing UAF read? We drop the
reference on the anon_name here, but (on some paths) we're about to
return anon_name->name to the caller through *name, and the caller
will read from it.

Ah, but I guess it's actually fine because the refcount increment was
unnecessary in the first place, because the vma pointer actually
points to a copy of the original VMA, and the copy has its own
refcounted reference to the anon_name thanks to get_vma_snapshot()?
It might be helpful to have some comments documenting which VMA
pointers can point to copies.

