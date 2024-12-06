Return-Path: <linux-fsdevel+bounces-36612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77B9E6873
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 09:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDB31885FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C608F1DE4E4;
	Fri,  6 Dec 2024 08:09:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E6197548;
	Fri,  6 Dec 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472576; cv=none; b=kRLjkI0FB9BCL2IhwoSjksL/pmHlsMqmwih7veA/IFXqDuw/dFnC2WqNEzE/XiTgkbez3yLaEK2gcyKB3W+DsQYNF5PdS075S4z0Ka/lHPewH9wMW1dOsUvB6OjAv1HiApWUPgiKZRhw+DvmN6JYTG36djyCedFbUUd3RSrOnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472576; c=relaxed/simple;
	bh=TQYE2agDYZJTvN56R/TnJ7DUpWGGKi+XZbXXKF4U1Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flbyhWCCdOBcyhQrcjrylkShKWavZgHMGcewx1TsxjqonGexSMC743bxEA/REthaamMQ8vxXOXE9uuxScd6CpxopMiCZY1/b2xIWY2P1BIXjncMQfOKnitpYNXUvffbxBq63pFeOm0f2z+jKCZqf1JMG/1Bt+P76RkYGb/v+8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y4P6X3Df1z4f3jct;
	Fri,  6 Dec 2024 16:09:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8235B1A08DC;
	Fri,  6 Dec 2024 16:09:27 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCngYU2sVJnEbw9Dw--.20216S3;
	Fri, 06 Dec 2024 16:09:27 +0800 (CST)
Message-ID: <0b45ce3d-fd20-4df2-9c04-f956b96bf6a2@huaweicloud.com>
Date: Fri, 6 Dec 2024 16:09:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/27] ext4: refactor ext4_zero_range()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 david@fromorbit.com, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-6-yi.zhang@huaweicloud.com>
 <20241204115208.g4lswqfbwrwmwtqw@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241204115208.g4lswqfbwrwmwtqw@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCngYU2sVJnEbw9Dw--.20216S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF15Ar1fCw45Gr47GF15urg_yoW8WFW5pF
	Z7Xa4j9FWkWFyUCa1xKF1fZF4Sk398tr47G34fWry8Zrn8JrnayFs2ga15W3W09ws7Ja1F
	vanrKryxuF45AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/4 19:52, Jan Kara wrote:
> On Tue 22-10-24 19:10:36, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The current implementation of ext4_zero_range() contains complex
>> position calculations and stale error tags. To improve the code's
>> clarity and maintainability, it is essential to clean up the code and
>> improve its readability, this can be achieved by: a) simplifying and
>> renaming variables, making the style the same as ext4_punch_hole(); b)
>> eliminating unnecessary position calculations, writing back all data in
>> data=journal mode, and drop page cache from the original offset to the
>> end, rather than using aligned blocks; c) renaming the stale out_mutex
>> tags.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> ...
> 
>> -		goto out_mutex;
>> -
>> -	/* Preallocate the range including the unaligned edges */
>> -	if (partial_begin || partial_end) {
>> -		ret = ext4_alloc_file_blocks(file,
>> -				round_down(offset, 1 << blkbits) >> blkbits,
>> -				(round_up((offset + len), 1 << blkbits) -
>> -				 round_down(offset, 1 << blkbits)) >> blkbits,
>> -				new_size, flags);
>> -		if (ret)
>> -			goto out_mutex;
>> -
>> -	}
> 
> So I think we should keep this first ext4_alloc_file_blocks() call before
> we truncate the page cache. Otherwise if ext4_alloc_file_blocks() fails due
> to ENOSPC, we have already lost the dirty data originally in the zeroed
> range. All the other failure modes are kind of catastrophic anyway, so they
> are fine after dropping the page cache. But this is can be quite common and
> should be handled more gracefully.
> 

Ha, right, I missed this error case, I will revise it.

Thanks,
Yi.


