Return-Path: <linux-fsdevel+bounces-28321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D319693C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 08:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357CF286193
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 06:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0091D54CB;
	Tue,  3 Sep 2024 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGnz37Ym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A01CEAD4;
	Tue,  3 Sep 2024 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345284; cv=none; b=XSKxI0mQGVChBtiI5K+0VCtl+7bn5+9KaTnt41iYFiqNDL70pSnRd3Q7qLlidqgbd0tw2Wf5X+3iqKxr/CGehmFDY7AM0uoZpjOHscfCRjEeMpDIJMS8CufNXYjLp2VQhayxsiNl6QWj3YzKwME36dMQnMVq5scmeKiVGHSo0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345284; c=relaxed/simple;
	bh=Wv8Ur0Meq6UKefyBdzxbNxw7WEZwm6adxFTh2bzlHe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aoa1h9Jo/KHeyy/uGJO/CBegYm+c4cXN1lSwgKWRWmWitedI5srd/UH/qIxQkjooZYMzkZ2SIHAP8eXgDllNdvlvB+aemiVp2VPtxgyWUAfTqpZjwwj7rK4ees7aMEB5JjQ8fAJ222L8C5H0GRdRp+2f2aOE6B2tF0NsGezfu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGnz37Ym; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c3551ce5c9so23375876d6.0;
        Mon, 02 Sep 2024 23:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725345282; x=1725950082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv8Ur0Meq6UKefyBdzxbNxw7WEZwm6adxFTh2bzlHe4=;
        b=FGnz37Ym83SSh+xXFSWYgmezi8MN1ws2SQiCgIcUjmodCwbdnu5bCMRk3lkN1M+SjP
         HDV7i1dDiPQiHNBsfMO32ylnu2KmqKrAFqFsosTZ97EFaxmr0x4RvU8/eJhpi0TheT81
         soqpC37Z05p01H2GGFwkThgC+62xCzPMwbdMN9Hn0blScyhMnvlxDNlcw1cQqSjLUos9
         +6ICSjsMxzvwUuU2b+T3etdrbW+PQH0RXttU7i2R/IDLgK5uN91y3gpNlwK/sAd+X8MN
         IemUXc+4t3LWvlJdPUy3zhcFla23o0T0SZK9VA5eM7M1ffFjfNgIIk86iZQ+sKNbXNSY
         t4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725345282; x=1725950082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wv8Ur0Meq6UKefyBdzxbNxw7WEZwm6adxFTh2bzlHe4=;
        b=leUjCHareQfXKdOqpUGkdwZE6zo5FWMiaHW42jPs+A4AHTo2nVSNFhjsWpqzNDZ5Hc
         OoOSKZASF9SnrulqgM6zlbsmk4PToKGrMxCpQ15vCU8ff0h8BH3vfm2b6KTvtQMMYQM0
         lwSjy6qOkRIjbbM7HOWPp0VmfAMvAyVGY4l24g1iNXf+nZC0IUFksACZOdAM6wiuKr9y
         kA+7zcTPoRG+ZCc0P8rgun1SlaoAvuClL5maxR+qAfxREjOHIkS6z2yYfYUODuVBkQxF
         DGdGuq58cO6jZ8yvSW5IqpWKRiw3dbB7PP86FVOGmAT29Y3hF7LED90H6nkn5RhuWiAq
         hctA==
X-Forwarded-Encrypted: i=1; AJvYcCULqNf0xpXBedJTEvEWFQXzk1tBkoZ7ANwcxzUSXncSr4JqnvS0VdnotStYQK2sijX8FVydPPjYG8pytmYQ@vger.kernel.org, AJvYcCVBOtBmzCG/kzi8HHdbA83Twv2P+29BX/sNf+wDbvDiO2fNmQius7rUixBak7ijtj8zSrRorWk/ykpO8rkd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W6P1MgMFHxnI64WZgAz08e+d3bfG5EnANuQo+czAYwMb4vT1
	AXl3r0B7Kc2WpMXfZOVVU1TzMZ6S2si0MMooMMhT2+iI496s98LkGBCC9vROWNLNR29hORumgL/
	6To8MezpTg7SjzsGF/kga2jjpN3c=
X-Google-Smtp-Source: AGHT+IHv9LNrpQ60gaO44a46ARNnM3HvLJvdxYBhL9WZNaj42n0QReJ1qZyueALt1fVevYfJBw8qoHdjPn97268yrQg=
X-Received: by 2002:a05:6214:19e1:b0:6c3:69f9:fb49 with SMTP id
 6a1803df08f44-6c369fa03d8mr67547076d6.16.1725345282103; Mon, 02 Sep 2024
 23:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zs959Pa5H5WeY5_i@tiehlicka> <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka> <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area> <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area> <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka> <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
 <ZtWArlHgX8JnZjFm@tiehlicka>
In-Reply-To: <ZtWArlHgX8JnZjFm@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Sep 2024 14:34:05 +0800
Message-ID: <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc allocations
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 5:09=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Mon 02-09-24 17:01:12, Yafang Shao wrote:
> > > I really do not see why GFP_NOFAIL should be any special in this
> > > specific case.
> >
> > I believe there's no way to stop it from looping, even if you
> > implement a sophisticated user space OOM killer. ;)
>
> User space OOM killer should be helping to replenish a free memory and
> we have some heuristics to help NOFAIL users out with some portion of
> memory reserves already IIRC. So we do already give them some special
> treatment in the page allocator path. Not so much in the reclaim path.

When setting GFP_NOFAIL, it's important to not only enable direct
reclaim but also the OOM killer. In scenarios where swap is off and
there is minimal page cache, setting GFP_NOFAIL without __GFP_FS can
result in an infinite loop. In other words, GFP_NOFAIL should not be
used with GFP_NOFS. Unfortunately, many call sites do combine them.
For example:

XFS:

fs/xfs/libxfs/xfs_exchmaps.c: GFP_NOFS | __GFP_NOFAIL
fs/xfs/xfs_attr_item.c: GFP_NOFS | __GFP_NOFAIL

EXT4:

fs/ext4/mballoc.c: GFP_NOFS | __GFP_NOFAIL
fs/ext4/extents.c: GFP_NOFS | __GFP_NOFAIL

This seems problematic, but I'm not an FS expert. Perhaps Dave or Ted
could provide further insight.

--
Regards

Yafang

