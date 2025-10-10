Return-Path: <linux-fsdevel+bounces-63818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9ABCEACE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 00:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F89C3BD5E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 22:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B43A271456;
	Fri, 10 Oct 2025 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usR0BRci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018F26B75B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134172; cv=none; b=JD88ZnHqsAjh8R+GmovPmVyNWckTyaEPw4eY0P0oUPHl1arFTq9aMNse90z2Ii9q72pH70Sf0lyMimlWRYAaBGV0e76KGjjqKT+j54Kv1TJfzahyjWmb7XkdKRaDmHcB+ILQK2TuGyEs8s4l7um00A+Z7fl1jB93I35IznZv3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134172; c=relaxed/simple;
	bh=whVp2qZBbeukaKmVgYtaHYfETEJJ1mPdQ4+rkrdkiFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOKA/AEop4ukk8Kp+AgN4iuvIKUslGRa2tbuUGGoa2goEpDPK01eJjn22qk3IAUL9F6KnNq/4WeDk1xxsyufo8ZEpLNrdhDntkqsmIw5n1d2zeAMJ8Q6dj4WORQp6gr6SvkQkdVRj7xvN60qHk/bIen0KVK+sktVGS3u8wlhSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usR0BRci; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42f6af58c39so239695ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760134170; x=1760738970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWDl81NsDb6bdxq6lZZ3Oo5fI0gR9e+s7CI7q6rmrnY=;
        b=usR0BRci7nddDMA6iJ6L1009QdlirFVjhD2WLO3S3NXVc28MeMK73hVJeq0tZSiCBU
         tQprU2DzAxS9jED2GLlXgmaYqJQRpblsRniyTGCNwiCHGFWJYSnSdty/+zuU2WRpbuz8
         7M3ELRMyLHaEf7Nh5HLdDm9UbowO4EMU22MWnMYBXlNxgKvi8updyIfh9M+gSgFu7wkl
         eFdczo+DzoUdH77wE+2J7m1nNvePRbvBvYL+SUQSR7NqwYPzGpf9Qa/NVgKe3UqIPd7+
         il2UM5/moAJp337sA/44HcuPRBx+dmlD9J5Dd7B4OQWoK31KU5qrC/LLcPLTyY0j5QVn
         rsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134170; x=1760738970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWDl81NsDb6bdxq6lZZ3Oo5fI0gR9e+s7CI7q6rmrnY=;
        b=AsuYmpThtBXVlhc4XsvjXarrnJIWeob28TjgHYi7s/4Y1KrM6cYM3zoVCBkapUsAX5
         CBfoASvq4jtmhkliuT7ENs6pPaZlC1hBNoFQyP+17KqY4ZXGHwyDSfiPeUyZVCGrprN5
         LgjwXCfyQEYhLvLxdOEDSN1iXTQBct8PZLTJShXRgCf3H1IfAkzKdpkZ+U0Dio4+aPSK
         sPd3sO/XEM3T5pPKvEllb/b0adoxsvexUJTNQEGd/oBJpLGQ2ZCwQ+rvIi6oY7EKiM5Y
         51cx1h6wEhtN4Fj+5U2mfSckgiE8hhKSRat/sAb/g+IxXsY3GlYSCRcc3+d2UsSRGe8G
         7KIA==
X-Forwarded-Encrypted: i=1; AJvYcCXX2JLT98y6+65DXb+nt+SyGwGJ5785fjyemHZZv6aX7x7zKwPKWz50W1DlZkPhw2cNcdIZQlxPSC8kqoLG@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9X/AmrE29q1e4RRxlURxOp2kXcHcULHviBkSkD+WQ3Ium/2U
	3brcUD/6siJ66FSIfznibj7HZbIygipHGucUNXvR97rNLELsF5taVW5uS07ctfjM1de6xUM/43h
	w4PXnTipX41qR9cax9g5bJm87mKT6JGzcWQ7UbMgx
