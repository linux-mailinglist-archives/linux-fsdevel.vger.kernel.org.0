Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC76367A3DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 21:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjAXU1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 15:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjAXU04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:56 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCE4DE0F;
        Tue, 24 Jan 2023 12:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv9nznBbfYaWMC5PdWGgIf1L1XcYuZUAUgr50l/S3J/mcSCTV1tW6xswxz0x8ZsqGjISaRBgZZFq2AKDS1W1Qj16s4Q1K2qeX7NObBzLaBKpZNVWjOpH2fhFvEqGP9XqVTGBxj9CiSHfrV8kzYCc37Jrwg1+pFZX8UOeBnFRRDc8xwC05E7BgK03QsS9AKMcKd2DcEN7Oc2hMn6HVx3JFs3V4K/6zXnRUzmmgkbN6y+qwaw/rsfez1HwyDZ+20QlzQ7CtRetmqRf1ohZHHSEUGERVdzfuU6TcMypZtTt1dFAfxkWdq4ZdRMJXpfLfhLBqwD1CJ3KMggYtNBW6ty54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGayIN/7yYOxf1NuH5oLbEOmo3VhAGKxrP+rFw/dtJM=;
 b=ij0X1U2/SPnx7DjO6EEhgaggxHwVg2Xwifb5mhI8XxxEwQD8+BYSB11XPRrLXhgCmO4mPWovN/uoAIaRJ0nVAPPq5HKSwi0iSGyY/6gOyGIJWfyG186lF/RXqPa00LgCnr88LokU/w1CvYd7Zw3/NuWnWtXRUZKzj3pulkQtJmvnQ8mUGtyzMJ4fxle9g9326uS25f242+VmeTXUHbMeHFdn5fUmbULWQHrvq/q5OaFnVTYWBD/MOJn8pwwIjTzWXyO7hy5F3lIqnMltSEaM7zOPjTVB3+W7UyjCnUsXYKewfcKy4ePJEvzwiIDs6NLPrWIlhbSEmMUAAM1/nHt61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGayIN/7yYOxf1NuH5oLbEOmo3VhAGKxrP+rFw/dtJM=;
 b=a+WN0ekslhib51bmvsPhu6p+a/xwBE+kEzO/HMGRn5uSFUzknIjFc6HRvEQas7GJ1QtlQfPZvLaDMYCV5NVYFFRitWChjApKm45HCkhu9JukMxJNndxtDQGOiX6ggW55YghV6sjm/NKWgYUi0chlUKERJmDaqxNigMbYZ+LBZx2yTtdIK3DDNOrvvSoeKc1A3+xhEINeXm/0A0Bq/vTqijq5wxV9puhijYm9UBiNvmGPCOw4MC2orCpxd+qu2VF7w7tHcLKVDl0RuCY13LWgr2nmVNIrj4MrzrLHXesVgWz7GAngXtomlOYVmTTZaI0oaHrG26IrUd5tdgNd7WeGsA==
