Return-Path: <linux-fsdevel+bounces-66206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D3C19811
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3105150372F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BAB2F6596;
	Wed, 29 Oct 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTPyymV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF442DA757
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731159; cv=none; b=XqhufNzSRgJTYxdT5Jj5wk2B+qMXnMeXxH0Ii7elFrDRmvUGHgI5hLA8lNBz+AtFNRhcDuhcZKOQEJgXGD1Vd1EJ1J+UJlaM2N3dGLcedatmlPsGJnFJxlhKEqpwDVniQEngHfzxksix3m2aARUkc4XEqxDKLZqflcEDrxet5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731159; c=relaxed/simple;
	bh=+eG+DZh4Mcc3z1uy4MNUctOCZyufRjLsNAdxEe98Jz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ow1GK2HvWpFPV1ux9YJi2nar1Tah65L3gmZs7kUmhogYiROAbtW19kWrjmerXhQdkTZzyuKZQgnXMZ5zfIiiqmzAz+1HBKNrzErFLCZhSDOlansXpB0KLpW8POyvTYqBVXKtNUo4K0opSLCpYcs+1bhIbHrkeXVQ6PPghBCoPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTPyymV1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-780fe76f457so70725407b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761731157; x=1762335957; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/9ZZO0rhubaMghlPDWYbVAhM+q6Jydtc36d3XX5xX8=;
        b=oTPyymV1cMSv99kCQqg/jKHU2+by0oW/w97dRRMHDohPhEWOZeFfe5d/Wi5lve69XN
         cHV3X9/wNEFGYFg/dsMOUXLgmMk5yEimY0aD6nzV8RXg4uvdnsbEuHMZAeeo8dUutw+5
         upTGuE/qPGQV2fgKmIdrM5SI+hD2TwMVTtrT24NlVlcYwktUrb0r1lwnU0nrfvIFHikX
         Sg5s4KlEcO/GGUIHYvMvyw9Q0+af1lLobxIuNmS1aE48SDXVE9VNae7GmKg9TNpFGi+W
         Zfzh8qDXE/AW9BJoQc/eAxbeW9V7/K/SQwGnGUEjLLFm5nRM3BhyqqAiZTaFk8NmrFrF
         PTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731157; x=1762335957;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/9ZZO0rhubaMghlPDWYbVAhM+q6Jydtc36d3XX5xX8=;
        b=KN7DwV85XauXIaPOt/bmAar3uUSwaGhDKASluJbgVqKIGDDkafjuVTKyATpmjQhKeX
         ThtVP+/cljuXI8IO9+pKWMALYm2kLUIkP/+UAiLfpO2fRwEpHKi3G1INIu1nOOKGDNWH
         Fezv1CaLZp3dlgziMDk11Q+gtxjCc72UYPqGGfEi56UpK5ZHxD648kqFijeJaSwnaY1L
         ebAigkWs/el2pDDm+Sw78+Am1T0ZXZ25x6pCYqkCudb/2Wi4H2Mq4mOyrQUjZ1PHO0Xj
         XySJUTZ4w19ZmETS78dEnawqaJ5s9HFcKS27/XmntAysjxeNaD0Rd06d8UHjjOo/XJwD
         KQrg==
X-Forwarded-Encrypted: i=1; AJvYcCVdHaY/WN7U4w5DUdO7mwgOxJiv/NC/xNf9CxLur1M8TnxAybP74kRA6nNjQ+4MybGjo4dmFlJhyyVt1iVL@vger.kernel.org
X-Gm-Message-State: AOJu0YzDjMaj4bjtjVhcIYBpvW0SntLXjKqRjKz17YCbZNDp+eZQkhMz
	61RDEaD1vkX0I+x/nFSIkjsqT39uak/ZquqnNz9lGcPdCrmip/KSshQyID9AA1dCXQ==
