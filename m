Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BDB653851
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 22:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiLUV5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLUV5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:57:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5741A38F;
        Wed, 21 Dec 2022 13:57:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOi/nABSQCLReHqylRiBd249T1UG9CfW7uVZdR46HLoZVFePeizKx9XJuTmwmL4OTUF2uyqlSZJtKpZTMT+tQmk7Il7beYAKTrNYh22nyiIxg2iLWDC1Z1hkkO8cVRkHkjEtU+EOus38HdiGH6Nu2RUFSjBWCCfKOY041ZRwa020ieL6is0dewC/nBx5DK6wPEKftBBtWyaZDewMbZ4sl76kehgic74uK+pHDXUfQW3mfbZE6mc6XF8ApMrZ7QzcG0sr8hgj+vTJSuEiVGgtxUoyHXr5letIXRZtgfDj9HHiXMSi5YJEgqGh4S6YXfRwN3fM1tDqV5mlsw2a20JgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd4e9kSqTBmqN8/Eo18606I52UhAtJd73VDZvzthFHM=;
 b=XxywtdE4k8lMOB1pqynQHzuaoH/DIiWtAdTXVWSzmbqhmU+jRfEBWXPlwRbWt0T3StSNrlxfdWR4ptDU2wfRPMmkw6jY5ErZ/2aXWSmfsuo5BuWTd0H5+6Vzj7FsehHJUxFUidyc6e0bYrhj54s4jNiMdKK1a7OCSxrwZo1w8F4MOH460ivohxp5neGVYghmMe5XPmesgSf3wWclfzkKGruAdALuM4+vdt+gDcBtiPRpn8+vVUHiX6Ij60u7gfo+yg1JtsuwLZcDZc8pBHDCy5x7I7Mf3Mc5dW54s6XEJpYW47d4HvK+Rt/nFfgT+oGtQwkNJrFcyFtXNZw/wTDYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd4e9kSqTBmqN8/Eo18606I52UhAtJd73VDZvzthFHM=;
 b=Z5O+VVERiZJqO7MyOGKVD/wcYU4x8BPOcE20dBp0LaYg8Hv9Fjb+klJy9ag59VBl6nijuscWZCex/LFeLsjF5lulBxsIjgpIfKiORbsXiSKmrxyfQ6FPbHP6xJC12a9SOhLU4aTlxXFtmIPFgdEDwu7vddDj02e9zMJR29PR04Wc1H6lYbZikXcUdm2EGhIQXKfzOLnNnF6ZYD+w4pWjbSMrjOlK+H5g2bNysL+WUG87V3Rd23qP7vVBcNAHSv1/6tRTFXFQYCj02Hbf0nvEqQtzpa7hBz1Izd9u6I1zXv6PU0MhnSemrMQbpd8ZCen81UqkLJM7xE0LNRBIjXDnJA==
Received: from DM5PR07CA0099.namprd07.prod.outlook.com (2603:10b6:4:ae::28) by
 CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Wed, 21 Dec 2022 21:57:36 +0000
