Return-Path: <linux-fsdevel+bounces-23904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B337A93499A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 10:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6858E2849C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 08:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC07A15C;
	Thu, 18 Jul 2024 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WyBbxCCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F2768EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290236; cv=none; b=sQBHiLf1VBQvODJywwoy6q84QzuQJ5s4lwcV/KojeipfQJxfFCuBiJSH7bk5Lay+g458sFj5tCiIdvAScAQChvdNRZJ2qn47adtPqOcij3GXPSHYIB6U3gJ+ADlofkkzX3Vrzca5oTYTl9JJQGOGVOPw0DLTBXHLG3BKPxyLJbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290236; c=relaxed/simple;
	bh=W8W8eSSicchF0HTNnpjwRvYnekiZ4wDdutg80Ex7/RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmhzBy3dv9jx6gV8wU/ZssJi5nT08PF/HUP+ZgaMU4g5qcZHyqMlAeC2fGNQah4UVSh+CaUAK02sLSrqz17DYZdMUBadd//VPLRhKwkRO+HXBQl8LS+qEqSi3BinLwNJonPcFP7pcH959VJFGS9RG38b4mmYrvz8m05aWoLYXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WyBbxCCK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a79f9a72a99so303500766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721290232; x=1721895032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76dnrtuWhzYwHnyFzkGb7MBr43hvYawhckJH3fPSFL0=;
        b=WyBbxCCK0an4c4IxImvRcZX1v8Ml/yDbPUTJ40hc+HIhWi+qyxGKHU90mvJCEotteg
         hbyB52jOiUDi+xpky+xYdfXwUpIwGho50NWBv9+W8OmyVxCc53ILNhKfwsvSZMSbmb9L
         OwSxsNpwHS2zibFvtmURzSfnpY5ALVwH7C7w+n87QB64NnxwF1eYMSkMY5No19JceHTO
         Di0GD+/gH/P3bzjd2f3q6fbt8t29m4j28sqlb8mLXiIDMBHpJlihcdXM2xNRakM1WZZV
         VurE6p9I3WK/oEHx4gxSR0B6eL3wU6MiKbAbo09AzGB4nZe6kwhpavgmtoaN8JtlgbDA
         zJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290232; x=1721895032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76dnrtuWhzYwHnyFzkGb7MBr43hvYawhckJH3fPSFL0=;
        b=vAPMgai8vlDKrU0ApCBj8K7myO/GlgF4iWjyd9ps3FHZ8dAPDdkgZe1SI7Ppx8P9y8
         V16OVWzjfdU/uiykiiTqG2w72t7Z6IErAUkafXKpix1ndVH4UqFEbGMJ9MXSmUVeyeb7
         mrfj2HR8pDlblN4Tlrv4EgScojeprUdgJsBwLrm80ThK2+2UhvaIWIv2xtDlD0fxns5q
         /oy3TWCyTnzAqPMdCP83VZk8n3/ZXzrqs+I9uC/Gu/S7P5cVY7RRj0z7z22bk3pBJKss
         O9zaNT/6LDcFKQQ6kEGKjTf0/DcbqixQs/L5Y9gc/qPUxqgHx/4QRd+jr4hl9+bPfxpC
         S2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXHfZExUDGUx46Ytt/RUiMJE1242AszukACgDg0zTt+qL3G9wnGCsu0ydFBmMiu5zy3sqkqC28VLdfOwptQBSmb8wGKLRQwItV+JXKnwQ==
X-Gm-Message-State: AOJu0YxST3mLp/2SevFhfPqZp37RJKoSqwJnvLFCivOnfXUMTLHX/vmI
	EUsHOBeb6Xlt5A6MlPXcvfNIFZG26bNenjJ1rpVZ/hFzQR17lIPwya8bew1Th2s=
X-Google-Smtp-Source: AGHT+IHDGcsXV9BowhgEkzRV8IViMd8b0kzojmy2zxD9zUc2ioY5avjUdu6Qi9xyrE13MyeYrVTjHw==
X-Received: by 2002:a17:907:3f1a:b0:a77:f5fc:cb61 with SMTP id a640c23a62f3a-a7a0eb8cb2emr283950266b.0.1721290222664;
        Thu, 18 Jul 2024 01:10:22 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7eeasm528664666b.71.2024.07.18.01.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:10:21 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:10:21 +0200
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
Message-ID: <ZpjN7YgIDmjO88gm@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
 <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka>
 <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
 <ZpjNuWpzH9NC5ni6@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpjNuWpzH9NC5ni6@tiehlicka>

On Thu 18-07-24 10:09:31, Michal Hocko wrote:
> On Thu 18-07-24 17:27:05, Qu Wenruo wrote:
> > 
> > 
> > 在 2024/7/18 16:55, Michal Hocko 写道:
> > > On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
> > > > On 7/18/24 12:38 AM, Qu Wenruo wrote:
> > > [...]
> > > > > Does the folio order has anything related to the problem or just a
> > > > > higher order makes it more possible?
> > > > 
> > > > I didn't spot anything in the memcg charge path that would depend on the
> > > > order directly, hm. Also what kernel version was showing these soft lockups?
> > > 
> > > Correct. Order just defines the number of charges to be reclaimed.
> > > Unlike the page allocator path we do not have any specific requirements
> > > on the memory to be released.
> > 
> > So I guess the higher folio order just brings more pressure to trigger the
> > problem?
> 
> It increases the reclaim target (in number of pages to reclaim). That
> might contribute but we are cond_resched-ing in shrink_node_memcgs and
> also down the path in shrink_lruvec etc. So higher target shouldn't
> cause soft lockups unless we have a bug there - e.g. not triggering any
> of those paths with empty LRUs and looping somewhere. Not sure about
> MGLRU state of things TBH.
>  
> > > > > And finally, even without the hang problem, does it make any sense to
> > > > > skip all the possible memcg charge completely, either to reduce latency
> > > > > or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> > > 
> > > Let me just add to the pile of questions. Who does own this memory?
> > 
> > A special inode inside btrfs, we call it btree_inode, which is not
> > accessible out of the btrfs module, and its lifespan is the same as the
> > mounted btrfs filesystem.
> 
> But the memory charge is attributed to the caller unless you tell
> otherwise. So if this is really an internal use and you use a shared
> infrastructure which expects the current task to be owner of the charged
> memory then you need to wrap the initialization into set_active_memcg
> scope.

hit send too quickly, meant to finish with
... and use root cgroup.
-- 
Michal Hocko
SUSE Labs

