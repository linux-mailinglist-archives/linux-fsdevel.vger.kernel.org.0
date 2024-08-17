Return-Path: <linux-fsdevel+bounces-26169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD6955558
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 06:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B92853AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDCC7F484;
	Sat, 17 Aug 2024 04:27:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026091E52C;
	Sat, 17 Aug 2024 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723868879; cv=none; b=NOXg+567X4sON4KHVvgYWebMTlKrkdq52KnPoVjcqirmm0zQv+Z1xKTNRirGFLnHuoI9Yo7JdyGHmvofXRaHySnX2D8OHoaKRdnAd0DA6TARXn+wbUW5LXujF3JtVezM2q2vSqi5K3VyEVVNX9LDfalR0Xyfq3GHwfWEAo+CSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723868879; c=relaxed/simple;
	bh=ZrCa4r6Sg6v/CR/ysHT8GIMNebnmNaigKsm4TEayycE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YA5zD0svJteTR3WTsZ95RWY+3eIJECusO4hFtPeNOSGthm8e415dRA5jxDkF59Srnk+kem9/4E+KCDh5PGyTHGdeGOof+i+CSSjMvglnoUlbI4EBi20Z/ef61UKYDhcA082H+SQQvopXBU/DSpTMo/nXWY+cmtRNgjcutiG+v14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wm5S91Lxmz4f3jHc;
	Sat, 17 Aug 2024 12:27:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1D4FE1A018D;
	Sat, 17 Aug 2024 12:27:51 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTFJsBmJiWpBw--.34678S3;
	Sat, 17 Aug 2024 12:27:50 +0800 (CST)
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
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <58d9c752-1b40-0af8-370c-cf03144c54c0@huaweicloud.com>
Date: Sat, 17 Aug 2024 12:27:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZrxBfKi_DpThYo94@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoTFJsBmJiWpBw--.34678S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw47uF4UJF4kKFWDury8Xwb_yoW8JFWfpF
	9rKr1DGFW8Cay7uF9rZay7Zw1Y9343GFyUGFsaq3WakFn7t347K3W2ga4jkay7Gw1kAr4F
	q3y7XrZ7WFy5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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

On 2024/8/14 13:32, Christoph Hellwig wrote:
> On Mon, Aug 12, 2024 at 08:11:56PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Now we allocate ifs if i_blocks_per_folio is larger than one when
>> writing back dirty folios in iomap_writepage_map(), so we don't attach
>> an ifs after buffer write to an entire folio until it starts writing
>> back, if we partial truncate that folio, iomap_invalidate_folio() can't
>> clear counterpart block's dirty bit as expected. Fix this by advance the
>> ifs allocation to __iomap_write_begin().
> 
> Wouldn't it make more sense to only allocate the ifѕ in
> iomap_invalidate_folio when it actually is needed?
> 

I forget to mention that truncate_inode_partial_folio() call
folio_invalidate()->iomap_invalidate_folio() only when the folio has
private, if the folio doesn't has ifs, the iomap_invalidate_folio()
would nerver be called, hence allocate the ifs in
iomap_invalidate_folio() is useless.

In my opinion, one solution is change to always call folio_invalidate()
in truncate_inode_partial_folio(), all callbacks should handle the no
private case. Another solution is add a magic (a fake ifs) to
folio->private and then convert it to a real one in
iomap_invalidate_folio(), any thoughts?

Thanks,
Yi.


