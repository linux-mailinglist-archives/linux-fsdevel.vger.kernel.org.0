Return-Path: <linux-fsdevel+bounces-60478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32738B48491
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 08:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA383B96F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874162E2DFB;
	Mon,  8 Sep 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O+4tICuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9715ADB4;
	Mon,  8 Sep 2025 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314597; cv=none; b=TndO+gvFbcc7n0t9dXcqYtqzzjyuxCoP+a19Nsl8GdrraUCIbNAb13CqR9xEKTaHJe3ueBYzmveP9ol5/H6QKKi/89aXRhpGWAhmErl01LMx8SY53EK2X3ir/4IDpeGryksHTezJ9IepeFHt4iaSBsNJoYyGdriWTAR6C8CABLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314597; c=relaxed/simple;
	bh=IHHgWpB7XcU7hYXbGGKm76CMAvv1L16rOpYVAS1UiRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCeoJD7XjBHUumjZNhrmjIZGrj+qmWU6jzpsMFRTcVtBg0VOyGr9mt8hg6Vo6S9TA2JHKEoKTHXjaqgFOzEQEZR+MnWn4qz55SXv2hTyvD9UGxwf9vBKqszK++7A+3SHL0P+7bicoPwML69zwcx4S93OfLNTBTitjM7xuaI4X8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O+4tICuy; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757314584; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qRfhMOU1jwt6QQs/bLEA+T15CSW+jtTj6s7+A3xD1P0=;
	b=O+4tICuyc4u09eQyXJ7YSCdiessZnqfiqoqyj9BLk+agre+muiGU0UXBwW+/ezIZLAw108CUSix/fTrudajUJDVpOPSzegyvTtwsmZRgp2RhGWqAb2T7+ZbG7Zf4boDokHl4Y/ywo/3bJdw/9+b2UDzMGcsPLeO/uR6KjUI6lkI=
Received: from 30.221.130.235(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnT.E8Y_1757314582 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 14:56:23 +0800
Message-ID: <2c51b7dd-4eb8-4af3-b554-1044fa493388@linux.alibaba.com>
Date: Mon, 8 Sep 2025 14:56:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/16] iomap: add a private arg for read and readahead
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
 miklos@szeredi.hu, hch@infradead.org, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com, linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-14-joannelkoong@gmail.com> <aLJZv5L6q0FH5F8a@debian>
 <CAJnrk1af4-FG==X=4LzoBRaxL9N-hnh1i-zx89immQZMLKSzyQ@mail.gmail.com>
 <a44fd64d-e0b1-4131-9d71-2d36151c90f4@linux.alibaba.com>
 <CAJnrk1bBmA+VK6UK1n6DRnuLvX8UOMp-VgQGnn2rUrq0=mCyqA@mail.gmail.com>
 <d631c71f-9d0d-405f-862d-b881767b1945@linux.alibaba.com>
 <20250905152118.GE1587915@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250905152118.GE1587915@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/5 23:21, Darrick J. Wong wrote:
