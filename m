Return-Path: <linux-fsdevel+bounces-21074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6068FDA38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF611F25214
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D0168C07;
	Wed,  5 Jun 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0axwYly0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D15146599
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629376; cv=none; b=QlYdEkuVOZxQ7XrCtt11bwet6Mn2BLw2uKbXfjylBtJgIo6YlKpfxBO26ysE7ZlQNC4b7G+9AVEJsDBIAbeWcwRZw4lLznonwVUXbnH3+PM8HxQ08VzMjkkAZrW2vogjH4pYw+jK+o8N2oRrXXAbfOdkTYvEsTnyHdWRa8q3vE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629376; c=relaxed/simple;
	bh=sCnF1WWhVGW8xVYwTfmbAr1BNfwqxr2DfWhEZMEn4bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCGDQyD7tyGGIZuzWP8yADlL/yVITPSveV33lYDRfZfsoI/NXvACrOy5D6yWSgfjPidRg+8EbCI/z9JuJ4K9ebjMTzaMxsVebpBhNybBa5itAEbK008VEtDhBpvFEHlSAPvZbj8kAhYfOJpIiAR/QfkeVIKKhTmjlGp7ntJtFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0axwYly0; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa7797e897so438290276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717629372; x=1718234172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It1jGSpY/d5JoW3BH0YDpFaZbUvrsvHdjibkMTnj6oI=;
        b=0axwYly08R1IzMpbeUenVfvBdvSeJTVQkAqE3dBLDuiuXw2fhLdGKRnP2nmVosxg0H
         32W3X+n2fWL2hfXb7JH0T4L03t6OMJsk/Rl7dOqCaPwef+STobuFDkhNFrcj3BjL1JVX
         9SIwpnDv1VgBV2EHFImMur9dBwfNZpQQD0ZWs+73im87Uk0uij2ss+w1ZBYLy/UaXttf
         JAb/h25UE20Lc+mSoiGPBYPEvnspIV9fyPKZkNOlh1p+saWy+T2Z9Mw5KV/2xfYBrsJG
         CeImEszUUD9lEUkJG5zZOv6VLSLaaXeLW1uXyO+MzSUDQLihn0Bmc1DgwtTygKubYH39
         s0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629372; x=1718234172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It1jGSpY/d5JoW3BH0YDpFaZbUvrsvHdjibkMTnj6oI=;
        b=Fj2bCa2NyIb14T7jIe8KqG2j5co1IHbNIvgIDpUjgF9Uec00N27jUBTwrQO0/vEuV9
         3Hn6tLMMTIFN96QTZX0n6HqPl8wJcvAYFcKCn1vd/0oxm8yjoCD7hEzxm074wz8z7Yt2
         cAkwRKsXB3daHeYt+CTjKgOD0V1HtT9oi3upqKM61R1ryEKAQa7PfQ2CdFhTB7cAvHPQ
         6clfn+hshy8Oi1gRN+rRXkmU8pGS0R5rO55Tkwn0PnHRZ8j7OZbvVUXx78Hp1Skxs3Rh
         bIW35tsVsVk1Eh6Th0WmZDhVkqh1XOgsLIsaxrP8WTi8h30nGJfhHgxcRVY/fs4bMNI1
         QVEw==
X-Gm-Message-State: AOJu0Yyi9i+M2XQN1amiNtVhRZDlClHpkanNMHF2Y8aFwSOUs2PWI4gG
	e1aV2o5QMGJ+FMg77yloWR9hPGyxlTzN5kmMhnhgC0wDqVtR/jLgzaW4YUI3obtgeLOvU8gkq0c
	bPpo0dka8XxgbJnt7jZ30aFtIsxDZv+4plhQi
X-Google-Smtp-Source: AGHT+IG//Bbpm13yX5er5mRkf9mAC+1ekahyf3BmUiMZJv5AfaAy7zvY2vctDaLWIjOaU+8qTcrwQqETtL7ybQfO+V0=
X-Received: by 2002:a25:b299:0:b0:dfa:5d84:716b with SMTP id
 3f1490d57ef6-dfacac6b7f4mr3630672276.57.1717629371946; Wed, 05 Jun 2024
 16:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-5-andrii@kernel.org>
