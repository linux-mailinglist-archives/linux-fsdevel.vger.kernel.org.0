Return-Path: <linux-fsdevel+bounces-47137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B42CA99B05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 23:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8773D7A39FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19F20C030;
	Wed, 23 Apr 2025 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+I0yi0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D402701D4
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445216; cv=none; b=GVnebPi5SsvgDnIQwKwvxTQ425wQbpYkDXusC/PM/r/PYH/ZE2jhZYOF36Vr50rm+tCn5WF6GQ3W/+96KGMnZmV0N7m5zna8wC9NthLEqkDi75i68pvNciR5222D+u78HMkq3R1p20axXRzZWu/Fg0oPkO+aYop7oAZJM57zGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445216; c=relaxed/simple;
	bh=1VENgflOh3MnWBXlewKcXCnf2iJGOO5S/6TsTkBKJjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAB9IcIsP/uAK+44Yk14CBkPaOCy/oiap69NKziQT9W6b6AEp4RIw68aGa9TXh1H1QxyLtwoSDMgfx67yvVN1D7QioWSo7pfkQQjDG0OykU1CPsV+yB3ju0cDB2ZrM3BlO4zlXah1vR7TRztLtoH8EYJeB5jJG4ZAE2xLjaWjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+I0yi0r; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47e9fea29easo43271cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745445213; x=1746050013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wxOEPg2lzGGAAEWxyMxHF7QDi50JL+cgIXLanH/rmg=;
        b=w+I0yi0rZZufAMzk4tikYMnTXTZf++GbQxgW+IxjOi5cx4TQwMsstWg0p0bO7Mrlw+
         mxitFGHMdZvDFJ668oSWaAqR3oCstXTO7c7qiiWrg7wIL0jSThMu31JybgLVOttLJllW
         pthV4qTsN9eW7jF6CXDBlF+4XNjlXxDHjtTxNz2faxldy4W67NIO66rKa7v6NRMvxy8V
         XsQ0pWldRNWHyrvP6kuFgsBhV4AMSZEt/tpepJQCbYx3ZiK99GX6ipj3sip0Q/6G6NZp
         +hKn4VIqvVqzXQvJvu0ZH2X94qkbaqdjs/6zOL2j1hYX6qi//7lwXIfp2qTO24e9wlqh
         fciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745445213; x=1746050013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wxOEPg2lzGGAAEWxyMxHF7QDi50JL+cgIXLanH/rmg=;
        b=pkGrRQ+GdlTBHT9VP4kQmKpaxJNHETf7nv6pWKDdGrClcZVJKm6tiwA73uDKv4t8XD
         qIXaXfP1EQRHE9AtU2g1A9JDw3Zc8OkRHu7SQSvyYZzAf9qnmLdw0/uMJ1dYm+oNCOuu
         JI0GDVZEpIpaaHVQSqj7HRTjGZgjOvlDG8d7r9TmiJvm7FNOqs1Jc9/7z+I3qRyTBFfy
         gCyii3kx1SCSYCE7yxUb0yZciWSb0m5Fst/3k9tXsYFPAU1v40W0GXfpnCqpI+DPvU1v
         igpCFDq528N9l8w8ZSVm/gaZC4PyiG3d+/lyutQHE9OZ0gOpv8mcTuxzhhj/WdTKqlwH
         P5DA==
X-Forwarded-Encrypted: i=1; AJvYcCXvdPBNDenpWaxxoFOSgrBi0P3S8t8oyWhpYdbIgcDfm9Q1yc7Oyvp2RY1NweptAnfG3m2Xds72IkcRcm2s@vger.kernel.org
X-Gm-Message-State: AOJu0YyeopHmDVjDa0LRGT4NIpxf4O+8fK4B+eqIZayYWQEyPE4zz4oK
	pSJFV2GzSHyfCcWhKE7WtNHwDvZedRgbELvESeijIKox0XiOfDyopr9pmgqvuoSc82TtKmzUPhg
	7SYzAW0o+yye1jZdjUeUj6ajXVxqTMYH4INaZ
X-Gm-Gg: ASbGncvyW67TK5jK+QUynmytQfPvplC6/0sW44jRR8mAKMWx/8cLHZehBlzOgYUwDgd
	pqkodwwbAYgsroCY+ZPuuEp0U63sWwatKzvVXzUyRSRXBzydoRHUJdPyF1a3TAqOwjsDgQVzkkR
	cq99U3SWc68TmLP0WU1vlDiPLJqiMSmnsux0J7Olng4LK1ZKPYuo/x
X-Google-Smtp-Source: AGHT+IFxKf4JMsoiImdRCM9Gv2EFQUjIOz6bkJ3ODyiXPnj15zTxtQdogrWnY80WdKRS5ErJulohCQQ1CRC+j+mpd8k=
X-Received: by 2002:a05:622a:1bab:b0:476:d668:fd1c with SMTP id
 d75a77b69052e-47e79cbfd5emr1736981cf.2.1745445212617; Wed, 23 Apr 2025
 14:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
In-Reply-To: <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Apr 2025 14:53:20 -0700
X-Gm-Features: ATxdqUFczXuJ3MtAVzm6hOXwKgR46ihWvXXCSbcxhMDhIph3juTGEiPJwzlaPbY
Message-ID: <CAJuCfpGQPO5AqiZxfb9JYUqd5suS2C+qWt-_acjU0zFf-g-eGA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 3:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >
> > Utilize speculative vma lookup to find and snapshot a vma without
> > taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurrent
> > address space modifications are detected and the lookup is retried.
> > While we take the mmap_lock for reading during such contention, we
> > do that momentarily only to record new mm_wr_seq counter.
>
> PROCMAP_QUERY is an even more obvious candidate for fully lockless
> speculation, IMO (because it's more obvious that vma's use is
> localized to do_procmap_query(), instead of being spread across
> m_start/m_next and m_show as with seq_file approach). We do
> rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA (no
> mmap_read_lock), use that VMA to produce (speculative) output, and
> then validate that VMA or mm_struct didn't change with
> mmap_lock_speculate_retry(). If it did - retry, if not - we are done.
> No need for vma_copy and any gets/puts, no?

Yeah, since we can simply retry, this should indeed work without
trying to stabilize the vma. I'll update the code to simplify this.
Thanks!

>
> > This change is designed to reduce mmap_lock contention and prevent
> > PROCMAP_QUERY ioctl calls (often a low priority task, such as
> > monitoring/data collection services) from blocking address space
> > updates.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 63 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 55 insertions(+), 8 deletions(-)
> >
>
> [...]

