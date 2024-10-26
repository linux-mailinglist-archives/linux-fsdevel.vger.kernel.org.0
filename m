Return-Path: <linux-fsdevel+bounces-32997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C19B1462
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 05:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744092834A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 03:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7215C147;
	Sat, 26 Oct 2024 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aj7zOPKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053B7081D
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2024 03:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729914979; cv=none; b=bKpBznR1kL6z3KQ29iq8zWhv53l4Uq5Dw35BFXYaw9yr2FcDU8aoIItCtGJZ7oI9aRsPm1wRDMODN7lgs1flPM9wtHPNLc5HqALFf/fnOwGebvUjxKhOG0Ynjbzq48zeOm2zAutoxhSeVjM+gSOtCatKbnG0TlC7jGPsM1OVxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729914979; c=relaxed/simple;
	bh=3oM9WEdtQNIO693hFjB/zmcwWdvOBl5ifNMyfJw9/PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3ekhOMaqGyszSi/p8UzE899Yd3EOOVP/5jvhJMY+Fxr+S2cZpeLsv2y6gato+Ha3IMBq472tANvXvhtmGVlKhzxneo11kXZk2h+ygl9gTybV5a1pTVXF7t5x1tuoxijPYdH2/ttsQkcG7IHppeQM+oqGjZ4KCfq0zsmsbQrj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aj7zOPKk; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fd01c9defso854021241.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729914975; x=1730519775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WKjNsNyT0ruYn6UVMVJ1RKIZyXTRYpCy6zMhmlf4JA=;
        b=aj7zOPKkgQn0mO3ApOxP99muVIOVBXhDjDjRPpbaF/I0axfRacn+npZNNkRs4SEdG4
         3+tqU3XspleGZtVhpuzHrFxyMTmzeR++WFu0tD666dB0cHGhU5SaXG0k37dUTfdp0gjQ
         whDoKCJHisoplt6JN5HiMIEKPkEJ4si8B/NlzkyTCUN7f7EQ1rDe+5tdw8LZjQ7vMlV5
         /ukv9yf1odGDGJup++SpOs1A8rG87PYFqZVYXVOj6mh10Fju1dkgObA79JKAfzwsGDrr
         fjL8VecpGCbfg4Mcur9ihlnr/qKLLrVkGxtgcqzIlkH7niINDZSGBRZFkNLn8c6KpNXh
         QJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729914975; x=1730519775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WKjNsNyT0ruYn6UVMVJ1RKIZyXTRYpCy6zMhmlf4JA=;
        b=L2USRnJDdPnY++tV+CXV0HlItMBbADdmcirGAQhS1Ns/WgTTWRovaPFCd3CRFx1NdJ
         V/FJSa4Mf1MEdYCwjxK/+FNuKzNPYtJvYfJanESnE3Lz4q/PKdCfVKt2WRPZsaI9X6NI
         mmjw9oxsX5JT08qcYVwm03dRS19uEiWDrbBZwTXKm03CZvAqsXYIZQpeEyWx9u7/w1QU
         Gpfi5LCxRKWQtVOA3pVxKnWh4HNuK+PzXY3QbdX3maYoSO3GRkcVLSViIMLC1uq5+OVg
         pw3FYu9NUnd+UOujwt9RKWzPSXHZlGO2ZIfQbRwb/m89txQCq5u+oHNcZeDpz0fx/JkT
         1FWg==
X-Forwarded-Encrypted: i=1; AJvYcCVnC3IeuFV7I0nkEm1R5xh3AfDIlVwcD34jCPIpR0AzTy2wwZCz+3EjBXPuC3HZGBBDZ2+eJBcXUg/ABcLH@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7UVRJlfe4t3T9+tdXnVkUI8xfknayxK7cjRJh2bRPUo//BVh
	d1nLZPRF0te6J79Bw/uEEVzsoonmVBFxVCOk+yjFnb9VsZZoevqmhuuY5dvVwusP+chiV0yc/pO
	BfUKR+DvXLqU3NPdDR4eNVVItZz/+9ScJGvbf
X-Google-Smtp-Source: AGHT+IGHNioCV05B550z2HqdgbUh0S/Q4eiZK4coivQy8ntPYu+GO8YLiwCo3H1KXVMRJGwT6JD11juuGsuy611LTeQ=
X-Received: by 2002:a05:6102:32d2:b0:4a4:7980:b9c7 with SMTP id
 ada2fe7eead31-4a8cfb83109mr1334887137.14.1729914975276; Fri, 25 Oct 2024
 20:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev> <20241025012304.2473312-6-shakeel.butt@linux.dev>
In-Reply-To: <20241025012304.2473312-6-shakeel.butt@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 25 Oct 2024 21:55:38 -0600
Message-ID: <CAOUHufYCPkUH0ysujoXZaw3PSrPvaw356-Pb97=LPGVRu_7FNQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 7:23=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> While updating the generation of the folios, MGLRU requires that the
> folio's memcg association remains stable. With the charge migration
> deprecated, there is no need for MGLRU to acquire locks to keep the
> folio and memcg association stable.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/vmscan.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 29c098790b01..fd7171658b63 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3662,10 +3662,6 @@ static void walk_mm(struct mm_struct *mm, struct l=
ru_gen_mm_walk *walk)
>                 if (walk->seq !=3D max_seq)
>                         break;

Please remove the lingering `struct mem_cgroup *memcg` as well as
folio_memcg_rcu(). Otherwise it causes both build and lockdep
warnings.

> -               /* folio_update_gen() requires stable folio_memcg() */
> -               if (!mem_cgroup_trylock_pages(memcg))
> -                       break;
> -
>                 /* the caller might be holding the lock for write */
>                 if (mmap_read_trylock(mm)) {
>                         err =3D walk_page_range(mm, walk->next_addr, ULON=
G_MAX, &mm_walk_ops, walk);
> @@ -3673,8 +3669,6 @@ static void walk_mm(struct mm_struct *mm, struct lr=
u_gen_mm_walk *walk)
>                         mmap_read_unlock(mm);
>                 }
>
> -               mem_cgroup_unlock_pages();
> -
>                 if (walk->batched) {
>                         spin_lock_irq(&lruvec->lru_lock);
>                         reset_batch_size(walk);
> @@ -4096,10 +4090,6 @@ bool lru_gen_look_around(struct page_vma_mapped_wa=
lk *pvmw)
>                 }
>         }
>
> -       /* folio_update_gen() requires stable folio_memcg() */
> -       if (!mem_cgroup_trylock_pages(memcg))
> -               return true;
> -
>         arch_enter_lazy_mmu_mode();
>
>         pte -=3D (addr - start) / PAGE_SIZE;
> @@ -4144,7 +4134,6 @@ bool lru_gen_look_around(struct page_vma_mapped_wal=
k *pvmw)
>         }
>
>         arch_leave_lazy_mmu_mode();
> -       mem_cgroup_unlock_pages();
>
>         /* feedback from rmap walkers to page table walkers */
>         if (mm_state && suitable_to_scan(i, young))
> --
> 2.43.5
>
>

