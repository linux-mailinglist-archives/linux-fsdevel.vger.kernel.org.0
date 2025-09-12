Return-Path: <linux-fsdevel+bounces-60988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC8B53FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 03:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A269487539
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 01:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040CD74420;
	Fri, 12 Sep 2025 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tHPiMtqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E0381C4;
	Fri, 12 Sep 2025 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639467; cv=none; b=K77nuxEVKirX87aQ+94rLhKAuazGZio7p+dkI/LYrmzJRXt4RvJb3w/3VeKIL7TSQ3XsVrdksnYLczeDYvW5ylvozTtjiQ+OoLXQbMaahIzS4nal0EqbKiscZUlzxQTKJPujPdZDJ8s7kuuxUwe0sJNSecJ8cioaX9SBnpb7cIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639467; c=relaxed/simple;
	bh=vqPSzQgj6c/vcGJwIGjwfFlNQHUveO6QouzOa9uIMuU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PPhMr5grnduUlLInhu1QN5lgbcLCOiECaRMYFr9JklRKzw1sPZCJS7vDUeUtg0huY0/u3RunRbDwaaSiyV2RhMGchtZsT1Ji/Z3M10U8eMNabqmIdlOt66C4Se5G4AniNB8+P2a1QSEK6iffUK32gvyhPgWyaR4CoFEGVmboWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tHPiMtqG; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757639461; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=92OXjVgj5kXo0QHletDaCdXlq03ag7yLQDUAH9tWdAo=;
	b=tHPiMtqGxu0ObSi+aLybSaWQnGCUnEN+B3bCXewtsK8erbJwF4xdODTfXdlBa9uhVRn0hqcgM4YvyMCGkRs3PX5fq8KMP6qGkMMYijw9iy+w4vJKS9UTbvylBKjIWdMSDC+pvwWQE3umaSZsLwXYeE8NAFap6TW6e+R+IKsA+GE=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnoZ3GP_1757639460 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 09:11:01 +0800
Message-ID: <267abd34-2337-4ae3-ae95-5126e9f9b51c@linux.alibaba.com>
Date: Fri, 12 Sep 2025 09:10:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
 miklos@szeredi.hu, djwong@kernel.org, linux-block@vger.kernel.org,
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
In-Reply-To: <66971d07-2c1a-4632-bc9e-e0fc0ae2bd04@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/12 09:09, Gao Xiang wrote:
> 
> 
> On 2025/9/12 08:06, Gao Xiang wrote:
>>
>>
>> On 2025/9/12 03:45, Joanne Koong wrote:
>>> On Thu, Sep 11, 2025 at 8:29 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> ...
>>
>>>> ```
>>>>
>>>> But if FUSE or some other fs later needs to request L2P information
>>>> in their .iomap_begin() and need to send L2P requests to userspace
>>>> daemon to confirm where to get the physical data (maybe somewhat
>>>> like Darrick's work but I don't have extra time to dig into that
>>>> either) rather than just something totally bypass iomap-L2P logic
>>>> as above, then I'm not sure the current `iomap_iter->private` is
>>>> quite seperate to `struct iomap_read_folio_ctx->private`, it seems
>>>
>>> If in the future this case arises, the L2P mapping info is accessible
>>> by the read callback in the current design. `.read_folio_range()`
>>> passes the iomap iter to the filesystem and they can access
>>> iter->private to get the L2P mapping data they need.
>>
>> The question is what exposes to `iter->private` then, take
>> an example:
>>
>> ```
>> struct file *file;
>> ```
>>
>> your .read_folio_range() needs `file->private_data` to get
>> `struct fuse_file` so `file` is kept into
>> `struct iomap_read_folio_ctx`.
>>
>> If `file->private_data` will be used for `.iomap_begin()`
>> as well, what's your proposal then?
>>
>> Duplicate the same `file` pointer in both
>> `struct iomap_read_folio_ctx` and `iter->private` context?
> 
> It's just an not-so-appropriate example because
> `struct file *` and `struct fuse_file *` are widely used
> in the (buffer/direct) read/write flow but Darrick's work
> doesn't use `file` in .iomap_{begin/end}.
> 
> But you may find out `file` pointer is already used for
> both FUSE buffer write and your proposal, e.g.
> 
> buffer write:
>   /*
>    * Use iomap so that we can do granular uptodate reads
>    * and granular dirty tracking for large folios.
>    */
>   written = iomap_file_buffered_write(iocb, from,
>                                       &fuse_iomap_ops,
>                                       &fuse_iomap_write_ops,
>                                       file);

And your buffer write per-fs context seems just use
`iter->private` entirely instead to keep `file`.

> 
> 
> I just try to say if there is a case/feature which needs
> something previously in `struct iomap_read_folio_ctx` to
> be available in .iomap_{begin,end} too, you have to either:
>   - duplicate this in `iter->private` as well;
>   - move this to `iter->private` entirely.
> 
> The problem is that both `iter->private` and
> `struct iomap_read_folio_ctx` are filesystem-specific,
> I can only see there is no clear boundary to leave something
> in which one.  It seems just like an artificial choice.
> 
> Thanks,
> Gao Xiang
> 
>>
>>
>>>
>>>> both needs fs-specific extra contexts for the same I/O flow.
>>>>
>>>> I think the reason why `struct iomap_read_folio_ctx->private` is
>>>> introduced is basically previous iomap filesystems are all
>>>> bio-based, and they shares `bio` concept in common but
>>>> `iter->private` was not designed for this usage.
>>>>
>>>> But fuse `struct iomap_read_folio_ctx` and
>>>> `struct fuse_fill_read_data` are too FUSE-specific, I cannot
>>>> see it could be shared by other filesystems in the near future,
>>>> which is much like a single-filesystem specific concept, and
>>>> unlike to `bio` at all.
>>>
>>> Currently fuse is the only non-block-based filesystem using iomap but
>>> I don't see why there wouldn't be more in the future. For example,
>>> while looking at some of the netfs code, a lot of the core
>>> functionality looks the same between that and iomap and I think it
>>> might be a good idea to have netfs in the future use iomap's interface
>>> so that it can get the large folio dirty/uptodate tracking stuff and
>>> any other large folio stuff like more granular writeback stats
>>> accounting for free.
>>
>> I think you need to ask David on this idea, I've told him to
>> switch fscache to use iomap in 2022 before netfs is fully out [1],
>> but I don't see it will happen.
>>
>> [1] https://lore.kernel.org/linux-fsdevel/YfivxC9S52FlyKoL@B-P7TQMD6M-0146/
>>
>> Thanks,
>> Gao Xiang
> 


