Return-Path: <linux-fsdevel+bounces-54425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A50AFF89D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AF03A9B18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7FA2868A2;
	Thu, 10 Jul 2025 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4yRJQ8mq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D4280A5A
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126595; cv=none; b=YYoJDiHgEBMR8oNMGLt1xQefWOPzfhYoUonGPkQ+K5eicdehE0TfCOzxp9l489Du8eYYgEaechrp47j0m6mUvdoRwswjukI7JCdPkumTd7S+y7sv7HAAaRdtoNIxndTW9yBDL83y6JjC7jblPp9rFGEsAIFhE939+bXeXYtTBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126595; c=relaxed/simple;
	bh=h0KjSpeWdigZAZsRt1k8nf58qKzquiGW74F6JUkVpXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzEYl3dZVaYbiLoNs96bqW9ttFGKMGzjlRzM0caGhgMiWqLFwBngJgoQD436a7W0rpOR7bpvXOWR4LbXwKO8chF969fdul65I7xTZWFauWSG1WICq8K3qhvcBnGn87Jbt/JaIAT12bMhEtdzXk/lHs01ZhrOkaPZj4RDfFSWLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4yRJQ8mq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso150201cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 22:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752126592; x=1752731392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2DkamPXkqG5QCK86AOwRmXVbMEqNBmAF1PKjGfsOCw=;
        b=4yRJQ8mqpUDSOh2uiqNou9iyLo1sNhsqpDvPZCNQqfz4RssJl7EfiOhP+l3yAr9ULT
         ltQV+NQLXLiEXCMZJ+Rj4o8dt3Ee9Jha7R5LRcCbfaOFYlQdKL0QdevEjauyuhWfLWUD
         9RB56VVVtQv53V6pPNZp6+bQXS/PNVOVaeFa+IM9Ul87A8VzNtZyYQUHO2hgmj78iJdC
         tHhnU8+xmaoZrtPLeyZVrZVnvcfFG7zbxJo0DcuUNfGJRNwpIChzOFYdaYUv6KjDzfWI
         SrlMFv8b2kHQ6odQykd1dWGT/iPY/aZo/H7DECb0owkHa5ENJSk5rGhwozqwNf5XANub
         lOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752126592; x=1752731392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2DkamPXkqG5QCK86AOwRmXVbMEqNBmAF1PKjGfsOCw=;
        b=sTvK4tWc2dZUr/6ZlU7SZyNhA4KPOTL56Nh+Nh618RoRGQlv7ZVG3/IlbcmzvenOP+
         ZBA7Gc721eGdWrKWjgBDGKMS+RkHd/P1O9g+DwarQy9WlfIubnLA12acaNhXpi2emXP4
         Q9RSOaIZAAIYFFK/qBmWqh9JTEtvmmPb17LhOfFBqYWh2Jfgsbevl+dT8GkhBhP4JFvQ
         oSsEphBW1f8NyXiYTaMwp+Skub1oLZt1AblEkzoM3AX7Uq6PWi1BaEDcBrOkTetkN9Uf
         gqtphNFCnk1b880LFy11+8EMyZJB1YbdzjYovbne8wYumjodhXOHvBtx0wx4AWgZQt4i
         4stw==
X-Forwarded-Encrypted: i=1; AJvYcCUJg/NjeDRdiS++OD9HV327C3kbrPgjR3aokbO+IXqvtsZ/RauuDoXM6qOi8IpUKA5HHlCJqdnjoBwm86p7@vger.kernel.org
X-Gm-Message-State: AOJu0YydXBFwO60sb6VDgyz9JSdNvi5y16czADCKpRWiCVlS1L1UfGyu
	dIPEuxG+PZtnRdP7WVeTmwVIIPi5aEV40FMwaDraq1zv7TrwST5uf3H9qD0Aubor9MZF+koG8Sz
	ETrLnZaDev788YOkr593+kYoxIxJVTdfLBh3O3uEj
X-Gm-Gg: ASbGnctAottLTZz2ynUE3gGmJtCpCr/txTYzyVX9Jx55rsR3RSL2C3YSfYcqQpTtEjG
	b3TRhbp0ItNbYX8ykcAiS6C0prJ/VXppjRW32CbUv929cHMzDjFCK1oZQ8r8lSf0Zd0LOx4L/5+
	LaDYlsO5Fpz0m1J8qkB+6PbtXPxpZi/DW7lv4eolqmeQnYXQuwDv84F2CwotBhk9xga8bCv/4sD
	w==