> On Fri, Sep 05, 2025 at 10:21:19AM +0800, Gao Xiang wrote:
>>
>>
>> On 2025/9/5 07:29, Joanne Koong wrote:
>>> On Tue, Sep 2, 2025 at 6:55 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>
>>
>> ...
>>
>>
>>>>>>
>>>>>>>     int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
>>>>>>> -             const struct iomap_read_ops *read_ops)
>>>>>>> +             const struct iomap_read_ops *read_ops, void *private)
>>>>>>>     {
>>>>>>>          struct iomap_iter iter = {
>>>>>>>                  .inode          = folio->mapping->host,
>>>>>>>                  .pos            = folio_pos(folio),
>>>>>>>                  .len            = folio_size(folio),
>>>>>>> +             .private        = private,
>>>>>>>          };
>>>>>>
>>>>>> Will this whole work be landed for v6.18?
>>>>>>
>>>>>> If not, may I ask if this patch can be shifted advance in this
>>>>>> patchset for applying separately (I tried but no luck).
>>>>>>
>>>>>> Because I also need some similar approach for EROFS iomap page
>>>>>> cache sharing feature since EROFS uncompressed I/Os go through
>>>>>> iomap and extra information needs a proper way to pass down to
>>>>>> iomap_{begin,end} with extra pointer `.private` too.
>>>>>
>>>>> Hi Gao,
>>>>>
>>>>> I'm not sure whether this will be landed for v6.18 but I'm happy to
>>>>> shift this patch to the beginning of the patchset for applying
>>>>> separately.
>>>>
>>>> Yeah, thanks.  At least this common patch can be potentially applied
>>>> easily (e.g. form a common commit id for both features if really
>>>> needed) since other iomap/FUSE patches are not dependency of our new
>>>> feature and shouldn't be coupled with our development branch later.
>>>>
>>>
>>> Hi Gao,
>>>
>>> I'll be dropping this patch in v2 since all the iomap read stuff is
>>> going to go through a struct ctx arg instead of through iter->private.
>>> Sorry this won't help your use case, but looking forward to seeing your patches.
>>
>> Hi Joanne,
>>
>> Thanks for your reminder.  Okay, I will check your v2 to know how
>> you change then.
>>
>> Also, one thing I really think it's helpful for our use cases is
>> converting .iomap_begin() at least to pass struct iomap_iter *
>> directly rather than (inode, pos, len, flags, iomap, srcmap)
>> since:
>>    - .iomap_{begin,end}() are introduced before iomap_iter()
>>      and struct iomap_iter but those callbacks are basically
>>      now passed down some fields of `struct iomap_iter` now;
>>
>>    - struct iomap_iter->private then can contain a per-request
>>      context so that .iomap_begin() can leverage too;
>>
>>    - There are already too many arguments for .iomap_begin(),
>>      pass down struct iomap_iter directly could avoid adding
>>      another `private` argument to .iomap_begin()..
>>
>> Therefore, I do wonder if this change (.iomap_begin() passes
>> struct iomap_iter *) is a good idea for the iomap folks, in
>> addition that filesystems can specify `struct iomap_iter->private`
>> as in this patch.  Since this change is necessary to make our
>> page cache sharing feature efficient, I will continue working on
>> this soon.
> 
>  From a source code perspective, I like the idea of cleaning up the
> function signature to pass fewer things to ->iomap_begin.  I suspect
> that we could simplify it to:
> 
> 	int (*iomap_begin)(const struct iomap_iter *iter,
> 			   struct iomap *iomap,
> 			   struct iomap *srcmap);

Hi Darrick,

Thanks for your reply and sorry for my late reply due to another
internal stuff.

It sounds better to me since `const` annonation may have some more
aggressive compiler optimization.

> 
> That way we preserve the notion that the ->iomap_begin functions aren't
> allowed to change the iterator contents except for the two iomaps.
> 
> That said, the nice thing about passing so many parameters is that it
> probably leads to less pointer chasing in the implementation functions.
> I wonder if that makes any difference because extent mapping lookups
> likely involve a lot more pointer chasing anyway.  Another benefit is
> that since the parameters aren't const, each implementation can (re)use
> those variables if they need to.

Ok, but I'm not sure, in principle, even without `const` annotation,
users can make local variables in their callbacks to avoid extra pointer
chasing.

But anyway, that is not what's my own original intention: we need
another `->private` ctx to pass among all-iomap_begin() because it
holds extra information, I think passing in `const struct iomap_iter *`
is cleaner than adding a new argument.

I will post this after the whole new feature work is finished.

> 
> I think you could simplify iomap_end too:
> 
> 	int (*iomap_end)(const struct iomap_iter *iter,
> 			 loff_t pos, u64 length,
> 			 size_t written);
> 
> and make ->iomap_end implementations extract iter->flags and iter->iomap
> themselves if they want to.  I don't like how xfs_iomap.c abuses
> container_of to extract the iter from the iomap pointer.

Yeah, make sense.

> 
> (But not enough to have written patches fixing any of this. :P)
> 
>> Another thing I want to discuss (but it's less important for our
>> recent features) is the whole callback hook model of iomap.
>>
>> Basically the current model does mean if any filesystem doesn't
>> fulfill the iomap standard flow, it has to add some customized
>> callback hook somewhere to modify the code flow then (or introduce
>> a new special flag and move their specific logic into iomap/
>> itself even other fses may not need this), but the hook way will
>> cause increased indirect calls for them, currently we have
>> `struct iomap_ops`, `struct iomap_writeback_ops` and
>> `struct iomap_dio_ops`, if some another filesystem (when converting
>> buffer I/Os for example or adding {pre,post}-processing ) have
>> specified timing, it needs to add new hooks then.
>>
>> I do wonder if it's possible to convert iomap to get rid of the
>> indirect-call model by just providing helper kAPIs instead,
>> take .read_folio / .fiemap for example e.g.
>>
>>     xxxfs_read_folio:
>>        loop iomap_iter
>>          xxxfs_iomap_begin();
>> 	iomap_readpage_bio_advance(); [ or if a fs is non-bio
>>               based, spliting more low-level helpers for them. ]
>>          xxxfs_iomap_end();
>>
>>     xxxfs_fiemap():
>>        iomap_fiemap_begin
>>        loop iomap_iter
>>          xxxfs_iomap_begin();
>>          iomap_readpage_fiemap_advance()
>>          xxxfs_iomap_end();
>>        iomap_fiemap_end
>> So that each fs can use those helpers flexibly instead of diging
>> into adding various new indirect call hooks or moving customized
>> logic into iomap/ itself.
> 
> Yes, it's quite possible to push the iomap iteration control down into
> the filesystems to avoid the indirect calls.  That might make things
> faster, though I have no idea what sort of performance impact that will
> have.

It's not from the performance impact perspective, but for the
flexibility.  Adding new hooks everywhere doesn't smell good
at least on my side (because iomap tends to cover the whole I/O
lifetime, which is by design different from page cache callbacks
for example).

> 
>> I don't have a specific example  because currently we don't have
>> direct issue against standard iomap flow on our uncompressed
>> path, but after a quick glance of other potential users who try
>> to convert their buffer I/Os to iomap, I had such impression in
>> my head for a while.
> 
> OTOH making it easier for non-disk filesystems to use iomap but supply
> their own IO mechanism (transformed bios, memcpy, etc) makes a far more
> compelling argument for doing this painful(?) treewide change IMO.

Yeah, I can see it's rather a painful treewide change, but if more
hooks are added, it will be more painful than now.

Anyway, it's just my random thought but it doesn't have real impact
to our work and much less important to me.

Thanks,
Gao Xiang

> 
> --D
> 
>> Thanks,
>> Gao Xiang
>>
>>>
>>>
>>> Thanks,
>>> Joanne
>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>
>>>>> Thanks,
>>>>> Joanne
>>>>>>
>>>>>> Thanks,
>>>>>> Gao Xiang
>>>>
>>
>>