X-Gm-Gg: ASbGncsWLEtMcflAn6la/2PFAd55Y0lWCgQzH4kqyUqmD4l5wCCX4Rw21fm0Gqz3UQ0
	aGgtggEeNem2mgO0SrLWbBQlZ8RM+c7XI8d+z7Drj5ijsndCiX49ZldyqgcU4MxkDtIpEwZBV3X
	G9H76Yo9/U/cNMvyKnYfgbQbKKnCq5aJhu+lpZV5nAHdF5k3C/kxmV/vrQwAw16+5mLmTIDNofF
	DUroxF9+67GFVFFEUtIb3QNu5Iyeqxm8fnue5iD3LWthqEkO0KqiEZSxr0yIyRM/hjpNa13YBXT
	fGDz1JL4MrFHDaoarLusQqhxDr/T5jsnbk4V4wh8lq3GVb47Cs22TS+9/Ursqu8s8PpSetYrKZV
	Eryvr306AyLyE0harV0X+ZYUWObm4Qd4KnI+zBvsbDLYO5MHFr3GSzkM0N7P9SYHQ73IbZk/HuA
	7wft99xev6w8tVtCWHK8113rB/UFkPhfyiw948iOX3aPr/VVfoHalILzmflw5r
X-Google-Smtp-Source: AGHT+IEeP09fuX5a6/tVT4haAmvdF3K7vyTy354JjeQP1tfCemInfRx1yyo5g0HaztI92HwXX6vV3g==
X-Received: by 2002:a05:690c:4a05:b0:783:7081:c479 with SMTP id 00721157ae682-786293b13admr37307107b3.65.1761731156381;
        Wed, 29 Oct 2025 02:45:56 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed199f95sm34481207b3.28.2025.10.29.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:45:55 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:45:52 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memory: Do not populate page table entries
 beyond i_size
In-Reply-To: <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
Message-ID: <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
References: <20251027115636.82382-1-kirill@shutemov.name> <20251027115636.82382-2-kirill@shutemov.name> <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org> <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Oct 2025, Kiryl Shutsemau wrote:
> On Mon, Oct 27, 2025 at 03:33:23PM -0700, Andrew Morton wrote:
> > On Mon, 27 Oct 2025 11:56:35 +0000 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> > 
> > > From: Kiryl Shutsemau <kas@kernel.org>
> > > 
> > > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > > supposed to generate SIGBUS.
> > > 
> > > Recent changes attempted to fault in full folio where possible. They did
> > > not respect i_size, which led to populating PTEs beyond i_size and
> > > breaking SIGBUS semantics.
> > > 
> > > Darrick reported generic/749 breakage because of this.
> > > 
> > > However, the problem existed before the recent changes. With huge=always
> > > tmpfs, any write to a file leads to PMD-size allocation. Following the
> > > fault-in of the folio will install PMD mapping regardless of i_size.
> > > 
> > > Fix filemap_map_pages() and finish_fault() to not install:
> > >   - PTEs beyond i_size;
> > >   - PMD mappings across i_size;
> > > 
> > > Make an exception for shmem/tmpfs that for long time intentionally
> > > mapped with PMDs across i_size.

Thanks for the v3 patches, which do now suit huge tmpfs.
Not beautiful, but no longer regressing.

> > > 
> > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> > > Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> > > Fixes: 01c70267053d ("fs: add a filesystem flag for THPs")
> > 
> > Multiple Fixes: are confusing.
> > 
> > We have two 6.18-rcX targets and one from 2020.  Are we asking people
> > to backport this all the way back to 2020?  If so I'd suggest the
> > removal of the more recent Fixes: targets.
> 
> Okay, fair enough.
> 
> > Also, is [2/2] to be backported?  The changelog makes it sound that way,
> > but no Fixes: was identified?
> 
> Looking at split-on-truncate history, looks like this is the right
> commit to point to:
> 
> Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")

I agree that's the right Fixee for 2/2: the one which introduced
splitting a large folio to non-shmem filesystems in 5.17.

But you're giving yourself too hard a time of backporting with your
5.10 Fixee 01c70267053d for 1/2: the only filesystem which set the
flag then was tmpfs, which you're now excepting.  The flag got
renamed later (in 5.16) and then in 5.17 at last there was another
filesystem to set it.  So, this 1/2 would be

Fixes: 6795801366da ("xfs: Support large folios")

> 
> It moves split logic from shmem-specific to generic truncate.
> 
> As with the first patch, it will not be a trivial backport, but I am
> around to help with this.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

