Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F10636FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 02:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKXBaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 20:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKXBaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:30:05 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF83BBDCD;
        Wed, 23 Nov 2022 17:30:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO5L+yXDuqkpZExdGLAY21UB/ajr8DagFW5w+Gx8N+M537EPlwB2Ef6bLhx/5em+pngpWBeqT2KO5QcvkWqhyavnqoOxaWLLq0hS5CCafq3E8UdKf/Kqof+v9+jFebzPyG/7hyBnD+1k1dg840XCl+bE3XlIOfAxgeZQBwnEVuh5h5f2kIFL5RR89qLCjxMWBHsC76YECHAVKecGtkOh0gw6NAcdC+pPgwrkgeDljnG5DSOSRLNAhoXMTZP+B6qo04ndsd6Qk/gfdE7iz3WeUarWUFTMOqg7tUT4lL+GR+pH55WmfSmOWlR9wAB2ISoAhnqKuvkVM+MX+ebOULx3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm1LwHWXitcxtBMrvVUq1HZTjWuSlP5kPs/yjJZKD6Y=;
 b=JDGPt7zFuvFxkAodz81VHIc+7k3YJjYG63l7Y67dk/iSfUS90kCS1ylfcj0PH9cbSkKIxoIcoh6X66RMsweYlfyLKhhEXFKLM07Q3oaS3Dzbn5Ee6E1J66XfpgRgp/9YZxBJNJcjIJLQj3dGPaLUM9EFtrTXpRy24FIURJtfrffXOR9faRon4p8LfRSTfnI0IGIE2wKs4wrdRPRMNh200KgkCXIkOJdeIGVDgd79Z1dNhgMsb/SRVgN6/yKJSjnzBEaFEhuFfTED3HqP8v/vF1MAoAE7O+qwEdwv5gfWtI8Uv+YzDsHZa8ApFZFCmAnenC6FNFDvurYJ01gCdU83tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm1LwHWXitcxtBMrvVUq1HZTjWuSlP5kPs/yjJZKD6Y=;
 b=HXytnNA4X/JLVZ9IC1lXoRUTRpmJNg5qbf5TqGp+FgOuvyTbgScfd+pCR3qNOjSqpPLuwwnA7IHldABljcoKeAejFAczEN7rRUnS7EFZ5Mecu60nwIVewi1dvFEsRDJSnMmOkHs+hPCSKUA/hPVX9JrWpDhzeULR67aH6ptcUmM+mgjvTULB3yZsvDcjSsZf/NVzX6ofb91Bfs9wapkyYREmMwzsLrjND1hPF5JQdUufOtUuEhNy/hmF/dht4h4fDfk/VPXiw2YWteD0qrtkepGdoYYyh4SniPWks0xQ0Y1o4RiZWjWrPS9A466iG4JlQBXwdyn1z4fDQG6vfqbJww==