X-Google-Smtp-Source: AGHT+IHd9bYNDNAN5ENOSYbR3QqescLdRwV2rs10KxjR/R0bjr3EaIwYCIh2/P1wreAPm2DA7zZ9VtunAr5OldSmhpc=
X-Received: by 2002:a05:622a:8e0a:b0:4a7:ff6d:e956 with SMTP id
 d75a77b69052e-4a9ec7d20b7mr1710771cf.3.1752126592089; Wed, 09 Jul 2025
 22:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-7-surenb@google.com>
 <0e0312c9-9a89-4a1b-a135-4425ea95d6f6@suse.cz>
In-Reply-To: <0e0312c9-9a89-4a1b-a135-4425ea95d6f6@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 22:49:40 -0700
X-Gm-Features: Ac12FXxTrq12WEb497yNoTrLUG113kauaA6N6gifPoRES-xwIKd4uwt6gAWXY3I
Message-ID: <CAJuCfpG+rzpEqDYAOr+CH-4remxJzuGKEH-=zpf_bWcah-1atw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] fs/proc/task_mmu: remove conversion of seq_file
 position to unsigned
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

On Tue, Jul 8, 2025 at 10:37=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/4/25 08:07, Suren Baghdasaryan wrote:
> > Back in 2.6 era, last_addr used to be stored in seq_file->version
> > variable, which was unsigned long. As a result, sentinels to represent
> > gate vma and end of all vmas used unsigned values. In more recent
> > kernels we don't used seq_file->version anymore and therefore conversio=
n
> > from loff_t into unsigned type is not needed. Similarly, sentinel value=
s
> > don't need to be unsigned. Remove type conversion for set_file position
> > and change sentinel values to signed.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Some stuff in the code gave me a pause but it's out of scope here so just=
 in
> case someone wants to do some extra churn...
>
> > ---
> >  fs/proc/task_mmu.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 751479eb128f..b8bc06d05a72 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -135,7 +135,7 @@ static struct vm_area_struct *proc_get_vma(struct p=
roc_maps_private *priv,
> >       if (vma) {
> >               *ppos =3D vma->vm_start;
> >       } else {
> > -             *ppos =3D -2UL;
> > +             *ppos =3D -2;
> >               vma =3D get_gate_vma(priv->mm);
> >       }
> >
> > @@ -145,11 +145,11 @@ static struct vm_area_struct *proc_get_vma(struct=
 proc_maps_private *priv,
> >  static void *m_start(struct seq_file *m, loff_t *ppos)
> >  {
> >       struct proc_maps_private *priv =3D m->private;
> > -     unsigned long last_addr =3D *ppos;
> > +     loff_t last_addr =3D *ppos;
> >       struct mm_struct *mm;
> >
> >       /* See m_next(). Zero at the start or after lseek. */
> > -     if (last_addr =3D=3D -1UL)
> > +     if (last_addr =3D=3D -1)
> >               return NULL;
> >
> >       priv->task =3D get_proc_task(priv->inode);
> > @@ -170,9 +170,9 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >               return ERR_PTR(-EINTR);
> >       }
> >
> > -     vma_iter_init(&priv->iter, mm, last_addr);
> > +     vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
>
> I wonder if this should rather be done only after dealing with the -2 cas=
e
> below. It seems wrong to init the iterator with a bogus address. What if =
it
> acquires some sanity checks?
>
> >       hold_task_mempolicy(priv);
>
> It seems suboptimal to do that mempolicy refcount dance for numa_maps sak=
e
> even if we're reading a different /proc file... maybe priv could have a f=
lag
> to determine?
>
> > -     if (last_addr =3D=3D -2UL)
> > +     if (last_addr =3D=3D -2)
> >               return get_gate_vma(mm);
>
> I think only after the above it makes sense to init the iterator?

Yes makes sense but let me do that outside of this patchset as it's
rather unrelated.

>
> >       return proc_get_vma(priv, ppos);
> > @@ -180,8 +180,8 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >
> >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> >  {
> > -     if (*ppos =3D=3D -2UL) {
> > -             *ppos =3D -1UL;
> > +     if (*ppos =3D=3D -2) {
> > +             *ppos =3D -1;
> >               return NULL;
> >       }
> >       return proc_get_vma(m->private, ppos);
>

