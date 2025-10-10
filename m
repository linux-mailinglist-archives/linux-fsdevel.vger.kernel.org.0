Return-Path: <linux-fsdevel+bounces-63779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EABF8BCD9F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66EC1355D72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899CA2F7465;
	Fri, 10 Oct 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTnmIb1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302862F619B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108050; cv=none; b=h6hzG4GPnTKZYCIWC6PcrzCDaG3gnNmvKl6nSelkeIoi5IVWYMgcv2YZnSuUnoGfxRwCqqqjq9CfJK7cTvwEtQgZOqcHvpSL3ysAlY+rhupmzpTM6f76rpwAqEqIGeu8ioPn8/Z6ACZOzM9IWAEHQ9IWz7vGopBv+GKJbHZWkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108050; c=relaxed/simple;
	bh=DC7x9YWROCenDmlSc1FcZsUca68HCfG/mUx/W7rmzrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJzneht6QmM64NyUyiaqrnrD7rvp7HLZ/xlaTbx2+MxGzfjPK7aFxRdrY568F4kWfhoMlyTdI8JAA1IvfOTHtEcA7pdH6hIWv7orRcnseYg2xNRcQfYICi8blnBIoJRtcaKIHGAobqeTsR+YsTuBFsjIC424L4sLxnHUaO8tAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTnmIb1T; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e6ec0d1683so314541cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760108048; x=1760712848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DpdiimUJLGEL9YZv8OhwGPgsBnQcaD8Xj4apakBfn0=;
        b=VTnmIb1TlHElKTohVvdtRHx7HEmeqrB8hSvmF22DJB+mQqqZZk+wvsDuz4uln9V7FU
         dpsQgLT/r6jgDPFmApUUPclup6rNvOlQo0ZBmnDUNevAy0Zisy9ZysmhlASpSd4Rc+w1
         UlL5OoGSVmhMYUtrcg8PpuJ5/J5BCFolzz31lFG/HMjjS7/pk80KXDRttm9jhNG34XxI
         y42d9fImcgtux4nhQ7EP8Q2jXzWGqDHaxpe/P/Sck42KrtcdBO5PGk1kL/VeEL5tIWyF
         /sauTiZHoQFdaXa8Z681DWvHC8T3LFGFuTu+3Zdya2+6jVwPi1yIjMqIFriwTRqAu6Ku
         DWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108048; x=1760712848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DpdiimUJLGEL9YZv8OhwGPgsBnQcaD8Xj4apakBfn0=;
        b=LwWMZtiHnOgNKobs+QlSZsApOs2+78GZ5Gl8qPVP4IlVBOgfHvF+v3uEiODRiFr25f
         jhjjw4yAyKoqHof6Dvnt7I6wbgJ2s4at0Tvq829+Ujv4yy+SUZ34IhYSiC+yY09+CWJu
         PCjil7hsFadVTZWSFh8KhdJ/JUyjj8ZfvElQetXkaZebE5RdUtiwgTakBsyqFpiq1lft
         wIs3M+LIgObJF0ORUBzPBEozKvQQhWto21O5mUbyzEKhuu+JV3x9+mdIh5Nao5yPtuEf
         3Cc8YzXyj0qM3+uXyhBZkL4pMJfI5GSTBkWiuy/uU4sCoa5kUVtmV5JkSVo2WgWm4++c
         4s0A==
X-Forwarded-Encrypted: i=1; AJvYcCVcP2q6iOiWXMrFtl70MX5b7RtUkwrhITblKUeexwCjIu35YQOH+DiDZAmZQXJYMIHpB3yBhUFOy4q1mabJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhao00fEac5eaW+U6tkeXphwPCIqZZxImrEQQxljqEwM/rrTAI
	XELp0HMX0Mb1IstIEngKtxIrFJyk+u6l4U/uNdnesCir9NmH0LZYcAwPd9RxcXPncfkWFdshGgN
	iGkYaAqXR0OB3SMEisHGcAWmp2rHcOnQZb5Ae20Aq
