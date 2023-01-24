Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945367A3CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 21:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjAXU0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 15:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjAXUZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:25:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AA4ABE9;
        Tue, 24 Jan 2023 12:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxGLRBdQegsfNiswyksbnFZAzwIEs7xsqq77RMCEDaGaVhCs0zGm5/jBg7EHvLXwR1EB2FHvDIinpdyCc9m0bUdU+r7QHXMqHoAgZHtAqkbWTrVLyMPxoC+WF69VRz5mGHIK+TclmpSnGEAy9ve14uj3DDOyPjHo790Of/dZXTZmCPbpTOjn/7BnJc1ACY3wk2DJGpEN4CX9tT+nyiovd9mP0XgmnRpSUaIzP57+OxwFpfP3eTPdtua1BRrYIN+xsIpC+sKVvhhT1O/DL4TstBaV7xeMAsVfH0RMhLlsgu+vUa8R/2QLiYuKW82drVpdusJISevotUR9cXOOV1T8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMI1u5r/RYaBF9q378KN/DbUHr9RfUddXU5SXVEvq5g=;
 b=azZpqKWMc0Is2SCb3jvqTD16g8mU9HX88KOlSB1+IqcUDbtf6dKx2wry8QCJ1P9xJu83MDTBdD6C1dMItuE7Yjuw3yz/EztOKy+LIAjPeoA3db9j+Pve+GhH7XDQTnS1OfiApy0AY6H5yQsTKqnXPai0xXhpzLmbysqdge5I+yS8fKQjCgTrr7PHHYEmfQXpIfKXrCFxghF3/XEeu0RJtrwkcR1t74qgk88ZLRvthNHtADFIhf7HAtq+HdYz8GTyhoaFtSvYA8p7cCgl7scG9j9vrtsVgmL3mIYXN9NuA0rEsDCAHi/ozFpe07FqHfI2eIO90UeR5/e3T+b3Sn8r3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMI1u5r/RYaBF9q378KN/DbUHr9RfUddXU5SXVEvq5g=;
 b=O9mhnniJuiv6sSVpsl/W004IEkZD8jiXCCSo7Fm+Z7v/NaRqY8635w3AmEEYXzg5YYY8m0R0M3X3uwB4SIKfUFYUJEMlTfbHtCnJFRWMWoivoJp0CHDZJdd6zmr4tSO5NOZ2zxdyTfbeCmQW3WEAROjSTv4zFUT23S0A9Sunjc6XKqXmgYp/oBhsdb5ZYjUePZR01o6jU/hBPmmfV8/byaJmTHkl3Le+EaZ4DmiP9//6fq+RyiKlUOdqsQu3uiGLsWRaUAa04gpY0a/Zt3GgNELb4g6tY4/Ooja5ym6Lwef0msPmE1/qI3ZgWDS2dmweOY3lFWwCoGsktoL65fFvVA==
