Return-Path: <linux-fsdevel+bounces-10508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2A84BCE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 19:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED89F1C214A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A69612E75;
	Tue,  6 Feb 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ffu3b+xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380D134AA
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244083; cv=none; b=iHWHFnWzK7dwMB/jSKLCGp9biGEktoarTyNzCpoDVJllNEkHdh8ZkedHOLavU7rXJEMkLD3MD0QN1NKfzKASnEzFI0El1K36ddPoMQhyn+WFk85tkn7AasQj4XFMrxRwJoCROm0V+grW7+N9mqpkG5CChXhwEdoitheGx0vwdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244083; c=relaxed/simple;
	bh=XHTHEUL3c1zqoIkdhMoTUTEvYUg9rrTol977ov8Dor4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDkN7xwUMBWETx5xBa+yYY6YbDcJDRsB5YgHzSSB/WI4dC3xkGjlxLa3pXBefIJfanu1dZA0HZKgBi8pclAVjBZ/a06cx5Yx08h2uuxQ6zVKDO/UrE/Q+4p/VXxMpVXTo2KECGEvzdlJxoKQD0HjwzdB7xnw2LmDfSApSPyypok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ffu3b+xg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56012eeb755so1232a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707244080; x=1707848880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mssWr8/tMwfYzRYqB7GAnBjReP7gos18KJNG0Y4GNVI=;
        b=Ffu3b+xgSQL4YWVMxwIquI/txW3BMRUO5/jdLgfhkOZ/4V03tHGZ5WSTv5JPuK9O1J
         XTsTVX+svLiCOaFYp30WGZWeSwZaqTSgahL74D3neblDb5xuFWNTEpqbN0JoRne+1OdU
         99ShoRmlgvGLynDaifqKYrj4jdEK3AAmHn1ztx6yz3NEsZvaTLAPdfBocOSTBYy/O2wP
         RkzxtZmgtodczPvTfUoYAfIR9fgoI8NiWNf1BMCZAnd4QIAXav9zxS0RFBtDQPRrrb4l
         TEyd1ENpRgu+cVNG1bO6KT6PT6V5Q0poaI/mgkHhJoYWM3dwt4iCc2R9+9TiXbESGTl9
         AFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244080; x=1707848880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mssWr8/tMwfYzRYqB7GAnBjReP7gos18KJNG0Y4GNVI=;
        b=v1R+qOZnSeRn17hy86dRLRqmGbUOjpxfbs04hGawjE5LpZxz5H0MTE+eMq9+e50aVV
         9SirFkVyEeVnvf8QDzBTWK4PDfXwYaIA7BS5cSSCQvUQIIA+iG6G2Lh6NxdhV3lY5KNY
         i+82UieodvLGdkwLBU7NNfw2xbf80KtuxB9ZcRavxuJS3JWarJgEuYM7v+RjMR+xv4cB
         WYaqzFJj4VHoogyf0zqCafGBo18+/6QpqY7dOxwwUQjd4cfnRttu37rDhXtR75trZNiL
         eKwKW4lWqyMg1IiJqvzaxs5WX9s9s1vaBZi1hV41PwGdTCPJ5W0nMz+5QgPrCUFx02q3
         Ijfg==
X-Gm-Message-State: AOJu0YzOgQz9Y2/eY82TGWMtVBRBJWMQbdiOGliKcsgtedZ/TcKuP6+4
	BYaECbw2tYKJ1EfRI0NnujQGwTXN41EqbXMLSkra0o4tFsSiqfjNrK6GFVSbobdkHOFJcvBnk/B
	/PCQeYc/nMPhruLMPppZ8KqWjGxrCBvD2HCO/
X-Google-Smtp-Source: AGHT+IGlFHjhMsclmD9laqfjKedcH6F5arabPzzT/YJDR4LP/EEGeTRmgXeW7NgKrSk3f6qUrTPuh0ae6i59DgzppUw=
X-Received: by 2002:a50:ccd6:0:b0:560:1b3:970 with SMTP id b22-20020a50ccd6000000b0056001b30970mr7470edj.7.1707244080137;
 Tue, 06 Feb 2024 10:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206010919.1109005-1-lokeshgidra@google.com> <20240206010919.1109005-4-lokeshgidra@google.com>
In-Reply-To: <20240206010919.1109005-4-lokeshgidra@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Feb 2024 19:27:22 +0100
Message-ID: <CAG48ez0AdTijvuh0xueg_spwNE9tVcPuvqT9WpvmtiNNudQFMw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com, 
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com, 
	bgeffon@google.com, willy@infradead.org, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:09=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
