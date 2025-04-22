Return-Path: <linux-fsdevel+bounces-46878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF932A95C60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E283E18904FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4E194A73;
	Tue, 22 Apr 2025 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjVEM4Jz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386963CB;
	Tue, 22 Apr 2025 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745290360; cv=none; b=edqn/gbdviimOZGgDv2cJ50wAECGOcJEDgxAuUeVOV1URyUBHi3wdR6wDldyegcAppkPjbF32yD/eC6FKdAxFSW00cMoNY9kARnVBRTgJd5cWrZ8W7lWhv8/QvKT8tlCM/oqaySzg8eSecRrC0tMGGtYZ5cvQnhGVc+vfcG2ogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745290360; c=relaxed/simple;
	bh=HzcXYKkb+gxiz/CypYGdA3srGhWNtD6xPuF1s4YZSJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5gqjiKwHgbR0dmkl2YaxgiKsz3cpPB5+H6Yfaqlhpar8H5QQ/ezQWxwh6P61UiXVt/1Dfv5aFHjauwjuX7TXEJX+PloZiKN3Q2eGPjCcmf6wyV2h1H3Z7lMOibC80zNnBM+lfEfS8DBQuJVk7T8G//gv7DzqKNwVMXrGj/wFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjVEM4Jz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bef9b04adso43297051fa.1;
        Mon, 21 Apr 2025 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745290356; x=1745895156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi94xerXwlRjfGn0o2uKZl55G3YIPKTGeFv4COfN76c=;
        b=hjVEM4JzvDsKZ04e9DBUpM8G74L/aNCRKBOhDoxahr6Xs4128NYbqQu+HR6YvS8omf
         Y/2gYOhH0wU2PQOdud6nBfjmkbW9w38qkeauhPpsj/Rezht7Cws8xQA5vT28iwS/Depk
         ABxY9zoHGucle3EZQSwpWjFecmssg6QszLb3YbDcM72I+3GJeUVSe52nE0ZWlk58c+sc
         vy9D4rpr6T7S+Qt4FLUtqyh4JAdNdNgKYN/2DPxTqklU9uqSQyIeegHYqPE0HlONoRMp
         puSyrwElMlNb5SbjgEdmMTYBK9RQGl1cCSA+vRK8AwLtMEOWGt569eYr1KCCN+jYEVBS
         0kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745290356; x=1745895156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi94xerXwlRjfGn0o2uKZl55G3YIPKTGeFv4COfN76c=;
        b=QlQz0R/09gw7AFMQnjxl86heXhlre7hu7/nHR3j3laJ0W8ZinSqm47pWzoPbU1zNtP
         lN3CgIZ2O4sgzCrqTTVzZ2m/V+p6+XaAsLs3BZmzhQT+5yGq/SjJK0ul2gTTqeqlsjkp
         EspTfpeGr6G9Bxqre4dqAcRRO8rfPq4fY7yisPhZ8LTdS7dgZM+1rIy4GhwUOae0WZXl
         6+Gqj/RN8jmEqPybPHMoQa89w7PNHMiQ++JVJQjoSB25TFCfKNEZHitJUBDZQzvMgB5t
         y/iyhoYEDuLUOeFOvyGbpZmiN758a1uUey2SMNGUtN1IfMK5x34ybOrLHxlcc6t3mSik
         0x/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGuL3Pm1svzhkUC1DRw/aDsg2GuPVb2gDJ2yr9+yYSAoxOclppZfMTDdS4yrPQRpj2vFFczrfGiA8P@vger.kernel.org, AJvYcCUUQqPUkPeaxvDNvyTFlh3G716ADIXmcv4UcDkBcU9vdwZqR2LN+q+U5y+SauZi7CvqndWqUxb6@vger.kernel.org, AJvYcCUuCcYoKavlQPuKFvvJpn5yK8uiKSi1ILiw/2eWCXqW3BYfPubm9mdBtprq0OWQD5EhLiZaCnq1onodj/AS1g==@vger.kernel.org, AJvYcCVKGudPHuJIp/KSq8eRk6Cer6cfYaZZB5/e79yP2jvi2cCd5BlmQzB/T2cgkjsj813lKkPkJ9V+4ZQ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/AF/SOCOCoDrUsD3YUqZq3DTELHkgoBS6LzDaaPqz6UMEeqUz
	BUyT7z/W4TykpM4WV+m7xt2ufFAifJV5n1L3JEVq+IraYCJD7uz2RwoYBKWv7fdRokbMTFoAzj8
	8By1ZDB4g7JANS1PuVXwb2BQT24I=