X-Gm-Gg: ASbGnctdg4OXP+fANFRAM8abi+uxcuYqewNp7pRnV7gtGd3wc804Xu1Yk+EuxD8SiGm
	xdiLPf1RBbuvftRfbv1jbja2Ed//czD8fk09iLt3IiQZ60e5viiZi/1kACRkhDJOAR+fxzxabWI
	Nk2c+u8Ba002NilIKuf9a8WRKYYrAbgwuNWwH8ovBpU9e41rEtTrtC2oxA9ndzdSzHT3jFEMnfb
	9E6NqJcw/e0vI7Uq6OiRtWNenQpOdY=
X-Google-Smtp-Source: AGHT+IEheEysfffoa2UToJd25UhCG01OYZFDrESO0ecdrZ/jfSjqLqSlKoaOdjO8BC9OyiGuvNfvS8dJfmUrxJvS6qg=
X-Received: by 2002:a05:622a:1111:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4e6eabcef17mr26585351cf.11.1760134169530; Fri, 10 Oct 2025
 15:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-7-surenb@google.com> <20251010202034.58002-1-sj@kernel.org>
In-Reply-To: <20251010202034.58002-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 10 Oct 2025 15:09:18 -0700
X-Gm-Features: AS18NWAqrvtXxssXuPoUdtLG3YkWXccAtAeaTjudhXcSXDHpPbRX_NTpHoxKXI4
Message-ID: <CAJuCfpHmLpE-7U2_efn9XqK=3SM+zRw-jUkDgJRBW=2tWZTepg@mail.gmail.com>
Subject: Re: [PATCH 6/8] add cleancache documentation
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, willy@infradead.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, hannes@cmpxchg.org, 
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:20=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hello Suren,

Hi SJ!

>
> On Thu,  9 Oct 2025 18:19:49 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Document cleancache, it's APIs and sysfs interface.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  Documentation/mm/cleancache.rst | 112 ++++++++++++++++++++++++++++++++
> >  MAINTAINERS                     |   1 +
>
> I think this great document is better to be linked on mm/index.rst.

Ack.

>
> Also, would it make sense to split the sysfs interface part and put under
> Documentation/admin-guide/mm/ ?

Hmm. I guess that makes sense.

>
> >  2 files changed, 113 insertions(+)
> >  create mode 100644 Documentation/mm/cleancache.rst
> >
> > diff --git a/Documentation/mm/cleancache.rst b/Documentation/mm/cleanca=
che.rst
> > new file mode 100644
> > index 000000000000..deaf7de51829
> > --- /dev/null
> > +++ b/Documentation/mm/cleancache.rst
> > @@ -0,0 +1,112 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Cleancache
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Motivation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Cleancache is a feature to utilize unused reserved memory for extendin=
g
> > +page cache.
> > +
> > +Cleancache can be thought of as a folio-granularity victim cache for c=
lean
> > +file-backed pages that the kernel's pageframe replacement algorithm (P=
FRA)
> > +would like to keep around, but can't since there isn't enough memory. =
So
> > +when the PFRA "evicts" a folio, it stores the data contained in the fo=
lio
> > +into cleancache memory which is not directly accessible or addressable=
 by
> > +the kernel (transcendent memory) and is of unknown and possibly
> > +time-varying size.
>
> IMHO, "(transcendent memory)" better to be dropped, as it has removed by =
commit
> 814bbf49dcd0 ("xen: remove tmem driver").

Ah, good point. Will remove.

>
> > +
> > +Later, when a filesystem wishes to access a folio in a file on disk, i=
t
> > +first checks cleancache to see if it already contains required data; i=
f it
> > +does, the folio data is copied into the kernel and a disk access is
> > +avoided.
> > +
> > +The memory cleancache uses is donated by other system components, whic=
h
> > +reserve memory not directly addressable by the kernel. By donating thi=
s
> > +memory to cleancache, the memory owner enables its utilization while i=
t
> > +is not used. Memory donation is done using cleancache backend API and =
any
> > +donated memory can be taken back at any time by its donor without no d=
elay
>
> "without delay" or "with no delay" ?

Ack. Will change to "without delay"

>
> > +and with guarantees success. Since cleancache uses this memory only to
> > +store clean file-backed data, it can be dropped at any time and theref=
ore
> > +the donor's request to take back the memory can be always satisfied.
> > +
> > +Implementation Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Cleancache "backend" (donor that provides transcendent memory), regist=
ers
>
> Again, "transcendent memory" part seems better to be dropped.

