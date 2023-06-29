Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED174202C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 08:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjF2GGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 02:06:19 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:18305
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229539AbjF2GGQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:06:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVAbaj519kClc4Oc6DXTe3ml7zB6d6v6bvWkOhccBiNqtRrTsGknb9cs0uop50a9cKXy1LkPldEzFYHRL+6XyiZfqAQ5Sq6j0azEX8fbKzWnBmSxS4w6vWO2bBs07o0OvMq4xHFzRCRA5aM1m70M2YchbxRl8tkT8biTa0teC/ZfptcAby9R4ov+BXElq7WLqXu7STaMdfSROhtwq3ZdvqJb6VyAdBd40hEHwHIpov1ImCA3HU5UQfUgOnRTxRjpkBPREgpqaly3aVWUg5C5xer0W8ciosdsLQe/iv6lgNmetcdKAli5WlrHDt1rWzI9Ji4CvgtlUTOeP8NGNO1Jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4zkZh4jdU2vRUCe4nqGab/6PhoV9gpf3v9BsepwWsE=;
 b=WZStf7B07jZc0fIO9QCRZrQV3CCpt3O0as+2d7Gtde0PVACKYYvsfXlpWKMZzNVo7hM1WmZQsH6RwAzaIXCRpFI6wktNkq4mxCfQ5VGjZQfacKTntIgS/MQTtTbjSubT8UnDfgHWmS5D2cw43G+nqp2JGcAWzKLs7n/Deb/VlTBNgwmnJrHWzk4zkhYHXaOGvonTLEvrR9zH53gDgoyL4ZKp65U6wZlyfy1FwVSlKnCNLFYAjD1bAPMt/YKF10/dFfEAQwzrDmE8FX82Qjjxmfae0/G+Gdvbm4LqTRwcevMiDoM+iVsFTrxJv5bjkTVMPJYpjPVw/iB3yObnx5vHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4zkZh4jdU2vRUCe4nqGab/6PhoV9gpf3v9BsepwWsE=;
 b=RBnbcgIAaAWCd8nhYgiAHrrZWscCOZBIqJqnd2YQf9EHjkzXoHHQ/+auzf53gdUfK9IRzgme6ya9DZCTKBl48p7/AcPYfccFNXtkDAIRKGRe1PI+r0xTnEshCHFYGbHNgsbTX6W9pb0GR0yEfYVva9yR5pihWM+EPS7IrdJ2O1A3xvo4fvaHnvvMMu4Rg61LllLhVfwTzJShHYwYhsnqdLF45e9RKePDHklrOibx/PQDiqR7QPcacNGj9mWOfW4vlw7BWHNC4CacSjVO5mTNZMDUD49HYYGwIpNIvj2IAXdqRii8qIEMo0xdjCE9u02iDv3aZ3Ll0CKy6uEzadL3tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 06:06:13 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6cea:921f:eb00:c1e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6cea:921f:eb00:c1e7%6]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 06:06:12 +0000
References: <20230628172529.744839-1-surenb@google.com>
 <20230628172529.744839-6-surenb@google.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v5 5/6] mm: handle swap page faults under per-VMA lock
