Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FE678E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjAXCMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjAXCMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:12:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12D11EBB;
        Mon, 23 Jan 2023 18:12:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToetfjX/32PDsMdYjIe1YH7XpzmFb+e5njMGDn6K3V4+HyCWRuQOWbOQub5JtAmu0qnLGzwbK/Rlu/acObL3qyFTjyIe+reXfoINGNfNmoPCg8QiQCjamSmMqgSsndRQrJ8YQJOVuJVBnFBeHd0MygFLm8SpP4sEphBsRnckcLGYkZh8oW5xyi5IgKU/nInvVBpwZ+XvSD+m8xQtm313AaFAdxR1GH+Fs96RnnJe9yq4pMqcIZoDV2vb1O8tXkSBktuC4P9PA6qXpy6VUTsJf+Cqmzv781ToXkK69BP6XsdhbYjsYj7Q4pr6dx3Jg/mZWDqWFCX6CCYf51VmsMegqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnNLJ62wvIfuV4AjmA4AbQQnONAxrmS8d9gSgQjQoLI=;
 b=gosjfY73aFCnnlhxy5RqUWoro8l6gBjeOHK2rcNQmuN/Hi3dmplUpq7ZL5slOPrFV4F6Aq4BNloUWVNlETEJWpVm8UdLl0tgrkRFP9QF3SfOmsNXuXZHRw6oRXdwQv95Odm4XTs2CQir+fFISPpz39x2O4JBsShMrLhX5cFN2ij9GLNtltkjL8/PZakUDP2SMPnLHMOw1FKG2ptcRULC4WsWNgIbRTlzgXTWdE6/5AJWGAp0JVTbO9sRFluIa5z1SyOgmajFZT3itxVmyTNRaKV3PvSHzSw7n+XnFfgV8T3+la/KGJn3VmeQdZ2s6Ttsxk1tr9fo7wrzR1nqwooMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnNLJ62wvIfuV4AjmA4AbQQnONAxrmS8d9gSgQjQoLI=;
 b=tzoMK9JUxjrG0DinJ3E/9w6qrdmQIEIJN8C8sSc7Qrian9DLAl7F0dZJimycsi1d/ULrFMJSm8um98yDzES20aDYziJ3rrPB5DQ1faiwRGlkXkayCHRnaYxsfxHie3GV75D2s6dPrePhfCGyMaOTRgTJFLb6unbG7iljyWFaaWwzxcUt3ac5uh9INOiQRPWjbr/kKb7QHG8mEbZmi9qaw+xm1R0BK5jO7kb96Q5YcpWo7+Yi98c8QeP0dT4FtN+WUfrSs8Gj908Rzxr1qehUzRs6WWwwL15AJ7ykuMqVJQ8TNBE5WYOA8bvCspDJYphqNIeMXxfX8JltX4E49jwgFg==