Received: from BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::21)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 20:25:39 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::d4) by BN9P221CA0027.outlook.office365.com
 (2603:10b6:408:10a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 20:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17 via Frontend Transport; Tue, 24 Jan 2023 20:25:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:47:36 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:47:35 -0800
Message-ID: <b7833fd7-eb7d-2365-083d-5a01b9fee464@nvidia.com>
Date:   Tue, 24 Jan 2023 11:47:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 5/8] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
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
 <20230124170108.1070389-6-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230124170108.1070389-6-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|BN9PR12MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: a613e488-b483-4c21-a615-08dafe4928cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUJ8g3GZDzczwZwBxej/naWyPqie9zNHZfljmIDKYBPNGtatxJ3UnirVNeVq3YAHewG0iLkoI3qw0LSiEOoanHNCoXIsUVUUAi4iLuiz2hm4n7jQZ3NRdW9H9w13FV3mFR8Xh1DDQHTXejKIvI+pIYgkgaayvryaaTsLiKSgaR+84C/PL8ZNrwgDV3lubPnGT8X5o0Yzp6JAdKYiC1m9SrDTRFU2b0fXfPVZ7Pczu+bCrKlds4oR8Z5pupDL5nSeJOnu9ZFi5IMlw3t1pdTh1tbTyPdZ9gNbYPnzDjTxW8koKrqis7Ii9IB+6HDqFBOvTbMFZRJvt6Imik5lETyoKRykcF0FGduUDzfM9uLU4RKA+sIRTueq90uX1O/+ubtoCr8h4CAOKFouOWtpg+ancGuws+SdzYTj0Z0zvVP5c23F5twakvbwEZQ/j9WW06hD4OGbr7CeG6rLYYn667HFFKuhRoS2gjZwh9U635/t+pTc1Tt83tB/idi4UhE6+jK8L42N6vPKmNriptGy+2D6LoRGxLioEn90YHrg+CAgyEO3t5HSN3/oezprWUnKRhBtyMSIrQUtoxiMHuNF6FG5W9hw8ufHqhJddWPwrpscrsFh7+NMtWZPi5USCyAfc7VJAoCwmkSlpJHDS4BF9AliGLUMXBBq/kbaFsjdMLkpfVIo4vqxUzmCOmz4BTkXnHEokzrJ9Rt3cMBKIqC4C8YYgrqMQbsHs+dHtRIXi+LyobQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(7636003)(70586007)(82740400003)(40480700001)(40460700003)(36756003)(356005)(31696002)(110136005)(16576012)(336012)(478600001)(83380400001)(316002)(70206006)(8676002)(4326008)(2616005)(426003)(47076005)(54906003)(31686004)(2906002)(53546011)(86362001)(8936002)(36860700001)(186003)(26005)(41300700001)(5660300002)(7416002)(82310400005)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:25:39.4883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a613e488-b483-4c21-a615-08dafe4928cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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
> From: Christoph Hellwig <hch@lst.de>
> 
> Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> meaning is only set when a page reference has been acquired that needs to
> be released by bio_release_pages().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org
> ---
> 
> Notes:
>      ver #8)
>       - Don't default to BIO_PAGE_REFFED [hch].
>      
>      ver #5)
>       - Split from patch that uses iov_iter_extract_pages().
> 
>   block/bio.c               | 2 +-
>   block/blk-map.c           | 1 +
>   fs/direct-io.c            | 2 ++
>   fs/iomap/direct-io.c      | 1 -
>   include/linux/bio.h       | 2 +-
>   include/linux/blk_types.h | 2 +-
>   6 files changed, 6 insertions(+), 4 deletions(-)

One documentation nit below, but either way,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

> 
> diff --git a/block/bio.c b/block/bio.c
> index 683444e6b711..851c23641a0d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1198,7 +1198,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>   	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
>   	bio->bi_iter.bi_bvec_done = iter->iov_offset;
>   	bio->bi_iter.bi_size = size;
> -	bio_set_flag(bio, BIO_NO_PAGE_REF);
>   	bio_set_flag(bio, BIO_CLONED);
>   }
>   
> @@ -1343,6 +1342,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   		return 0;
>   	}
>   
> +	bio_set_flag(bio, BIO_PAGE_REFFED);
>   	do {
>   		ret = __bio_iov_iter_get_pages(bio, iter);
>   	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 7db52ad5b2d0..0e2b0a861ba3 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -282,6 +282,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   	if (blk_queue_pci_p2pdma(rq->q))
>   		extraction_flags |= ITER_ALLOW_P2PDMA;
>   
> +	bio_set_flag(bio, BIO_PAGE_REFFED);
>   	while (iov_iter_count(iter)) {
>   		struct page **pages, *stack_pages[UIO_FASTIOV];
>   		ssize_t bytes;
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 03d381377ae1..07810465fc9d 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -403,6 +403,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
>   		bio->bi_end_io = dio_bio_end_aio;
>   	else
>   		bio->bi_end_io = dio_bio_end_io;
> +	/* for now require references for all pages */

Maybe just delete this comment?

thanks,
-- 
John Hubbard
NVIDIA
