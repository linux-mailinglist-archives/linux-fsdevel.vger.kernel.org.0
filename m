Return-Path: <linux-fsdevel+bounces-18788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADA18BC5A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B12B1C213DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645C3D967;
	Mon,  6 May 2024 01:53:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE767381AA;
	Mon,  6 May 2024 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714960436; cv=none; b=pM2a2qVYq/jgs4TKd4/kvylO1SeT48DIwZTau1WjB1W7zu87nEMdrkg7s3iPh/7boJHT9VgchEcAWt6WZEO0Zal6f4I0UMlfQbG2JYnPamw8DLCHPJyimc7qf+7wIe2gru0dLcI0YF8pf+dlmeE+Y1OHc17JusL8v8Avha5Xwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714960436; c=relaxed/simple;
	bh=0Um1bTmzq570K8fqlUnlNkRzwnus3K7KRW4iXzYpgLc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jonz3Set6xJb/Mv9rzyPMlI8n0SeiU+/vBeVZsZHjarwle8BAyWjn7or+FIsNCYFwNQjI+7NRHY7sWqV5MpTJn8KrcZCq5v6QoNMmWTDspcYlcSbp00v6TIDdEkXJyfoViD91t2IoZdE2rwN2VO042mbzVgnnEQRHfJq/1hFIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXkw65L7Xz4f3kjW;
	Mon,  6 May 2024 09:53:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E63811A1013;
	Mon,  6 May 2024 09:53:50 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgDX3JQtODhmtM3MLg--.56156S2;
	Mon, 06 May 2024 09:53:50 +0800 (CST)
Subject: Re: [PATCH 07/10] writeback: factor out wb_dirty_freerun to remove
 more repeated freerun code
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-8-shikemeng@huaweicloud.com>
 <ZjJ5gfIXBmpKMj9c@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7fecbde8-d4b8-c733-847e-a760efb41571@huaweicloud.com>
Date: Mon, 6 May 2024 09:53:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjJ5gfIXBmpKMj9c@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDX3JQtODhmtM3MLg--.56156S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW3XF4kWFy8AFW5Jr45trb_yoWkWwc_Ca
	n0gry7C3yUJa1DGa47GFWfZFZ8Wa4xXry7Xr1jqw1DWay8JF4kWa43WrZ5CF1xGw48t3sx
	Cwnxta1kZ3429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


Hello,
on 5/2/2024 1:18 AM, Tejun Heo wrote:
> On Mon, Apr 29, 2024 at 11:47:35AM +0800, Kemeng Shi wrote:
> ...
>> +static void wb_dirty_freerun(struct dirty_throttle_control *dtc,
>> +			     bool strictlimit)
>> +{
> ...
>> +	/*
>> +	 * LOCAL_THROTTLE tasks must not be throttled when below the per-wb
>> +	 * freerun ceiling.
>> +	 */
>> +	if (!(current->flags & PF_LOCAL_THROTTLE))
>> +		return;
> 
> Shouldn't this set free_run to true?
Originally, we will go freerun if PF_LOCAL_THROTTLE is set and number of dirty
pages is under freerun ceil. So if PF_LOCAL_THROTTLE is *not* set, freerun
should be false. Maybe I miss something and please correct me, Thanks.
> 
> Also, wouldn't it be better if these functions return bool instead of
> recording the result in dtc->freerun?
As I try to factor out balance_wb_limits to calculate freerun, dirty_exceeded
and position ratio of wb, so wb_dirty_freerun and wb_dirty_exceeded will be
called indirectly and balance_dirty_pages has to retrieve freerun and
dirty_exceeded from somewhere like dtc where position ratio is retrieved.
Would like to know any better idea.
Thanks.
> 
> Thanks.
> 


