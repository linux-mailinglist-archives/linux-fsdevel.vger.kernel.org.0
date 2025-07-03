Return-Path: <linux-fsdevel+bounces-53753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2DAF67AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 04:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE5416BAFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCC81B0F17;
	Thu,  3 Jul 2025 02:03:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957806EB79;
	Thu,  3 Jul 2025 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508236; cv=none; b=i6IQigCMoeKQziZCsYQPJKI/Wc7gGnWAXavjc0JqoqkQmnDU78lzciCSyPJzr7FqAIOBuL0Za9whR2xqhTUysHQK6IkqgcXjlBuNeIBZq//BFKQ5Vk2qGr3lABhaSLveeGOiQLf628Tw11R6AeeRX5Ec6SbHcp78OVjZQ68GhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508236; c=relaxed/simple;
	bh=cj5tk4s7MeSPch96CAZg7LHsRgPqCa/4i/SmhJI+HbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSYgRw5DfkeRFtJTVo5i78cYPfakOlk5dwTLf+vSlcTM8HWERG9MxljmNtDLZiT/vfy9a3jZk76Rm2M347M5hHzG8opIcg0nPyk6TYNg0DRs2mU7/pNEhK+R43rN5EAkd65a2gM9PsGCOOHclMAqcdTTqq34ncBvIeJZWa63wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bXg6c2z9dzKHN1m;
	Thu,  3 Jul 2025 10:03:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CDF4D1A0A4F;
	Thu,  3 Jul 2025 10:03:50 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgA3mSYE5WVogxzrAQ--.65249S3;
	Thu, 03 Jul 2025 10:03:50 +0800 (CST)
Message-ID: <abbdba63-2e15-4a11-844a-0423d0bc4a87@huaweicloud.com>
Date: Thu, 3 Jul 2025 10:03:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] ext4: process folios writeback in bytes
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com,
 libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-2-yi.zhang@huaweicloud.com>
 <oggzqu4j23ihzsi7qfwiluy5w3nwubgbyhqu2a3hdtta7cyhno@smlzq7xmrflq>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <oggzqu4j23ihzsi7qfwiluy5w3nwubgbyhqu2a3hdtta7cyhno@smlzq7xmrflq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3mSYE5WVogxzrAQ--.65249S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy5Xr15ZrW3ZryxWF47XFb_yoWDWFg_uF
	ZYyr4xKr4v9F1xA3Z7Z3ZxAr4vkF4UKF1rCryrCr98A34fZrykZFn5G3s0kr4UWa9rWr47
	uFW7Xr43ArZxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/2 22:00, Jan Kara wrote:
> On Tue 01-07-25 21:06:26, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Since ext4 supports large folios, processing writebacks in pages is no
>> longer appropriate, it can be modified to process writebacks in bytes.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Just one small issue. With that fixed feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> @@ -2786,18 +2788,18 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>>  		writeback_index = mapping->writeback_index;
>>  		if (writeback_index)
>>  			cycled = 0;
>> -		mpd->first_page = writeback_index;
>> -		mpd->last_page = -1;
>> +		mpd->start_pos = writeback_index << PAGE_SHIFT;
>> +		mpd->end_pos = -1;
> 
> Careful here. Previously last_page was unsigned long so -1 was fine but now
> loff_t is signed. So we should rather store LLONG_MAX here.
> 
> 									Honza

Ha, right! Sorry for missed this corner, will fix.

Thanks,
Yi.