Ack.

>
> > +itself with cleancache "frontend" and received a unique pool_id which =
it
> > +can use in all later API calls to identify the pool of folios it donat=
es.
> > +Once registered, backend can call cleancache_backend_put_folio() or
> > +cleancache_backend_put_folios() to donate memory to cleancache. Note t=
hat
> > +cleancache currently supports only 0-order folios and will not accept
> > +larger-order ones. Once the backend needs that memory back, it can get=
 it
> > +by calling cleancache_backend_get_folio(). Only the original backend c=
an
> > +take the folio it donated from the cleancache.
> > +
> > +Kernel uses cleancache by first calling cleancache_add_fs() to registe=
r
> > +each file system and then using a combination of cleancache_store_foli=
o(),
> > +cleancache_restore_folio(), cleancache_invalidate_{folio|inode} to sto=
re,
> > +restore and invalidate folio content.
> > +cleancache_{start|end}_inode_walk() are used to walk over folios insid=
e
> > +an inode and cleancache_restore_from_inode() is used to restore folios
> > +during such walks.
> > +
> > +From kernel's point of view folios which are copied into cleancache ha=
ve
> > +an indefinite lifetime which is completely unknowable by the kernel an=
d so
> > +may or may not still be in cleancache at any later time. Thus, as its =
name
> > +implies, cleancache is not suitable for dirty folios. Cleancache has
> > +complete discretion over what folios to preserve and what folios to di=
scard
> > +and when.
> > +
> > +Cleancache Performance Metrics
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +
> > +If CONFIG_CLEANCACHE_SYSFS is enabled, monitoring of cleancache perfor=
mance
> > +can be done via sysfs in the `/sys/kernel/mm/cleancache` directory.
> > +The effectiveness of cleancache can be measured (across all filesystem=
s)
> > +with provided stats.
> > +Global stats are published directly under `/sys/kernel/mm/cleancache` =
and
> > +include:
>
> ``/sys/kernel/mm/cleancache`` ?

Ack.

>
> > +
> > +``stored``
> > +     number of successful cleancache folio stores.
> > +
> > +``skipped``
> > +     number of folios skipped during cleancache store operation.
> > +
> > +``restored``
> > +     number of successful cleancache folio restore operations.
> > +
> > +``missed``
> > +     number of failed cleancache folio restore operations.
> > +
> > +``reclaimed``
> > +     number of folios reclaimed from the cleancache due to insufficien=
t
> > +     memory.
> > +
> > +``recalled``
> > +     number of times cleancache folio content was discarded as a resul=
t
> > +     of the cleancache backend taking the folio back.
> > +
> > +``invalidated``
> > +     number of times cleancache folio content was discarded as a resul=
t
> > +     of invalidation.
> > +
> > +``cached``
> > +     number of folios currently cached in the cleancache.
> > +
> > +Per-pool stats are published under `/sys/kernel/mm/cleancache/<pool na=
me>`
>
> ``/sys/kernel/mm/cleancache/<pool name>`` ?

Ack.

>
> > +where "pool name" is the name pool was registered under. These stats
> > +include:
> > +
> > +``size``
> > +     number of folios donated to this pool.
> > +
> > +``cached``
> > +     number of folios currently cached in the pool.
> > +
> > +``recalled``
> > +     number of times cleancache folio content was discarded as a resul=
t
> > +     of the cleancache backend taking the folio back from the pool.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1c97227e7ffa..441e68c94177 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6053,6 +6053,7 @@ CLEANCACHE
> >  M:   Suren Baghdasaryan <surenb@google.com>
> >  L:   linux-mm@kvack.org
> >  S:   Maintained
> > +F:   Documentation/mm/cleancache.rst
> >  F:   include/linux/cleancache.h
> >  F:   mm/cleancache.c
> >  F:   mm/cleancache_sysfs.c
> > --
> > 2.51.0.740.g6adb054d12-goog
>
>
> Thanks,
> SJ

Thanks for the review!

