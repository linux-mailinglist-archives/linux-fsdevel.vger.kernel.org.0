Return-Path: <linux-fsdevel+bounces-54821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986F4B03929
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8E171B76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B89239086;
	Mon, 14 Jul 2025 08:19:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AABA238C24;
	Mon, 14 Jul 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481152; cv=none; b=sbf9IGt+9oRcDvBbzURU8veMKZmeh47Gjyb24Dp598zyUWHlgPyl9C6S7erXzCM6fzb30RmgLtD/sHDfAOQO7NSa7gZfpJfimBpGo8xk/E7vz9DO/BMrzwZFTja3JKv6c+IxkgAod7OLhi1s3EMOL9U/K8dkX9cy6jhHgQ8OtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481152; c=relaxed/simple;
	bh=5/TlKMySHoKYuxCH8czaQZG0lt92ce0eNPzW4eE5Xe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIgoJ35hQe+jVx1t/gK8hqOc7QslOHXbjQcFgWaXlLxdXQK1I3p5gzkEozE+sfjSWrPoKw0vV4g7+Rvgdq4doXhSqIlrSg5ajCsMmBRcmVzQxGWvFC6JWk0jrvy6HZhqMEiv0rxSgZtEV1IAH5WClmJpBDDsZiFVFwFCUwvdG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F4531764;
	Mon, 14 Jul 2025 01:19:00 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68C873F66E;
	Mon, 14 Jul 2025 01:19:06 -0700 (PDT)
Message-ID: <1cbef124-5576-418c-9de5-dd1bd0083c72@arm.com>
Date: Mon, 14 Jul 2025 09:19:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] mm/filemap: Allow arch to request folio size for
 exec memory
Content-Language: en-GB
To: Tao Xu <tao.xu@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250609092729.274960-1-ryan.roberts@arm.com>
 <20250609092729.274960-6-ryan.roberts@arm.com>
 <e62f4caf-57dc-445e-be29-aff324e0d444@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e62f4caf-57dc-445e-be29-aff324e0d444@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2025 16:41, Tao Xu wrote:
