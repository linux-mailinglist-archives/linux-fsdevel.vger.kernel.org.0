Return-Path: <linux-fsdevel+bounces-23480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2092D236
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0E21F24C93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5919247D;
	Wed, 10 Jul 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffpC0Ptx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DA191497;
	Wed, 10 Jul 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616702; cv=none; b=CvIOaBo4jWyLxnMy3KFohcLn6ZmU7UbCO0TuF3rG/PuSB6MZsVYX4O7Ek7pnmanlMwXc41kJN02vBmFC5yPO6qDdVCviKjNIiZH1Mo+fG4LGYcdCFGZTA2p5jmFum0T2xbplqq62iUl4pRUlCAlXjNRbnQVppDUV5eW0GCM1X9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616702; c=relaxed/simple;
	bh=SyVxla2et2wQdF7Ur4jp45UAsd15s5o3dZy1WA18ZDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHwa39V4U1v0xFEijaXP+FKPeGv2/Msa0VyLMTkXcRhqwYNqJ4/Ng6Hwy50MzHSwRef8QPGAvgAiELSzr+V+YPqHw5pWb8PmhNI65OXg7vWyNi5M0rmdNTj7UTewyv6EGdGqjNo8OFlsaKqASBYIZdKYp+fzUk2RPAXZt7Z3b5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffpC0Ptx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6fd513f18bso667422166b.3;
        Wed, 10 Jul 2024 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720616699; x=1721221499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wO7cOo1kh0P6Txqc4PJ38t7/AZC3sWDggaziBs/A6L4=;
        b=ffpC0Ptx7Paa7NIuXWvTVGfCsTATf535PBhZQ4STb3ErLpW2TeqoMUQMCa+0FvlGyZ
         WCPJVsHO4W82+VDo9CWOR0t2HzNt9ujnfnnWhteaTv5WgMQ3mwAtImCGnbjhaYvwOX5E
         xuPj9BkKQaY0FZqJLiNvjRbJ098tCXUB+ZCGwEY617oS0xxCSHAr2T2yLmWQcmErAOby
         HhOtZK6six7+D/Fq+XlzZBRRICXDhNYpfkiRqJa7+bEYpXSe0mBeGUqI3Z+o7ehu/27k
         WLLDX48U2A7GquCPoZB/SA1QzQzfpRxMby9p4UX/x99hoYpQft1ubFSIKnB8wpm5RNH8
         hC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720616699; x=1721221499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wO7cOo1kh0P6Txqc4PJ38t7/AZC3sWDggaziBs/A6L4=;
        b=gR4TMmde8rBqo/JTTJvafMweqnpiXcOmAFlIwomCbuQd1OFuLF7lDJxSC6Nkg1jf/O
         dilGio5lEacvAa5Ou+gIpBCxjCGSJoh6/sTwllBLqJ8NCBBbOd339MZYa7URqFL+Psvh
         zUpqrDqUf1liihdW7x51W9n3kjuZrJEOYYb2LBTKCYFAFF5vRZclo1crrEWKar1DUbUj
         IBRfIEG6TNVooq+nJVzYHXI+0U4EYFwmzf4ro0I80Q6Cj9QPagbsUmJtBrbB88WJuBER
         CfkLJugck7bUnzehu8NJ1V+FLzHfCD2AzL1opXTQbK6OOcZmVlxRrPBazjW7+jVChcdk
         VhGA==
X-Forwarded-Encrypted: i=1; AJvYcCU1BmHTmyxDuj3DzAZp3Sobfjq/K7Ws91ErWp4qfeqpmEyCt8dzZ+dMIQgdMwYilxslrDw/N5Hm8RS6tpITPsrKZTXxw1Z19A65KcM+yjnRs9YcwLrxr8d0SsCLMK9Mig+n3E8pcNhUD1dS8g==
X-Gm-Message-State: AOJu0Yyb6IkJyTaw3rOSsphJgv7oGSLAi7EqAQx2ohqq8wQEL2LbICP/
	6exBWUu1m8Jl5gbXNxP1z/y1tlreMYqq8rC1V3i/Sd+l/K/T3wAdt6aK+2nLwT7it13ZigWKd3w
	3OXivOS2Qo1HWU5MlWaOE83AMz/4=
