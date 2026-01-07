Return-Path: <linux-fsdevel+bounces-72592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A121CFC77D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 08:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45AF63034A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7711B27FB2E;
	Wed,  7 Jan 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FA6kKmGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537E27FD4A;
	Wed,  7 Jan 2026 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772422; cv=none; b=anEeSMr0/8lzbkGHy90/H54maRHAOfaGwUYybrYV+0DEXv0sTNUi4oA16RVPhOO0lNXO5ON5zdvwdCMt6T9WBKDft4a7Cc0jB/u9UbH+Tx1VyJBpCcb1H5SAqr3UWqDUM/p9Fa7GGWQnrgytYTGXyQefmGHTB9WdEQyvgDDSERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772422; c=relaxed/simple;
	bh=dWl4aA3MRKbB6zXsP2yS6jsJRCLsyETM0sJdMbNe+hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js8dvnVARXr7+vwGI6RqDfHHXPu8irggjBFsCROX+xj1VW4t3LbceL86e+Th3D8gcLQlP38UAQahj28ccqYumw3ZUJLZChds04QwsWWnFlRjkG2ZqjGzpOHFHtUAdpxnO0TwbI0OvqbiExz4H3F/k3LP25F60y9AY78ilSvU+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FA6kKmGL; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767772410; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uUqzrsb1f9GaEfY1AZwki6Vfws6/4NnUQf4AEGM5Xvo=;
	b=FA6kKmGLKyb638LeSSH+6UE4h9BGNnwaAUFA6keJ9ZiGFdCowyJa9gfePXrOv3WmqEbRriEQ8j0LvUm6rCoGgbcIQQKwuHwhI5xH90/bcP+y4ZhbJmiYX7l4g9gv+2UcxUmY7Zw6iSd4XXX3UXsfJCRIcDfJ5uk7tjOfrslog6E=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwY3fsA_1767772409 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 15:53:30 +0800
Message-ID: <d82c60eb-a170-48fe-9e50-e64c80681cb6@linux.alibaba.com>
Date: Wed, 7 Jan 2026 15:53:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
 <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
 <df2889c0-6027-4f42-a013-b01357fd0005@linux.alibaba.com>
 <07212138-c0fc-4a64-a323-9cab978bf610@huawei.com>
 <9bacd58e-40be-4250-9fab-7fb8e2606ad8@linux.alibaba.com>
 <48755c73-323d-469e-9125-07051daf7c19@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <48755c73-323d-469e-9125-07051daf7c19@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/7 15:32, Hongbo Li wrote:
> 
> 
> On 2026/1/7 15:27, Gao Xiang wrote:
>>
>>
>> On 2026/1/7 15:17, Hongbo Li wrote:
>>> Hi, Xiang
>>>
>>
>> ...
>>
>>>>>>> +
>>>>>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>>>>>> +{
>>>>>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>>>>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>>>>>> +    struct erofs_inode_fingerprint fp;
>>>>>>> +    struct inode *sharedinode;
>>>>>>> +    unsigned long hash;
>>>>>>> +
>>>>>>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>>>>>>> +        return false;
>>>>>>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>>>>>>> +    if (!fp.size)
>>>>>>> +        return false;
>>>>>>
>>>>>> Why not just:
>>>>>>
>>>>>>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>>>>>>          return false;
>>>>>>
>>>>>
>>>>> When erofs_sb_has_ishare_xattrs returns false, erofs_xattr_fill_ishare_fp also considers success.
>>>>
>>>> Then why !test_opt(&sbi->opt, INODE_SHARE) didn't return?
>>>>
>>>
>>> The MOUNT_INODE_SHARE flag is passed from user's mount option. And it is controllered by CONFIG_EROFS_FS_PAGE_CACHE_SHARE. I doesn't do the check when the superblock without ishare_xattrs. (It seems the mount options is static, although it is useless for mounting with inode_share on one EROFS image without ishare_xattrs).
>>> So should we check that if the superblock has not ishare_xattrs feature, and we return -ENOSUPP?
>>
>> I think you should just mask off the INODE_SHARE if the on-disk
>> compat feature is unavailable, and print a warning just like
>> FSDAX fallback.
>>
> 
> Ok, it seems reasonable, and also can remove the check logic in erofs_xattr_fill_ishare_fp. I will change in next version.

I think you should move

if (!test_opt(&sbi->opt, INODE_SHARE))
	return -EOPNOTSUPP;

into erofs_xattr_fill_inode_fingerprint() directly.

Thanks,
Gao Xiang

