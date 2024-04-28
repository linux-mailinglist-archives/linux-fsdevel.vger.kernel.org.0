Return-Path: <linux-fsdevel+bounces-17996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF5A8B4963
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DDA1C20C33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 03:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7282907;
	Sun, 28 Apr 2024 03:26:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805A1854;
	Sun, 28 Apr 2024 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714274768; cv=none; b=G6dXRwcGYpbq7VjpHEHxBHdBvi91ywGeY9JAfksdv480mJ01k6X0JRAwyhOM7xaHbR1qYVo/oKVURosohX2RLodTTtWMCQ9fULgbooM5U+Q8dICqqgoS6FhIuMfSbgRCpcbJfVKoqlk3ohUUJeWBjF0Y8kHnULMNy9DWXq15+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714274768; c=relaxed/simple;
	bh=dRbYW5r1aha79uQUUDDP7FX0PER5xuIeZ/k7nBZKlQs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cmY6WszkunThFlqRB8YjiNfj6VDXTp1XdOAjMbCo4Lvi/69vvIpH0zudJ3nakWdFUKA1mlOtSnC7mJpSwDv14uqdQIoPM0sit3U4ydCRahgZc1TWViN4yOL0cwIbgQ1jdfduzl6OShJub5QBqBXZKBS9Q5D/pHsXsFj+vzSYiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VRsLF1V3tz4f3k6h;
	Sun, 28 Apr 2024 11:25:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2D14A1A0568;
	Sun, 28 Apr 2024 11:26:02 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA_IwS1m1qSpLQ--.48414S3;
	Sun, 28 Apr 2024 11:26:01 +0800 (CST)
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
 tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
 <20240425182904.GA360919@frogsfrogsfrogs>
 <3be86418-e629-c7e6-fd73-f59f97a73a89@huaweicloud.com>
 <ZitKncYr0cCmU0NG@infradead.org>
 <5b6228ce-c553-3387-dfc4-2db78e3bd810@huaweicloud.com>
 <ZiyiNzQ6oY3ZAohg@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <c4ab199e-92bf-4b22-fe41-1fca400bdc31@huaweicloud.com>
Date: Sun, 28 Apr 2024 11:26:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiyiNzQ6oY3ZAohg@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXfA_IwS1m1qSpLQ--.48414S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GryDZF1ftw1DXw47uF1UAwb_yoWDCrbEg3
	9Yv39rCr4kAa13AF45Kw15Jrs2kr1rKr1rXrZ8Xrs7JrW8AFykJas5ur93Z3y7Xa1Yyr1a
	9F9av3W7Z3sFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/27 14:59, Christoph Hellwig wrote:
> On Fri, Apr 26, 2024 at 03:18:17PM +0800, Zhang Yi wrote:
>> I've had the same idea before, I asked Dave and he explained that Linux
>> could leak data beyond EOF page for some cases, e.g. mmap() can write to
>> the EOF page beyond EOF without failing, and the data in that EOF page
>> could be non-zeroed by mmap(), so the zeroing is still needed now.
>>
>> OTOH, if we free the delalloc and unwritten blocks beyond EOF blocks, he
>> said it could lead to some performance problems and make thinks
>> complicated to deal with the trimming of EOF block. Please see [1]
>> for details and maybe Dave could explain more.
> 
> Oh well.  Given that we're full in on the speculative allocations
> we might as well deal with it.
> 

Let me confirm, so you also think the preallocations in the COW fork that
overlaps the unreflinked range is useless, we should avoid allocating
this range, is that right? If so, I suppose we can do this improvement in
another patch(set), this one works fine now.

Thanks,
Yi.


