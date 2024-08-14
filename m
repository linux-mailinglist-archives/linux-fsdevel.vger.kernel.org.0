Return-Path: <linux-fsdevel+bounces-25895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64071951641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA31CB22599
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9910C13D28F;
	Wed, 14 Aug 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep4Ch8wu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C25394
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623186; cv=none; b=I3xZk+M81soUgtHpMCfJukmroTraIr6hnv6D83R56RrwI80HzWU7Sv4zTxDhQTtX7Z0rPNlfIv+cHSS/5mX2gnFHaAzPdxNodaVmda6m2+HXcpgB365n2Wngt1pgoKMdGyu0xHWzLBAzh6DZQ/u8uhuGGbGbYW2vYpd5Kv6zY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623186; c=relaxed/simple;
	bh=vF4OX9sO0zUiw67Wpl8ZsJjcLkWo/yyhpusQjm8ANPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INJ+YJVLelBLAEv34LPl0O7cXYUSqFw7uWh+s39EE0uQ36XBhHxWvy/XeoCfYT3805QcFGMWmcHQhNvO8MgvsRcG8buA/jgsM65t+buwMnNHmidPxora1o440/4QPkWOss9afTtspzXz8YlXvq7DLAizUEM2eLlWRMlfRixqsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep4Ch8wu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6659e81bc68so63332527b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723623183; x=1724227983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGvZ8Nwv8GBiQUulIipgwv+J0c68LRgI3wqw2Kiq2dA=;
        b=Ep4Ch8wu37Y40jh+EBJXJFbX7y25YBRKrs9GUv9qu9sSoip3r+evHQX39zEw42+Xca
         a35wrA88zua+pTswyGWLPFLhStutp3KgMxUonVIi2ln1d9TsBVSuJUHVzWhFSs/ZX0Q9
         bun+9oIc0VsO9G59wOcRDx96mIAvSHB1eicf+kxulXn8/YN82366n+G18v2FrAZqRsXB
         Ss2+1wSwV+EB3cUL+R9c2pbDKUjIRB5Louk5OfcWwfxCiF5mza09hy15KDPG3JU3tCaK
         LY+o3DPeoHEY6D48A2Dp0CxXN00tmiZZTPZrGwv1AOcNHGirzkd+qXhy386UuxlVBUo8
         LBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623183; x=1724227983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGvZ8Nwv8GBiQUulIipgwv+J0c68LRgI3wqw2Kiq2dA=;
        b=IZLBgFVzNCxtbfYSUtifz6DCrniZGRb6UHuCNxdkZ1oIRQJku3Fg6ExNwbFT+XgvCm
         y71HOUp/ne0PHt+vk7E3emYywNCF5VErN20OI+DaCG9jWJpI99M5vSHguSXuLEdPtG/P
         h5InjXIGt3a/6XUou01cqioWiAmyxOw/3YDqaOHNV735/hSrEmdUut4RzjBiky8VAP1J
         rFk1Yx+3SQc5HkbeNLjUMUs72rDSFnLd/JNzwI92LO8FQVGO7dtDgLL0FaqcblLK0FNJ
         OHQbgkHsV62xl48uPaEtIYGQPzb7vb83kEoHiCDq3PENwmG1OiFXU6/JMYMsLG48KQ8E
         sHMg==
X-Forwarded-Encrypted: i=1; AJvYcCXyjUKu//oEKfmdC+PnGyCpp1Z2i+eydUBH+jUF2xBd6ov5ahkfu3Ld7hggf+tIlgPKKjwQrjcUJHwECbx13hUlzSQYDDHmDj4wwVYYHg==
X-Gm-Message-State: AOJu0YxIXy65ZNWbFQscEj5VTjgiTSVYZTb3GY6cewr5ksVrgij3HeF9
	82njOMYkPYEuURfY1eH7obgIXdcobs5CHwtWIRQHhikEJMO/r6rG1KeCqFELfkx3dwjPtEJmbBk
	4MO3RiRqJezCxBg4TGish6E/oOQQ=
X-Google-Smtp-Source: AGHT+IHPsyxsLJw627PD4PkNZdulH1HkpBqHnu70JOJZgWesLJszKkb1HmPCvSG/JsT00RpA/iRYML9yPs2FWC8VtPw=
X-Received: by 2002:a05:690c:4d83:b0:64a:efa6:b3d5 with SMTP id
 00721157ae682-6ac9a47849bmr25999987b3.37.1723623183563; Wed, 14 Aug 2024
 01:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org> <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka>
In-Reply-To: <Zrxfy-F1ZkvQdhNR@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Aug 2024 16:12:27 +0800
Message-ID: <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 3:42=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 12-08-24 20:59:53, Yafang Shao wrote:
> > On Mon, Aug 12, 2024 at 7:37=E2=80=AFPM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > > > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bf=
c
> > > > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To com=
plement
> > > > this, let's add two helper functions, memalloc_nowait_{save,restore=
}, which
> > > > will be useful in scenarios where we want to avoid waiting for memo=
ry
> > > > reclamation.
> > >
> > > No, forcing nowait on callee contets is just asking for trouble.
> > > Unlike NOIO or NOFS this is incompatible with NOFAIL allocations
> >
> > I don=E2=80=99t see any incompatibility in __alloc_pages_slowpath(). Th=
e
> > ~__GFP_DIRECT_RECLAIM flag only ensures that direct reclaim is not
> > performed, but it doesn=E2=80=99t prevent the allocation of pages from
> > ALLOC_MIN_RESERVE, correct?
>
> Right but this means that you just made any potential nested allocation
> within the scope that is GFP_NOFAIL a busy loop essentially. Not to
> mention it BUG_ON as non-sleeping GFP_NOFAIL allocations are
> unsupported. I believe this is what Christoph had in mind.

If that's the case, I believe we should at least consider adding the
following code change to the kernel:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..89411ee23c7f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4168,6 +4168,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int o=
rder,
        unsigned int zonelist_iter_cookie;
        int reserve_flags;

+       WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL && !(gfp_mask &
__GFP_DIRECT_RECLAIM));
 restart:
        compaction_retries =3D 0;

        no_progress_loops =3D 0;


> I am really
> surprised that we even have PF_MEMALLOC_NORECLAIM in the first place!

There's use cases for it.

> Unsurprisingly this was merged without any review by the MM community :/
> --
> Michal Hocko
> SUSE Labs

--
Regards
Yafang