X-Gm-Gg: ASbGncuS4WclGSOTq8aonQ42tFqLjhZD+ZibeMEa148tgFiCELu+3avaPSyDf2qnVyG
	4lqzmlszhC+nPaUmhcdaDDGierj5ZD6jdvGrhrZrExVJcVRP8ASM43D5C26DNse0l36HF7AnFPC
	utmyLQbQQ6KqwBFBUhYxdeXbrhWgyZn84mWa+t07eSEVK/ZNlHN5Hx+r6jGjpbxNUhVKaR10INm
	F3eSFDVFfeETvjo7FjwoceAOZLJu7yhFfp7EX+4TaDdC5gk2rOv
X-Google-Smtp-Source: AGHT+IELG1HO5re9l71qV16AXiLCV5TxV3n/x4fv7b1UlE7oKp+shLXPJ4Ui15bl56g81Rjif4tTmM3A2oXDy0V1pv8=
X-Received: by 2002:a05:622a:50:b0:4d0:dff9:9518 with SMTP id
 d75a77b69052e-4e6eabcf616mr24839371cf.12.1760108047605; Fri, 10 Oct 2025
 07:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com> <20251010011951.2136980-2-surenb@google.com>
 <aOhx9Zj1a6feN8wC@casper.infradead.org>
In-Reply-To: <aOhx9Zj1a6feN8wC@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 10 Oct 2025 07:53:56 -0700
X-Gm-Features: AS18NWBSQfAZ95bfn8zHE7YuLwgx02HxJfLsEBTBLUde_yaDHMul1ATmajxkrCY
Message-ID: <CAJuCfpH85Ns8_+JNG4HS6TnFMUN0si+mcLXxUxedhQh1c0CSEw@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:39=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Oct 09, 2025 at 06:19:44PM -0700, Suren Baghdasaryan wrote:
> > +     /*
> > +      * 99% of the time, we don't need to flush the cleancache on the =
bdev.
> > +      * But, for the strange corners, lets be cautious
> > +      */
> > +     cleancache_invalidate_inode(mapping, mapping->host);
>
> Why do we need to pass in both address_space and inode?

Ah, you mean why I don't use inode->i_mapping to get to its address
space? I think I can. I'll try, and unless something blows up, I'll
apply the change in the next version.

>
> > +/*
> > + * Backend API
> > + *
> > + * Cleancache does not touch page reference. Page refcount should be 1=
 when
> > + * page is placed or returned into cleancache and pages obtained from
> > + * cleancache will also have their refcount at 1.
>
> I don't like these references to page refcount.  Surely you mean folio
> refcount?

Yes, mea culpa :) Will fix.

>
> > +     help
> > +       Cleancache can be thought of as a page-granularity victim cache
> > +       for clean pages that the kernel's pageframe replacement algorit=
hm
> > +       (PFRA) would like to keep around, but can't since there isn't e=
nough
>
> PFRA seems to be an acronym you've just made up.  Why?

Inherited from the original cleancache documentation. Will remove.

>
> > +struct cleancache_inode {
> > +     struct inode *inode;
> > +     struct hlist_node hash;
> > +     refcount_t ref_count;
> > +     struct xarray folios; /* protected by folios.xa_lock */
>
> This is a pointless comment.  All xarrays are protected by their own
> xa_lock.

Ack.

>
> > +static DEFINE_IDR(fs_idr);
>
> No.  The IDR is deprecated.  Use an allocating XArray.

Ah, good to know. I'll change to xarray.

>
> > +/*
> > + * Folio attributes:
> > + *   folio->_mapcount - pool_id
> > + *   folio->mapping - ccinode reference or NULL if folio is unused
> > + *   folio->index - file offset
>
> No.  Don't reuse fields for something entirely different.  Put a
> properly named field in the union.

Ack.

>
> > +static void folio_attachment(struct folio *folio, struct cleancache_in=
ode **ccinode,
>
> Unnecessarily long line

Ack.

Thanks for the feedback, Matthew!

>

