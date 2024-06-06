Return-Path: <linux-fsdevel+bounces-21079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3E08FDD6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 05:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC7A281C83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 03:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B311DFF5;
	Thu,  6 Jun 2024 03:24:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CEF17BD8;
	Thu,  6 Jun 2024 03:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644288; cv=none; b=tm9p9mH47VbvMK7x9T6Va2vlwJ/nc4XyL3N/LiSgmyS4Se9EGL2yptI05qO663Cj7OO2Jl1QruAxeHfGQsUhxkUAFVYIfM9QYSRD+GzK1ZjQlOaUtApbuWyinZdu+w5KuCalsBULbLUojbc77NmdtsKfZhe0LIN0xvtatwjf7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644288; c=relaxed/simple;
	bh=EeTpYbZng4Y5bfpMT8WReGs6mMWFJe0SV0m03KYwY3M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FMoJE9Xnwfba+4tdw7TflACk3bvWtognmZu41hmsi+cXPK/WXzzmHo6hZSzKsJrjkL7azqY2zgKE9atQPca/CI951sCtRMzzJwp5HPq6idzi2BjjVXMydpz5diJwFvOPW3gBcQh9S9mBymnYuoB0mTcERIGqpzRETX1HC7FfTtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VvqST1C9mz4f3nKW;
	Thu,  6 Jun 2024 11:24:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 556A31A016E;
	Thu,  6 Jun 2024 11:24:36 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgAnMJjyK2Fmz2rqOQ--.40149S2;
	Thu, 06 Jun 2024 11:24:36 +0800 (CST)
Subject: Re: [PATCH v2 8/8] writeback: factor out balance_wb_limits to remove
 repeated code
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
 <20240514125254.142203-9-shikemeng@huaweicloud.com>
 <ZljGiunxmVAlW6EE@slm.duckdns.org>
 <cfbbcc80-7db1-8277-98ab-1f32c3a629ab@huaweicloud.com>
 <Zl4G0tI_0CHKIWHh@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <6d5e260e-4910-92d1-faf4-8aee0b78b16d@huaweicloud.com>
Date: Thu, 6 Jun 2024 11:24:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zl4G0tI_0CHKIWHh@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnMJjyK2Fmz2rqOQ--.40149S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyrWFW8JF4UCF43Zr4DXFb_yoW3Wwb_WF
	s29aykKw4UuFs7ta1vyF45J34xGFWrXryUZ348Way7C34fAa1UWay5WFyav3WxJr4IkF9x
	W3Z2g340kry2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/4/2024 2:09 AM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jun 03, 2024 at 02:39:18PM +0800, Kemeng Shi wrote:
>>> Isn't this a bit nasty? The helper skips updating states because it knows
>>> the caller is not going to use them? I'm not sure the slight code reduction
>>> justifies the added subtlety.
>>
>> It's a general rule that wb should not be limited if the wb is in freerun state.
>> So I think it's intuitive to obey the rule in both balance_wb_limits and it's
>> caller in which case balance_wb_limits and it's caller should stop to do anything
>> when freerun state of wb is first seen.
>> But no insistant on this...
> 
> Hmm... can you at least add comments pointing out that if freerun, the
> limits fields are invalid?
Sure, will add it in next version. Thanks
> 
> Thanks.
> 


