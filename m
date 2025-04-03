Return-Path: <linux-fsdevel+bounces-45592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E52A79A72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 05:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18101892D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 03:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502318CC08;
	Thu,  3 Apr 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZOt/76W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81CB672;
	Thu,  3 Apr 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651169; cv=none; b=j9zgA20+NyLgW0ORLoMj66OmIjaPdZvtEjCpyxQE+ZOeJUg2ZVW/gJsP4jYcb7QGvusP2KVCGHYrwDulxeFgc4/frV3oona8us7z1MsvA1j8Kns23w6kyApF1WWlzDmycxMTmloZh35kX25rZKJpJoggmtKJQLJhSGpYYZUK7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651169; c=relaxed/simple;
	bh=Kvfr5kL7jbmC0Xtin82L19uIHAUE+wM26oS+0d0/nsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQbCzgeiUqHn3p8kwI15w4+EzSNALNRLHiH58ZI0lQXxIzsKKOZO75mvde5XeZSzIw1kehrtj8AsDZx7iENQ40gczt/CfzgfxNoo1pCS+1NHf8lNolUsdLJAV3w7MPmqKkzfoxzZndsBagwx08eNAO4j8r3jW6X9KTmNxi4FpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZOt/76W; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8fb83e137so4448076d6.0;
        Wed, 02 Apr 2025 20:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743651167; x=1744255967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN89JI2VQ7k82pxEYojzTPPzefEph7bPqyCjL2FCwjs=;
        b=RZOt/76W/DiEJEOheNFKY93iwJaqsT/ItrVDI7G96nZunyjI40WTmJjMmlltrJyLHp
         FNBCfdrjGrSb/ku7x1kT6Blu+t8gwIvMt8VCq0tbBkwwMGLTbwRgQP2nN0jUF5Tn6HGD
         lKaBaQuWK59m1n2+duXeVmXIi0m6fhTJR36ClODKZuAp7KZOZE/mzGE/8qKK4lNAQXoN
         tEpwOHEgXyQb2jk/X3tWF+6R+z22z65NS3Cok9/uo1CGaafQhPBkRAjpIP9ctDSVgcqS
         3LKyzS1Rl74ELjB9u4x/ahGieAE5NvNo6YnGCKgMsbH8B+6BpLP+4BHGEjL29UVIAyEP
         1fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743651167; x=1744255967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xN89JI2VQ7k82pxEYojzTPPzefEph7bPqyCjL2FCwjs=;
        b=aQh//BhlXu2kCywySTT9tO0Uapfcvmjrd4HmD5ma2IbVw9FjbB5/Yn8b06ZOLCems8
         wzpfPDD06cR7np7Y4kiBEWSDsbtZ1MOFoV2DW7v2ILcn/8BIYcK9NOFHR2hBItG7Z/u7
         ypY0FM6ejRITOPJPF3lnQwPG4uza2IZQoBfY8cGAclxQpsHP1k31NMrXlEBbai9Lhyqw
         QLRx65r+gq4A2Rft0z/MCmVAca+Xp+8H2j7q2xihDCrrukcfQ/8ymwS+PIHQcH9CXLwx
         9KIalnglwktSmt1nLZDdiqcIwbSgjTfiApDT726mNjiXZneUW1kYRtsPihnfNqI+SMB2
         VlUg==
X-Forwarded-Encrypted: i=1; AJvYcCUTF7LKhYQUBtOrLsxlKTwriYne35ArXDc+8Uou1NSWMDjRQm4CNbxXRdLE5zDhpm9N7tA0DRlq3Ef1zzrz@vger.kernel.org, AJvYcCX6M6O2trPXanuf9VaOD0DlaNg5wuNumIHo8Y6tfWdEbqk9FWaOM0eEZzLs0PnkmjKb1K/bHgmuzDkzp/Ut@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKmCSptiT/2qvyTXdOJJx4JJ4VqJd2iWkLh0vlQJEsu7WU17j
	j8aTNyv1arZbuVTW5jzoy80M7ce3IpKPMfloCeB0xy1+Qv7f8WjWCca8iVwI8JEuNpqC53sBPZu
	LfDItYGUtYS+/1mtOrRFCONHlYGw=
X-Gm-Gg: ASbGncsfbw4Pp7nDaloSVwQTbunVQBvwjd56aR452Nzd9dSVgHkOTqGWIzcd4rrsFSu
	s+73o3U8IdxV0B6rhX/ab54eR+hY5i/l0EWqnCSM2C1llKSOPcCyNs76MsR3w6J5WHkwrVOeunO
	dGrGJydtJ+KIUBE0dJoPvNB95S2IA=
X-Google-Smtp-Source: AGHT+IFUg4ZAqjvgc5pcOSRgS/+j30sZrK9LRS7T6zrlZ59bfE+yMCiIgfxNFAGq5EqcJ4aApveq8wVzT5JQTS15L2I=
X-Received: by 2002:ad4:5ba1:0:b0:6ea:d033:284c with SMTP id
 6a1803df08f44-6ef02a84e08mr88985886d6.0.1743651166795; Wed, 02 Apr 2025
 20:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401073046.51121-1-laoar.shao@gmail.com> <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry> <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area> <Z-0sjd8SEtldbxB1@tiehlicka>
 <Z-2pSF7Zu0CrLBy_@dread.disaster.area> <b7qr6djsicpkecrkjk6473btzztfrvxifiy34u2vdb4cp5ktjf@lvg3rtwrbmsx>
 <Z-3i1wATGh6vI8x8@dread.disaster.area>
