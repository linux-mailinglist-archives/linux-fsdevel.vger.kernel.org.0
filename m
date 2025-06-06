Return-Path: <linux-fsdevel+bounces-50794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CCAACFABB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0377A3CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974933086;
	Fri,  6 Jun 2025 01:32:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DCC8460;
	Fri,  6 Jun 2025 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749173520; cv=none; b=Wc5ivkBc6m7DI1bufKr5iP1zMsuCtTpwgO0VjcmtJKFWsSOXYjsPuxP8NV/NLnNW2CaoY/2V4kLi5/2PdJsdMkfp2WwpWHWO9tM6Vq6nT8o9xmfkjUMm4VQzrH/9Ttc0YUfHS+E9optw5dq2rQfym1AX1Oy///i8Y56hZpGgwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749173520; c=relaxed/simple;
	bh=6CayD2KNOzUUrDpwR3Wod86n8V1t5zRMUINRHoPfNi8=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mpcC4VESwSXfUrDA6bAZcXnJ+TqFiQ8HQd4c/oVBoDVzYJURMMXRElHMzgY6WNHzRg60XrBCMExx2HrZNFBIaPrhVxMyYGDN2PpUmlzV+9VnWy7a29lV+J3NhEGsRLqnhN0fZaFBlM03OQno/wIYnUc5DUQEBnqtDw9bw28U8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bD3hD466mzKHN3X;
	Fri,  6 Jun 2025 09:31:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E956E1A1B4C;
	Fri,  6 Jun 2025 09:31:54 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP2 (Coremail) with SMTP id Syh0CgAXIGMJRUJoj9AWOg--.42789S2;
	Fri, 06 Jun 2025 09:31:54 +0800 (CST)
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-2-shikemeng@huaweicloud.com>
 <20250605125724.d2e3db9c23af7627a53d8914@linux-foundation.org>
 <721923ac-4bb1-1b2b-fce5-9d957c535c97@huaweicloud.com>
Message-ID: <46bcdc15-02d6-2113-98e6-0578361f125b@huaweicloud.com>
Date: Fri, 6 Jun 2025 09:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <721923ac-4bb1-1b2b-fce5-9d957c535c97@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXIGMJRUJoj9AWOg--.42789S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1DKF4fZF1fKr45AFyDAwb_yoW8Gry3pr
	y7AasYyFs7GryIkFn2qr97ur1Sga97GF40q3WrZr13Ca45Xr9rtF4jyry5u3W3C34xJw4Y
	vF1qkF9rXrW7XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/6/2025 9:11 AM, Kemeng Shi wrote:
> 
> 
> on 6/6/2025 3:57 AM, Andrew Morton wrote:
>> On Fri,  6 Jun 2025 06:10:31 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>>> As noted in the comments, we need to release block usage for swap entry
>>> which was replaced with poisoned swap entry. However, no block usage is
>>> actually freed by calling shmem_recalc_inode(inode, -nr_pages, -nr_pages).
>>> Instead, call shmem_recalc_inode(inode, 0, -nr_pages) can correctly release
>>> the block usage.
>>>
>>> ...
>>>
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>>  	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>>>  	 * in shmem_evict_inode().
>>>  	 */
>>> -	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
>>> +	shmem_recalc_inode(inode, 0, -nr_pages);
>>>  	swap_free_nr(swap, nr_pages);
>>>  }
>>
>> Huh, three years ago.  What do we think might be the userspace-visible
>> runtime effects of this?
> This could trigger WARN_ON(i_blocks) in shmem_evict_inode() as i_blocks
> is supposed to be dropped in the quota free routine.
Besides, the leak of block usage will reduce the available space to user.
As the amount of leakage accumulates over time, the available space may
eventually be exhausted.
>>
>>


