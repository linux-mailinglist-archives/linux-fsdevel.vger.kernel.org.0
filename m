Return-Path: <linux-fsdevel+bounces-22061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB59118EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 05:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257B51C21B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 03:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C91272A7;
	Fri, 21 Jun 2024 03:13:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066C2AEE3;
	Fri, 21 Jun 2024 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939620; cv=none; b=LmJc0HlUBq/F6dFUpIUR1co7Q5xlGUSMvxlWbPJfeAOzWDIWYaEpGxmGdwcoD7A8rV1Wht9oD5Ku05KY8135uc0MmUWw8HTcq2I2OZkLbsfbSOeDgKMr7HU6e1dTzcJkfoxeevAvRTX1LRv6ubXzQMBCp1h+k1T3lAU80RiW35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939620; c=relaxed/simple;
	bh=RpKbTn8z66IM6pDZnQjMY7s18b115A7rGKrIz7h93Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E5WXsVQDdQuV1FJKb1LxoWkaU0LJmtXtVbpz35/iF/UVnJToFOUfz7+vgGmFnkVHyytzQdVyn0OuKYLeb7h431NbGV0Fl2J82hBirQ0vE4KE1fiYQJ6g6LwwO+3fNsYt4vfCdQXHKDbniFzWmwP2oIJbd52HsilZVVcYTfXW6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W52QN10NMz2CkN9;
	Fri, 21 Jun 2024 11:09:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E3771A0188;
	Fri, 21 Jun 2024 11:13:27 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 11:13:27 +0800
Message-ID: <8f450919-dbd2-4074-a697-92d72f414b65@huawei.com>
Date: Fri, 21 Jun 2024 11:13:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bvec_iter.bi_sector -> loff_t?
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Kent Overstreet
	<kent.overstreet@linux.dev>
CC: <linux-bcachefs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/6/20 22:49, Matthew Wilcox wrote:
> On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
>> That's really just descriptive, not prescriptive.
>>
>> The intent of O_DIRECT is "bypass the page cache", the alignment
>> restrictions are just a side effect of that. Applications just care
>> about is having predictable performance characteristics.
> 
> But any application that has been written to use O_DIRECT already has the
> alignment & size guarantees in place.  What this patch is attempting to do
> is make it "more friendly" to use, and I'm not sure that's a great idea.
> Not without buy-in from a large cross-section of filesystem people.

Indeed, the purpose of O_DIRECT is to bypass the page cache. Either the
file system can handle the unaligned offset or memory, or it should
directly return EINVAL (or ENOTSUP for file cannot be read by direct
I/O?). But I have observed that some file systems have
this fallback logic (in ext4: if `ext4_should_use_dio` not true, it will 
fallback to buffer I/O. in f2fs: if `f2fs_should_use_dio` not true, it 
will fallback to buffer I/O.). Does O_DIRECT flag need prescriptive 
definition to standardize I/O behavior?

Thanks,
Hongbo
> 
> I'm more sympathetic to "lets relax the alignment requirements", since
> most IO devices actually can do IO to arbitrary boundaries (or at least
> reasonable boundaries, eg cacheline alignment or 4-byte alignment).
> The 512 byte alignment doesn't seem particularly rooted in any hardware
> restrictions.
> 
> But size?  Fundamentally, we're asking the device to do IO directly to
> this userspace address.  That means you get to do the entire IO, not
> just the part of it that you want.  I know some devices have bitbucket
> descriptors, but many don't.
> 
>>> I'm against it.  Block devices only do sector-aligned IO and we should
>>> not pretend otherwise.
>>
>> Eh?
>>
>> bio isn't really specific to the block layer anyways, given that an
>> iov_iter can be a bio underneath. We _really_ should be trying for
>> better commonality of data structures.
> 
> bio is absolutely specific to the block layer.  Look at it:
> 
> /*
>   * main unit of I/O for the block layer and lower layers (ie drivers and
>   * stacking drivers)
>   */
> 
>          struct block_device     *bi_bdev;
>          unsigned short          bi_flags;       /* BIO_* below */
>          unsigned short          bi_ioprio;
>          blk_status_t            bi_status;
> 
> Filesystems get to use it to interact with the block layer.  The iov_iter
> isn't an abstraction over the bio, it's an abstraction over the bio_vec.
> 