In-Reply-To: <Z-3i1wATGh6vI8x8@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 3 Apr 2025 11:32:10 +0800
X-Gm-Features: ATxdqUFkqq208cw4cDch-CknV3k9kx8MlaesikBMQDQvSW8KA9P4N_gPOjl9ANA
Message-ID: <CALOAHbCn=AETSFf_kPb7w2kjZp_4JnEcmoOKMEUQucYUQuWEUA@mail.gmail.com>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
To: Dave Chinner <david@fromorbit.com>, Uladzislau Rezki <urezki@gmail.com>, npiggin@gmail.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>, joel.granados@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:22=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Wed, Apr 02, 2025 at 04:10:06PM -0700, Shakeel Butt wrote:
> > On Thu, Apr 03, 2025 at 08:16:56AM +1100, Dave Chinner wrote:
> > > On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> > > > On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> > > > > Have a look at xlog_kvmalloc() in XFS. It implements a basic
> > > > > fast-fail, no retry high order kmalloc before it falls back to
> > > > > vmalloc by turning off direct reclaim for the kmalloc() call.
> > > > > Hence if the there isn't a high-order page on the free lists read=
y
> > > > > to allocate, it falls back to vmalloc() immediately.
> > > > >
> > > > > For XFS, using xlog_kvmalloc() reduced the high-order per-allocat=
ion
> > > > > overhead by around 80% when compared to a standard kvmalloc()
> > > > > call. Numbers and profiles were documented in the commit message
> > > > > (reproduced in whole below)...
> > > >
> > > > Btw. it would be really great to have such concerns to be posted to=
 the
> > > > linux-mm ML so that we are aware of that.
> > >
> > > I have brought it up in the past, along with all the other kvmalloc
> > > API problems that are mentioned in that commit message.
> > > Unfortunately, discussion focus always ended up on calling context
> > > and API flags (e.g. whether stuff like GFP_NOFS should be supported
> > > or not) no the fast-fail-then-no-fail behaviour we need.
> > >
> > > Yes, these discussions have resulted in API changes that support
> > > some new subset of gfp flags, but the performance issues have never
> > > been addressed...
> > >
> > > > kvmalloc currently doesn't support GFP_NOWAIT semantic but it does =
allow
> > > > to express - I prefer SLAB allocator over vmalloc.
> > >
> > > The conditional use of __GFP_NORETRY for the kmalloc call is broken
> > > if we try to use __GFP_NOFAIL with kvmalloc() - this causes the gfp
> > > mask to hold __GFP_NOFAIL | __GFP_NORETRY....
> > >
> > > We have a hard requirement for xlog_kvmalloc() to provide
> > > __GFP_NOFAIL semantics.
> > >
> > > IOWs, we need kvmalloc() to support kmalloc(GFP_NOWAIT) for
> > > performance with fallback to vmalloc(__GFP_NOFAIL) for
> > > correctness...
> >
> > Are you asking the above kvmalloc() semantics just for xfs or for all
> > the users of kvmalloc() api?
>
> I'm suggesting that fast-fail should be the default behaviour for
> everyone.
>
> If you look at __vmalloc() internals, you'll see that it turns off
> __GFP_NOFAIL for high order allocations because "reclaim is too
> costly and it's far cheaper to fall back to order-0 pages".

This behavior was introduced in commit 7de8728f55ff ("mm: vmalloc:
refactor vm_area_alloc_pages()") and only applies when
HAVE_ARCH_HUGE_VMALLOC is enabled (added in commit 121e6f3258fe,
"mm/vmalloc: hugepage vmalloc mappings").

Instead of disabling __GFP_NOFAIL for hugevmalloc allocations, perhaps
we could simply enforce "vmap_allow_huge=3D false" when __GFP_NOFAIL is
specified. Or we could ...

>
> That's pretty much exactly what we are doing with xlog_kvmalloc(),
> and what I'm suggesting that kvmalloc should be doing by default.
>
> i.e. If it's necessary for mm internal implementations to avoid
> high-order reclaim when there is a faster order-0 allocation
> fallback path available for performance reasons, then we should be
> using that same behaviour anywhere optimisitic high-order allocation
> is used as an optimisation for those same performance reasons.
>
> The overall __GFP_NOFAIL requirement is something XFS needs, but it
> is most definitely not something that should be enabled by default.
> However, it needs to work with kvmalloc(), and it is not possible to
> do so right now.

1. Introduce a new vmalloc() flag to explicitly disable hugepage
mappings when needed (e.g., for __GFP_NOFAIL cases).
2. Extend kvmalloc() with finer control by allowing separate GFP flags
for kmalloc and vmalloc, plus an option to disable hugevmalloc:

  kvmalloc(size_t size, gfp_t kmalloc_flags, gfp_t vmalloc_flags, bool
allow_hugevmalloc);

Then we can replace the xlog_cil_kvmalloc() with:

  kvmalloc(size, GFP_NOWAIT, __GFP_NOFAIL, false);

This is just a preliminary idea...

--=20
Regards
Yafang

