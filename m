Return-Path: <linux-fsdevel+bounces-17448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886388ADB87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FCE1F22C37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497412E6D;
	Tue, 23 Apr 2024 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T98ywX0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0EAF9D4;
	Tue, 23 Apr 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835862; cv=none; b=DXq/8Jkl7ESNzUip2t4yac6AuO16iNguQ1F7Axos0aS2OCVVoG8QK1umcO0jhQc+cBjNYkmpdFNRTYwm2MTimuBj61gN8PppzrxVfRb43S5vrgJbr6zTSrKnP+I69wmlVqWxNjsa3HRp6qyZqjKClaatO2X6BqXp39wgTOIGcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835862; c=relaxed/simple;
	bh=TGwgxLWlj6TWD43M93E40JEa1uNcDOPHLH01f/Mh3eY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQngMst8Y3ZbnZhlNqiakwDRDbiTLuOqcUUawz/GXQhdFo5yyT9HspfwrxLdDn1I7QZ03sL9EyI+nMatxAsR1a8TZ0PVurU6chP/41+269rKmKR8pQLxQNdocVzEjLnNeYtLdnskl3inyQI56qPRqhnicprpj+ZkL7AvTxFfwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T98ywX0z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713835860; x=1745371860;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=TGwgxLWlj6TWD43M93E40JEa1uNcDOPHLH01f/Mh3eY=;
  b=T98ywX0zAUXUt8mYCKlCetoS/oApql5GeKqVSiavCrfZqnsw52lfUTDc
   yp6VnJMUMQWIt6tb7Wed6e6ORlPPGVhs/fu7WyWkgkfJdIkM5Xi74YkAv
   LDNvppIveUcaXkDcwByUtI/wLwjcIlFCecAMwi1/zNNNY2Wt7VUSVXVhS
   aTJHiTIog4laTe+ns+kQq+lRCeP3PuO/WWiccTRa2BOARPUYYP2jeHY/5
   YlGUSDc9tVmhU/pCrdKl07hiKnNTvtT8YSm8BHODFtUclbR4A4Ns+mIHf
   RUPW5iaLr2TAj/dPkWMPG0j91r7oSx3rg37JmHmisXQbnfbAchEIgZc9A
   w==;
X-CSE-ConnectionGUID: S0n2GrWwQLiO+00vAjzLyA==
X-CSE-MsgGUID: Lf9O4wrjQaW0xlg2tA6IjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9319527"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9319527"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 18:30:59 -0700
X-CSE-ConnectionGUID: 7juPBe2xRCerbJCnut7GNw==
X-CSE-MsgGUID: T4bvjcGaQv+nbkC1V8Txqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55143078"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 18:30:56 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,  linux-mm@kvack.org,  Andrew
 Morton <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Barry
 Song <v-songbaohua@oppo.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Neil
 Brown <neilb@suse.de>,  Minchan Kim <minchan@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  David Hildenbrand <david@redhat.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
In-Reply-To: <CAMgjq7B1YTrvZOrnbtVYfVMVAmtMkkwiqcqc1AGup4=gvgxKhQ@mail.gmail.com>
	(Kairui Song's message of "Mon, 22 Apr 2024 23:20:19 +0800")
References: <20240417160842.76665-1-ryncsn@gmail.com>
	<87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7B1YTrvZOrnbtVYfVMVAmtMkkwiqcqc1AGup4=gvgxKhQ@mail.gmail.com>
Date: Tue, 23 Apr 2024 09:29:03 +0800
Message-ID: <87r0ewx3xc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Mon, Apr 22, 2024 at 3:56=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Hi, Kairui,
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > Currently we use one swap_address_space for every 64M chunk to reduce =
lock
>> > contention, this is like having a set of smaller swap files inside one
>> > big swap file. But when doing swap cache look up or insert, we are
>> > still using the offset of the whole large swap file. This is OK for
>> > correctness, as the offset (key) is unique.
>> >
>> > But Xarray is specially optimized for small indexes, it creates the
>> > redix tree levels lazily to be just enough to fit the largest key
>> > stored in one Xarray. So we are wasting tree nodes unnecessarily.
>> >
>> > For 64M chunk it should only take at most 3 level to contain everythin=
g.
>> > But we are using the offset from the whole swap file, so the offset (k=
ey)
>> > value will be way beyond 64M, and so will the tree level.
>> >
>> > Optimize this by reduce the swap cache search space into 64M scope.
>>
>
> Hi,
>
> Thanks for the comments!
>
>> In general, I think that it makes sense to reduce the depth of the
>> xarray.
>>
>> One concern is that IIUC we make swap cache behaves like file cache if
>> possible.  And your change makes swap cache and file cache diverge more.
>> Is it possible for us to keep them similar?
>
> So far in this series, I think there is no problem for that, the two
> main helpers for retrieving file & cache offset: folio_index and
> folio_file_pos will work fine and be compatible with current users.
>
> And if we convert to share filemap_* functions for swap cache / page
> cache, they are mostly already accepting index as an argument so no
> trouble at all.
>
>>
>> For example,
>>
>> Is it possible to return the offset inside 64M range in
>> __page_file_index() (maybe rename it)?
>
> Not sure what you mean by this, __page_file_index will be gone as we
> convert to folio.
> And this series did delete / rename it (it might not be easy to see
> this, the usage of these helpers is not very well organized before
> this series so some clean up is involved).
> It was previously only used through page_index (deleted) /
> folio_index, and, now folio_index will be returning the offset inside
> the 64M range.
>
> I guess I just did what you wanted? :)

Good!

> My cover letter and commit message might be not clear enough, I can updat=
e it.
>
>>
>> Is it possible to add "start_offset" support in xarray, so "index"
>> will subtract "start_offset" before looking up / inserting?
>
> xarray struct seems already very full, and this usage doesn't look
> generic to me, might be better to fix this kind of issue case by case.

Just some open question.

>>
>> Is it possible to use multiple range locks to protect one xarray to
>> improve the lock scalability?  This is why we have multiple "struct
>> address_space" for one swap device.  And, we may have same lock
>> contention issue for large files too.
>
> Good question, this series can improve the tree depth issue for swap
> cache, but contention in address space is still a thing.

The lock contention for swap cache has been reduced via using multiple
xarray in commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB
trunks").  But it fixes that for swap cache only, not for file cache in
general.  We have observed similar lock contention issue for file cache
too.  And the method isn't perfect too, like the issue you found here.
In general, it's about what is "file" for swap device.

> A more generic solution might involve changes of xarray API or use
> some other data struct?
>
> (BTW I think reducing the search space and resolving lock contention
> is not necessarily related, reducing the search space by having a
> large table of small trees should still perform better for swap
> cache).

--
Best Regards,
Huang, Ying

