Return-Path: <linux-fsdevel+bounces-47629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2607AA159F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CD017DAC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F1253334;
	Tue, 29 Apr 2025 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJwS9nVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DA2517AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947504; cv=none; b=DQacA0D/95PPjMU5StrGsunhXE2Nczce46HM5k2XLTKGjVmHJHuJfNlZWzHAyOboejSITNqo3z7stTzGMhDdWKpk0Iu/0axFQDv7X74v8GHWaw8E7YL68gv8/tqe1ozgBIKzAoCWKYul69qR7MDmE4yUej+xoAMkHUBZcoeikkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947504; c=relaxed/simple;
	bh=YZNlpWTu45BvxqqIxegtjX5fVfVe1MKL/1zgFUmY1E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7dAM3N45yR0R6C8BiqNlIRB9CFzm1H1jZYAKtR2hEMhY8CNztTLzODV1fNgGl7kyRWN7omvW5mQQnoj0rp1ExYbLd78falLrEiJhXoPglNEXaeCiDs/qYSWgWSECi2dcDIs96FL0V85Kn5UwHaglzzyEfYBPpo10SHsGgrTDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJwS9nVH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso3371a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745947501; x=1746552301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZNlpWTu45BvxqqIxegtjX5fVfVe1MKL/1zgFUmY1E0=;
        b=KJwS9nVHG5K+LQbyX2Lp+PZQUbtfikrRqqcHsKzT0LyaKErYQvPtkzHES3CGd9ARnG
         zVDfrtmA0/tJCf8HzvIilnMJNBtidqIL5eI/HyKpac9FQBvpMoHQomTI3l3LwSCuBb9c
         EXpcLMJuibNgDG5DKELPSIIR8qM0nra+Sz52lLI7PNXQVaR/UeWi+gDfHe6TIErORFvS
         EVrQtyQnbaRtpAP4HbdvzZ37CFYxccclQm43wAobHQ7jKztawZMV7zNxuoBq4nZtuPDT
         xF9moi/ktWK8R+h42Z9L+9i/wYpQi4NmxzQmcHpUzkWNqR1dT712wOLXUEcibDHBZTUr
         65vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947501; x=1746552301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZNlpWTu45BvxqqIxegtjX5fVfVe1MKL/1zgFUmY1E0=;
        b=gIBbg4KF/iQW9jEhTUO96UA3ZnnI4GOsLWLph9E4gRsXthc0c+NqBL4QmbuqQUA5/P
         O3mbkkcvdMBqpnboiZEHUcr5ZaUGfasqCz+xzKxEPTKAuGNcU9CPLwJxMytuzus6nbba
         6HwbuqVeCIHv9bR484eT696AVJ68kVId0KSLIFtiXzEczEwH4f114JOlNmnoLX1WOGNw
         6ANhQ6W+Wq27PVKXPyqk0ksskcSI8EUzJ4QzaHtAhv8sAKL1PPTHOLZDjzPXIXbLwsYs
         XifHIDOYyzMMlFKFGAFeX4crxMvEBYbQptet4fnIAHgQ5nxEu5bkYQmfAS+e9BqwmBEu
         NjUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUln2B9HiwUG/YqieMqigBR3s1WBPb7sX2JxTWmdjP4vvzSn1UlKl/hNV/7eFOa1f3juvUuRPU/MEfsQmma@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgGKcH3nEwqzM5VdhUm1IvMF36A0k1MYPOSNUKa30XpnEKFbl
	C80N3bmUItbCfjK8/Mwiw6aHcFH0n5bfbF6VIpXQc/kNxb9ZH3uW+p3/G99dxCS55WbEVeL8sh6
	hHXM7ezm2UVjZE1y8CTsR3UU3+5ahI1sFn5Zs
