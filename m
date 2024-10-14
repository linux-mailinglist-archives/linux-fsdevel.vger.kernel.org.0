Return-Path: <linux-fsdevel+bounces-31920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188EB99D8B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 23:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22B228284B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ED31D278A;
	Mon, 14 Oct 2024 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFynH5Sb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B681D172F
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939861; cv=none; b=LmhpULbbUBkg8DOPxV/B/O+kfrhCymHS685/wfNFFeT9Mu66wyrL7EqhdlyyYV/S+BuftbKCXwbpCQozkMUrHGe6wUM4R15rGSV7zSNsBTL+yJOKeNmqaGiGKiEi7EQ7Ig7FLBBdO68+TjzOy+hZSi4Kok6NnmIt4cdFtbHK4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939861; c=relaxed/simple;
	bh=lHagXXJOyh0nDsDp1PmuO0YI561tDzjsjOxed4sSuK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TM3sAoJjEhhuaB49gvIaAmMXy/ZVLOZbRx9hmVCLuj3Hl64wboajWeOzHYRUTlG1EdfRrFkZUhG+vnH5UqA8VTFA998eebc1+18mzkOGaLXk7kDk2QqmNxoqt09rQfvHvFm9x06OKR8sQpS9uOjxxKPqfhGLNXjbYG/x0BgMiaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFynH5Sb; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4603d3e456bso42975891cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728939859; x=1729544659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rtfQZJf4aN6x/+CFZ/mi2tjYxLWSezPfibNwf1sTfk=;
        b=gFynH5Sbk05cJYReT1DXc2GMFI8B+ZvIfIO2ewcGcxYGi9XvmnX+KvIsk3FvVhhQFa
         AZ6snsTPvyoe82PWXrN1ISNRzLNyedtMyejLOzdiYjwWswFJHgRdfdkBKWKuJPij55DK
         HGBk2QKhOFP0zgd4IOHJ4SD2KA5XENjES6q/vq59g7dMxbtDTmPgdGjVA3dYiAEPmmER
         x1pZofsHOQeKK92P/yaTHSBZjjDAuA40PZ/yAWYAnYHyI9dWwcBNtOm0omn5qkVdRSZP
         5EVGVOPfwTkYqMV/4EwAR3WvHz8sy5a1Y3xKkCzS4GmXSV3tDt/CrZbh26rX7c8c6Guz
         8q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939859; x=1729544659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rtfQZJf4aN6x/+CFZ/mi2tjYxLWSezPfibNwf1sTfk=;
        b=lDgIkvz2231Uf/YggCBZVuLcND9Mbf0o90h/7h42c5cFyMagG3+ppa2efgArQLQzHQ
         hf7NV/AXAbAyljrFOcHClQg5xv4gLNxgtsRgznHSGjF6JS5KJ20LSTo/RrZVJA572CGX
         oxXBfw9FrOSU7BXksTqgdz2VjClBm21htyta6rHXzqq/+OlFXO4KSmHdHe8jGBQyof/r
         aqRVfXbIv9f1oBHzd4b2eYIkOHLc96WVzWnfa12dUNm5XC65b5gmGNRe8XlQsoR1TKHK
         IBPc/r1q2q+sYEFONUJKC4lU/bUfMUFvICp0G4uhqnSCXK/ddLkUtJoOQVy3PTgtcmT4
         AOSA==
X-Forwarded-Encrypted: i=1; AJvYcCXPQ6TKyvyeexOgkJiHhuoXZoADEubPNcTTjnxPR0/xLZi6mAJbDtS25i1pR1J3w2AfG8TpzDx2l4mg8+Ri@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3bRwYUNRgPKvstmcN4ptRugV7Q5zU/jnhx3P7eA26gI46pBF
	jzCLJo1XhxkdaM2GLzf9FxfqdaYe8NpKS5o733m4CKkwtAYHKrDioJ7VTRk3ojihBPVKl31Ck9u
	wJIJ2OlfIsg9+2iplAysc9KibIJA=
X-Google-Smtp-Source: AGHT+IFqZZAKnd9dm+KSN0BbKCsOY/GRk4OK4Ex6L0MNOKtkvT53kUj39auAk7BOl9UcufSHbjtdtx8jRA5qs3E0viY=
X-Received: by 2002:ac8:7d04:0:b0:45f:8c1:41af with SMTP id
 d75a77b69052e-4604bc4dd68mr173959961cf.41.1728939858709; Mon, 14 Oct 2024
 14:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-2-joannelkoong@gmail.com> <265keu5uzo3gzqrvhcn2cagii4sak3e2a372ra7jlav35fnkrx@aicyzyftun3l>
