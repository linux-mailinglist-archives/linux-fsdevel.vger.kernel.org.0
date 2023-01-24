Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6067A295
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjAXTYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAXTYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:24:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247534955F;
        Tue, 24 Jan 2023 11:24:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwjqJlJWoAONN85MtJpr7Mk+gLnBhgFqOLvzZk2+KPak3aq4bdyspAzcz9O+fuNH86s33iGy+SiwADxQBNCQkt3JbGnNJANQskrdwFBOxmead8TbD9cTvcbenkeVbA6Z1vzTB7/6XsLIcC5WHjig0ZGyur4fwyhLAgHBRtCX3HhUb/YpLZuy1dn3GCr5/HClApna4FmataDuwFuEXXI6X9j716bkMJnA3iXCCf2YcCTox/UZwWCXcXc04OsshFxXFSvdUThaUfBdrHXcXG1ou5LpLAxxaeon46gWbAAIH0VZ55hL++OrlPFx8ptBuW9O9bVfSB6iev89WPIhLFVg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QuvB1oM4EJJ+ZuvjgfLIqaq1Vt9v2caYSIMwBGvw9I=;
 b=jOOlCJce0+MVgvhxPx2aMHmlVWCki65f1XlHhkKEUU6d4jMLiEie/s08k+SZAj+1yq6pAJVtIvxghbDN/jN9YyM99q7F/5mJFCgkUgSM7SdBBxq47CYtUaD2bIvhgQt+BFJ+/67NFJwY8jknii2WCNoQuTJB7KATHM8mFVtxjSKnp7djMYyBRJhLvuzROc5Kr1tUZNykuboeC8Pl403oFZkCFxlF5hxTIGlMQS+eLDKpnxR6RDNrC3pnSx5QHCMWh149aec+nZZw/5qR5yRaFLP5azgqV8qVsS856+Q/IOXMZ4I7mM2CWS4DJN8hVLnEKO9fofiRvWpVttvBDWcbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QuvB1oM4EJJ+ZuvjgfLIqaq1Vt9v2caYSIMwBGvw9I=;
 b=lwYy7ctwyc8N7px2TrApMKSzOWNS8dAj3MbSx1Cv1riCpd97an+yNUxXX59azWTWqmOSoxL8rLT7173EGuMx22dMCZD46hch45xFg1M6Ua1noLvShL9TwscfqlD1oDeJP5huObyImaO+vG47juki7Y/wGzo/RF3VbvmwsrlzOerX5lMpLPDpfUeBtE9NHn1LVPrCSmSFWCLSuJTkweC/p1Hf2F5wpNqRP7XVlHVeJXfqyb4sZKLlTNk3hb1JCvgmbJOY89vVjC/1Qu4/a98bh2F3DMcaO+xBNVtZ+9cjCiiVVVtwfel5fzhJ0TWSDaABm4OAXVmUUhx5pxxglkVlDg==
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 19:24:01 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::98) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 19:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Tue, 24 Jan 2023 19:24:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:23:47 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:23:46 -0800
Message-ID: <0b649477-8e61-b330-aba5-eba4761a56d5@nvidia.com>
Date:   Tue, 24 Jan 2023 11:23:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 1/8] iov_iter: Define flags to qualify page extraction.
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-2-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230124170108.1070389-2-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7559f2-725f-43c3-9e1d-08dafe408c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFe2qDmQs/LDKPFIaY+ZeeguF6ZTXL71XPoe7K1Uc2RbS8l1NydHSABNl8W+3UnwyG/Vo6E5dKgSngWKx2YKdwFeLAO4NY5NJiU0VHNMNmqFQYKEFVVKQi8lJMqNAHIuzf6yMj/nhM9T9NKBNDOHKZc7VjBw7Z+RrrXs5Ksot+BbF5mZQlUVhQ5BcCwMBAr7y5yleoR3onUPQWF3At54nU2AxvTrbs5QNasCDH4ehLxWCLAP5FSkIRtJppGDGnWMNAf/OnhQTj4zt+HfBroSJxE3pasdI18L20afmk3dVIFML2eIMqO+H57Nl86BXWSwjOJ3aaSErWL18PaklV/njJfkAT93l+aj7MHOxezeyzF40XWBDeAg191Kcy7VTnIKi6dtRhXwD4RrwOEcIMHjlV7JHNOx9kb1/23jxlk5Os8QXkYpo7A3KROo6WsFRGlJe+STcbLW8pmqFcJF5VWPObHZj2njlGpZPoDr78nA/GpWyWXcdU2ZBTyVLZSLrUJBsR8HQS8QobUpzByFHVMoko0IsozHTGwaZQ+caSlXxir0PYkC2FmvUS36fY4XnLZgEOImt++YuyEkFIAU90TbHk1G7G+DFqv9h7O5QWnhpmcv/fedVCnZ331eEdQ42e/IZedCpMy+2pTzoG2XAZAHBMxlI1k4PYjFZN00XW8IFWPA9PIZmu/8I/sGMa7k4PI3y3e/wyqyDHKqsJU/YA+NCcb5gkXnoI9GtPhOSEzqRF0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(2616005)(36756003)(2906002)(7416002)(356005)(5660300002)(7636003)(82740400003)(4326008)(82310400005)(41300700001)(83380400001)(36860700001)(31696002)(16576012)(86362001)(40460700003)(478600001)(31686004)(110136005)(40480700001)(53546011)(8676002)(26005)(186003)(70206006)(316002)(8936002)(54906003)(426003)(336012)(47076005)(70586007)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 19:24:00.9771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7559f2-725f-43c3-9e1d-08dafe408c50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/23 09:01, David Howells wrote:
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
>      ver #9)
>       - Change extract_flags to extraction_flags.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>      
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
> 
> diff --git a/block/bio.c b/block/bio.c
> index ab59a491a883..683444e6b711 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1249,7 +1249,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
>   	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>   	struct page **pages = (struct page **)bv;
> -	unsigned int gup_flags = 0;
> +	unsigned int extraction_flags = 0;
>   	ssize_t size, left;
>   	unsigned len, i = 0;
>   	size_t offset, trim;
> @@ -1264,7 +1264,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>   
>   	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
> -		gup_flags |= FOLL_PCI_P2PDMA;
> +		extraction_flags |= ITER_ALLOW_P2PDMA;
>   
>   	/*
>   	 * Each segment in the iov is required to be a block size multiple.
> @@ -1275,7 +1275,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	 */
>   	size = iov_iter_get_pages(iter, pages,
>   				  UINT_MAX - bio->bi_iter.bi_size,
> -				  nr_pages, &offset, gup_flags);
> +				  nr_pages, &offset, extraction_flags);
>   	if (unlikely(size <= 0))
>   		return size ? size : -EFAULT;
>   
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 19940c978c73..7db52ad5b2d0 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -267,7 +267,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   {
>   	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
>   	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
> -	unsigned int gup_flags = 0;
> +	unsigned int extraction_flags = 0;
>   	struct bio *bio;
>   	int ret;
>   	int j;
> @@ -280,7 +280,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   		return -ENOMEM;
>   
>   	if (blk_queue_pci_p2pdma(rq->q))
> -		gup_flags |= FOLL_PCI_P2PDMA;
> +		extraction_flags |= ITER_ALLOW_P2PDMA;
>   
>   	while (iov_iter_count(iter)) {
>   		struct page **pages, *stack_pages[UIO_FASTIOV];
> @@ -291,10 +291,10 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
>   			pages = stack_pages;
>   			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
> -						   nr_vecs, &offs, gup_flags);
> +						   nr_vecs, &offs, extraction_flags);
>   		} else {
>   			bytes = iov_iter_get_pages_alloc(iter, &pages,
> -						LONG_MAX, &offs, gup_flags);
> +						LONG_MAX, &offs, extraction_flags);
>   		}
>   		if (unlikely(bytes <= 0)) {
>   			ret = bytes ? bytes : -EFAULT;
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 9f158238edba..58fda77f6847 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -252,12 +252,12 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *
>   		     loff_t start, size_t count);
>   ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
>   		size_t maxsize, unsigned maxpages, size_t *start,
> -		unsigned gup_flags);
> +		unsigned extraction_flags);
>   ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>   			size_t maxsize, unsigned maxpages, size_t *start);
>   ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>   		struct page ***pages, size_t maxsize, size_t *start,
> -		unsigned gup_flags);
> +		unsigned extraction_flags);
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
> index f9a3ff37ecd1..da7db39075c6 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1432,9 +1432,9 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
>   static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>   		   struct page ***pages, size_t maxsize,
>   		   unsigned int maxpages, size_t *start,
> -		   unsigned int gup_flags)
> +		   unsigned int extraction_flags)
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
> +	if (extraction_flags & ITER_ALLOW_P2PDMA)
> +		gup_flags |= FOLL_PCI_P2PDMA;
>   
>   	if (likely(user_backed_iter(i))) {
>   		unsigned long addr;
> @@ -1495,14 +1497,14 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>   
>   ssize_t iov_iter_get_pages(struct iov_iter *i,
>   		   struct page **pages, size_t maxsize, unsigned maxpages,
> -		   size_t *start, unsigned gup_flags)
> +		   size_t *start, unsigned extraction_flags)
>   {
>   	if (!maxpages)
>   		return 0;
>   	BUG_ON(!pages);
>   
>   	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
> -					  start, gup_flags);
> +					  start, extraction_flags);
>   }
>   EXPORT_SYMBOL_GPL(iov_iter_get_pages);
>   
> @@ -1515,14 +1517,14 @@ EXPORT_SYMBOL(iov_iter_get_pages2);
>   
>   ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>   		   struct page ***pages, size_t maxsize,
> -		   size_t *start, unsigned gup_flags)
> +		   size_t *start, unsigned extraction_flags)
>   {
>   	ssize_t len;
>   
>   	*pages = NULL;
>   
>   	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
> -					 gup_flags);
> +					 extraction_flags);
>   	if (len <= 0) {
>   		kvfree(*pages);
>   		*pages = NULL;
> 

