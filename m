Return-Path: <linux-fsdevel+bounces-56769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CFB1B6AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C855C1796EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB67279327;
	Tue,  5 Aug 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CwmR5ck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCF1FBEB0
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404689; cv=none; b=ceT66qsB3jP0/LfNGdhCRI3NqzmYXrQR+hnYEqawPlAdGvjg7YwkJyLgYfyWZp/Fe04eCYP1T/gfW4FLX1LWsL7hAQ9F8ZHA6mwd9/10ykPTtry1PL1tSz/QbwfE16gpjqh2vdPZoRejkLGZR1vyOINy0PaKzVPp26wzGfV1XkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404689; c=relaxed/simple;
	bh=arjCcfwEvuffPrclQ/6w1YywG85PqYHtkxOop0K6FLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHDXYFzkQmqZNH8ZepXYYw5EMA4XBQcrjSW60mX5Hf1SetUGWJ+oehPYogwq7tF+Ys4mBFrrWqukgSR2lC8wpXT/o1W3ZJWTq8ISt8civ9yhkXoOoqAz50CzFxu8bftT3R5TXwO8/w3XwTmYoAmfBL6mKA83WgJ9XHewf4wePYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CwmR5ck; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0673b0a7cso596421cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754404686; x=1755009486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aef8IAvwtLn08IdbykC4EYYFzkMHHIdInKV+pvklfuE=;
        b=1CwmR5ckkPTgkSHhLPBs0Y9Zz9PUv0ECATdi77YkZsMg0bTn0w2csYJv6CwVSmfOz/
         lV2SC5SWwbblyVsG5qzYHAxjKRuHlQJXm85vbbpEUkAKUuxznK2/Ni04hpwNr0cnJhDB
         lkDHSC2s1vtYDvT8W6Q/klC/sFVHoQOju7Vq/iYlder7so4fzlFVN8vBHHh/DRDDHhFQ
         64Qi0Z7JrPe9qmYgJF6M8nnFT70Dxh9QJL/2QjVoQNdeAFwtvLEPB8SXNlyTPQ+gSV6R
         dYvvZ7klvczbOyV1MNXrtf948CcvXDFY7on/k4kYAWbIsgXgNwe2Y1Sj1vtLizkpxe2K
         hnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404686; x=1755009486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aef8IAvwtLn08IdbykC4EYYFzkMHHIdInKV+pvklfuE=;
        b=jCH+XZ6ndQWlvES6P5Iy4OiEfeFMJfu4iEFUrd4YO5B4T1MvhgMU8LyWEAWRhc2RZa
         svB+4UDvp8UwGn979jK4V6QeaLLX403ZJ0Q7Ppo6dPftTu8zz3+UtW9Fri68eyleL40S
         bjFt1YlZcw90TxARIq1ualjejKEA71+RMbpy0s/irrB+eVdrRb1O6cFby+bNATstH4KB
         qBBnbzioUpOei3qH8bTyRZ5jnbYuCa1tHz0IDHjsaNR8gE6PevbnedZQLfh8nGgBjHXl
         SYANkrvthGDL3I6ttmESMk/k9VtdulpI41j9zJl7Cm+L7fIzHIEoiuw9ETizr7LbRm62
         N2mg==
X-Forwarded-Encrypted: i=1; AJvYcCXHz9YukISRGNWsXeSTPUpYssuv4yk/ZqTJov91DwMxvrtsn+i+Kd3XYi6z55TMr2hKQjPAGIwZDHdeZa1l@vger.kernel.org
X-Gm-Message-State: AOJu0YwNO63WlxY1HF5+YPb3ErEWQeqRv/DUq3jTE1VsqvN6/TqbxsKD
	6VkFsIp5QgYllQFxPzW37L1twYGSebuS1pjUgNdtL1WaAKzj4AU3g1xsI+A3X21HlynEXs841nK
	aQ2cjmi/mpEC0fc3U27zjg0vpA5ea16Tg+wiFakgG
