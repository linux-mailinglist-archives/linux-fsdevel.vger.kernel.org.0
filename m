Return-Path: <linux-fsdevel+bounces-12644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E885C86222D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 03:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E96A287E71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 02:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF81118A;
	Sat, 24 Feb 2024 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YClsuH4q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10259DDA2
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708740159; cv=none; b=XVohOoKWccYl43bfzdO33pUHLpDLIQi3Kzf69wXQbAx6lUcNQlg9rPBZuMRLvjyDsaJqcSl5zT1xOqhbUOND7Odd2S3skveavtta+p0M801RYTqOl/h1IxfGh7RG9nZMjQ+K06iZjA9aGr+CVgrgyIEsEVXnWfKB2CF5pykmI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708740159; c=relaxed/simple;
	bh=aU9FbwN1S9//HRHbhdmeF+fyYNkS7K9J/zpvYfRP3hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5XOWduYyXd2MwbAwoJ6CbogNQ2FOxb2WRspgltU0V3gGPNRYHg+krLLjgzjSA/pxDBzR1ja3cAY2GXTnnb8HO7qOG+PysgnDTppKOS8bUWRoCJnE6m9tWidxZVY29kWz7ZEnXO8GhMhgHC+q4O24vyp/ShH6Wajl7CBd/oVfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YClsuH4q; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc73148611so1567539276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 18:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708740156; x=1709344956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PYgxetUjHOrEBE3OyfXnw/V4oH+FzaVrAptzS8yqHg=;
        b=YClsuH4qi+9Hbah7mEVNCxqPVcCh1T8fgiGQbuJcRakQfLjheg2rmtv16S3OI6V4sQ
         nlaUliNA1qA63z6vOZ6V7JomJp43uouyQOdEgd2pkPDnyJDjRgZcN66pvWp2GruffhWc
         CIBRI1tO6ZfFH2Z60sHRNNqlE06wOVp9jAkvkKMlc9QY2DSOKmGD75kn7V2D5MAg4Jia
         fausVUyE1OVR7gE3WJ1wOZM6I1dbiS3GSUPM0S3Ap+vHIhOrkHl16fOaXSGmE5XfDxg+
         +MYYpw01Ar1XB+euQdjKPPl7Xfo62jG9xoAT4Tn9iqq81a8td3y9txJl6eLlnqiy+wlz
         8DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708740156; x=1709344956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PYgxetUjHOrEBE3OyfXnw/V4oH+FzaVrAptzS8yqHg=;
        b=iAPAm72nfCWkiVx9fiCouMxg5HP8zxG/5d14IAaW527hvEVfnSHFU8poDf5CZ7m3hZ
         wMZY9hWSEH0SVhBIMJw/zWu3aL73ALFmqpumRQ8ppZhKJWa6XW9LAINRtgvk9QhsRBBb
         uSBsnZXwVY8LyOyFNuVOI5tRh93XMZh0Mhk1pHAaogaDGyJXUFh2MuE+iTvx/LI7o6Yz
         rVmkgfAiGuO/tvVvaOvujqGL1QuY4Y6L80NtDegECJ19mis1Hqafoj57GMhhZ3DSUIqP
         E7b0RQnD0kMg/99etSzYe/+jpACmHFZlwnKi7BGe8gmh/6B6tDxHjibjZ5A4/hvNpINf
         ph+g==
X-Forwarded-Encrypted: i=1; AJvYcCVDS9SY+9VOOlyzyUv8W38frgbPcWeclPHBRuyadIFWc4JkuRSQuhj4HQKBATIkqP3A8g0Vw8hZrwR6FF6uZotDizkjJ+UqglzCUxwdjA==
X-Gm-Message-State: AOJu0YwYvIUgBeI6d9CoiySWDc7AcnfumW6lVOaXOwTTrX54nJuMRmS+
	xXATRvUtzH6yHY7bvRdr6cclecgDSdLcCNDZXQa9tVNqLAXOcaeDmlFyoL8G3l7oVfCKH9PpdnB
	GBQnz5N/SQWxntvzoV6q85guCrafSr8hAFB/+
X-Google-Smtp-Source: AGHT+IHeD7s1jl7nDLOSZG0y9kCuKTd3u0TtUWQK/hX08wsrnwTSQEZdy4JG7wuGlK1ABvMhJVtPl8BOIpukOXAnbmk=
X-Received: by 2002:a25:9986:0:b0:dc7:4758:7802 with SMTP id
 p6-20020a259986000000b00dc747587802mr1258940ybo.48.1708740155772; Fri, 23 Feb
 2024 18:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-4-surenb@google.com>
 <CA+CK2bD8Cr1V2=PWAsf6CwDnakZ54Qaf_q5t4aVYV-jXQPtPbg@mail.gmail.com>
In-Reply-To: <CA+CK2bD8Cr1V2=PWAsf6CwDnakZ54Qaf_q5t4aVYV-jXQPtPbg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Feb 2024 18:02:24 -0800
Message-ID: <CAJuCfpHBgZeJN_O1ZQg_oLbAXc-Y+jmUpB02jznkEySpd4rzvw@mail.gmail.com>
Subject: Re: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook() __always_inline
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:16=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > It seems we need to be more forceful with the compiler on this one.
> > This is done for performance reasons only.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  mm/slub.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 2ef88bbf56a3..d31b03a8d9d5 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x=
, bool init)
> >         return !kasan_slab_free(s, x, init);
> >  }
> >
> > -static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> > +static __always_inline bool slab_free_freelist_hook(struct kmem_cache =
*s,
>
> __fastpath_inline seems to me more appropriate here. It prioritizes
> memory vs performance.

Hmm. AFAIKT this function is used only in one place and we do not add
any additional users, so I don't think changing to __fastpath_inline
here would gain us anything.

>
> >                                            void **head, void **tail,
> >                                            int *cnt)
> >  {
> > --
> > 2.44.0.rc0.258.g7320e95886-goog
> >

