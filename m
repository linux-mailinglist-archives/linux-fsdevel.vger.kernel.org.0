Return-Path: <linux-fsdevel+bounces-32841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E99AF6E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F73AB216DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E382AF00;
	Fri, 25 Oct 2024 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hGD7323b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2545AD21
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820315; cv=none; b=SfDq4kHzHrU7Hi6+c/CDYeHabT85YE31zLUIbS95irbFN25jAHQuG3f1fEVTsyYjldZPnojoJ3IqPvmVNCCDZjEE3gm3UTJjHRRA2TOZ9aDZCC98izEThLll2b9F2dDiA12YKPKTlXaquS+8IzIn7ehvwGAra66arlPnvtpk9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820315; c=relaxed/simple;
	bh=Ol4W+VQi908uTrMVTUusvfFcBLtq9fOYdJQtG73KPTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZzP1f6vU5S6i49+a8Ex6XyHUuF5h/wnazF+rF7KERxRRDkZq3e8XdXCI9j0OIMOCl1rKC439wmRU2Diz4ACZYCr/UYPYwXBrrQDQ8JDAo3eKvsBdN8BBSx387MbMuRbQLDVlKzRI6JJdia6bvu1MPqKoevWiwWpdrOubplVOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hGD7323b; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729820307; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3fjz4BfrC3wykJsJfwFrwxl/YAJeU7MAIcR+vHCE4mA=;
	b=hGD7323b5kReb8rK1NXosOH0IM925IAeN4tE/sAXJKRuTam3VMEKWgp8qKDydXB6txrBgv46owHENVuTMf6Q+uE7aFhlWQbrdteuiw24Mz/H5Z3z9uPDYtLuVv/4boBCoHKg+SvRqQKMmAg5XxY6SnD6nJwthvGRqt4WoZWOSys=
Received: from 30.221.145.1(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WHqdu5c_1729820305 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 09:38:26 +0800
Message-ID: <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
Date: Fri, 25 Oct 2024 09:38:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, hannes@cmpxchg.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/25/24 12:54 AM, Joanne Koong wrote:
> On Mon, Oct 21, 2024 at 2:05 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Mon, Oct 21, 2024 at 3:15 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>
>>> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>
>>>> I feel like this is too much restrictive and I am still not sure why
>>>> blocking on fuse folios served by non-privileges fuse server is worse
>>>> than blocking on folios served from the network.
>>>
>>> Might be.  But historically fuse had this behavior and I'd be very
>>> reluctant to change that unconditionally.
>>>
>>> With a systemwide maximal timeout for fuse requests it might make
>>> sense to allow sync(2), etc. to wait for fuse writeback.
>>>
>>> Without a timeout allowing fuse servers to block sync(2) indefinitely
>>> seems rather risky.
>>
>> Could we skip waiting on writeback in sync(2) if it's a fuse folio?
>> That seems in line with the sync(2) documentation Jingbo referenced
>> earlier where it states "The writing, although scheduled, is not
>> necessarily complete upon return from sync()."
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html
>>
> 
> So I think the answer to this is "no" for Linux. What the Linux man
> page for sync(2) says:
> 
> "According to the standard specification (e.g., POSIX.1-2001), sync()
> schedules the writes, but may return before the actual writing is
> done.  However Linux waits for I/O completions, and thus sync() or
> syncfs() provide the same guarantees as fsync() called on every file
> in the system or filesystem respectively." [1]

Actually as for FUSE, IIUC the writeback is not guaranteed to be
completed when sync(2) returns since the temp page mechanism.  When
sync(2) returns, PG_writeback is indeed cleared for all original pages
(in the address_space), while the real writeback work (initiated from
temp page) may be still in progress.

I think this is also what Miklos means in:
https://lore.kernel.org/all/CAJfpegsJKD4YT5R5qfXXE=hyqKvhpTRbD4m1wsYNbGB6k4rC2A@mail.gmail.com/

Though we need special handling for AS_NO_WRITEBACK_RECLAIM marked pages
in sync(2) codepath similar to what we have done for the direct reclaim
in patch 1.


> 
> Regardless of the compaction / page migration issue then, this
> blocking sync(2) is a dealbreaker.

I really should have figureg out the compaction / page migration
mechanism and the potential impact to FUSE when we dropping the temp
page.  Just too busy to take some time on this though.....


-- 
Thanks,
Jingbo

