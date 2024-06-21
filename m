Return-Path: <linux-fsdevel+bounces-22058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7599118CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DDC1C22644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6884FAE;
	Fri, 21 Jun 2024 02:37:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5DD8289A;
	Fri, 21 Jun 2024 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937456; cv=none; b=bAHgqQjScZ4u2Ysc74AlAf3AcywZoSagBBTRhOKzyAiBxZe0/ULnnZC90Cz0eN8BIBHHpkJBBWBwQRg0flNIK6+dmJseQCPgKUXLuEA0vSVqZkvuYbhWX4KsRlECP0Z9dwnSYjDvIkN8bHku0IOP3JLI5yQ8Mzdqzpo3Wh2zE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937456; c=relaxed/simple;
	bh=LfFYFCNK5qm76GnB8FgDfN7JiY7OMy1sPc/cPv+eWeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DUcv86/kcdOIJqLmzdhFT2IIam+HGRcgHRjzDKxwd0sRblhuz9zsk0ABhRnE7Zr/ZurR7pvL+eGBsR2x8jHbM2X3PYi1acSu9TFPnW4/5KVHtMCZlCR8/jYhGQ/u8+9AvlGIL8oRT+RuKCHx2IO7bJcwUGLJ+d8GIe7R/L3eAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W51cX4zjbzxSKr;
	Fri, 21 Jun 2024 10:33:16 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A1EF6140158;
	Fri, 21 Jun 2024 10:37:30 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 10:37:30 +0800
Message-ID: <d7a104b4-fea8-4c61-b184-ddc89bf007c4@huawei.com>
Date: Fri, 21 Jun 2024 10:37:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bvec_iter.bi_sector -> loff_t?
To: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Kent
 Overstreet <kent.overstreet@linux.dev>
CC: <linux-bcachefs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <hch@lst.de>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
 <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/6/20 22:56, Jens Axboe wrote:
> On 6/20/24 8:49 AM, Matthew Wilcox wrote:
>> On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
>> I'm more sympathetic to "lets relax the alignment requirements", since
>> most IO devices actually can do IO to arbitrary boundaries (or at least
>> reasonable boundaries, eg cacheline alignment or 4-byte alignment).
>> The 512 byte alignment doesn't seem particularly rooted in any hardware
>> restrictions.
> 
> We already did, based on real world use cases to avoid copies just
> because the memory wasn't aligned on a sector size boundary. It's
> perfectly valid now to do:
> 
> struct queue_limits lim {
> 	.dma_alignment = 3,
> };
> 
> disk = blk_mq_alloc_disk(&tag_set, &lim, NULL);
> 
> and have O_DIRECT with a 32-bit memory alignment work just fine, where
Does this mean that file system can relax its alignment restrictions on 
offset or memory (not 512 or 4096)? Is it necessary to add alignment 
restrictions in the super block of file system? Because there are 
different alignment restrictions for different storage hardware driver.

Thanks,
Hongbo
> before it would EINVAL. The sector size memory alignment thing has
> always been odd and never rooted in anything other than "oh let's just
> require the whole combination of size/disk offset/alignment to be sector
> based".
> 
>> But size?  Fundamentally, we're asking the device to do IO directly to
>> this userspace address.  That means you get to do the entire IO, not
>> just the part of it that you want.  I know some devices have bitbucket
>> descriptors, but many don't.
> 
> We did poke at that a bit for nvme with bitbuckets, but I don't even
> know how prevalent that support is in hardware. Definitely way iffier
> and spotty than the alignment, where that limit was never based on
> anything remotely resembling a hardware restraint.
> 
>>>> I'm against it.  Block devices only do sector-aligned IO and we should
>>>> not pretend otherwise.
>>>
>>> Eh?
>>>
>>> bio isn't really specific to the block layer anyways, given that an
>>> iov_iter can be a bio underneath. We _really_ should be trying for
>>> better commonality of data structures.
>>
>> bio is absolutely specific to the block layer.  Look at it:
> 
> It's literally "block IO", so would have to concur with that.
> 