X-Google-Smtp-Source: AGHT+IGCFxVCXdmp75r1wbdIFzjDoi24n+M4oPOXt5hliNLw6PRGoAOxUk2qC0wxwjz9YrQ49yXsGWc7xU/JD1IB1Ig=
X-Received: by 2002:a17:906:794a:b0:a77:abe5:5f47 with SMTP id
 a640c23a62f3a-a780b89e7c3mr512946366b.63.1720616698896; Wed, 10 Jul 2024
 06:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <4307e984-a593-4495-b4cc-8ef509ddda03@amd.com> <CAGudoHH4N0eEQCpJqFioRCJx75WAO5n+kCA0XcRZ-914xFR0gw@mail.gmail.com>
In-Reply-To: <CAGudoHH4N0eEQCpJqFioRCJx75WAO5n+kCA0XcRZ-914xFR0gw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 10 Jul 2024 15:04:46 +0200
Message-ID: <CAGudoHEsg95BHX+nmK-N7Ps5dsw4ffg6YPimXMFvS+AhGSJeGw@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: Yu Zhao <yuzhao@google.com>, david@fromorbit.com, kent.overstreet@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:24=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Jul 10, 2024 at 2:04=E2=80=AFPM Bharata B Rao <bharata@amd.com> w=
rote:
> >
> > On 07-Jul-24 4:12 AM, Yu Zhao wrote:
> > >> Some experiments tried
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> 1) When MGLRU was enabled many soft lockups were observed, no hard
> > >> lockups were seen for 48 hours run. Below is once such soft lockup.
> > <snip>
> > >> Below preemptirqsoff trace points to preemption being disabled for m=
ore
> > >> than 10s and the lock in picture is lruvec spinlock.
> > >
> > > Also if you could try the other patch (mglru.patch) please. It should
> > > help reduce unnecessary rotations from deactivate_file_folio(), which
> > > in turn should reduce the contention on the LRU lock for MGLRU.
> >
> > Thanks. With mglru.patch on a MGLRU-enabled system, the below latency
> > trace record is no longer seen for a 30hr workload run.
> >
> > >
> > >>       # tracer: preemptirqsoff
> > >>       #
> > >>       # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-mglru-irqs=
trc
> > >>       # ------------------------------------------------------------=
--------
> > >>       # latency: 10382682 us, #4/4, CPU#128 | (M:desktop VP:0, KP:0,=
 SP:0