Received: from BN0PR04CA0175.namprd04.prod.outlook.com (2603:10b6:408:eb::30)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 24 Nov
 2022 01:29:59 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::31) by BN0PR04CA0175.outlook.office365.com
 (2603:10b6:408:eb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Thu, 24 Nov 2022 01:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 01:29:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 17:29:51 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 17:29:51 -0800
Message-ID: <1597daa2-bf3a-41a3-3094-0050164f013b@nvidia.com>
Date:   Wed, 23 Nov 2022 17:29:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v1 09/20] mm/gup: reliable R/O long-term
 pinning in COW mappings
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <sparclinux@vger.kernel.org>,
        <linux-um@lists.infradead.org>, <etnaviv@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-10-david@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221116102659.70287-10-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cde9e9b-2493-4f0c-4115-08dacdbb6707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RHItDhzCAMf5HWoS4ntFCpRqQlfUZALBusQoHAYpCIgF+GVWJI/866NqPCyejASRRWMGg24Eyd0y1K25p05iFHwm8GOnpikgpH8i0lBxybOF3/H7AqIZyOmSNZcd+Xj65iVu2nuGNP6mf9YHJjcVY1aUITBjkbWtmbTW+G6wc18pRTl261iiihjvavV5LDRvPkFxpq2O8TrXuiKvSkoXcNieWYRG3daSi1crFHtSE+EEcVXAy7Ow8kneWePdUVUp3q+avtvObXRS/yH0eYJl4BGbZzjpQJcKcTCU1mdSUdkvq6p8wva9rYGI3lc/6AqZMXNnZTnulouAI3mPbnLN3bFVLs7pwDDjInGQbprr5Z7bd3Hixe5rtEveukdfdTHLym+lF+wsB4kGR1UaSYEwrQ8m8d3pJoZ3YQRxJidPQrSTRyY8Cl4HwYMMEIOJL2+0lDR45DkXn1TutVXKgAJUQB7K6v2D5Uft3D6IxTeEXVfbe1XWCCrJPUxhbTRCbVnjgioTbHLwzVG7fvSG0+eZ6PLN9lsPfzRjC2lNim9nCcJeN0qJ0p3pl8VMq4iFlT3edHz9rGPGiZ2WDkQBwv/QWI/vJYXwx3dIShOIoHeVycOD8q+Yc23IWyFA98oGITO6wH650Ph3lHSQ/cZJcWaFIR8YeGiBNHWUzmchRlLU5LHlpFOg5nAQUF5MaWvwTEeoe2Mzbuf/eIZ46lu9Wpu9Y4EBtChzXOHKF+xAAvnXkE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(31686004)(70586007)(478600001)(66899015)(8676002)(36756003)(8936002)(4326008)(186003)(16526019)(41300700001)(53546011)(7406005)(26005)(110136005)(2616005)(7416002)(336012)(316002)(70206006)(5660300002)(16576012)(54906003)(2906002)(86362001)(40480700001)(83380400001)(40460700003)(31696002)(426003)(47076005)(82310400005)(82740400003)(7636003)(36860700001)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 01:29:59.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cde9e9b-2493-4f0c-4115-08dacdbb6707
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/22 02:26, David Hildenbrand wrote:
...
> With this change, the new R/O long-term pinning tests for non-anonymous
> memory succeed:
>    # [RUN] R/O longterm GUP pin ... with shared zeropage
>    ok 151 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP pin ... with memfd
>    ok 152 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP pin ... with tmpfile
>    ok 153 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP pin ... with huge zeropage
>    ok 154 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP pin ... with memfd hugetlb (2048 kB)
>    ok 155 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP pin ... with memfd hugetlb (1048576 kB)
>    ok 156 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP-fast pin ... with shared zeropage
>    ok 157 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP-fast pin ... with memfd
>    ok 158 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP-fast pin ... with tmpfile
>    ok 159 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP-fast pin ... with huge zeropage
>    ok 160 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (2048 kB)
>    ok 161 Longterm R/O pin is reliable
>    # [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (1048576 kB)
>    ok 162 Longterm R/O pin is reliable

Yes. I was able to reproduce these results, after some minor distractions
involving huge pages, don't ask. :)

> 
> Note 1: We don't care about short-term R/O-pinning, because they have
> snapshot semantics: they are not supposed to observe modifications that
> happen after pinning.
> 
> As one example, assume we start direct I/O to read from a page and store
> page content into a file: modifications to page content after starting
> direct I/O are not guaranteed to end up in the file. So even if we'd pin
> the shared zeropage, the end result would be as expected -- getting zeroes
> stored to the file.
> 
> Note 2: For shared mappings we'll now always fallback to the slow path to
> lookup the VMA when R/O long-term pining. While that's the necessary price
> we have to pay right now, it's actually not that bad in practice: most
> FOLL_LONGTERM users already specify FOLL_WRITE, for example, along with
> FOLL_FORCE because they tried dealing with COW mappings correctly ...
> 
> Note 3: For users that use FOLL_LONGTERM right now without FOLL_WRITE,
> such as VFIO, we'd now no longer pin the shared zeropage. Instead, we'd
> populate exclusive anon pages that we can pin. There was a concern that
> this could affect the memlock limit of existing setups.
> 
> For example, a VM running with VFIO could run into the memlock limit and
> fail to run. However, we essentially had the same behavior already in
> commit 17839856fd58 ("gup: document and work around "COW can break either
> way" issue") which got merged into some enterprise distros, and there were
> not any such complaints. So most probably, we're fine.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/mm.h | 27 ++++++++++++++++++++++++---
>   mm/gup.c           | 10 +++++-----
>   mm/huge_memory.c   |  2 +-
>   mm/hugetlb.c       |  7 ++++---
>   4 files changed, 34 insertions(+), 12 deletions(-)
> 

