Return-Path: <linux-fsdevel+bounces-8510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F6838717
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 07:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC291F23FC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D94CB4C;
	Tue, 23 Jan 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5L1Jpul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA174EB21
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990036; cv=none; b=FaCRlMf3N1Xrc1jBi0Xa3RS1UE5W+wChYoJQD1KDAxd154BgxibwLgL54nc4/Fm9pspA50hWy83ztdgCEL6QppGjSJkuOOp0wl0ju3GpGbR8p4jJ78BSo23376ltuaTZxTUOPN66NiS/Cv4TH9XX6VhgrM8XFoF6cBB3LFa3o7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990036; c=relaxed/simple;
	bh=27Aj8d6q/ybatyrtxw+UPq7m9vsdWQLbU30eyMwD+zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgyvBt1OCibfBIbfG5jcpWw7lTrCvEQ90mO0FamMwmuep+0p+LW/F+i0CSMYueGhCytVfwyzBz2XFG84fQXK4PQsQhjBWokokrQ9G8/Z38vm4spaCXBO695dB//DlkKjaqBI8tgUEOD8U8dUolCiCHhvC8tCuDnKhZU0WzfXEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5L1Jpul; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff828b93f0so33471377b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 22:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705990033; x=1706594833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxZ+A3znnzHtmYf2gcEZb4fN+U5N81/SctsD0rg3+jg=;
        b=p5L1JpulbK5k6Oa6x4qysS3HBIVVZRrpceglU2ZdXMfC5yHpsRvX/sM+vc8l8lJt9X
         niJu05Dti+ydLMq0QVI9qbl5wwoha9ZnNlb6t26l4DIzKElvXePnaGfV6/fnmSEU2EKu
         VS+9F1qTXML9xM+5bWLQ//nYrS2xTjTNBSkz8F8BTGXN+F2FUTBk6s2TPqAzhVDUIcgo
         OfAgjVmWjPL+WgQh/ltR5zwYeTm9VubH0BYVHa6Wd/uff+D/NQ3h0SMf5XQG7m1tTplN
         mQK2n+PS5sc5ab5/fr+lBl3l6Kl0H/moQP5nlmdOasW3VLmKlbCscupI0OphLBBTzO10
         ys7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990033; x=1706594833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxZ+A3znnzHtmYf2gcEZb4fN+U5N81/SctsD0rg3+jg=;
        b=nlWU11t5OSMlyXJAA6IDw9P2kKSlcJ1M626vNKBfv0Uon32y1tGFLrsTDyhYSb7q04
         YZH9DhZCUQd6PUOY+f93Vd3CpsoWY6fyHpeXlJ70P9hSwEalP3ZUCcmHNDXwRrrO6Jgt
         5R+xsphufTtGKCOrA/Ki/ZqIfz6h6KrbznQNqw8vyFEBdlmyMxl2swMqGyK+ojfkRWYj
         tYwF9ch71VJxpMlw6L9eA5+mMAUWvOkU8PPZ9ud4aJZHGDU3M8UacBy7ivdcgvv10GDa
         QKPhdaEVYl49BfIu4atz9bkgtwVfw2NLkUKwO5OJO+EAwMrdUCT9TB45m/wesIKY8zMl
         v/bw==
X-Gm-Message-State: AOJu0Yw5ETbZS9HbxofZ3xEfIsHQD5CQCXf28JzGyOa+74C91/6mYOxB
	YEZhHpg9D+HInt6kr7i8ZNeZGuOp1jB/0FnkNCWkO7jL/gsVNYvXqwBkcCneeg3f9IRmY+qkWO5
	fXbPNd/LfdfdHzIsxuJrHKBUmV3n4hXWkP0P4
X-Google-Smtp-Source: AGHT+IFC24yaqUuFYRVQwBifsM09I8AWsKVJfvX9JHXVSG8btg9SsHsyuwhx6HGIsXQY1mUHEHTsahjdQvvp/j4/v+0=
X-Received: by 2002:a81:a1c5:0:b0:5ff:aa81:cf4b with SMTP id
 y188-20020a81a1c5000000b005ffaa81cf4bmr3863649ywg.83.1705990033272; Mon, 22
 Jan 2024 22:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122071324.2099712-3-surenb@google.com> <20240123053629.365673-1-sj@kernel.org>
In-Reply-To: <20240123053629.365673-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Jan 2024 22:07:01 -0800
Message-ID: <CAJuCfpHpujSbPcR2_jNTBu6+DTXvLBUoi2PjkYNJyTp62xaP9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/maps: read proc/pid/maps under RCU
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, dchinner@redhat.com, casey@schaufler-ca.com, 
	ben.wolsieffer@hefring.com, paulmck@kernel.org, david@redhat.com, 
	avagin@google.com, usama.anjum@collabora.com, peterx@redhat.com, 
	hughd@google.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	Liam.Howlett@oracle.com, yuzhao@google.com, axelrasmussen@google.com, 
	lstoakes@gmail.com, talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:36=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Suren,
