Return-Path: <linux-fsdevel+bounces-28459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3C796AD7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 02:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E835628580B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 00:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC9443D;
	Wed,  4 Sep 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP+7EWL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93E29A2;
	Wed,  4 Sep 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410966; cv=none; b=u/s7yynQQaJAa9xVclzLNZnjaRifhl7TCcvQ9DFnTelcfdpUmuQnyr3/XOfdL2rLCDUVWd3Yuk681SIL1WNOHvc/W/VoE24KweZir2Y6RxWfYoElNaqyDg524y8/7cpb9XiM9TVVm5SODW1V21r83+XN96xujGOMUI1h+IfBbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410966; c=relaxed/simple;
	bh=jnh1H7M/QJfhLyfhl/F7/OpfWIBWmSjE5b8OhlHRMTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBqtVS9OPdnE07Ywec2hwZBo3nV+w04dzfGEOh6M1yCL/gH2K89y4mSG9rZ+4Ww1j9sJB88770g7dyE8ewUTPmfW0+qgk6rhmbM0x4dyoi7XdJxDxkevBVwfwftYn7hkSV2BGGHeJptPlevXBBfIlG5SEjDubR7HtG8rFwuc6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP+7EWL0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334806248dso580138e87.1;
        Tue, 03 Sep 2024 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725410962; x=1726015762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkHcKWMv96FSYVO5XaYl2xQoYr+/od+PFt08e/cIBxg=;
        b=dP+7EWL0IFSaEUFB6m0QmL2yQrN8E0UV1m7t4+BtU162eSL2+gw3DpMbXYfA04s/65
         c5o8jUg8eCDoJIY9PdZ/xMHB7Sw8Oikf3FHMzM6Rbhhgwc7aXseeG34yrKz6HDE3kcFZ
         6fXNYw8LY+SliHIIm9N7gb+M6tnHJEwfxGL4f+IgJUqvbVhIU0pgecIHL9lhDjYLBFPk
         Xm3ey25WwRyrS8YE9QNJEnA8q3eG6SwCI1xfIbdlaYQwl9Pw79MSHauROchE5tNbyknp
         5j0zHeI+sidUXYPq0r+GB5vwMD3cHb5CfPKsLh/Ap/iyEHs28NxdTNINwUqwxMyfS4Sm
         Wo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410962; x=1726015762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkHcKWMv96FSYVO5XaYl2xQoYr+/od+PFt08e/cIBxg=;
        b=qIzuuhdPkW+P4DW2XMBq+XQ5fCPruuCHLDNERuvPJ6phGTjho+yrdMqjRfZ50NW1bg
         kmyVC2JxAawnsVV+EC7+Mx0SzU0WI1LwPuCPd+fiSc/jMeNaye40Lr9UUVc/mPQvQV5J
         o8KBZcaN3pYsBWFhB60Tl2qPyJYA+Zdjcj1H23RlmBR5oV3Gpp9ADUrd/9dobnlt3+Fk
         rBtzvgLATSIJQbE4S4yWTzXak4BQJcoemGZyTQ43Og76pAZXx0MKOlqngAI6RMJT8ThL
         OrIa1beNd2R5bNWKYcWFm9oR87C0o0IdRy9qhMFLq17xEesTLqbilA13b4p4T4K39HT4
         Mogg==
X-Forwarded-Encrypted: i=1; AJvYcCUpttQoIeab7e/3/v3NhKlfx5kAvYvuVmNJkZronp1YPf+esn9ELrMbG1bEVglh/CzZ6FLOzNhFgsHC@vger.kernel.org, AJvYcCX6Tzt5lzQ0KMTbWtE3f+HMdA8CxU09WMcyq4ZTY/dVUoPsx4Q/dLTGO+iQekwVkXdpoICzVbiMrUcBzEJQSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpB+UItj/kWmq9Uyi9F+inwNXIoQKXkaK5aBLjJVSYhADOFprv
	4ceOqyWH/X1X0/JjSR9qdNlwWgB5bnVQeqolN7HQJPYNsq8jN1KD3Z3LGYyFAidSNU1/wg4K8RO
	xBNYqdZrcWQuUTQfA2io2anjUKXI=
