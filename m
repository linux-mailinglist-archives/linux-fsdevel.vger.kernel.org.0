Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109E95AE0BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiIFHPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiIFHPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:15:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D770E4BA4D;
        Tue,  6 Sep 2022 00:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTMjFDqt1ygT5VVA6D8tIQrCzSJ2z+KHt12S2VKjnDyRKnJP9rLtKh+T6gKeBale7qeBUAZC72TJFRsJUEt7Jucl1Lo82VRR/1T8159Yd6zgEbC9ibrCrYh9X43LNLCne4SRJBZJJOWyud64mGv8ZNNn4qD8tXisUaWQbj5Z0oDa0coDzNZ4LPs50wFOqH064hQn5TumnTGQHTuvj1Hv5cKIjmg61FIOa2jrVIwxESvHwvBOvYSVGVfPq8TlzyYCJeSIJbLh9QPcUPMbHqil643/RNWOHvPu+aA5SlL4ZU9pu7dhBtBTDl0Jefk4obCdV3tevIc6NC45SDvq0JBVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkKAz8KyGeYWnH8tA4W+3TRYY4PBqC9c0KssuOdc+Ow=;
 b=W2XBQNY8MGyeIZUAJ7blyKdkmAfC12gTxcL8ChAhJe9MN5dH756i5D/TdGcuKjhE/QRXA5iQmO/3FpHkTssWxm6FTynLtaZZQu885srCQlH61ia0iO+eFHpGp9QSE6qb6Y9ZJ3YlxE00rDZqcDUxoQ3VqmCJcaFrQ6lLMuKfC5rMXd/Bf/0zRJmF/s/PP9/DkbMp5eHQLsyXD2bGlT/bQZxSNe7TwLRuWWyNnze4WMZmt5t6Tk8/FrkSocVQaRmpYRgC256WMveNjlPPs0cMR/pVQ0CPUdkAx/n4FULWK0sUrgd15/VLPqw9yV2Ot42lNr0siVSdpJK1I3/Nfmvc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkKAz8KyGeYWnH8tA4W+3TRYY4PBqC9c0KssuOdc+Ow=;
 b=DmVWFplyCP75ylN2bPiq5q7iL3A408+J8tQcb67cr6assgcnTqPlhLyW87gWQecld800VcazW0i2EUWw4UNmp9HEHA0g/sRWj9xVcLe9iX6JlJPqUkwRimD4/sVQUbYEsx7C30xaZub7z3s8+vQBc7H0zanklhM7IVnlSx5GMHAdgd4ZBOKEffB0PpjykWQM1EWlOs1CC94gSRpTOrS/xA4rIlN1EKZ+JrNMdvanKNkpIUWh/+xjUevIdwZrkMYmXL6KwXcNoqJv+dqSzylQHEB5PHjZttWSvslJF9VSuR3lwDJB6xs73Nxowf5QarQMooXrwED1KctxJorYI2On/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 6 Sep
 2022 07:15:35 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:15:35 +0000
Message-ID: <9ec65099-63f9-2fed-fe11-f061710ddaa0@nvidia.com>
Date:   Tue, 6 Sep 2022 00:15:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 5/7] block, bio, fs: convert most filesystems to
 pin_user_pages_fast()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-6-jhubbard@nvidia.com>
 <YxbtMhuUgg7eNOs4@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YxbtMhuUgg7eNOs4@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:180::30) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cd174e5-c13a-4c0e-6827-08da8fd797a0