X-Gm-Gg: ASbGncuzNZJEGmXa6lrdR9PFP+kES7DYbX+BzXFTswNKp3ofFydSqYHCyvkCi0rqyNV
	U3EMsrfanpaMLq0yAilCAlu8ZQz8+aLzknUh7gebllFgjC3WW/pQu8y8MYFXUeiHYWymSi9BF74
	2tvH+dM27KNa7/Yx+Mv9ROyA==
X-Google-Smtp-Source: AGHT+IH0pobsEDhqgBiMybJBGFfzBmfi5gN6IfXj2PvvL+H/tCa0V7Nz3x0A1J61ubY6QCw1vhCT8drwcXBS924Rd8o=
X-Received: by 2002:a2e:bccc:0:b0:30d:626e:d031 with SMTP id
 38308e7fff4ca-31090575a6cmr50253431fa.33.1745290356289; Mon, 21 Apr 2025
 19:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303163014.1128035-1-david@redhat.com> <20250303163014.1128035-14-david@redhat.com>
 <CAMgjq7D+ea3eg9gRCVvRnto3Sv3_H3WVhupX4e=k8T5QAfBHbw@mail.gmail.com>
 <c7e85336-5e34-4dd9-950f-173f48ff0be1@redhat.com> <da399be3-4219-4ccf-a41d-9db7e1e45c14@redhat.com>
 <CAMgjq7CcSZf0be+OwttyzC3ZQJWZPOtDK1AtXvaPkuVuVk-XOg@mail.gmail.com>
In-Reply-To: <CAMgjq7CcSZf0be+OwttyzC3ZQJWZPOtDK1AtXvaPkuVuVk-XOg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 22 Apr 2025 10:52:19 +0800
X-Gm-Features: ATxdqUHu3Nlmi6Itb7v_9fuAuittkhb0QfY9n7T_xMcN79HZG93lA6soH-RwJPY
Message-ID: <CAMgjq7B_7jb9MRt+npesVhz1QV3sZ_6qzZQKHKP5J3rGVNJv6w@mail.gmail.com>
Subject: Re: [PATCH v3 13/20] mm: Copy-on-Write (COW) reuse support for
 PTE-mapped THP
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Muchun Song <muchun.song@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 12:35=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Sun, Apr 20, 2025 at 12:32=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >
> > On 19.04.25 18:25, David Hildenbrand wrote:
> >
> > Oh, re-reading the condition 3 times, I realize that the sanity check i=
s wrong ...
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 037b6ce211f1f..a17eeef3f1f89 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3789,7 +3789,7 @@ static bool __wp_can_reuse_large_anon_folio(struc=
t folio *folio,
> >
> >          /* Stabilize the mapcount vs. refcount and recheck. */
> >          folio_lock_large_mapcount(folio);
> > -       VM_WARN_ON_ONCE(folio_large_mapcount(folio) < folio_ref_count(f=
olio));
> > +       VM_WARN_ON_ONCE(folio_large_mapcount(folio) > folio_ref_count(f=
olio));
>
> Ah, now it makes sense to me now :)
>
> Thanks for the quick response.
>
> >
> >          if (folio_test_large_maybe_mapped_shared(folio))
> >                  goto unlock;
> >
> > Our refcount must be at least the mapcount, that's what we want to asse=
rt.
> >
> > Can you test and send a fix patch if that makes it fly for you?
>
> Sure I'll keep the testing, I think it will just fix it, I have a few
> WARN_ON_FOLIO reports all reporting mapcount is smaller than refcount.

Hi David,

I'm no longer seeing any warning after this, it fixed the problem well.

