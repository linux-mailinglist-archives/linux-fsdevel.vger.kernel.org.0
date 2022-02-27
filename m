Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD14C5F59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 23:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiB0WNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 17:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiB0WNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:13:22 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE2D1A82A;
        Sun, 27 Feb 2022 14:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9PuSrcM8LNLaQPTRKztMmztbdlLkuAm/1KSWw70KI3kGOigXwsOWLUcnuralrOvP8Cu8EdmZ17yerSTl3cv0mNT4iy+kJxT0XqjwfHPQaugweskav7IlGgd3xT8yFv/NLzH7GsrUrmi0JsD+eS1wKRcscbfGFM6dpuBPo2QduOicLdA3+PcCZN6ddBBXqadQSzpVZHkiP5zDSbJhYP4ptrenTO3WNriJurmJilktR9TNUpPM2dbdgMhujMY2v2Fq8vjTCxj/DfOaFRjAauefKyYUcK98dF9l4YJGUrMvIPmLs5XPUvTGzOdZSy/ztw3qD1fHv2Rkscq96m9Fnc6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nypha++8eI7rpyIKRTA4pGUbYg9Qs7+bzgjhXq7EQhI=;
 b=D1Lq2tf5ArYIBxGuioSkken+b56GDn4VxEYubw8GFnKB7KtrQne5+xN566NiEbQr5yG4AF70SCmS+KQ+ndQvOPoUT0WJJkpN21oW4pZaatR6Pqgzztycyi4hky6O33PxbY52Y7NPZqeBRNflc66usHc0xli7zL8CKGAjP2P1tWfH5ozUT3kDDrhXWlwtRDtBGU7YrZhQOdBb+c81I74g+osc/mnow7ZwLiql6GXzJgwTGHYukOem7+sHmg60NXihmKxIBRBb57qVPTHHonI2h7AndLZ2R/3kSMVbIVukzrPxsBs5gqdIicPKdw4QeapBm6C8f4QQqoDac7wo3phl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nypha++8eI7rpyIKRTA4pGUbYg9Qs7+bzgjhXq7EQhI=;
 b=R3CU8QCv+uujvKU0pDhh7x6dqAtJlB7amJV4eFh/IfEMLvWLh0CK9JNmEzNUQzV3LBG45Y3PGuDaBzw2NkVw+4y7vsVdFHgqiYwuDhBT9JtI7PA2qZjgbIGpY70LJxRr1QCdVt19AD7ZudLazR9pdni1XQxvMAstX0S35UC8KODgrP4V5EVsOt+C6REsEcRIBT513tPNFWGkeaS6wO9+DdoAtrCBmM6PPuSeR40kTwlLeiA8cp8C4EqLd+iNpiXlmuDPxaLUROyGVUd88yG3g4vu7MOuHFPSrnALPS3GQ8pdgKIz67oog6col31WdU7gmYewk6mFXw7lThO5WyQDww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sun, 27 Feb
 2022 22:12:40 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.026; Sun, 27 Feb 2022
 22:12:40 +0000