X-MS-TrafficTypeDiagnostic: CY8PR12MB7586:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dHzsr8NUFPCdrBedbeY7U90AechrUH9IdsWvfs2gsm2OxC9rAuiATwgzY+SqjjpdirthU5DuoAMlfP8LaGalX0nbFq7p1OQkUD8NBalx4je/VHECKPo7AQmx/Cec5TSTtnp4CxUlArqYhTuSZf/xde4EueMtmUdlbdaApqMgTsWiQAdSbI6U8y1gxnLIYVv48eEDMiJpwUcsrgJxRKThqav9I+3WTRtpeOQVRwJuwSbUbPVT0rMJG1H5jv0takXpZsgJAbnLNWu/59380vdyM7WgNW0U3suZjMRNBdOuJV6B4nHNJHZIE0BH7aOlieNagq8nF5ASMHjl2/M27GSDtzY4sLLxquMFOq7tDNSX6OR+kMfkkPwMarY45XxuXiY8uMmBMlpJ+PHD9+FcE0gtIW6E3qIyY3NRKehK4BKyhSrFiUo2H95nxoj66MKi7F6VOpezFHW1UE2ptdEosRu1Fa4m5bJC1DM9u/uxy0s8iNV/61sqQJNJJroO1up9izEIj+zy3UjfVIdl7I/zfZVBVsIHM8gqemBtd9WETrt1V7/urpw9B47POiIxfkz9/wMpHzS4HFuH41bfYNWd5qcl9er0ndC65nWMK0kw50VNA8FQ9GcoPru8D2ntZ30/O7XEoKCuf7zmtuN6TX55X9AqC1Y/MQ6BOqvCqQ7DfnCK8VeM71odZovyypnDWxB+s/KdpFUJ0Q1h4clJIT1AEnrZ30nMO56+vwazp9lZpltX0Ue1k9Gx74778/D1gm2qzfpaFAl/l9SGyZd5SuX8qZ/s2pxedO0hN/1ZB1xjXcmQCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(6512007)(36756003)(8936002)(5660300002)(6506007)(53546011)(186003)(2616005)(26005)(7416002)(31696002)(558084003)(86362001)(478600001)(6666004)(6486002)(41300700001)(31686004)(83380400001)(38100700002)(2906002)(66476007)(54906003)(66556008)(66946007)(8676002)(6916009)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG5mRmFBcmw2WU9YYmhrNnI4ZHJlMW5EbXFqWUdrVVIvZEhNRWFaMEk4UDNT?=
 =?utf-8?B?WVRFTkRuVU1Kb21TaEVRL3crQ09VemYza3JWcTh1UndUN3o3TXBubDNrQ0RY?=
 =?utf-8?B?bk5rWGtJVzdBaS9xTkw3YU02ZzE1Qnp2a1ZkKzBnYmNWVDNldCtMbWNZd2lC?=
 =?utf-8?B?QXlKUHovTE9NZ2M5VnUzZnZPbFR3djVQZkpVTkZNanhiVUNLNGR3QUw4ZVgr?=
 =?utf-8?B?Y2ovcU1ud1hwUk5zTjBLMk1Kc1ZSYVhiT2RKVXBmdEhUQUlZSEpDcmhhQmRo?=
 =?utf-8?B?TlkyTWN0cFNSRUhXUGJiZzloenRudFE5TVJueEFCbFlvTUsrZ0F1Sld1K2Y0?=
 =?utf-8?B?dVVkYzg4MDR2Q1Y3cVJtUG5rWXBZcXdod1o4RmUwbkJjTWZZRnRCNWNzK0tH?=
 =?utf-8?B?R1BxakNlcDYzZ2M4enF5WFVxRkxjT05SRGhjUlF4VkpUS3M2dTMxdUYySStw?=
 =?utf-8?B?d3U1bThONWM3SmtlMEhlNnZhTzdDY2lhQTZoRDVoYjNoTFRTYmNiVGJrdC9q?=
 =?utf-8?B?NDlwdHpKcmlpUGFvNktWYXJiR29CZW8rTDAzKzFzTkFhSDd3dEZJRlZHNVpj?=
 =?utf-8?B?cEVmM3ZQRERPQm1mNXlPYmI2TGNhOVNlV2J5UHRoY0ZMQXBZTy9hZnQ4d01X?=
 =?utf-8?B?eTFJcTkyc0lCMjkwUHc2eWNsakN2TkxvZXp1cDk3aVM4Q2sySng3MVd4d1lN?=
 =?utf-8?B?ek02SGZ5OWtUWEVuSnhMTUdiSDJEamVzNGljRXVzSzE0UEh0NkpFQ0FyUnpo?=
 =?utf-8?B?dlNOKyt4MUc0QzNPSFE1UDJQd3JTdG54V1ZLZ1FQRmo4cTIrVU1KNVd4SVVi?=
 =?utf-8?B?WmNzQmNjZ1FWWEREWU45ZkNPdDFjSERjQkpRaENqQzFnSlJ1UFNBbUtISmRF?=
 =?utf-8?B?bWtaNXYyWGllVCszVHZSalQzSmkzUXJodmFuaStraVRha1FCbWQ2Unh3SCtj?=
 =?utf-8?B?bmhudzBhMlBlcnUvN1dGcjkwOWNEQzEyQ0d0V3hhN1pJWVVrSFJUbzh0QlFp?=
 =?utf-8?B?U2FlenI5UGlhell6dmczYk5NY0J4YlRKbkh2eWFJbzV0V1RHWWFNWDZEcW03?=
 =?utf-8?B?UHdSaHBodDBpdFZwSjRzWERjdHREeWg3Q2Z5NG81emNlenZkZ0tMODI5N2VQ?=
 =?utf-8?B?ZGdGTTQ5K2dUaTdiQ2pJSmNweWJtK1pFb3ZldkhkbHFIMzFWaVc3N3ltVWs2?=
 =?utf-8?B?R09zUi9jb3dMVnNJNFpPYS93cVFpMld1Vk5CdUZNbmJBQnZkY1Z0NXJsNWFN?=
 =?utf-8?B?UDBDQUR0Q0JVbGlLN21XQ3h3ejFrR296bElzTXRvbEtSUmx5U0pSREFhUXND?=
 =?utf-8?B?S09KcVlQalg4dTJyV1NnV25nRmQyNEhkWUEweTZSV2E3WDRVRzdRakRlVWw2?=
 =?utf-8?B?aVZoc1l0aGU5RkRrR2tsVjFMWi9ScXdwMnFoTTZwMUxFOCtIaTFsR2hLdHZQ?=
 =?utf-8?B?TXJZeDNtWlNBQWNRRGpnMjJBZjNkK09Ka2pPWVprbXZUaW56MVVLcnZXTkFF?=
 =?utf-8?B?anAxUUZCMUN1Zjc5Wm9pT3BSZ0NJSlZNYm8xTGpMR2pOSmRMdnllMUk4RjJQ?=
 =?utf-8?B?bWNzTko4aDkzdUFBZkljeWd3cjE3UlI5TEVKQ1NpZ2ZpSDRELzBHd0JIVXhU?=
 =?utf-8?B?WFFkRDQxNXpGZ0kxOU4wcTVrZlVTTGp6S1hZc1QwWVUxekVuRFl4Um5aN3ps?=
 =?utf-8?B?UVphMnRzVUxWaG41bFFsTHk2UGFUYjVaZGZ6b2FjUTlvaDlucE1Jb21IYmtD?=
 =?utf-8?B?QkVPUzBnd0hnNGpYWWtSZkRPak80c3JVNm9oc1lya2lSNDdIQ1BJd2NQdHdM?=
 =?utf-8?B?M3hzSUlWNTF6cU1pMURQcGJoMG9OTHptWWUxVXpSSXpabUU1dktHNGloYVZW?=
 =?utf-8?B?djJTaGhiWVl4YXVZTjJtSS9MemV6WmtkVFNKQTF6bGpESFpTKzFJcDJHRWlE?=
 =?utf-8?B?bnpOdm9SSEpQTTBWM25yajMvcEk5T1hDVkNsK1RrNU9GZ2lnckUvVnZVL045?=
 =?utf-8?B?OU1QNC9xUFdlOVh5TjBNRENMalp5aU4xMG9mMEJpUWg4Zi92WkxRN1BDc0xJ?=
 =?utf-8?B?MVRDQjZFd0xqb2VNQ1VDUzVrLzg5NXRhMm5KYVlGQ3g0N3QrKzBUN05PNWJH?=
 =?utf-8?B?RTh2MEtlWDF1Y2gxMWR0SkhpSnBVVWpoTS9Td2I1TE1SeXpRYTZ0aStSQzVu?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd174e5-c13a-4c0e-6827-08da8fd797a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:15:35.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yj4RcBLtvgS2+z+uBPnb2oj7bNkuMVMkroFMBMFsF4LwhbwJx06x3cpSmSErUiAPA8/Vdk3118RtNwgzyT2d9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/5/22 23:48, Christoph Hellwig wrote:
> Please split this into separate patches for block, iomap and legacy
> direct I/O.

Sure, will do.


thanks,

-- 
John Hubbard
NVIDIA

