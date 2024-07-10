Return-Path: <linux-fsdevel+bounces-23506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7419292D7FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 20:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC528667B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B14195B14;
	Wed, 10 Jul 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="haUO44yT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC31194099
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634727; cv=none; b=i9gWfIBGLJ9mspDW41F8iuCWuXs22MsewaPjo+o+16NbLN2c/nfvMBcclPiXHjFW55tIKZTt0zd6nEP24ducQJZxfRV/0yS1SJ6RI++QbDie9dT7VSb1uki9X6nA/PGGsBsSJcQoSGKpkudNWjI9VRm5POh1NeBRRQgr+pDCXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634727; c=relaxed/simple;
	bh=K2tlaOn/UrGJwgaSqvIr0bzxkIKbmhU+rtLAVgwVRkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3TkqGbZsdQyuAxFSL1nR9MBCMl/iKsCr2wusvNDzTPCjfe6iLItWWFSdTclLwISICHs2BB4Ws+AhQftoWUEub1PKRvrXU9qh7Rf7S7SzeklhuZyomwEBOdAh/62aLkWTaephBaswejKvbFLNez4AjXwYbobv/T0xrGjwBCGxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=haUO44yT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447f8aa87bfso43381cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720634725; x=1721239525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOvbHMK6yjy+j4wGCOQ884vrN5y0/inUH90JR72cu7w=;
        b=haUO44yTyqQma6HJ3DBb1mvxB+d+AGNXXVxnn2M7gAzokIFRZ1iVZd96qmF3anq65R
         uho2G4J20Xm6efwRfzpRFryL6GPqeLJHCMq4uvEWvANV4YYtaIRU+sOrmGBySz3PPSvO
         NhxZ5bhqidQTvPuoKUzH4mnRwQ+YzMfP7IVkKThfQqIBXworgR52vWST6Uz2ZcgzVY2s
         6qnSUzHV5sJKxE0uERKsJ8YlWrJPylLaJ2Dm4JgQqjFxq9w42m12cl+ZecIvMDi/JqdH
         SsEe+nbtLnA7bQMQ96kFbBy35B4p5RSWSWfVxNhJCPc+3ePEIrzUQg8/FeLgvj4a+j20
         1BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720634725; x=1721239525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOvbHMK6yjy+j4wGCOQ884vrN5y0/inUH90JR72cu7w=;
        b=gKARoV6Zmo+nTi88AhTk/W2vMhev5na0+q/L533t6Nt8AsFQRvl3q6SIVKHAxsoviC
         +cnjCfIDnWtzrxjybrnn1hOr7eX1tIjYqVFugJq/Be2JukEc9RKhTG3kX2/4RaiIYF44
         C9jP6Oq+mG9g0QAKnXit8ezOF7vr5hT5ZeW7v9V35uypXX6FrG1PJNF3paoEeNNYJ4w5
         8v45iid6+Jek1hkpr+SFYlzDJnfrNhIztl15PFNosdKCYqciL9yY2ySitk+57y1tTypr
         cGLkRJCJyaDTo+GB1YkbilpSaVpORPlYu+blpo9Ooi3rMjVVKN/Srse3DsKhEV7Ki4gM
         s+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVXO9my1T4602EDAqTa15LrvS4s9oBSODKZeHvUEvz3aN5v6QPcjMULmDDv+9sMv2PBNjLGv6tuK4BRWVczpsFeKzHbjtp5JEwDwqmUNg==
X-Gm-Message-State: AOJu0YxXkL0j/I6hP7oMECtyfxm2+e5Shf/vT/+VhrPE/iuZo0Gd+Igd
	WgMaUtlW2cZbbM+nErLp+J3D/2K2RymXkqKM9QQnykdKJ+A6rTzVGbEtnkJWraU1EEu1zltAkLh
	uP0dmr0/cY9hh/KS4T2KGi6Wo05aZR7jfIIeS
X-Google-Smtp-Source: AGHT+IEyytpgDqK3ENrH4AkMFMoYmBex4aMvgkYoPQubRHHsNpCGrYxuusMYiUPUaqGeonOe2ZYTFL/k1eo/+mBo/VM=
X-Received: by 2002:a05:622a:7602:b0:447:e497:95d0 with SMTP id
 d75a77b69052e-44d11e8a35fmr39911cf.17.1720634725183; Wed, 10 Jul 2024
 11:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <4307e984-a593-4495-b4cc-8ef509ddda03@amd.com>