Received: from CY8PR19CA0018.namprd19.prod.outlook.com (2603:10b6:930:44::15)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 02:12:46 +0000
Received: from CY4PEPF0000C97F.namprd02.prod.outlook.com
 (2603:10b6:930:44:cafe::97) by CY8PR19CA0018.outlook.office365.com
 (2603:10b6:930:44::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 02:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C97F.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.16 via Frontend Transport; Tue, 24 Jan 2023 02:12:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 18:12:40 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 18:12:39 -0800
Message-ID: <8231351d-49f7-fcc8-4224-62490daa0063@nvidia.com>
Date:   Mon, 23 Jan 2023 18:12:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 01/10] iov_iter: Define flags to qualify page
 extraction.
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-2-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230123173007.325544-2-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97F:EE_|BL1PR12MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c599e62-7948-452e-c209-08dafdb07c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +l1ldovIW3odpHCr3gNX6TWD/Qh3QgmHIZ9mjjBQbtgYQM9oPuEs85DSfdOJ3rpatqdvJrtEWW7PaMwM9vDRR4zCAspWlthyPMFXGxq2yNJUhT7qy23oQjplXRYFx4rIPkpT1cpz5/0QghFEP6c4EdFBAt6Rg9lo/nIU7i2c+V+IxJBqb5ZU9M6BL9dSINVhZKX91C8xRSQD/TPY7vkFYt9dhNsl1FeNKg5DU3A0Q/Z9D+O+nq+o+RhgcY2bRrH/0mKW5azQXUZOsanfZr+qmDc8PWe8sgOdgsL+sKIEr3X9TH5QO184r9vGT8kmaWig2Fgbo8GxUEv6RhY3hruOXDf+puLsDBNACYfb0lTyBWgAzKAL70s0+1hbFc4tgBHCWHnYI7+Ope3vU8sTIxGgkvqf6MKqHWCFWYr4+BM3VSNUuPXKM6YY5j7y2DNJaf5RC+RFqtlNOoE8S40Fl7qHC90jlPplwRfDppNho+iz+ARhVX6vOVFm2EGFOH8vsPZxHcbr+PgFQtgn4ncpSAd1L7uoDqtduNRkgXnncj0cfWT1N6tO4LHFJD6VfoslinpjPfheaDJ7/utdWwXAoPvd8HZmNF+Pt1YjsAYdJ3yJnHq9lwePxwannvg55YW2pAMW+fJsMzyAXTkKD8AgzGiI3O6I/7/JDhXxqIR9LTE1yGHDZ77LkU9fbCh9StO/1Z9pOkQo5/dddY7oaz36WyFgt3olfZ0pgyJeKdZODy/fgHk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(36860700001)(82740400003)(7416002)(41300700001)(86362001)(356005)(7636003)(82310400005)(2906002)(8936002)(5660300002)(4326008)(40460700003)(16526019)(40480700001)(26005)(53546011)(8676002)(186003)(47076005)(336012)(426003)(70206006)(316002)(70586007)(16576012)(54906003)(2616005)(110136005)(478600001)(31686004)(31696002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 02:12:46.3387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c599e62-7948-452e-c209-08dafdb07c19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 09:29, David Howells wrote:
> Define flags to qualify page extraction to pass into iov_iter_*_pages*()
> rather than passing in FOLL_* flags.
> 
> For now only a flag to allow peer-to-peer DMA is supported.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> ---
> 
> Notes:
>      ver #7)
>       - Don't use FOLL_* as a parameter, but rather define constants
>         specifically to use with iov_iter_*_pages*().
>       - Drop the I/O direction constants for now.
> 
>   block/bio.c         |  6 +++---
>   block/blk-map.c     |  8 ++++----
>   include/linux/uio.h |  7 +++++--
>   lib/iov_iter.c      | 14 ++++++++------
>   4 files changed, 20 insertions(+), 15 deletions(-)

One possible way this could run into problems is if any callers are
violating the new requirement that flags be limited to those used to
govern iov extraction. In other words, if any callers were passing other
gup flags in (because instead of adding to them, the code is now setting
flags to zero and only looking at the new extract_flags). So I checked
for that and there aren't any.

So this looks good. I will lightly suggest renaming extract_flags to
extraction_flags, because it reads like a boolean: "to extract, or not
to extract flags, that is the question". Of course, once you look at the
code it is clear. But the extra "ion" doesn't overflow the 80 cols
anywhere and it is a nice touch.

Up to you. Either way, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/block/bio.c b/block/bio.c
> index ab59a491a883..a289bbff036f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1249,7 +1249,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
>   	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>   	struct page **pages = (struct page **)bv;
> -	unsigned int gup_flags = 0;
> +	unsigned int extract_flags = 0;
>   	ssize_t size, left;
>   	unsigned len, i = 0;
>   	size_t offset, trim;
> @@ -1264,7 +1264,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>   
>   	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
> -		gup_flags |= FOLL_PCI_P2PDMA;
> +		extract_flags |= ITER_ALLOW_P2PDMA;
>   
>   	/*
>   	 * Each segment in the iov is required to be a block size multiple.
> @@ -1275,7 +1275,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	 */
>   	size = iov_iter_get_pages(iter, pages,
>   				  UINT_MAX - bio->bi_iter.bi_size,
> -				  nr_pages, &offset, gup_flags);
> +				  nr_pages, &offset, extract_flags);
>   	if (unlikely(size <= 0))
>   		return size ? size : -EFAULT;
>   
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 19940c978c73..bc111261fc82 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -267,7 +267,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   {
>   	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
>   	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
> -	unsigned int gup_flags = 0;
> +	unsigned int extract_flags = 0;
>   	struct bio *bio;
>   	int ret;
>   	int j;
> @@ -280,7 +280,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   		return -ENOMEM;
>   
>   	if (blk_queue_pci_p2pdma(rq->q))
> -		gup_flags |= FOLL_PCI_P2PDMA;
> +		extract_flags |= ITER_ALLOW_P2PDMA;
>   
>   	while (iov_iter_count(iter)) {
>   		struct page **pages, *stack_pages[UIO_FASTIOV];
> @@ -291,10 +291,10 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
>   			pages = stack_pages;
>   			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
> -						   nr_vecs, &offs, gup_flags);
> +						   nr_vecs, &offs, extract_flags);
>   		} else {
>   			bytes = iov_iter_get_pages_alloc(iter, &pages,
> -						LONG_MAX, &offs, gup_flags);
> +						LONG_MAX, &offs, extract_flags);
>   		}
>   		if (unlikely(bytes <= 0)) {
>   			ret = bytes ? bytes : -EFAULT;
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 9f158238edba..46d5080314c6 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -252,12 +252,12 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *
>   		     loff_t start, size_t count);
>   ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
>   		size_t maxsize, unsigned maxpages, size_t *start,
> -		unsigned gup_flags);
> +		unsigned extract_flags);
>   ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>   			size_t maxsize, unsigned maxpages, size_t *start);
>   ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>   		struct page ***pages, size_t maxsize, size_t *start,
> -		unsigned gup_flags);
> +		unsigned extract_flags);
>   ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
>   			size_t maxsize, size_t *start);
>   int iov_iter_npages(const struct iov_iter *i, int maxpages);
> @@ -360,4 +360,7 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
>   	};
>   }
>   
> +/* Flags for iov_iter_get/extract_pages*() */
> +#define ITER_ALLOW_P2PDMA	0x01	/* Allow P2PDMA on the extracted pages */
> +
>   #endif
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index f9a3ff37ecd1..fb04abe7d746 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1432,9 +1432,9 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
>   static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>   		   struct page ***pages, size_t maxsize,
>   		   unsigned int maxpages, size_t *start,
> -		   unsigned int gup_flags)
> +		   unsigned int extract_flags)
>   {
> -	unsigned int n;
> +	unsigned int n, gup_flags = 0;
>   
>   	if (maxsize > i->count)
>   		maxsize = i->count;
> @@ -1442,6 +1442,8 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>   		return 0;
>   	if (maxsize > MAX_RW_COUNT)
>   		maxsize = MAX_RW_COUNT;
> +	if (extract_flags & ITER_ALLOW_P2PDMA)
> +		gup_flags |= FOLL_PCI_P2PDMA;
>   
>   	if (likely(user_backed_iter(i))) {
>   		unsigned long addr;
> @@ -1495,14 +1497,14 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>   
>   ssize_t iov_iter_get_pages(struct iov_iter *i,
>   		   struct page **pages, size_t maxsize, unsigned maxpages,
> -		   size_t *start, unsigned gup_flags)
> +		   size_t *start, unsigned extract_flags)
>   {
>   	if (!maxpages)
>   		return 0;
>   	BUG_ON(!pages);
>   
>   	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
> -					  start, gup_flags);
> +					  start, extract_flags);
>   }
>   EXPORT_SYMBOL_GPL(iov_iter_get_pages);
>   
> @@ -1515,14 +1517,14 @@ EXPORT_SYMBOL(iov_iter_get_pages2);
>   
>   ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>   		   struct page ***pages, size_t maxsize,
> -		   size_t *start, unsigned gup_flags)
> +		   size_t *start, unsigned extract_flags)
>   {
>   	ssize_t len;
>   
>   	*pages = NULL;
>   
>   	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
> -					 gup_flags);
> +					 extract_flags);
>   	if (len <= 0) {
>   		kvfree(*pages);
>   		*pages = NULL;
> 