> All userfaultfd operations, except write-protect, opportunistically use
> per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> critical section.
>
> Write-protect operation requires mmap_lock as it iterates over multiple
> vmas.
>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
[...]
> diff --git a/mm/memory.c b/mm/memory.c
> index b05fd28dbce1..393ab3b0d6f3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[...]
> +/*
> + * lock_vma() - Lookup and lock VMA corresponding to @address.
> + * @prepare_anon: If true, then prepare the VMA (if anonymous) with anon=
_vma.
> + *
> + * Should be called without holding mmap_lock. VMA should be unlocked af=
ter use
> + * with unlock_vma().
> + *
> + * Return: A locked VMA containing @address, NULL of no VMA is found, or
> + * -ENOMEM if anon_vma couldn't be allocated.
> + */
> +struct vm_area_struct *lock_vma(struct mm_struct *mm,
> +                               unsigned long address,
> +                               bool prepare_anon)
> +{
> +       struct vm_area_struct *vma;
> +
> +       vma =3D lock_vma_under_rcu(mm, address);
> +
> +       if (vma)
> +               return vma;
> +
> +       mmap_read_lock(mm);
> +       vma =3D vma_lookup(mm, address);
> +       if (vma) {
> +               if (prepare_anon && vma_is_anonymous(vma) &&
> +                   anon_vma_prepare(vma))
> +                       vma =3D ERR_PTR(-ENOMEM);
> +               else
> +                       vma_acquire_read_lock(vma);

This new code only calls anon_vma_prepare() for VMAs where
vma_is_anonymous() is true (meaning they are private anonymous).

[...]
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 74aad0831e40..64e22e467e4f 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -19,20 +19,25 @@
>  #include <asm/tlb.h>
>  #include "internal.h"
>
> -static __always_inline
> -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> -                                   unsigned long dst_start,
> -                                   unsigned long len)
> +/* Search for VMA and make sure it is valid. */
> +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_struct *ds=
t_mm,
> +                                                   unsigned long dst_sta=
rt,
> +                                                   unsigned long len)
>  {
> -       /*
> -        * Make sure that the dst range is both valid and fully within a
> -        * single existing vma.
> -        */
>         struct vm_area_struct *dst_vma;
>
> -       dst_vma =3D find_vma(dst_mm, dst_start);
> -       if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> -               return NULL;
> +       /* Ensure anon_vma is assigned for anonymous vma */
> +       dst_vma =3D lock_vma(dst_mm, dst_start, true);

lock_vma() is now used by find_and_lock_dst_vma(), which is used by
mfill_atomic().

> +       if (!dst_vma)
> +               return ERR_PTR(-ENOENT);
> +
> +       if (PTR_ERR(dst_vma) =3D=3D -ENOMEM)
> +               return dst_vma;
> +
> +       /* Make sure that the dst range is fully within dst_vma. */
> +       if (dst_start + len > dst_vma->vm_end)
> +               goto out_unlock;
>
>         /*
>          * Check the vma is registered in uffd, this is required to
[...]
> @@ -597,7 +599,15 @@ static __always_inline ssize_t mfill_atomic(struct u=
serfaultfd_ctx *ctx,
>         copied =3D 0;
>         folio =3D NULL;
>  retry:
> -       mmap_read_lock(dst_mm);
> +       /*
> +        * Make sure the vma is not shared, that the dst range is
> +        * both valid and fully within a single existing vma.
> +        */
> +       dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len);
> +       if (IS_ERR(dst_vma)) {
> +               err =3D PTR_ERR(dst_vma);
> +               goto out;
> +       }
>
>         /*
>          * If memory mappings are changing because of non-cooperative
> @@ -609,15 +619,6 @@ static __always_inline ssize_t mfill_atomic(struct u=
serfaultfd_ctx *ctx,
>         if (atomic_read(&ctx->mmap_changing))
>                 goto out_unlock;
>
> -       /*
> -        * Make sure the vma is not shared, that the dst range is
> -        * both valid and fully within a single existing vma.
> -        */
> -       err =3D -ENOENT;
> -       dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> -       if (!dst_vma)
> -               goto out_unlock;
> -
>         err =3D -EINVAL;
>         /*
>          * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHAR=
ED but
> @@ -647,16 +648,6 @@ static __always_inline ssize_t mfill_atomic(struct u=
serfaultfd_ctx *ctx,
>             uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
>                 goto out_unlock;
>
> -       /*
> -        * Ensure the dst_vma has a anon_vma or this page
> -        * would get a NULL anon_vma when moved in the
> -        * dst_vma.
> -        */
> -       err =3D -ENOMEM;
> -       if (!(dst_vma->vm_flags & VM_SHARED) &&
> -           unlikely(anon_vma_prepare(dst_vma)))
> -               goto out_unlock;

But the check mfill_atomic() used to do was different, it checked for VM_SH=
ARED.

Each VMA has one of these three types:

1. shared (marked by VM_SHARED; does not have an anon_vma)
2. private file-backed (needs to have anon_vma when storing PTEs)
3. private anonymous (what vma_is_anonymous() detects; needs to have
anon_vma when storing PTEs)

This old code would call anon_vma_prepare() for both private VMA types
(which is correct). The new code only calls anon_vma_prepare() for
private anonymous VMAs, not for private file-backed ones. I think this
code will probably crash with a BUG_ON() in __folio_set_anon() if you
try to use userfaultfd to insert a PTE into a private file-backed VMA
of a shmem file. (Which you should be able to get by creating a file
in /dev/shm/ and then mapping that file with mmap(NULL, <size>,
PROT_READ|PROT_WRITE, MAP_PRIVATE, <fd>, 0).)

