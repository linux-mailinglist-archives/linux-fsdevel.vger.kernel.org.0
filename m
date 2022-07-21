Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D694457C8EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiGUK1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 06:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiGUK1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:27:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF23F820F6;
        Thu, 21 Jul 2022 03:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmp6C+akleKjO/jKIf9JNjRss3znWcw06A5fhBoVsiwTeYF2Lz8oeT3DIYntgPy2xSmjTMJCJwuFU9FLoSe53EDXaimSjxyE74IWbFJuTT7OW6G24lx7Twierm9ahzUisRsJUF6rcQeyhdxV87TG5Cg2P9f1uymDwTRKgGF2iyaXckTfbc7v4H3EgTNtz16s3b2dcl6ldecmDI4fub6gkrTTW2oddrV+xM6owuFe+uAb32Hg980xt/ivX0v+dKmycNwoF555ibgr8tx8eIoAGIOafDDS4/S3/eCuVes8qdn9zwhs+ohdIANfRtQpAioqCWT9VlbkFNjUhZRsXUAIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg0/2EbRBjSfICjHk4BOyAszvl0FzffETSdPTSpDvXw=;
 b=N6NcZQG/vq8yw17Wvyacc4hDjFcYCxG32r4hB6F8kP2NAqhNHgb6UlqGeAcPsO5gimuhQRO+pZWF2UfFzfNfBjgmMkWD+BxSUi6CorCWr+2V2zzCDU7BVOYOZlamX009j4zfPk3hhDUXjksWPYnhFLTf+AkC0mwyA4j2TYav0aBlZ2vsLnEMMZpCeV+yHwxu1oZfWZOa6h/6Y5OwRVbF0ND0oE3I6PjH3Q4+iiEg+jVN2PT7T2Js3ZEl8j/zPvYLm6ZQMt5F10nfnJ6+FIiUWIKDpPggwWnAQ4azDRwdPyGH4Axfb0rXKqmiXkP5UyzRrVnf//N2h6K1Ox8TsOEkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg0/2EbRBjSfICjHk4BOyAszvl0FzffETSdPTSpDvXw=;
 b=dFRJ4rSsiFiUlw9ASjvgTfd6Navm3HEmcVUXiObfTOLfrK24UA1aTGnYaHGSbEQbyuMNDUtcSJZ6tQ6+2cqT79bDHZ7RTYGR9AIvWRJQnXj5k2Kau4A+y+5NQ02GgmvfLDMDpdIaeOyL9mmejsunNI/00P0Mw4jEnQ3JZyKE3ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by PH7PR12MB5997.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 21 Jul
 2022 10:27:20 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5438.023; Thu, 21 Jul
 2022 10:27:17 +0000