> On 09/06/2025 10:27, Ryan Roberts wrote:
>> Change the readahead config so that if it is being requested for an
>> executable mapping, do a synchronous read into a set of folios with an
>> arch-specified order and in a naturally aligned manner. We no longer
>> center the read on the faulting page but simply align it down to the
>> previous natural boundary. Additionally, we don't bother with an
>> asynchronous part.
>>
>> On arm64 if memory is physically contiguous and naturally aligned to the
>> "contpte" size, we can use contpte mappings, which improves utilization
>> of the TLB. When paired with the "multi-size THP" feature, this works
>> well to reduce dTLB pressure. However iTLB pressure is still high due to
>> executable mappings having a low likelihood of being in the required
>> folio size and mapping alignment, even when the filesystem supports
>> readahead into large folios (e.g. XFS).
>>
>> The reason for the low likelihood is that the current readahead
>> algorithm starts with an order-0 folio and increases the folio order by
>> 2 every time the readahead mark is hit. But most executable memory tends
>> to be accessed randomly and so the readahead mark is rarely hit and most
>> executable folios remain order-0.
>>
>> So let's special-case the read(ahead) logic for executable mappings. The
>> trade-off is performance improvement (due to more efficient storage of
>> the translations in iTLB) vs potential for making reclaim more difficult
>> (due to the folios being larger so if a part of the folio is hot the
>> whole thing is considered hot). But executable memory is a small portion
>> of the overall system memory so I doubt this will even register from a
>> reclaim perspective.
>>
>> I've chosen 64K folio size for arm64 which benefits both the 4K and 16K
>> base page size configs. Crucially the same amount of data is still read
>> (usually 128K) so I'm not expecting any read amplification issues. I
>> don't anticipate any write amplification because text is always RO.
>>
>> Note that the text region of an ELF file could be populated into the
>> page cache for other reasons than taking a fault in a mmapped area. The
>> most common case is due to the loader read()ing the header which can be
>> shared with the beginning of text. So some text will still remain in
>> small folios, but this simple, best effort change provides good
>> performance improvements as is.
>>
>> Confine this special-case approach to the bounds of the VMA. This
>> prevents wasting memory for any padding that might exist in the file
>> between sections. Previously the padding would have been contained in
>> order-0 folios and would be easy to reclaim. But now it would be part of
>> a larger folio so more difficult to reclaim. Solve this by simply not
>> reading it into memory in the first place.
>>
>> Benchmarking
>> ============
>>
>> The below shows pgbench and redis benchmarks on Graviton3 arm64 system.
>>
>> First, confirmation that this patch causes more text to be contained in
>> 64K folios:
>>
>> +----------------------+---------------+---------------+---------------+
>> | File-backed folios by|  system boot  |    pgbench    |     redis     |
>> | size as percentage of+-------+-------+-------+-------+-------+-------+
>> | all mapped text mem  |before | after |before | after |before | after |
>> +======================+=======+=======+=======+=======+=======+=======+
>> | base-page-4kB        |   78% |   30% |   78% |   11% |   73% |   14% |
>> | thp-aligned-8kB      |    1% |    0% |    0% |    0% |    1% |    0% |
>> | thp-aligned-16kB     |   17% |    4% |   17% |    3% |   20% |    4% |
>> | thp-aligned-32kB     |    1% |    1% |    1% |    2% |    1% |    1% |
>> | thp-aligned-64kB     |    3% |   63% |    3% |   81% |    4% |   77% |
>> | thp-aligned-128kB    |    0% |    1% |    1% |    1% |    1% |    2% |
>> | thp-unaligned-64kB   |    0% |    0% |    0% |    1% |    0% |    1% |
>> | thp-unaligned-128kB  |    0% |    1% |    0% |    0% |    0% |    0% |
>> | thp-partial          |    0% |    0% |    0% |    1% |    0% |    1% |
>> +----------------------+-------+-------+-------+-------+-------+-------+
>> | cont-aligned-64kB    |    4% |   65% |    4% |   83% |    6% |   79% |
>> +----------------------+-------+-------+-------+-------+-------+-------+
>>
>> The above shows that for both workloads (each isolated with cgroups) as
>> well as the general system state after boot, the amount of text backed
>> by 4K and 16K folios reduces and the amount backed by 64K folios
>> increases significantly. And the amount of text that is contpte-mapped
>> significantly increases (see last row).
>>
>> And this is reflected in performance improvement. "(I)" indicates a
>> statistically significant improvement. Note TPS and Reqs/sec are rates
>> so bigger is better, ms is time so smaller is better:
>>
>> +-------------+-------------------------------------------+------------+
>> | Benchmark   | Result Class                              | Improvemnt |
>> +=============+===========================================+============+
>> | pts/pgbench | Scale: 1 Clients: 1 RO (TPS)              |  (I) 3.47% |
>> |             | Scale: 1 Clients: 1 RO - Latency (ms)     |     -2.88% |
>> |             | Scale: 1 Clients: 250 RO (TPS)            |  (I) 5.02% |
>> |             | Scale: 1 Clients: 250 RO - Latency (ms)   | (I) -4.79% |
>> |             | Scale: 1 Clients: 1000 RO (TPS)           |  (I) 6.16% |
>> |             | Scale: 1 Clients: 1000 RO - Latency (ms)  | (I) -5.82% |
>> |             | Scale: 100 Clients: 1 RO (TPS)            |      2.51% |
>> |             | Scale: 100 Clients: 1 RO - Latency (ms)   |     -3.51% |
>> |             | Scale: 100 Clients: 250 RO (TPS)          |  (I) 4.75% |
>> |             | Scale: 100 Clients: 250 RO - Latency (ms) | (I) -4.44% |
>> |             | Scale: 100 Clients: 1000 RO (TPS)         |  (I) 6.34% |
>> |             | Scale: 100 Clients: 1000 RO - Latency (ms)| (I) -5.95% |
>> +-------------+-------------------------------------------+------------+
>> | pts/redis   | Test: GET Connections: 50 (Reqs/sec)      |  (I) 3.20% |
>> |             | Test: GET Connections: 1000 (Reqs/sec)    |  (I) 2.55% |
>> |             | Test: LPOP Connections: 50 (Reqs/sec)     |  (I) 4.59% |
>> |             | Test: LPOP Connections: 1000 (Reqs/sec)   |  (I) 4.81% |
>> |             | Test: LPUSH Connections: 50 (Reqs/sec)    |  (I) 5.31% |
>> |             | Test: LPUSH Connections: 1000 (Reqs/sec)  |  (I) 4.36% |
>> |             | Test: SADD Connections: 50 (Reqs/sec)     |  (I) 2.64% |
>> |             | Test: SADD Connections: 1000 (Reqs/sec)   |  (I) 4.15% |
>> |             | Test: SET Connections: 50 (Reqs/sec)      |  (I) 3.11% |
>> |             | Test: SET Connections: 1000 (Reqs/sec)    |  (I) 3.36% |
>> +-------------+-------------------------------------------+------------+
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Acked-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Tested-by: Tao Xu <tao.xu@arm.com>

