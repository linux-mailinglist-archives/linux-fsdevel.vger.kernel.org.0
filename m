Return-Path: <linux-fsdevel+bounces-28325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84196951E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D27D2847F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F641D6C77;
	Tue,  3 Sep 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GbqxNpYX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241B1DAC67
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347916; cv=none; b=b6WNq7EmmszS84StS0tVc3rbwhzeoQDeYcvS4YX39F2bysCqyZwuPxEnKnlvtqaD+t9AQRWwOZJNufQDHhYH2RGcFsJh9kd6GyY1048wUBepU1mA5k2RH/sJN8ukRMm85FVbZCT/FJ3qbd3XM/X7wrHOAyScABWun2rZKqxiTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347916; c=relaxed/simple;
	bh=9R2R23jf1PEhDM/oJgEjpe7S91A3RSK2laatLt/3BHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lycOxI7ZWVghPmakHea8lTEy3UssnarQMJZ1fBtE32k3DStKdc9DOPe7ke1GWif4r6+1gdDyaVTq2d/1sPJvlgBfmpPAqkGk9TPkaBoKPGywfr9SyFJc8DZ70iBQWeOkVemfX5sNaA6UQmh6jqqRTXJJM176al2wc87X0REeXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GbqxNpYX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso5236933a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725347913; x=1725952713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O1FUH7RDqc8uXX+mkPWVfnuu8rhsu2/+E91M6Uiz5sw=;
        b=GbqxNpYXi1cmt8b83A2CBRCxMzulZeHIhgBRL+89rvCk3c5rJCOctv2ncTyyE5sK05
         kLPLh+Gv26bsu2x3vkSaYffcg3NNMaIWQ+Puok5H9rrs6Mw6ppmiu1p18tShSU/LRXCe
         onvuuzfFY4kteuNPAP4Ome5pWQaTG/w/XFf3nim8sqmq3LHJY45g5uDta6Ld+QAKslu9
         48hpPzaWEapYbIgj/S4xQ8oyVhrkRSH7E2/8K5XAQQNl2LisT94VHWeLP445XB5rYvGD
         Qk5/xn8zok2BwqI46PeubcsAiSQQ5Vup6s9+37Wi/wKnGnXqiWFCAoRZ1U/c9gCLfLtK
         HK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347913; x=1725952713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1FUH7RDqc8uXX+mkPWVfnuu8rhsu2/+E91M6Uiz5sw=;
        b=BD1b/5K6fLZoGfhy1B2t4EApLaiIrNtUn2OMLGWISScVJcCxAcSJ2yNtTQ8W543LTE
         q8EOlsuXpiS5PBYFQg8N6fAooV5it4E4ze+bgby1eXQ/U0L98Fl7E8Op5J+yM3TSkje/
         rF9C2nR17S8MbG3V/JSFQt34edlsN6Kcwtx/Y7peF7VAxVKfHVFYqzVcZi5V2yF123HY
         TJBxmCMlBLGh53loEHgPgFuDqB1hOLIby8pW+FR3hBe8lVDq4lG21o859LJ/3YeYPGfW
         p5aaFUJ/3GnIcglg3a8zElWQV5dJr5LL/v9myh7AYrcYXQbKzzFGWuqjQipT8HPQ2lvp
         j36Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTK7V1hyFvz+addG+Re5sz5CRvbRQINOFrqUuN/l3Jm3GkItLeQi3YrBySxeXsu8DKpbbj81D1M3Fdoydz@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxLbdI2rKp07wnrRULm2mP4F6C3PPM7EhM6DoWBxooSHNXqsh
	31vd6ThpcRxcnEIWiT2dTH6lVScAwWDsLMFM8OpCQ7XETR8n1+QDgB/FcJmsl4U=
X-Google-Smtp-Source: AGHT+IH7o8OBuxsYo0So55zp2XL6wxWiUBp8CJS3P4zLH8eKh+LWdli7JkGefznOKzzc3ienqUEupQ==
X-Received: by 2002:a05:6402:5186:b0:5c2:1014:295a with SMTP id 4fb4d7f45d1cf-5c2200de37dmr16495409a12.2.1725347912777;
        Tue, 03 Sep 2024 00:18:32 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c255d3da3fsm2703971a12.79.2024.09.03.00.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:18:32 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:18:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <Zta4R1FQGcXPDLk6@tiehlicka>
References: <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area>
 <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka>
 <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
 <ZtWArlHgX8JnZjFm@tiehlicka>
 <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>

On Tue 03-09-24 14:34:05, Yafang Shao wrote:
> On Mon, Sep 2, 2024 at 5:09 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 02-09-24 17:01:12, Yafang Shao wrote:
> > > > I really do not see why GFP_NOFAIL should be any special in this
> > > > specific case.
> > >
> > > I believe there's no way to stop it from looping, even if you
> > > implement a sophisticated user space OOM killer. ;)
> >
> > User space OOM killer should be helping to replenish a free memory and
> > we have some heuristics to help NOFAIL users out with some portion of
> > memory reserves already IIRC. So we do already give them some special
> > treatment in the page allocator path. Not so much in the reclaim path.
> 
> When setting GFP_NOFAIL, it's important to not only enable direct
> reclaim but also the OOM killer. In scenarios where swap is off and
> there is minimal page cache, setting GFP_NOFAIL without __GFP_FS can
> result in an infinite loop. In other words, GFP_NOFAIL should not be
> used with GFP_NOFS. Unfortunately, many call sites do combine them.

This is the case with GFP_NOFS on its own already. NOFAIL is no
different and both will be looping for ever. We heavily rely on kswapd
or other GFP_KERNEL's direct reclaim to allow for forward progress.

Unfortunatelly we haven't really found a better way to deal with NOFS
only/predominant workloads.

-- 
Michal Hocko
SUSE Labs

