Return-Path: <linux-fsdevel+bounces-21062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D7F8FD292
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B391C21C23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548DF155C9E;
	Wed,  5 Jun 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZaspJ99"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEF15351A;
	Wed,  5 Jun 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604051; cv=none; b=Nybfi8a/VOVczUngfTWMllrfP3wcckAyviw8tZjPB10AsVf66aZUUttSJc0lUPPYuCZREFeGiqr4XeG9modVCEKB1Cb9O0O0I3at7RKosZUDRFZRqCUpDsL6LEh6B7DJWGaZMp5EyXVn1nP5z86l+JmltrGQkOQGAmEdL+5rx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604051; c=relaxed/simple;
	bh=zHUNB3srC5m8VepwrOG7tIvrkNy+nREgWKumgaryJFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nKbXuFD9OA58x05gSXlP+1AWGbzUaVIG3CJqNptLEjSQHMYp2fBpgOslvstvSDm0KQCYip1eu2M8SzClFn4+3B7GvWxjjoRUQpTu69gsmnidpO9EZyF/KVi5aoe0mzzRu6V95RnF49WHzSq0E+5rqXi77ZutBt8QDShjEmXMHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZaspJ99; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c21d7de619so3119684a91.2;
        Wed, 05 Jun 2024 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717604049; x=1718208849; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xShohQaQijNVnGBy0vSCe1Lri84br3jamfs3+AUmWoU=;
        b=FZaspJ99aJFRhnTL97eL342oafWr+34JBR9vA7wK1mfLkQYMuy9tDZkrOGNOHaE6Z+
         EU65UlaXCoMYSq4g/veROU0MLEdM6cYKY9QguccNrHbvdOTzoxzw5RBZL1KDBjeXwOnm
         iIASMUrsKYmKZvsA7hkMEL/xuo7bByy1Bm/mLohsktNlya7f09BO/UQ2cxhwAEAbpQ56
         21T8LSR+h2yW7ouKI5I42ayuH6iAK/5rAgcafV3gf5XQFlwM4VpLrmEdBX4K0ZKkY4T9
         RBDMVYHibWRnrSbPdrrW8omBUBxxlisg6pqTqak8+GVIGaOknIgkSbu/QLLPue8U9AZu
         4YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717604049; x=1718208849;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xShohQaQijNVnGBy0vSCe1Lri84br3jamfs3+AUmWoU=;
        b=qOOPz8GgInkcxTEN3yzciFec/l0grX41ViShS8SHfNE606JCnEjmYkbdji4HmIsU70
         eKBfH/aCKPmO4XRHHKm4aAVZvMZWO/omlwV9TO4hCyT3LceW1b2Lq+BP5/GYc+1TOO4G
         6Ey+x53b5nFoVbP7wo6CTpKsSGzGDHogz9zh5BPbZBzjppb296YlaYbhQE5bouisGfpc
         4EmwitFniBgYHnbbFaqC1dXt183H46eJ2bwF0WZa39wfhRE2CyQzi6/o7LDLyYyT/ofp
         SBmPodgQUPeBh/rUnX7BEkPWygl/bVQVp5ST3i24VUcQ/I2QKLMotW/A0CU+8ArvzN00
         lbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCViF1i68iAFgYzkA8kjHerl1LKAVqcWNbt4qE6vpRpWQFKVu1b1O94BpBQtLhWA5P2/h7X2TshuF/lnbnCdA14MO6s5x5qdx/xWINibVsLZeFwYAyxoyX9quaRmF3CaauU9M+ayXazEokoR8mX8W6omRYrynSRrfKdrjIx1X3FoNw==
X-Gm-Message-State: AOJu0Yw3qDy+AkWRprTf9tPG464TEPoQCxgJGKO7NoT3gpuWiZuL7Kf/
	lu77lbe7Qlh/933fnDfNkJ6jSVLCZ6+77YQbpNFwsWU45VkWTwHC2XvSic/vBMLGnURx4l99dNz
	DRGN1aNhR+l58TVU1WilenHmtPKg=