Received: from BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::14)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 20:26:49 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::a0) by BN9P221CA0022.outlook.office365.com
 (2603:10b6:408:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 20:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17 via Frontend Transport; Tue, 24 Jan 2023 20:26:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 12:00:18 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 12:00:17 -0800
Message-ID: <689058d5-618b-d487-c168-5e8d3733321d@nvidia.com>
Date:   Tue, 24 Jan 2023 12:00:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 7/8] block: Convert bio_iov_iter_get_pages to use
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
 <20230124170108.1070389-8-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230124170108.1070389-8-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 701bd5e8-a0d4-46ae-59e4-08dafe495248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6ci0Rn8otFT/EViW57CY3yyNLyqtd71+A/luYJQfAUFlLDAfAO/KS/a+HwN+RLUgvS8bpsVLoicFHHpct3RHpgAPvSbhFdoIItQGeoHMn19xrQamppeKJS6miOkHvkzVDlgiEOIpViLUVDmCi2+49Sne2IBwdx4smDfeodi7QlNMI9/PhiCyGdGn1NYmqDyJQcF6XoghNdj5W/gLfEo51rEXRrabcv/TgA6QhgB/aS+c9Z6S8yRAA5HTU+tys34qnC94K3/MWX9NdKm187+tqEVVIikRrCP89ZPFXscfR7uNIbozY4JUAPS8p/2g0teI2mrgdbCV+NFPJMRHr96RoMLnR35+TlbKer3gli7zoeq6I9sy7uHRc7tYaKtdYHPK80eS9X4kcXCLeGGKV6241lJ5oDCe/vuVxr/rIYHAbJzqdT4xd3I/Gq2M+dWhhp3BWH/elpQD9n4cdAKLnl+DKbQdzP9eXECuzWA3VoF2hiBIKDSdPXeseJBhai5F7r5nh8TPl+ClcSdmnlp0BvG6YuSv6cegwZg6dF9bHH9mHc6xJKsHo/wT9s0QtEUr3L76X/0CNfYr6fVHNj7Jq2i1+gF+mrNSTQhJWSfmsCHI7Yq6QW+CsE6ACaz3n7BZcaMUcwQB9nOheFhWq78VIfJ2OHmpDj7JmGBOvvxUKSx6kppiLHxgxXyesUb3G01iMvoaJuweqY9NrS0Opd1X831oiVGIhR2gGpPUGm0HleyttU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(2616005)(110136005)(356005)(16576012)(316002)(40480700001)(54906003)(2906002)(336012)(47076005)(83380400001)(36860700001)(36756003)(41300700001)(7416002)(40460700003)(5660300002)(7636003)(70586007)(70206006)(82740400003)(8936002)(426003)(8676002)(4326008)(26005)(82310400005)(478600001)(16526019)(31686004)(86362001)(186003)(53546011)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:26:49.0543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701bd5e8-a0d4-46ae-59e4-08dafe495248
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
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
> The pages need to be pinned for DIO rather than having refs taken on them to
> prevent VM copy-on-write from malfunctioning during a concurrent fork() (the
> result of the I/O could otherwise end up being affected by/visible to the
> child process).
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
>   block/bio.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index fc45aaa97696..936301519e6c 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1212,7 +1212,7 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
>   	}
>   
>   	if (same_page)
> -		put_page(page);
> +		bio_release_page(bio, page);
>   	return 0;
>   }
>   
> @@ -1226,7 +1226,7 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
>   			queue_max_zone_append_sectors(q), &same_page) != len)
>   		return -EINVAL;
>   	if (same_page)
> -		put_page(page);
> +		bio_release_page(bio, page);
>   	return 0;
>   }
>   
> @@ -1237,10 +1237,10 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
>    * @bio: bio to add pages to
>    * @iter: iov iterator describing the region to be mapped
>    *
> - * Pins pages from *iter and appends them to @bio's bvec array. The
> - * pages will have to be released using put_page() when done.
> - * For multi-segment *iter, this function only adds pages from the
> - * next non-empty segment of the iov iterator.
> + * Extracts pages from *iter and appends them to @bio's bvec array.  The pages
> + * will have to be cleaned up in the way indicated by the BIO_PAGE_PINNED flag.
> + * For a multi-segment *iter, this function only adds pages from the next
> + * non-empty segment of the iov iterator.
>    */
>   static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   {
> @@ -1272,9 +1272,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	 * result to ensure the bio's total size is correct. The remainder of
>   	 * the iov data will be picked up in the next bio iteration.
>   	 */
> -	size = iov_iter_get_pages(iter, pages,
> -				  UINT_MAX - bio->bi_iter.bi_size,
> -				  nr_pages, &offset, extraction_flags);
> +	size = iov_iter_extract_pages(iter, &pages,
> +				      UINT_MAX - bio->bi_iter.bi_size,
> +				      nr_pages, extraction_flags, &offset);

A quite minor point: it seems like the last two args got reversed more
or less by accident. It's not worth re-spinning or anything, but it
seems better to leave the order the same between these two routines.

Either way, though,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>   	if (unlikely(size <= 0))
>   		return size ? size : -EFAULT;
>   
> @@ -1307,7 +1307,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	iov_iter_revert(iter, left);
>   out:
>   	while (i < nr_pages)
> -		put_page(pages[i++]);
> +		bio_release_page(bio, pages[i++]);
>   
>   	return ret;
>   }
> @@ -1342,7 +1342,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   		return 0;
>   	}
>   
> -	bio_set_flag(bio, BIO_PAGE_REFFED);
> +	bio_set_cleanup_mode(bio, iter);
>   	do {
>   		ret = __bio_iov_iter_get_pages(bio, iter);
>   	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
> 

