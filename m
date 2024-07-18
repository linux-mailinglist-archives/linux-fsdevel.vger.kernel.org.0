Return-Path: <linux-fsdevel+bounces-23903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E3934996
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA001F23650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C979B99;
	Thu, 18 Jul 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TzWi95UD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4091BDD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290175; cv=none; b=KKZuwz7ldKMhllf6Apsl0SgMEcnWazbndSfCG2wcbyByRFnYaX5KfaMuDchEq1gYPM/GDbyKcBT4GQhtEWyWgLrnTiMqMUsZvCK24UB+go1HCTtSUSF5Hgdw3e1qUsxeU9T48gJZy52h0ksg+k2we1WCa0sJo1eSnoFRjp5FQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290175; c=relaxed/simple;
	bh=TDYm5PZVfZHPLUELKTZw/I1/ewmmqaWyG3B3esIwX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIigiqJguXgBzr2ochEF7F/zZljQLJkS96wmtXFkSprOlpD9MukOxDZdJQXT8F0rSDn4HfFA3w5XDZx4SCr4/ZAmTgy37nOyCHJUjtQqvhqNILQMWBiob6gKKmLIAiZeXPykXVdVFdobJ93Jlix3zwxY2mZxUbxYu1OT85NjfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TzWi95UD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ed741fe46so63475e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721290171; x=1721894971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tXMh51KVDkJmQr+NxLPzI9t9Kwi4FwG+tK/QlWBahKs=;
        b=TzWi95UDhOtfJrxTJ5O+Dqqgm7t96Pc5jM2LjfuDMEw5ZIp8ZH7WwMEf53WZX+v4jw
         18dE6qLgUDCwxrpLVrXFT5w6EZoWaAZSQIbz8SIUKLom0chLcEZ1q5xfV4auELrX/OlS
         gtWyu9mYI2+S4y0mGlPfCjScFxZlkq8rCzN/GH4pMR9RVEHvcijtDpfU8SAmAlumSNxv
         pjQANwSnQk9d8Yje15uzxtkzfISwceeIBI/mmrwUIFhgfXbTcsoYCnAkGioFvRcgxXvF
         q7SfeVyH7ZQaYzE50UxQDYBxOkWlWTC0kCpgFDhucYnBObJKUcYKGFThSZTGXeKZyp56
         Ml2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290171; x=1721894971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXMh51KVDkJmQr+NxLPzI9t9Kwi4FwG+tK/QlWBahKs=;
        b=eu1W0A2cw2qhWVoTOltDx9ATjhRapK2FD5axpcijjJHTxNnxm/s0IEUFsNoyJNj7C0
         LF0Bi0jk88Bt02yI746JEyMZKsT7av7GOIy/7+eyc3S6x/xrz6+2+7GE1F96FojS0EJd
         Hr43IvJnbx91G0auUVGMxaGgJfidUKR3UjH2XQ4SSd88HkPJW3U6Co0ivKKOrKF62a7z
         PjCGxRfHUhD4Y9PuoE1Amt3QZgo2xQ4HV3vEEybVP57Rgihky2bQD3nzCjG5wFxrOrfn
         k3D3Uoh310zSvoZ98SJ9+BDQnHEDVAO+Tg0YP/5F4MokhrgK4f2NSwZS4SP+c6nPl1D0
         lGSg==
X-Forwarded-Encrypted: i=1; AJvYcCVFr0ZbvzAriiDqRl4OzkW3g4v0+ax0lIeyMjzCNloaMDDbwnRGPv0/B7bAogiRvqYpp/z0pjhUuBGJOTAtLaiV+2NECJ164dTf/qE2dw==
X-Gm-Message-State: AOJu0YzYmRvojdchU1uCG3lg06uVZxpiH0C8nl9Fi/EApq4Lw+eUD/uD
	H6yId9KYH0mAp4yIs9zuhbbi/BqEJ4jDmOlCMv9sSHXBAhgDYLDM+vZczYcKsBIWgvRlLi0ABgs
	l
X-Google-Smtp-Source: AGHT+IGegX6hhcdBy2hHYfDBsDRJkiHBdAAF1OXnxmmpbPiUGv7h+8z8jYIwpVOTdMuMRgTCMfHFxQ==
X-Received: by 2002:a05:6512:3c93:b0:52e:7f6b:5786 with SMTP id 2adb3069b0e04-52ee543f25emr2769637e87.61.1721290170831;
        Thu, 18 Jul 2024 01:09:30 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff9fbsm531461866b.154.2024.07.18.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:09:30 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:09:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <wqu@suse.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Cgroups <cgroups@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Message-ID: <ZpjNuWpzH9NC5ni6@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
 <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka>
 <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>

On Thu 18-07-24 17:27:05, Qu Wenruo wrote:
> 
> 
> 在 2024/7/18 16:55, Michal Hocko 写道:
> > On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
> > > On 7/18/24 12:38 AM, Qu Wenruo wrote:
> > [...]
> > > > Does the folio order has anything related to the problem or just a
> > > > higher order makes it more possible?
> > > 
> > > I didn't spot anything in the memcg charge path that would depend on the
> > > order directly, hm. Also what kernel version was showing these soft lockups?
> > 
> > Correct. Order just defines the number of charges to be reclaimed.
> > Unlike the page allocator path we do not have any specific requirements
> > on the memory to be released.
> 
> So I guess the higher folio order just brings more pressure to trigger the
> problem?

It increases the reclaim target (in number of pages to reclaim). That
might contribute but we are cond_resched-ing in shrink_node_memcgs and
also down the path in shrink_lruvec etc. So higher target shouldn't
cause soft lockups unless we have a bug there - e.g. not triggering any
of those paths with empty LRUs and looping somewhere. Not sure about
MGLRU state of things TBH.
 
> > > > And finally, even without the hang problem, does it make any sense to
> > > > skip all the possible memcg charge completely, either to reduce latency
> > > > or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> > 
> > Let me just add to the pile of questions. Who does own this memory?
> 
> A special inode inside btrfs, we call it btree_inode, which is not
> accessible out of the btrfs module, and its lifespan is the same as the
> mounted btrfs filesystem.

But the memory charge is attributed to the caller unless you tell
otherwise. So if this is really an internal use and you use a shared
infrastructure which expects the current task to be owner of the charged
memory then you need to wrap the initialization into set_active_memcg
scope.

-- 
Michal Hocko
SUSE Labs