X-Google-Smtp-Source: AGHT+IHDIZeudf9hp58R/vptexzs1Mrowe6BNsnF5Wlb/7372cK0lZMZTfKDqKmYcNXTjsWoONoUvuThHOfGib955fE=
X-Received: by 2002:a17:90a:d512:b0:2c2:8a67:96e4 with SMTP id
 98e67ed59e1d1-2c28a6797c7mr1470005a91.7.1717604048552; Wed, 05 Jun 2024
 09:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-2-andrii@kernel.org>
 <Zl-38XrUw9entlFR@casper.infradead.org> <uevtozlryyqw5vj2duuzowupknfynmreruiw6m7bcxryjppqpm@7g766emooxfh>
In-Reply-To: <uevtozlryyqw5vj2duuzowupknfynmreruiw6m7bcxryjppqpm@7g766emooxfh>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jun 2024 09:13:56 -0700
Message-ID: <CAEf4BzZFpidjJzRMWboZYY03U8M22Yo1sqXconi36V11XA-ZfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, surenb@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 6:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Matthew Wilcox <willy@infradead.org> [240604 20:57]:
> > On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko wrote:
> > > +/*
> > > + * find_and_lock_vma_rcu() - Find and lock the VMA for a given addre=
ss, or the
> > > + * next VMA. Search is done under RCU protection, without taking or =
assuming
> > > + * mmap_lock. Returned VMA is guaranteed to be stable and not isolat=
ed.
> >
> > You know this is supposed to be the _short_ description, right?
> > Three lines is way too long.  The full description goes between the
> > arguments and the Return: line.

Sure, I'll adjust.

> >
> > > + * @mm: The mm_struct to check
> > > + * @addr: The address
> > > + *
> > > + * Returns: The VMA associated with addr, or the next VMA.
> > > + * May return %NULL in the case of no VMA at addr or above.
> > > + * If the VMA is being modified and can't be locked, -EBUSY is retur=
ned.
> > > + */
> > > +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct *mm,
> > > +                                        unsigned long address)
> > > +{
> > > +   MA_STATE(mas, &mm->mm_mt, address, address);
> > > +   struct vm_area_struct *vma;
> > > +   int err;
> > > +
> > > +   rcu_read_lock();
> > > +retry:
> > > +   vma =3D mas_find(&mas, ULONG_MAX);
> > > +   if (!vma) {
> > > +           err =3D 0; /* no VMA, return NULL */
> > > +           goto inval;
> > > +   }
> > > +
> > > +   if (!vma_start_read(vma)) {
> > > +           err =3D -EBUSY;
> > > +           goto inval;
> > > +   }
> > > +
> > > +   /*
> > > +    * Check since vm_start/vm_end might change before we lock the VM=
A.
> > > +    * Note, unlike lock_vma_under_rcu() we are searching for VMA cov=
ering
> > > +    * address or the next one, so we only make sure VMA wasn't updat=
ed to
> > > +    * end before the address.
> > > +    */
> > > +   if (unlikely(vma->vm_end <=3D address)) {
> > > +           err =3D -EBUSY;
> > > +           goto inval_end_read;
> > > +   }
> > > +
> > > +   /* Check if the VMA got isolated after we found it */
> > > +   if (vma->detached) {
> > > +           vma_end_read(vma);
> > > +           count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > +           /* The area was replaced with another one */
> >
> > Surely you need to mas_reset() before you goto retry?
>
> Probably more than that.  We've found and may have adjusted the
> index/last; we should reconfigure the maple state.  You should probably
> use mas_set(), which will reset the maple state and set the index and
> long to address.

Yep, makes sense, thanks. As for the `unlikely(vma->vm_end <=3D
address)` case, I presume we want to do the same, right? Basically, on
each retry start from the `address` unconditionally, no matter what's
the reason for retry.

>
>
> >
> > > +           goto retry;
> > > +   }
> >

