Return-Path: <linux-fsdevel+bounces-27560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5496262C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA9285D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E42171E5F;
	Wed, 28 Aug 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="txUBEcw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D48173347;
	Wed, 28 Aug 2024 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845059; cv=none; b=oGgnLBOEO1ZyORCRySEzbBvOjJ0D1fuJSdz4dvAekSJPmRwW5k+cK90q7bcrOGkBAYARAE4Zgmw/G57xN6Db4Ns1aL+OtCwyx5RxXEfwL+kZYaNm+0eKWpHKVy7d2KhFrvyMTIM5EclfrrP3DmTN+jIG4EAQgMcqCwxilwKIkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845059; c=relaxed/simple;
	bh=DayXTzJU+YhVIOAHUrAl/QSM+Bc01leTMONhVAN9SfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/Xlwl0eD4ogNWCWfrCyZsyMgC90ZQ2SvJV4HwTAW99VxFAiCB/NhVO8NpN4Kf+l6zYRWu8ZQyeCsgm0deUdqsIcDwvAx5ovQAjqVLpEjNa+ezv5VBFRcUsSg5My5w+WnioiFrCnQln0N+xrcblSLS9yl2keG/Qz60naVWmaNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=txUBEcw1; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724845047; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ugNMtmVRjHIn/42KzidtvoiLqJnhMfKlcNcK8/ZW6MI=;
	b=txUBEcw1gAX25koQZAV7ANsjuUlc1T9kA1mEoQY9d3KZjztLGGGvSnqj6YCDf7xoDNoDzTzI8ozLWE01Z4R2t3MKliLDb7+Lmv5GXvlQShIsLECA5PxNVl/Yyd9FSF0WHij+ji+RaWTvh5BvtnjyuMJnOuzT30VcvXN83mQ7miU=
Received: from 30.221.147.140(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDplXqn_1724845046)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 19:37:27 +0800
Message-ID: <e1b5a997-0977-43ff-8d02-7df3c1a26142@linux.alibaba.com>
Date: Wed, 28 Aug 2024 19:37:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add fast path for fuse_range_is_writeback
To: yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lixiaokeng@huawei.com, miklos@szeredi.hu
References: <8e235c73-faac-4cb7-bc6a-e1eea5075cbe@linux.alibaba.com>
 <20240823061913.3921169-1-yangyun50@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240823061913.3921169-1-yangyun50@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/23/24 2:19 PM, yangyun wrote:
> Sorry for the late reply.
> 
> On Wed, Aug 14, 2024 at 05:56:06PM +0800, Jingbo Xu wrote:
>>
>>
>> On 8/14/24 5:36 PM, yangyun wrote:
>>> In some cases, the fi->writepages may be empty. And there is no need
>>> to check fi->writepages with spin_lock, which may have an impact on
>>> performance due to lock contention. For example, in scenarios where
>>> multiple readers read the same file without any writers, or where
>>> the page cache is not enabled.
>>>
>>> Also remove the outdated comment since commit 6b2fb79963fb ("fuse:
>>> optimize writepages search") has optimize the situation by replacing
>>> list with rb-tree.
>>>
>>> Signed-off-by: yangyun <yangyun50@huawei.com>
>>> ---
>>>  fs/fuse/file.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index f39456c65ed7..59c911b61000 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -448,9 +448,6 @@ static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
>>>  
>>>  /*
>>>   * Check if any page in a range is under writeback
>>> - *
>>> - * This is currently done by walking the list of writepage requests
>>> - * for the inode, which can be pretty inefficient.
>>>   */
>>>  static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
>>>  				   pgoff_t idx_to)
>>> @@ -458,6 +455,9 @@ static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
>>>  	struct fuse_inode *fi = get_fuse_inode(inode);
>>>  	bool found;
>>>  
>>> +	if (RB_EMPTY_ROOT(&fi->writepages))
>>> +		return false;
>>
>> fi->lock is held when inserting wpa into fi->writepages rbtree (see
>> fuse_writepage_add()).  I doubt if there is race condition when checking
>> if fi->writepages rbtree is empty without fi->lock held.
> 
> The code can make sure that there are no race conditions because:
> 1. For O_DIRECT and FOPEN_DIRECT_IO with fc->direct_io_allow_mmap, the `filemap_write_and_wait_range` before can make the insert operation to be happend before the check operation.
> 2. For other cases, there are no pagecache operaions so the fi->writepages is always empty.
> 
> In my usercase, the fi->writepages is usually empty but the spin_lock associated with it contributes a great impact on the performace of my filesystem due to lock contention. So optimize it.

Thanks for the explanation.  There are multiple callsites of
fuse_wait_on_page_writeback(), and how do you ensure that there can't be
any concurrent fuse_writepage_add() with these callsites.

I'm not sure if the concurrency indeed makes a difference, since
fuse_range_is_writeback() releases fi->lock before it returns anyway.


-- 
Thanks,
Jingbo

