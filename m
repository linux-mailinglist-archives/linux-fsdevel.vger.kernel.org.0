Return-Path: <linux-fsdevel+bounces-61974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9539DB81272
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C278587F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53522FD1BE;
	Wed, 17 Sep 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gTftg7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2E2FC012
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129759; cv=none; b=jszWWSP9ILM0ti1n3HLAm8BdS8gdNpChPhodQGiaM/P5vspfOun8MZomG0vqyTn2C6h3PKNeeHd4mosLURpv3wEOs3rtrDbzHQB0SkzeP3hATFDR8hZYkIX8b91M+lmqgYa1bFwxCdrljOxu3EUUsuMqCqZdyM9DUQjXvW9Y+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129759; c=relaxed/simple;
	bh=ikCoNCwLqPBNlRXdXhap1TrscZ5NIMCidUJQsIyZl7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvYE9A6LkaCKIsYaMJMWRl1HjxOlI3pixwv00AqoxKyWkYOWIhzCvMUPqzOkzct1RU6nSfiqoXRIKDKDFNYZJ4NFnEyYv7doKfgKMJIQjHQFSDMmwiZFB/40mV9oc5Rke/q+dU8CH+KyH4pHH1AV1aap2dbmee5h4keDKeErTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gTftg7U; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-265abad93bfso12265ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758129757; x=1758734557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+E7E6CpklnGcp1ci3sPCCKWWgs8VUPg8eKk3JcOPP8=;
        b=3gTftg7UvOaBYLkA7ZPl5A6sHZyVnwLS0d83YZsDMjG3/pFfaMuWOcLe5bdJdPFLkT
         rHZWgJVMyzoxiFm9VK9aDiu3iYQ09mGw6qubfr7yqST5xV52x1/9HYYoYYxo3osfRI5C
         gl4uDSY4oKw9gG/3eGoRS8Q9lMW2nqDiE5ey7a86WTdOxv/bZTmEA19UzS69A+Dtoxbd
         44tSuSy/iUDlfPWAdhxvV3RzlkTSK3Q52W+XJ90TvlEerDjagERZllqiISNdfPdSO0gz
         vtwnwTZEcX01xqaKkpYvxtkvPCV0lMWYphvGLw+pWm3DMDF5357ZvM11BDWKz2h76/+U
         P3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129757; x=1758734557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+E7E6CpklnGcp1ci3sPCCKWWgs8VUPg8eKk3JcOPP8=;
        b=mG2Su4/q+kdgYqJlQ+TH8j+zON41dQfpmi67p2HxVgukGJSMS3Y2G1lhzSK6TM5cIH
         o4wW5ZhRU1MAjjrBNryJclPG4hxaa3LD06fZ6HLbJE6qV8heRyk4+cp0bhsqkv+43qAa
         iPuzoCRF/TcNGxX+8xYYu8lsbrBBQ6go1AeVS9+W6bKL13A+00gPS8QtSXGPTP+ixjkx
         1cp9k2g7n2G3hj33UP/Azkztmimo9VsAJZaB2emAFpDuHLAcPTGINh92H8pscQTSHQPa
         ZamfS0bQuJyYG08p0ZLHsB7MPjEFTO3UG+er6UTvalA/cBmkhmY3C0kVax7XGFgmKoP3
         LkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW25xN9XPqDHj5Hn0OeZyQH357sakm7mVbprF0ATxKmgRgORXhhyi6+/+B09ZV0O/a7yKAKUoL2vmh9d3Ju@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+J06B7Iiu/JaaUYFJK4oCDjfmAjIreCtW4LRVHnZmQYZZelk
	Wb784S+mozomM3OdyNn/GdeczchxrI7MdGA2J50HRWpfmcD5OfnpJtD8HhLiVoxIbOoBZzLwv8k
	HTf00bg0MwssXRRhUYVBuEyYIgFCA6SfOpomTN7oH
