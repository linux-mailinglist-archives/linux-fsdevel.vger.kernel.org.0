Return-Path: <linux-fsdevel+bounces-46143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDEEA834D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D168D189CD7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5A21B9C3;
	Wed,  9 Apr 2025 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwNgXtFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE21A5BA4
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242517; cv=none; b=hyBVQOUyl5MkKLl5Yqk980yNnkSo9TI3nJaIpgXnrQjVVVdJDV1Lpmj0WaNT8iAKT35IlzmRzR7Xag5M9ZTFSBs/ImxTHaEKLjM4dmjx5LDn3APDGuFloyEevxkqMUOoD9fmEip3K8EcSTQ6tSlNm8e4t0ZIgbG+AdciD5DJyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242517; c=relaxed/simple;
	bh=jyCetvfhiphvRF6Rb9wi0iFQUmJa5nnNjmcLdyQd2JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuQQ+sQ7Xv/Vsw2jXu2Bz4nJiLwjZcg7EXNrBvn74oZdpVJ+1v2H63J2obRCThbOzJrYXEK9kQxZoo9jUj5CPDbAIjZmVaeWfboX77UySU511KMSzz2hLrbQYR4RW3c6Qtevqdmog6YuOrIxbtTweJYCeGQx8oPe3Gl6krKY0qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwNgXtFA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476b4c9faa2so2138901cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 16:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744242514; x=1744847314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTjrPSBrPYXmzrzc01mnjtNO0ZedRJO2/v4wSLyvGU8=;
        b=NwNgXtFALdrEhTNxNO5NQ4Lww4/psuBjGWo1s9jyo6xC/JKEHOnsgKyRoGST4iDQe5
         rwG7gKYXr+nCOaMB14dgX/VPcUPCDI+qcgr3t0m/vxzmVidPFBO9PmO/z9IXdCpFpbzY
         hNtWpIdxSnjsLTFJk+aAHRQ6i1Ddp/QBU81Dp9t4lW0E0uFVQN3eLtEgQmJ5g2F1MqQ3
         xjvrw62bKhwIHKnhBM0CXMG3qfeoPH0TpdtwIqLumZEquGYAGYUtz+8WccC3UkGhJNeJ
         XzELZxbH9KCliplkvTDQMEBd6IZbT6pN3uzs+Xf+dW6uTwLGOvAL8ZcqE/JK0U3r69Z3
         wj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744242514; x=1744847314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTjrPSBrPYXmzrzc01mnjtNO0ZedRJO2/v4wSLyvGU8=;
        b=IUwo5HL8VowceH8bUC+2jIX3Y9SorC6dn3AcUdlKJ2dw5/yLMZJVnNuEMftQ3sXuoY
         FTqNB+oQ7HmWKjg6PSXOT5ghEOYAAWDgEF8c7XV9qcowbupCa0EYZz2H4Qo2G1gwQu2J
         vbeUa/taRxehPsCIjQzN3CI7gRKYhEFFjog98a4M8BdS0AJVSZ+vxtS24mM2uV43SDGO
         xNgYNHuKh1krhuJiL65jjYJt8x2koPjPa4rFvoEPm5jBjYYo31DHgCEN8Timbfatm599
         F90AE/dpomXxAQyTGlX7/mAK1C/reAOD9X3/b0z+YHlvWbCs59xVtALViV4vm3mWoTv6
         oweQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0XlOKgaNbg4fVVnQDYcP9Lk74vnapin5H9OB3rs1OHPZj/FYubEt5yTL7200Hqz5bco3Qj3q9mzE3iZk9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcb9C+2F7NiMfmnDFybY8VgV1C0sFWxn9XY4Bxi/T+h18lMNlY
	GfLg2ugP7PKlKdOnPJL+qkqHKwFrGR3VOU1QY5I6HhsECpRIi2oBVBHdAle87a3H8+dPKm54SbP
	TydEgfahSzOmIWuImlxEwF7nalrw=
X-Gm-Gg: ASbGnctXZi5fUC15c4H0UCYw420JWHRgJiy9MqZGSBMX6d1BQGFTv+cyMubrdGueOGu
	i+d9IJQMdyyMMSjzfP33jbAl28JV1ttdbfj4tjkeavW5dzfSrb741yPgq4DdhI+zHDO31RDBloj
	bOONVUC3O7yX7M70I6YLBk0TS4pkN7l41f2THbaXKyWB74dEK8
