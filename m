Return-Path: <linux-fsdevel+bounces-47937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13424AA7709
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 18:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1309D3B9055
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537925E45F;
	Fri,  2 May 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5tK/zxQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654E2580C4
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202581; cv=none; b=KEQLqxzG8oKRejCqTIksjNQJSNjP11lrjimC0P5ad0vdXeBxiS9dQfohOqbelpCxxGiNxM69shP3CiUgWNUK8SLK6fPRw3bvfCj9oY2ORq0a8xHcNnBFYgWkvMpsVJ5PLH9fBBQ3gWPfbSEfscTLcwakGupk8vgxq2+RrE/8eWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202581; c=relaxed/simple;
	bh=58bSUz7jJ2p8+5qkdJcblMgTqYam8GfQ6+npz5F5H34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsOXgvAP0kyKHeG+mU2iibBNlb+owxpdVT+07r3pD8bTvnz+xLvas/ektifgxGEtVW+YstbU92E4vuTD2y5wBOyazT8vBhZHs+HjIjxzE+gStGlMVDf2vIUCjhIFO+StxLHlhtA89wrVhLerWtQz9WgbtgwGjWJWwysNB8cXLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L5tK/zxQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47e9fea29easo322001cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746202578; x=1746807378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58bSUz7jJ2p8+5qkdJcblMgTqYam8GfQ6+npz5F5H34=;
        b=L5tK/zxQj2s3TTqqrgsSI5i8k7QTmfhkv04vHQHPZKspc39cdjXOZM6XO1VqUMECvt
         4KnwfnknBr2/+Ue/CPoO5A0m1cIVAvgH5yHf27uNMjtzYji96fO/DH7pmVXPUaKCvkFi
         02LVUc3aHyeLrkc25LrPk5a+2DUjtXcudhGK3QuwOXjXAJMiozJFxaspHcfdaVJ9v5CA
         9/q3aWnu0WBSNR9qc8lEodCQMY4Ex3hnyIi2G3sA0rr7yNMf0NK7F0yjI6nz1n2OD7H7
         eVx/11BEHDsbbrR3W/8VxOPNdLOLGctxQdGr8wtVKmPI4EqNfOfU9LFVNTTVzVTv8A0n
         rMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202578; x=1746807378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58bSUz7jJ2p8+5qkdJcblMgTqYam8GfQ6+npz5F5H34=;
        b=drEReIcTO4BtuEaa2KK+INS6kgpcpavaI4owNzmHZ/VkdsBQeJr92tVhZetsud/s/x
         qc6SBU14KNjxUWIwrMTrLJh0SjoKsRPhHGRsuXsyy2b+qY5HeC+uRAqwgTc+0XC5SwiE
         Q2OyHfs5KHB+S5BH+uripk/lKgxo3VBOQVbAySEUYNqx0ja7UHQjyD1payqOgdlWFsZy
         kauuI3QaMJ3Dl4Q5MpqA8+cRKHhpIRzHmyqXRI8Wf8sBwPNTbWVmMQ+g8lA2UUfeC/+L
         A+AaL0v/s3AOq716EQx1PGW2+R697QgKVbd0d8uHPd1l4FEKDm0N8MmcQurftv5Ufrva
         bQsA==
X-Forwarded-Encrypted: i=1; AJvYcCWqPQnGKYGb2tdkPqNGHn8Ae/WJ+gSaU62HsNi1vBlcnYcsQ/3hLqfz1dYhJHa9zes2G63+fzhwKR9boxFb@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDgiR7jqAgKanUOi2UERnaCzHVPFdDf0tfjV+5pDxeaY9PHqx
	bpkjvh0OwfdCWy4C/wvFYLbGGGOE2kaDpTIcXrxLgGTjE/0mv9ldpM7bZHVBY/oqNL2g+GGYcSe
	n855aDXovmhWcTFu1P96J5uOsGbnhlCjzrwrs
X-Gm-Gg: ASbGnctpYd8Qzo5m/COmEM6MDXha5mz4OReq94zxpYJ4oJ5dFMRO++J+ZrLfDfsYjcV
	EComCV1fbPlozpR8mc6rr0zJcC2Oo6WmR4p6guLitPoe/Pu5AyIsSlO2shcI9tiaQBM5EV69iWr
	vDWr3/tkLGC5lqSCkhI7mBxVgqvL1u9eZfLRupyCgEOELgOm906Q==
