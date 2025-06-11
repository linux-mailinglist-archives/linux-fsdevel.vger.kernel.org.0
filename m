Return-Path: <linux-fsdevel+bounces-51264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AFDAD4F77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A601BC1853
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6F825C81B;
	Wed, 11 Jun 2025 09:11:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031C253F07;
	Wed, 11 Jun 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633092; cv=none; b=i2PnRlqBWeCggnI7/XAdK9RJEUc/7ho3LiyxFG2Cv8sJqWK6i5em/C/CBjJ/ZZOtldi0pcT6KSS5Lry0GW2+MSFRpIP2p/mbqrdyj+kVkCW/RsEPKO9ndyqhnieXWtYtYWwJoU02023jdY7oKptcmpTmQMBLN27zalnoYfkq4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633092; c=relaxed/simple;
	bh=pPdhZLFx81a99NKMs06K1RMlQsaeMNKweZjfjEfJL7w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OmYpOQDlyyZhN84mxNRYlWP1z+It/6sUv46wiXQuNDZI+S6ecQg2bV7Hcdpjh/QiSe2fVCkFrjDOGrqqPIYbwaeY+6SHjR0e/1QH9k7ELQ6+PTq+KcErw9WkDVHjmIfoG1PweJrZOp8pmLS5XOacRnkpqbFaiG/N0nyF1Y46kNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bHKf74jCHzYQvrH;
	Wed, 11 Jun 2025 17:11:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A39201A0ED6;
	Wed, 11 Jun 2025 17:11:26 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP4 (Coremail) with SMTP id gCh0CgAniFw7SEloD7+1PA--.34437S2;
	Wed, 11 Jun 2025 17:11:24 +0800 (CST)
Subject: Re: [PATCH 2/7] mm: shmem: avoid setting error on splited entries in
 shmem_set_folio_swapin_error()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-3-shikemeng@huaweicloud.com>
 <c05b8612-83a6-47f7-84f8-72276c08a4ac@linux.alibaba.com>
 <100d50f3-95df-86a3-7965-357d72390193@huaweicloud.com>
 <24580f79-c104-41aa-bbdb-e1ce120c28a0@linux.alibaba.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <93336040-f457-d8a1-29df-f737efa8261c@huaweicloud.com>
Date: Wed, 11 Jun 2025 17:11:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <24580f79-c104-41aa-bbdb-e1ce120c28a0@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAniFw7SEloD7+1PA--.34437S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1UArW5uF17Jw17Ar4DCFg_yoW8KryfpF
	WUK3Z5KF4kJrWIkr1ktw18tryY934rWr1Uta93Cr43A3ZFqrn8KryrWr1Uua47AryDGr10
	qF12qas7Xas0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



on 6/11/2025 3:41 PM, Baolin Wang wrote:
> 
> 
> On 2025/6/9 09:19, Kemeng Shi wrote:
>>
>>
>> on 6/7/2025 2:20 PM, Baolin Wang wrote:
>>>
>>>
>>> On 2025/6/6 06:10, Kemeng Shi wrote:
>>>> When large entry is splited, the first entry splited from large entry
>>>> retains the same entry value and index as original large entry but it's
>>>> order is reduced. In shmem_set_folio_swapin_error(), if large entry is
>>>> splited before xa_cmpxchg_irq(), we may replace the first splited entry
>>>> with error entry while using the size of original large entry for release
>>>> operations. This could lead to a WARN_ON(i_blocks) due to incorrect
>>>> nr_pages used by shmem_recalc_inode() and could lead to used after free
>>>> due to incorrect nr_pages used by swap_free_nr().
>>>
>>> I wonder if you have actually triggered this issue? When a large swap entry is split, it means the folio is already at order 0, so why would the size of the original large entry be used for release operations? Or is there another race condition?
>> All issues are found during review the code of shmem as I menthioned in
>> cover letter.
>> The folio could be allocated from shmem_swap_alloc_folio() and the folio
>> order will keep unchange when swap entry is split.
> 
> Sorry, I did not get your point. If a large swap entry is split, we must ensure that the corresponding folio is order 0.
> 
> However, I missed one potential case which was recently fixed by Kairui[1].
> 
> [1] https://lore.kernel.org/all/20250610181645.45922-1-ryncsn@gmail.com/
> 
Here is a possible code routine which I think could trigger the issue:
shmem_swapin_folio          shmem_swapin_folio
folio = swap_cache_get_folio()
order = xa_get_order(&mapping->i_pages, index);
if (!folio)
 ...
 /* suppose large folio allocation is failed, we will try to split large entry */
 folio = shmem_swap_alloc_folio(..., order, ...)

                            folio = swap_cache_get_folio()
                            order = xa_get_order(&mapping->i_pages, index);
                            if (!folio)
                             ...
                             /* suppose large folio allocation is successful this time */
                             folio = shmem_swap_alloc_folio(..., order, ...)
                            ...
                            /* suppose IO of large folio is failed, will set swapin error later */
                            if (!folio_test_uptodate(folio)) {
                             error = -EIO;
                             goto failed:
                            }

 ...
 shmem_split_large_entry()

                            ...
                            shmem_set_folio_swapin_error(..., folio, ...)


