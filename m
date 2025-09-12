Return-Path: <linux-fsdevel+bounces-61150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5054AB55A63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2821CC532C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF1D296BC5;
	Fri, 12 Sep 2025 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j1hOEH6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B017283FEB;
	Fri, 12 Sep 2025 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720159; cv=none; b=VqqAF0QtPAJjzeBN2RDJzgmbcuCOXktVsgnMKzAj2uacAISO9h0apllHE00OO/QOeuNO7BzPSp9KlMjYieFX2hxf0Z/qAD/+7OCBHRv4US/fRpczYPGNHl+ZqVsA7SbI0Wt7A7iQnSErvfnEYN17Poi03KHNBk5q5xGE289dY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720159; c=relaxed/simple;
	bh=0bIBfPWuw5ZM1DgXMXybxVA8D6G9EUTJlY7Lrt4adWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rzk/t/nJSSI5kj7yvttflMsh0Yf5Dea8sg0R8PnB8mAL29ShbXETlBMRIqz76SHGDBbA3VLERIFW+s2fWE3lrc8cw56XcjuYGNfIyejiliGTQrAX+yi3a2H3olAIl2bHVX2zp2bZLqgJjGG3rsOx06iX30nKTPq9NYdffyinrZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j1hOEH6s; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757720148; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BGcA9S5haR9shxP4e1Rj9BiCfMYulsAHb54maNa9apg=;
	b=j1hOEH6sLugNry5YQdlhte12Xy3NsOtNlS629Zja3oW8gd+VdW1eE5prU/9lBCvOfjWUvCIwNvavX01qrOLP3y4z8+dGZvCzzlCR3hx/yddAnnBGzUDwolwfW4eS4FqmjtYZAuOWDQnu/n1mwvoNHPqPCyYlHvbKmVVbECKWPfk=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wns4Zin_1757720146 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 07:35:47 +0800
Message-ID: <9dc446dd-9a7d-4bd0-8f95-a6121a773cfb@linux.alibaba.com>
Date: Sat, 13 Sep 2025 07:35:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, linux-block@vger.kernel.org,
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com>
 <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
 <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
 <0b33ab17-2fc0-438f-95aa-56a1d20edb38@linux.alibaba.com>
 <aMK0lC5iwM0GWKHq@infradead.org>
 <9c104881-f09e-4594-9e41-0b6f75a5308c@linux.alibaba.com>
 <CAJnrk1b2_XGfMuK-UAej31TtCAAg5Aq8PFS_36yyGg8NerA97g@mail.gmail.com>
 <6609e444-5210-42aa-b655-8ed8309aae75@linux.alibaba.com>
 <66971d07-2c1a-4632-bc9e-e0fc0ae2bd04@linux.alibaba.com>
 <267abd34-2337-4ae3-ae95-5126e9f9b51c@linux.alibaba.com>
 <CAJnrk1Y31b-Yr03rN8SXPmUA7D6HW8OhnkfFOebn56z57egDOw@mail.gmail.com>
 <CAJnrk1ZXM-fRKytRFptKNJrdN9pSbKJqXLW80T4UY=RLRKOBKQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1ZXM-fRKytRFptKNJrdN9pSbKJqXLW80T4UY=RLRKOBKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/13 04:09, Joanne Koong wrote:
> On Fri, Sep 12, 2025 at 3:56 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>

...

>>>>> but I don't see it will happen.
>>>>>
>>>>> [1] https://lore.kernel.org/linux-fsdevel/YfivxC9S52FlyKoL@B-P7TQMD6M-0146/
> 
> (sorry, just saw this part of the email otherwise I would have
> included this in the previous message)
> 
> Thanks for the link to the thread. My understanding is that the large
> folio optimizations stuff was added to iomap in July 2023 (afaict from
> the git history) and iomap is entangled with the block layer but it's
> becoming more of a generic interface now. Maybe now it makes sense to
> go through iomap's interface than it did in 2022, but of course David
> has the most context on this.

Again, I really think iomap callback model is not good stuff especially
as it becomes a more generic thing, and it seems inflexible compared
with other interfaces like the page cache (it also has callbacks
but many of them are just a few entrances of IO flows) or bio kAPIs.

As in the previous example, network filesystems generally don't need
any L2P logic (in principle, FUSE is more like a network filesystem),
but they still have to implement those iomap dummy callbacks and
ignore `iomap->addr`.


As for per-block dirty/uptodate tracking, that is just an atomic
feature to manage sub-folio metadata, but iomap is initially a part
which is out of XFS, and basically standard flows for disk/pmem fses.
I really think better generic interfaces are like lego bricks instead,
therefore filesystems can optionally use any of those atomic features
instead of just calling in iomap {read,write,writeback} maze-like
helpers and do different work in the callback hooks (even not all
filesystems need this).

I've mentioned too in
https://lore.kernel.org/r/d631c71f-9d0d-405f-862d-b881767b1945@linux.alibaba.com
https://lore.kernel.org/r/20250905152118.GE1587915@frogsfrogsfrogs

Thanks,
Gao Xiang



> 
> 
> Thanks,
> Joanne
> 
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>>
>>>


