Return-Path: <linux-fsdevel+bounces-25886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67DA9514FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91761C22484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE5013A87C;
	Wed, 14 Aug 2024 07:08:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1CA27446;
	Wed, 14 Aug 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619314; cv=none; b=idYtXZPFc5OwY5IWX7oCtZ38DOOwQ7k38eo8De56q+EcnNFLkKLbU3v88Y6qNLZNJo8Vl9SfGUAnN67vXVZvOU/pkcVAiVTWQ8/XBaiYxtVucWubpyKbakemS0GXok8T2gYF6Tc3UMyXLxbG9GIY6epR1TzhTafAVefojlExMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619314; c=relaxed/simple;
	bh=Gm3F+nnI84YxUt6gJumvaW5Wn1prq0qr+MJe9fRtBbU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IayDNOCBKBZ5APiu8/CizdzqmRcvKqHMf3gbigOj07LqeZCEE20K/FQcNtYiVITYmILZb5aCgPyfmEvJKfw8YDv8acmXvu5DGoCEIrsaKURlVkqfaqoCHEHT/Npr96KTCsQCL7cQsIMiq3vm2AQuMyZTpQAbMrY/dkq8kSUK/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WkK8y1j2dz4f3jZL;
	Wed, 14 Aug 2024 15:08:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8E2EC1A1537;
	Wed, 14 Aug 2024 15:08:27 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXzILpV7xmHJyaBg--.14959S3;
	Wed, 14 Aug 2024 15:08:27 +0800 (CST)
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
Message-ID: <b098d15b-4b80-2b73-d05b-f4dbb5d4631a@huaweicloud.com>
Date: Wed, 14 Aug 2024 15:08:25 +0800
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
X-CM-TRANSID:gCh0CgBXzILpV7xmHJyaBg--.14959S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw47uF4UJF4kKr1xtw47Arb_yoW8JFyfpF
	WxKa15Gr48tF1fZ3srXayUXr1rK3yfJrW3GFZIq3W29anxGr1a9F1qg3Z0ga47JrnrJF48
	Xr47Xa4xGFy5Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
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

Therefore, you mean current strategy of allocating ifs is to try to delay
the allocation time as much as possible? The advantage is that it could
avoid some unnecessary allocation operations if the whole folio are
invalidated before write back. right?

> Also do you have a reproducer for this?
> 

This mistake doesn't case any real problem now, because once the folio
has been partial truncated, the counterpart range becomes a hole, although
the ifs dirty bit is not cleared, iomap_writepage_map_blocks() can deal
with it and won't cause any problem. Hence I don't have reproducer for
this.

Thanks,
Yi.


