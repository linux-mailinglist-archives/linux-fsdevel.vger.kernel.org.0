Return-Path: <linux-fsdevel+bounces-36969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F99EB802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454BC18882A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D4230267;
	Tue, 10 Dec 2024 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFD7ep9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D622FAE0
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850933; cv=none; b=DOujWBBfSE7SHB3N4qqQO3aVDeLmLTLgYnDUh19Eib10zJJqD8L9t3yezeww1y1tpYCkip2MM2qIg+VAOG3FVl4EBGnohAdIAujjXxCvJF27niXdzMtLKoKASiPDsDkCS5jfgOnB2gcG7BLoEAAMSwgrOuLAZEePkXV4liJ9Ibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850933; c=relaxed/simple;
	bh=65mBZ/F+s9YxlRJpWUAHAJJBKcnRjWV2qFXtSeoqb0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGFmxVe47pvhg7ozxDkTzv6gsAUmG1EAk3S9IY5RJSGLEej0HIObmlLzTT/k96BLqeCnDNCzUwwh2+JdPbqud8rNsC0uOYVegP/WEI6i0ZI9tPm0St/6ZlKWX7s1enNJnQdbx7rSWrGAYkZOj4ByN3KFgrIs9uzCfJNAhBR7NUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFD7ep9t; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3c2135f61so9017a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 09:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733850930; x=1734455730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j7LZ3gidxJvgG/m4KFvrvy2HeW92l/T3DtHZWGqx18=;
        b=NFD7ep9tvsrHgVkX98Kww8FPNLaOjvkZdFdr05Ksd9+2uuZv10WZ3pMhZVhr632qLt
         84Pvrn1+t6cMLKfwqyE4A15DwFg/pMaHi5NGKA0AOgZ+UY9tNuqKkjxiX3tGT4+i/Npj
         He1dm4J/HYFFqTb4lqOKcfICe0EOuIwNdOnLswRjrdmNoH2h9Qol09XZT939PslnLcOl
         t0YKoLGKxdec2Zt/kCdw6nAg1dM1yzQE17KfcxJNug4GLL3qLzyBVL/U3+jykx3TNm15
         I9qNoigQrSTGornXNgGirys84N4imGjXJSP7PBlO/b8cBQoWqQO4u2yzLiiNp9Qr19/Y
         byNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850930; x=1734455730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j7LZ3gidxJvgG/m4KFvrvy2HeW92l/T3DtHZWGqx18=;
        b=KxIUul98CXgo3kv/goQGkXZqsgItqq9k3C7/NsJUBVqwc9Up2N1g9CiTgR/JoHl1lk
         V+iNmv7v5txRACXwE+OhyfLjeXXV0XKG2H4kdNdxBzXTVqSjF4lSd6f45xHgpjwbv+Ny
         eWCDN1Xh47S2GoN9APaCoITG5/cgO1Nwb2TGQFKVPo3ExIMmC7kQ8CObxuuC4SikK6mi
         amD/Aoq8qNkLrSB5AwmokespnBE5yOo3oy2P1zGyoRArOkKaSY7aFO8XGJ7KP+W1XldS
         vUrhEScFWBw2BoV3lJShxq7kQODQy024bpP80uzgN9FpHEVPI0dovCNmchxtv3peV2an
         rqGA==
X-Forwarded-Encrypted: i=1; AJvYcCXGA0Rwi9N7zmm2lgx1HDvxsjz+DpBluvvMpI9HfwP6WszLPufP+6fpwBi/JS2MxwTX54su7xmL2XFxSNGe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+9s89P6LtAS/qJiMUMmrMJZTbVroNSsXcwPe/ScAZmnRpZ/+
	6eoKUxtplTi0QbK21rv7eFPLGGonMqHEPG8Tlhtcb1SjJTktGl6Rb1x/icSt/AQd1WeySNXM5K1
	3Bcki5CCA6C8D26SOKUwu1INHKD+awjSLlIZ2
X-Gm-Gg: ASbGncvBCmezM54mJg/HT+gPlC7ZKIaJFdfnUXGT+M5bbBGRfa3pPicJ3nE++csYH0S
	7M4tq36dwuNLIUYH6t40JO2LSJ2xjIcJjcWqI3bFlXlypFruLK4Wg7ixfpcTrxoA=
