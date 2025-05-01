Return-Path: <linux-fsdevel+bounces-47874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F17AA660B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 00:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF4D464E34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 22:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56518262FEF;
	Thu,  1 May 2025 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3D/VrlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC020E718;
	Thu,  1 May 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137428; cv=none; b=enye2+9eWg/vHwMYPNGM3Nyn2ZIJJesKnWuO2BD6RlAjfLzywTkEwnYLSK/6YPzm9q6iaD+KksHuiM4jvZ8sdxmsKNntdkPUyiv5QhrFjERfzxyPZnY/LXvfPpcHCv4V+o0lJW49ytV1AQY3m/kcBQjy2QhBF4W8ZuF5mX+35Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137428; c=relaxed/simple;
	bh=BWPyE4Z62SctOURTQUDtHt2c4dEB0jFXGMMvw9+2hRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3vV+5ajUpHQeEoMc8HaQF6FH84oqQOsXIqNeYwRpnUgsgsnifhFPbFBqsuI7L6nGHMmcHxF0UR6O3sMNW+bwhEJVJjKXrmIBHPK8plyJJS3DaebJ+m4GKgwbt9lJbEVkrSgLM99unW+bvFBfRr+KUf3vkn9oXwdy1hD7sFjges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3D/VrlP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1233547a12.3;
        Thu, 01 May 2025 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746137426; x=1746742226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWPyE4Z62SctOURTQUDtHt2c4dEB0jFXGMMvw9+2hRI=;
        b=J3D/VrlPWMDN3IayYwIijCtCIXKy0Bb2JQp8Rk4lOEZhkvZlEMemmf9syEx4o4hE5e
         ZzQiqYAOIAkPWmKcVHeu8mLfLyKrYj/eP61IsN6HwaoN994W56CRfeC8WufNNWmNu5p0
         h2ydvyvMMAdboeL8CGgm54LL5WB5DO8q6WcUTf/pDUtQVYLqzFVpWUUu2b380/ngDPxW
         A6ABSED0mT2Rt1LVnh33QYRPLNQoohWS4Qbc9wiBGnP0hZOLe6CVtotAD8QZX/7nqvdh
         6imV0GjkPKc7w4Ts7zvCe4xIK+ViPELazge90LiKNkFPM1lupyD4ZLjRk/FzoamPJ6iJ
         cgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137426; x=1746742226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWPyE4Z62SctOURTQUDtHt2c4dEB0jFXGMMvw9+2hRI=;
        b=mjo+8VJyLcG0ruVEcxRm4ZqrYxu+GqQX4v7O/vOV5ySacymcStVjdsIbKLNSJm7ii5
         NVMdF68+R2c96ZwdOodl50qRZ/MIeRCpQCU9w2/HA/YdVQD1il/omolSWJNjMM3/qngG
         S7lpUvAt0ui3BBSjWGJxwtsjeFzvr/rXBCIjhB2Cfa7ykZ/2mtCU61xagmDmmtW2SMaS
         xTQmoFSBRC04yk/5gpDGzn3oR3j65LltM5CQbG4UjH+Acw6AAnrw32XSqtEelo6MYTD5
         oNJE5hw5zoRgyQUnBFZqfUGdSjx6/gEXJk/e5Z0qPLrx5LxINSvm4JIfN6xyaetBn3ch
         sOUg==
X-Forwarded-Encrypted: i=1; AJvYcCV/3mwbzuWH/fV5dCAdCQ0aQfZJFJYMFnzDK6AzhoXTAXgDUt6u93js/Z9DBuhPurb0bFfMhqWY0ta+TXTx@vger.kernel.org, AJvYcCVGvuLD3ENOqAmkVkIBV2NLfWx3D5qLNCBZHqmMPAmacTiDWOg0vw7rqJ1XPRBdxJdJsM2XHH80giGO5x9qa7WY@vger.kernel.org, AJvYcCXrZOcAkG92LQJKqtAIs3v2fv+eO4GS5yVVhcamEr2bn0z25m2xmnLDQgwYpqDPCga/eefCP/GfPxuzbm5m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6uIbOS3P10I/FV51SGQpsMKgGGtgAk5zK41zkwp6nskHJJ7PN
	nfqiCXgVix3RqXuN6yHEeuIforTOWWjPEHYaedjdZIV96AHJxecZQN48pPR2Hm3QkvVGswlLB59
	MV+YpmBg06nGUZpl/8pG+RDGa3jg=
X-Gm-Gg: ASbGncvfOo0jq05PhkLWzTjx5iRSFKvAmbgylADSGcNYa2Eff1Lv2QjVDzRTipUY7jJ
	BYeL7PJtke2VIkKL53MPoyhlpDvSei72qxvNg/eX8u4QJz6WOTN6avmrZf4uOPNBERyBqyk9Q6Q
	qAL5ii/aAj6sWX9r0Q2ufxN9Fq22YiLIL7aHdmhg==
