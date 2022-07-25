Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5C15800FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 16:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiGYOuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiGYOuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:50:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424911835E;
        Mon, 25 Jul 2022 07:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTQF4r42Z5Gl2Tm6NREYf3c9wVWCbrTreQIize0P5j/euOjZXwIFk/U00ly6EDX1gy9Cev+raJpTg5mVxAOQ3p/3KOVBbHdb46SMIfyKybiX42QZT5IZpKkIuvGOZwFKB5S4vP9irKT23D6YkmtjqlpXAYApvEODkYMKB/s3lUQD3H6LCwTkXJgwMx12hQTcZHg4sp6beuXzNrJiV9ElFI/tXsTXXyKCIHgUeFtal6kTURafz71mkWkjPzMQoVk44kpHNjMRnTMm/3u/EzSK8nbRtlYIusV3INYgCIszuahBLZtZ021APDCEmFgkRrxq6xVa8PxbAE4oA8a0RD9vtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGgh7cGiUxo8piOwCZODYaqKZivAZm519AjxtozZYr0=;
 b=KhlA1dGLsXZ3h0bT/ABfUGNbRkJ8n5ymL3ufQvcAoUO20b/0+gnrlJ2WWZ/niGAqFpRbkVSg3HdFKTFJmsrvVQkeBF1rND3ZzUVDuINs3t3ei9otTU1ELByxE2Hx8lKYC+a61zyTtTOHDryrz9MneyICmnN73N1OAiLv73/ez+La3mDyLvrhT53Cy7dUTo5Sh4bGR4/0z3TxQPi5fznKgtzbC2YpHllRdLeSHtw78nuopCmYqxPwFgMzUOHGoPwoQYNwT1ml5dxvOpf/kjME+mLYDYy94v823dJYyCulFH+WIaX6sa46gqdmgpyhzDzHFHkuBSRSV1YHJEfRqgXyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGgh7cGiUxo8piOwCZODYaqKZivAZm519AjxtozZYr0=;
 b=RywHUoyM03elksTiq1SJyTSPY4w6SmtqDdcfPAQs1DL/Qgnw9Ui0M6osGKI4YTbC64LLGA83q8wSrkeFWnPqW+he6j9+Ezbw/nb1bTDxWEM3v8Thp+EIbc/fORR511kQlbnNw9fBdid+868bwWnjODyB1yKHLWnibPEuPXsN388=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by DM6PR12MB3706.namprd12.prod.outlook.com
 (2603:10b6:5:1cc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 14:49:56 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5458.024; Mon, 25 Jul
 2022 14:49:56 +0000
Message-ID: <c193585a-ec32-7ed5-6418-162959e9e449@amd.com>
Date:   Mon, 25 Jul 2022 16:49:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <c59fca89-cd0c-1724-210e-d9b01b375103@amd.com>
 <20220725135416.GD304216@chaop.bj.intel.com>
Content-Language: en-US
In-Reply-To: <20220725135416.GD304216@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66a760a8-4a1d-4fba-18c5-08da6e4cf08f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZ71P4njeNOwMuQCK8udkzGnrs4jK47l58HrMXEpYzhXUspWepzhixYjo5b8lzPAPcB7sH1e07qgvpxLHa3gfYDDkMjygBWTLk8/L+3gTpBEYoIh32zTIt5em/UcggX3AyQi7ND14femlQwFFm7ETrwKVhLfTCHlTfz4YArgHIHOxvPsI1xkU6W76RqCzIANZySgEqTSGNLgdM0ehNayYs+oZ6abCbmjxmb/MRCAt97c0aeP2qqCgXkBa8dc2oB5hZhk0i3jOCzTJMbGhax9TlEZWIx+0OL6oVIqEAxum+WQwMPRLORdD3HNjMmjT1HAWhs9hwp1PE8FRQPB6whknokkvQ7+/9ez/uG29aJDJro3IZllpw5StUPiGbycQR2iyc4EjqzfiJw9stT6XheqZFn/15aqWBCxLLPHPgCQb5+4n4D5SYkbTgBP8ydBReVPzG5X9G5Qi3apbtHGsTUrgXn5wDX1urG15sknifMcnCX4HzmgrU1Bcb2xlpju5ZnR/YNMqIXasqt/ngPGkH9Y7er6z0fWRR/Mu1LJiQwl8xfuVj0PhV96I4fCWlsCyRcp7RlPA0jJyuU1Jm40XGpgvvld3G1qavSrXhv6HxJ5Rc2XDkFZf/zvLGaZKfJWXtwaLjtWhqV0GU8J4L/pzGmtL2nOQc6a1BEtRvMNlHNpSW294+IzQe2hrENColocSG0PhizJyi37FT+RkhbJzdPqUmHC8uB85Q6+ubHkS1LJOeR27Cy5xLauX7Z8FlkrhY2SFdVnFAp5zpuXcXWl6WbGkrTt8/RmCbJwGM81d53dcjxpCmaJFkhpTZ8IATFh3mVZz+ZY+VjjQz8LNXwkAQfqOwnRNT0SfBeYuHokekiO1Co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(7406005)(966005)(478600001)(316002)(7416002)(6486002)(8936002)(5660300002)(66476007)(66556008)(66946007)(8676002)(6506007)(4326008)(6512007)(26005)(6666004)(86362001)(2906002)(36756003)(6916009)(31696002)(54906003)(38100700002)(41300700001)(2616005)(186003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djR0bXRNRFFnaytkZGpOcnN3emxLRy9Xam5CU1MwalJ3ZC9ubEtxRVZDRVRM?=
 =?utf-8?B?a1grQmVwWWtXb1JmeWM3OTVYYnhaaEJkU3RlS0pGMDdXYWZHVzBKOHhzQU5z?=
 =?utf-8?B?V3hTdk9RMEhMa0xpVVhieUc5dVBlaDFVUGxoNWtvRFI4cHE1VDlnaVJWYTJO?=
 =?utf-8?B?TjUySVBGR0grMkNKUmVadTl3eEdXMmgxMFVLZFFiZFhsZ0ozWndleWhQQmhB?=
 =?utf-8?B?alZYSGhpTDJMVzZVaGRGMnlHZkJSM2Jqd3phSEIwM0ZXYnhBYnR3WURDUG9r?=
 =?utf-8?B?czdsNjh6YjJMcFduMkJGTDNScUdlZ29jdUZkV1ZEUVdEcjRId1gyZEZ2ZEV3?=
 =?utf-8?B?OVh4ZkJQRDRYK2x4Y1VWV3ZpcWhZSzVPaXpNRDBFUkRkNmhkeTJZNk95V3pt?=
 =?utf-8?B?V2lTYkRuVHlmNHV0SWlucFdBWW04RFFXd2c5TXh3TVlIR3dKWk1nWmRBTzNp?=
 =?utf-8?B?L2RuM1FRRWwxckFwMVRTanNVVGJTTWZvVnJrcHJ1N1BzSk50cC8wekhmM3BU?=
 =?utf-8?B?ZGt3aW1LWnBLMVRTWXZUR1plaFhWSEw0YkxjNUQvS0FGYlRxclNmSmZENGts?=
 =?utf-8?B?SmttcE9CNjA3VlViYjlPZ2tzM2FaSTBNWGVQSk1VYmRIbzhnWktMdkw4bzhu?=
 =?utf-8?B?VFBvK3FiVU8vZ0Z6aFVFaGFaWVdScmowQXNENmtpWHplaEthQjh6d1FJemEv?=
 =?utf-8?B?RkZSZXZDL05qNncxVVF2R3dJTG55USt2NERQblZLazZ5QndFQlZaMnRqNFhR?=
 =?utf-8?B?MEd1WkR1YUhxMCtJS2hkNUF5a3dZWVhudkRuZ3pjemhyd2pkSmpFQTBxVFdB?=
 =?utf-8?B?MEErbXEvOEppc3ZZNEFsSUExWkZDa3FLV25Zd1BFWlRwNjVnRzBKWXQ0SHo1?=
 =?utf-8?B?YSt2TDBoY1F4MWt3eHFpTzBRNmdmczVXWW5xYmRxZjVGR3NuSGovOFNka0F4?=
 =?utf-8?B?WW9xRFhZd1o1VndEZlF2Y09QLzhGc201U2FQMUszVHMxcUdGS0hkalN2YmhE?=
 =?utf-8?B?SWJGcm02aFV1MmRlKzVqRGRmWmRjU3hKOUM1WGtXM2FrZUthSVAwdk9GNmp5?=
 =?utf-8?B?cnUzZHBDdnUvdVVSQWNBVGt2RnZsRGhkYTFkRXdmbWYzdnQwRnhSYmwzUEtx?=
 =?utf-8?B?NTNZdU9GanFrTS9Dd2ljbkkxcmlzN1d2bEFBTUlFR0M5M1VJNGFIYWxoMGlN?=
 =?utf-8?B?cEsvcEVQZjhqblovWEYxcnRvMXJTVXdyVUJLYjI1Y0tlYk0wRHRiaFEveXlu?=
 =?utf-8?B?UDZ1a3RwNURuTlBDbllRQ055ZEp4NU5qODQwSDZsa0ZOKzVwb0ZkL2tmWUxI?=
 =?utf-8?B?TkRkR2trUzFVZnJPTHZPWVZlcUkvaGEwYVlheWtPdCtrSGNVQVNHb1ZneXNr?=
 =?utf-8?B?d0FjYXl1MXpzdnBBcExjaUdmWHpTTWhYU3BDN1pCb2I1bWtYZi9oVWthTExI?=
 =?utf-8?B?aGxMdU1sWCs5ZWtyeXNIRldjVjcxeVkzZEdoZVdsbm16V2ZjMWtRNXB0a2F5?=
 =?utf-8?B?Nm5wa2Y5dnA5M3NqZXlQS2UzTjZBZm0zUkI4TXFFQjlhcDBnSjJxNHF0emov?=
 =?utf-8?B?QWR0emtVOTYrOUNUcVlWbzcvVkJOYUJaMjZTWDRqTjBDeEJYMGczdGNQYmRk?=
 =?utf-8?B?TldlbTduVW9vTzIvN2krK3hVU3dNOVkrTjN1VjNFUkhZQzBCVmJ4MVZMY2wz?=
 =?utf-8?B?RTJ3SnNQemoxS0ZaMlJqWjBzWVFRYWdxZXVHaXEyVXNEamQvdkVMTEpmc0Jw?=
 =?utf-8?B?TVFQU1FoczBtYkRGSGdvWEpsRUZ2cDV5dTNwMlh2U0ZWa1lpOTJSOWE4YjRS?=
 =?utf-8?B?aVR4STI2OFdIWlRtNnJlMWRPWFdscmtWejRoTDA5VHdYbzhQNEkrOUNqRFQ1?=
 =?utf-8?B?SlY2UXQ0d2VkNWpQcGpWZWZGVVlHZ294M3dyakR1aG9BeklIUjFhNmJrUCt0?=
 =?utf-8?B?TEtCS2d2VVBFaFpHMXA3MTV4NFU4WEF1aGgzT0VPaDBCL0kwYkZRZUR2ZFBv?=
 =?utf-8?B?dXpmRWVXSFVyNFhDTUNQZW91SlRNaDIvUTBHVTFLSGprQzFTcFVQci9BWTMw?=
 =?utf-8?B?WDFuS1lQSzgxMG9GRGRPRWpPbG0zeFBjMTlwbTBMZlZYa3lOTk5yUGtoeitq?=
 =?utf-8?Q?rLxJ/tjtpzzzPm6nO3C47tiBj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a760a8-4a1d-4fba-18c5-08da6e4cf08f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:49:56.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uVwNMu6qP6o72b4bf3u4HzMIDGL7TYa8SDu9w6RPOAfY22q6RG+HuVa4T0orWjWK5nu9IZmh+lZkb3/XdmOxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> Normally, a write to unallocated space of a file or the hole of a sparse
>>>> file automatically causes space allocation, for memfd, this equals to
>>>> memory allocation. This new seal prevents such automatically allocating,
>>>> either this is from a direct write() or a write on the previously
>>>> mmap-ed area. The seal does not prevent fallocate() so an explicit
>>>> fallocate() can still cause allocating and can be used to reserve
>>>> memory.
>>>>
>>>> This is used to prevent unintentional allocation from userspace on a
>>>> stray or careless write and any intentional allocation should use an
>>>> explicit fallocate(). One of the main usecases is to avoid memory double
>>>> allocation for confidential computing usage where we use two memfds to
>>>> back guest memory and at a single point only one memfd is alive and we
>>>> want to prevent memory allocation for the other memfd which may have
>>>> been mmap-ed previously. More discussion can be found at:
>>>>
>>>>     https://lkml.org/lkml/2022/6/14/1255
>>>>
>>>> Suggested-by: Sean Christopherson <seanjc@google.com>
>>>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>>>> ---
>>>>    include/uapi/linux/fcntl.h |  1 +
>>>>    mm/memfd.c                 |  3 ++-
>>>>    mm/shmem.c                 | 16 ++++++++++++++--
>>>>    3 files changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
>>>> index 2f86b2ad6d7e..98bdabc8e309 100644
>>>> --- a/include/uapi/linux/fcntl.h
>>>> +++ b/include/uapi/linux/fcntl.h
>>>> @@ -43,6 +43,7 @@
>>>>    #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>>>>    #define F_SEAL_WRITE	0x0008	/* prevent writes */
>>>>    #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>>>> +#define F_SEAL_AUTO_ALLOCATE	0x0020  /* prevent allocation for writes */
>>>
>>> Why only "on writes" and not "on reads". IIRC, shmem doesn't support the
>>> shared zeropage, so you'll simply allocate a new page via read() or on
>>> read faults.
>>>
>>>
>>> Also, I *think* you can place pages via userfaultfd into shmem. Not sure
>>> if that would count "auto alloc", but it would certainly bypass fallocate().
>>
>> I was also thinking this at the same time, but for different reason:
>>
>> "Want to populate private preboot memory with firmware payload", so was
>> thinking userfaulftd could be an option as direct writes are restricted?
> 
> If that can be a side effect, I definitely glad to see it, though I'm
> still not clear how userfaultfd can be particularly helpful for that.

Was thinking if we can use userfaultfd to monitor the pagefault on 
virtual firmware memory range and use to populate the private memory.

Not sure if it is a side effect. Was just theoretically thinking (for 
now kept the idea aside as these enhancements can be worked later).

Thanks,
Pankaj

