Return-Path: <linux-fsdevel+bounces-11769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4147E85705E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA23F285699
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF5D145B2A;
	Thu, 15 Feb 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z5wTSasA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F71419AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035025; cv=none; b=SvrcTTgWe7Dnvt6cpVCuvsdMFzNurPFfKNV89iRo1A961vUzSidhh/oQIISQvHm7WLiw/0+1r5dkIK6cEKHK0hXXc5oltPqDksOd8LvjA9gkuZ1jsUCdUUhxLIeOV7rq9WZQgvRGWiplLzl3TlvQCrH4ueluzOMccW6k/bP4c94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035025; c=relaxed/simple;
	bh=yyAnxZLHxtUIlmQo1r4GlPP4knPmSLoBXYbWMNr6yNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRivhIIWcTU+f2QBcclhmWzeQj7POVlIE8oIDUaTuxS+7tPd6IXHbv0721aHhnGi+6DW/4BH9KWDTn0hptMEpwE2Hcz6A+apc5bhcdywrJrCNAiL+LB1MNMWGmO+AOEnnUq2D0HSVj9zk02S/V9beMM4WO1WlEpxM/Q4fdqguTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z5wTSasA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607d590aeb5so10042607b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 14:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708035022; x=1708639822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLHIWZhrv84d6KmPP8BZW5HG3tmTNG2nCmARo35gkoM=;
        b=z5wTSasAintVb0xk9c/XL4+gc9g7V6vjS46FpEg3svDbR0wvkFu+frPuzmnvIbnuyn
         zPDt6aPTkFLl54eHnlrY/EENJ0P7d0jenhQg1RYEeNEuNfW2Dppivd1tdTK+wRFMsKSZ
         rLvtTc5ysaSpq8r8+O0Y+lIj5Bs4Ro3GIJ+6F9uiAR29Ll3ktHhUtwifaBBkuk8bHE5F
         b1Lpmw1kiYTW/Z7dtGK0tcsV71lI6FJL7iN6n21M6bX7CUw5TLVhT9Q+oOM4MXwdaD6P
         rHrqEWYELbgs//LtblzNVxGlsbE6U88eTBLXcFMq/5kBzWC1MBWS3qYsefyjgJIEbpHZ
         EclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035022; x=1708639822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLHIWZhrv84d6KmPP8BZW5HG3tmTNG2nCmARo35gkoM=;
        b=l5e16H1tX61SOnwDf72Mh5wjwE6vXCjzXbTw//xE1iK77iVj1o+n6O8CI6KhDd27I8
         VYhAFqg20lRB3nGq4k1CzYY5G27ltyplQk4pxfTgPEzHKB7+GXYnHROeNMtksUm6WatQ
         ZjbhGCPNiTkDvQ1bybE1qqGjlrOnTahYV3tvQAYI37izbUYTKE6qKuKd40jRUKV+edR9
         jJjjvd323dxGiTte8GSz3yxT7mpvA9nF/6D3Tp1WdlqNCeDsgXKYVG+LkMxzLlashs7Y
         +XGN4PgKJzuO+eRheg+5pz3h+ywDv3DvgfxgdToqVj2SX3IsjucxSCAnw1MyhrtZ0Nr4
         Nsyg==
X-Forwarded-Encrypted: i=1; AJvYcCX69d1mtK7akA9SYa72QOzWHLMFBCpODGKqxCGaxSyOtWn/bkI2VrbL1ZuioGu937YG69/zLykWPoHnEo+BewE/iPexenSqdMS09XzxSw==
X-Gm-Message-State: AOJu0YwaWmHkJ9e7zwVkKhhqAMOwCIc/14eDI1H+TKQWUrQmAw804JlY
	jsfOHo1n2plD2synHhJMJ7tc09ANZ0IfGTPNLuYgcrygL09AaoQseYeZ+T/XLwt5tIIUNi8pnsy
	JUBbDb2YWs7zN4fGg5HRPQcRVRTtfLM3j3TRu
X-Google-Smtp-Source: AGHT+IFPqVFbWR3loG0cymbC1adYDa/mthQjD5ce08MYwc/pTnwtNoukSoOp+DLhCLmSTzEm3k2gZM9hlQK2lswT1QI=
X-Received: by 2002:a0d:cc81:0:b0:5ff:956a:1a05 with SMTP id
 o123-20020a0dcc81000000b005ff956a1a05mr3845012ywd.14.1708035021851; Thu, 15
 Feb 2024 14:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-8-surenb@google.com>
 <fbfab72f-413d-4fc1-b10b-3373cfc6c8e9@suse.cz> <tbqg7sowftykfj3rptpcbewoiy632fbgbkzemgwnntme4wxhut@5dlfmdniaksr>
 <ab4b1789-910a-4cd6-802c-5012bf9d8984@suse.cz>
In-Reply-To: <ab4b1789-910a-4cd6-802c-5012bf9d8984@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 14:10:09 -0800
Message-ID: <CAJuCfpH=tr1faWnn0CZ=V_Gg-0ysEsGPOje5U-DDy5x2V83pxA@mail.gmail.com>
Subject: Re: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, akpm@linux-foundation.org, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:50=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/15/24 22:37, Kent Overstreet wrote:
> > On Thu, Feb 15, 2024 at 10:31:06PM +0100, Vlastimil Babka wrote:
> >> On 2/12/24 22:38, Suren Baghdasaryan wrote:
> >> > Slab extension objects can't be allocated before slab infrastructure=
 is
> >> > initialized. Some caches, like kmem_cache and kmem_cache_node, are c=
reated
> >> > before slab infrastructure is initialized. Objects from these caches=
 can't
> >> > have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark =
these
> >> > caches and avoid creating extensions for objects allocated from thes=
e
> >> > slabs.
> >> >
> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> > ---
> >> >  include/linux/slab.h | 7 +++++++
> >> >  mm/slub.c            | 5 +++--
> >> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> > index b5f5ee8308d0..3ac2fc830f0f 100644
> >> > --- a/include/linux/slab.h
> >> > +++ b/include/linux/slab.h
> >> > @@ -164,6 +164,13 @@
> >> >  #endif
> >> >  #define SLAB_TEMPORARY            SLAB_RECLAIM_ACCOUNT    /* Object=
s are short-lived */
> >> >
> >> > +#ifdef CONFIG_SLAB_OBJ_EXT
> >> > +/* Slab created using create_boot_cache */
> >> > +#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
> >>
> >> There's
> >>    #define SLAB_SKIP_KFENCE        ((slab_flags_t __force)0x20000000U)
> >> already, so need some other one?

Indeed. I somehow missed it. Thanks for noticing, will fix this in the
next version.

> >
> > What's up with the order of flags in that file? They don't seem to
> > follow any particular ordering.
>
> Seems mostly in increasing order, except commit 4fd0b46e89879 broke it fo=
r
> SLAB_RECLAIM_ACCOUNT?
>
> > Seems like some cleanup is in order, but any history/context we should
> > know first?
>
> Yeah noted, but no need to sidetrack you.