X-Google-Smtp-Source: AGHT+IF8L2+CCwV5k84zUeiwruyaxm/9IB09bfyjXX6Acxns+WD6FRjO3eDCBsRxkWxyNifDbB4FnnkHPTpIweEMoLU=
X-Received: by 2002:a05:622a:11:b0:486:8711:19af with SMTP id
 d75a77b69052e-48ae773409emr10652821cf.0.1746202577791; Fri, 02 May 2025
 09:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
 <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com>
 <CAJuCfpGxw7L67CvDnTiHN0kdVjFcPoZZ4ZsOHi0=wR7Y2umk0Q@mail.gmail.com>
 <CAG48ez1cR+kXBsvk4murYDBBxSzg9g5FSU--P8-BCrMKV6A+KA@mail.gmail.com>
 <CAEf4BzarQAmj477Lyp2aS0i2RM4JaxnAVvem6Kz-Eh1a5x-=6A@mail.gmail.com> <CAG48ez2tQsqS3+ZfSus+Wi5ur6HbYuaAhhmOOrkDyrZG+gsvXg@mail.gmail.com>
In-Reply-To: <CAG48ez2tQsqS3+ZfSus+Wi5ur6HbYuaAhhmOOrkDyrZG+gsvXg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 2 May 2025 16:16:06 +0000
X-Gm-Features: ATxdqUE5eBihdzh_T37nNq-zp7SiYqV-8pNUMisZD5AepZKCzib88UxNXda6nVs
Message-ID: <CAJuCfpGMJFM3Y_wXu+16Ha4LZx7gteucG478xZK6M9ZTWM297A@mail.gmail.com>
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

On Fri, May 2, 2025 at 3:11=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, May 2, 2025 at 12:10=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Apr 29, 2025 at 10:25=E2=80=AFAM Jann Horn <jannh@google.com> w=
rote:
> > > On Tue, Apr 29, 2025 at 7:15=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > > On Tue, Apr 29, 2025 at 8:56=E2=80=AFAM Jann Horn <jannh@google.com=
> wrote:
> > > > > On Wed, Apr 23, 2025 at 12:54=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <su=
renb@google.com> wrote:
> > > > > > > Utilize speculative vma lookup to find and snapshot a vma wit=
hout
> > > > > > > taking mmap_lock during PROCMAP_QUERY ioctl execution. Concur=
rent
> > > > > > > address space modifications are detected and the lookup is re=
tried.
> > > > > > > While we take the mmap_lock for reading during such contentio=
n, we
> > > > > > > do that momentarily only to record new mm_wr_seq counter.
> > > > > >
> > > > > > PROCMAP_QUERY is an even more obvious candidate for fully lockl=
ess
> > > > > > speculation, IMO (because it's more obvious that vma's use is
> > > > > > localized to do_procmap_query(), instead of being spread across
> > > > > > m_start/m_next and m_show as with seq_file approach). We do
> > > > > > rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA=
 (no
> > > > > > mmap_read_lock), use that VMA to produce (speculative) output, =
and
> > > > > > then validate that VMA or mm_struct didn't change with
> > > > > > mmap_lock_speculate_retry(). If it did - retry, if not - we are=
 done.
> > > > > > No need for vma_copy and any gets/puts, no?
> > > > >
> > > > > I really strongly dislike this "fully lockless" approach because =
it
> > > > > means we get data races all over the place, and it gets hard to r=
eason
> > > > > about what happens especially if we do anything other than readin=
g
> > > > > plain data from the VMA. When reading the implementation of
> > > > > do_procmap_query(), at basically every memory read you'd have to =
think
> > > > > twice as hard to figure out which fields can be concurrently upda=
ted
> > > > > elsewhere and whether the subsequent sequence count recheck can
> > > > > recover from the resulting badness.
> > > > >
> > > > > Just as one example, I think get_vma_name() could (depending on
> > > > > compiler optimizations) crash with a NULL deref if the VMA's ->vm=
_ops
> > > > > pointer is concurrently changed to &vma_dummy_vm_ops by vma_close=
()
> > > > > between "if (vma->vm_ops && vma->vm_ops->name)" and
> > > > > "vma->vm_ops->name(vma)". And I think this illustrates how the "f=
ully
> > > > > lockless" approach creates more implicit assumptions about the
> > > > > behavior of core MM code, which could be broken by future changes=
 to
