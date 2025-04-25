Return-Path: <linux-fsdevel+bounces-47312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591BDA9BC49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 03:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2581B67DC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 01:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3710482EF;
	Fri, 25 Apr 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckf7c1xy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67723594E
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544164; cv=none; b=DtPZwZIeQCBY9cCh2ewAnoncyhhKywLR3ub/Kia3MGow419NkieAd2nsBDtBKEyNGGdGI9326NDV5Tg3sCPUgvLTi2cgI/GT6TPYVtdERNU7RQMe16F8hmU17JIxTwGx8IHXGX+msXU5E5gvxkNRXPl6NDNM0I8wRW4v8d+LtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544164; c=relaxed/simple;
	bh=WALtWoGDrImkKsqlW52Px1QNOxoitv97VLOpHas8L74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XomKgHGscu1P3KxQLtyicJOGwemOE3vmglJ+5v0sJ1JvLE9fSNlqkLpGCmmrv/QRTfEtLlPAir0suBVz1nbp77V+ADY2exdElGXZE/hXVlwXaS7C8kDfaU8/8dP/rSLnOeIaTNpvBzkWDS3jL/EbsEJHLdYA3CLBB8/9xQwQ6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckf7c1xy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4774611d40bso141181cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745544161; x=1746148961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K9bjVigQ9XmXhq8by3Hj+E/GFtV7bsMbvNtbTFzChA=;
        b=ckf7c1xy25Zfb0B+r8Y/2DzCk5Z/tWL3iTBexZ2JHtA1Pe49AttMqnVF621IXNzlc4
         CO5ZxRMXM/IJfoN4baT13Eg502DCX7xZkIHGTi0I4mXlV0g8xDqD56u1iRKcuK50GECO
         KtdQT2dYT6CAJd/SCTQedz0yZdQq+aPavOduzes3UzM7Rbx6Ia18n3J8lzRqk5sxVX7w
         28AFBUwf+Pz+ONAa+1FLpGHXCo0nlgasfJ2bAu+L/sWm+/2IyfhpzHybb+EH7bqidQ7n
         YFA7SdXW6eQhMCMs3PVlkxpNjgIwepSTbmoslbQbUQSUV0VHR9WpcZMqMugNM5HKf/x7
         jODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745544161; x=1746148961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K9bjVigQ9XmXhq8by3Hj+E/GFtV7bsMbvNtbTFzChA=;
        b=OfmLeFMBVBs8ajYYZAO/coXHCqhTN9/mrII0UV331WbooGDdHoogrtvq2cgMkBNtsU
         KnX36lgtGqDgMvNns3fxb0CarwPA7Qiawyu+T7+oWgq+TbZ91dYo2020LyEiBSh9wfNS
         5jIomGu73TMF31OYvWhOh0Smlz6qKJtBnhIwYSMg1MDphsnWGZP/v0f3zpIqnQLTR0wX
         UQ0DueFuhVhUNJ1BEXx+ckwBEKb81Jmw94C2rljGjy4vOh5zR8hSzvxcsplcqQqcM6zf
         24ccXhQJqMmG0OsK1SqFjWjDjch9Ex96uW7InRU/7FufzhriCTUcmqIaXlD6kY4jY0Ol
         9/Og==
X-Forwarded-Encrypted: i=1; AJvYcCVqngjFkO6kgMKjTFbZ7BEwkrJDnz7b2F9hlDrS0A/WGihQsjgA4Dl1658uArMfsn5eH37Vk6zqqxZsnTnR@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPB/v1N7ScB7LmZvKy9Qpxli+w0wJA0IY86AUE6JaR11Qc2/N
	M0v1wGF7AifXbFy0i3nzY98nPpBc8gtsjkPzPxMmmMkRcX6eakZH17qWsgYudlt8H7GVFFZ3IB3
	PDxaPEa5cRLmwBZ84vEFg37to1mr1whClQip2
X-Gm-Gg: ASbGncvR7WhtC1p+TFBjbBYOx0i2m2KWqEZJcSJ8DLtjDXAta0O2zUz7qrdtMMESEEs
	j3OKpaICIQ9rnagnN+0MRYnjF4dDx5D90erQEBp14rjdcpZLEWiwlX3RVCeGoUPAYlslD7CzWJ2
	mF6O5hgSJ0/j6HtmZPIPlsA1FWEGJjag1SmI43Vp5UxWTTyJb62HXg
X-Google-Smtp-Source: AGHT+IEt/nPiv11l/e/GSMv5Za7I4jVSnD+KaNGcgmvToYwx1jTQJ15gKx+YYTluagAOfwzpKoB2aPCR4OBveZa7vHU=
X-Received: by 2002:ac8:6f0a:0:b0:47d:4e8a:97ef with SMTP id
 d75a77b69052e-4800b23eac2mr1072001cf.1.1745544161322; Thu, 24 Apr 2025
 18:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
In-Reply-To: <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Apr 2025 18:22:30 -0700
X-Gm-Features: ATxdqUHl3nwugWlcDPFs2JZXQP9ge1vI2-h6FI1XIzYNeJP5M_-gGtA7rBp5BFA
Message-ID: <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in mm
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 2:22=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > Right now these are performed in kernel/fork.c which is odd and a viola=
tion
> > of separation of concerns, as well as preventing us from integrating th=
is
> > and related logic into userland VMA testing going forward, and perhaps =
more
> > importantly - enabling us to, in a subsequent commit, make VMA
> > allocation/freeing a purely internal mm operation.
> >
> > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > CONFIG_MMU is not set, and there is no sensible place to put these outs=
ide
> > of that, so we are put in the position of having to duplication some lo=
gic

s/to duplication/to duplicate

> > here.
> >
> > This isn't ideal, but since nommu is a niche use-case, already duplicat=
es a
> > great deal of mmu logic by its nature and we can eliminate code that is=
 not
> > applicable to nommu, it seems a worthwhile trade-off.
> >
> > The intent is to move all this logic to vma.c in a subsequent commit,
> > rendering VMA allocation, freeing and duplication mm-internal-only and
> > userland testable.
>
> I'm pretty sure you tried it, but what's the big blocker to have patch
> #3 first, so we can avoid the temporary move of the code to mmap.c ?

Completely agree with David.
I peeked into 4/4 and it seems you want to keep vma.c completely
CONFIG_MMU-centric. I know we treat NOMMU as an unwanted child but
IMHO it would be much cleaner to move these functions into vma.c from
the beginning and have an #ifdef CONFIG_MMU there like this:

mm/vma.c

/* Functions identical for MMU/NOMMU */
struct vm_area_struct *vm_area_alloc(struct mm_struct *mm) {...}
void __init vma_state_init(void) {...}

#ifdef CONFIG_MMU
static void vm_area_init_from(const struct vm_area_struct *src,
                             struct vm_area_struct *dest) {...}
struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
void vm_area_free(struct vm_area_struct *vma) {...}
#else /* CONFIG_MMU */
static void vm_area_init_from(const struct vm_area_struct *src,
                             struct vm_area_struct *dest) {...}
struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
void vm_area_free(struct vm_area_struct *vma) {...}
#endif /* CONFIG_MMU */





>
> --
> Cheers,
>
> David / dhildenb
>