X-Gm-Gg: ASbGnctzEMqF25997cvBTJqU0FBzawa8uCc5Zy9+7Y1EYWwBG2Xbx77Good1pxd/IK2
	fRjGWEshWWhMiE2BQOnwT9s8wMdccULsDRWftwme7OVI3mAWQHeCj1ESQwhugHn+2Ee3zkXenSZ
	4/ZxN+WAS4V8rb+N/yjTs9whSPcX9F7EsQoxi6Lsxl9ZmHcwVX/B9UBtIordOMt2cBRYZGF5brr
	XbOLez+/yc00GN/uWEfWKE+0rxY1NpO0aPXecddhDWof7m19UiLbMI=
X-Google-Smtp-Source: AGHT+IHeiEiZK89rCQTa9vJT7n+2u8jidRkSIY9SZNarvXZONROAFr8zQdlQ9JzID/8YZhac6C1RAxvIIaVZDc04CMY=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-26808a2fc00mr4313065ad.3.1758129756462; Wed, 17 Sep 2025
 10:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-7-kaleshsingh@google.com> <eb7820ed-3351-4cb5-8341-d6a48ed7746f@redhat.com>
In-Reply-To: <eb7820ed-3351-4cb5-8341-d6a48ed7746f@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 17 Sep 2025 10:22:25 -0700
X-Gm-Features: AS18NWCUijB84Y15lF3r5d3C-Ej09R315cPK-C8knq1sNn05pRA_6ZbvAAxSzwc
Message-ID: <CAC_TJvctkyGEKv8mVE83D2DzCd-HiXh9co_DuZfwuF86FJoiJw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mm: add assertion for VMA count limit
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:44=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.09.25 18:36, Kalesh Singh wrote:
> > Building on the vma_count helpers, add a VM_WARN_ON_ONCE() to detect
> > cases where the VMA count exceeds the sysctl_max_map_count limit.
> >
> > This check will help catch future bugs or regressions where
> > the VMAs are allocated exceeding the limit.
> >
> > The warning is placed in the main vma_count_*() helpers, while the
> > internal *_nocheck variants bypass it. _nocheck helpers are used to
> > ensure that the assertion does not trigger a false positive in
> > the legitimate case of a temporary VMA increase past the limit
> > by a VMA split in munmap().
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v2:
> >    - Add assertions if exceeding max_vma_count limit, per Pedro
> >
> >   include/linux/mm.h               | 12 ++++++--
> >   mm/internal.h                    |  1 -
> >   mm/vma.c                         | 49 +++++++++++++++++++++++++------=
-
> >   tools/testing/vma/vma_internal.h |  7 ++++-
> >   4 files changed, 55 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 8bad1454984c..3a3749d7015c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4219,19 +4219,27 @@ static inline bool snapshot_page_is_faithful(co=
nst struct page_snapshot *ps)
> >
> >   void snapshot_page(struct page_snapshot *ps, const struct page *page)=
;
> >
> > +int vma_count_remaining(const struct mm_struct *mm);
> > +
> >   static inline void vma_count_init(struct mm_struct *mm)
> >   {
> >       ACCESS_PRIVATE(mm, __vma_count) =3D 0;
> >   }
> >
> > -static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> > +static inline void __vma_count_add_nocheck(struct mm_struct *mm, int n=
r_vmas)
> >   {
> >       ACCESS_PRIVATE(mm, __vma_count) +=3D nr_vmas;
> >   }
> >
> > +static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> > +{
> > +     VM_WARN_ON_ONCE(!vma_count_remaining(mm));
>
> Can't that fire when changing the max count from user space at just the
> wrong time?

You are right: technically it's possible if it was raised between the
time of checking and when the new VMA is added.

>
> I assume we'll have to tolerated that and might just want to drop this
> patch from the series.
>

It is compiled out in !CONFIG_VM_DEBUG builds, would we still want to drop =
it?

Thanks,
Kalesh

> --
> Cheers
>
> David / dhildenb
>