In-Reply-To: <265keu5uzo3gzqrvhcn2cagii4sak3e2a372ra7jlav35fnkrx@aicyzyftun3l>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 14 Oct 2024 14:04:07 -0700
Message-ID: <CAJnrk1Yrn3_eXPCrXDqA-5F2un33BAxrP=GdmrLw7bhtbGypjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: skip reclaiming folios in writeback contexts
 that may trigger deadlock
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:38=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Oct 14, 2024 at 11:22:27AM GMT, Joanne Koong wrote:
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
> > This commit adds a new flag, AS_NO_WRITEBACK_RECLAIM, to "enum
> > mapping_flags" which filesystems can set to signify that reclaim
> > should not happen when the folio is already in writeback. This only has
> > effects on the case where cgroupv1 memcg encounters a folio under
> > writeback that already has the reclaim flag set (eg case 3 above), and
> > allows for the suboptimal workarounds added to address the "reclaim wai=
t
> > on writeback" deadlock scenario to be removed.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/pagemap.h | 11 +++++++++++
> >  mm/vmscan.c             |  6 ++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 68a5f1ff3301..513a72b8451b 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -210,6 +210,7 @@ enum mapping_flags {
> >       AS_STABLE_WRITES =3D 7,   /* must wait for writeback before modif=
ying
> >                                  folio contents */
> >       AS_INACCESSIBLE =3D 8,    /* Do not attempt direct R/W access to =
the mapping */
> > +     AS_NO_WRITEBACK_RECLAIM =3D 9, /* Do not reclaim folios under wri=
teback */
>
> Isn't it "Do not wait for writeback completion for folios of this
> mapping during reclaim"?

I think if we make this "don't wait for writeback completion for
folios of this mapping during reclaim", then the
mapping_no_writeback_reclaim check in shrink_folio_list() below would
need to be something like this instead:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 885d496ae652..37108d633d21 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1190,7 +1190,8 @@ static unsigned int shrink_folio_list(struct
list_head *folio_list,
                        /* Case 3 above */
                        } else {
                                folio_unlock(folio);
-                               folio_wait_writeback(folio);
+                               if (mapping &&
!mapping_no_writeback_reclaim(mapping))
+                                       folio_wait_writeback(folio);
                                /* then go back and try same folio again */
                                list_add_tail(&folio->lru, folio_list);
                                continue;

which I'm not sure if that would be the correct logic here or not.
I'm not too familiar with vmscan, but it seems like if we are going to
reclaim the folio then we should wait on it or else we would just keep
trying the same folio again and again and wasting cpu cycles. In this
current patch (if I'm understanding this mm code correctly), we skip
reclaiming the folio altogether if it's under writeback.

Either one (don't wait for writeback during reclaim or don't reclaim
under writeback) works for mitigating the potential fuse deadlock,
but I was thinking "don't reclaim under writeback" might also be more
generalizable to other filesystems.

I'm happy to go with whichever you think would be best.

And thanks again for taking a look at this patch, Shakeel!

>
> >       /* Bits 16-25 are used for FOLIO_ORDER */
> >       AS_FOLIO_ORDER_BITS =3D 5,
> >       AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct add=
ress_space *mapping)
> >       return test_bit(AS_INACCESSIBLE, &mapping->flags);
> >  }
> >
> > +static inline void mapping_set_no_writeback_reclaim(struct address_spa=
ce *mapping)
> > +{
> > +     set_bit(AS_NO_WRITEBACK_RECLAIM, &mapping->flags);
> > +}
> > +
> > +static inline int mapping_no_writeback_reclaim(struct address_space *m=
apping)
> > +{
> > +     return test_bit(AS_NO_WRITEBACK_RECLAIM, &mapping->flags);
> > +}
> > +
> >  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
> >  {
> >       return mapping->gfp_mask;
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 749cdc110c74..885d496ae652 100644
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
> > +                         (mapping && mapping_no_writeback_reclaim(mapp=
ing))) {
> >                               /*
> >                                * This is slightly racy -
> >                                * folio_end_writeback() might have
> > @@ -1320,7 +1323,6 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >               if (folio_maybe_dma_pinned(folio))
> >                       goto activate_locked;
> >
> > -             mapping =3D folio_mapping(folio);
>
> We should not remove the above line as it will make anon pages added to
> the swap in this code path skip reclaim. Basically the mapping of anon
> pages which are not yet in swap cache, will be null at the newly added
> mapping =3D folio_mapping(folio) but will be swapcache mapping at this
> location (there is add_to_swap() in between), so if we remove this line,
> the kernel will skip the reclaim of that folio in this iteration. This
> will increase memory pressure.

Thanks for the explanation! I will add this line back in for v3.

>
> >               if (folio_test_dirty(folio)) {
> >                       /*
> >                        * Only kswapd can writeback filesystem folios
> > --
> > 2.43.5
> >