Message-ID: <c59fca89-cd0c-1724-210e-d9b01b375103@amd.com>
Date:   Thu, 21 Jul 2022 12:27:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53eaaeae-6f70-4cdb-2ad8-08da6b0395fc
X-MS-TrafficTypeDiagnostic: PH7PR12MB5997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3rkqDu/MtUGfyd22dBbc6buHqVUAwskQuYrY8FQ/jqYy4AXtuONs3eOfcOI6y0yMLZMFyoNZQr+OgbE9P0fk9c8kGLw6dL+5a5sDQ/1VIL4G37lan767xHVH+7JvNMPxw9RrqDOnc31y8HlNnpJiAm2LtHZDlts3o0Ot5sH2Jo2GNZQjA1Ag4iQ+j/ZHXK/LzqYbRrvrwagiGq9gyiGSF8NjffP9P/T2dV8HT8CNe+5FpWERS5U3ziaE5FCdrcyH2EPXiNWO6nChzigLX/qid6im3OhYTqYhZg0NRQn+JlLr2NAuVHhLsff++S2reglOI+N+LS/naPXXuXhhDQR9AR9uO3rqg8/ulMb/EDtit3ueoMbJ2dudoMUnnfgv91BUa3PmPa012nIkRLgZxKF/8dZ+bgoFvN9mgE8SAF/n1FNQ8LkL3Qf+H8k/GwB3070VsETOvpBNr3dZxCh20/5mS3TuHwQizEV019UVd4V8ZRRS5EWFjb1Th2VmZje5ONPs9ACfhVlDcyPzsa9gVvtzRJ3aweVSDAmgVFInH/qCRl7Vl38UJVTwc0fCOHZ3baNG8iQOF7mIG5Gc4LV4fK8qTaVGu+EiM1+ELoIrKeyWgCd4aTz8q0+GyaJFPMUTTEmdq4AuDnHnydXga5xHrdDTjVjkhfisCMWhCetZNWaLNgTn579rMtmwi3wedaCGbSlZsEdPCVwRgfPs8taB9+As3fWzRySjv6iW3fZ55SlVytCyHGQyrfP6RD3jsIDU8SCGbk4LTJPiYMOgiis07DQYkSosH4DsXESr8vg36Xr4utexmBPGO4FoDjHNulhT49cBAl6rrV/9rYsY5dQklMkNg82J8j/ijz2cSr+sJHvTqu/+ZLurSqaVHQPNqGLq8V3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(7406005)(31686004)(5660300002)(8936002)(2906002)(54906003)(7416002)(110136005)(66476007)(86362001)(36756003)(4326008)(316002)(66556008)(83380400001)(6666004)(6506007)(966005)(66946007)(478600001)(41300700001)(8676002)(6486002)(38100700002)(26005)(2616005)(31696002)(186003)(6512007)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXFUL25NMG5BamhqUUZUMWxpcEhPM0phMnFpM1F1dExSdFBHekc1bTZHcGhr?=
 =?utf-8?B?SlJCRVFwVG81bWFpVk9BL09xYjRnR2NiQWVkTTlsMUpLMzBCM3JEL1RwTG9T?=
 =?utf-8?B?RGZDMGwwamlvcEZWczh3WS83WXNkdE5GdGZ2WFpETUtQUDV3VzZwQ29Zekwv?=
 =?utf-8?B?RTBCQllobEszV1FjZTQxU1lwM0lEWXExWC9xeDFsWFMrRVVuRDBCKytoYlRF?=
 =?utf-8?B?Z2dnNm1HNnpQQ25OTHVpRm91ZG5uWmZPRGVBdGZ1UHl2VkFOR3BPZGtDRmp5?=
 =?utf-8?B?QWZTeVFOV3I1d3RXcGdOcWFkUkZVWUx3UjNZejdRN21wdFVQcmJVMUV2Q1g3?=
 =?utf-8?B?RTlYZk1sM004MnpmTWY1Q0phZzhOMDJzdzFzWTZWa2x6Ulk4TXR5TnRtM1lI?=
 =?utf-8?B?TGtPQXhSQTRTMHN1Q3l1VU0xRUJtNGtFZDFGWUxMclJ1TUVZUzQ2WHBuM0Y4?=
 =?utf-8?B?cFFUdjZjdUg4YTB4bGE3dlJJdWN1TWptc2ZIazRsQ2FNM2poTzZDSklqbE1E?=
 =?utf-8?B?VEdVNkNudjFPU3FqdGdUMGZDMlNrMUpyaGxNNEtMYmZOR0lCQTQzQXAyVUdW?=
 =?utf-8?B?dndnd29kMStvOWlFMHNiUklvRzhndHo3ckJ3UmpRdjRJS0RrbmptaitJZkpI?=
 =?utf-8?B?cW5WOENpcjFvVGdtbXRIdC9jU09nUHNyb0U0emZkM0Nvc3llNnF6K3JsZldF?=
 =?utf-8?B?ZE9Ga2VFSDBmTlZrMjBYRUtRSzM5dTN1MElWdGYvQVJzTGxjZ2NWb2NQVHNx?=
 =?utf-8?B?NUJqa2JDQ3BqL2pqc3BaZlg0ZExZNUhYVHVRanBGbUY0NWhZeHhkbm9aOElw?=
 =?utf-8?B?UUcvZ2lSbGYrek9nU1JYQXJBSC9LdldrMHFLV3dkSFZPSktSSkh2amxHTDhs?=
 =?utf-8?B?TGxlQ3NFNHJGTmZGWHJXZ2svSnhXN28vaS8zanVaU0EyWWNhbjRKSFJVT0pT?=
 =?utf-8?B?VXd4cTBvWFIydjdDdXlTWTNDTTlwNngrc2V5dHFTdGgyM0hldFdWY3Rpc0Nm?=
 =?utf-8?B?ZkoweGFxazEvdEx5N3JsblpWWVZiQUNQdmt3YnFKcVp4aUJKT3ZYVW8wQjVD?=
 =?utf-8?B?ODFsdzE3L3h0SGs5WkVDNUZSdTN4WDEzWEIvZE5kMmljYnFpSFR6Y0pRYlVK?=
 =?utf-8?B?QnhJRGVnQlRWaFdmS0xpNHBOczNTUHJjQ3lHbTRNcHFUbGJBOWFRTndWNXdM?=
 =?utf-8?B?ZExmQzIwMDVJUjQveE1CeG1CZzVnSmNONE1kdVB0SEowa3hxa0FyT0VOSE5P?=
 =?utf-8?B?cmFaS2c0R0xybjc2K1BMblJ3L3JzQlVad2M0NHA2akUvbGtxNS9TZXEvVTBT?=
 =?utf-8?B?NlZqNlJtNkpTUWtSU0FqNXhFaTQxSm9oY09WMDdJendGV3pqNm43K202c0s5?=
 =?utf-8?B?MEUrRVJwenF0aUszZitsWVVReG50cHYvdmpkOVdRTFpmbDdnYzl0OGF0QWhI?=
 =?utf-8?B?UlFoZjVrb0d5R0pWQjRjSW5SdkZaUzlBU0xjeU1QTkhKMmwyY0hQWUpQNlg1?=
 =?utf-8?B?U0VmYURJM2xYQVFGcjJOQThxNndNcFhuQTFHRExYZlhaRGNnK3VQYUwwUFNW?=
 =?utf-8?B?ZnlVVFptLzQ5NmJJVmhPL3ZqdzhWUFRLbFM5YmR2b3JUdkMvbi9maHRxWXc0?=
 =?utf-8?B?OE1mclArTjR0YVBnemxobGFvWnBBcXM3a1RuK05SZEhNZGVRQ3N1K011dnJw?=
 =?utf-8?B?TEtLK2xjWWc1blZMTzZnd3hJZ044bllhemZBamEvRmQ2cGlQaHhlVTlSa1N2?=
 =?utf-8?B?RGlQMERzUjdVQ3IzVWhFTUNtUTVNQlVZWHJuM09oQ0hwNC9TR2MrVzNVbjhC?=
 =?utf-8?B?Sk5vb1NvNm54cDA5VjdPdGJ5d0VUdHNzTVlGYldCMkljbEw4TnpNVEtPQ05J?=
 =?utf-8?B?TkpHWi9CRW9KS3l0OUp1QWJZNTVKb3VzZUpCaFlPS20xZEhqeE9MYVpxaGdN?=
 =?utf-8?B?UzU5SG5RRjFmbi93UUREbzg2Q0tPL0NacnQwUnBzSmNMczBtVkQyZFU4QVY0?=
 =?utf-8?B?MFNBNWg0R0ZhSWhhV01EdTQ1cU1qM3BKbWpkVDFEL2w0UUVvTjdKRVpXS2RJ?=
 =?utf-8?B?TXZRZlNwem1FbjFmMzhFb216RnYwbUNoWEl0dkFBLzZ0NUJjanNvb2VucVhy?=
 =?utf-8?Q?JsGJWlysto510nMhC5R5acQJ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53eaaeae-6f70-4cdb-2ad8-08da6b0395fc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 10:27:17.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ns8BJ2910Nru/VVWMevQ1YUBMuOXwux3PJqjATN8kEFATZe6Vku1yYVToWVgOMore/LEkylzIDRU9hHQjG/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> Normally, a write to unallocated space of a file or the hole of a sparse
