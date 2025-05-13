Return-Path: <linux-fsdevel+bounces-48916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E523AB5DE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 22:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4313A4F7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D32BFC7C;
	Tue, 13 May 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8jSD5i9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092221F4608
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747168771; cv=none; b=m4cSy98d+oCrqUkm+SWapxj3AsArtsjJw0ZjqV0yzJuC+Lyj8hLMZbnUQPhhmP1mjTxUy5wDmAhGXUKT4YQ11vU/iaalTM93MphNPq5M/IJkISXXJJ5SxyY+I5R40/tcJRDERJhArSJImcNj0l4r2mp6G+kZIz+1FhuZhvqxZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747168771; c=relaxed/simple;
	bh=yAT/QBy78BrMBimb3jP4pyT1Rf2SlTC8NlTq8btAuJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiTw4MZmsqJsh633Fa8DE1+r2yQ2UmnkbuaV02hTFxkh+Jkh4B0yrtsMy3kY9PMCIcunsLzIh311V3F+7OqgIrJNzBuqtJgloUpYWwbjN95vNtuBYI3qF6UC+xRa3r/3Qts1dLg56/8atF62CMenKchOr5cjQecJ6CSWMMjlPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8jSD5i9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47688ae873fso67156761cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747168769; x=1747773569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fRBNif9MYU4R4jS58KSvNzpN1vITjZOzwOP1HOtOBs=;
        b=l8jSD5i9zJi6FBk8PVm0NBCFWC/Z2eDSWNX+9fBuo+AqOWsTLYe7TN6jUlbR+VL9y/
         JsfZyhtpSXeEeXbVQpIQGQepTm/lzXG7m00rHUyStXyieHNp0ZlhEsWXcwCrX3qVmsWm
         jJXEqCALzb+t3NLbQKFKQOZy07L8i+C5RfjvWOedZ3FIfP/TwfD0Zs99PILEGX7Dds0x
         bPPLyqCPFUf5cS4mryZBDbthnA+MPRZZyj3jRZkU5AuFzXGT8mtnK7CWUvagSHnmL5cy
         69++81DgmBUz4JBOo+dBy8s9/ZbYfjTtvsDfdEm2r9YTXVTxvL1S8XBWH2uclifcswCF
         10Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747168769; x=1747773569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fRBNif9MYU4R4jS58KSvNzpN1vITjZOzwOP1HOtOBs=;
        b=SHgjCuVoXkmF6YrUEFqHx0qfVB/Agtofo615KHPsSYMmdWSVRiAIxTVGVI4kxxlK+K
         FJV+vjo+YuRTbHR0ij0sNvp+KC3c50chs4YlbTElfgIUN/qV9VHeGT8D1AOfDe98Q6lI
         KpT2e1hT7/3aLNWmetrStk/n4owBVEedXiONxE+KAYLburHcUMLrUb+qhtXu1H7r0eLi
         VNP3MQPUPQG10qjJO9uh9wPb1MCjBVRDqODIUr6MbglogmNYrN6qcdP6yTslAJfiSFL+
         ypduBz+bJckd3VClaZe8TqHdPlru6XFR+GeFihqwaTQN6sW2N0H/5sb5YN4KR4Z/plzX
         foPA==
X-Gm-Message-State: AOJu0Yxfp99BNwlAh7f7iIDMYTC2tBiNKSuTjPDClyfJG5b2Y8qQ3wLs
	b423SJ73vX6Jyaoe/O0GgO5tEnluhbtwCWyAoB04CfCzK9q0n2PeW6MRYha2jnNimEKjIbn9wH6
	RPd3d6Nk2Rz572frg/E0WS8jKkSk=
X-Gm-Gg: ASbGncuuPWrqe9lIXSWnJeDqI66RvJppWjW7oHHLxMIGfnRShLz1AtpXnK4Okqm+780
	MSJGtxklVM6+Hb4VszFLPRMbWczlNBhpp4JKNNW2gSjisq8B1Ev6AcbfgihfW8fEi4i9rvtMoBQ
	/tUSmpufqhvI/vA4qIfMRT6vo+cu8xYDvr
X-Google-Smtp-Source: AGHT+IGmxIzvaidikQavQG5HTLL0VYre8eW5qOSphnPoaEunIXaMQikzwuUIymt+/i4v7zSTqpDnPzWLmOdYNfCpA50=
X-Received: by 2002:a05:622a:418b:b0:48c:428c:5b5b with SMTP id
 d75a77b69052e-49495cadebemr18464311cf.1.1747168768871; Tue, 13 May 2025
 13:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-11-joannelkoong@gmail.com> <CAJfpegs=3mhpQeXhu37HN=p846UFzxEg3NM9awwLwU+cKr1NZw@mail.gmail.com>
In-Reply-To: <CAJfpegs=3mhpQeXhu37HN=p846UFzxEg3NM9awwLwU+cKr1NZw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 13 May 2025 13:39:18 -0700
X-Gm-Features: AX0GCFu30FUZVmms0imlmtW53RKzhJMxLKLWFfFKmDYcDqnEQYnysgbYzZb6D3k
Message-ID: <CAJnrk1Z8OEjrvFtqgR22E-8MWE5MAbA3LDgv54XEHudr4ELsDg@mail.gmail.com>
Subject: Re: [PATCH v6 10/11] fuse: optimize direct io large folios processing
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	willy@infradead.org, kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 12:19=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Tue, 13 May 2025 at 00:59, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > Optimize processing folios larger than one page size for the direct io
> > case. If contiguous pages are part of the same folio, collate the
> > processing instead of processing each page in the folio separately.
>
> This patch is sort of special in the series, since the others are
> basically no-op until large folios are enabled.
>
> Did you validate this in particular?  Is there a good way to test
> direct I/O on a buffer with mixed folio sizes?

Hi Miklos,

No, I did not validate this case in particular. I'm happy to drop this
patch for now and resend it when large folios get turned on, if you
prefer that. It seems like it'd be good to add this case to xfstests.
Matthew mentioned in [1] that this can get triggered by:

"Userspace may mmap() a file PROT_WRITE, MAP_PRIVATE.

If they store to the middle of a large folio (the file that is mmaped
may be on a filesystem that does support large folios, rather than
fuse), then we'll have, eg:

folio A page 0
folio A page 1
folio B page 0
folio A page 3

where folio A belongs to the file and folio B is an anonymous COW page."

Looking at iov_iter_extract_pages() more closely though, I'm realizing
now that this function extracts only a list of *contiguous* pages, so
I don't think we even run into a case where the extracted pages that
get returned can have interleaved pages from another folio.

Ideally though, the long-term solution would be having a
iov_iter_extract_folios() API instead of having to use
iov_iter_extract_pages() as a workaround. I'm hoping to take a stab at
implementing that after the large folios work is done.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/Z1cSy1OUxPZ2kzYT@casper.infradead=
.org/
>
> Thanks,
> Miklos
>

