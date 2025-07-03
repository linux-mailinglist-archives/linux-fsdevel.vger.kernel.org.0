Return-Path: <linux-fsdevel+bounces-53802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F4AF76FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF71893EE1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BC2E88AB;
	Thu,  3 Jul 2025 14:14:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A082D5418;
	Thu,  3 Jul 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552040; cv=none; b=Y6nlH8J/OBkXzshUYWBf34iX2m734KEJ5pgAARtT3z7dWTnTy8cYVbyXDH6X5dZCV4ueZux66SEM1PZiNWQXkUSa73PJHXO9hhbERzDbBhBWLqVyGxv8PI4wAlqCNFdbIGNMXhN2QL6G67Z+/05se8rUHf0V3/UO1JoLRJeVMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552040; c=relaxed/simple;
	bh=jYa0ElrOwg3E30m7l7Nw6tKSbtT2mPC05vfYnMLOo4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyVqQV4td19MX6b3V4SclwLedlszhobjetCacf3in47A7NfXYVrOK4g9YFAtE1jW1M3nhHwzxqIIeBhecWAPqKIZcVNCsjrXdPoSXmV3TIH32+Eg6EHKDOt/JWxte8n57jD+DPIEtdQDwzKMH/LY3BGwMvW8wIA3s9ufcdm/qLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bXzJz0DsgzYQtrH;
	Thu,  3 Jul 2025 22:13:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D8C491A108E;
	Thu,  3 Jul 2025 22:13:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgAHaCUfkGZoidghAg--.13097S3;
	Thu, 03 Jul 2025 22:13:53 +0800 (CST)
Message-ID: <a6225180-9983-4a0a-8898-435b014b8ebe@huaweicloud.com>
Date: Thu, 3 Jul 2025 22:13:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
To: Theodore Ts'o <tytso@mit.edu>, "D, Suneeth" <Suneeth.D@amd.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
 <f59ef632-0d11-4ae7-bdad-d552fe1f1d78@amd.com>
 <94de227e-23c1-4089-b99c-e8fc0beae5da@huaweicloud.com>
 <20250626145647.GA217371@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250626145647.GA217371@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAHaCUfkGZoidghAg--.13097S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr17uFWkWFyDGr4rJw4DXFb_yoW5XFyxpF
	WakFn7AFnxXw4xAwn7Gw1kZr9Iy3s5XFW3G3Z5GryjvwnxGF4S9FW0qas5uFW7GrWUX3WI
	qw4jv343Z3W5XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/26 22:56, Theodore Ts'o wrote:
> On Thu, Jun 26, 2025 at 09:26:41PM +0800, Zhang Yi wrote:
>>
>> Thanks for the report, I will try to reproduce this performance regression on
>> my machine and find out what caused this regression.
> 
> I took a quick look at this, and I *think* it's because lmbench is
> measuring the latency of mmap read's --- I'm going to guess 4k random
> page faults, but I'm not sure.  If that's the case, this may just be a
> natural result of using large folios, and the tradeoff of optimizing
> for large reads versus small page faults.
> 
> But if you could take a closer look, that would be great, thanks!
> 

After analyzing what the lmbench mmap test actually does, I found that
the regression is related to the mmap writes, not mmap reads. In other
words, the latency increases in ext4_page_mkwrite() after we enable
large folios.

The lmbench mmap test performed the following two tests:
1. mmap a range with PROT_READ|PROT_WRITE and MAP_SHARED, and then
   write one byte every 16KB sequentially.
2. mmap a range with PROT_READ and MAP_SHARED, and then read byte
   one by one sequentially.

For the mmap read test, the average page fault latency on my machine
can be improved from 3,634 ns to 2,005 ns. This improvement is due to
the ability to save the folio readahead loop in page_cache_async_ra()
and the set PTE loop in filemap_map_pages() after implementing support
for large folios.

For the mmap write test, the number of page faults does not decrease
due to the large folio (the maximum order is 5), each page still
incurs one page fault. However, the ext4_page_mkwrite() does multiple
iterations through buffer_head in the folio, so the time consumption
will increase. The latency of ext4_page_mkwrite() can be increased
from 958ns to 1596ns.

After looking at the comments in finish_fault() and 43e027e414232
("mm: memory: extend finish_fault() to support large folio").

vm_fault_t finish_fault(struct vm_fault *vmf)
{
	...
	nr_pages = folio_nr_pages(folio);

	/*
	 * Using per-page fault to maintain the uffd semantics, and same
	 * approach also applies to non-anonymous-shmem faults to avoid
	 * inflating the RSS of the process.
	 */
	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
	    unlikely(needs_fallback)) {
		nr_pages = 1;
	...
	set_pte_range(vmf, folio, page, nr_pages, addr);
}

I believe this regression can be resolved if the finish_fault()
supports file-based large folios, but I'm not sure if we are planning
to implement this.

As for ext4_page_mkwrite(), I think it can also be optimized by reducing
the number of the folio iterations, but this would make it impossible to
use existing generic helpers and could make the code very messy.

Best regards,
Yi.


