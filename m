Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D865A3AB8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 02:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiH1Aqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 20:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH1Aqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:46:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A90A41993;
        Sat, 27 Aug 2022 17:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU6vQreB2R43gFI6a/q8kPaIMym4/C5rcOa+WADbh5PoWNg8MwApYI7Tqy7iADFynOm/3mkEkSmv5NOlAHx1E7TKN9BBY49lOEvga15z5AwkzRW99yCppF23v9yim0QiwIFhaTcYkxdiiu0bNZ0wJS1uB5mYx7WVDSfOJwGg3sHysIdxh3Dvn19aJOakKnX+PZkQSO+JYts2nXhzBRmXUSJrk/ml+TTBRkXjvbvf1TEwN5UupQGzoHs6OmLH/Qp4JWWKnXzxzZgw7JoP/AnkABZSQb0SQ3O9O3G7qcmQHJkKML019maKjPgR3Ela2IXwBEGHZ3denPo8ZKFVdImMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INed6BQQIW5xBMYZthpJVN5qYhlixuE5CsH/9pLECHQ=;
 b=Cr9L1c2efTtokLBFv1HDEb5CknurQSZJH4dWcTSrPlfqkc+8xWb7WAJDN7p7mAV18XvbXas25eg6BGcyI6bGWx06tFkO5YHt0CwhYvqS7/8LKgP2tREcg+vehkBybqBhAzGEnN3ZAOPetj6DNIi+b31/TGRskYX83pNqRPD8P2c3qZjqijFjRiTs5OMmeaJdRCSMfaH+UN90xC0kHRy3kJ9OusjGI7N76XW+Rs8PO8NTMplMeIpLulY/i4swhYrgxzcyXKj+bF4I198ymlKY77lio1ZGh8mqxXKV/720JKbcQOkox4iTffk+Apk77+F24ApB66FrP3tgSze52CGJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INed6BQQIW5xBMYZthpJVN5qYhlixuE5CsH/9pLECHQ=;
 b=m/olAyVQPUGhUdZyMcnuj5fQxLJyqZOheV65Y+aGsA9SxzI9t1SFvfgoxn8jwYCziiAWKgzZSWy3fQHYLNn46Y8cItc8HW3ZEanu9nDv9dkiDbRajQDbTF/RC3Hl8CTTLi8swS+9UeZc2XlRxT5W8Byg4tKK83h/ZKaxUmGSCumhK/Ctw14MtSYmrimH2RuFzLlBeBUOI1z6QpHBIHOR738fN3moOQwanc291yoegCg/gzzlcSH0TV+fRgPhkUHfJZhw7cbDLWshk7Jm5Ud4ECPSH0oxzarx2cDKHSvbLfh4zPhJ2qQnBKmZAJxu8M3B43mtOovIw1WcRXHrv1IeBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 00:46:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 00:46:28 +0000
Message-ID: <2c30c786-acad-238d-327e-2669e7ebcfcc@nvidia.com>
Date:   Sat, 27 Aug 2022 17:46:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
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
 <20220827083607.2345453-6-jhubbard@nvidia.com> <YwqfWoAE2Awp4YvT@ZenIV>
 <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com> <Ywq5ILRNxsbWvFQe@ZenIV>
 <Ywq5VrSrY341UVpL@ZenIV>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Ywq5VrSrY341UVpL@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a623983f-6156-469e-ae52-08da888ebe0b
