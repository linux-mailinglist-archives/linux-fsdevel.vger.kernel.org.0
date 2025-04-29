Return-Path: <linux-fsdevel+bounces-47621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2AAA1424
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291EB188FEF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3264924A055;
	Tue, 29 Apr 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0Y1SOr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912B248878
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946558; cv=none; b=gnv/gYxy/SvpQ1SYHS0XDs14l5qedmXHTma2j/No1ZdWghL/+enV54VZQC8yHMV1TG4GjecNOB8KlEDaKttvISeYafOLMMSgxiT/3FgtVgl2iAi0Y06Zo9cEDt9XGdnApkzwmvTmcC09gkvczcPJBsiCZTOMg3KeMhUW6QJeU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946558; c=relaxed/simple;
	bh=otdy+cHDnN0z4MKJuQ50lJc3kGS+4GqL7DVYHyt+3rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDKnCnWT9cSb8h+FHFjI2MOhArcETmUGjDJAaAaRUMPgTzkYHdoTct2MrggHuxgAtaDzPeUyGNp8oVGmqtoyiRnpbULojLLVU0iK3ovyLiUcdF/heeFr3nqx7ME2Uew1eVTrXBqfuxWzVewpSHWQP7M9uS37elEgltYu9daswmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0Y1SOr0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47666573242so357681cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745946555; x=1746551355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wN1T3GMxNDHasA1P1pHfr57BfT4ryZUjRwhWQiFJ1U=;
        b=p0Y1SOr0CUlCKP+s/+gwo4KXL7wHgqYLjL1M3mGNNtzo+9I6YcdWh2SkbRYTRbOmez
         k9oqWBTwfwimfybknSFt9J9bIDfJTSGBcLe/3JyU7jLljxNQznPXsEOaFX5Chg3pxyik
         ZcEhhnjF+29kbtBL3fF0Ss2a8ORcvF5vFi4jIJ6CVL9Ts8ayni6D53nth2MkEv03yHnX
         s/4tjQlxCI+qaT2QYNfp8wf1vGaVxbrFBgNx0mQ16yNUpg7UKhLXKXGMmzjEeq2xd+RH
         DqrUPxR7kQWJ5yxhYdMyWslLPd2ug/O2/OrLxydtL2jnQDeQRPUWU7cFblKIk75yWqRc
         jvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946555; x=1746551355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wN1T3GMxNDHasA1P1pHfr57BfT4ryZUjRwhWQiFJ1U=;
        b=Ksp2gSQxASQtnPBmWikG1KdQ7+a/PlgCaAqJYashtofMOo5HAepGwinCudCWDR41Dt
         wf4T8kUJ7WvRhrRlIWFI55fmDEeOWGTu4pPfC+EPdPKWTITBq8iKHOak24rvyTO5y9tE
         eQ7E8ZK9aLjeNT/09EpbEHu3zjC60ThEEOuwTjQMf8o82LRR/CLHXP/xiLZ42kR7Wi90
         PQ6dDsi25V3rsy99BCIH+zxt0ihzRi7ZBCIHA1ekup4Mgv0/gyTj25QqL3Kk5JjHV8bW
         f3FHlaQfwXQK4fbhJ4mrCgQMYDfzdh94iiLZYlFLnrGVrgDm81mfok/07JunXQgAxHE/
         pFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbwlFyXe58wlgMkMvo4M4Xhmr7qO28Z/LaMlJk6g4ovUkgXQMyVwrDAUMK4YXp2I96Nl3X4EG3ieDeYyan@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUwaDLC2ophe81haVUoG6DRqb2zyTBM7r1TaZ2l/IZ0C8YIY8
	rV9w57bWk/c6LIxswGE2hcBB6ZqyeYcYIlYD+D+pMAJsjr+Wck0uVpjoRXZWp7GyTRe0EKOeuPC
	RoZQlu5H1xDAjo0pvfjSbCM6cXXlLWerpmR44
X-Gm-Gg: ASbGncuyThsyAF+j/IsBa1nTMB6AaVOJ3aEBiTlJDh3rw4puIm3Td5+yccoe8GIzW9Q
	vb5y4PQ5Qn2PFHvSdFddMAPaOwFfiGk9IlTpVMyYauaKdSr9N8xWxOtZnCD+S1MI8azEgLPsBIl
	WYcU/7nN5YpdvNfVRlJEPPdV4ZUgk27XW89zK+sVau7OvgiweQB0ZKkjXnPluyNy4=
