Return-Path: <linux-fsdevel+bounces-45792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A26DA7C4A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 22:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627A87A4D80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F521D3F8;
	Fri,  4 Apr 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KErL8425"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CFE567
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797373; cv=none; b=tshJk8rTBpUh9JufYkxpU8kZMcothTABdFqwH0SP4pMsjA5D/2j5izC18NP86YIJvLezlu2JvNaLjFKo4CwMmeCKoapbVTdE8FJSHK/nRBG2urU5wPwtJ2f2aeO2HheMWihXDhWeu4fTR4krF8TVYAp36ZkBJ+Sz8jaEfAuVASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797373; c=relaxed/simple;
	bh=JoVcBLgWXY5w4Rq8bKZFSnhsGSUZA2zbz0uFIdfMhSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXnMgPex59upSeXnVXlDGfNv4iFv2qybTbuhvVozuW1t3KUQfGsUcmxIRFYC6Cf7RvFfWLSxicVn+w4/dD6twSMavbMx1SBU13IyqMNAYL16Xh49wd/xYxGpcoFILG32JanjGh9Sb4Oe2cr7mpdiFfD0QQb7eOqxbNow+xmNt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KErL8425; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5e39d1db2so141195885a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743797371; x=1744402171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peCkHt+LDME+OD6D/AiSmy+EjQcuKrBKZOk6NvWEPtU=;
        b=KErL8425g5ZWUdqjctPhalFv0zFrSpWOpAOYNawOk0/j7nhDvc2MOvRV2EilalAYHC
         neWnkyb+yAU0v4CC757MK+8CfaxtBxUOGEHvUA45Wd0MTwzlcL2oCiJQ/KBWYvhu6Chq
         jEQWOEyPG72AwJkrHqc/mHP8N45j+0BWhWTr+66d+4pxG4k+vkSiaKcyB3IioqZhV69E
         JuRhGxsqwrMGFGdxnIlOtaU52v9gXPnK1CzoFb3suMY3jkF4IYXPG+f2cR+G9SSCrYci
         C6+Ec63cr5FncfhaCwkKrQS2UP3brgck7ECgZMu7wg57GHl1hQaE2YajJBmGkVFx6msy
         Jg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797371; x=1744402171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peCkHt+LDME+OD6D/AiSmy+EjQcuKrBKZOk6NvWEPtU=;
        b=Whk6ilTaOOhIF+70HZosPv+HgN4z8bqxChEi2ZcM554Al0VWbO7zMqppp54fj4mGn/
         sd1fs5iiakhKOYoJGg8GEMv+LYT9e2gluHHGNYjKQMll+zR93QYLt1csd2AtlLsRuN10
         Rt8YcvFPmXxgYQbnz1TajGgdPCcgkMgJkqCMGE/alE7CtMsEjy1LmuY9j1Q9rz0SZIV6
         7/87lxWSw+L0NbJXtYSVGtByDpcWJAa0Q14OwpsWM04v/rDsLR0WMubyOllRxT1da7fz
         rMTglWmqiQT4GnCctn5F3BpBajJDM5j0hp5kmkJxHluTBsY9ocDXI//MTb9GiblKTRUY
         JctQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgn5/I3uIf3wW/ujPD92yvIMktAECPYn+nRPCSeDcnSheZvbhhrdtqT4bAv9hAd0wWfupip3a9d1lu/aJf@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzTTfZdGCKoqV+3GRFWl5kUrUq0SeHdATNoYpcCnUltrFbKJ8
	CekpaeTtoAV+uzzqdH6oEcyoq/HmOZCJ0OcSG54R5uoTMPCO4l5OLM+u6fER29Hwqv9yHUGdotd
	MRgTOL/hG0JK4yU1pXBd0uahDVH0=
