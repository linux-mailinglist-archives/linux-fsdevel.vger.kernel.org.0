Return-Path: <linux-fsdevel+bounces-14944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ABB881BA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 04:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924A9B21736
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 03:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100CBA46;
	Thu, 21 Mar 2024 03:45:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6576D39;
	Thu, 21 Mar 2024 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992736; cv=none; b=mCF+ZtsLeiCdvnxC27nCHsHiWyMFyBRP5oQdD0ukv2uNeOipvuJDeWsMbvId7/s9nGWz6fiWxuY0tEn+NmJa2NZtmEpEh8Xa8AYmoLlig/kCqttdKJMV4hQM5ocfluleLguKecai9kXr7efVyV/Lci/+E9qHZRMDBOeF2bgQRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992736; c=relaxed/simple;
	bh=NHjn5I2E8OUKAyyvwBV0GVI+3EQB1r6fWHAfZDjadSM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W4hNK1umG+2dONgIj4if1XQRsOzWUzRumOZwQ3UVWWWLJ51IFyhgb6+px+NU6SwIAJPSZCnZi75ZfDF0ztkAn2Of1qGLcCj7c6Sq91oGBQfjDM6jDEW1Lkq65R0VnbjOeLDwkJJGKRh9fzHeZ3nRHtIMKONeHZirTfzT4Yw4lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V0WZD4qL6z4f3jHt;
	Thu, 21 Mar 2024 11:45:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AD7191A0C84;
	Thu, 21 Mar 2024 11:45:30 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgC3w5tZrftlDzDuHQ--.36010S2;
	Thu, 21 Mar 2024 11:45:30 +0800 (CST)
Subject: Re: [PATCH 2/6] writeback: support retrieving per group debug
 writeback stats of bdi
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, bfoster@redhat.com, jack@suse.cz, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-3-shikemeng@huaweicloud.com>
 <Zfr6QV-2IWD6yCI1@mtj.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <956133f9-f758-002f-64a3-4c44d4bd04d5@huaweicloud.com>
Date: Thu, 21 Mar 2024 11:45:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zfr6QV-2IWD6yCI1@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3w5tZrftlDzDuHQ--.36010S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF48WF4kGF4DXF1fWFyUJrb_yoW3Xrc_u3
	y5Ar4kuFsxXF1kW3WxZFn8JrZ8K3ykWF17ZanYqryDtFn5AFZ5ZryfWFZrJ347K3WrZFnI
	93Z3Xw47Wr4DujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UQzVbUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/20/2024 11:01 PM, Tejun Heo wrote:
> On Wed, Mar 20, 2024 at 07:02:18PM +0800, Kemeng Shi wrote:
>> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
>> index 9845cb62e40b..bb1ce1123b52 100644
>> --- a/include/linux/writeback.h
>> +++ b/include/linux/writeback.h
>> @@ -355,6 +355,7 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
>>  
>>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
>>  unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
>> +unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb);
> 
> Would cgwb_calc_thresh() be an easier name?
> 
Sure, will rename it in next version. Thansk!
> Thanks.
> 