Message-ID: <aba02dcc-2cd0-de7a-f3f5-8e34469de1a7@nvidia.com>
Date:   Sun, 27 Feb 2022 14:12:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/6] block, fs: assert that key paths use iovecs, and
 nothing else
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, jhubbard.send.patches@gmail.com,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-4-jhubbard@nvidia.com>
 <5935986f-bbbf-fa90-2eba-b249ca7e15e1@kernel.dk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <5935986f-bbbf-fa90-2eba-b249ca7e15e1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::23) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99407d0b-6fb1-4bec-376e-08d9fa3e4539
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36791546BA021842A92047A5A8009@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JvG09+QVn/fxZpZYXmkBf9/86F1o4Q3avmjlRWXjM9p/VqFuDwQt9PspQxa9a8lnMz6z6E2nLMVgYGufH3w8A1qVkf7TGGPu7ttoY2nYQzr494AC4CNUtZaZsuoc3BY9ZfUWxsPtOlmFmGZZe3IJ4gSwpeRB1EQPROIWa7NMd81VYy8oU4Dkpps4Qygz4EmQI6e/VxcNMYGhBXndXP+WrWHEd7wkBV3zAElTKHQo0NGtQ4l0vePSQhCmNVirh5knk4uBmp93Lbw0xXLM2bixJJlJWeQz8L+4Mn/yfdSWl1miJmtiUMVtf7HkROtrRnvfmdOhZF8LGVkwVrBTCkSSTYm+I2U0JxzrlmFghFYYv87XzHdB3Rp8BqCQDLowcPw+HTmHeNvIO6Avr0bRsZW4A5YHHECVENbYYb0TtqZCC9pSBJn2zwwUUnGJEmBJhYB+bj5Ho1bxI0PqeL7ZKvQjV0lHFBaGzbtw3CeX4Gx+iwfGqMbCiQ2z8zEYSRKEBTMlCnJ0BPUYb3xYD8kYVmPUkp38J7KdM9FkkKfNcYwBvYiTeDTzEwYWDi8E18K9sRvAfx/HdUOWdfTmQycK+LdMEyeG3BgJbsZWvP/Y3KLLUmv+UzQAIk/Oe9uG0OtYdupDYsmMQqTBcbZ/ibosNAXW6YqfTU/rNTOr80gZ1EbAxuCkQzwHsYoK4uCEr0JKmZsRzbiSsbGIj6K/TmXMPhqn9tgDUfIRHq5Vew6eAglEgvjRKP0i3saBGULjEAxcetW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(31686004)(316002)(4326008)(83380400001)(6506007)(2616005)(36756003)(6486002)(6512007)(508600001)(26005)(186003)(6636002)(5660300002)(2906002)(4744005)(8936002)(7416002)(110136005)(66556008)(66476007)(66946007)(86362001)(8676002)(38100700002)(921005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzZjMkF5WnZ5VGRtNEpyRW5aYVhWeFpTNHZ4bFJaMFhQVHZ2OXBIeEUxWDBu?=
 =?utf-8?B?cnlzOEF1b2xFZUx0anhoRU90SU95cHhvc05xZzFwN20rOWRrekVIcTBXV2J0?=
 =?utf-8?B?NkxzMFVOY0tlZXZxM2M1MmRwZS9RWkRrZzRWVjJGNTBIUlE0VEFPQWhqOHBP?=
 =?utf-8?B?bk14L0QveVdqblBqajVuQ2l3MDZpRTZFTGNDa29zWVA3VzhxL2VQcEVhNFdN?=
 =?utf-8?B?dVp2TDRJODZVRG04TkcrS0E2Q09QYTlLVWRCaGU3NjBBZW1mRHlnTWVvRG92?=
 =?utf-8?B?ME44dy9rYjR5SlVybUJQcGVsK3p3b0x1ejhPRmN5UVo4elBuN2NDVUdUd3cr?=
 =?utf-8?B?WkVhSnYxeHVORzIrSXR2YXRJTXJLbVY4WWh3bGNNbkhURFoxTW5HN0tQeVZM?=
 =?utf-8?B?Rk1FdnNKMFFxMWFtbmNuTnJOVDFDcFJKWWJMSEpiRHY3MkN5a082WndGbkxS?=
 =?utf-8?B?RTlxSlNKQnk3SEtXRWI0MDMvMzZybVZMc2gxLzBoMVNGemNvY1YrdFpaYUls?=
 =?utf-8?B?bFBGV3hSWExycytVZ25VTnlmdDUwTTV3ci81eDZicEdkRXNPMWthM0RuS1Zj?=
 =?utf-8?B?bHdqNFowWThYcTJ3Vms3K01DS2w5bzRFZ0lPNGRUNTJxbXJJOE5SUXJUUlJ6?=
 =?utf-8?B?ZXREajdTbnNIMmdTWjY1OU5EM0cva2NDdHduNU90TjZpNmVTUnZINHRXNXlk?=
 =?utf-8?B?RTZjeC95eXF0S2dYbTZRWjdyMkd5Z3NQa2pQeWVpS2JvMUgwdEloVmFidXc0?=
 =?utf-8?B?RHJMTnQrd0hnU3M1SW4wU3YyRDVlS0Y2ekkvM1RSby9MVUV4U05VbVlpZEVT?=
 =?utf-8?B?Z2ZGbDR0WFVZQ1dTQlhWZmlYMFFTS3dWakx5azBiaElyTGp6M3VZUlVlYWxJ?=
 =?utf-8?B?VWhUUnJxTXNmeFQ4REZQTHJiU2J5blZsRmtDdXV4RHExd1ZKVUtFQ0ZvNTcw?=
 =?utf-8?B?TTFGamEzMWFNR0hmbG40S3NUU25LZFZ4Y3dPZ2ZSQW5RVzYvVVF6STlWdjVE?=
 =?utf-8?B?QWk5ZjV6dnhyODlnUmFjdWNuQmdWWFBxYStnRkxkbC8xaWZJUzg4VXkrMUhT?=
 =?utf-8?B?cHY4TmU5TmJnNnl3M1NSR2VjQjZ2UUdxZGorV0llY3E4WHRkVnBEditrVGVi?=
 =?utf-8?B?SHZoRExlZWNiZUtDYVd1Q2hPYzQycjRHc2UvdVJobm55dGZrM1B1anJEOTdT?=
 =?utf-8?B?Y3J2YUVOY3JPMEl6R1ZoTFA4REhaN2tQY1QwMzJkSlEwQnl5MmJZZXZsZlo2?=
 =?utf-8?B?VCtmdGg3amZQUmFlbXQxeFUwdmJnYjh6OUthOHhtYkhFWkxMNkEwYno1Y0Nv?=
 =?utf-8?B?eXJOSzVZNGplS2dkR1E4Wk5DanZFSldtZTFIdWxiS0kwdlBnR1FyVEpQZ3d6?=
 =?utf-8?B?c2ZocHlDcGRRaXduWHM1bjgwdk40SmJmUWx6OWdvRDJIdkhkdWdrL2IreTRm?=
 =?utf-8?B?UG5CREw1M3gvL3AvdE1lWDk5RjVmWGQ0SGdEYTBoREZMUTF1aTlVZHFzOHNu?=
 =?utf-8?B?TDYyTitRSUEyb1cxVmZSdDZ3cGtTS2g0S1JrV3JQZlQvZjR5MGlRTWZzR3lt?=
 =?utf-8?B?NHpKYTVkejQ3LzFiRnVSKzJ3MjJxZnZoVVhoVnFlYzJpVUxtMmdLbzlZcERx?=
 =?utf-8?B?SldtV2VFRmVMUUJwRUJVdEVIa2diV09LbWw1OXVPajk4K2EzT3FkU1pwbFdO?=
 =?utf-8?B?RkcxUnlPeGkycDdhM0IzV2NJM0FFb0RxKzFaVFF6c3ZoMjk5L0FjMnFNZ00r?=
 =?utf-8?B?eXU0YWdqUFZPSlMybUNRRDl0UDgvbWcrWVJjUmlRR3dLRGFZUllkeE56ZHZh?=
 =?utf-8?B?M1VaMTlDanZnVEdDR04xZWFHWnFEb09nOVNPK3B2cHR2dWgvaG9vQm1YVm9z?=
 =?utf-8?B?aUdnNjAvYlMyRXZtWktIVVI2Y1JjelBZcG1WVXVZVHF1a0tPdjBXaTZoc1J6?=
 =?utf-8?B?cmxXVG9jY2FSRkxwYXZvcGY0WUhsMnZkcjRTVHZra0pXTUh3MEU3ZkhJc0Ji?=
 =?utf-8?B?SGxxcGhNUUZDMlZTeDFDdWt4alB5d1gxTWdKTGdSRzYvODdOeVVBc3QxMUYw?=
 =?utf-8?B?SGhLMUVKWWhnemhobno1UTVvbU1nNjU5bkQ0VEtoR0YxR0ZleHRpeFBFZmEz?=
 =?utf-8?B?Mlk2bWVWbGNCM2JuRUtvVFBTMXd6QWR6dVZlbWtFREZhemVCMVdWUmVCc3lZ?=
 =?utf-8?Q?AhMgudN0SRx713il6gVx/g4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99407d0b-6fb1-4bec-376e-08d9fa3e4539
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2022 22:12:40.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIrcrKS5IRE2Si1Z7GXl8yFXmdO7zJ63axDIV83RwL2sa+Ir/RnY7ITLm3Rocc3j7Es/igkLKgiHCpqDkq3Fvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/22 13:58, Jens Axboe wrote:
>> diff --git a/block/bio.c b/block/bio.c
>> index b15f5466ce08..4679d6539e2d 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -1167,6 +1167,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>   	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>>   	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>>   
>> +	WARN_ON_ONCE(!iter_is_iovec(iter));
>> +
> 
> If these make sense, why aren't they also returning an error?
> 

Oops. Got caught up in the luxury of local testing and watching the
logs, but also returning errors is of course the right answer. Will fix.

thanks,
-- 
John Hubbard
NVIDIA
