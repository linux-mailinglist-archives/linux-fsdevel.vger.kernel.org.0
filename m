Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B95A3AA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 02:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiH1Abj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 20:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Abi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:31:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5163121A;
        Sat, 27 Aug 2022 17:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biJDvaC+YoRr0+Y005nOlQPYj4+WxY7aRkawrAXSQCEtzAm1iirTqRLQkcOyw3obA7lkQVZJMDovVOdoRQpc9LHtwdCAnsuIjkIt7ESGomKkCxhym/U92QwbBLrXGAeHtb6i1O4pFWLISOOTRAi/+fi0UzM0/yB4h7WDuZd2ZseHc9sz75mCpHDeielTDXgWvf3RDNOvfqZ340wLLKl2KtkN69MfCneZA00H7uZBJYbv8cvjrPR/ovG34Os4aG6ImRmR6KTn1UjfWZvgZWeLdtnWKEyExh3q0MZY3UfVg7ugJ4A+tQncYQsgR18Ox+jBkR869nNwQvGgH8T7NU2tVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2sxr/6SgchYPpX0jS5oLr+yXTwimUiHqeEhOoi0P4Q=;
 b=OG+z86AhOILfXOOl3PffLjrSTkLNXbh5Cs1OuLih9cAgrp/nZibyGGW213P60oOLVuexVmCxmE+6vEq0IT7RdQY4Ibqu4rDgagjAIUdo2buCaq7jWLwPmawLXCUE/1B0LZxHMBOyuBEyWZRaKSqncfPgYHnqMPRXGHqGHGvLs3sZK9IbOTFBTuk78L+GeyOODLLatZB95Oiy1WJIqYZPBr6EUKrD32HKneNjJIgpJ2Kbt/299Y9eJWpT6iMLoXar+fKF6IBnogm3dhcDXw46PerPGXjz3UbdV7//tGfpL5bFjfdDgpu4zEjSo5C1vfZEciXTRug577YiR62GilhoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2sxr/6SgchYPpX0jS5oLr+yXTwimUiHqeEhOoi0P4Q=;
 b=rMtoVWPc3o9zHXJg3/wFy90tSqTRrtQYo7z0SD7jPV+ry2GWrKL0ezk/GC3GCVxGYhvIIVkUrsAZ5n8ZLc/P2H+lwnqutjkN2AJ76F21dFsqi5cliRSa3Pf8BMCv1xL/fXFSNngr/4DK+IR6CUDSkI4hDTSeKTWwyfhMOpr5yTQQZ7dvDdVwOSboDYsLoFMOv4DUFwNIxLYpgxfD2eD92fShnpocViVYmJwevAjVVtkAJxZ1YAcYKzoOtuNcGZrhYSRupJ0VueW6FPWFz4U2LdSUUy7xluCxTkpLMIHtYFwyzARrdDbKvMV/RVRioV9WLdKBEwZrdpySa6L688jvsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 00:31:35 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 00:31:35 +0000
Message-ID: <d89943aa-5528-a424-099f-4b1a2151b893@nvidia.com>
Date:   Sat, 27 Aug 2022 17:31:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/6] block: add dio_w_*() wrappers for pin, unpin user
 pages
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-3-jhubbard@nvidia.com>
 <20220827152745.3dcd05e98b3a4383af650a72@linux-foundation.org>
 <4c6903d4-0612-5097-0005-4a9420890826@nvidia.com>
 <20220827171220.fa2f21f6b22c6d3047857381@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220827171220.fa2f21f6b22c6d3047857381@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4304a4f-a4c9-4812-91b4-08da888ca9a7