> > > > > MM code.
> > > >
> > > > Yeah, I'll need to re-evaluate such an approach after your review. =
I
> > > > like having get_stable_vma() to obtain a completely stable version =
of
> > > > the vma in a localized place and then stop worrying about possible
> > > > races. If implemented correctly, would that be enough to address yo=
ur
> > > > concern, Jann?
> > >
> > > Yes, I think a stable local snapshot of the VMA (where tricky data
> > > races are limited to the VMA snapshotting code) is a good tradeoff.
> >
> > I'm not sure I agree with VMA snapshot being better either, tbh. It is
> > error-prone to have a byte-by-byte local copy of VMA (which isn't
> > really that VMA anymore), and passing it into ops callbacks (which
> > expect "real" VMA)... Who guarantees that this won't backfire,
> > depending on vm_ops implementations? And constantly copying 176+ bytes
> > just to access a few fields out of it is a bit unfortunate...
>
> Yeah, we shouldn't be passing VMA snapshots into ops callbacks, I
> agree that we need to fall back to using proper locking for that.

Yes, I'm exploring the option of falling back to per-vma locking to
stabilize the VMA when its reference is used in vm_ops.

>
> > Also taking mmap_read_lock() sort of defeats the point of "RCU-only
> > access". It's still locking/unlocking and bouncing cache lines between
> > writer and reader frequently. How slow is per-VMA formatting?
>
> I think this mainly does two things?
>
> 1. It shifts the latency burden of concurrent access toward the reader
> a bit, essentially allowing writers to preempt this type of reader to
> some extent.
> 2. It avoids bouncing cache lines between this type of reader and
> other *readers*.
>
> > If we
> > take mmap_read_lock, format VMA information into a buffer under this
> > lock, and drop the mmap_read_lock, would it really be that much slower
> > compared to what Suren is doing in this patch set? And if no, that
> > would be so much simpler compared to this semi-locked/semi-RCU way
> > that is added in this patch set, no?

The problem this patch is trying to address is low priority readers
blocking a high priority writer. Taking mmap_read_lock for each VMA
will not help solve this problem. If we have to use locking then
taking per-vma lock would at least narrow down the contention scope
from the entire address space to individual VMAs.

>
> > But I do agree that vma->vm_ops->name access is hard to do in a
> > completely lockless way reliably. But also how frequently VMAs have
> > custom names/anon_vma_name?
>
> I think there are typically two VMAs with vm_ops->name per MM, vvar
> and vdso. (Since you also asked about anon_vma_name: I think
> anon_vma_name is more frequent than that on Android, there seem to be
> 58 of those VMAs even in a simple "cat" process.)
>
> > What if we detect that VMA has some
> > "fancy" functionality (like this custom name thing), and just fallback
> > to mmap_read_lock-protected logic, which needs to be supported as a
> > fallback even for lockless approach?
> >
> > This way we can process most (typical) VMAs completely locklessly,
> > while not adding any extra assumptions for all the potentially
> > complicated data pieces. WDYT?

The option I'm currently contemplating is using per-vma locks to deal
with "fancy" cases and to do snapshotting otherwise. We have several
options with different levels of complexity vs performance tradeoffs
and finding the right balance will require some experimentation. I'll
likely need Paul's help soon to run his testcase with different
versions.

>
> And then we'd also use the fallback path if karg.build_id_size is set?
> And I guess we also need it if the VMA is hugetlb, because of
> vma_kernel_pagesize()? And use READ_ONCE() in places like
> vma_is_initial_heap()/vma_is_initial_stack()/arch_vma_name() for
> accessing both the VMA and the MM?
>
> And on top of that, we'd have to open-code/change anything that
> currently uses the ->vm_ops (such as vma_kernel_pagesize()), because
> between us checking the type of the VMA and later accessing ->vm_ops,
> the VMA object could have been reallocated with different ->vm_ops?
>
> I still don't like the idea of pushing the complexity of "the VMA
> contents are unstable, and every read from the VMA object may return
> data about a logically different VMA" down into these various helpers.
> In my mind, making the API contract "The VMA contents can be an
> internally consistent snapshot" to the API contract for these helpers
> constrains the weirdness a bit more - though I guess the helpers will
> still need READ_ONCE() for accessing properties of the MM either
> way...

