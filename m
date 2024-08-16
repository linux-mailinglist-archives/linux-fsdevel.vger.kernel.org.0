Return-Path: <linux-fsdevel+bounces-26089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150E953F08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 03:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5BB23606
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2729CEF;
	Fri, 16 Aug 2024 01:44:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922E1DFFC;
	Fri, 16 Aug 2024 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772652; cv=none; b=kdfgY68/c0T/W099OOhHT7ORf5nVVlKK1kc+t2hbQppi/e3YYk/+zn8v3S4QAxAujEQaguEdIxvrPNyIVyPfutepmchBAigY8fFv0bI1f+Tr2vKJNPGM61418KiC3wwSY6syJ5JgBPy/ny69aItsnM1Zu+IsxsDAyH+Z1SS2UbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772652; c=relaxed/simple;
	bh=XJp+Jb3dve6kiWKebsssb6P1PqxlbemB2ygfIkOkhs8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eQfdw8c7lySJkMEn8BkD4A80VDPkhq10uZsP3/78pFq38+FoX/sbH9feeFN2Xw1fwRyCrDteUSNfd3sawr7tQMfdLdw3mn/pr25BPeoO5Legpotdaljmhw9lwNVTgs063dHA9ESQAIT0zaTinpW+EngIcGGlsyypM1PIY+4id4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WlPsh1Fswz4f3jsD;
	Fri, 16 Aug 2024 09:43:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 092791A0568;
	Fri, 16 Aug 2024 09:44:06 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHboTkrr5miBBBBw--.52648S3;
	Fri, 16 Aug 2024 09:44:05 +0800 (CST)
Subject: Re: [PATCH v2 3/6] iomap: advance the ifs allocation if we have more
 than one blocks per folio
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
 <ZrxBfKi_DpThYo94@infradead.org>
 <b098d15b-4b80-2b73-d05b-f4dbb5d4631a@huaweicloud.com>
 <Zr2Zd-fjb96D3ZQi@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <ff66af8c-2b56-aa72-2470-00ff097fc6a6@huaweicloud.com>
Date: Fri, 16 Aug 2024 09:44:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zr2Zd-fjb96D3ZQi@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHboTkrr5miBBBBw--.52648S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW3ArWxZFy3XrWrKr15Jwb_yoWxAFc_uF
	4v9r4kur95Way5A3W2g3Z8JrZagrZ0yF18XrZ8GFZ3Wa98Aa9aqr1vkrZYvFy2yFZF9Fnx
	WFy2gay5XryagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/15 14:00, Christoph Hellwig wrote:
> On Wed, Aug 14, 2024 at 03:08:25PM +0800, Zhang Yi wrote:
>>> iomap_invalidate_folio when it actually is needed?
>>>
>>
>> Therefore, you mean current strategy of allocating ifs is to try to delay
>> the allocation time as much as possible?
> 
> Yes.
> 
>> The advantage is that it could
>> avoid some unnecessary allocation operations if the whole folio are
>> invalidated before write back. right?
> 
> Yes.  And hopefully we can also get to the point where we don't need
> to actually allocate it for writeback.  I've been wanting to do that
> for a while but never got it.
> 

Yeah, this sounds like a good idea.

Thanks,
Yi.