X-Google-Smtp-Source: AGHT+IESKitBJO3sZv32xrVdF494ZNH19atUoJKC8GwVG1r2WedLX5sPmIE31lJgcwtfPpfMmDhKELfsvLaZi4LwOy0=
X-Received: by 2002:ac8:7f4c:0:b0:47d:d252:4873 with SMTP id
 d75a77b69052e-488a5dedc42mr4952881cf.11.1745946555202; Tue, 29 Apr 2025
 10:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
In-Reply-To: <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 10:09:04 -0700
X-Gm-Features: ATxdqUHykEeEaRUDfVFPrHYAFtv8-ek3ih5pTaKrNuCjWMlHoN1VLkz4YajbEFo
Message-ID: <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:40=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Apr 18, 2025 at 7:50=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > With maple_tree supporting vma tree traversal under RCU and vma and
> > its important members being RCU-safe, /proc/pid/maps can be read under
> > RCU and without the need to read-lock mmap_lock. However vma content
> > can change from under us, therefore we make a copy of the vma and we
> > pin pointer fields used when generating the output (currently only
> > vm_file and anon_name). Afterwards we check for concurrent address
> > space modifications, wait for them to end and retry. While we take
> > the mmap_lock for reading during such contention, we do that momentaril=
y
> > only to record new mm_wr_seq counter. This change is designed to reduce
> > mmap_lock contention and prevent a process reading /proc/pid/maps files
> > (often a low priority task, such as monitoring/data collection services=
)
> > from blocking address space updates.
> [...]
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index b9e4fbbdf6e6..f9d50a61167c 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> [...]
> > +/*
> > + * Take VMA snapshot and pin vm_file and anon_name as they are used by
> > + * show_map_vma.
> > + */
> > +static int get_vma_snapshot(struct proc_maps_private *priv, struct vm_=
area_struct *vma)
> > +{
> > +       struct vm_area_struct *copy =3D &priv->vma_copy;
> > +       int ret =3D -EAGAIN;
> > +
> > +       memcpy(copy, vma, sizeof(*vma));
> > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > +               goto out;
>
> I think this uses get_file_rcu() in a different way than intended.
>
> As I understand it, get_file_rcu() is supposed to be called on a
> pointer which always points to a file with a non-zero refcount (except
> when it is NULL). That's why it takes a file** instead of a file* - if
> it observes a zero refcount, it assumes that the pointer must have
> been updated in the meantime, and retries. Calling get_file_rcu() on a
> pointer that points to a file with zero refcount, which I think can
> happen with this patch, will cause an endless loop.
> (Just as background: For other usecases, get_file_rcu() is supposed to
> still behave nicely and not spuriously return NULL when the file* is
> concurrently updated to point to another file*; that's what that loop
> is for.)

Ah, I see. I wasn't aware of this subtlety. I think this is fixable by
checking the return value of get_file_rcu() and retrying speculation
if it changed.

> (If my understanding is correct, maybe we should document that more
> explicitly...)

Good point. I'll add comments for get_file_rcu() as a separate patch.

>
> Also, I think you are introducing an implicit assumption that
> remove_vma() does not NULL out the ->vm_file pointer (because that
> could cause tearing and could theoretically lead to a torn pointer
> being accessed here).
>
> One alternative might be to change the paths that drop references to
> vma->vm_file (search for vma_close to find them) such that they first
> NULL out ->vm_file with a WRITE_ONCE() and do the fput() after that,
> maybe with a new helper like this:
>
> static void vma_fput(struct vm_area_struct *vma)
> {
>   struct file *file =3D vma->vm_file;
>
>   if (file) {
>     WRITE_ONCE(vma->vm_file, NULL);
>     fput(file);
>   }
> }
>
> Then on the lockless lookup path you could use get_file_rcu() on the
> ->vm_file pointer _of the original VMA_, and store the returned file*
> into copy->vm_file.

Ack. Except for storing the return value of get_file_rcu(). I think
once we detect that  get_file_rcu() returns a different file we should
bail out and retry. The change in file is an indication that the vma
got changed from under us, so whatever we have is stale.

>
> > +       if (!anon_vma_name_get_if_valid(copy))
> > +               goto put_file;
> > +
> > +       if (!mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq))
> > +               return 0;
>
> We only check for concurrent updates at this point, so up to here,
> anything we read from "copy" could contain torn pointers (both because
> memcpy() is not guaranteed to copy pointers atomically and because the
> updates to the original VMA are not done with WRITE_ONCE()).
> That probably means that something like the preceding
> anon_vma_name_get_if_valid() could crash on an access to a torn
> pointer.
> Please either do another mmap_lock_speculate_retry() check directly
> after the memcpy(), or ensure nothing before this point reads from
> "copy".

