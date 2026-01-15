Return-Path: <linux-fsdevel+bounces-73924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 599EBD24BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EDFE30141D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2431F3A1A26;
	Thu, 15 Jan 2026 13:30:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6A395D93;
	Thu, 15 Jan 2026 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483855; cv=none; b=J+Vw7bLGEsFMI70rgjjdZKt9IOM0U+Mi7+A6QpQvR2OkqvE9Uvsx7LwEDpG6FymLXb3iTxA4GggyUxzRTVxxy2+/yexY6Lbp3eWMdP35GnNM9wErmBwgK2oUX4um+duCbxmLT/775++pppdiiAiajfMLz9NBtEQGAgUpBEGZXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483855; c=relaxed/simple;
	bh=e6hnGFS0XPjhAi5muKv5zCvk+GSSfCWUSUHvlYckBvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSUnF9ats8GQ6jnCzQ6I8/Rzj6ZEDeccmmGGx0uqnWOfbm33S1D9W7/pkrOIDyzh+MQTBo3Bnbj0v4kON0cUni4GjwBi8tcLyolM5YLi/H9n+WyAUifurINowRYzTDcZYYflGUYHYQKlWI9+ECzUHxzoFwUgSJJ/k+32FrxDIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [10.26.132.114] (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [101.226.143.241])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30c9b99fb;
	Thu, 15 Jan 2026 21:30:45 +0800 (GMT+08:00)
Message-ID: <a9dc39a4-bdeb-4e28-9283-cf611ce198f5@ustc.edu>
Date: Thu, 15 Jan 2026 21:30:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] fuse: add close all in passthrough backing close for
 crash recovery
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260115072032.402-1-luochunsheng@ustc.edu>
 <20260115072032.402-2-luochunsheng@ustc.edu>
 <aWjcT6snaivGXvxq@amir-ThinkPad-T480>
From: Chunsheng Luo <luochunsheng@ustc.edu>
In-Reply-To: <aWjcT6snaivGXvxq@amir-ThinkPad-T480>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9bc1d9f54c03a2kunma845a69a223c9a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSx5MVkseSBhLTR5LSRlOT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKS0pVSUlNVUpPSFVJT0pZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQk
	tCWQY+



On 1/15/26 8:23 PM, Amir Goldstein wrote:
> On Thu, Jan 15, 2026 at 03:20:30PM +0800, Chunsheng Luo wrote:
>> Simplify FUSE daemon crash recovery by avoiding persistence of
>> backing_ids, thereby improving availability and reducing performance
>> overhead.
>>
>> Non-persistent backing_ids after crash recovery may lead to resource
>> leaks if backing file resources are not properly cleaned up during
>> daemon restart.
>>
>> Add a close_all handler to the backing close operation. This ensures
>> comprehensive cleanup of all backing file resources when the FUSE
>> daemon restarts, preventing resource leaks while maintaining the
>> simplified recovery approach.
> 
> Am I correct to assume that you are referring to FUSE server restart
> where the /dev/fuse fd is stored in an external fd store and reused by
> the new FUSE server instance?
> 

Yes, that's correct.

>>
>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
>> ---
>>   fs/fuse/backing.c | 14 ++++++++++++++
>>   fs/fuse/dev.c     |  5 +++++
>>   fs/fuse/fuse_i.h  |  1 +
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
>> index 4afda419dd14..34d0ea62fb9b 100644
>> --- a/fs/fuse/backing.c
>> +++ b/fs/fuse/backing.c
>> @@ -166,6 +166,20 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>>   	return err;
>>   }
>>   
>> +static int fuse_backing_close_one(int id, void *p, void *data)
>> +{
>> +	struct fuse_conn *fc = data;
>> +
>> +	fuse_backing_close(fc, id);
>> +
>> +	return 0;
>> +}
>> +
>> +void fuse_backing_close_all(struct fuse_conn *fc)
>> +{
>> +	idr_for_each(&fc->backing_files_map, fuse_backing_close_one, fc);
>> +}
>> +
>>   struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
>>   {
>>   	struct fuse_backing *fb;
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 6d59cbc877c6..25f6bb58623d 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -2651,6 +2651,11 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
>>   	if (get_user(backing_id, argp))
>>   		return -EFAULT;
>>   
>> +	if (backing_id == -1) {
>> +		fuse_backing_close_all(fud->fc);
>> +		return 0;
>> +	}
>> +
> 
> I think that an explicit new ioctl FUSE_DEV_IOC_BACKING_CLOSE_ALL
> is called for this very intrusive operation.
> 
> Sending FUSE_DEV_IOC_BACKING_CLOSE with backing_id -1 could
> just as well happen by mistake.
> 
> Thanks,
> Amir.
> 
> 
Okay, thank you for the suggestion.


