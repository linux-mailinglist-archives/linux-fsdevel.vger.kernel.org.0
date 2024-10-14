Return-Path: <linux-fsdevel+bounces-31909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65999D56F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 19:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E251F23A3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3171BDABD;
	Mon, 14 Oct 2024 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyNbvsMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03F1AE877
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926300; cv=none; b=MTson4M8tNTU3kjzwzF/A3UcTXeysYa14/mjEGZSG4gq1pJM7Hn3vnz4BHb1qUFAy5GZvSRK0hgWFVsJ05G61Ceet9kWpJMXpf0flIyp0OqulkDAaxI2VlaQnsWgGb4SGAaptCZFvhAd4h8jndxcTrd7TyRY5pvZncPLPvD0OEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926300; c=relaxed/simple;
	bh=wnUdKODfAGcfIVRGhb8l3BIMuqcz1HxlhNrixbz+7k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmP7Renab7RCPZ73qrYshGN/vW3yIwVeSiDsxcNfSsIC46NZVH2dOUe/j0kIE4dEGyI85pwzmooVp0FLONDit+U/SH0gxzLm5cYhnLodyXnmYHL/LkMHfvuStcO3EbMgAuICD/E5r2eiLHAPH2w2jMaIrkaIU/9D3hPOjdRFjjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyNbvsMl; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46071514c6fso6099311cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728926297; x=1729531097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6GjKiroA4ql0lEHofgbnDwiGAfJixcOP1LU5Sya9WQ=;
        b=RyNbvsMlNe0/m5y3XoDQtuXTdDpPjvLluZMGE4cM9KD9POnkuoQcX+rRHnmva9Mxyp
         ERKIsZf1sFMx8fK1nq57FyfyF1LeuD1381spW22Uvmi/BG0xAqU/6kfwk9da0xiB86pX
         SF0beKhkpINjZ3mkyV5YNfjijCBGZom46/q8Cm/e90RuWsZ1ZiPvNZsWlL4hRim4YReC
         /rYY/uNhN21f9DkKzOmk4ms5KHAbBAJWLNEAMyiNtmGLdwwwEZ2BYWPnBSJstSDaqn/S
         BvWdQ3crfLQkJrFjbWk53IPctcO96fPbYKfgwomeARkPtWtyeM+ATRg4jwJ7OeQtyBs8
         P4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728926297; x=1729531097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6GjKiroA4ql0lEHofgbnDwiGAfJixcOP1LU5Sya9WQ=;
        b=AXewFcrFZPIwTynBtfklJqS7sIukCgVtdydg6tQK4krjQWGULHZ9455+q6DqlM8c11
         e/oACRTz0Ej+bNrYPLZg0aZexboNOFhLglN9GOgx75AXZo13sowQghj3tMHnWWOvUBpv
         nHESgoqciJGD9Os0n4xMhIRot79+LjkQO8rAaVyaHdlzSwOfABcG40h+RCcTBfrjQLEf
         YW2KUz+RR6NQtuVRqngAUlum0eJcQ3oVof9/1XvgyKZNCxHdV0t3+wsoiCd1nC0SHeOL
         /veKh0N2wqi7y28geXUaFYSzM/bzbApVz6RF/yi8jPXKo/CTuTksIt+UH+S0c1uYYbSl
         56Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXL+QjTnJnTuRbjEZ5PENcSkg+7U/X0h6d/z+P51ZLv+bV0wsvwHwdWkfTR54afXRXW+KjUEThEqWJyuUME@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+uLwxbEYuVCW8jfO7LMJ3q3C72s5Prc+8pKhgkaOg6SIBs7Z
	DPRmlWJZ0ZTVeuIbbRRKiT/RWb6bevaGXgd+rSgH8wl021ptS6NHKrTctUQ25kWwTQjYU17kG8O
	cTd8kvte/ATcKWCWMR2Q6whNRpQl6hw==
X-Google-Smtp-Source: AGHT+IG7XUNvTVPoEsMkLtNckOcRYYSZWECevnmpgCY2UmmEZ8NlqS20kYMUcpP4vODA57/MIdHezQoP14Mo4ZXPAEA=
X-Received: by 2002:a05:622a:2c5:b0:458:4a68:7d15 with SMTP id
 d75a77b69052e-4604bc45d49mr213815351cf.44.1728926297318; Mon, 14 Oct 2024
 10:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011223434.1307300-1-joannelkoong@gmail.com>
 <20241011223434.1307300-2-joannelkoong@gmail.com> <prx7opxb3zqofuejohnqikxqbau6mde3lqxkistcwqun2xzr36@rpxky5oltnvs>
