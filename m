Return-Path: <linux-fsdevel+bounces-73311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 464EED154D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 21:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D4F3016DC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2DE350A02;
	Mon, 12 Jan 2026 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="froXm5Ck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CF352F95
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250595; cv=none; b=T189tfCCPGXCIcvaiy1q3YJTeUe+Rwxum+zePbDhikFrM4691RdCSECi2NC3h0A1sqoCms0Rxt7of24NjiYcgldd3Bpe8tmtCq/X3bUsym6hXM/borJIpW48kqJ/lyo2BjAZTxvWy2MWoDq7S8i2oLvDlmvpWJ8Bu1IrybB/3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250595; c=relaxed/simple;
	bh=8n/OlbRFBya5TRZFNxoSLdsHxboFN5YnYm3X2dnuDuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjuM/NQWHPHDDyKkiLYTNO5D7hgnsVffjv0I1etzmFUql/1jCNokQ3MdKEkpNeHZ9yqVYFTurPGkFNEns0kTZSRROLLAXkztv/g4dGqZRYX+QDTaH5yndAXMMQFKUT6aOjKUMi8YfRVp3IpgZYfCdApTEke/SZE4H94KQ4zkebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=froXm5Ck; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-890228ed342so72646976d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 12:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250593; x=1768855393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wn+2Bz1XnwnLY98RFma90b13qbfeCs0rC99BF5gEU8=;
        b=froXm5CkHobWkrOkU0UbaasU2FlTl4FUd/AuFoeUUMs4WytWPawpsaO84stF06HUhm
         XS51vRqxfo5Oxtt5S/a1ZVs4wm14IVFo5rX6OVBX8pwc9YUM6vqDVAG6yt74ZvGt9sTh
         41lEh2zlUA+tGYgUI648OnE1CP3VqErrgNnzrRoq+HUR0Z8+KRr/p1fL3MPe8YJhhhRI
         uVzWqlvLUdtoiHvAhUt2S0Mpl8mZWAkYuL+NOKppOghIbIJ3alI1zymjSaoJaAzIh1UG
         R3evJBj+p03rWqP7aNv0mY2FfXj9cf3DiU4AosaaE+/Bjtd8HyAUOsvQpcv6YNPgbEM5
         gttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250593; x=1768855393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Wn+2Bz1XnwnLY98RFma90b13qbfeCs0rC99BF5gEU8=;
        b=wFsU0dDhkeiaIfLj0PeZSreaMETFqenNGwMohChCMGjpLo4FIyCAgRYXX6QPOgN8nw
         0oeAlMxyQEBTckmEaL6efuMkaGK0WUsC116CCvvdFRvIz/aakdPA6CMws3z2ETMga85Q
         oR2ltBo0d54NrGCkyENF5lx5/PtPVWRR1fulJtPWSNncQUGbXj2hd1ILfqRmAQjkm+CI
         Rfc2K2sX3jRdAsTFjfc4NnEGFLWUb/uyhcL69H1BIHtMs8XM6ZVroVNL1U3Zq4yRfAOD
         atPAe2c5aDcB4tsv4V7ZqX3PdudnkU9TxPvzZVNv7YASV3RnHKH4u8mMow5/UarHm9Bm
         q3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqHOiQDuNZBawmWqx+iFAJhkceF3EqFjqvPgp10iYW3MCux9ewj7x75iRsZBFBl0DWR8NlML7AWTdLOVWz@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmPgRy3VCIhyXO1Q9zGcxyUyme3lwdtArcwPpO5ogt1uu/ctc
	BxAby5jHoYD2JiksDpYGkUVyNdMxKLH7pONFXRoSAnQFOPtX3ollg7fx1PPsTAX2KymEMwoS2Rk
	0n89XQ0IqW+7Cgnc57CU3v0oMejDH7sc=
X-Gm-Gg: AY/fxX4228MPZIWTI7/NV4ZrGlKBI4u2zwwUO2J5TZgaGsB9LZWcT0QX/6u59LSGLWl
	XwZr5n6MXeQoY3iN2W8HgY6gQT2JPCCSKe5/2/GKE2t5NNaWi6y72oVMCKhkZEbfT6oOXFWQcLg
	6SiKY78EtLiujlRz3vHj3f5Kvwy9qJvViCwTs4tHTm0PAATv7xhmGl+HHGIJ81aUOCyDsz0NVk0
	dyOsBzIcSvzVU1F6GZzEKJ8yYAQ+zjA7KbPx8yeegYrzik0RtYjHVdnJ28pzl1Fh/AtZA==
X-Google-Smtp-Source: AGHT+IExUdgRj/l+2ZKhV/eGPO3L8kyW2OQay5HeroRpTVftTdhLkG565qIV2TBfcRl4dcGmY/btmAf6im980bfWRog=
X-Received: by 2002:a05:6214:570a:b0:890:eff:c135 with SMTP id
 6a1803df08f44-890841e462amr296018626d6.4.1768250592943; Mon, 12 Jan 2026
 12:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
 <b7b72183-f9e1-4e58-b40f-45a267cc6831@bsbernd.com> <aWJ-pHIY8Y8sjLeC@casper.infradead.org>
 <wu7mu22kgr7pmzrneq6rkivhwvpbximyrkouciktl7wf5w7wur@rsyqyczopba2>