>
> On Sun, 21 Jan 2024 23:13:24 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > With maple_tree supporting vma tree traversal under RCU and per-vma loc=
ks
> > making vma access RCU-safe, /proc/pid/maps can be read under RCU and
> > without the need to read-lock mmap_lock. However vma content can change
> > from under us, therefore we make a copy of the vma and we pin pointer
> > fields used when generating the output (currently only vm_file and
> > anon_name). Afterwards we check for concurrent address space
> > modifications, wait for them to end and retry. That last check is neede=
d
> > to avoid possibility of missing a vma during concurrent maple_tree
> > node replacement, which might report a NULL when a vma is replaced
> > with another one. While we take the mmap_lock for reading during such
> > contention, we do that momentarily only to record new mm_wr_seq counter=
.
> > This change is designed to reduce mmap_lock contention and prevent a
> > process reading /proc/pid/maps files (often a low priority task, such a=
s
> > monitoring/data collection services) from blocking address space update=
s.
> >
> > Note that this change has a userspace visible disadvantage: it allows f=
or
> > sub-page data tearing as opposed to the previous mechanism where data
> > tearing could happen only between pages of generated output data.
> > Since current userspace considers data tearing between pages to be
> > acceptable, we assume is will be able to handle sub-page data tearing
> > as well.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/internal.h |   2 +
> >  fs/proc/task_mmu.c | 114 ++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 109 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index a71ac5379584..e0247225bb68 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -290,6 +290,8 @@ struct proc_maps_private {
> >       struct task_struct *task;
> >       struct mm_struct *mm;
> >       struct vma_iterator iter;
> > +     unsigned long mm_wr_seq;
> > +     struct vm_area_struct vma_copy;
> >  #ifdef CONFIG_NUMA
> >       struct mempolicy *task_mempolicy;
> >  #endif
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 3f78ebbb795f..3886d04afc01 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -126,11 +126,96 @@ static void release_task_mempolicy(struct proc_ma=
ps_private *priv)
> >  }
> >  #endif
> >
> > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *p=
riv,
> > -                                             loff_t *ppos)
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static const struct seq_operations proc_pid_maps_op;
> > +/*
> > + * Take VMA snapshot and pin vm_file and anon_name as they are used by
> > + * show_map_vma.
> > + */
> > +static int get_vma_snapshow(struct proc_maps_private *priv, struct vm_=
area_struct *vma)
> >  {
> > +     struct vm_area_struct *copy =3D &priv->vma_copy;
> > +     int ret =3D -EAGAIN;
> > +
> > +     memcpy(copy, vma, sizeof(*vma));
> > +     if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > +             goto out;
> > +
> > +     if (copy->anon_name && !anon_vma_name_get_rcu(copy))
> > +             goto put_file;
>
> From today updated mm-unstable which containing this patch, I'm getting b=
elow
> build error when CONFIG_ANON_VMA_NAME is not set.  Seems this patch needs=
 to
> handle the case?

Hi SeongJae,
Thanks for reporting! I'll post an updated version fixing this config.
Suren.


>
>     .../linux/fs/proc/task_mmu.c: In function =E2=80=98get_vma_snapshow=
=E2=80=99:
>     .../linux/fs/proc/task_mmu.c:145:19: error: =E2=80=98struct vm_area_s=
truct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you mea=
n =E2=80=98anon_vma=E2=80=99?
>       145 |         if (copy->anon_name && !anon_vma_name_get_rcu(copy))
>           |                   ^~~~~~~~~
>           |                   anon_vma
>     .../linux/fs/proc/task_mmu.c:161:19: error: =E2=80=98struct vm_area_s=
truct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you mea=
n =E2=80=98anon_vma=E2=80=99?
>       161 |         if (copy->anon_name)
>           |                   ^~~~~~~~~
>           |                   anon_vma
>     .../linux/fs/proc/task_mmu.c:162:41: error: =E2=80=98struct vm_area_s=
truct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you mea=
n =E2=80=98anon_vma=E2=80=99?
>       162 |                 anon_vma_name_put(copy->anon_name);
>           |                                         ^~~~~~~~~
>           |                                         anon_vma
>     .../linux/fs/proc/task_mmu.c: In function =E2=80=98put_vma_snapshot=
=E2=80=99:
>     .../linux/fs/proc/task_mmu.c:174:18: error: =E2=80=98struct vm_area_s=
truct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you mea=
n =E2=80=98anon_vma=E2=80=99?
>       174 |         if (vma->anon_name)
>           |                  ^~~~~~~~~
>           |                  anon_vma
>     .../linux/fs/proc/task_mmu.c:175:40: error: =E2=80=98struct vm_area_s=
truct=E2=80=99 has no member named =E2=80=98anon_name=E2=80=99; did you mea=
n =E2=80=98anon_vma=E2=80=99?
>       175 |                 anon_vma_name_put(vma->anon_name);
>           |                                        ^~~~~~~~~
>           |                                        anon_vma
>
> [...]
>
>
> Thanks,
> SJ

