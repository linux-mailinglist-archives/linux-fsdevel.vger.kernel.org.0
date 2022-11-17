Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37C62E964
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 00:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiKQXQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 18:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiKQXP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:15:59 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7F716D2;
        Thu, 17 Nov 2022 15:15:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/dyDUg8CQYgiJIU/ctyljmUdxl7lv1W0DqeVF6BzRM+4H3mv3lBb8ntk/0tbd/pIKBflH6HJl+h7T9gZg6zfxWloOi+r+Jigxz47nhEzFpzJlKawC8/eHnbeLHZs9XsZU0mCZON2pQWH9kgaQ/XJcxF0q22iLlrjDkfDLh9j9WsdklQCLbUd5hakp3AHsKRx6zGX6hENQsuXkxHFkRI5QbLVcRAcN42VMN47c2ryHRZCiU9jXG6RzcuwLeKd2bKktpUcgEAOju901BHMPY5bfaTGJVybywaxuwyfmbanRClSE9or4iJp3zA+qFOy+RGnVGp8cRnMVL80vQn8q/vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TV2/fnFlsfvkgGFu5urUDTiLpRsFiRQiV56Xr0bxAA=;
 b=OfxfLJoC9DAlkr0wdj63TKCGvPL9IHFJgZOsDf7gKzIjGfj6j4nJxRKCAAW8USCJpXLrhPFFieBfFcN4fVyeK/BVfzTMZ0DchqyYA/cNb8PruNrHPrpVA4PWfC6WeNArXoddPiJSlXQFlhmeCmVWLKci1si06qSk92bdKZUp8KgxgRxaatkG6y5qmn9Kwn/LJIoE0okGmhIDw5OXTcmTyejH42ulnnqcNVBdNVlpfDqVszkvBfzlzYTvzwo2HxKo5UQ78C62sCMk2E3D4FgseEFpV/i+OjyaaJoOiGELGynS8/VHQcZxykU4jN8zfdbkUkC/5APuvj7iFW1YRW6X7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TV2/fnFlsfvkgGFu5urUDTiLpRsFiRQiV56Xr0bxAA=;
 b=UWVm3YUP8d1xEjNJ2OxxJ3hiAyAFFM9uQGQhTlXQeyWKI8fVWwTDCq6X2FA+p/VY9whKx3mGYDZC+EONg4dOip70rhW5754Gt+0R5T0tHmHJTKscFtPIZgYGnSXcG5kXj8Zupb+SIcdTmwtA5Bl/DaxD/7Jpo9xkyMs3H6LgHBXa0vxbA1AiDvHNxgXfju9zMnQF/RlBDq2L95iy7clhBjOekZNe3GxfyfSHbC+reOBZNrxwsF3QkhkSQ9fvTfAQHofhBBCOiuR3+kxd/Fx1JwS+DcajRXWWhfumetjVcpuG126sHbDk7H0AunUcc/6K8gugB5dyrGZyLyRah+tCZQ==
