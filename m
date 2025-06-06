Return-Path: <linux-fsdevel+bounces-50792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ABAACFA9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DC37A1FF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50542A8D0;
	Fri,  6 Jun 2025 01:11:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C923DF5C;
	Fri,  6 Jun 2025 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749172306; cv=none; b=cLfEquInmPBpCDmkyYOhCpfAItOlk0JZMMLuV6huxJ0NDXCJabQbmtpeRflHaj0uyonsWRzk+EnkdUkbNGWwZkMc2IZVDuGSnNaqVlic8fzeBfpQYXKdDo8J91RZe/x8c482rxYJl6w2znR/IcNRfluO1Pnk5wdqfW8Vx/1VGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749172306; c=relaxed/simple;
	bh=Ng97a+IaTRbBbYWYbDD6AuQ8DmFmzD18hIzZD+c8ipM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=up0k7fq4qek5/mzMrFTnBf2iMFjJkOE47SmeGtBa0emZIWwnx4J1T+PlAeNXTSzs5L8XTLWXgTc4G7nZ0tcxCHsYRggmGai/uyb/6MNAveBWteSlO2epZd7MAyAhShV7GM8P9aFS+zs3q10tW5U0V7gAT6H/9epVgWiu+1iU5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bD3Ds1VgkzKHMyD;
	Fri,  6 Jun 2025 09:11:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 91A711A0D27;
	Fri,  6 Jun 2025 09:11:39 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP3 (Coremail) with SMTP id _Ch0CgBnB8JJQEJotWmmOQ--.56805S2;
	Fri, 06 Jun 2025 09:11:39 +0800 (CST)
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-2-shikemeng@huaweicloud.com>
 <20250605125724.d2e3db9c23af7627a53d8914@linux-foundation.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <721923ac-4bb1-1b2b-fce5-9d957c535c97@huaweicloud.com>
Date: Fri, 6 Jun 2025 09:11:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250605125724.d2e3db9c23af7627a53d8914@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnB8JJQEJotWmmOQ--.56805S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1rtw48Jw48uFWDXw1rCrg_yoWkXrc_XF
	4Iv39rCFW8XFsrAa1DXw4SqFZYka1kur4qvrW3JF92vryYq3WDCrnrXrySyryxXa1UKFZx
	Cwn3X3W5KFyj9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/6/2025 3:57 AM, Andrew Morton wrote:
> On Fri,  6 Jun 2025 06:10:31 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> As noted in the comments, we need to release block usage for swap entry
>> which was replaced with poisoned swap entry. However, no block usage is
>> actually freed by calling shmem_recalc_inode(inode, -nr_pages, -nr_pages).
>> Instead, call shmem_recalc_inode(inode, 0, -nr_pages) can correctly release
>> the block usage.
>>
>> ...
>>
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>  	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>>  	 * in shmem_evict_inode().
>>  	 */
>> -	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
>> +	shmem_recalc_inode(inode, 0, -nr_pages);
>>  	swap_free_nr(swap, nr_pages);
>>  }
> 
> Huh, three years ago.  What do we think might be the userspace-visible
> runtime effects of this?
This could trigger WARN_ON(i_blocks) in shmem_evict_inode() as i_blocks
is supposed to be dropped in the quota free routine.
> 
> 