In-Reply-To: <4307e984-a593-4495-b4cc-8ef509ddda03@amd.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 10 Jul 2024 12:04:48 -0600
Message-ID: <CAOUHufZdA56QBMK=OWoi63+Tx6f9X0w3e6B1hjOGtj_6a+Ri0g@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: mjguzik@gmail.com, david@fromorbit.com, kent.overstreet@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 6:04=E2=80=AFAM Bharata B Rao <bharata@amd.com> wro=
te:
>
> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
> >> Some experiments tried
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 1) When MGLRU was enabled many soft lockups were observed, no hard
> >> lockups were seen for 48 hours run. Below is once such soft lockup.
> <snip>
> >> Below preemptirqsoff trace points to preemption being disabled for mor=
e
> >> than 10s and the lock in picture is lruvec spinlock.
> >
> > Also if you could try the other patch (mglru.patch) please. It should
> > help reduce unnecessary rotations from deactivate_file_folio(), which
> > in turn should reduce the contention on the LRU lock for MGLRU.
>
> Thanks. With mglru.patch on a MGLRU-enabled system, the below latency
> trace record is no longer seen for a 30hr workload run.

Glad to hear. Will post a patch and add you as reported/tested-by.

> >
> >>       # tracer: preemptirqsoff
> >>       #
> >>       # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-mglru-irqstr=
c
> >>       # --------------------------------------------------------------=
------
> >>       # latency: 10382682 us, #4/4, CPU#128 | (M:desktop VP:0, KP:0, S=
P:0
> >> HP:0 #P:512)
> >>       #    -----------------
> >>       #    | task: fio-2701523 (uid:0 nice:0 policy:0 rt_prio:0)
> >>       #    -----------------
> >>       #  =3D> started at: deactivate_file_folio
> >>       #  =3D> ended at:   deactivate_file_folio
> >>       #
> >>       #
> >>       #                    _------=3D> CPU#
> >>       #                   / _-----=3D> irqs-off/BH-disabled
> >>       #                  | / _----=3D> need-resched
> >>       #                  || / _---=3D> hardirq/softirq
> >>       #                  ||| / _--=3D> preempt-depth
> >>       #                  |||| / _-=3D> migrate-disable
> >>       #                  ||||| /     delay
> >>       #  cmd     pid     |||||| time  |   caller
> >>       #     \   /        ||||||  \    |    /
> >>            fio-2701523 128...1.    0us$: deactivate_file_folio
> >> <-deactivate_file_folio
> >>            fio-2701523 128.N.1. 10382681us : deactivate_file_folio
> >> <-deactivate_file_folio
> >>            fio-2701523 128.N.1. 10382683us : tracer_preempt_on
> >> <-deactivate_file_folio
> >>            fio-2701523 128.N.1. 10382691us : <stack trace>
> >>        =3D> deactivate_file_folio
> >>        =3D> mapping_try_invalidate
> >>        =3D> invalidate_mapping_pages
> >>        =3D> invalidate_bdev
> >>        =3D> blkdev_common_ioctl
> >>        =3D> blkdev_ioctl
> >>        =3D> __x64_sys_ioctl
> >>        =3D> x64_sys_call
> >>        =3D> do_syscall_64
> >>        =3D> entry_SYSCALL_64_after_hwframe
>
> However the contention now has shifted to inode_hash_lock. Around 55
> softlockups in ilookup() were observed:

This one is from fs/blk, so I'll leave it to those experts.

> # tracer: preemptirqsoff
> #
> # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-trnmglru
> # --------------------------------------------------------------------
> # latency: 10620430 us, #4/4, CPU#260 | (M:desktop VP:0, KP:0, SP:0 HP:0
> #P:512)
> #    -----------------
> #    | task: fio-3244715 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  =3D> started at: ilookup
> #  =3D> ended at:   ilookup
> #
> #
> #                    _------=3D> CPU#
> #                   / _-----=3D> irqs-off/BH-disabled
> #                  | / _----=3D> need-resched
> #                  || / _---=3D> hardirq/softirq
> #                  ||| / _--=3D> preempt-depth
> #                  |||| / _-=3D> migrate-disable
> #                  ||||| /     delay
> #  cmd     pid     |||||| time  |   caller
> #     \   /        ||||||  \    |    /
>       fio-3244715 260...1.    0us$: _raw_spin_lock <-ilookup
>       fio-3244715 260.N.1. 10620429us : _raw_spin_unlock <-ilookup
>       fio-3244715 260.N.1. 10620430us : tracer_preempt_on <-ilookup
>       fio-3244715 260.N.1. 10620440us : <stack trace>
> =3D> _raw_spin_unlock
> =3D> ilookup
> =3D> blkdev_get_no_open
> =3D> blkdev_open
> =3D> do_dentry_open
> =3D> vfs_open
> =3D> path_openat
> =3D> do_filp_open
> =3D> do_sys_openat2
> =3D> __x64_sys_openat
> =3D> x64_sys_call
> =3D> do_syscall_64
> =3D> entry_SYSCALL_64_after_hwframe
>
> It appears that scalability issues with inode_hash_lock has been brought
> up multiple times in the past and there were patches to address the same.
>
> https://lore.kernel.org/all/20231206060629.2827226-9-david@fromorbit.com/
> https://lore.kernel.org/lkml/20240611173824.535995-2-mjguzik@gmail.com/
>
> CC'ing FS folks/list for awareness/comments.
>
> Regards,
> Bharata.