Received: from BN9PR03CA0138.namprd03.prod.outlook.com (2603:10b6:408:fe::23)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 23:15:55 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::bb) by BN9PR03CA0138.outlook.office365.com
 (2603:10b6:408:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 23:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 23:15:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 15:15:41 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 15:15:41 -0800
Message-ID: <e1c01800-a5ba-ea69-c9d8-19b2cbe05d4f@nvidia.com>
Date:   Thu, 17 Nov 2022 15:15:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH 1/4] mm: Move FOLL_* defs to mm_types.h
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jeff Layton" <jlayton@kernel.org>, <linux-kernel@vger.kernel.org>
References: <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk>
 <166869688542.3723671.10243929000823258622.stgit@warthog.procyon.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <166869688542.3723671.10243929000823258622.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f8df6f-0fd8-4497-74e2-08dac8f1add6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4SLtMvlbVqKzk/aJn4IIVlZwznOxqCRC6ziq9mTSIDZn+FpLRFeGtfK6u2VahL0hGAh0DK4lUM4ExSDVsePd8+sLDvjCMV4hGGDnIgVP7UgFmCe7+fXTMAGXUKwNMN/3r3OLQsCUDP4SRMxWR50Il8Sj+rg93K16w0Xb/jbAAs2yhaxnFDZVfGm5Qpi8YqATfXX8beda5xtg6pUOTxxIDvsJhfbRu+YKqvRQTpozmm/2Uvmz7Md/VrEBA9DFUO0pk98ngfNJQBnxWZRpecTH66fj2uVO2fVdCfoAL7g3rr7/u7PaEeszFF3CqjlOeP4zh6gx1Pl+fWK6TVRUQ5tjXRmQ8Z5C95yAGu5btqLz+f8Z5yLZn2tlBCtt+P+HM1QFLU4v0PFUmJnvYrldAmVPcqp2IJhdDrtRalw0HnyS0lTnytrRZL6IprTFVX6fGMWhCldvsmg25MKKK2LvJtiNAUG5XZycF4G3dWUFcksvHso09LnShDEK9HpbY3hYkgHK/59c8/Lr111uzd2y9JyUhgHj5seb9gnG/EggS844kyQ4u48SFxQhT+sSv4wxQM39xeJJ7fOqchPzgYj2UY2/qzekofk7WzBaPJpSHSz86d0TnpbfjKUPUcFsBQA3w/taRcucTCKL7vIki8ATx3fDRn+3LUwfE6mc7ZxeMGyUGgGjk8DScWIBM4HjYlmQmTFVToMBEo3l3qnO6FSMlbEsQZtQ2PCtfDKOWa9d88EavzAL+pAsoaUzY29NW9GTGU6ZQqFJ3BoHwx1W1m27UURzgtlERAQKbUf/iFqIJEKYq4AuWz4tRLJrsLCIfTuK00B
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(31686004)(36756003)(86362001)(30864003)(2906002)(356005)(5660300002)(82740400003)(83380400001)(31696002)(8676002)(7636003)(70206006)(2616005)(16576012)(26005)(110136005)(478600001)(186003)(40460700003)(47076005)(54906003)(8936002)(16526019)(41300700001)(82310400005)(36860700001)(966005)(336012)(316002)(426003)(4326008)(53546011)(70586007)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 23:15:55.3501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f8df6f-0fd8-4497-74e2-08dac8f1add6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/17/22 06:54, David Howells wrote:
> Move FOLL_* definitions to linux/mm_types.h to make them more accessible
> without having to drag in all of linux/mm.h and everything that drags in
> too[1].
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/linux-fsdevel/Y1%2FhSO+7kAJhGShG@casper.infradead.org/ [1]
> ---
> 
>   include/linux/mm.h       |   74 ----------------------------------------------
>   include/linux/mm_types.h |   73 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 73 insertions(+), 74 deletions(-)


OK, I've verified that this is a "mostly identical" movement: the only
thing that changes is that the comments now come before the defines.

And because mm.h includes mm_types.h, it is unlikely that moving a
define from mm.h to mm_types.h would cause build failures. It's not
completely impossible: ordering issues are sometimes involved in this
sort of change. But unlikely.

Anyway, this is a good move. The users of various mm APIs should not
have to pull in quite so much of the internals of mm, and this is a step
in that direction. FOLL_* items are used by filesystems and other
subsystems that definitely do not need all of mm.h.


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bbcccbc5565..7a7a287818ad 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2941,80 +2941,6 @@ static inline vm_fault_t vmf_error(int err)
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
> -#define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
> -#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
> -#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
> -#define FOLL_ANON	0x8000	/* don't do file mappings */
> -#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
> -#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
> -#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
> -#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
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
> index 500e536796ca..0c80a5ad6e6a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1003,4 +1003,77 @@ enum fault_flag {
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
> +#define FOLL_WRITE	0x01	/* check pte is writable */
> +#define FOLL_TOUCH	0x02	/* mark page accessed */
> +#define FOLL_GET	0x04	/* do get_page on page */
> +#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
> +#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
> +#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
> +				 * and return without waiting upon it */
> +#define FOLL_NOFAULT	0x80	/* do not fault in pages */
> +#define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
> +#define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
> +#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
> +#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
> +#define FOLL_ANON	0x8000	/* don't do file mappings */
> +#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
> +#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
> +#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
> +#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
> +
>   #endif /* _LINUX_MM_TYPES_H */
> 
> 