Thanks for testing! Although, unfortunately I think you were a day late and this
patch is now in mm-stable so too late to add the tag.

Thanks,
Ryan

> 
> Observed similar performance optimization and iTLB benefits in mysql sysbench on
> Azure Cobalt-100 arm64 system.
> 
> Below shows more .text sections are now backed by 64K folios for the 52MiB
> mysqld binary file in XFS, and more in 128K folios when increasing the p_align
> from default 64k to 2M in ELF header:
> 
> +----------------------+-------+-------+-------+
> |                      |         mysql         |
> +----------------------+-------+-------+-------+
> |                      |before |     after     |
> +----------------------+-------+-------+-------+
> |                      |       |    p_align    |
> |                      |       |  64k  |   2M  |
> +----------------------+-------+-------+-------+
> | thp-aligned-8kB      |    1% |    0% |    0% |
> | thp-aligned-16kB     |   53% |    0% |    0% |
> | thp-aligned-32kB     |    0% |    0% |    0% |
> | thp-aligned-64kB     |    3% |   72% |    1% |
> | thp-aligned-128kB    |    0% |    0% |   67% |
> | thp-partial          |    0% |    0% |    5% |
> +----------------------+-------+-------+-------+
> 
> The resulting performance improvment is +5.65% in TPS throughput and -6.06% in
> average latency, using 16 local sysbench clients to the mysqld running on 32
> cores and 12GiB innodb_buffer_pool_size. Corresponding iTLB effectiveness
> benefits can also be observed from perf PMU metrics:
> 
> +-------------+--------------------------+------------+
> | Benchmark   | Result                   | Improvemnt |
> +=============+==========================+============+
> | sysbench    | TPS                      |      5.65% |
> |             | Latency              (ms)|     -6.06% |
> +-------------+--------------------------+------------+
> | perf PMU    | l1i_tlb           (M/sec)|     +1.11% |
> |             | l2d_tlb           (M/sec)|    -13.01% |
> |             | l1i_tlb_refill    (K/sec)|    -46.50% |
> |             | itlb_walk         (K/sec)|    -64.03% |
> |             | l2d_tlb_refill    (K/sec)|    -33.90% |
> |             | l1d_tlb           (M/sec)|     +1.24% |
> |             | l1d_tlb_refill    (M/sec)|     +2.23% |
> |             | dtlb_walk         (K/sec)|    -20.69% |
> |             | IPC                      |     +1.85% |
> +-------------+--------------------------+------------+
> 
>> ---
>>   arch/arm64/include/asm/pgtable.h |  8 ++++++
>>   include/linux/pgtable.h          | 11 ++++++++
>>   mm/filemap.c                     | 47 ++++++++++++++++++++++++++------
>>   3 files changed, 57 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 88db8a0c0b37..7a7dfdce14b8 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1643,6 +1643,14 @@ static inline void update_mmu_cache_range(struct
>> vm_fault *vmf,
>>    */
>>   #define arch_wants_old_prefaulted_pte    cpu_has_hw_af
>>   +/*
>> + * Request exec memory is read into pagecache in at least 64K folios. This size
>> + * can be contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB
>> + * entry), and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base
>> + * pages are in use.
>> + */
>> +#define exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
>> +
>>   static inline bool pud_sect_supported(void)
>>   {
>>       return PAGE_SIZE == SZ_4K;
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 0b6e1f781d86..e4a3895c043b 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -456,6 +456,17 @@ static inline bool arch_has_hw_pte_young(void)
>>   }
>>   #endif
>>   +#ifndef exec_folio_order
>> +/*
>> + * Returns preferred minimum folio order for executable file-backed memory. Must
>> + * be in range [0, PMD_ORDER). Default to order-0.
>> + */
>> +static inline unsigned int exec_folio_order(void)
>> +{
>> +    return 0;
>> +}
>> +#endif
>> +
>>   #ifndef arch_check_zapped_pte
>>   static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
>>                        pte_t pte)
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 4b5c8d69f04c..93fbc2ef232a 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3238,8 +3238,11 @@ static struct file *do_sync_mmap_readahead(struct
>> vm_fault *vmf)
>>       }
>>   #endif
>>   -    /* If we don't want any read-ahead, don't bother */
>> -    if (vm_flags & VM_RAND_READ)
>> +    /*
>> +     * If we don't want any read-ahead, don't bother. VM_EXEC case below is
>> +     * already intended for random access.
>> +     */
>> +    if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
>>           return fpin;
>>       if (!ra->ra_pages)
>>           return fpin;
>> @@ -3262,14 +3265,40 @@ static struct file *do_sync_mmap_readahead(struct
>> vm_fault *vmf)
>>       if (mmap_miss > MMAP_LOTSAMISS)
>>           return fpin;
>>   -    /*
>> -     * mmap read-around
>> -     */
>>       fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>> -    ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>> -    ra->size = ra->ra_pages;
>> -    ra->async_size = ra->ra_pages / 4;
>> -    ra->order = 0;
>> +    if (vm_flags & VM_EXEC) {
>> +        /*
>> +         * Allow arch to request a preferred minimum folio order for
>> +         * executable memory. This can often be beneficial to
>> +         * performance if (e.g.) arm64 can contpte-map the folio.
>> +         * Executable memory rarely benefits from readahead, due to its
>> +         * random access nature, so set async_size to 0.
>> +         *
>> +         * Limit to the boundaries of the VMA to avoid reading in any
>> +         * pad that might exist between sections, which would be a waste
>> +         * of memory.
>> +         */
>> +        struct vm_area_struct *vma = vmf->vma;
>> +        unsigned long start = vma->vm_pgoff;
>> +        unsigned long end = start + ((vma->vm_end - vma->vm_start) >>
>> PAGE_SHIFT);
>> +        unsigned long ra_end;
>> +
>> +        ra->order = exec_folio_order();
>> +        ra->start = round_down(vmf->pgoff, 1UL << ra->order);
>> +        ra->start = max(ra->start, start);
>> +        ra_end = round_up(ra->start + ra->ra_pages, 1UL << ra->order);
>> +        ra_end = min(ra_end, end);
>> +        ra->size = ra_end - ra->start;
>> +        ra->async_size = 0;
>> +    } else {
>> +        /*
>> +         * mmap read-around
>> +         */
>> +        ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>> +        ra->size = ra->ra_pages;
>> +        ra->async_size = ra->ra_pages / 4;
>> +        ra->order = 0;
>> +    }
>>       ractl._index = ra->start;
>>       page_cache_ra_order(&ractl, ra);
>>       return fpin;
> 