X-MS-TrafficTypeDiagnostic: DS0PR12MB6653:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGXYSh50LiRL6iEyPbzcFpW/GtKd9Lb6LO/Bf6O6MP4HzMsOsmxcLQS+3qh3FrS59F3/hvqjHqgG1/DggFsdzVGvDP6G22WTta7HKbdtJHkOgsHPUl/dN8U40OGEE0H+mX5RwNsouqZR+Jz5Tjb/Fl9wtE0EwstMeXOfd6GEPJGWyaheUNgXexhjB445KmIdwmEV10Bxq39HHyrBEa2xG4lQLWP3VL+h7o6WHjAYuLzrpJCxhNOd5pqthpyKA+lcCnnYaBL7v/fS5JADEROz94PRAVQffLnyR8dstzjUsZ55AfDf6eRYCVBYaAptisjHvPMsRPNkOz2gIulOiERGn8o6xeB3IiG7dFRhTFYQ2dkmgVc3OLA9QOMsbRrQWJ08/Ugi3qNH77mClQDIdK1pZOlcTx4y1j6fX/nzgZt3nIheHDzVy4Zrq/0ZGaqNKkvzO/bO5O5rf5kEDaXxNPushaFQK9OtX/SFxU+crg3a31va14uCwGOi5ackCVz5h6QLmadvDeOgZzE1166rA77PuNSgPZBg7qtHon/NXqq/U4sDQRbWwKVyolZGlB3dceTZdxVfqXer/FKe1n/lQ5a2afor6ut+sXabkqLZcUDt5XY+8k1lq569grvf0LsCGpMx62pFjmjjNx9s/T23s2R/sotZqTAnE5/9oMuAf/dPBI+Gmn8V4uvNMptGdYkM6/PuS0EfTO9j0M+OoOi4xd5EB+JHBUIAAzKjOZWexMQyvq2YSztRRLRvSgRLtGLXWdSOvQapaJQc9chJFeUfDrTPNjTYlqcIHtJjX0d8u8s6Q4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(66556008)(6512007)(478600001)(66476007)(6486002)(86362001)(8936002)(7416002)(31696002)(38100700002)(5660300002)(66946007)(8676002)(4326008)(316002)(31686004)(6916009)(41300700001)(36756003)(54906003)(186003)(2616005)(53546011)(6666004)(2906002)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVFJRVliWW1TK3BoR1FyNWZvOGVlOU11TGJOblhXVlJrV1VIdXhHVFZHbUhq?=
 =?utf-8?B?OWplSThVYkdoWUFXOW1uQXRlQjlFcytWajJRTXR4YlNaRjdvQ1RmV0g1Vm1p?=
 =?utf-8?B?MGtraFVnZEhSY2ROcE41azg4dzdkbVIrVDBiU3BMVk5DVnVXTWVobjlrc09B?=
 =?utf-8?B?dDJtVkxNVzVjbllHOGZRM2QxRW5heWpZZkZFeFVOT2t4Z09wS0NZVGRHL0dn?=
 =?utf-8?B?NjZCd0ZDYXYrdkJJQTE2MHVFOGxZZjUrdnA3N2JkOHNXUnB5TkRROTgvY3Zr?=
 =?utf-8?B?THdmVDY4NWxoSGhaMWNyWWEzdU1wTWdTZU5XMUxEUjZyYjJlNTF0WUxyb0V2?=
 =?utf-8?B?Q1QwRmpLVmpkS0N2TWVLM0pEYk9BWlZkNUdLVGVCYTZDUjJjSURsd0dTT2s2?=
 =?utf-8?B?TEwzZEJ3bGlCZCtQanNPVk8xSERjWWw5VkpxV3ZuVXJ4eExSbzgrUXZZbWNh?=
 =?utf-8?B?ai9ZRnZyWUVlT2I0T0R2ZFRVWllZNmxHTEZUb3FVQ1lpMG9KNEtrM1NtT3lJ?=
 =?utf-8?B?M2FnbXJocW1heDZVaTBMejZuaWdTQTVWTWhyb0V5ekdDMWNqRm9lNGthMi90?=
 =?utf-8?B?ekNxU1pMRnFUaFJYZ1J1OE1ObWdkWGU2SXBFNG5IUC90RldPbVloeVFMSCt4?=
 =?utf-8?B?U2ExUVpNaE10SVpYTmIxRU1zK0pwYU5kYjZRbmZCVUJwQU9mMmtTb0hJS20y?=
 =?utf-8?B?ZUE2TTBFcFljcVlORTdyQnd5a2o3c0E2ZWt4TXVWekJiMHNwRUJZVVh1Q3F3?=
 =?utf-8?B?bEdPS0ZHQ3hXcjZLbHEzSWxvZk12MmozVFlQUXhjWCtickNHZTI0NkF4dkk0?=
 =?utf-8?B?MFlaSWpzZVFVR1VGaDl1UlUvMW91cndQTERHMm1lUGpYSmtIWDgvWVljK3pD?=
 =?utf-8?B?ci9tOWk3WnZNYUxud2x3KzRCRWZXUVc4dHd1VWFzeDBJMnFyVkZUZC9lZGFu?=
 =?utf-8?B?aGgvdWt0UnR4ZHQ3ZjZ0c2tkc1h1dlB3T0V4ak11OTg4N0pWdFkzak84WWhM?=
 =?utf-8?B?dWVUMFBEdE9qTG5zUjNUU3ZJYUZFcDJwcmVtVlVKblpiak5LakZjWEpUTHI2?=
 =?utf-8?B?WVQyTHROSHR3OExqM1VqVittaEltRjA0alBnbHB5OVJnODBwQzVadWtObWxr?=
 =?utf-8?B?NG5OM2VPdTc2T1lhUTkwSDQvQzM3cDMxbXowWmYzMUtqeEdVM2ptaDBuWUdo?=
 =?utf-8?B?WW9kbHFzNFBVcTFRdmFHa0U2Mmc4Uzh3VWFqKy9TZks0WUhVay81UWt3Nnht?=
 =?utf-8?B?MVVlNC9JbGdOck9DR1RQSEJxc1pac2hjWXpKOXFWRDJEV28zS0NnU0t6NXEv?=
 =?utf-8?B?NWt0TGs5bC85bVpFVTdDNWxIUFdwcmZBckxHcUFxemcyS3lFa2xqcjlLNURB?=
 =?utf-8?B?TDY3ZFZsU3AzUW9ESnFtei9wbXQ4QzA4bnVCNGhVNkpqVm1TSjJXakZ4Q0N6?=
 =?utf-8?B?dzFtLytmNEdNcDEwcEs2UnNuNnF6MC9QbmlhcjViOEJrUCtyLzRXcVJNTTF5?=
 =?utf-8?B?a1RTSFQ2dVU0Zmc3UHZVNmpLMFFCNXlWTXhjWGt0aGdYWGUxZC9xY1FiSjJZ?=
 =?utf-8?B?cW1zU1J5U1RLQ2lFUWlBV2dacTFQYXFUL1pkL09WSFZROE0zWjcrblZNQjdS?=
 =?utf-8?B?eE1YZTJIaDRvenZZNnBHOUNpRmVVcGNhbVo4c1hrMm9tbkh5Y2ZuOGl3Q0FL?=
 =?utf-8?B?Z0F2TXAxZlZRMm1hNEdyeWhWTTVwT2svVGpqbDV5YTd3QmJjTVJudHJqdGlt?=
 =?utf-8?B?aVZLNFlHdkVKMENCNVZ6UG1OYStGWEtjemNqTmlyRlU2QjNkOEJPRUhSZWVz?=
 =?utf-8?B?NEo2dXFjRlREMjBxWGhDSXBXd21QM3p3Z051Y2czVmtSdmk1UEYwc1k5YUZM?=
 =?utf-8?B?SXBvd3pGSHU3NHdMQ25aQlRzSStWRmNQRTNHR3dKSEdFR2tzSlVrZUcvWktw?=
 =?utf-8?B?c0NlMEpabmh3a1AzQjZ1VlEvTmEzVHBOdkx5VU5pVkdacVVQcFFQTSs0c094?=
 =?utf-8?B?Zld4Q0x6dWthajdGdnMvUmNoQ0xlL0xTSi9idW9sbFIzV3R6MmhScGh6NVkz?=
 =?utf-8?B?NG9DRE4zb2hoTnhVY1NzTDYvZXFyTkRlNUhGSGpiNVdDd3hZMWpkYlYrZCt2?=
 =?utf-8?Q?hC67OYox7NnYOKf30LQ79zrUY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4304a4f-a4c9-4812-91b4-08da888ca9a7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 00:31:35.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHSRQoP8IJoBhdwKwptL2qvi0K6O1U4THmdQDZwr5lHToK/YiKldBIkNLoVkvhes0R0whLX1MCHhgawq53FBWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/27/22 17:12, Andrew Morton wrote:
> On Sat, 27 Aug 2022 16:59:32 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> Anyway, I'll change my patch locally for now, to this:
>>
>> static inline void dio_w_unpin_user_pages(struct page **pages,
>> 					  unsigned long npages)
>> {
>> 	/* Careful, release_pages() uses a smaller integer type for npages: */
>> 	if (WARN_ON_ONCE(npages > (unsigned long)INT_MAX))
>> 		return;
>>
>> 	release_pages(pages, (int)npages);
>> }
> 
> Well, it might be slower.  release_pages() has a ton of fluff.
> 
> As mentioned, the above might be faster if the pages tend
> to have page_count()==1??
> 

I don't think we can know the answer to that. This code is called
in all kinds of situations, and it seems to me that whatever
tradeoffs are best for release_pages(), are probably also reasonable
for this code.

Even with all the fluff in release_pages(), it at least batches
the pages, as opposed to the simple put_page() in a loop. Most of 
the callers do have more than one page to release in non-error cases,
so release_pages() does seem better.


thanks,

-- 
John Hubbard
NVIDIA