X-MS-TrafficTypeDiagnostic: PH7PR12MB6933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgccJRSgYAtZEjKSF5TvY7/Atnw+Se+zTyjTOgj9ujsincAX71fZp7hQI5t1dohRFMaEyXO2SZLYGwHktCpt2b6OiBNTZVHfdP42tYEIlZ6TYSWrcSmmXw/4RT27ORa+Yt5UegttRIXx2TDuOgLeja5RwfRGS0g5mrJt/YbeM+WG2nmjPbMjzx76Enrj2q78EFOIWJJLaYIvi7WnclEk8XBVgZy3qZQBhG9ex/f/r4yZJ1/vKqcGUP3JlOHm64q6fQ8+QCBYIbEULeAxoF5fmIpUWx+OwozriDA3EiQMJy4IPdGZb03g+ObT5zksV7cAx0CEQKxG47ODjYBTUjDWrS8eBRhCaksaSNv/GJSRcOzYWAPNVioDjdcvgbmqRpSXYJBnzyOzUEKwAFsy3MoUrZYV8DMzl5fFeq3BTdUKi9L6/qDMPaJ9mF9Ggk/mFAdjqv3aksYXf9xKkQTnhGjvdRWYuYU4Pz3RgcO/McU9fRHdGquLCKxQmxeGGJRQjV+k3UpNX+PogGawJZ0kWrOav5X/fVwL9/3qcKAzLquMu13VEMcvWqr39uvXazmU9+0d9xbAGNU9kO0O+wZoz9XF6C1tZDr76j/gQErp3J1EbzZL5jEfy8wO3NM5DDU1mOX/0iziwo8+WZDr6/Q1ATVRW/5FaGsoJ6truW8dGNyUzJmladnZn/fcM3iXSfrOjNfG1YmOM6LtwHTgnD4rXlWLSuwAC1rAJPfw9H7nyDYtNvIXgC8+AG4INHnkr6eI4h8+cq4kBfJPUQlEK1ESgaweJec2BuDpcIgiXHMThFKnEXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(66946007)(8676002)(66556008)(66476007)(4326008)(38100700002)(7416002)(86362001)(2906002)(31696002)(8936002)(6506007)(5660300002)(53546011)(26005)(41300700001)(6512007)(478600001)(6486002)(316002)(2616005)(186003)(6916009)(54906003)(83380400001)(36756003)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURlZUJ5NkwrSit5OTVjY1gzeU1hTGhGaFZSRWVNdkdIeWtRVkxiVnRiV29h?=
 =?utf-8?B?ZllHQnBuYjk4bW1iMEtCdG45bTZNUDdoZ2ZLeVZWQmVTNElRSW1ydTA4eHdE?=
 =?utf-8?B?S2hlNzJhZ1VaelFXN2hmbEcyVW42TlkwNkEzT05GQmZXMmdQakJwVWhURlVG?=
 =?utf-8?B?WU5lRzY0cUl5cnpOQVlnTjBpczBKNDlNb0gwSElWdG5pV21hclRoWWh0VkNW?=
 =?utf-8?B?alVNMXhZNUFKZ3E2NElmK2hLWGQ0dEw5cUtCTWVIcE9mdjVhb3lZY1B5ODhT?=
 =?utf-8?B?c2xUU3U2b1BoRjJyaldLQnVOdkRkT0pldlgrWGFVM1JWNXN3K2FuZ1dINWRL?=
 =?utf-8?B?WEhmR1NBQWZHd3l3emt4SU1LVzQwWFE2N1R5d1lGWnRJdW11Ym1aYng0cW9V?=
 =?utf-8?B?bzBta1pTMHNlbWozVExnRHptZG5qaWJSS0NUMm1oY0FYRi9idFdjeDJLeUFv?=
 =?utf-8?B?d2M5Vmd0YTB4R2Q5RE9paTZhRzhIbDVMbEswajFoTmxuN0I5TkVXck1UNzFP?=
 =?utf-8?B?dW1PSGhCQytBdW1zck4wZXFYcGczOFFsR1JreG9xcTBKb3Y1M2xkcWZidWg5?=
 =?utf-8?B?OUpGd0RRK1pXb0hoUVJYWkJUZFVlUDNablc5NjZrMzRLY0RscHVzS2ZiaG9l?=
 =?utf-8?B?QkQ1N3ZFaVFlcVByRmVVbWpLQjVlVElPbzVpZi9ZeU91NjA0L3FGK2ZwZFp0?=
 =?utf-8?B?NUVic001THRLZU5TaE9FcVZTb3dGWUptOWpBdUlQQWE1eFh2Rm81N1c0dzdx?=
 =?utf-8?B?RG1WUzcvU2V6Z1Y0YjNHVVJGVGlHNER0eU1nS0dKWXJCRmk2cWdDcEFkalYr?=
 =?utf-8?B?U1grME5pOER3bEF3OWxha21qVXF4VHl0UVVEWmFHQXZtS1MxdGx5aFoyaE9q?=
 =?utf-8?B?YXpZMzNjWGx6a0wzSW51dFJWaUp3THRLOG9CUnlMNDY4MEthZVJlWFpxSG4z?=
 =?utf-8?B?VTlKU1VUbkNudk9oaHc0UUUzUG5wYkdUZFBIRWcwVndtMHVET2JGd2FNWVVN?=
 =?utf-8?B?SEhKL3ozZ2k0V0t3Q0s5Nk5pSWJlejFYL1ZRZHgrVmpvV0VBNldQMEhZMTM2?=
 =?utf-8?B?eXpjUGF4ajlDZFNJdFBKSGhUcnZmb1RNQlZrR0Z3YmQzcnNPS01jZjF5dGlS?=
 =?utf-8?B?MEYzY0twL3MzTjd4TzMrcTQxY0VSSFZIYXI3dHlJQkh4RUx1SDdreWR3WWUx?=
 =?utf-8?B?eWl3QXhNL25iZlI0MWpMdi8vSTVYNCtISkduQ3AyTTVjK2xwbU5QTEFwSnp4?=
 =?utf-8?B?dEtweEJUaEQ0MG9aSUZGUWxqOUorUDBCRXhVSmNCMUY5d0pPSG9xb3FUenY4?=
 =?utf-8?B?Umlibi9TSHp5c0xzc3BxL3JVRUp2L0NaalRjQU9XT3ZSN2kyQTJMTUVpL1Rm?=
 =?utf-8?B?UUM3c28zY0ppSTkvb0htbXc2Y2JUeDFUVGFzUU50ZVJ5UHpWbnVnaG1yRVlx?=
 =?utf-8?B?R0VPRzNVK1VKbnpraEVwdGw2VUxZQlUzZGpnUDVTNHFjQWExY00wOUppQmhI?=
 =?utf-8?B?NlZJWnVIdVRTNFRVRWNaNUNVM0xDa09hbFpsQjFTOEFCVGRGTkRBTGxXRVpm?=
 =?utf-8?B?RmU3L2tQNm4zMkxxYXA3RUFzM01vbWJ2bG5CS25XT0FJME9KdXBjWUtwc2xC?=
 =?utf-8?B?bDZheEVDWlYzYkNsUzI1NGpsT0xkZzNhOHk3Mkdhb2VDV3dqTzA2UTBOSCt3?=
 =?utf-8?B?UUFBNUtpNkszYzVhTkx3NVhNVHhvaTlEazYxUjAvVkh3OXRwZlc1SkVTRHQw?=
 =?utf-8?B?N3RyUmt4RE11OFZESkY2eWxhVnBkSGdKVkZuU2RlcTVBRXBLYm5sT0JXclJZ?=
 =?utf-8?B?bVVId0xDSzVyS25aU29yUUFLb1lQb3NKNDQxdjhMYVdhOUhJcW4xa0R4Nmlm?=
 =?utf-8?B?M0M4dXhXeU5XZzRLTzZma0pOcVdDM2FTT3l1L2o2UE1yQWZLSWt6WG4xaW5F?=
 =?utf-8?B?V3NCVEt6a3psM0RZb056VnBCZlZFcGdLSkkwZ1NHeExkcjNqSFBZa3IxK2VM?=
 =?utf-8?B?bzZPcXhtWjBVU0xQV0tkY3M0MHZFYlFvUUpVb3Vqa1VCbzk1OWxPZjgyTXQy?=
 =?utf-8?B?ZVlGUjlUUGlhVnZzanhxcnBPR01SRWl3dHRDZk92cTFNSHJhNjBLdWJMOWpt?=
 =?utf-8?Q?opjdSvKnxd2ZHS2XAEcSHsrXC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a623983f-6156-469e-ae52-08da888ebe0b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 00:46:28.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/Nq9SNjF3yH5zZJmY2cH6Accvi1dAw0/vXBFLFFshDkNMCO7dt+F91l2uER9YC0SHIjhNVJblWks3N3D/T+KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933
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

