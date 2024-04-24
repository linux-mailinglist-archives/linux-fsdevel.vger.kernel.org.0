Return-Path: <linux-fsdevel+bounces-17575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D278AFE5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 04:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9C7B2164F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 02:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A41864C;
	Wed, 24 Apr 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJTdQ02B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE317BA4;
	Wed, 24 Apr 2024 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925567; cv=none; b=YGx8nNViWIEws6DKwyb6NxlxvixhyW1AHcK+5GOWq10ztuwsZRsB6L1FxgmyWI1ewx/IuCfXi4xNS8VhipPFym6mp1iqK3XrZxB7YRwbmiKzbVmV79uWj0TNmNSyiZu6qaMNssaz8ubX3vzTM4Cp9Pc3IvO/CUlijSsCC84QmIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925567; c=relaxed/simple;
	bh=QmPQF7eOoPT8Nnn8OjXFg1nFy1plktJnigngENo2NvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+Rq1ZJDfmyBuHKY8n2fH2/BwP37V0WgeNAwXsjm4iOyhi+g5CmBoB7vraxAmW0+H4cVDGGTb4qxMM5baAoOgUFB2AyiG38K9T3t3o7fgNrO7xrSovYLksBKLdUpNcUsbBAfS5lRYpTwqxlaZB4cdu44sdGeDv+KD10hOHJVnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJTdQ02B; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713925566; x=1745461566;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QmPQF7eOoPT8Nnn8OjXFg1nFy1plktJnigngENo2NvY=;
  b=iJTdQ02BClkq/3jYAdGadz/iAFC+x7uQMNYEJ++TScZsBnfJy6bZDty3
   lNPuAprGWuAJh+3uVR7J99LFqYatiMKEE23G93SDOzLm+WKeQKJSIaIdo
   +ZAtQGrfaKSYh4UwHsKyLxWK67+u6YPODEIlKcDBbjUeNyiX9/0BOrt1a
   pL9wJiijynBeLl/iN4SwO+8OscogI3IIVEIsaXzplGliGFFtAips/JWN3
   LEY1hX4OpBn3tfdBvNxO4TMQ1PdpA9r4VwPzoCnTbJZ0qXwhsjtIMhbM3
   wER14jnA5t21rpd/QXV5S4rxcT8Z8IvNgBaNQ9ozYz7MYMzSq8Zd2FWyB
   Q==;
X-CSE-ConnectionGUID: Zl6dREobRzuc+FSyFQnjiw==
X-CSE-MsgGUID: gnP28RU1TSem0P88h0elNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27051300"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="27051300"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:25:58 -0700
X-CSE-ConnectionGUID: VvU8Xw05S0qwtinn4bSQ/g==
X-CSE-MsgGUID: XqJH75ReSsebrfkSkF2Hyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29039432"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:25:53 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kairui Song <ryncsn@gmail.com>,  linux-mm@kvack.org,  Kairui Song
 <kasong@tencent.com>,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
In-Reply-To: <Zico_U_i5ZQu9a1N@casper.infradead.org> (Matthew Wilcox's message
	of "Tue, 23 Apr 2024 04:20:29 +0100")
References: <20240417160842.76665-1-ryncsn@gmail.com>
	<87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zico_U_i5ZQu9a1N@casper.infradead.org>
Date: Wed, 24 Apr 2024 10:24:01 +0800
Message-ID: <87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Matthew,

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Apr 22, 2024 at 03:54:58PM +0800, Huang, Ying wrote:
>> Is it possible to add "start_offset" support in xarray, so "index"
>> will subtract "start_offset" before looking up / inserting?
>
> We kind of have that with XA_FLAGS_ZERO_BUSY which is used for
> XA_FLAGS_ALLOC1.  But that's just one bit for the entry at 0.  We could
> generalise it, but then we'd have to store that somewhere and there's
> no obvious good place to store it that wouldn't enlarge struct xarray,
> which I'd be reluctant to do.
>
>> Is it possible to use multiple range locks to protect one xarray to
>> improve the lock scalability?  This is why we have multiple "struct
>> address_space" for one swap device.  And, we may have same lock
>> contention issue for large files too.
>
> It's something I've considered.  The issue is search marks.  If we delete
> an entry, we may have to walk all the way up the xarray clearing bits as
> we go and I'd rather not grab a lock at each level.  There's a convenient
> 4 byte hole between nr_values and parent where we could put it.
>
> Oh, another issue is that we use i_pages.xa_lock to synchronise
> address_space.nrpages, so I'm not sure that a per-node lock will help.

Thanks for looking at this.

> But I'm conscious that there are workloads which show contention on
> xa_lock as their limiting factor, so I'm open to ideas to improve all
> these things.

I have no idea so far because my very limited knowledge about xarray.

--
Best Regards,
Huang, Ying

