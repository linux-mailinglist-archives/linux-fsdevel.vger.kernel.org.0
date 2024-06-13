Return-Path: <linux-fsdevel+bounces-21616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B29067D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D7F2892CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FBF1422D8;
	Thu, 13 Jun 2024 08:51:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716054757;
	Thu, 13 Jun 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268687; cv=none; b=sufW5G2jd2W9ZiYfUh+k7zJEVhu8GHukGxNhls90Z6+yRNj4uOXO/+w/UiO19HAzmdS3FOl/aQ3EdL8YhcXheJAD4LdtHL11iqlU6f9jDLyXazwV1FkSnZ5lgymymHivhIdXRP8Jg/WldHOVIcQsW7+95lOb8mot/biAupKP1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268687; c=relaxed/simple;
	bh=ZuIrvdnCdC66P2/Oy3B5qDyUCS1nfb1dhtDgdHKG57Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZPX1YwM8EKJEueiJIGoTeIjPF6jcTOcdQLvn+vbOAsTSPQOjMTPq3a5yYsINN2RBWKI8jDIX6kSmR7dlu+qcnkBdg8Ny/5Itd/J0hF179k263OGxf3+ZbXOQLLaPhlRXnejRAFo2xRCb66O4wf40ViMnMPTypc+iGJA6hIKUOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W0GNJ0bPqz4f3jLy;
	Thu, 13 Jun 2024 16:51:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 28A7E1A0181;
	Thu, 13 Jun 2024 16:51:22 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgAnM5sIs2pmo8qMPA--.64899S2;
	Thu, 13 Jun 2024 16:51:22 +0800 (CST)
Subject: Re: [PATCH v3] writeback: factor out balance_wb_limits to remove
 repeated code
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240606033547.344376-1-shikemeng@huaweicloud.com>
 <20240611145256.41a857beb521df61cff1695a@linux-foundation.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <8c896957-7728-ff4b-09ee-f13d5c8e8ede@huaweicloud.com>
Date: Thu, 13 Jun 2024 16:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240611145256.41a857beb521df61cff1695a@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnM5sIs2pmo8qMPA--.64899S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF17Zr4Uur4UZF43CF1xXwb_yoW8tr1rpF
	Z2ya1jyr4DJF4fXrnxAay7Z34aqrs7GF43Cry7Jws3tr43Kr1xKFyfWr40gFW7Cr9rG345
	Zr4Dtas7Gw1FvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/12/2024 5:52 AM, Andrew Morton wrote:
> On Thu,  6 Jun 2024 11:35:47 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> Factor out balance_wb_limits to remove repeated code
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  mm/page-writeback.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index bf050abd9053..f611272d3c5b 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -1783,6 +1783,21 @@ static inline void wb_dirty_exceeded(struct dirty_throttle_control *dtc,
>>  		((dtc->dirty > dtc->thresh) || strictlimit);
>>  }
>>  
>> +/*
>> + * The limits fileds dirty_exceeded and pos_ratio won't be updated if wb is
>> + * in freerun state. Please don't use these invalid fileds in freerun case.
> 
> s/fileds/fields/.  I queued a fix for this.
Thanks for fixing this.
> 
>> + */
>> +static void balance_wb_limits(struct dirty_throttle_control *dtc,
>> +			      bool strictlimit)
>> +{
>> +	wb_dirty_freerun(dtc, strictlimit);
>> +	if (dtc->freerun)
>> +		return;
>> +
>> +	wb_dirty_exceeded(dtc, strictlimit);
>> +	wb_position_ratio(dtc);
>> +}
>> +
>>  /*
>>   * balance_dirty_pages() must be called by processes which are generating dirty
>>   * data.  It looks at the number of dirty pages in the machine and will force
>> @@ -1869,12 +1884,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>>  		 * Calculate global domain's pos_ratio and select the
>>  		 * global dtc by default.
>>  		 */
>> -		wb_dirty_freerun(gdtc, strictlimit);
>> +		balance_wb_limits(gdtc, strictlimit);
>>  		if (gdtc->freerun)
>>  			goto free_running;
> 
> Would it be neater to do
> 
> 		if (balance_wb_limits(...))
> 			goto free_running;
> 
> ?
Here are two reasons why I retrieve freerun info from dtc:
1. Retrieve freerun and other calculated info from balance_domain_limits and
balance_wb_limits in the same way. Personly think it's cleaner.
2. It's more clear that we stop to limit pages because of freerun state of
wb.
> 
> That would require a balance_wb_limits() comment update and probably
> name change.  Just a thought.
> 
> 