Date:   Thu, 29 Jun 2023 16:04:58 +1000
In-reply-to: <20230628172529.744839-6-surenb@google.com>
Message-ID: <877crm246q.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0044.ausprd01.prod.outlook.com
 (2603:10c6:1:15::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 86dc9889-5d07-415d-6f0b-08db7866f0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yw575ifdhl/gBvKQZKSVBPalu3Ep6KAEUNhojEocIiDIITJPLUTcqQukg+zA1AdIvnufBHCalOGYCo0eSbzadmnFINGwnxf2gLQj7B8a5d5jifSI4A/1du4rdWpUh7itD4xYPIHOGIab2oS2ofKzCk7EFX0YDnqbhh0YqToRHAzfhEXDH6ulIaSlVWfEx2VJlIP11Op4XFSZIbtOwUMFyGDwe9ULbJjkBFFXxIZ/AV1z6iYDdxMDSu+ulPtgjRgtOkn8M4nx2ByxXDmys7n/kClF2jisCFZp2kXO30/IHtDGbwhN+7Gx4loORyL8TlZib9oKWwhOAh5P6TjduwdNRnhyEqx8er07qxCetcG/zVTZ6HNpUmphj1R4JlL0ayvlQy+awMVJR8Q5y/RNnfCE4fnV5xF/uwK9+eEJIcNUw3k4MLj8WN126GK0UoSw3egadosBLqc9JgG3hNhGE0PdRhaXI9FBEgXaNqDTd3bW/1k9F4f3n3hlq7rylCEk5qT/w4hk8gFBnW1HES7RqOsJUXHDV0vHxWAzuhj80omFeT7Jy+yLwm42656cp1QY9unA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(38100700002)(83380400001)(86362001)(478600001)(9686003)(6666004)(6486002)(4326008)(41300700001)(66556008)(316002)(8936002)(66946007)(66476007)(8676002)(6512007)(6506007)(186003)(6916009)(26005)(7406005)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wzf8fgKFLN0ziFu9TsV/ZRvENtnV3nBuFMeP1O3OFX6H9L4EZk+Ti0BRFYCd?=
 =?us-ascii?Q?bxCQMfSiJcTdNZ4slVMq2sDhj2xpgFdMVsG13sfwHx7nHnzgEuEDGLH0pcDu?=
 =?us-ascii?Q?ljhKDAdh3UZkhvCy9rqc/5xWE9cT0MA+MJWFZO6zGOcd2OlJGkvR/DmMFiph?=
 =?us-ascii?Q?WHfNRpoPjOyp/65tGcz1EAjQXlWcbMjTtC0PSXkJomlr+RygCmwWu69KUYyd?=
 =?us-ascii?Q?U0xDH2roMlHSIk7yShlVHxn0TnOgRRn4yEclcBzcO5sLnNtnBf5mtPMn6bDm?=
 =?us-ascii?Q?hDT73x/djkS3u1jLOHbmQrnFq3ARcS8kDT1TV75g1w71jmGj1E4jfobGIbkS?=
 =?us-ascii?Q?SB9pJ5OaLKuzO6N0KtS614XUTOuzFHp06vQ5MhEd54il/PJe16nWx/FJNVJn?=
 =?us-ascii?Q?My5gi+rECzwE1k7HrpbztfFUVLeAPlrCtyJP3FzGkjYDbRRQIFTGrp4U8XYM?=
 =?us-ascii?Q?lQCWl32Mf+GVeUGoFUag/rErVwPkm0MmyBBlHKt68/WGuOLPaiYhDtWx5YiW?=
 =?us-ascii?Q?6FRIDRbCyqFuAUFPR0h9jKWHjYXIWKYrt8LxTJ+vYfOtiKMeWyZjei315hqJ?=
 =?us-ascii?Q?9mqcpckZg1Nju0otWnVu35YGBJsWiVjuVjnaYzGlaOr3jU9VfLm3O4t3hO8M?=
 =?us-ascii?Q?LH2ISfqRmcobPJYhmVOKcm+7NYHbmIUa++6fstr5tqiV2BdgxpIEsOjnFGLz?=
 =?us-ascii?Q?lM7RuVjEVqWDo0T7aVgNCCB5QF+4ekOD3zzln9QL36e9M+6xwXMdoS1Kw9e/?=
 =?us-ascii?Q?bZO4u/96HNM/Eik9pbS3SEw40EzznVjZ4Nj+HGy5bSgmndLc6f22ujRTunzd?=
 =?us-ascii?Q?pffYC8QhRpV+miGQ/qjv/hJWsZiKB8wdVCdC34qb2vCx4Yi2egzWzzCfKJUa?=
 =?us-ascii?Q?m495UCU5H9hmaIxgz9YcUV80eu3ZGcDiTDD9XiljBXMT+05NcNX58xR8fnX1?=
 =?us-ascii?Q?soj7+ndOfQXdsWdv8HUMPXumKhZyp7XKgJ9K59cIeVe6bb379BI/dlz4c/BR?=
 =?us-ascii?Q?fyvI/DAXoXygLngb3rgw5zhnlN2zRfWRhAi023zgPiflXc6vUS99WRDEajZ1?=
 =?us-ascii?Q?DHCgEIJ1XMoEI23aBHy6RFJ7C+U1unpSQabk5kYB43q7plPWxQ9H3tIwjn3W?=
 =?us-ascii?Q?ge3AsiRIx5Amrq6kJmrg+nW5VEoS/mKw+jXnS6smj6YmqnrdTxM6zOCELuzR?=
 =?us-ascii?Q?2P+SRsowe7dNGx9M1JUjf9DTsMXz0xN/CuCGFPtAVPz8iiuCF94oAxKKh2ir?=
 =?us-ascii?Q?LAuMPuGMMxWkXCeFcxUAizvhC91wIRi4/hlSoMLzsD4vJnwLXLiDE5mT/GU2?=
 =?us-ascii?Q?ULM2OBQjz3MURN9I7Di8ghKWduxD5HzCuhPWqtfhoondTgBqjr5CgbsHPmx7?=
 =?us-ascii?Q?uSBEIn1F1+FDVp3Vl0Gx2722xy95rWiUJMLQywKaHAf9OkNkyNfrVWy5iFhD?=
 =?us-ascii?Q?ffbyadIiv/v89NijNBTpHY2R1Gf2Sq9kYvqPnDkJQ4SpNwbsOd02ucL5mFXc?=
 =?us-ascii?Q?5n7NdpgTv4qghg3/FYGwmOfmT3+AhtvyYLz0VvkWJrJsj6SmoMPLZjAIf1r7?=
 =?us-ascii?Q?Ew3mLGkYIr6ZpUjpQWBlISGboHK2P7W1Xrqb5ghm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dc9889-5d07-415d-6f0b-08db7866f0cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 06:06:12.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luqmgXcvUMaBTgb9aFqMhN70B/K5rw/DkpzssimwxCwIBTsCgSXegcamXYuRhvo3TIGAQmLKpIYTeLTucO3N3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Looks good and passed the HMM selftests. So:

Tested-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>

Suren Baghdasaryan <surenb@google.com> writes:

> When page fault is handled under per-VMA lock protection, all swap page
> faults are retried with mmap_lock because folio_lock_or_retry has to drop
> and reacquire mmap_lock if folio could not be immediately locked.
> Follow the same pattern as mmap_lock to drop per-VMA lock when waiting
> for folio and retrying once folio is available.
> With this obstacle removed, enable do_swap_page to operate under
> per-VMA lock protection. Drivers implementing ops->migrate_to_ram might
> still rely on mmap_lock, therefore we have to fall back to mmap_lock in
> that particular case.
> Note that the only time do_swap_page calls synchronous swap_readpage
> is when SWP_SYNCHRONOUS_IO is set, which is only set for
> QUEUE_FLAG_SYNCHRONOUS devices: brd, zram and nvdimms (both btt and
> pmem). Therefore we don't sleep in this path, and there's no need to
> drop the mmap or per-VMA lock.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h | 13 +++++++++++++
>  mm/filemap.c       | 17 ++++++++---------
>  mm/memory.c        | 16 ++++++++++------
>  3 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fec149585985..bbaec479bf98 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -723,6 +723,14 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
>  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  					  unsigned long address);
>  
> +static inline void release_fault_lock(struct vm_fault *vmf)
> +{
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> +		vma_end_read(vmf->vma);
> +	else
> +		mmap_read_unlock(vmf->vma->vm_mm);
> +}
> +
>  #else /* CONFIG_PER_VMA_LOCK */
>  
>  static inline void vma_init_lock(struct vm_area_struct *vma) {}
> @@ -736,6 +744,11 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
>  static inline void vma_mark_detached(struct vm_area_struct *vma,
>  				     bool detached) {}
>  
> +static inline void release_fault_lock(struct vm_fault *vmf)
> +{
> +	mmap_read_unlock(vmf->vma->vm_mm);
> +}
> +
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
>  /*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 52bcf12dcdbf..d4d8f474e0c5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1703,27 +1703,26 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>   * Return values:
>   * 0 - folio is locked.
>   * VM_FAULT_RETRY - folio is not locked.
> - *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
> - *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
> - *     which case mmap_lock is still held.
> + *     mmap_lock or per-VMA lock has been released (mmap_read_unlock() or
> + *     vma_end_read()), unless flags had both FAULT_FLAG_ALLOW_RETRY and
> + *     FAULT_FLAG_RETRY_NOWAIT set, in which case the lock is still held.
>   *
>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
> - * with the folio locked and the mmap_lock unperturbed.
> + * with the folio locked and the mmap_lock/per-VMA lock is left unperturbed.
>   */
>  vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
>  {
> -	struct mm_struct *mm = vmf->vma->vm_mm;
>  	unsigned int flags = vmf->flags;
>  
>  	if (fault_flag_allow_retry_first(flags)) {
>  		/*
> -		 * CAUTION! In this case, mmap_lock is not released
> -		 * even though return VM_FAULT_RETRY.
> +		 * CAUTION! In this case, mmap_lock/per-VMA lock is not
> +		 * released even though returning VM_FAULT_RETRY.
>  		 */
>  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
>  			return VM_FAULT_RETRY;
>  
> -		mmap_read_unlock(mm);
> +		release_fault_lock(vmf);
>  		if (flags & FAULT_FLAG_KILLABLE)
>  			folio_wait_locked_killable(folio);
>  		else
> @@ -1735,7 +1734,7 @@ vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
>  
>  		ret = __folio_lock_killable(folio);
>  		if (ret) {
> -			mmap_read_unlock(mm);
> +			release_fault_lock(vmf);
>  			return VM_FAULT_RETRY;
>  		}
>  	} else {
> diff --git a/mm/memory.c b/mm/memory.c
> index 345080052003..4fb8ecfc6d13 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3712,12 +3712,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!pte_unmap_same(vmf))
>  		goto out;
>  
> -	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> -		ret = VM_FAULT_RETRY;
> -		vma_end_read(vma);
> -		goto out;
> -	}
> -
>  	entry = pte_to_swp_entry(vmf->orig_pte);
>  	if (unlikely(non_swap_entry(entry))) {
>  		if (is_migration_entry(entry)) {
> @@ -3727,6 +3721,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			ret = remove_device_exclusive_entry(vmf);
>  		} else if (is_device_private_entry(entry)) {
> +			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +				/*
> +				 * migrate_to_ram is not yet ready to operate
> +				 * under VMA lock.
> +				 */
> +				vma_end_read(vma);
> +				ret = VM_FAULT_RETRY;
> +				goto out;
> +			}
> +
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>  					vmf->address, &vmf->ptl);

