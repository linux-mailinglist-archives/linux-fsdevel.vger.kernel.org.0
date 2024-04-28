Return-Path: <linux-fsdevel+bounces-17989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8398B4905
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 03:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092A11F21B10
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 01:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485EB10F1;
	Sun, 28 Apr 2024 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jl7vdDFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16764A;
	Sun, 28 Apr 2024 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714266983; cv=none; b=iQfW0iF8MfrHWcWNN80P681wEHjXL5+LWWG/7TYmDGLk9aAxsbpjOA6ByvVaI/O0FIbeGzjskSlcpI8CK+kGa+18j3p4BYOEjwpD+bMOFFZFk2ViY9MjfHg2iwtuXA6UTp7SBhWmFy0nnUezrB9KeKujL8tyh/PsNxgQ83soEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714266983; c=relaxed/simple;
	bh=T37KaSyUuWuW85l2ruCLx2uNwdP395EJMwHfBNBUsPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XkNA2QMV33KxhNoCO5I+kRgfs3H0oXuAl3hb0i5PaGUQGSQrhj+A54jSK4CWSdo4FiOxPyXrE9j/43KY3HTB/PqBm1bVWoN3toFx45LVs8F2c6dty82fjtLF3XZQ2UyUShCDyWTvRBYy9LE7pbQQI+yKGp7B8uF2LZPCrzWjj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jl7vdDFf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714266982; x=1745802982;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=T37KaSyUuWuW85l2ruCLx2uNwdP395EJMwHfBNBUsPg=;
  b=Jl7vdDFftVx5UTxyXB0KQMO3abyhF3/izh97yvVnUdKzDd1fJLnBi+Qv
   KJ6HpKL7mXAlIlc4HmT/kY+UtN634Wmgd0uhOW0qUlS1SErPcgh7aBNb/
   ASziOvFfj2d92nvAphHf9hoRukne5A8sq24fBwE3a+itLD3PLn0LPffla
   O1pBrw9WMu/7CtWZQH6Zky4TCdIRcNDI+GD6xnDQ/4wHN8w3Ak9xyr0Ws
   Mv+2qCHdS3Chk4u1yuLQQqSyhdVpLShViCxLVqsm7tZjQB9C1j4WEEXfJ
   z08mS/mO75BNeA8KP9bvpWsEpW3tsqvzoinG5VL4QYp+Q5qNQpfemISIO
   Q==;
X-CSE-ConnectionGUID: aBhIBntCT1us6HoyvG8wMQ==
X-CSE-MsgGUID: i2o3lF+9QlKhYeOC3eoy9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27419755"
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="27419755"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 18:16:22 -0700
X-CSE-ConnectionGUID: Z9PtG/FCQ3mjkxBgoTxZ/A==
X-CSE-MsgGUID: /usw1doHTVC2NDoUvemriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="30574669"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 18:16:17 -0700
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
In-Reply-To: <CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com>
	(Chris Li's message of "Fri, 26 Apr 2024 16:16:01 -0700")
References: <20240417160842.76665-1-ryncsn@gmail.com>
	<87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zico_U_i5ZQu9a1N@casper.infradead.org>
	<87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com>
Date: Sun, 28 Apr 2024 09:14:25 +0800
Message-ID: <87bk5uqoem.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> Hi Ying,
>
> On Tue, Apr 23, 2024 at 7:26=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Hi, Matthew,
>>
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>> > On Mon, Apr 22, 2024 at 03:54:58PM +0800, Huang, Ying wrote:
>> >> Is it possible to add "start_offset" support in xarray, so "index"
>> >> will subtract "start_offset" before looking up / inserting?
>> >
>> > We kind of have that with XA_FLAGS_ZERO_BUSY which is used for
>> > XA_FLAGS_ALLOC1.  But that's just one bit for the entry at 0.  We could
>> > generalise it, but then we'd have to store that somewhere and there's
>> > no obvious good place to store it that wouldn't enlarge struct xarray,
>> > which I'd be reluctant to do.
>> >
>> >> Is it possible to use multiple range locks to protect one xarray to
>> >> improve the lock scalability?  This is why we have multiple "struct
>> >> address_space" for one swap device.  And, we may have same lock
>> >> contention issue for large files too.
>> >
>> > It's something I've considered.  The issue is search marks.  If we del=
ete
>> > an entry, we may have to walk all the way up the xarray clearing bits =
as
>> > we go and I'd rather not grab a lock at each level.  There's a conveni=
ent
>> > 4 byte hole between nr_values and parent where we could put it.
>> >
>> > Oh, another issue is that we use i_pages.xa_lock to synchronise
>> > address_space.nrpages, so I'm not sure that a per-node lock will help.
>>
>> Thanks for looking at this.
>>
>> > But I'm conscious that there are workloads which show contention on
>> > xa_lock as their limiting factor, so I'm open to ideas to improve all
>> > these things.
>>
>> I have no idea so far because my very limited knowledge about xarray.
>
> For the swap file usage, I have been considering an idea to remove the
> index part of the xarray from swap cache. Swap cache is different from
> file cache in a few aspects.
> For one if we want to have a folio equivalent of "large swap entry".
> Then the natural alignment of those swap offset on does not make
> sense. Ideally we should be able to write the folio to un-aligned swap
> file locations.
>
> The other aspect for swap files is that, we already have different
> data structures organized around swap offset, swap_map and
> swap_cgroup. If we group the swap related data structure together. We
> can add a pointer to a union of folio or a shadow swap entry.

The shadow swap entry may be freed.  So we need to prepare for that.
And, in current design, only swap_map[] is allocated if the swap space
isn't used.  That needs to be considered too.

> We can use atomic updates on the swap struct member or breakdown the
> access lock by ranges just like swap cluster does.

The swap code uses xarray in a simple way.  That gives us opportunity to
optimize.  For example, it makes it easy to use multiple xarray
instances for one swap device.

> I want to discuss those ideas in the upcoming LSF/MM meet up as well.

Good!

--
Best Regards,
Huang, Ying