X-Gm-Gg: ASbGnctIGLJ+almaZ7V1mwDN8mATUKgQTO+0ko4g7Sr3A4AjKsepkWqu9lFucVnYldC
	Z07kDHujUOaD1zBIYL7lvbBZaGGylrUTTbFp0xIiK9vBG8pi2kNTCcybw+6UKoHqgLa4jdo3+TS
	tXmBNN1wOV5WFTTYUTDH+m+zQVQNh30TAWDvIka8WcW5zoDp5k+g==
X-Google-Smtp-Source: AGHT+IFQ4OT/08toQML4e1ydyufT1IDTka9yb0vrhYlgRKfv7FERG5Kbei2OqJYLX1P6Hv4sTwQ29rgIx15PTzGkeeg=
X-Received: by 2002:a05:6402:516a:b0:5e4:9ee2:afe1 with SMTP id
 4fb4d7f45d1cf-5f83933ac06mr118420a12.2.1745947500781; Tue, 29 Apr 2025
 10:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
 <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com> <CAJuCfpGxw7L67CvDnTiHN0kdVjFcPoZZ4ZsOHi0=wR7Y2umk0Q@mail.gmail.com>
In-Reply-To: <CAJuCfpGxw7L67CvDnTiHN0kdVjFcPoZZ4ZsOHi0=wR7Y2umk0Q@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Apr 2025 19:24:24 +0200
X-Gm-Features: ATxdqUFzhZAitfkhicfO9Ve5tnFVPmDAwtXF6C9iK9LMhQflCPc-OR-WEacaXck
Message-ID: <CAG48ez1cR+kXBsvk4murYDBBxSzg9g5FSU--P8-BCrMKV6A+KA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Suren Baghdasaryan <surenb@google.com>
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

On Tue, Apr 29, 2025 at 7:15=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Tue, Apr 29, 2025 at 8:56=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Wed, Apr 23, 2025 at 12:54=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > > Utilize speculative vma lookup to find and snapshot a vma without
> > > > taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurrent
> > > > address space modifications are detected and the lookup is retried.
> > > > While we take the mmap_lock for reading during such contention, we
> > > > do that momentarily only to record new mm_wr_seq counter.
> > >
> > > PROCMAP_QUERY is an even more obvious candidate for fully lockless
> > > speculation, IMO (because it's more obvious that vma's use is
> > > localized to do_procmap_query(), instead of being spread across
> > > m_start/m_next and m_show as with seq_file approach). We do
> > > rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA (no
> > > mmap_read_lock), use that VMA to produce (speculative) output, and
> > > then validate that VMA or mm_struct didn't change with
> > > mmap_lock_speculate_retry(). If it did - retry, if not - we are done.
> > > No need for vma_copy and any gets/puts, no?
> >
> > I really strongly dislike this "fully lockless" approach because it
> > means we get data races all over the place, and it gets hard to reason
> > about what happens especially if we do anything other than reading
> > plain data from the VMA. When reading the implementation of
> > do_procmap_query(), at basically every memory read you'd have to think
> > twice as hard to figure out which fields can be concurrently updated
> > elsewhere and whether the subsequent sequence count recheck can
> > recover from the resulting badness.
> >
> > Just as one example, I think get_vma_name() could (depending on
> > compiler optimizations) crash with a NULL deref if the VMA's ->vm_ops
> > pointer is concurrently changed to &vma_dummy_vm_ops by vma_close()
> > between "if (vma->vm_ops && vma->vm_ops->name)" and
> > "vma->vm_ops->name(vma)". And I think this illustrates how the "fully
> > lockless" approach creates more implicit assumptions about the
> > behavior of core MM code, which could be broken by future changes to
> > MM code.
>
> Yeah, I'll need to re-evaluate such an approach after your review. I
> like having get_stable_vma() to obtain a completely stable version of
> the vma in a localized place and then stop worrying about possible
> races. If implemented correctly, would that be enough to address your
> concern, Jann?

Yes, I think a stable local snapshot of the VMA (where tricky data
races are limited to the VMA snapshotting code) is a good tradeoff.