X-Google-Smtp-Source: AGHT+IHT16w6MB/cAWIgtFbiSkDVdo7XP1VoYlvCUhWiCeYhHyzKjFoNyCYw0JcgMIyZtC6modyN7XVZ+Xm+NXJ7OGE=
X-Received: by 2002:a50:c2d1:0:b0:5d0:d935:457b with SMTP id
 4fb4d7f45d1cf-5d41ed02050mr123811a12.0.1733850929585; Tue, 10 Dec 2024
 09:15:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com> <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Dec 2024 18:14:53 +0100
Message-ID: <CAG48ez12K25yNWaAXqMnC8tfpTQFOwzvPsyE7r8N1NM9wqfzzw@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: abstract get_arg_page() stack expansion and mmap
 read lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:05=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Right now fs/exec.c invokes expand_downwards(), an otherwise internal
> implementation detail of the VMA logic in order to ensure that an arg pag=
e
> can be obtained by get_user_pages_remote().
>
> In order to be able to move the stack expansion logic into mm/vma.c in
> order to make it available to userland testing we need to find an
> alternative approach here.
>
> We do so by providing the mmap_read_lock_maybe_expand() function which al=
so
> helpfully documents what get_arg_page() is doing here and adds an
> additional check against VM_GROWSDOWN to make explicit that the stack
> expansion logic is only invoked when the VMA is indeed a downward-growing
> stack.
>
> This allows expand_downwards() to become a static function.
>
> Importantly, the VMA referenced by mmap_read_maybe_expand() must NOT be
> currently user-visible in any way, that is place within an rmap or VMA
> tree. It must be a newly allocated VMA.
>
> This is the case when exec invokes this function.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/exec.c          | 14 +++---------
>  include/linux/mm.h |  5 ++---
>  mm/mmap.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 58 insertions(+), 15 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 98cb7ba9983c..1e1f79c514de 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -205,18 +205,10 @@ static struct page *get_arg_page(struct linux_binpr=
m *bprm, unsigned long pos,
>         /*
>          * Avoid relying on expanding the stack down in GUP (which
>          * does not work for STACK_GROWSUP anyway), and just do it
> -        * by hand ahead of time.
> +        * ahead of time.
>          */
> -       if (write && pos < vma->vm_start) {
> -               mmap_write_lock(mm);
> -               ret =3D expand_downwards(vma, pos);
> -               if (unlikely(ret < 0)) {
> -                       mmap_write_unlock(mm);
> -                       return NULL;
> -               }
> -               mmap_write_downgrade(mm);
> -       } else
> -               mmap_read_lock(mm);
> +       if (!mmap_read_lock_maybe_expand(mm, vma, pos, write))
> +               return NULL;
[...]
> +/*
> + * Obtain a read lock on mm->mmap_lock, if the specified address is belo=
w the
> + * start of the VMA, the intent is to perform a write, and it is a
> + * downward-growing stack, then attempt to expand the stack to contain i=
t.
> + *
> + * This function is intended only for obtaining an argument page from an=
 ELF
> + * image, and is almost certainly NOT what you want to use for any other
> + * purpose.
> + *
> + * IMPORTANT - VMA fields are accessed without an mmap lock being held, =
so the
> + * VMA referenced must not be linked in any user-visible tree, i.e. it m=
ust be a
> + * new VMA being mapped.
> + *
> + * The function assumes that addr is either contained within the VMA or =
below
> + * it, and makes no attempt to validate this value beyond that.
> + *
> + * Returns true if the read lock was obtained and a stack was perhaps ex=
panded,
> + * false if the stack expansion failed.
> + *
> + * On stack expansion the function temporarily acquires an mmap write lo=
ck
> + * before downgrading it.
> + */
> +bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
> +                                struct vm_area_struct *new_vma,
> +                                unsigned long addr, bool write)
> +{
> +       if (!write || addr >=3D new_vma->vm_start) {
> +               mmap_read_lock(mm);
> +               return true;
> +       }
> +
> +       if (!(new_vma->vm_flags & VM_GROWSDOWN))
> +               return false;
> +
> +       mmap_write_lock(mm);
> +       if (expand_downwards(new_vma, addr)) {
> +               mmap_write_unlock(mm);
> +               return false;
> +       }
> +
> +       mmap_write_downgrade(mm);
> +       return true;
> +}

Random thought: For write=3D=3D1, this looks a bit like
lock_mm_and_find_vma(mm, addr, NULL), which needs similar stack
expansion logic for handling userspace faults. But it's for a
sufficiently different situation that maybe it makes sense to keep it
like you did it, as a separate function...