Ack. I'll add mmap_lock_speculate_retry() check right after memcpy().

>
> > +       /* Address space got modified, vma might be stale. Re-lock and =
retry. */
> > +       rcu_read_unlock();
> > +       ret =3D mmap_read_lock_killable(priv->mm);
> > +       if (!ret) {
> > +               /* mmap_lock_speculate_try_begin() succeeds when holdin=
g mmap_read_lock */
> > +               mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_se=
q);
> > +               mmap_read_unlock(priv->mm);
> > +               ret =3D -EAGAIN;
> > +       }
> > +
> > +       rcu_read_lock();
> > +
> > +       anon_vma_name_put_if_valid(copy);
> > +put_file:
> > +       if (copy->vm_file)
> > +               fput(copy->vm_file);
> > +out:
> > +       return ret;
> > +}
> [...]
> > @@ -266,39 +399,41 @@ static void get_vma_name(struct vm_area_struct *v=
ma,
> >                 } else {
> >                         *path =3D file_user_path(vma->vm_file);
> >                 }
> > -               return;
> > +               goto out;
> >         }
> >
> >         if (vma->vm_ops && vma->vm_ops->name) {
> >                 *name =3D vma->vm_ops->name(vma);
>
> This seems to me like a big, subtle change of semantics. After this
> change, vm_ops->name() will no longer receive a real VMA; and in
> particular, I think the .name implementation special_mapping_name used
> in special_mapping_vmops will have a UAF because it relies on
> vma->vm_private_data pointing to a live object.

Ah, I see. IOW, vma->vm_private_data might change from under us and I
don't detect that. Moreover this is just an example and .name() might
depend on other things.

>
> I think you'll need to fall back to using the mmap lock and the real
> VMA if you see a non-NULL vma->vm_ops->name pointer.

Yeah, either that or obtain the name and make a copy during
get_vma_snapshot() using original vma. Will need to check which way is
better.

>
> >                 if (*name)
> > -                       return;
> > +                       goto out;
> >         }
> >
> >         *name =3D arch_vma_name(vma);
> >         if (*name)
> > -               return;
> > +               goto out;
> >
> >         if (!vma->vm_mm) {
> >                 *name =3D "[vdso]";
> > -               return;
> > +               goto out;
> >         }
> >
> >         if (vma_is_initial_heap(vma)) {
> >                 *name =3D "[heap]";
> > -               return;
> > +               goto out;
> >         }
> >
> >         if (vma_is_initial_stack(vma)) {
> >                 *name =3D "[stack]";
> > -               return;
> > +               goto out;
> >         }
> >
> >         if (anon_name) {
> >                 *name_fmt =3D "[anon:%s]";
> >                 *name =3D anon_name->name;
> > -               return;
> >         }
> > +out:
> > +       if (anon_name && !mmap_locked)
> > +               anon_vma_name_put(anon_name);
>
> Isn't this refcount drop too early, causing UAF read? We drop the
> reference on the anon_name here, but (on some paths) we're about to
> return anon_name->name to the caller through *name, and the caller
> will read from it.
>
> Ah, but I guess it's actually fine because the refcount increment was
> unnecessary in the first place, because the vma pointer actually
> points to a copy of the original VMA, and the copy has its own
> refcounted reference to the anon_name thanks to get_vma_snapshot()?
> It might be helpful to have some comments documenting which VMA
> pointers can point to copies.

If I follow Andrii's suggestion and avoid vma copying I'll need to
implement careful handling of pointers and allow get_vma_name() to
fail indicating that vma changed from under us. Let me see if this is
still doable in the light of your findings.

Thanks for the insightful review and welcome back!