X-Google-Smtp-Source: AGHT+IEBvJxmQhQXpMx75PoTovnS2SR1lBW7YHxl1SJaol1lEdyjKH9c2q2IpfwRyY+99YLUuftwKkXxEcqPxsbKYQQ=
X-Received: by 2002:a05:6512:3d8d:b0:535:681d:34b6 with SMTP id
 2adb3069b0e04-535681d3788mr35513e87.10.1725410961537; Tue, 03 Sep 2024
 17:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
 <20240903022902.GP9627@mit.edu> <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
 <20240903120840.GD424729@mit.edu>
In-Reply-To: <20240903120840.GD424729@mit.edu>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 4 Sep 2024 08:49:10 +0800
Message-ID: <CAGWkznFu1GTB41Vx1_Ews=rNw-Pm-=ACxg=GjVdw46nrpVdO3g@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:08=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Sep 03, 2024 at 04:50:46PM +0800, Zhaoyang Huang wrote:
> > > I'd also sugest only trying to use this is the file system has
> > > journaling enabled.  If the file system is an ext2 file system withou=
t
> > > a journal, there's no reason avoid using the CMA region
> > agree.
> > > assume the reason why the buffer cache is trying to use the moveable
> > > flag is because the amount of non-CMA memory might be a precious
> > > resource in some systems.
> >
> > I don't think so. All migrate type page blocks possess the same
> > position as each other as they could fallback to all migrate types
> > when current fails. I guess the purpose could be to enlarge the scope
> > of available memory as __GFP_MOVEABLE has the capability of recruiting
> > CMA.
>
> Well, I guess I'm a bit confused why the buffer cache is trying to use
> __GFP_MOVEABLE in the first place.  In general CMA is to allow systems
> to be able to allocate big chunks of memory which have to be
> physically contiguous because the I/O device(s) are too primitive to
> be able to do scatter-gather, right?  So why are we trying to use CMA
> eligible memory for 4k buffer cache pages?  Presumably, because
> there's not enough non-CMA eligible memory?
I suppose maybe you missed the way of how CMA work as the second
client as the special fallback of MIGRATE_MOVABLE during normal
alloc_pages.(cma_alloc is the first client of CMA area)

//MIGRATE_MOVABLE->ALLOC_CMA
gfp_to_alloc_flags_cma
{
#ifdef CONFIG_CMA
        if (gfp_migratetype(gfp_mask) =3D=3D MIGRATE_MOVABLE)
                alloc_flags |=3D ALLOC_CMA;
#endif
        return alloc_flags;
}

//ALLOC_CMA->__rmqueue_cma_fallback
__rmqueue(struct zone *zone, unsigned int order, int migratetype,
                                                unsigned int alloc_flags)
{
        struct page *page;

        if (IS_ENABLED(CONFIG_CMA)) {
                if (alloc_flags & ALLOC_CMA &&
                    zone_page_state(zone, NR_FREE_CMA_PAGES) >
                    zone_page_state(zone, NR_FREE_PAGES) / 2) {
                        page =3D __rmqueue_cma_fallback(zone, order);
                        if (page)
                                return page;
                }
        }

        page =3D __rmqueue_smallest(zone, order, migratetype);
       ...
}

>
> After all, using GFP_MOVEABLE memory seems to mean that the buffer
> cache might get thrashed a lot by having a lot of cached disk buffers
> getting ejected from memory to try to make room for some contiguous
> frame buffer memory, which means extra I/O overhead.  So what's the
> upside of using GFP_MOVEABLE for the buffer cache?
To my understanding, NO. using GFP_MOVEABLE memory doesn't introduce
extra IO as they just be migrated to free pages instead of ejected
directly when they are the target memory area. In terms of reclaiming,
all migrate types of page blocks possess the same position.
>
> Just curious, because in general I'm blessed by not having to use CMA
> in the first place (not having I/O devices too primitive so they can't
> do scatter-gather :-).  So I don't tend to use CMA, and obviously I'm
> missing some of the design considerations behind CMA.  I thought in
> general CMA tends to used in early boot to allocate things like frame
> buffers, and after that CMA doesn't tend to get used at all?  That's
> clearly not the case for you, apparently?
Yes. CMA is designed for contiguous physical memory and has been used
via cma_alloc during the whole lifetime especially on the system
without SMMU, such as DRM driver. In terms of MIGRATE_MOVABLE page
blocks, they also could have compaction path retry for many times
which is common during high-order alloc_pages.
>
> Cheers,
>
>                                                         - Ted