> > >> HP:0 #P:512)
> > >>       #    -----------------
> > >>       #    | task: fio-2701523 (uid:0 nice:0 policy:0 rt_prio:0)
> > >>       #    -----------------
> > >>       #  =3D> started at: deactivate_file_folio
> > >>       #  =3D> ended at:   deactivate_file_folio
> > >>       #
> > >>       #
> > >>       #                    _------=3D> CPU#
> > >>       #                   / _-----=3D> irqs-off/BH-disabled
> > >>       #                  | / _----=3D> need-resched
> > >>       #                  || / _---=3D> hardirq/softirq
> > >>       #                  ||| / _--=3D> preempt-depth
> > >>       #                  |||| / _-=3D> migrate-disable
> > >>       #                  ||||| /     delay
> > >>       #  cmd     pid     |||||| time  |   caller
> > >>       #     \   /        ||||||  \    |    /
> > >>            fio-2701523 128...1.    0us$: deactivate_file_folio
> > >> <-deactivate_file_folio
> > >>            fio-2701523 128.N.1. 10382681us : deactivate_file_folio
> > >> <-deactivate_file_folio
> > >>            fio-2701523 128.N.1. 10382683us : tracer_preempt_on
> > >> <-deactivate_file_folio
> > >>            fio-2701523 128.N.1. 10382691us : <stack trace>
> > >>        =3D> deactivate_file_folio
> > >>        =3D> mapping_try_invalidate
> > >>        =3D> invalidate_mapping_pages
> > >>        =3D> invalidate_bdev
> > >>        =3D> blkdev_common_ioctl
> > >>        =3D> blkdev_ioctl
> > >>        =3D> __x64_sys_ioctl
> > >>        =3D> x64_sys_call
> > >>        =3D> do_syscall_64
> > >>        =3D> entry_SYSCALL_64_after_hwframe
> >
> > However the contention now has shifted to inode_hash_lock. Around 55
> > softlockups in ilookup() were observed:
> >
> > # tracer: preemptirqsoff
> > #
> > # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-trnmglru
> > # --------------------------------------------------------------------
> > # latency: 10620430 us, #4/4, CPU#260 | (M:desktop VP:0, KP:0, SP:0 HP:=
0
> > #P:512)
> > #    -----------------
> > #    | task: fio-3244715 (uid:0 nice:0 policy:0 rt_prio:0)
> > #    -----------------
> > #  =3D> started at: ilookup
> > #  =3D> ended at:   ilookup
> > #
> > #
> > #                    _------=3D> CPU#
> > #                   / _-----=3D> irqs-off/BH-disabled
> > #                  | / _----=3D> need-resched
> > #                  || / _---=3D> hardirq/softirq
> > #                  ||| / _--=3D> preempt-depth
> > #                  |||| / _-=3D> migrate-disable
> > #                  ||||| /     delay
> > #  cmd     pid     |||||| time  |   caller
> > #     \   /        ||||||  \    |    /
> >       fio-3244715 260...1.    0us$: _raw_spin_lock <-ilookup
> >       fio-3244715 260.N.1. 10620429us : _raw_spin_unlock <-ilookup
> >       fio-3244715 260.N.1. 10620430us : tracer_preempt_on <-ilookup
> >       fio-3244715 260.N.1. 10620440us : <stack trace>
> > =3D> _raw_spin_unlock
> > =3D> ilookup
> > =3D> blkdev_get_no_open
> > =3D> blkdev_open
> > =3D> do_dentry_open
> > =3D> vfs_open
> > =3D> path_openat
> > =3D> do_filp_open
> > =3D> do_sys_openat2
> > =3D> __x64_sys_openat
> > =3D> x64_sys_call
> > =3D> do_syscall_64
> > =3D> entry_SYSCALL_64_after_hwframe
> >
> > It appears that scalability issues with inode_hash_lock has been brough=
t
> > up multiple times in the past and there were patches to address the sam=
e.
> >
> > https://lore.kernel.org/all/20231206060629.2827226-9-david@fromorbit.co=
m/
> > https://lore.kernel.org/lkml/20240611173824.535995-2-mjguzik@gmail.com/
> >
> > CC'ing FS folks/list for awareness/comments.
>
> Note my patch does not enable RCU usage in ilookup, but this can be
> trivially added.
>
> I can't even compile-test at the moment, but the diff below should do
> it. Also note the patches are present here
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvfs.=
inode.rcu
> , not yet integrated anywhere.
>
> That said, if fio you are operating on the same target inode every
> time then this is merely going to shift contention to the inode
> spinlock usage in find_inode_fast.
>
> diff --git a/fs/inode.c b/fs/inode.c
> index ad7844ca92f9..70b0e6383341 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1524,10 +1524,14 @@ struct inode *ilookup(struct super_block *sb,
> unsigned long ino)
>  {
>         struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
>         struct inode *inode;
> +
>  again:
> -       spin_lock(&inode_hash_lock);
> -       inode =3D find_inode_fast(sb, head, ino, true);
> -       spin_unlock(&inode_hash_lock);
> +       inode =3D find_inode_fast(sb, head, ino, false);
> +       if (IS_ERR_OR_NULL_PTR(inode)) {
> +               spin_lock(&inode_hash_lock);
> +               inode =3D find_inode_fast(sb, head, ino, true);
> +               spin_unlock(&inode_hash_lock);
> +       }
>
>         if (inode) {
>                 if (IS_ERR(inode))
>

I think I expressed myself poorly, so here is take two:
1. inode hash soft lookup should get resolved if you apply
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dvfs=
.inode.rcu&id=3D7180f8d91fcbf252de572d9ffacc945effed0060
and the above pasted fix (not compile tested tho, but it should be
obvious what the intended fix looks like)
2. find_inode_hash spinlocks the target inode. if your bench only
operates on one, then contention is going to shift there and you may
still be getting soft lockups. not taking the spinlock in this
codepath is hackable, but I don't want to do it without a good
justification.


--=20
Mateusz Guzik <mjguzik gmail.com>