>> file automatically causes space allocation, for memfd, this equals to
>> memory allocation. This new seal prevents such automatically allocating,
>> either this is from a direct write() or a write on the previously
>> mmap-ed area. The seal does not prevent fallocate() so an explicit
>> fallocate() can still cause allocating and can be used to reserve
>> memory.
>>
>> This is used to prevent unintentional allocation from userspace on a
>> stray or careless write and any intentional allocation should use an
>> explicit fallocate(). One of the main usecases is to avoid memory double
>> allocation for confidential computing usage where we use two memfds to
>> back guest memory and at a single point only one memfd is alive and we
>> want to prevent memory allocation for the other memfd which may have
>> been mmap-ed previously. More discussion can be found at:
>>
>>    https://lkml.org/lkml/2022/6/14/1255
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>> ---
>>   include/uapi/linux/fcntl.h |  1 +
>>   mm/memfd.c                 |  3 ++-
>>   mm/shmem.c                 | 16 ++++++++++++++--
>>   3 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
>> index 2f86b2ad6d7e..98bdabc8e309 100644
>> --- a/include/uapi/linux/fcntl.h
>> +++ b/include/uapi/linux/fcntl.h
>> @@ -43,6 +43,7 @@
>>   #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>>   #define F_SEAL_WRITE	0x0008	/* prevent writes */
>>   #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>> +#define F_SEAL_AUTO_ALLOCATE	0x0020  /* prevent allocation for writes */
> 
> Why only "on writes" and not "on reads". IIRC, shmem doesn't support the
> shared zeropage, so you'll simply allocate a new page via read() or on
> read faults.
> 
> 
> Also, I *think* you can place pages via userfaultfd into shmem. Not sure
> if that would count "auto alloc", but it would certainly bypass fallocate().

I was also thinking this at the same time, but for different reason:

"Want to populate private preboot memory with firmware payload", so was 
thinking userfaulftd could be an option as direct writes are restricted?

Thanks,
Pankaj





