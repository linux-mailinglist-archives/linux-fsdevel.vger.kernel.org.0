Return-Path: <linux-fsdevel+bounces-74404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD38D3A10B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D57E0303BE00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15B533B6E8;
	Mon, 19 Jan 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XG18T6fk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1033B6DA;
	Mon, 19 Jan 2026 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810356; cv=none; b=CoJTDyQ763bobXYCfMD1klhhOF3ewvE3RhwhMxhRpLJe3idS6ozlF9475fbjv1zOQfADCmset3vfimIp3joP2LTkVP0wqy10SpnpB7+9x+lAZxCsVTQpnW5/GNNReb2ob76ZtgPJ3lqkpmUzS2jBlGTJimZyu3vDBz76zkIzVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810356; c=relaxed/simple;
	bh=FWes7OhSld10qlcH7p1VpeTSgsIeUpesRGlPR7GD2WU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DIuYmzQKST8YyMoPWKWM80DUO85SUG3MHNVVJvK1aTWRmZVycPJlc85EhsPWJE5FeLsLCf/72p/7avK+NALsuSIa8SHV5S/X4S7wUIEs2Hgwoi6XOBji5f5pWRFqDzJe+9BbzWUGIP12GkwWCr0bQi8iMxeixdBfpp9hKxp66v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XG18T6fk; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768810351; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=eXOFYQUuzhFj9OHqhogwdIk9d4r3LbBPp2+CjnT0hY4=;
	b=XG18T6fkcRYEDySmt6vHWRwLOeCpFCdF+S+3k0dJubPAo1nYJM2TLutGiUP6yTiV1zB3lNUqWbLnI6NF/Zd1KIPurx5pBzqXeYsyQW6a4zVC5l4eFFfP6QQSEJU89DepySk5urecXVp/7bb7irFG6SeoH2cWaShtnqfx0UVcM28=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxK3bUB_1768810350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 16:12:30 +0800
Message-ID: <be558d13-6b41-48b7-9f5c-5da0f1ca1fce@linux.alibaba.com>
Date: Mon, 19 Jan 2026 16:12:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
In-Reply-To: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/19 15:53, Gao Xiang wrote:
> 
> 
> On 2026/1/19 15:29, Christoph Hellwig wrote:
>> On Sat, Jan 17, 2026 at 12:21:16AM +0800, Gao Xiang wrote:
>>> Hi Christoph,
>>>
>>> On 2026/1/16 23:46, Christoph Hellwig wrote:
>>>> I don't really understand the fingerprint idea.  Files with the
>>>> same content will point to the same physical disk blocks, so that
>>>> should be a much better indicator than a finger print?  Also how does
>>>
>>> Page cache sharing should apply to different EROFS
>>> filesystem images on the same machine too, so the
>>> physical disk block number idea cannot be applied
>>> to this.
>>
>> Oh.  That's kinda unexpected and adds another twist to the whole scheme.
>> So in that case the on-disk data actually is duplicated in each image
>> and then de-duplicated in memory only?  Ewwww...
> 
> On-disk deduplication is decoupled from this feature:

Of course, first of all:

  - Data within a single EROFS image is deduplicated of
    course (for example, erofs supports extent-based
    chunks);

> 
> - EROFS can share the same blocks in blobs (multiple
> devices) among different images, so that on-disk data

   This way is like docker layers, common data/layers
can be kept in seperate blobs;

> can be shared by refering the same blobs;

Both deduplication ways above will be applied to the
golden images which will be transfered on the wire.

> 
> - On-disk data won't be deduplicated in image if reflink
> is enabled for backing fses, userspace mounters can
> trigger background GCs to deduplicate the identical
> blocks.

And this way is applied at runtime if underlayfs
supports reflink.

> 
> I just tried to say EROFS doesn't limit what's
> the real meaning of `fingerprint` (they can be serialized
> integer numbers for example defined by a specific image
> publisher, or a specific secure hash.  Currently,
> "mkfs.erofs" will generate sha256 for each files), but
> left them to the image builders:
> 
> 
> 1) if `fingerprint` is distributed as on-disk part of
> signed images, as I said, it could be shared within a
> trusted domain_id (usually the same image builder) --
> that is the top priority thing using dmverity;
> 
> Or
> 
> 2) If `fingerprint` is not distributed in the image
> or images are untrusted (e.g. unknown signatures),
> image fetchers can scan each inode in the golden
> images to generate an extra minimal EROFS
> metadata-only image with local calculated
> `fingerprint` too, which is much similar to the
> current ostree way (parse remote files and calculate
> digests).
> 
> Thanks,
> Gao Xiang