X-Google-Smtp-Source: AGHT+IFjNAMEynO/Y+tFwWVJsr8l5Ssoacz9wKgc3F5AeOePnRb92snRqL3R1zs4lx7teB+6m61wE6vaawvomov7VeA=
X-Received: by 2002:a05:622a:1808:b0:477:6c0e:d5b3 with SMTP id
 d75a77b69052e-4796e2e44aamr5376201cf.6.1744242514326; Wed, 09 Apr 2025
 16:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-2-joannelkoong@gmail.com> <0462bb5b-c728-4aef-baaf-a9da7398479f@redhat.com>
 <CAJnrk1Z2S9K1AsNnYHBOD_kGsOmYuJGyARimtc_4VUgUWDPigQ@mail.gmail.com>
 <221860f0-092c-47f1-a6f8-ebbe96429b1a@redhat.com> <ukmd4fdrca2ofoqouq66rtjmq2agl57otwozvlwusnzxg3crah@byvep55p2hlk>
In-Reply-To: <ukmd4fdrca2ofoqouq66rtjmq2agl57otwozvlwusnzxg3crah@byvep55p2hlk>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 9 Apr 2025 16:48:23 -0700
X-Gm-Features: ATxdqUHqGhSUIMY5llb451gYpNwyrRA48zN9G3QOwLnk0WbeE4lpSvVouWTFKQg
Message-ID: <CAJnrk1Y2vOobjP4n0k4gtD3_xfPKiQk3eOg85HnKdMejFzR4qA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, miklos@szeredi.hu, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jefflexu@linux.alibaba.com, 
	bernd.schubert@fastmail.fm, ziy@nvidia.com, jlayton@kernel.org, 
	kernel-team@meta.com, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 3:05=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Fri, Apr 04, 2025 at 10:13:55PM +0200, David Hildenbrand wrote:
> > On 04.04.25 22:09, Joanne Koong wrote:
> > > On Fri, Apr 4, 2025 at 12:13=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> > > >
> > > > On 04.04.25 20:14, Joanne Koong wrote:
> > > > > Add a new mapping flag AS_WRITEBACK_INDETERMINATE which filesyste=
ms may
> > > > > set to indicate that writing back to disk may take an indetermina=
te
> > > > > amount of time to complete. Extra caution should be taken when wa=
iting
> > > > > on writeback for folios belonging to mappings where this flag is =
set.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > > Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > > ---
> > > > >    include/linux/pagemap.h | 11 +++++++++++
> > > > >    1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > > > index 26baa78f1ca7..762575f1d195 100644
> > > > > --- a/include/linux/pagemap.h
> > > > > +++ b/include/linux/pagemap.h
> > > > > @@ -210,6 +210,7 @@ enum mapping_flags {
> > > > >        AS_STABLE_WRITES =3D 7,   /* must wait for writeback befor=
e modifying
> > > > >                                   folio contents */
> > > > >        AS_INACCESSIBLE =3D 8,    /* Do not attempt direct R/W acc=
ess to the mapping */
> > > > > +     AS_WRITEBACK_INDETERMINATE =3D 9, /* Use caution when waiti=
ng on writeback */
> > > > >        /* Bits 16-25 are used for FOLIO_ORDER */
> > > > >        AS_FOLIO_ORDER_BITS =3D 5,
> > > > >        AS_FOLIO_ORDER_MIN =3D 16,
> > > > > @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(stru=
ct address_space *mapping)
> > > > >        return test_bit(AS_INACCESSIBLE, &mapping->flags);
> > > > >    }
> > > > >
> > > > > +static inline void mapping_set_writeback_indeterminate(struct ad=
dress_space *mapping)
> > > > > +{
> > > > > +     set_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
> > > > > +}
> > > > > +
> > > > > +static inline bool mapping_writeback_indeterminate(struct addres=
s_space *mapping)
> > > > > +{
> > > > > +     return test_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags=
);
> > > > > +}
> > > > > +
> > > > >    static inline gfp_t mapping_gfp_mask(struct address_space * ma=
pping)
> > > > >    {
> > > > >        return mapping->gfp_mask;
> > > >
> > > > Staring at this again reminds me of my comment in [1]
> > > >
> > > > "
> > > > b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to expr=
ess
> > > >        that very deadlock problem.
> > > > "
> > > >
> > > > In the context here now, where we really only focus on the reclaim
> > > > deadlock that can happen for trusted FUSE servers during reclaim, w=
ould
> > > > it make sense to call it now something like that?
> > >
> > > Happy to make this change. My thinking was that
> > > 'AS_WRITEBACK_INDETERMINATE' could be reused in the future for stuff
> > > besides reclaim, but we can cross that bridge if that ends up being
> > > the case.
> >
> > Yes, but I'm afraid one we start using it in other context we're reachi=
ng
> > the point where we are trying to deal with untrusted user space and the=
 page
> > lock would already be a similar problem.
> >
> > Happy to be wrong on this one.
> >
> > Wait for other opinions first. Apart from that, no objection from my si=
de.
>
> I am on-board with keeping it specific to reclaim deadlock avoidance and
> naming it such.

Sounds good, I will submit v8 with this renamed to
AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM.

Thanks,
Joanne

