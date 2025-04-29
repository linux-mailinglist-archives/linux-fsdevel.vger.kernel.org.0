Return-Path: <linux-fsdevel+bounces-47623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E108AA14A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A87A1888D39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7DC2528F3;
	Tue, 29 Apr 2025 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvmqP7+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F86251780
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946907; cv=none; b=PZKljsj55T4lMMt2164eDflP2NMHt7K3+M6HgY6VYW4ik1qfvsk9tgu+7my1EI3UOwzFtLOn8u66EC8A7Je1zyN8FsIUGTZlPtZMQAsvRwFEDAZQvtl/6uJYAKAj1eqa/UeOs2hzQzqAVx0JlLwOUlf0Y6TXZTvjWt4rCMbUyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946907; c=relaxed/simple;
	bh=8N3PFLJdo2BL64kwpJnok05xXM6XlOssovMurdNnZcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIT36XsUOI15UkmEX09AC6mzPgLUj9zjFoyrnOTgsnaWLNq0SBRYpR5CrNnSvuWISC5x8FB+uBFMSOpTG7CQJRhtt+GDIhHnINX83k8dFEdiZX6xkV61cZ33H4dwmRlK7YVYLWs1tQXl7u5Cf4WCqomgJagOnlZmBUr+QRpos6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvmqP7+3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47666573242so360231cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745946904; x=1746551704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N3PFLJdo2BL64kwpJnok05xXM6XlOssovMurdNnZcM=;
        b=yvmqP7+3ya/94l2fLXHmzE6OXyONki4Xwo85mIw4cNtpqTl/qs8hAr2ABt+SaZ0QpA
         MYGuvB4sAXZH6Ii29Hi8yjnPEriSGC569nRP4LCCSSPt3PlHxWeX2nbrJav22e5G/hqL
         maAIK8mfK1UJL4cNT/E4VRzp7BNiPn+pbpEzT5PE9uQvCgDhXzMXvtg7hTfR9Eb0gEdK
         Opl2qfaV3OMjpjpitYgTUd2z6gDLjVLWMNIuxsTc33v76DvuaImb93farIhfhf18apM9
         TQGc7+fPjcKhRm86LJY1thr/z+K4jka+VRSsTiKOhBEYDvskkYvAnkeW7zwSb+EtaMFs
         rpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946904; x=1746551704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N3PFLJdo2BL64kwpJnok05xXM6XlOssovMurdNnZcM=;
        b=w25n3hFXebMjuNXGH9PWeo3nQch7Z/+xcXDnbsbqHHr+p+2kJqNf9cFGLs9eeq4z3V
         iAfd7DIugin7eRoBRR75YhSns6sS7QDuH9qYC2+gtPokPAuN9RPdDLFiknvG/3BRimL3
         BvK6iK2lXZbSlw6ZR6/suPNsSNF4YZSEB9AagUOOFHstueXgWSz4GVvyyOYf89DQwi2a
         mkRLGYKxgD/koTKQrcF1smUzAoLOn6Mot5Xo+5u9RTmVnIpx1BwmDeaGNObTZiIbjVMv
         DDduX5ae72jPJZNNGjY20bh+utabGhLOL0x/vG67UNVHlYj8EIxCNyiyzZXQOEaUpdAQ
         MQQA==
X-Forwarded-Encrypted: i=1; AJvYcCXdrbTBKl+tF6Q2XwZ7Xviv/cJBZ0dhX9GiEOEEua3XFaQyNytzewlgrthzm9nxrJ3o2mv0ps7tp6+aGj0C@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvcHr2LU3RW66/JBUAKqQLiSrVrpCGyhI2acrtmAzOPgIuXwk
	haOb0ZR2oK6XGr3wXxrmSFeImiw1itPGzVk80uqWGiUKgmdmh23gu04oU09YyT6ZFF5jlJkg2Fx
	GrWQeGEQzCWITpJnl5oTm3Z6h3U5Dst3ZG3j+
X-Gm-Gg: ASbGncto841AizUG1ev5b5DUrvK0gBDx+UzBd8QGLAVWOlwlO0yfJuDAoBcZPRsWB7M
	Nijax3TLo2myvDB1oTsKMdXtDbYR844FIydEpgfELbQkIS4VrjgD8VXkxZtMgSQC7DZ4Rzo8uWN
	BhOXHE35lacNCVvw8COgFj5bN95ltQbxkFspfL9wr21R0wydj/hT9e
X-Google-Smtp-Source: AGHT+IHc2d7Lags5IXA2jqjdd8Wrmu7oiMjs4V+SDYbkXeZnsbeXFEB5FbDmi3+9UCay73uMesmQXy8B2gOJYxFd2N0=
X-Received: by 2002:a05:622a:1ba7:b0:47d:cdd2:8290 with SMTP id
 d75a77b69052e-488a5dee905mr4983031cf.9.1745946904330; Tue, 29 Apr 2025
 10:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com> <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com>
In-Reply-To: <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 10:14:52 -0700
X-Gm-Features: ATxdqUGDGzBEh9QYdQgSp_gL9D3xJRJOqR7cGNBprwi1rNdXNpRqj3ts5tZZ_ww
Message-ID: <CAJuCfpGxw7L67CvDnTiHN0kdVjFcPoZZ4ZsOHi0=wR7Y2umk0Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:56=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Apr 23, 2025 at 12:54=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > Utilize speculative vma lookup to find and snapshot a vma without
> > > taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurrent
> > > address space modifications are detected and the lookup is retried.
> > > While we take the mmap_lock for reading during such contention, we
> > > do that momentarily only to record new mm_wr_seq counter.
> >
> > PROCMAP_QUERY is an even more obvious candidate for fully lockless
> > speculation, IMO (because it's more obvious that vma's use is
> > localized to do_procmap_query(), instead of being spread across
> > m_start/m_next and m_show as with seq_file approach). We do
> > rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA (no
> > mmap_read_lock), use that VMA to produce (speculative) output, and
> > then validate that VMA or mm_struct didn't change with
> > mmap_lock_speculate_retry(). If it did - retry, if not - we are done.
> > No need for vma_copy and any gets/puts, no?
>
> I really strongly dislike this "fully lockless" approach because it
> means we get data races all over the place, and it gets hard to reason
> about what happens especially if we do anything other than reading
> plain data from the VMA. When reading the implementation of
> do_procmap_query(), at basically every memory read you'd have to think
> twice as hard to figure out which fields can be concurrently updated
> elsewhere and whether the subsequent sequence count recheck can
> recover from the resulting badness.
>
> Just as one example, I think get_vma_name() could (depending on
> compiler optimizations) crash with a NULL deref if the VMA's ->vm_ops
> pointer is concurrently changed to &vma_dummy_vm_ops by vma_close()
> between "if (vma->vm_ops && vma->vm_ops->name)" and
> "vma->vm_ops->name(vma)". And I think this illustrates how the "fully
> lockless" approach creates more implicit assumptions about the
> behavior of core MM code, which could be broken by future changes to
> MM code.

Yeah, I'll need to re-evaluate such an approach after your review. I
like having get_stable_vma() to obtain a completely stable version of
the vma in a localized place and then stop worrying about possible
races. If implemented correctly, would that be enough to address your
concern, Jann?

