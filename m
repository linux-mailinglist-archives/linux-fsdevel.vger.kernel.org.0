Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4882D590E2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiHLJdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 05:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiHLJdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:33:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49111825;
        Fri, 12 Aug 2022 02:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6WKJwpW+GOm0AAdpG8laCWlDrmYPcrZFzkhWpnFlv4goz54MsHn3e91a6VYDft+5bCq2D3UwspXKBS67FYKlHIAKU723gubhdfSWlX8+82BYBFsdOcXLYqInq7fx+r6wzal0OUXJCn3DTLNMbSMl9vPn4Z6sHT9TLnWIKlPhRGz/o9LJd2ttzquxcx7nTDGnDFeC2LQFBDl+JfEbADbaujTJotXdUYJ4qTfHU4PFkCAadyjPo2/RjjIFNBc+rQT1YWXAQAbNLu8H9wB0FZhq0eLBkjK9GHYDHzNxZf8zm36F+qMmc1GQm0+NX6GrWRsT9Bb4X2OAXdtTPgiL9W+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SMQghi0SSPcHFTKNwQZZGT0IxnzxoHZ82tpqNwX9Lk=;
 b=kbs19VWuqquyYLN7dplplzPKpZv/FaF2f5xQYOho6hQ8Vl07XdPE7JRr7tOYAJ4Woi76mSvqC9hyh6KC0M0jXnJ+Ltkr4ucBxQhxObYa9ZX99Z/ZuaegDHjSyK7bMJPv4b83bYYBBdD8BLBqbSXwQsKXJq6ARF6KKFpQQXxzQvxurn8ENqHpBW6lum+prbig+1fT+G6ogGs01XlWzyKXRpiE6yMyIG+ln7pdQTDiOFkvrtnGhbFZFozog26SgXO8g/JM372NclZ1tL6Qf81EhhmHq6k0AgnU7ZA44saGR7HgLt5y8jZxi7in43HbEBc9FGc4Q+c07cpTZX/7ewMDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SMQghi0SSPcHFTKNwQZZGT0IxnzxoHZ82tpqNwX9Lk=;
 b=GBOhVYZNfLEmPlqBw+CzAakIgbrOXjl33k6goGqiNz1jJKj95hgFIHzjjSfwdJxLCX9SFluK5Vj303p6fG1Zn4K6welEEznfzN3jdquqeiwXbR6t+twCTrNXx9Aq/anlqFOWftTPL9HtPGvKEKaZkqQ21XIsm9duw/qOEEw7FDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by CH2PR12MB4822.namprd12.prod.outlook.com
 (2603:10b6:610:6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 09:33:39 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5504.020; Fri, 12 Aug
 2022 09:33:38 +0000
Message-ID: <411625ac-a8d0-e823-2f91-2d8c0bf9f4cf@amd.com>
Date:   Fri, 12 Aug 2022 11:33:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     "Nikunj A. Dadhania" <nikunj@amd.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
 <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
 <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
 <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13463a36-8fc2-4db7-0c91-08da7c45bc6d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pc3ONFv9qrQmmZwO9QzfSfSc2im2sUf5dI6Dvf4KPAewb6A7+7Go6k0xKwClkznrcpJsjC6xeTPKvRnBKQv+Uon99EhTK51yRCRv8GseqgX1Jzukw7/lE6puCkZIKJeMKZ99NlM1zwhrPAMBCQBvP4qbocvtBncVLnIJ8V2KB7asM8cN8qJnj34Aa3iZXo+iYE8JD28JlfuRh2uTHPINfWvxc3nNRc6330AWqQWp+4ZD0kg5AmH/yY4KLlx9eXKm1nAFhJNr/LOUK0sto1REN+ltNSx2TzUWSkRrR9tn/zK5r1cci8mEyhdWCF1+aN4LGfhW4F24NUy//95jnDKe6a3iNhuJ6d2Mv5ujmbHstvAofw0CizsFyEPsPish15hdROUwuTRChrDsHGCxtEmVh9TRJ3N6z3GD3wIkjqudKCgn7+uln6OddhF+LT+eCKmTmQbHmuh/tMIlV2EjgZ/mb0B9xeq0rOU0rV7eyRsSGjpNwr2doESoiL6/qiiViaA6pKUH49IJKri3g8CEjkrdEfBZ73LLrAe1qWmN+FMUV8+rTrtV0Ayx7CMDUgMt42aV6BOsceDx3UiuY7lWmjwDf4jEFDWTK3oQCmVRysKMRQXBvZd5bcves8J8XV8r1Hq0i3Gy7KFgyVz9ccrVnSdFh3QVT321J7eBBEA+LM7nlHowDc9TvpFH8U1QdywdTHZdJhy78YXpct5TrW8amvsx21iBAXZezM6gcYOQ4n2gCDU1xe0QWt5xT5fBYMaDrAjAM3UYo52rkGexRJh3etAQEmvYHm1W6RTRHn9dj6ZZ6gxA/FKjoYSfUxD4g9OgViYWDqH8Nu5FTdqc34gO2N6pog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(66556008)(8676002)(2906002)(5660300002)(66476007)(66946007)(316002)(31686004)(7406005)(7416002)(26005)(8936002)(478600001)(38100700002)(31696002)(186003)(86362001)(4326008)(41300700001)(6486002)(83380400001)(6666004)(36756003)(110136005)(6506007)(54906003)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhMcWpqWlJLR21YblByTDhXeDZiRFYwK0xhOWtNS3gxTEswL2lmamM0RFdr?=
 =?utf-8?B?clpEa00xZzJrNVNCOU1paDZyUUs2R0tPTDRRQXR0czJUbkRSOTBZUE55S1FS?=
 =?utf-8?B?SEhHQUp6NTBBdXQyazV1TVdlTzY4WjY3cFg3T2NMajBMMFo1YlhsbmwxVDdN?=
 =?utf-8?B?QmZudXQ1d1J4ZmlSeE5EUkNGTk0rdVFzUVJIbkJwZWszTGl6RUQzU3dRZXdo?=
 =?utf-8?B?SDlBck5UbUtDV29DdUViZkF6NUExVGU5d1NibVl4NnFucXgyNkwzMFFHc3Bz?=
 =?utf-8?B?QzdlaWNaVEhJbFBxeDZjRlFIVXRrcFVvWmpTUUFoaUVHdkZKTWU4VUpMdjhG?=
 =?utf-8?B?bmJIbXVoTWVFSUQ3NFFTR2lyK1htbEt3SllWZm9pd2IvdThhODVvN3VFWVFh?=
 =?utf-8?B?Rm8wWGJ5bzN3WUZkTlFnYk8yQ0N3aVl0ZDV4aEVaTUpmZStQY0N6dGxnOGhn?=
 =?utf-8?B?U3RyMk9wTFU3MTB1M0dXM016S210WXRPbWRGdVhOeHhPNUlOaEd0VVNBTTds?=
 =?utf-8?B?QTliamVoOGZwaGJMVndCK0FLUlR1ZDFDa3IvbUMxZ0dhOTdjcUxINlRKbkRo?=
 =?utf-8?B?cTcvN1hxdGRrSHMxTFUvRTk1VVlTcHlJMWovNEZtd0pzaEZjalNOT0ZpTjl4?=
 =?utf-8?B?amZnclBFNWFyckVLUGYxTWF0UWxac0gwZmFEMkNhWkt0a0JoOFo1RjVsT1Q5?=
 =?utf-8?B?cGdHSUZPR3NUKy8wTmw3S0NHR2hPSkVKa3hDb2pWUGJTSnVCNkc4em1ENk51?=
 =?utf-8?B?YnBMWnVxdWdKdjM1ZDlUaTdwNjVoTE5Na09qSUJoRmNKMUw0bWhnaXc5UUVX?=
 =?utf-8?B?OEFDZmswb2R2SDY1dnRJeEpoc2lVSGJQNEF6NkZwWEFVY25rVHNYRFY0VFVC?=
 =?utf-8?B?dUlVeEVQMTJOT0JXS1VPTFZoN1Y5MllrYWVsN0JTd0dWUXpqUjBTbkw0Umdx?=
 =?utf-8?B?QmRUSUNacHNLdkdqWWRKUitVV05PM1J3MENObVZyaXY1U1dpNFpmakkzeHlQ?=
 =?utf-8?B?R0pTRldndGlTZDlLalpBb25JK2wyNitCa0J1b3I3QlFSNXVZREZkVERzOTFV?=
 =?utf-8?B?Qytzb082Sk1WZk1zNmdqV1JpSldyb29mZzdISjcrV0VGOVc2bGdYdi95TDN1?=
 =?utf-8?B?cmdBZ1RMZ3ZkZDRDNVVnQ3YwMW1KK3RLeHZoUXAyUUwwSVlkMjV4TWQ4K3N1?=
 =?utf-8?B?d0UvZ2NpZ0FsaUJ5STBlVDdOWjVoclM4b2hERGN3UUJmcGF6bGdmRmFoMFJ5?=
 =?utf-8?B?dUhDVmp6NkFxUjJxT2o1TEQwNEU1YjIyUWhQOUR4RG4rK3poWkhLMldZc3BB?=
 =?utf-8?B?cXVjUGNGUlVGVVZHSjdkSHBrdWtkUFNySXlqYWNLZ3FqdEgvd1J6ejQ5ZHl1?=
 =?utf-8?B?UnRjMTUrM0dNUk9rWDBzZGFxSEUvSFFrT2dQdVMzWnRrZDN2cld1cEgrbE0r?=
 =?utf-8?B?UGtIUEc5bDBXVmI0cFZYSi9Lb2JUdUZWYXNXODN2YXpiVUlWbnlycEU3anNK?=
 =?utf-8?B?dVZDbXpxSk9XTVZLUUt6YW4rSlVVaS9VclBkYkNidTgzbWZpeDFxdldmUS91?=
 =?utf-8?B?Yk5xUmw3MHhTL3YxUjhIQ1ROcjU3NFkvV2dyK0NndHRQck9NcU51dG9Lc2Ra?=
 =?utf-8?B?Sk1sN0F1Rk1ISEI0VTl3K25UNXFBZkJjTElBRzZuVjdNcHNTSklLYkpYaDZW?=
 =?utf-8?B?d0tHR3RTeUtFWVBOTXk2c2dhbUxGUVZsTWJyYkNkdHZ4Qy9ob0VGdERnUFlM?=
 =?utf-8?B?V3Q4enREdEhOWDRFYndMY1ZkK0ZzNmNPZkdNdTNRQkxvTzE2RmZlRTlrSGxY?=
 =?utf-8?B?YW05TlFGaVlRcjJsTGROSGFBcTU2UDEzVTdiOE9Ob0s3TDM0U3JIekJIcUxo?=
 =?utf-8?B?eC81WWVtakhMb3lXMWJ6T3Q3UU9SR3VINE9kWW1USmNzeDhOd3JVUlhpcEFj?=
 =?utf-8?B?N2pXUnRrbFNDY3ByeGpTQnRHSEJSMjNQS1BPTUcrYzFSdWEwMXdVR2ZtQ0kw?=
 =?utf-8?B?YmMwTjY2YTVDNFhjUkhDcUpuNWhLUWFZdnRlSFEvWG9vTnptY2ZzUGtQczJu?=
 =?utf-8?B?VXk0V1BrKzdRT0l1M1JwcXdjdmZaczlBK1JZOFdIK2E0UUZ3K1B5UFJ3anNY?=
 =?utf-8?Q?Fjeo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13463a36-8fc2-4db7-0c91-08da7c45bc6d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 09:33:38.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJsj+R+D+/5ME9JGIE3EPb/6B5kSNOpTHB9W6kHRZNMKskQlF+2RKP1IlgMKLXZ0uUVZzuIn0ePjvCEP0KbAxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>>>>
>>>>>>> However, fallocate() preallocates full guest memory before starting the guest.
>>>>>>> With this behaviour guest memory is *not* demand pinned. Is there a way to
>>>>>>> prevent fallocate() from reserving full guest memory?
>>>>>>
>>>>>> Isn't the pinning being handled by the corresponding host memory backend with mmu > notifier and architecture support while doing the memory operations e.g page> migration and swapping/reclaim (not supported currently AFAIU). But yes, we need> to allocate entire guest memory with the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE etc}.
>>>>>
>>>>> That is correct, but the question is when does the memory allocated, as these flags are set,
>>>>> memory is neither moved nor reclaimed. In current scenario, if I start a 32GB guest, all 32GB is
>>>>> allocated.
>>>>
>>>> I guess so if guest memory is private by default.
>>>>
>>>> Other option would be to allocate memory as shared by default and
>>>> handle on demand allocation and RMPUPDATE with page state change event. But still that would be done at guest boot time, IIUC.
>>>
>>> Sorry! Don't want to hijack the other thread so replying here.
>>>
>>> I thought the question is for SEV SNP. For SEV, maybe the hypercall with the page state information can be used to allocate memory as we use it or something like quota based memory allocation (just thinking).
>>
>> But all this would have considerable performance overhead (if by default memory is shared) and used mostly at boot time.
> 
>> So, preallocating memory (default memory private) seems better approach for both SEV & SEV SNP with later page management (pinning, reclaim) taken care by host memory backend & architecture together.
> 
> I am not sure how will pre-allocating memory help, even if guest would not use full memory it will be pre-allocated. Which if I understand correctly is not expected.

For SEV I am also not very sure what would be the best way.
There could be a tradeoff between memory pinning and performance.
As I was also thinking about "Async page fault" aspect of guest
in my previous reply. Details needs to be figure out.

Quoting my previous reply here:
"Or maybe later we can think of something like allowing direct page 
fault on host memory access for *SEV* guest as there is no strict 
requirement for memory integrity guarantee and the performance overhead."

Thanks,
Pankaj
