Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510585AE174
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiIFHog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiIFHof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:44:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F48260B;
        Tue,  6 Sep 2022 00:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf7WTs85nmBQQDphE1fPQSXBxYXyyoo1wxHAOpEJzs4geGG5kC1zmN6x3PEZZHZlk6/Q5oj8ON1TcsmUK7bbKJPVKJrvs0mSj52uNPHiFb2xppN0BTzwvDQxUdlWgbjNTQdyV0Hgn+HzgGTxS0fnF9hMpD0eo/dxVFzBxi/bvsGiOZJ2LApexouHLA+ZIsu3mLD6QK/fBB/9I1lWjcP/GBt2O0EpADghhNmuJDkGN/PwgjNkvfGlfrNo5rVUNu/+WqVmdjuYgHvXG+6f/kEDrfsKLfI/e5rqqe1Arw4JNsIE30JeTXt2rH/eGRxSQoMwe+u0DIyEb9VEbXLft5htsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbAokJjUtHMVxnua1mldM4sX1inHsMPSVwO2d6dFY6I=;
 b=DnsiK6cTWSgVuhiVBQ05/N93todCHksEOolsu7PPvwpI2tR25RDOfTVFrQLJ33HWtRaZ5Rj97fi7GTstTo7GB04F7UmzYuWOFfF0VijCYhLHZsIN62/nnrefehI8AeyQ+hPAzJni8hQVtnKZxF0E5zyOATLKWkZl7gpUqfAo3MEr4rSVBTeQF72feGCEPzbO4yOaK9zSJDBmGbNK9FQZ7YXD1FX07Ab0CtJ/zqNabvzX7n4NiP1/o5hSdnzdBNKPWpLiI8xTVefcIPjec+5felj60+dTy82XZegTDZXAhFAA8if/8Gt0+ptBPjneKPBgxVokxvNJhO/5uyg82um30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbAokJjUtHMVxnua1mldM4sX1inHsMPSVwO2d6dFY6I=;
 b=Z/qbii1Leh8ZaI/sCrcN+BZ8pfz8HoSqU9DDft0sjPL2AUYyIy8mkmnrRUwmjHYBtbOky9vx89myQ0WgYNqR51D4oZDcrxFLo7p804fVaRh7AT9SMWwSwk3M9X2EWjgun1BQh+ougKgbIJ53YLQHMFpqA8Y93ovyCNhvbNjPfqCih3J10mVoWsrVKugoy8ToNXy1bcjaAb0DG64HPodAhajx0mrRYbUEk5fGaZ6LOm3slydUsCPljBDZLaLi2a6+waWLPLfW7CW4y3ZXVuMlbwLk/q5/yvHSJzfXdehaNSTHrJ6HFNaxYgPGNx9FF044nFeXZFXoQVSXmW4h9N/ntA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 07:44:32 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:44:32 +0000
