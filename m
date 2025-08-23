Return-Path: <linux-fsdevel+bounces-58875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155C3B326DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 06:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704791C88417
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 04:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEAF21D3C0;
	Sat, 23 Aug 2025 04:37:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783822566;
	Sat, 23 Aug 2025 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755923846; cv=none; b=TAM3XiEHu9mQmC8wVB7tbQqQq0+gvrJjRkztv7ZEDJgkAIlskP/aOqNVRyOfw3YFCn9XV87FJSYR+JWP1ddVaFDvIv/aZ9viqS1CXG93tKMRKUC9P843v4XfX2RoPUFxRpvV6g1GaIg2A3K8lthKCKoBIT+f7gG2Xb3lh/KMJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755923846; c=relaxed/simple;
	bh=jOsk/0E2M1AqmaAoj/SNM6dDuTwerjrCn1XIBMFUI0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ3BT225vnekFI4KeePC8WledVmOiomTusLGqSZER/jr5FWJwiN9bTW/WfQW1EGsi7cADNE7GbfooYBQCVJ2ygvN5Q6U/He/LuwK7iZt2MdqQ4S1R4hMQy6PlhQZwz/2qigRGz31DcwnhFYPbaeg832U4N+FeCYaW/TMM59hAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c84691PCYzYQvXl;
	Sat, 23 Aug 2025 12:37:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AF3481A06DD;
	Sat, 23 Aug 2025 12:37:19 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHERJ9Ralopph+Eg--.26768S3;
	Sat, 23 Aug 2025 12:37:19 +0800 (CST)
Message-ID: <bf778cf7-6ae5-4f57-a40c-fbae5cbe00a7@huaweicloud.com>
Date: Sat, 23 Aug 2025 12:37:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] block: introduce
 max_{hw|user}_wzeroes_unmap_sectors to queue limits
To: John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 tytso@mit.edu, djwong@kernel.org, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, brauner@kernel.org,
 martin.petersen@oracle.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
 <20250619111806.3546162-2-yi.zhang@huaweicloud.com>
 <803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERJ9Ralopph+Eg--.26768S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1Utr4furyDGrW7CryxAFb_yoW8Zw4xpF
	y8uryIq34rJFs29w4Utw1UuFyFy3yru345Gr9rJ3Z3A3ykCrnIgF45u3ZFgFW7XrWrGw18
	t3WYyFZxZr4UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 8/21/2025 8:55 PM, John Garry wrote:
> On 19/06/2025 12:17, Zhang Yi wrote:
>>   }
>> @@ -333,6 +335,12 @@ int blk_validate_limits(struct queue_limits *lim)
>>       if (!lim->max_segments)
>>           lim->max_segments = BLK_MAX_SEGMENTS;
>>   +    if (lim->max_hw_wzeroes_unmap_sectors &&
>> +        lim->max_hw_wzeroes_unmap_sectors != lim->max_write_zeroes_sectors)
>> +        return -EINVAL;
> 
> JFYI, I noticed that I am failing this check in raid0_set_limits() -> queue_limits_set() -> queue_limits_commit_update() -> blk_validate_limits() for v6.17-rc2
> 
> The raid0 array consists of NVMe partitions. Here lim->max_hw_wzeroes_unmap_sectors = 4096 and lim->max_write_zeroes_sectors = 0 values for the failure, above.
> 
> john@raspberrypi:~ $ cat /sys/block/nvme0n1/queue/write_zeroes_max_bytes
> 2097152
> john@raspberrypi:~ $ cat /sys/block/nvme0n1/queue/write_zeroes_unmap_max_bytes
> 2097152
> john@raspberrypi:~ $ cat
> /sys/block/nvme0n1/queue/write_zeroes_unmap_max_hw_bytes
> 2097152
> john@raspberrypi:~ $
> 
> 

Thank you for checking on this!

The problem is that raid0_set_limits() only sets max_write_zeroes_sectors
without synchronously setting max_hw_wzeroes_unmap_sectors. It appears
that all stacked drivers that call blk_set_stacking_limits() to
initialize stacked limits but independently adjust
max_write_zeroes_sectors are problematic, including all md drivers and
drbd. These drivers need to update max_hw_wzeroes_unmap_sectors as well, I
will send out a fix soon.

Thanks,
Yi.

> 
>> +    lim->max_wzeroes_unmap_sectors = min(lim->max_hw_wzeroes_unmap_sectors,
>> +            lim->max_user_wzeroes_unmap_sectors);
>> +
>>       lim->max_discard_sectors =
>>           min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
>>   @@ -418,10 +426,11 @@ int blk_set_default_limits(struct queue_limits *lim)