On 8/27/22 17:39, Al Viro wrote:
> On Sun, Aug 28, 2022 at 01:38:57AM +0100, Al Viro wrote:
>> On Sat, Aug 27, 2022 at 04:55:18PM -0700, John Hubbard wrote:
>>> On 8/27/22 15:48, Al Viro wrote:
>>>> On Sat, Aug 27, 2022 at 01:36:06AM -0700, John Hubbard wrote:
>>>>> Convert the NFS Direct IO layer to use pin_user_pages_fast() and
>>>>> unpin_user_page(), instead of get_user_pages_fast() and put_page().
>>>>
>>>> Again, this stuff can be hit with ITER_BVEC iterators
>>>>
>>>>> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
>>>>> +		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
>>>>>  						  rsize, &pgbase);
>>>>
>>>> and this will break on those.
>>>
>>> If anyone has an example handy, of a user space program that leads
>>> to this situation (O_DIRECT with ITER_BVEC), it would really help
>>> me reach enlightenment a lot quicker in this area. :)
>>
>> Er...  splice(2) to O_DIRECT-opened file on e.g. ext4?  Or
>> sendfile(2) to the same, for that matter...
> 
> s/ext4/nfs/ to hit this particular codepath, obviously.

aha, thanks. I do remember that you alerted me earlier to splice(2)
problems, and I thought I'd neatly sidestepped those this time, by
staying with user_backed_iter(i) cases. 

But I see that it's going to take something more, after all.



thanks,

-- 
John Hubbard
NVIDIA