In-Reply-To: <wu7mu22kgr7pmzrneq6rkivhwvpbximyrkouciktl7wf5w7wur@rsyqyczopba2>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 12 Jan 2026 12:43:02 -0800
X-Gm-Features: AZwV_QgLt0LDqG4AYy4MxQx2i1PR--V5T3xK6lVVqNwOZj9F6Pm2LmfKAKM6_-0
Message-ID: <CAJnrk1YSp10MCagMGiLw87p9UHbU83Ovnyz5z52NGDxV=My9bw@mail.gmail.com>
Subject: Re: __folio_end_writeback() lockdep issue
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, Bernd Schubert <bernd@bsbernd.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Horst Birthelmer <hbirthelmer@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "David Hildenbrand (Red Hat)" <david@kernel.org>, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 5:06=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 10-01-26 16:30:28, Matthew Wilcox wrote:
> > On Sat, Jan 10, 2026 at 04:31:28PM +0100, Bernd Schubert wrote:
> > > [  872.499480]  Possible interrupt unsafe locking scenario:
> > > [  872.499480]
> > > [  872.500326]        CPU0                    CPU1
> > > [  872.500906]        ----                    ----
> > > [  872.501464]   lock(&p->sequence);
> > > [  872.501923]                                local_irq_disable();
> > > [  872.502615]                                lock(&xa->xa_lock#4);
> > > [  872.503327]                                lock(&p->sequence);
> > > [  872.504116]   <Interrupt>
> > > [  872.504513]     lock(&xa->xa_lock#4);
> > >
> > >
> > > Which is introduced by commit 2841808f35ee for all file systems.
> > > The should be rather generic - I shouldn't be the only one seeing
> > > it?
> >
> > Oh wow, 2841808f35ee has a very confusing commit message.  It implies
> > that _no_ filesystem uses BDI_CAP_WRITEBACK_ACCT, but what it really
> > means is that no filesystem now _clears_ BDI_CAP_WRITEBACK_ACCT, so
> > all filesystems do use this code path and therefore the flag can be
> > removed.  And that matches the code change.
> >
> > So you should be able to reproduce this problem with commit 494d2f50888=
3
> > as well?
> >
> > That tells me that this is something fuse-specific.  Other filesystems
> > aren't seeing this.  Wonder why ...
> >
> > __wb_writeout_add() or its predecessor __wb_writeout_inc() have been in
> > that spot since 2015 or earlier.
> >
> > The sequence lock itself is taken inside fprop_new_period() called from
> > writeout_period() which has been there since 2012, so that's not it.
> >
> > Looking at fprop_new_period() is more interesting.  Commit a91befde3503
> > removed an earlier call to local_irq_save().  It was then replaced with
> > preempt_disable() in 9458e0a78c45 but maybe removing it was just
> > erroneous?
> >
> > Anyway, that was 2022, so it doesn't answer "why is this only showing u=
p
> > now and only for fuse?"  But maybe replacing the preempt-disable with
> > irq-disable in fprop_new_period() is the right solution, regardless.
>
> So I don't have a great explanation why it is showing up only now and onl=
y
> for FUSE. It seems the fprop code is unsafe wrt interrupts because
> fprop_new_period() grabs
>
>         write_seqcount_begin(&p->sequence);
>
> and if IO completion interrupt on this CPU comes while p->sequence is odd=
,
> the call to
>
>         read_seqcount_begin(&p->sequence);
>
> in __folio_end_writeback() -> __wb_writeout_add() -> wb_domain_writeout_a=
dd()
> -> __fprop_add_percpu_max() -> fprop_fraction_percpu() will loop
> indefinitely. *However* this isn't in fact possible because
> fprop_new_period() is only called from a timer code and thus in softirq
> context and thus IO completion softirq cannot really preempt it.
>
> But for the same reason I don't think what lockdep complains about is
> really possible because xa_lock gets only used from IO completion softirq=
 as
> well. Or can we really acquire it from some hard irq context? Based on
> lockdep report at least lockdep things IO completion runs in hardirq
> context but then I don't see why we're not seeing complaints like this al=
l
> the time and even deadlocks I've described above. I guess I'll have to do
> some experimentation to refresh how these things behave these days...

I looked into this briefly when there was a syzbot report about this
in october [1]. The stack trace is a little different but I think it's
pretty much the exact same scenario.

I came to the same conclusion Jan came to. Copying over my notes from
October: "I don't think this is a real deadlock. My understanding of
it is that the other thread where the timer is running that is calling
fprop_new_period() could only try grabbing the xa_array lock in a
hardware interrupt handler since it disables preemption and is already
running in softirq context which means it can't get interrupted by
another softirq or scheduled out and the hardware interrupt handling
code in the drivers don't access the page cache directly."

It's unclear to me why it's only complaining about this for FUSE.

This seemed like a false positive scenario to me, but I also think the
patches Hilf tried out in [1] seemed reasonable.

Thanks,
Joanne

[1] https://lore.kernel.org/all/68e583e1.a00a0220.298cc0.0485.GAE@google.co=
m/

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

