Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F067A29F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjAXTZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjAXTZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:25:40 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD026474DD;
        Tue, 24 Jan 2023 11:25:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fphmW1u/6kSdcAL4iRMfkk65dZPTExP3yyUDbUtSNoYN85SQt2GSVMIa7nl7pX1lMAhmv0M9YsV7pGU3jjVZv5rEHLl4JpdplaUJkw/4ImWFBm2ImDUSaRaCAtFBjyLFzFZsRg9SYfanzMc6PjFeV68aXmaBMupIbbhUGIslVKfkRn60IPJPihGLxsVh++E0ZXnres/eOWGus68l+JM5UdD/LT68aMJzJROpIhRl7oblZppZjzDQeWZStinkvpfpVDLcwSFThEEgc88oibgjaHAz6SsXUEnDy60wikUVfTlxffVUeew0pj/OdQrQrCje0cJHIpviTQ6tGlhRiyfQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM1OkKfp25+Qv1Y70mZQXwoUC2f8XN84N8AGzsTjEtQ=;
 b=HvZuAG3GwSN2BM+ZILWLx2nOU331MOaWEE+vBzYx8TOgMAJ+TrPzjiydYpaVTkNb6PMbBG1U/HqNI3klhdqTpvJBHsbTeCDBurw10nlX7Kx+qUqVqJ0RvnXx/1PsB9U7ALpBRUJ+voD1MW37vX+8eFU6M23jeSeb56GMrD3oXGBhwgCnbzo14HUQplTgOVy6ATEy0QxBY9l/XMEL4E3Yxoyfzl95qbZ2GAskNWdgwN7REM+sqhcs/CQKG4QpnmTukGsG+J8FfXPo9UAaBP6fQtu6jF+jz/VIZZ6tnnacrdzyctCuQnSus2iXhIIGO77zNtWdIOt1JSnLIlirEwhKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM1OkKfp25+Qv1Y70mZQXwoUC2f8XN84N8AGzsTjEtQ=;
 b=WGeHzQ928CNrIPvOgpkNlbipeGAO1Oy2tLax8QfBHs3/qUiehQagr0s/n96+VOH/SRUNoG+Vto5YiR10cuu6nkMvMYdpO/ZCJwNmhN98tpUErkgyfqwpQ7LyoJQgiPh78uU6s94XUPyItAw9I6kJmQXfqOo8Y7rmYf82M7XmlUNjt3iQZ5NUKzag0at/P5WUXMnQJiVwKdSd7dB7VtJeTh2H6Pu5RHNdf1hJyLxxRE9JzuX+SVX5pETj01GQkyz+Yfhf1duAxb2PPh3fHfS/N36DSU9ENdOC6omOqXRLcueRHe3KRQyGQEoRxL2iy6d3CxONkdXCYS0gzP8N5KTLvA==
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 19:25:31 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::ee) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 19:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Tue, 24 Jan 2023 19:25:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:25:17 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:25:16 -0800
Message-ID: <dac764eb-ef21-4ec5-bcd8-102ca4d49f20@nvidia.com>
Date:   Tue, 24 Jan 2023 11:25:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 3/8] iomap: Don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
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
 <20230124170108.1070389-4-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230124170108.1070389-4-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|BY5PR12MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6216e5-7198-4e03-fdc9-08dafe40c1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELE6y1oH/cIdjNl1skh6RYJgOBwPfv0IPjKak1fq/DTr0BQjrffzZP8wF7mcgDvyCcFYvKDeACC7ZOgEhRLdIqhFVXARGrOaCff5BFF8SWkaR9Q6tm8H3jBzhWu3KR2QyU5kS1BUELwf9P2hcmmDrlGDUp/W/EQPMDI/ShHUGYkcop4p3PY68kuACmr0qvvXX0xdzzJkDYQE36j9EbZAQcWKKEd3iIuoVJl4TrUNv6TcsHG7X/6ouwoHqNAaM4uL5HqFuvrJpSzISh+eRQLvIGETzInUcHeNa1CDYe2kZtUpFUSRaMNXEuYnTbvautCgiUYaRydqNBbhqqmmWhsuxylJ0U+AgWL7Fadh/xzr4oBauA86rPvLcFbPaZ/xANHJ71Z9t7C8JJGu1f8QhR8aLPgPCIGjn4GKvTCXXzwK7rmxQrABEpUFbo+SQawmQhYyCyUSIv5iJqAxRTMmeUPdGdU3C8Df+xOSp4sMjh6x3mGlYYehhaz5gGqohxaZCFbEKrT8APpKA3s4btLL8gBJ07/W2qp/lSgScleNLZIvpb9m9UJjzYH4YgMnEEU4ny/XKqvJQUN4I5+ZYlVWigohA71AUhNhdo677oQcI42bMYK1faYjjtFjmazyOagNmkk+eYdaz6DFf2eTS6P6dqMU1ZG3W2+GRFAYO90m+/xuUf87LDcJkBPzFJNrqcMyVYakoHJhNxjsx6exvaLdZwpkqdToA5PX47ebz6begNnZhgY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(5660300002)(41300700001)(7416002)(86362001)(356005)(7636003)(4744005)(82740400003)(2906002)(4326008)(82310400005)(8936002)(316002)(40460700003)(16526019)(40480700001)(26005)(53546011)(16576012)(8676002)(186003)(47076005)(336012)(426003)(54906003)(2616005)(478600001)(110136005)(36756003)(31686004)(70586007)(31696002)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 19:25:31.0546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6216e5-7198-4e03-fdc9-08dafe40c1fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
> ZERO_PAGE can't go away, no need to hold an extra reference.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   fs/iomap/direct-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9804714b1751..47db4ead1e74 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -202,7 +202,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   	bio->bi_private = dio;
>   	bio->bi_end_io = iomap_dio_bio_end_io;
>   
> -	get_page(page);
> +	bio_set_flag(bio, BIO_NO_PAGE_REF);
>   	__bio_add_page(bio, page, len, 0);
>   	iomap_dio_submit_bio(iter, dio, bio, pos);
>   }
> 