X-Google-Smtp-Source: AGHT+IEukHCiv0n/JvQlnVisQ9NcpDWiULJyzG9ulukDSWHzwhVlDHhrNnmb5DBXCR9VMAyD/hB4fECHCyyHgmDkii8=
X-Received: by 2002:a17:90b:548d:b0:30a:4c29:4c9c with SMTP id
 98e67ed59e1d1-30a4e55e265mr1047516a91.6.1746137426343; Thu, 01 May 2025
 15:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
 <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com>
 <CAJuCfpGxw7L67CvDnTiHN0kdVjFcPoZZ4ZsOHi0=wR7Y2umk0Q@mail.gmail.com> <CAG48ez1cR+kXBsvk4murYDBBxSzg9g5FSU--P8-BCrMKV6A+KA@mail.gmail.com>
In-Reply-To: <CAG48ez1cR+kXBsvk4murYDBBxSzg9g5FSU--P8-BCrMKV6A+KA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 15:10:13 -0700
X-Gm-Features: ATxdqUExe7F77b22Qk2zjYQs6MWIUlgh62k8s1E89d2IVsrOwf_AG7qP5_ERJcs
Message-ID: <CAEf4BzarQAmj477Lyp2aS0i2RM4JaxnAVvem6Kz-Eh1a5x-=6A@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:25=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Tue, Apr 29, 2025 at 7:15=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > On Tue, Apr 29, 2025 at 8:56=E2=80=AFAM Jann Horn <jannh@google.com> wr=
ote:
> > > On Wed, Apr 23, 2025 at 12:54=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb=
@google.com> wrote:
> > > > > Utilize speculative vma lookup to find and snapshot a vma without
> > > > > taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurrent
> > > > > address space modifications are detected and the lookup is retrie=
d.
> > > > > While we take the mmap_lock for reading during such contention, w=
e
> > > > > do that momentarily only to record new mm_wr_seq counter.
> > > >
> > > > PROCMAP_QUERY is an even more obvious candidate for fully lockless
> > > > speculation, IMO (because it's more obvious that vma's use is
> > > > localized to do_procmap_query(), instead of being spread across
> > > > m_start/m_next and m_show as with seq_file approach). We do
> > > > rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA (no
> > > > mmap_read_lock), use that VMA to produce (speculative) output, and
> > > > then validate that VMA or mm_struct didn't change with
> > > > mmap_lock_speculate_retry(). If it did - retry, if not - we are don=
e.
> > > > No need for vma_copy and any gets/puts, no?
> > >
> > > I really strongly dislike this "fully lockless" approach because it
> > > means we get data races all over the place, and it gets hard to reaso=
n
> > > about what happens especially if we do anything other than reading
> > > plain data from the VMA. When reading the implementation of
> > > do_procmap_query(), at basically every memory read you'd have to thin=
k
> > > twice as hard to figure out which fields can be concurrently updated
> > > elsewhere and whether the subsequent sequence count recheck can
> > > recover from the resulting badness.
> > >
> > > Just as one example, I think get_vma_name() could (depending on
> > > compiler optimizations) crash with a NULL deref if the VMA's ->vm_ops
> > > pointer is concurrently changed to &vma_dummy_vm_ops by vma_close()
> > > between "if (vma->vm_ops && vma->vm_ops->name)" and
> > > "vma->vm_ops->name(vma)". And I think this illustrates how the "fully
> > > lockless" approach creates more implicit assumptions about the
> > > behavior of core MM code, which could be broken by future changes to
> > > MM code.
> >
> > Yeah, I'll need to re-evaluate such an approach after your review. I
> > like having get_stable_vma() to obtain a completely stable version of
> > the vma in a localized place and then stop worrying about possible
> > races. If implemented correctly, would that be enough to address your
> > concern, Jann?
>
> Yes, I think a stable local snapshot of the VMA (where tricky data
> races are limited to the VMA snapshotting code) is a good tradeoff.

I'm not sure I agree with VMA snapshot being better either, tbh. It is
error-prone to have a byte-by-byte local copy of VMA (which isn't
really that VMA anymore), and passing it into ops callbacks (which
expect "real" VMA)... Who guarantees that this won't backfire,
depending on vm_ops implementations? And constantly copying 176+ bytes
just to access a few fields out of it is a bit unfortunate...

Also taking mmap_read_lock() sort of defeats the point of "RCU-only
access". It's still locking/unlocking and bouncing cache lines between
writer and reader frequently. How slow is per-VMA formatting? If we
take mmap_read_lock, format VMA information into a buffer under this
lock, and drop the mmap_read_lock, would it really be that much slower
compared to what Suren is doing in this patch set? And if no, that
would be so much simpler compared to this semi-locked/semi-RCU way
that is added in this patch set, no?

But I do agree that vma->vm_ops->name access is hard to do in a
completely lockless way reliably. But also how frequently VMAs have
custom names/anon_vma_name? What if we detect that VMA has some
"fancy" functionality (like this custom name thing), and just fallback
to mmap_read_lock-protected logic, which needs to be supported as a
fallback even for lockless approach?

This way we can process most (typical) VMAs completely locklessly,
while not adding any extra assumptions for all the potentially
complicated data pieces. WDYT?

