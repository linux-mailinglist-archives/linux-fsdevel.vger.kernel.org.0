Return-Path: <linux-fsdevel+bounces-72829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44947D02F81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 14:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7781D30087B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4742A82D;
	Thu,  8 Jan 2026 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sS2FltES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2683D3315;
	Thu,  8 Jan 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875555; cv=none; b=X2h5vvE0gUlvzXQcsnjFxSYgdMcY7sMOZIn+TJJD2ni0lQOfwefvcEGNcARxxWRw885lrHpwuoNNIRDzuh7IN9p0QjriYYSiDuAMNCBy9MW95mGoAzlYkPyrD0cH8gO0E79Iwr/+3JYLVkuayVTCE7MDYWVPaUMldsIkd5xPKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875555; c=relaxed/simple;
	bh=z0+8gzbE/A+SVL7AHGtdgFBbPcxGo9Q02qhZ6PwSsAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAiK/VIIx/3EnbDtpJQ71xGw5wc92bB4LK95wB7snD8uzz6zGysCzj/UVayAmtySjMXAqzZ7DhBGBFCMJNx+tgMNZcnZ/7ExdI1K53NwMVT4qfgvxTH50U1KEeRcF/b6KgMnCw0ak/9knA8tyAqITdLyXCl9/0MLALZ4e7OG+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sS2FltES; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767875548; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ua0tqkWtKiJMCR8s1xdOhAoiWaQM65A/foc/hvxNaH8=;
	b=sS2FltES19g0RZoC4vwvF4PTr6y3jZClUpnMTNjMrt9UDh83tRdpD2RnIGD9VbgTLP0nFe4kuBCNer+C9V0dk7yY+/C6yVJ/e9yoroAKc3n4aM1ETncdWVR1LXj8+rG0FQv6SAjTZ6r0s0XL3Mm5NB8urRpr4DjNp/SUUtYJono=
Received: from 30.251.32.236(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwcgEVB_1767875547 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 20:32:28 +0800
Message-ID: <21190994-916e-4f6e-8a57-8f90e27e3227@linux.alibaba.com>
Date: Thu, 8 Jan 2026 20:32:27 +0800
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
 <bb8e14f4-dbab-4974-a180-b436a00625d1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <bb8e14f4-dbab-4974-a180-b436a00625d1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/8 20:20, Hongbo Li wrote:
> Hi, Xiang
> 
> On 2026/1/7 14:08, Gao Xiang wrote:
>>
>>
>> On 2025/12/31 17:01, Hongbo Li wrote:
> 
> ...
> 
>>> +
>>> +static int erofs_ishare_file_release(struct inode *inode, struct file *file)
>>> +{
>>> +    struct file *realfile = file->private_data;
>>> +
>>> +    iput(realfile->f_inode);
>>> +    fput(realfile);
>>> +    file->private_data = NULL;
>>> +    return 0;
>>> +}
>>> +
>>> +static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
>>> +                       struct iov_iter *to)
>>> +{
>>> +    struct file *realfile = iocb->ki_filp->private_data;
>>> +    struct kiocb dedup_iocb;
>>> +    ssize_t nread;
>>> +
>>> +    if (!iov_iter_count(to))
>>> +        return 0;
>>> +
>>> +    /* fallback to the original file in DIRECT mode */
>>> +    if (iocb->ki_flags & IOCB_DIRECT)
>>> +        realfile = iocb->ki_filp;
>>> +
>>> +    kiocb_clone(&dedup_iocb, iocb, realfile);
>>> +    nread = filemap_read(&dedup_iocb, to, 0);
>>> +    iocb->ki_pos = dedup_iocb.ki_pos;
>>
>> I think it will not work for the AIO cases.
>>
>> In order to make it simplified, how about just
>> allowing sync and non-direct I/O first, and
>> defering DIO/AIO support later?
>>
> 
> Ok, but what about doing the fallback logic:
> 
> 1. For direct io: fallback to the original file.
> 2. For AIO: initialize the sync io by init_sync_kiocb (May be we can just replace kiocb_clone with init_sync_kiocb).

No, I'd like to disallow these two types of I/Os
first and consider adding it later for simplicity.

> 
> Thanks,
> Hongbo
> 
>>> +    file_accessed(iocb->ki_filp);
>>
>> I don't think it's useful in practice.
>>
> 
> Just keep in consistent with filemap_read?

Just remove it since EROFS is an immutable fs so
there is nonsense to update atime.

Thanks,
Gao Xiang