Looks good,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6bd2ee5872dd..e8cc838f42f9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3095,8 +3095,12 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
>    * Must be called with the (sub)page that's actually referenced via the
>    * page table entry, which might not necessarily be the head page for a
>    * PTE-mapped THP.
> + *
> + * If the vma is NULL, we're coming from the GUP-fast path and might have
> + * to fallback to the slow path just to lookup the vma.
>    */
> -static inline bool gup_must_unshare(unsigned int flags, struct page *page)
> +static inline bool gup_must_unshare(struct vm_area_struct *vma,
> +				    unsigned int flags, struct page *page)
>   {
>   	/*
>   	 * FOLL_WRITE is implicitly handled correctly as the page table entry
> @@ -3109,8 +3113,25 @@ static inline bool gup_must_unshare(unsigned int flags, struct page *page)
>   	 * Note: PageAnon(page) is stable until the page is actually getting
>   	 * freed.
>   	 */
> -	if (!PageAnon(page))
> -		return false;
> +	if (!PageAnon(page)) {
> +		/*
> +		 * We only care about R/O long-term pining: R/O short-term
> +		 * pinning does not have the semantics to observe successive
> +		 * changes through the process page tables.
> +		 */
> +		if (!(flags & FOLL_LONGTERM))
> +			return false;
> +
> +		/* We really need the vma ... */
> +		if (!vma)
> +			return true;
> +
> +		/*
> +		 * ... because we only care about writable private ("COW")
> +		 * mappings where we have to break COW early.
> +		 */
> +		return is_cow_mapping(vma->vm_flags);
> +	}
>   
>   	/* Paired with a memory barrier in page_try_share_anon_rmap(). */
>   	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> diff --git a/mm/gup.c b/mm/gup.c
> index 5182abaaecde..01116699c863 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -578,7 +578,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>   		}
>   	}
>   
> -	if (!pte_write(pte) && gup_must_unshare(flags, page)) {
> +	if (!pte_write(pte) && gup_must_unshare(vma, flags, page)) {
>   		page = ERR_PTR(-EMLINK);
>   		goto out;
>   	}
> @@ -2338,7 +2338,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>   			goto pte_unmap;
>   		}
>   
> -		if (!pte_write(pte) && gup_must_unshare(flags, page)) {
> +		if (!pte_write(pte) && gup_must_unshare(NULL, flags, page)) {
>   			gup_put_folio(folio, 1, flags);
>   			goto pte_unmap;
>   		}
> @@ -2506,7 +2506,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>   		return 0;
>   	}
>   
> -	if (!pte_write(pte) && gup_must_unshare(flags, &folio->page)) {
> +	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
>   		gup_put_folio(folio, refs, flags);
>   		return 0;
>   	}
> @@ -2572,7 +2572,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>   		return 0;
>   	}
>   
> -	if (!pmd_write(orig) && gup_must_unshare(flags, &folio->page)) {
> +	if (!pmd_write(orig) && gup_must_unshare(NULL, flags, &folio->page)) {
>   		gup_put_folio(folio, refs, flags);
>   		return 0;
>   	}
> @@ -2612,7 +2612,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>   		return 0;
>   	}
>   
> -	if (!pud_write(orig) && gup_must_unshare(flags, &folio->page)) {
> +	if (!pud_write(orig) && gup_must_unshare(NULL, flags, &folio->page)) {
>   		gup_put_folio(folio, refs, flags);
>   		return 0;
>   	}
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 68d00196b519..dec7a7c0eca8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1434,7 +1434,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>   	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(flags))
>   		return NULL;
>   
> -	if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
> +	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))
>   		return ERR_PTR(-EMLINK);
>   
>   	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 383b26069b33..c3aab6d5b7aa 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6195,7 +6195,8 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>   	}
>   }
>   
> -static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
> +static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
> +					       unsigned int flags, pte_t *pte,
>   					       bool *unshare)
>   {
>   	pte_t pteval = huge_ptep_get(pte);
> @@ -6207,7 +6208,7 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
>   		return false;
>   	if (flags & FOLL_WRITE)
>   		return true;
> -	if (gup_must_unshare(flags, pte_page(pteval))) {
> +	if (gup_must_unshare(vma, flags, pte_page(pteval))) {
>   		*unshare = true;
>   		return true;
>   	}
> @@ -6336,7 +6337,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		 * directly from any kind of swap entries.
>   		 */
>   		if (absent ||
> -		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {
> +		    __follow_hugetlb_must_fault(vma, flags, pte, &unshare)) {
>   			vm_fault_t ret;
>   			unsigned int fault_flags = 0;
>   