X-Gm-Gg: ASbGncsJ4W20TCi8ATL83vfTe+kmQc+TsnNZFmiGedpvOScnysI47bME/q6N+GH+bNo
	ADDLEWbnVrB9Nm93rlD7oahzBS6378dBB1f2brNWN2yKAPDMg9to4JAM9CXMTw037+n2h7HLDCU
	eugmM1jYXOMmxFYsJPg2yGmypu+LkTfO0vFf1HOkG/ALdwrFPFQCXwR08Rdu7cLgWRDRTMBmPJF
	RNBIhT47O2u0fNj1RP7nq8iw/RQlBfrtjzEMQ==
X-Google-Smtp-Source: AGHT+IGNgBN87aq4QIxEol6Iry1WpPeZs6N2msqSePTFM5jWMKBB+kelQvyXcVEXcEbW86sUjLIcplgHgUotOVKwENk=
X-Received: by 2002:ac8:5e4b:0:b0:48a:ba32:370 with SMTP id
 d75a77b69052e-4b084f396fbmr3912431cf.10.1754404685401; Tue, 05 Aug 2025
 07:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804231552.1217132-1-surenb@google.com> <20250804231552.1217132-4-surenb@google.com>
 <a2fca13d-87bd-4eb3-b673-46c538f46e66@suse.cz>
In-Reply-To: <a2fca13d-87bd-4eb3-b673-46c538f46e66@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 5 Aug 2025 07:37:53 -0700
X-Gm-Features: Ac12FXw4MVzzUn2oCKvSzz_8aCVi1Bw7CmRaPzcL7KBJ8BbbbzRtIwg97emJVWA
Message-ID: <CAJuCfpG7_=3cN6VrPmx1qtXq53AptNynTccG5vYUEYdfyQ71DA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:18=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/5/25 1:15 AM, Suren Baghdasaryan wrote:
> > Utilize per-vma locks to stabilize vma after lookup without taking
> > mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
> > contended, we fall back to mmap_lock but take it only momentarily
> > to lock the vma and release the mmap_lock. In a very unlikely case
> > of vm_refcnt overflow, this fall back path will fail and ioctl is
> > done under mmap_lock protection.
> >
> > This change is designed to reduce mmap_lock contention and prevent
> > PROCMAP_QUERY ioctl calls from blocking address space updates.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 81 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 65 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 843577aa7a32..1d06ecdbef6f 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -517,28 +517,78 @@ static int pid_maps_open(struct inode *inode, str=
uct file *file)
> >               PROCMAP_QUERY_VMA_FLAGS                         \
> >  )
> >
> > -static int query_vma_setup(struct mm_struct *mm)
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     return mmap_read_lock_killable(mm);
> > +     lock_ctx->locked_vma =3D NULL;
> > +     lock_ctx->mmap_locked =3D false;
> > +
> > +     return 0;
> >  }
> >
> > -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_st=
ruct *vma)
> > +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     mmap_read_unlock(mm);
> > +     if (lock_ctx->mmap_locked)
> > +             mmap_read_unlock(lock_ctx->mm);
> > +     else
> > +             unlock_vma(lock_ctx);
> >  }
> >
> > -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct =
*mm, unsigned long addr)
> > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_=
locking_ctx *lock_ctx,
> > +                                                  unsigned long addr)
> >  {
> > -     return find_vma(mm, addr);
> > +     struct vm_area_struct *vma;
> > +     struct vma_iterator vmi;
> >
>
> Hm I think we can reach here with lock_ctx->mmap_locked being true via
> "goto next_vma" in query_matching_vma(). In that case we should just
> "return find_vma()" and doing the below is wrong, no?

Ah, you are quite right. I should handle mmap_locked differently in
query_vma_find_by_addr(). I will post the fix shortly.

>
> > +     unlock_vma(lock_ctx);
> > +     rcu_read_lock();
> > +     vma_iter_init(&vmi, lock_ctx->mm, addr);
> > +     vma =3D lock_next_vma(lock_ctx->mm, &vmi, addr);
> > +     rcu_read_unlock();
> > +
> > +     if (!IS_ERR_OR_NULL(vma)) {
> > +             lock_ctx->locked_vma =3D vma;
> > +     } else if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > +             /* Fallback to mmap_lock on vma->vm_refcnt overflow */
> > +             mmap_read_lock(lock_ctx->mm);
> > +             vma =3D find_vma(lock_ctx->mm, addr);
> > +             lock_ctx->mmap_locked =3D true;
> > +     }
> > +
> > +     return vma;
> >  }
> >