In-Reply-To: <prx7opxb3zqofuejohnqikxqbau6mde3lqxkistcwqun2xzr36@rpxky5oltnvs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 14 Oct 2024 10:18:05 -0700
Message-ID: <CAJnrk1b0d_svhF=LmSZHJ3LEeHX0_s+UZz4wHxwc5=JQ5tYEUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: skip reclaiming folios in writeback contexts that
 may trigger deadlock
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 9:55=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Oct 11, 2024 at 03:34:33PM GMT, Joanne Koong wrote:
> > Currently in shrink_folio_list(), reclaim for folios under writeback
> > falls into 3 different cases:
> > 1) Reclaim is encountering an excessive number of folios under
> >    writeback and this folio has both the writeback and reclaim flags
> >    set
> > 2) Dirty throttling is enabled (this happens if reclaim through cgroup
> >    is not enabled, if reclaim through cgroupv2 memcg is enabled, or
> >    if reclaim is on the root cgroup), or if the folio is not marked for
> >    immediate reclaim, or if the caller does not have __GFP_FS (or
> >    __GFP_IO if it's going to swap) set
> > 3) Legacy cgroupv1 encounters a folio that already has the reclaim flag
> >    set and the caller did not have __GFP_FS (or __GFP_IO if swap) set
> >
> > In cases 1) and 2), we activate the folio and skip reclaiming it while
> > in case 3), we wait for writeback to finish on the folio and then try
> > to reclaim the folio again. In case 3, we wait on writeback because
> > cgroupv1 does not have dirty folio throttling, as such this is a
> > mitigation against the case where there are too many folios in writebac=
k
> > with nothing else to reclaim.
> >
> > The issue is that for filesystems where writeback may block, sub-optima=
l
> > workarounds need to be put in place to avoid potential deadlocks that m=
ay
> > arise from the case where reclaim waits on writeback. (Even though case
> > 3 above is rare given that legacy cgroupv1 is on its way to being
> > deprecated, this case still needs to be accounted for)
> >
> > For example, for FUSE filesystems, when a writeback is triggered on a
> > folio, a temporary folio is allocated and the pages are copied over to
> > this temporary folio so that writeback can be immediately cleared on th=
e
> > original folio. This additionally requires an internal rb tree to keep
> > track of writeback state on the temporary folios. Benchmarks show
> > roughly a ~20% decrease in throughput from the overhead incurred with 4=
k
> > block size writes. The temporary folio is needed here in order to avoid
> > the following deadlock if reclaim waits on writeback:
> > * single-threaded FUSE server is in the middle of handling a request th=
at
> >   needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback (eg falls into case 3
> >   above) that needs to be written back to the fuse server
> > * the FUSE server can't write back the folio since it's stuck in direct
> >   reclaim
> >
> > This commit allows filesystems to set a ASOP_NO_RECLAIM_IN_WRITEBACK
> > flag in the address_space_operations struct to signify that reclaim
> > should not happen when the folio is already in writeback. This only has
> > effects on the case where cgroupv1 memcg encounters a folio under
> > writeback that already has the reclaim flag set (eg case 3 above), and
> > allows for the suboptimal workarounds added to address the "reclaim wai=
t
> > on writeback" deadlock scenario to be removed.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/fs.h | 14 ++++++++++++++
> >  mm/vmscan.c        |  6 ++++--
> >  2 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e3c603d01337..808164e3dd84 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -394,7 +394,10 @@ static inline bool is_sync_kiocb(struct kiocb *kio=
cb)
> >       return kiocb->ki_complete =3D=3D NULL;
> >  }
> >
> > +typedef unsigned int __bitwise asop_flags_t;
> > +
> >  struct address_space_operations {
> > +     asop_flags_t asop_flags;
> >       int (*writepage)(struct page *page, struct writeback_control *wbc=
);
> >       int (*read_folio)(struct file *, struct folio *);
> >
> > @@ -438,6 +441,12 @@ struct address_space_operations {
> >       int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
> >  };
> >
> > +/**
> > + * This flag is only to be used by filesystems whose folios cannot be
> > + * reclaimed when in writeback (eg fuse)
> > + */
> > +#define ASOP_NO_RECLAIM_IN_WRITEBACK ((__force asop_flags_t)(1 << 0))
> > +
> >  extern const struct address_space_operations empty_aops;
> >
> >  /**
> > @@ -586,6 +595,11 @@ static inline void mapping_allow_writable(struct a=
ddress_space *mapping)
> >       atomic_inc(&mapping->i_mmap_writable);
> >  }
> >
> > +static inline bool mapping_no_reclaim_in_writeback(struct address_spac=
e *mapping)
> > +{
> > +     return mapping->a_ops->asop_flags & ASOP_NO_RECLAIM_IN_WRITEBACK;
>
> Any reason not to add this flag in enum mapping_flags and use
> mapping->flags field instead of adding a field in struct
> address_space_operations?

No, thanks for the suggestion - I really like your idea of adding this
to enum mapping_flags instead as AS_NO_WRITEBACK_RECLAIM. I don't know
why I didn't see mapping_flags when I was looking at this. I'll make
this change for v2.


Thanks,
Joanne

>
> > +}
> > +
> >  /*
> >   * Use sequence counter to get consistent i_size on 32-bit processors.
> >   */
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 749cdc110c74..2beffbdae572 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1110,6 +1110,8 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >               if (writeback && folio_test_reclaim(folio))
> >                       stat->nr_congested +=3D nr_pages;
> >
> > +             mapping =3D folio_mapping(folio);
> > +
> >               /*
> >                * If a folio at the tail of the LRU is under writeback, =
there
> >                * are three cases to consider.
> > @@ -1165,7 +1167,8 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >                       /* Case 2 above */
> >                       } else if (writeback_throttling_sane(sc) ||
> >                           !folio_test_reclaim(folio) ||
> > -                         !may_enter_fs(folio, sc->gfp_mask)) {
> > +                         !may_enter_fs(folio, sc->gfp_mask) ||
> > +                         (mapping && mapping_no_reclaim_in_writeback(m=
apping))) {
> >                               /*
> >                                * This is slightly racy -
> >                                * folio_end_writeback() might have
> > @@ -1320,7 +1323,6 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >               if (folio_maybe_dma_pinned(folio))
> >                       goto activate_locked;
> >
> > -             mapping =3D folio_mapping(folio);
> >               if (folio_test_dirty(folio)) {
> >                       /*
> >                        * Only kswapd can writeback filesystem folios
> > --
> > 2.43.5
> >