X-Gm-Gg: ASbGncuDY4i30cjZ7mi+tTCsVZDr2PQwNPbloHHX0lGB3p9Ta2mKwGI1xyfEotbS5Fc
	XLEXZ23tP1UwtJ4BnPKCYIPaHESzsJDp6/CFr8lrEttiOhUt/StKf12ePtMQaaibr94bnYJaaXi
	ORsZoPGnU5oW7qWFW02mBNwsENZdgZrUYTKgpqc7BDEA==
X-Google-Smtp-Source: AGHT+IFSQt7s2S3diZ6GEacLNQ3FK+Pn8kzzfoPCdjBaS9N90hjojGsbBGWs8cv9KnEJVglznxGfKDwZ7TSQmxR0eTc=
X-Received: by 2002:a05:620a:2903:b0:7c5:6ef2:2767 with SMTP id
 af79cd13be357-7c7759eab20mr492729085a.2.1743797370803; Fri, 04 Apr 2025
 13:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-2-joannelkoong@gmail.com> <0462bb5b-c728-4aef-baaf-a9da7398479f@redhat.com>
In-Reply-To: <0462bb5b-c728-4aef-baaf-a9da7398479f@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 4 Apr 2025 13:09:19 -0700
X-Gm-Features: ATxdqUGOpEdH6-QzzD09W4OCfRX_Obt5ojK2E8RLlQdnPHV74MxPE0Rx6EKOYvk
Message-ID: <CAJnrk1Z2S9K1AsNnYHBOD_kGsOmYuJGyARimtc_4VUgUWDPigQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
To: David Hildenbrand <david@redhat.com>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jefflexu@linux.alibaba.com, 
	shakeel.butt@linux.dev, bernd.schubert@fastmail.fm, ziy@nvidia.com, 
	jlayton@kernel.org, kernel-team@meta.com, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 12:13=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 04.04.25 20:14, Joanne Koong wrote:
> > Add a new mapping flag AS_WRITEBACK_INDETERMINATE which filesystems may
> > set to indicate that writing back to disk may take an indeterminate
> > amount of time to complete. Extra caution should be taken when waiting
> > on writeback for folios belonging to mappings where this flag is set.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >   include/linux/pagemap.h | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 26baa78f1ca7..762575f1d195 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -210,6 +210,7 @@ enum mapping_flags {
> >       AS_STABLE_WRITES =3D 7,   /* must wait for writeback before modif=
ying
> >                                  folio contents */
> >       AS_INACCESSIBLE =3D 8,    /* Do not attempt direct R/W access to =
the mapping */
> > +     AS_WRITEBACK_INDETERMINATE =3D 9, /* Use caution when waiting on =
writeback */
> >       /* Bits 16-25 are used for FOLIO_ORDER */
> >       AS_FOLIO_ORDER_BITS =3D 5,
> >       AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct add=
ress_space *mapping)
> >       return test_bit(AS_INACCESSIBLE, &mapping->flags);
> >   }
> >
> > +static inline void mapping_set_writeback_indeterminate(struct address_=
space *mapping)
> > +{
> > +     set_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
> > +}
> > +
> > +static inline bool mapping_writeback_indeterminate(struct address_spac=
e *mapping)
> > +{
> > +     return test_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
> > +}
> > +
> >   static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
> >   {
> >       return mapping->gfp_mask;
>
> Staring at this again reminds me of my comment in [1]
>
> "
> b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to express
>       that very deadlock problem.
> "
>
> In the context here now, where we really only focus on the reclaim
> deadlock that can happen for trusted FUSE servers during reclaim, would
> it make sense to call it now something like that?

Happy to make this change. My thinking was that
'AS_WRITEBACK_INDETERMINATE' could be reused in the future for stuff
besides reclaim, but we can cross that bridge if that ends up being
the case. Will submit v8 with this changed to
AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM.

Thanks,
Joanne

>
> [1]
> https://lore.kernel.org/linux-mm/0ed5241e-10af-43ee-baaf-87a5b4dc9694@red=
hat.com/
>
> --
> Cheers,
>
> David / dhildenb
>

