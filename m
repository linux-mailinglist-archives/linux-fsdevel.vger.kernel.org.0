Return-Path: <linux-fsdevel+bounces-61265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBAAB56DA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 02:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57F9189A82B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 00:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC2A1D54FA;
	Mon, 15 Sep 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvKNtk/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96311C860E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757897048; cv=none; b=S2z5f/6oLjuxhBY6m/Xv0to+FwCUCiEU514Th7B/1MTXrKbvZbDWwiwT8JbedtopwhQ4wltLbhd+MMgutYtxjBOu2cysRKtG9sO7nkCzWpl3s4diZ/bMJbBQ+rq2PsV6a2xdXYX0NSebO0X146bY8l9uII5YV03bW+c7Fc0WisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757897048; c=relaxed/simple;
	bh=aA8qj6lRb3xePM94d10e4Y4cI1pxwAPWJSkyEKnf/Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw5wO21lMmZ6KV3yDDTNZXkh6OpGIbFda8dUQHyP66z6ICOuumPiTUw5bLySs25+YaNtQhh2wLF36qhFfFbNoyZCh9L3Q4M8VTeycVwDiFVo9w9l6yYbzZzDCcBTBqn/A2Xpzsf/+q0XCHjlXg2WRwXGlxB5ofMXW502q20sf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvKNtk/3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b78657a35aso358821cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757897046; x=1758501846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9JaDewgxuozpkxda6xKseXUycmdfaWorgRDXhlzyRo=;
        b=LvKNtk/385HLT9CfJCeRTZIN8xMhLYHBJsE1HZhSnEU4MIfMuXdBFyQVaK0wlxNeph
         tqtQtgeNYMaYCtpx8W9n5QSBosliKLaV5Q8uUonSwtFQB+/47f92H0/iXOtUmiQosBk6
         Fd/Q/K9y50VE7fyMdic0sKL7HRjvWOlnkjmMoOsqQcn3NjGyYIYeI1eQzQRcOtrOPixG
         VhEqeoE35hLkFZPUOn1CAH9pIgmzMNvrtwkiGyqvxeppkscYF4Mz8BlvAJnnHW7I2No/
         vDfivupQbBMbgj/jc6QmhjsP3HeF97XTCnxB8J86viMc/TL1CgYjEr0fjhqgA39fi0xe
         7q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757897046; x=1758501846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9JaDewgxuozpkxda6xKseXUycmdfaWorgRDXhlzyRo=;
        b=EuJ0K27KxIrD1JDXjniW4WWu6qr43kaPTDw1TtWBao5ZwUwD1WEZ5LkumiXDE8hfsN
         DVuzylqO8E74K1KY44VUinzM5KXPuQQoTeWSzsq49dwkKOT046XL9cO/17FokyRPg9Tj
         J9mZW0w1RvgPwmiCNkAhE8+Nsi7KjF6/BfeGiqTXhrCFbWbqw44cXHF+KiRgzSqJ7iJp
         Mcq5gcxStRsTqwtoJnpv+HwQfhSLJAZykVzVtTrs9R+h+724/iI/Xoi6L9fCQPE57C2E
         YbpHrZGFR9WKDfW4PmgEMdhMAi28W32CKeaQ+26WSoMjA5pj1A5RwiBHQxbPSxH+1quc
         sj/g==
X-Forwarded-Encrypted: i=1; AJvYcCWEZJrxVYlP/uzgRJxY1ZRiOGd5rH0nvasMAeNA4zrtqnedwluZ8Cbij3sp0xNlroBC7PildoqLezS8DogE@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMAkoCiDridZW0fP1xdKdAFLwUUDbxJAULalFETXx56OBB9ry
	bSSXBx2cYU+108ZWYKDcs2XE/AgZ7utp2clTMmKJMmdnUWIyEy9M8HV3b44VkXZ47I9A8WcBJkC
	U4c7ZuKD4OVOHxonUhPBkLzw3dEGAGLSrLuQpYS8M
X-Gm-Gg: ASbGncuR/eaRGWBu6c2OpiNCjMtFfKmkRotjY08fhTsO0KNa67rgQ++HPLLNTvkhKSe
	VhieWWXwW6+1wm1DWPhtV2MHxsS3m7CAPf+ayIzsvLyKGtxI1vTJoezKk/TewZIcDm5fXBenwls
	Mj++c78Wr4rwIl+ZmiVwTJ/8sI9bQh+i/jAbT+vnALhMPRUeopAv9DcEw+ycAypPQk3aaI/RVRs
	XzRqMQ1tMvNiE7eRi9t/qQ=
X-Google-Smtp-Source: AGHT+IEezB3iSLbeJTHsIwywK29EKKbUJtnk62B10GeCdyT9bGxf+jf23KN9V20U3FFXbSgM6H7iFnxQMLHkzklqJuw=
X-Received: by 2002:a05:622a:900f:b0:4b3:7533:c1dd with SMTP id
 d75a77b69052e-4b78b98e1ecmr8313771cf.1.1757897045275; Sun, 14 Sep 2025
 17:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808152850.2580887-4-surenb@google.com> <20250914114308.3024033-1-clm@meta.com>
In-Reply-To: <20250914114308.3024033-1-clm@meta.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Sep 2025 17:43:54 -0700
X-Gm-Features: AS18NWCmk4aMAnU5waOHNrHwd6qTif_tgIS8NTe99BvH87FvfzNuXoMxBTE1cSY
Message-ID: <CAJuCfpGuvyRj6zxPuJDzCcGz_-x7feycsCkNQT0+Nzn4oUYcSA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
To: Chris Mason <clm@meta.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 6:24=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
>
> On Fri,  8 Aug 2025 08:28:49 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
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
> > Acked-by: SeongJae Park <sj@kernel.org>
> > ---
> >  fs/proc/task_mmu.c | 103 +++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 85 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index c0968d293b61..e64cf40ce9c4 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -132,6 +132,12 @@ static void release_task_mempolicy(struct proc_map=
s_private *priv)
>
> [ ... ]
>
> > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_=
locking_ctx *lock_ctx,
> > +                                                  unsigned long addr)
> > +{
> > +     struct mm_struct *mm =3D lock_ctx->mm;
> > +     struct vm_area_struct *vma;
> > +     struct vma_iterator vmi;
> > +
> > +     if (lock_ctx->mmap_locked)
> > +             return find_vma(mm, addr);
> > +
> > +     /* Unlock previously locked VMA and find the next one under RCU *=
/
> > +     unlock_ctx_vma(lock_ctx);
> > +     rcu_read_lock();
> > +     vma_iter_init(&vmi, mm, addr);
> > +     vma =3D lock_next_vma(mm, &vmi, addr);
> > +     rcu_read_unlock();
> > +
> > +     if (!vma)
> > +             return NULL;
> > +
> > +     if (!IS_ERR(vma)) {
> > +             lock_ctx->locked_vma =3D vma;
> > +             return vma;
> > +     }
> > +
> > +     if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > +             /* Fallback to mmap_lock on vma->vm_refcnt overflow */
> > +             mmap_read_lock(mm);
>
> I know it's just a (very rare) fallback, but should we be using
> mmap_read_lock_killable() for consistency?  I can see this impacting oom
> kills or other times we really want to be able to get rid of procs.

That's a good idea. From a quick look it seems safe to fail with
-EINTR here, which will propagate all the way to do_procmap_query().
Do you want to post a fixup patch?
Thanks,
Suren.

>
> -chris

