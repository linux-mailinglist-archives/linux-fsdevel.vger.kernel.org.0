Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F3967A3EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 21:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjAXUcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 15:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAXUcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:32:08 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2C2AD2A;
        Tue, 24 Jan 2023 12:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVsAXeGxOvz2kFADzljmZEWqBA1RfztE/tlD2nwuFxdGshcgNC42WmcOafAWOEeOHBtywVTJ7xIxoIXEMRSwzZd/IYmxhkfih/aiGMQdkVvnQ54IUexV20vXMhGgLgAmdXjYfZ5VYAqCBTfHQrqVc3ZG+23uxIpFSX0KIUl+9eQTPZaL2HvkV9Qhn4hE1+abDaTs+Wwz9aYsrESkcL5CvcPNS2bDP+x9U1IAzxTOzLCfhWKKtCb225Tuqdwm7Eo/cfqmSRVGNB6uCc/VO/MAgGwrohrY0+hQ6NkXfv1nitRn5Ny9Bwfp2Sq4InKjsn5Q+0ARD4JqO6X7S8FCdDM3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2fda49ycLyC38hvtVHurB4o1JnTe0GhHvqYhEsRXBs=;
 b=GQxUn6ZEGFLQzufTu6bAjDpUXGAdOgxP9iLHTM/rIqcQTyQOxByFH+KDCsvVVjJvlXJHBlEZrx6cAsoxRKDIT4jOhoYiEefckjfbw6eekbHmp03U55af2+Kf8v+DipdEpkOIVscTVnCUIv9TltI8LlM0WiwaOSs3FH4ZHC1qaXatogLEx4JihCLK/12MWg8ufhTknhkRjyWivpbUlda6pPJGt+wywQhOEMQlG4qk9cLAZO9/1Nz84XssEkr4psmnH62/5KOuJgQBE4zLi2uXR/a1UkxktYGHL7KsitLi9VrjkDUpoFeUS2XUWbv7c6QisMb543JRaS3znEdq2oqAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2fda49ycLyC38hvtVHurB4o1JnTe0GhHvqYhEsRXBs=;
 b=n1tKWewEsM1xGQ3w9ZaJqg8X9xvm0024a2/ebdq59bAK0R9ADfCxHkBTI1IqdMFrmrtxucq6TVVtZgJSGVWeE4k0ujyegbGBcVPHUqc47IwS0sJXxhM98fUxei5Aywm7OdY1mY4WoLX2qPnJeD1r4wmWZ+8ayf+dg8YPxMSGpw2Nvyl4bY5jO1mxhwXOS6JqXsmHWPOIoZLxRgcDqcaSnH1L0Yp1/+raCG0G1UiUNcj8tXxvoM5cxA8zoHhva6slNUb/JlfRFjTbtyAk4yua4sfxe0FCVk1MnxuiGOxDMW4iDsPVT+Mxxw/pjFMbiXWpzw2SaOcjQtjuo/ax+ypsLQ==
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Tue, 24 Jan
 2023 20:32:06 +0000