In-Reply-To: <20240605002459.4091285-5-andrii@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Jun 2024 16:15:58 -0700
Message-ID: <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 5:25=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Attempt to use RCU-protected per-VMA lock when looking up requested VMA
> as much as possible, only falling back to mmap_lock if per-VMA lock
> failed. This is done so that querying of VMAs doesn't interfere with
> other critical tasks, like page fault handling.
>
> This has been suggested by mm folks, and we make use of a newly added
> internal API that works like find_vma(), but tries to use per-VMA lock.
>
> We have two sets of setup/query/teardown helper functions with different
> implementations depending on availability of per-VMA lock (conditioned
> on CONFIG_PER_VMA_LOCK) to abstract per-VMA lock subtleties.
>
> When per-VMA lock is available, lookup is done under RCU, attempting to
> take a per-VMA lock. If that fails, we fallback to mmap_lock, but then
> proceed to unconditionally grab per-VMA lock again, dropping mmap_lock
> immediately. In this configuration mmap_lock is never helf for long,
> minimizing disruptions while querying.
>
> When per-VMA lock is compiled out, we take mmap_lock once, query VMAs
> using find_vma() API, and then unlock mmap_lock at the very end once as
> well. In this setup we avoid locking/unlocking mmap_lock on every looked
> up VMA (depending on query parameters we might need to iterate a few of
> them).
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  fs/proc/task_mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 614fbe5d0667..140032ffc551 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -388,6 +388,49 @@ static int pid_maps_open(struct inode *inode, struct=
 file *file)
>                 PROCMAP_QUERY_VMA_FLAGS                         \
>  )
>
> +#ifdef CONFIG_PER_VMA_LOCK
> +static int query_vma_setup(struct mm_struct *mm)
> +{
> +       /* in the presence of per-VMA lock we don't need any setup/teardo=
wn */
> +       return 0;
> +}
> +
> +static void query_vma_teardown(struct mm_struct *mm, struct vm_area_stru=
ct *vma)
> +{
> +       /* in the presence of per-VMA lock we need to unlock vma, if pres=
ent */
> +       if (vma)
> +               vma_end_read(vma);
> +}
> +
> +static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *m=
m, unsigned long addr)
> +{
> +       struct vm_area_struct *vma;
> +
> +       /* try to use less disruptive per-VMA lock */
> +       vma =3D find_and_lock_vma_rcu(mm, addr);
> +       if (IS_ERR(vma)) {
> +               /* failed to take per-VMA lock, fallback to mmap_lock */
> +               if (mmap_read_lock_killable(mm))
> +                       return ERR_PTR(-EINTR);
> +
> +               vma =3D find_vma(mm, addr);
> +               if (vma) {
> +                       /*
> +                        * We cannot use vma_start_read() as it may fail =
due to
> +                        * false locked (see comment in vma_start_read())=
. We
> +                        * can avoid that by directly locking vm_lock und=
er
> +                        * mmap_lock, which guarantees that nobody can lo=
ck the
> +                        * vma for write (vma_start_write()) under us.
> +                        */
> +                       down_read(&vma->vm_lock->lock);

Hi Andrii,
The above pattern of locking VMA under mmap_lock and then dropping
mmap_lock is becoming more common. Matthew had an RFC proposal for an
API to do this here:
https://lore.kernel.org/all/ZivhG0yrbpFqORDw@casper.infradead.org/. It
might be worth reviving that discussion.

> +               }
> +
> +               mmap_read_unlock(mm);

Later on in your code you are calling get_vma_name() which might call
anon_vma_name() to retrieve user-defined VMA name. After this patch
this operation will be done without holding mmap_lock, however per
https://elixir.bootlin.com/linux/latest/source/include/linux/mm_types.h#L58=
2
this function has to be called with mmap_lock held for read. Indeed
with debug flags enabled you should hit this assertion:
https://elixir.bootlin.com/linux/latest/source/mm/madvise.c#L96.

> +       }
> +
> +       return vma;
> +}
> +#else
>  static int query_vma_setup(struct mm_struct *mm)
>  {
>         return mmap_read_lock_killable(mm);
> @@ -402,6 +445,7 @@ static struct vm_area_struct *query_vma_find_by_addr(=
struct mm_struct *mm, unsig
>  {
>         return find_vma(mm, addr);
>  }
> +#endif
>
>  static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
>                                                  unsigned long addr, u32 =
flags)
> @@ -441,8 +485,10 @@ static struct vm_area_struct *query_matching_vma(str=
uct mm_struct *mm,
>  skip_vma:
>         /*
>          * If the user needs closest matching VMA, keep iterating.
> +        * But before we proceed we might need to unlock current VMA.
>          */
>         addr =3D vma->vm_end;
> +       vma_end_read(vma); /* no-op under !CONFIG_PER_VMA_LOCK */
>         if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
>                 goto next_vma;
>  no_vma:
> --
> 2.43.0
>

