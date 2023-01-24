Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95893678E75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjAXCnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjAXCnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:43:06 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB5E7;
        Mon, 23 Jan 2023 18:42:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttcv/M/qoYKHEHIczQBFCNPhNkn7ZddFAzRdY4DQuFibdSKihkFu9EU+rPpmVN3w6XLVmpcf05wuzZp0+CrUqc+xwFb+skT7HMZUPMWJtwYCsSg8+S+q8vtmR0sKh4UdSmQWShxI+967nOpw1mYLaRzZT31+b7lyg/biYRLQ+d9SPHmbM2qwn7Arpo0RHXRnZYVwaEieEvxKdiNbsWqUBO/3hy78At4rOQZR+rthq4pjtkA8qdaV4ZMgvRTpacJX2YtC2gXVwiS5mMEnMp4hyxkzhQtN7YuWcWPk6/x/3DQ+Q0siG0Zf3HX8wU6y5DFKpkW3Z0Yk+X0fbrqKzjjS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AIWNMzbnkjwl9icr736Rux8vaGm+5diKs0Z0Xgnsm0=;
 b=JFjlTWrvGwxHc9vcrpU8tHqLKzg9jGrS29J6aS1PNvCgcXk0iQOTcg7cD1qtSvNyy+twfNnR2u5/2aCxClNGQ0cGijadedKTtcFyMKlhq/zUtFmz58NrSJadn5gMq6SsRVFgS0B29HyUBpTi/Hd6WKNjqiLC842ty1q0+ZIecZ6N70mva3r0i7CPPlG6SYf31fPIFQ8Csq4jrDmV3JYoM3KFp5SDs/t7UcGhRM+IIkK6vxjWWyXPOGHHQmVvs0ZWWf0ISDRtZrNbJbqWf8LHnhZXfU6HYmjAVoa7SnK7knYXGmQxqVvXc/VbKEFXUjm5BOJ4foHCYf7d3aRNvelKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AIWNMzbnkjwl9icr736Rux8vaGm+5diKs0Z0Xgnsm0=;
 b=GDTKXNJDktfYRGy+aU4yONd7uzxwWmWdh3c+O7t0woIESHnFoyOa41ynQkTKLKG6P2aAejBTCr7FJAO0/aqxSXGxeJ2YsStiaImnTmL9HVeMnhzfF77OXh2TKNBARwHIuvRy6ifABbOjg/j2cRSicjPKVLdcF4HUOcBVUZGXBOAr1CRBgmWhQBDBE9j91CFn5XdwskYhtfMcUdExXuHSHW4aM7TU9jIw1EjpjrD2iBXX9+XlUr8pUN6oDI62mk6f/IjLIK79SSlLoiGFK13FgX2gO15e25NxHiogXWbnvAT5/1Tp+rdXRPiLUmg4glEFUyiYttd2mdRLWnYEeNx5+g==
Received: from DS7PR03CA0217.namprd03.prod.outlook.com (2603:10b6:5:3ba::12)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 02:42:35 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::d3) by DS7PR03CA0217.outlook.office365.com
 (2603:10b6:5:3ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 02:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 02:42:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 18:42:29 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 18:42:29 -0800
Message-ID: <eb1f8849-f0d8-9d3d-d80d-7fe8487a15f4@nvidia.com>
Date:   Mon, 23 Jan 2023 18:42:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 04/10] iomap: don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-5-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230123173007.325544-5-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7025a6-6ae4-4deb-1acc-08dafdb4a658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUBr1WNfG640T0XM7eusicD+6kiqjwih2MVx6CmSFuL8V1UI9V+hIvexBLDR/1w1BI3w/3FwOEd7lm/5eqMY8hipSKWJmm2NyJZQUkI3q2V+2g8mq75FohDh4Xf9dJobcHk2wAoQSw+z+/o+TUU6KxeMD5FiC+dw7fIa+4vCKwO3rumIMoBAS9V66oBVKUpcgB6eYl+ct8lS1aoM3MyQQ/zNkzlXVfp/hjIxzzYXUP+AzoBy5PxW+0qd7HJyo8PqDVImcN+YniOdMP2tmWlk06CdaWvC8VQUfBPti+HVrNQtXG5oKvhRRMRD+v8boU62o05I0ZOl1DynjoTpS9+SFV40c/vj+h9EEjc//xQtnK+mFiTkAOaiXGlDBCOKoWV2rV095k+8ZKVHZQ0nSSdcGNGCAX+ty3iLhJADUIsZzGQnSiMpmJNR3VYtKtLZ/dubHqRhbFIoVk3kCqN6QYFJ+IYz1G15etrxDA8VnihNEf35EKGUW9pmBLe3lU4LyFd4dTqYwRMjRJFWVQwH6aBHpo5yxpHq5OFi3nAzBd2irirhQsLNKvarVgxUFTwqGlG0X1Jx1t48Km5BOhuBdongqnz2BkPXh+TO7lTSMHKdYFX1Kk3LZ/R1Uhm0cROWoivL6Rv2+WD47bIMJqKzmO2G8cMnwShPi0/uC8pxgD1JxB+awX4eEcjt4VJsZWO+IhUHujku0iGx9x9pFJo0KgUjFv6mo8j4PKvbyntZCHMzMGQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(36756003)(70206006)(70586007)(86362001)(8676002)(4326008)(16576012)(54906003)(316002)(40480700001)(53546011)(16526019)(186003)(26005)(356005)(478600001)(110136005)(2616005)(7636003)(336012)(31686004)(8936002)(7416002)(40460700003)(5660300002)(47076005)(31696002)(82740400003)(82310400005)(426003)(2906002)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 02:42:35.1663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7025a6-6ae4-4deb-1acc-08dafdb4a658
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 09:30, David Howells wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> ZERO_PAGE can't go away, no need to hold an extra reference.

That statement is true, but...

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>   fs/iomap/direct-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
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

...is it accurate to assume that the entire bio is pointing to the zero
page? I recall working through this area earlier last year, and ended up
just letting the zero page get pinned, and then unpinning upon release,
which is harmless.

I like your approach, if it is possible. I'm just not sure that it's
correct given that bio's can have more than one page.

thanks,
-- 
John Hubbard
NVIDIA