Received: from DS1PEPF0000E63D.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::7e) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 20:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E63D.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.12 via Frontend Transport; Tue, 24 Jan 2023 20:32:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 12:08:16 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 12:08:15 -0800
Message-ID: <df718bc0-2163-a7a7-8c5c-db22e9320b7c@nvidia.com>
Date:   Tue, 24 Jan 2023 12:08:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 8/8] block: convert bio_map_user_iov to use
 iov_iter_extract_pages
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
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-9-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230124170108.1070389-9-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63D:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1a86b5-52f9-4424-d4c7-08dafe4a0f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wqc65LRXfWXoQPdJAoVXsvffjESIhpTypEft6/bnDP4WjjG2hpJbQezFXqjbnu2jC8ZjAPPToRHBMU5A+n6RfWTsoMTbdeXbpcztBtuV+amssWHveYe7HJe4Es1/Yx8uxWD0C69GPKWVK1UD76iojJ1xCPkBE+2rxLbjjflGHFWAvdEBl8zC0iu9Fnfca16dN+IgcM8DvZN7tRd8Mzz15lBqojxp8lKCF55w7qHAW7przzfJE9YMRSLoV3BdU+45rzCszC2k7Msf+S+24NkWnZXBKUDeTpSjkHrYFaeDCdxuofUBj8B/HmCcfNf8us5gbeWYRZnjqLEhqbWAaJGmhx/T3C0I7aE1NWPHUTPtqKEXT5tClL1NDXVxjCcYUKLkNeMZkhQerEoHKmKrDrUVop0O+w9olSt6NR+mr4HP863kAH/pIr2Sx6/uL4b8K+fRuE+O1ur3vnyuR3l/tPaZA7BDde5cBJ7Wlk1BHnlnjkld1aDwzqWjQPDPKgD0v/Adhn4JbkONinW0U1vdRV/KuRJDsBCaXcP7PVGQkZJw2LjCLvkJr/sQUODKk53ws90GX+OwnC2v2kPPQUvm11iOGMr1mAQ8ZXHchhmS7OSGh1VwfgRrpX/0X2Nkx8cRWkDl6/SuXYYY/+bANM8ZMKRSigz1H75E9yr2Tf98zc0cW19/kV7E+OorQC5aLuRtLhJn9w0lfIIA3TNqz3RU8xJqQAEpwO/u6qfqGfdVXyB1WQA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(31686004)(36756003)(86362001)(40480700001)(70586007)(82740400003)(356005)(83380400001)(8676002)(31696002)(8936002)(5660300002)(7416002)(2906002)(70206006)(7636003)(16576012)(36860700001)(316002)(40460700003)(478600001)(82310400005)(110136005)(54906003)(426003)(16526019)(47076005)(41300700001)(4326008)(26005)(336012)(2616005)(186003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:32:05.8514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1a86b5-52f9-4424-d4c7-08dafe4a0f0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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
> This will pin pages or leave them unaltered rather than getting a ref on
> them as appropriate to the iterator.
> 
> The pages need to be pinned for DIO rather than having refs taken on them
> to prevent VM copy-on-write from malfunctioning during a concurrent fork()
> (the result of the I/O could otherwise end up being visible to/affected by
> the child process).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org
> ---
> 
> Notes:
>      ver #8)
>       - Split the patch up a bit [hch].
>       - We should only be using pinned/non-pinned pages and not ref'd pages,
>         so adjust the comments appropriately.
>      
>      ver #7)
>       - Don't treat BIO_PAGE_REFFED/PINNED as being the same as FOLL_GET/PIN.
>      
>      ver #5)
>       - Transcribe the FOLL_* flags returned by iov_iter_extract_pages() to
>         BIO_* flags and got rid of bi_cleanup_mode.
>       - Replaced BIO_NO_PAGE_REF to BIO_PAGE_REFFED in the preceding patch.
> 
>   block/blk-map.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/block/blk-map.c b/block/blk-map.c
> index 0e2b0a861ba3..4e22dccdbe9b 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -282,21 +282,19 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   	if (blk_queue_pci_p2pdma(rq->q))
>   		extraction_flags |= ITER_ALLOW_P2PDMA;
>   
> -	bio_set_flag(bio, BIO_PAGE_REFFED);
> +	bio_set_cleanup_mode(bio, iter);
>   	while (iov_iter_count(iter)) {
> -		struct page **pages, *stack_pages[UIO_FASTIOV];
> +		struct page *stack_pages[UIO_FASTIOV];
> +		struct page **pages = stack_pages;
>   		ssize_t bytes;
>   		size_t offs;
>   		int npages;
>   
> -		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
> -			pages = stack_pages;
> -			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
> -						   nr_vecs, &offs, extraction_flags);
> -		} else {
> -			bytes = iov_iter_get_pages_alloc(iter, &pages,
> -						LONG_MAX, &offs, extraction_flags);
> -		}
> +		if (nr_vecs > ARRAY_SIZE(stack_pages))
> +			pages = NULL;
> +
> +		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
> +					       nr_vecs, extraction_flags, &offs);
>   		if (unlikely(bytes <= 0)) {
>   			ret = bytes ? bytes : -EFAULT;
>   			goto out_unmap;
> @@ -318,7 +316,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
>   						     max_sectors, &same_page)) {
>   					if (same_page)
> -						put_page(page);
> +						bio_release_page(bio, page);
>   					break;
>   				}
>   
> @@ -330,7 +328,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   		 * release the pages we didn't map into the bio, if any
>   		 */
>   		while (j < npages)
> -			put_page(pages[j++]);
> +			bio_release_page(bio, pages[j++]);
>   		if (pages != stack_pages)
>   			kvfree(pages);
>   		/* couldn't stuff something into bio? */
> 