Received: from DS1PEPF0000E65D.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::29) by DM5PR07CA0099.outlook.office365.com
 (2603:10b6:4:ae::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.22 via Frontend
 Transport; Wed, 21 Dec 2022 21:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E65D.mail.protection.outlook.com (10.167.18.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.8 via Frontend Transport; Wed, 21 Dec 2022 21:57:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 13:57:20 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 13:57:19 -0800
Message-ID: <4a7c67d5-3711-40d6-f9ac-e2f5e7099d03@nvidia.com>
Date:   Wed, 21 Dec 2022 13:57:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: Move FOLL_* defs to mm_types.h
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Jeff Layton" <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <2161258.1671657894@warthog.procyon.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2161258.1671657894@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E65D:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e38452-469a-4029-668d-08dae39e5ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnKQBibmvws2sHUudauC4rG9aWtekfC6mM+xywa3VAl803lSEVnwW7E5ngnRmtV8m9y8azO7TDLwBnK6KpK5wITaw9wOQs0XwtCLbomvDEIlR022evVnxwODTDC613uAKxMKFfcr6goal8U6q+2mLoh87dtKa4AYwS0ssVCCfWktoYFG6NGUDpCKh1CgSiyRvdAVUuy/75vj//PLCmfQWDt2dSPl6mxpc3qfEEA2iI41ebxzmm27yrhcxk5c7v+hoe3pi7HhA78+qEhERcP3fNOKvdKljiGZ1flo9dsFA23UqMdiWcSlqubpjaD/zfqd7s4rXgrUM5zAcG4wUrsT/JzZR9AVIMeb1V4K+zFLZozbLKCk+TpmWSXBx+PiwVvA89wqT/GqO97f2yirCsfddTwQ7gfpYybmP+0v+FTKTWZOytsA+AnWSTqgZ2EkrqxsoL92H4dG2OwJn4HlEAq1+46JeDSFieFZJHXx6iLFh02jlkX91YBxxvEyLqhMVnueMBlzPkidALBdtrzIw8cHvwIbyXqSjive06yS9vqoY+H8DQ31a2gI1Gh35rE/R7mgXjRtjPxr8MtrFHZmMdgxSJZmEHMWPE4/J6Bc6P9pozTMisutIwxvSw/5lkAp6Zr+noA9hbGOjnGXwxXLvRZETajtmCaUOVyOAfXE6jzCybLBcx8Rp/PUaimAjZ1vMJEXoxZcuISFdKxmRWFQq/HAm52ZdTUxZCvEawgTZ1ZWFveo1kPlNxH33sF9soOk5mniNZEsB0NVEnrP+ja4/zFPRIiUH0fg7N1df/JPzpMg9WPQYrT8R249lubRc58w/NcvqeutI/4Mmyhkpt3IF0A5J+x6QhQQfzZdPyZMx0hKYng=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(31686004)(36756003)(4326008)(356005)(2906002)(82740400003)(70206006)(86362001)(30864003)(70586007)(31696002)(8676002)(966005)(5660300002)(36860700001)(7636003)(83380400001)(478600001)(40460700003)(336012)(316002)(16526019)(2616005)(110136005)(16576012)(41300700001)(40480700001)(26005)(8936002)(54906003)(426003)(47076005)(82310400005)(186003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 21:57:35.9928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e38452-469a-4029-668d-08dae39e5ecf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E65D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/22 13:24, David Howells wrote:
> Hi Andrew,
> 
> Is it too late to ask you to add this to the current merge window?  It just
> moves the FOLL_* flags between headers, flipping the order of the banner
> comment and the defs.
> 
> It did have the following attributions:
> 
> 	Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 	Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> but the FOLL_* flagset got altered during the merge window, so I redid the
> patch.
> 
> Thanks,
> David
> ---
> mm: Move FOLL_* defs to mm_types.h
>      
> Move FOLL_* definitions to linux/mm_types.h to make them more accessible
> without having to drag in all of linux/mm.h and everything that drags in
> too[1].

I re-checked that everything got accurately moved. Looks good.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/linux-fsdevel/Y1%2FhSO+7kAJhGShG@casper.infradead.org/ [1]
> Link: https://lore.kernel.org/r/166732025009.3186319.3402781784409891214.stgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/166869688542.3723671.10243929000823258622.stgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/166920902968.1461876.15991975556984309489.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/166997420723.9475.3907844523056304049.stgit@warthog.procyon.org.uk/ # v3
> ---
>   include/linux/mm.h       |   75 -----------------------------------------------
>   include/linux/mm_types.h |   75 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+), 75 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f3f196e4d66d..be5edc0770ea 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3071,81 +3071,6 @@ static inline vm_fault_t vmf_error(int err)
>   struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>   			 unsigned int foll_flags);
>   
> -#define FOLL_WRITE	0x01	/* check pte is writable */
> -#define FOLL_TOUCH	0x02	/* mark page accessed */
> -#define FOLL_GET	0x04	/* do get_page on page */
> -#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
> -#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
> -#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
> -				 * and return without waiting upon it */
> -#define FOLL_NOFAULT	0x80	/* do not fault in pages */
> -#define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
> -#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
> -#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
> -#define FOLL_ANON	0x8000	/* don't do file mappings */
> -#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
> -#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
> -#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
> -#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
> -#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
> -#define FOLL_INTERRUPTIBLE  0x200000 /* allow interrupts from generic signals */
> -
> -/*
> - * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
> - * other. Here is what they mean, and how to use them:
> - *
> - * FOLL_LONGTERM indicates that the page will be held for an indefinite time
> - * period _often_ under userspace control.  This is in contrast to
> - * iov_iter_get_pages(), whose usages are transient.
> - *
> - * FIXME: For pages which are part of a filesystem, mappings are subject to the
> - * lifetime enforced by the filesystem and we need guarantees that longterm
> - * users like RDMA and V4L2 only establish mappings which coordinate usage with
> - * the filesystem.  Ideas for this coordination include revoking the longterm
> - * pin, delaying writeback, bounce buffer page writeback, etc.  As FS DAX was
> - * added after the problem with filesystems was found FS DAX VMAs are
> - * specifically failed.  Filesystem pages are still subject to bugs and use of
> - * FOLL_LONGTERM should be avoided on those pages.
> - *
> - * FIXME: Also NOTE that FOLL_LONGTERM is not supported in every GUP call.
> - * Currently only get_user_pages() and get_user_pages_fast() support this flag
> - * and calls to get_user_pages_[un]locked are specifically not allowed.  This
> - * is due to an incompatibility with the FS DAX check and
> - * FAULT_FLAG_ALLOW_RETRY.
> - *
> - * In the CMA case: long term pins in a CMA region would unnecessarily fragment
> - * that region.  And so, CMA attempts to migrate the page before pinning, when
> - * FOLL_LONGTERM is specified.
> - *
> - * FOLL_PIN indicates that a special kind of tracking (not just page->_refcount,
> - * but an additional pin counting system) will be invoked. This is intended for
> - * anything that gets a page reference and then touches page data (for example,
> - * Direct IO). This lets the filesystem know that some non-file-system entity is
> - * potentially changing the pages' data. In contrast to FOLL_GET (whose pages
> - * are released via put_page()), FOLL_PIN pages must be released, ultimately, by
> - * a call to unpin_user_page().
> - *
> - * FOLL_PIN is similar to FOLL_GET: both of these pin pages. They use different
> - * and separate refcounting mechanisms, however, and that means that each has
> - * its own acquire and release mechanisms:
> - *
> - *     FOLL_GET: get_user_pages*() to acquire, and put_page() to release.
> - *
> - *     FOLL_PIN: pin_user_pages*() to acquire, and unpin_user_pages to release.
> - *
> - * FOLL_PIN and FOLL_GET are mutually exclusive for a given function call.
> - * (The underlying pages may experience both FOLL_GET-based and FOLL_PIN-based
> - * calls applied to them, and that's perfectly OK. This is a constraint on the
> - * callers, not on the pages.)
> - *
> - * FOLL_PIN should be set internally by the pin_user_pages*() APIs, never
> - * directly by the caller. That's in order to help avoid mismatches when
> - * releasing pages: get_user_pages*() pages must be released via put_page(),
> - * while pin_user_pages*() pages must be released via unpin_user_page().
> - *
> - * Please see Documentation/core-api/pin_user_pages.rst for more information.
> - */
> -
>   static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
>   {
>   	if (vm_fault & VM_FAULT_OOM)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3b8475007734..4e1031626403 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1085,4 +1085,79 @@ enum fault_flag {
>   
>   typedef unsigned int __bitwise zap_flags_t;
>   
> +/*
> + * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
> + * other. Here is what they mean, and how to use them:
> + *
> + * FOLL_LONGTERM indicates that the page will be held for an indefinite time
> + * period _often_ under userspace control.  This is in contrast to
> + * iov_iter_get_pages(), whose usages are transient.
> + *
> + * FIXME: For pages which are part of a filesystem, mappings are subject to the
> + * lifetime enforced by the filesystem and we need guarantees that longterm
> + * users like RDMA and V4L2 only establish mappings which coordinate usage with
> + * the filesystem.  Ideas for this coordination include revoking the longterm
> + * pin, delaying writeback, bounce buffer page writeback, etc.  As FS DAX was
> + * added after the problem with filesystems was found FS DAX VMAs are
> + * specifically failed.  Filesystem pages are still subject to bugs and use of
> + * FOLL_LONGTERM should be avoided on those pages.
> + *
> + * FIXME: Also NOTE that FOLL_LONGTERM is not supported in every GUP call.
> + * Currently only get_user_pages() and get_user_pages_fast() support this flag
> + * and calls to get_user_pages_[un]locked are specifically not allowed.  This
> + * is due to an incompatibility with the FS DAX check and
> + * FAULT_FLAG_ALLOW_RETRY.
> + *
> + * In the CMA case: long term pins in a CMA region would unnecessarily fragment
> + * that region.  And so, CMA attempts to migrate the page before pinning, when
> + * FOLL_LONGTERM is specified.
> + *
> + * FOLL_PIN indicates that a special kind of tracking (not just page->_refcount,
> + * but an additional pin counting system) will be invoked. This is intended for
> + * anything that gets a page reference and then touches page data (for example,
> + * Direct IO). This lets the filesystem know that some non-file-system entity is
> + * potentially changing the pages' data. In contrast to FOLL_GET (whose pages
> + * are released via put_page()), FOLL_PIN pages must be released, ultimately, by
> + * a call to unpin_user_page().
> + *
> + * FOLL_PIN is similar to FOLL_GET: both of these pin pages. They use different
> + * and separate refcounting mechanisms, however, and that means that each has
> + * its own acquire and release mechanisms:
> + *
> + *     FOLL_GET: get_user_pages*() to acquire, and put_page() to release.
> + *
> + *     FOLL_PIN: pin_user_pages*() to acquire, and unpin_user_pages to release.
> + *
> + * FOLL_PIN and FOLL_GET are mutually exclusive for a given function call.
> + * (The underlying pages may experience both FOLL_GET-based and FOLL_PIN-based
> + * calls applied to them, and that's perfectly OK. This is a constraint on the
> + * callers, not on the pages.)
> + *
> + * FOLL_PIN should be set internally by the pin_user_pages*() APIs, never
> + * directly by the caller. That's in order to help avoid mismatches when
> + * releasing pages: get_user_pages*() pages must be released via put_page(),
> + * while pin_user_pages*() pages must be released via unpin_user_page().
> + *
> + * Please see Documentation/core-api/pin_user_pages.rst for more information.
> + */
> +
> +#define FOLL_WRITE	0x01	/* check pte is writable */
> +#define FOLL_TOUCH	0x02	/* mark page accessed */
> +#define FOLL_GET	0x04	/* do get_page on page */
> +#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
> +#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
> +#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
> +				 * and return without waiting upon it */
> +#define FOLL_NOFAULT	0x80	/* do not fault in pages */
> +#define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
> +#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
> +#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
> +#define FOLL_ANON	0x8000	/* don't do file mappings */
> +#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
> +#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
> +#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
> +#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
> +#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
> +#define FOLL_INTERRUPTIBLE  0x200000 /* allow interrupts from generic signals */
> +
>   #endif /* _LINUX_MM_TYPES_H */
> 