Message-ID: <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
Date:   Tue, 6 Sep 2022 00:44:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
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
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YxbtF1O8+kXhTNaj@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cbe3573-9a6a-4b04-d8a0-08da8fdba2e8
X-MS-TrafficTypeDiagnostic: MW3PR12MB4442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9drnai1j58XioXUeG3VyzdG1tCfrQ4LQTF8IDUvQ6b+nQjKAfydUOQgvyxVZUkqWpyoaSdOjex6KCj2HtANpArsz1nNUAixL9nYF9fhTfWlUTawGABilqA6lFCP46TB0LNOFUI8VX79lrBUR4E8LAoNcOte1Gnj7h4Ed0qkmmD+ChlWjffsvTh0oml/OS7njw5ZFVrorygrHmHVbhGBrcwPPusLSHsWDgM+oPYte11ZMVsETCo44Ig8+vM5RHjfXrG7YdoCNKhhTcou7CZZdOg8FJ9KDWujkT170yXhTqOVJJKL1ZX0Jw5npi/RdVepoMYw5vnZj08Jh9GbY/NZq3m8v4YrxrInK4d5ePbLH255cigO81Fht1HrvuwKRo+bLEAELqe5KpQJ9szNMUyV2e+/i4gMo1NzvL5BGZdRCypfh4rbh6jXFeSbv81yqB5B6iMrz2/x93F7xxPY3GoTxk2cUAscW7Z/d/tigScgzvU5jTXbkypzxEyrB7YgZRc6r5aea5AoHPHl34AjBhtw6Q+NEozYessZ3M6euWmtZd0iGN3x4cz3D7rBYsUd/NnsNcWb7F1gGZsCt42y15G2JvsNdMRua7Js2kX6O41kkZkkx5K70guIGkzr+c50ZiZhC9B9HFsTYW3kNC+TKI3xaLx+18o8vtbBDMeHj2rQ+B+cenCFQ0/Vgqeful0c1OPBDfPeFs8H9gWcWe2siXLIeKVhcbgnBcpvnKmgDZGm+HiRPTjmcMr0MA/M+Q79q4aI13jKDz3Y7UK8b13XtbE2BgsuMYuiO3N5MVdHbmY3orY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(31696002)(36756003)(31686004)(86362001)(66476007)(66556008)(8676002)(4326008)(66946007)(38100700002)(2616005)(26005)(6666004)(41300700001)(6506007)(83380400001)(478600001)(316002)(6486002)(6916009)(6512007)(53546011)(2906002)(186003)(7416002)(54906003)(5660300002)(4744005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmd0ZVdjaDZGTmVYb2d6VGl1Qk1MamxPTDhSNUdlQ1p3bDNSbUozSzVjcDQ5?=
 =?utf-8?B?WkJJd1R0UjVTSFJldzJJeUJWMHU5NTVSZkluVUV6SW5WckFtRTJpZEJkV051?=
 =?utf-8?B?dWNLTmpNOWFjMi8xWWlGcHRnYlB6WTNEMmxZVnpHek5YY1ZSaG1yaXFpMTB6?=
 =?utf-8?B?QmRSbHMxdmttdDdRcXFMWGdoQVVDUEhEL0RUVXZJYkxNK09JdzhHOUVMRUow?=
 =?utf-8?B?YzZOOVNoNVBvd0pXREpNNXE1OUF2bmthLzRpOWVRK2YyaGZaTzM5TjBOYXpR?=
 =?utf-8?B?dUJIeWdMMXMrRE0zR1VpeDU2Wm9EMFFJb2dyTFU4YkRtNCtybUpCNVd4WjRp?=
 =?utf-8?B?ZkpuTUFjdjhkK3lraklpUEU3Z0w1RVZ4OTdFbnZnTVhMTXMxUzdDTlhRNUZL?=
 =?utf-8?B?TEFBZ0k0MmQvNGxWQ1JlM2xvN1Z6eWlnT05TWm1LWmZTUDFpRVdUNGxPUnFj?=
 =?utf-8?B?endCS0Nic0pDSXhZNVV0WVRpTXArOEZvWTNPeWtsbWFic28xQW5FUjVDeUFr?=
 =?utf-8?B?bVV5RmFGMDU3NnpJNTZsY3NYVGV6WmtkY1dibGdxMTZXcEJuSzVXOThHTWJh?=
 =?utf-8?B?NFFONS9EeldqUFp3QTYzK21YTDdKbElFS0l3NWpqRXN1ZEkvNnN3dXhJS2F5?=
 =?utf-8?B?SkFoOXozcUIzSWFaa0FmZzFqVCtZUG5sVHlRenB2NGxiZldoTElSODQ3ODlQ?=
 =?utf-8?B?SjJEaWZXL0k4b04yNXY3Qnp2bUtCZHplT2Uzd2pRbmlORnByMFZrbmd1QzR5?=
 =?utf-8?B?bzBVU25ldUt3UzIwWEFPTG9pNkFReDh0NitGTzhYMEJTcEhFbkp2Z212Rytk?=
 =?utf-8?B?SkZsN3JzclRRODM3MXRodnhCL1NVNXFSQUpQVnhuT1ZLS0Q4OFd2QnRJbDZW?=
 =?utf-8?B?WFg5czdlVEtRWXhyajJ4ZGxxZmwxZjdWQXpROVJSdVdWRkphc29hOHJ5NWNB?=
 =?utf-8?B?a2ZZZ1RSTHBBUFZKZnNMb2wzY2dkUXlXRTZFOC9BV081dlp3WWR5bno3cUJi?=
 =?utf-8?B?NEd4amFBbWVkTUhpVEowdC9EdnpETEt0MTdpWE4vMllZNzA1bENCYjVNbzNa?=
 =?utf-8?B?c1U1andaS3dkTEdqdEd2d2pkc1ZjZy9hT2Jhb2diYVNvb1N4K3UzbHJSOUVq?=
 =?utf-8?B?QmcwUUhacVZ2dTJZc3cvUlFXYnVZYXVRU0Q2ZmRVNUNWcGlMcGEyMnptWmdB?=
 =?utf-8?B?RGh4OFBkSHd3dG5XUjE2TDlOVStpdzV2QTB4TXpERUhFYTFzekVBV09aemN3?=
 =?utf-8?B?SXBtd1RIMW9CL1prRndNTWh5cStHb3ZFRmI0bmx2OTdJQWg0TUQwY3NXVWVH?=
 =?utf-8?B?STJyem9RZTIrcE0xQ3dPZVI2NkdZbDdSUkVPbE9UeGVSQk5jNUNWMC85OVU3?=
 =?utf-8?B?clJ1R2pwenkvRTV6dzJ0TXA4Z2RUQ20yS2tKV1U5VC9FRm43VjBHbHQ2N3Qr?=
 =?utf-8?B?dG52dFhjWkZISjAvemJEVHFoTHgwYjg0Ukg2em5ZL0NycUVkWWlMRDdnc25H?=
 =?utf-8?B?Ri9DSFlJMEtzNFlpalFLN1lnY00yamFQam1sOHdaRnhDR0JQY2VJb3dBZ2Rr?=
 =?utf-8?B?bm15QzNqZU9jaStIUlZ1REhxQmRyMXE1Z1c5c2Vvc2U2STcyQTZzYWt0RjBr?=
 =?utf-8?B?YW8yZkgwV1d5cWVjcmt3blRRTFBZSUZNUEF2dUIrdDhlTFNBSXFPalhNcWlt?=
 =?utf-8?B?R0cvVnJlRURJRFhQdnhseVJtWDJCY2lZeDFiVkZ6cHFYMFJUTThmWnVkbk1F?=
 =?utf-8?B?NDU1L1NDQktGVUM4Z203V0dvZ1doZEU0SlUrWjRSZzN1RENtckV4VFV5Nm5K?=
 =?utf-8?B?a0JLelpQYysrcVczaE1pZWozc1ozZ3o5cjNVYlJaOU5yUHAvUnI0Y3ljUUw5?=
 =?utf-8?B?K3V6QUNYNFNqeS83dW9mVzNaQnFxdEhuZzFWNlNKSHk1ZktUbzBTMWVHR0d0?=
 =?utf-8?B?NkwveVY0Y25UN0IrMG5QTXFPOWtJTXRPR0toa2plU1VjVGdWOThmZDR2cWZW?=
 =?utf-8?B?WWcvdEF3N29iR3dOMUsyWE9KcGticVdPVXluK01jZGtKaitNb1VOVzVLV1Q0?=
 =?utf-8?B?OFoyRytmMWc3RW9Sek5CVC9YNXRuYTVrVUp5NVpzOFJ3OTdwSWdZcXZKcnRN?=
 =?utf-8?Q?GmnIqZY4wLafQUDBHn4w+Hcj7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbe3573-9a6a-4b04-d8a0-08da8fdba2e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:44:32.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tdh8vmgfpT7nsRBffShnYudZw24wEYaktN8LJnvH3PEYDoeQ5+OAKE50Lbdw+QLULBWHe3I0o013Jkg5cgNRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/5/22 23:47, Christoph Hellwig wrote:
> I'd it one step back.  For BVECS we never need a get or pin.  The
> block layer already does this, an the other callers should as well.
> For KVEC the same is true.  For PIPE and xarray as you pointed out
> we can probably just do the pin, it is not like these are performance
> paths.
> 
> So, I'd suggest to:
> 
>  - factor out the user backed and bvec cases from
>    __iov_iter_get_pages_alloc into helper just to keep
>    __iov_iter_get_pages_alloc readable.

OK, that part is clear.

>  - for the pin case don't use the existing bvec helper at all, but
>    copy the logic for the block layer for not pinning.

I'm almost, but not quite sure I get the idea above. Overall, what
happens to bvec pages? Leave the get_page() pin in place for FOLL_GET
(or USE_FOLL_GET), I suppose, but do...what, for FOLL_PIN callers?

thanks,

-- 
John Hubbard
NVIDIA

