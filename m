Return-Path: <linux-fsdevel+bounces-17995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B773D8B495C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1C2825B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 03:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654C28F1;
	Sun, 28 Apr 2024 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJ7UqIrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735915A4;
	Sun, 28 Apr 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714274603; cv=none; b=srOHzBYd0HPHDlR9uBWnuQWOslCkym8A3TaAKRp0XRXG2NP9ZyzHEM1jYlthw5ci5NGVlfVs6Y4JC8RP81tdvsoRNl18pM65gn5R1Nx7HDob1FeI9ytqJ0WW93lVqAb5xTAT08MoLhiljFFxzXtBm4PyU22vZpbVqWGqGNs7tnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714274603; c=relaxed/simple;
	bh=3VdbSUjP3eJlri/gGS+1w5VBWjDH3Cbj6PZzvQnzlBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QmOOC6ZMbc1flEPZyh3iHnFbf+2kUej5xITWarBY04JLmA8PJBMQN3DGGePeiB+SG5MiQjym4GIEaqpWsnTbMPqJAPf7T7Ldw2iRh8dwU8Sn5tq6W88n9qNYwA6kAwhT9VSI7+8a6G+fW1GguYONor8fgpYEPPD7kMVbWpdgw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJ7UqIrI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714274603; x=1745810603;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=3VdbSUjP3eJlri/gGS+1w5VBWjDH3Cbj6PZzvQnzlBY=;
  b=KJ7UqIrIn48mTuT0MhAQYiGPfAl8i89TBGyPSphDJ0yoW/USCQ29Vn2l
   gj2JhvHtkfPEbUi1sijWpJ+JwHbs+DREibA7bnHDNBR/DIdTpZ6qkrnAl
   XS7Eha4F7k22+aC2RU5TAr/7UFkJIit6DSQCFofQqpK0CfZdlc6YrtV6g
   SCQTwXxYwVN3qkoGxUK/9XPpOTMyJVJg4C4kSUcxkbfrxvgqsDXem92jI
   GmoHCtuj4cnfwbmclZJefJfdbs2WzyKrfuDY6St3sIJFa06Xu9Y1bBwlK
   W5wnSzBCzzfO8C2OP+HxL7oAFazQBNI9pGofWfHUSHBTw0VuABLp34yCM
   w==;
X-CSE-ConnectionGUID: G+JSJnJ7TpqgJdfN/hG48Q==
X-CSE-MsgGUID: PMbicFgZTtqjJ7iCFNEUsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20522215"
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="20522215"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 20:23:22 -0700
X-CSE-ConnectionGUID: yBivDVFrS8q2dgPD5A/8Aw==
X-CSE-MsgGUID: nJUD/d7bQsGwEcvEC2dXUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="26413851"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 20:23:17 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,  Kairui Song <ryncsn@gmail.com>,
  linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
In-Reply-To: <CANeU7QknjZrRXH71Uejs1BCKHsmFe5X=neK7D1d1fyos0sAb9Q@mail.gmail.com>
	(Chris Li's message of "Sat, 27 Apr 2024 19:43:20 -0700")
References: <20240417160842.76665-1-ryncsn@gmail.com>
	<87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zico_U_i5ZQu9a1N@casper.infradead.org>
	<87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com>
	<87bk5uqoem.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CANeU7QknjZrRXH71Uejs1BCKHsmFe5X=neK7D1d1fyos0sAb9Q@mail.gmail.com>
Date: Sun, 28 Apr 2024 11:21:25 +0800
Message-ID: <871q6qqiiy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> On Sat, Apr 27, 2024 at 6:16=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > Hi Ying,
>> >
>> > For the swap file usage, I have been considering an idea to remove the
>> > index part of the xarray from swap cache. Swap cache is different from
>> > file cache in a few aspects.
>> > For one if we want to have a folio equivalent of "large swap entry".
>> > Then the natural alignment of those swap offset on does not make
>> > sense. Ideally we should be able to write the folio to un-aligned swap
>> > file locations.
>> >
>> > The other aspect for swap files is that, we already have different
>> > data structures organized around swap offset, swap_map and
>> > swap_cgroup. If we group the swap related data structure together. We
>> > can add a pointer to a union of folio or a shadow swap entry.
>>
>> The shadow swap entry may be freed.  So we need to prepare for that.
>
> Free the shadow swap entry will just set the pointer to NULL.
> Are you concerned that the memory allocated for the pointer is not
> free to the system after the shadow swap entry is free?
>
> It will be subject to fragmentation on the free swap entry.
> In that regard, xarray is also subject to fragmentation. It will not
> free the internal node if the node has one xa_index not freed. Even if
> the xarray node is freed to slab, at slab level there is fragmentation
> as well, the backing page might not free to the system.

Sorry my words were confusing.  What I wanted to say is that the xarray
node may be freed.

>> And, in current design, only swap_map[] is allocated if the swap space
>> isn't used.  That needs to be considered too.
>
> I am aware of that. I want to make the swap_map[] not static allocated
> any more either.

Yes.  That's possible.

> The swap_map static allocation forces the rest of the swap data
> structure to have other means to sparsely allocate their data
> structure, repeating the fragmentation elsewhere, in different
> ways.That is also the one major source of the pain point hacking on
> the swap code. The data structure is spread into too many different
> places.

Look forward to more details to compare :-)

>> > We can use atomic updates on the swap struct member or breakdown the
>> > access lock by ranges just like swap cluster does.
>>
>> The swap code uses xarray in a simple way.  That gives us opportunity to
>> optimize.  For example, it makes it easy to use multiple xarray
>
> The fixed swap offset range makes it like an array. There are many
> ways to shard the array like swap entry, e.g. swap cluster is one way
> to shard it. Multiple xarray is another way. We can also do multiple
> xarray like sharding, or even more fancy ones.

--
Best Regards,
Huang, Ying

