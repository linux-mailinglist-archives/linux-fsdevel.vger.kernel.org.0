Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D7595406
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiHPHkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 03:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiHPHjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:39:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D271E34DBE4;
        Mon, 15 Aug 2022 21:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3SyX7E5gWyDZOJ+PYV+c0WLJoLaPc1Au5wUPNascEJFpxP5/zM80w7Qw1xHSBjjClZ93tegsjEN/xL3bIbrohdfVgv8pEIm+z1Up7TT4/rfsMSrRp5V0dPO0QtWp5vTMJPsfa2jON1zynvDLWn8RRHZOjhDhdmgG6Ss3WxKIlrGIXkAz7s6ExWGoxUi41U57TJ2yDE9XzM//eJGxG/PO/rpTCDukWb0Emx5nkmBKzWAAodU1Mxd6hfIoAAcZQoYPP1cXYkFePiqWKjUCVPHvy1rhGOMRxTNz1rZeeLbG/173dl3qdxsl+g6PE3aWQy4gmUeAsXjBQ8pvWfNDnPsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg5N3+zxcinTwLA8S9shaSA6Qs9sPBntMXqiQaBWt6Y=;
 b=Cvgn0gtNmJKx7tK7txBUB3DO9AYNG2VcZamGPW2oUsAgdDbmGoQN8Q+nkHMYswf8HTOZfxqqU1Rwmx0enxqc7klZ1ZvpdT87HVzVJOkol6592Olg15ggu9JDQw37aKQUhdxKR5U3TZr9N/Z1THSunyACjtu00XXcffKvSyvcOBvYqw7U+K5AjG+l/gmXdh0g4Cj8LWwxXmKua/aXv7CMzLOlfOwx/DsNHGOrq7uVXW+sddQ88AfdutCNZDoU/gfRC2COt5ah5tKyVPCqPoMv8e9oYvjmOX8JrbgGzuLKj0bnMKVArAvNu83dRT5ZqERsIXnQgYpbtf7oypYaQYDhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg5N3+zxcinTwLA8S9shaSA6Qs9sPBntMXqiQaBWt6Y=;
 b=GhzY0AClGu1MePfuNRAABAsfWhgPT4rg1shAmll901HsYvlK+coJJsEtMiG4nRfOncFMd65flHcPUI/AoNfvo9UrvETKHqHmrUXaet1wvv/sqfMLnWCqJG1eKcEPGGsuNBdzhPQLknSHNs9Y7/17JgDBazx9b1aH42O0FtPOKFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SN6PR12MB4749.namprd12.prod.outlook.com (2603:10b6:805:e8::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Tue, 16 Aug 2022 04:29:26 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:29:26 +0000
Message-ID: <18b4f424-c21a-5da7-5049-b643965cd885@amd.com>
Date:   Tue, 16 Aug 2022 09:58:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
 <20220815130411.GA1073443@chaop.bj.intel.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20220815130411.GA1073443@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::34) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3835707-d6fa-48b5-a51f-08da7f3fe6ba
X-MS-TrafficTypeDiagnostic: SN6PR12MB4749:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2e9VE4j+um95DoC8oCuoCB6tzNOzAObolCYOv0mMjTZZIJVirnIq+606n0BtAZx8QZnwFEO3yqcH578dwVC3ktNNwWFVUKiUJMoTVvBPEttQMuuP1l7jWKerET7fery3sY5+6+i6TVtaAZ4k6akjF1eRNGQq4IqVN+k/D5OLVjIMO/bBhFpcJwMQ8Em0fWJ2Jzo3zz3a1StvE9PNKEdfO5lwTMt6JoD9K9pZ42Cbzc+uGzP3J70JceOVHYI42zN6wY9QXm9vJveeImQgCvUht8zv+xtz+VwfLcuKpAwWmj43VYfp4VebXgewpqnohdJw+SK7yaSMlgwDd4is2oHqL+IJWGmqX+SnwXrdOcMfu1uxCIMNA8kDIoxpGENi5V98m4LSeAsD+Ni14Ra6tBWQ6goyBGocbcieHbQIoBlfv3UjmhwlMr3jlUgWmn7jtfkrwSzpzl6pD+q8IWUtcSLaJa4aarNyjru+wZb9NJdDes5qb7L8WVRM1Wb7424T47EeTceTdVj4viWhn+s1NyxV7JI0DpK7POWEbHGAztaqfkzNI+Mi1tQ2ye9jC7Dr9CjlRvKsY03MX6heepDKfoaNW/M/q1KcFkNsG8qfvtXPdvk4seJyBVYImRJj6i8wMJJ18WMNJSwztD9MhlK/yzDGJpCqzZoJ4H/jhb4PvTr6PIDWw37qey96rUm6wRyUyCqUfCAHkn1zS3K/Nnb2J7uBp/O00fcPEVdV2BxQ9GxIsAhhunHvdMxWI8UV3leK0blqFRIXv8y8kYpKiAlFPQ5+qzD/UvKtwLEJv3cU8/md84OGDeYeydQZYvIv9aygdTnjRRlOFEt3xA9v4//gmA5+Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(41300700001)(2906002)(6506007)(54906003)(8676002)(38100700002)(83380400001)(186003)(6916009)(316002)(53546011)(31686004)(36756003)(6666004)(478600001)(4326008)(26005)(7416002)(7406005)(31696002)(66556008)(5660300002)(6486002)(66476007)(8936002)(66946007)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VjY3FEMUdFT2dJdTA3TjQ3RlYwUkhUdUYrb0R4QzViVGZQTVFHVFFES0JL?=
 =?utf-8?B?R2V3ZW5TREVGR1dzcTd5cFVPWVJ6VTJ1T3dPUG1QbUkxRE1rTEQxYkxoWEx4?=
 =?utf-8?B?MDlRVUtWOW4yc0J5aUcxS3BKNmlUZ1F2SFhFbVpFalUxTnFWZGJhRWRFVkpL?=
 =?utf-8?B?K2NvcVBZWHZsdWVONnd3UmtUY2Q3MjFrMHJwVHg1cEsvTUsrcFJqdGdrWkpD?=
 =?utf-8?B?K0lDY0ZQZUtFekh1UFBtRUNCbVJQY1YrYjRqQXNTZjZTMDVqMkZUY0ZmU0RV?=
 =?utf-8?B?YlpZTW5BY1BBaDJpeGgzaGJqOHVibS9QcGZYZW51clJML25VM0UyTis0QlVF?=
 =?utf-8?B?R1QzRjErYjYzQlRBRWMxMzFidU10MWNPOHlJNkwxOEJpMEZkQmFnNi9BaTNL?=
 =?utf-8?B?SnFyZWtMNDVXQ0UrR2RwVzJOSEJBMzNEVTdpeVpuMTBqVjhnbUI0bFl2M3Ix?=
 =?utf-8?B?RTJJdUdqQ1l1RmhDaHpLSnVzcE9EdllkWDRRQnNuTXdtaXJadm5tYi9iTnh1?=
 =?utf-8?B?c0p6M01Vd2M4eDRrRlJNUGdjU093bklidllCd1ZEeTZCU0dqQ215eTh1akg5?=
 =?utf-8?B?RHYzM1E2R29hOXZrS2Z0NmNMcWFtTDFuWFNwOTdZNmtZTjNqYzJORElVYkFJ?=
 =?utf-8?B?Q0IwVEZrRGFuT2RHVVlDMmJ4V0ZpQkVIbVppMWxybU9kTWlFWnE5OWlhMC8w?=
 =?utf-8?B?TWJ0Mm9GOUp3OFMzZEFVT2gxNUFYUnFEa0NUcnp2eUkwNEtYSzJpc016bWtX?=
 =?utf-8?B?LzBYVVNmRmV4YTF5Zy9zeXhqRm9yblFzZlJ6Z0g5SHl4L25FajZhVUVHbXJi?=
 =?utf-8?B?MW1keDVneVhTS3FRdmZRaXExcnVRYURRZGlmOFlwaWNkdjh2eU5FZUFEWUpO?=
 =?utf-8?B?U2ovSFptUFljeXR5VHFGZTRVcUtOT2p0MUg4d3JOUlpBalU2dEduQ0UxYnIx?=
 =?utf-8?B?NDMrLzJIZ3JOUDJYWlFZU3JrQTd6c2FxV1JVd1hsMkFoSzlBMXJJQmp0N2xL?=
 =?utf-8?B?a1pYWStZak1kQTY3dElCdzYzcCs2NzE0cmJrQUI5OEc3SFFSVUM0bUMxUUZz?=
 =?utf-8?B?cmYxcHV5VUtrWis4Z2lhTTV1SW54OFFkT29uSFNmOUVuWFI3TTZtSnBvREJ3?=
 =?utf-8?B?T01OZlg3MTZUejRhakU3cmJZMTU1SVBCMXFvbnlic0F2T3VUY3VRNXoxYU5X?=
 =?utf-8?B?Z2JzNUFra0RwMmIybXpqWldTKzB5Snk5MzVPWUVuS1hWYjlNREo0ZWVhQ0Fo?=
 =?utf-8?B?TmxRVDR4M3RmL1EveGE5SitBTVZHVUFKVVFHWEZVS2pQMUVJMHpiKzZtUnp2?=
 =?utf-8?B?eVJXczY2ZC9POEpZTnAzMXN1YlpEV01VTXIvVndpYXBPTU9WaGhOM3hieXI0?=
 =?utf-8?B?MGZBZVdpNnFJZStkYmtMVVpFbzhGQjUvd0lweWd5T3h1aUkyVzNUVlVySjJK?=
 =?utf-8?B?TUhYSGVVN2FOZkdlQ2tFZnBjUi9NUjdqZi9KUjBWbjZGcGpMU21qNUM3azNJ?=
 =?utf-8?B?Q0ovUmV2NWZLODdta1VPYS93Q1YwMytLZVU5N2hwV1dMb1kzQks5V1VaTGFU?=
 =?utf-8?B?TVhkdXUxRkt5c1BqTkpiNzBPQ3BrK2E2VmpNVXl3NjZRZ2ZkYWxLK2dwekp3?=
 =?utf-8?B?Z0ZkWm85VFpQMHZkRGdhb2xkV2k3QTR0dDJ6M1ovcGpDZjhtNUpJUUo2THZI?=
 =?utf-8?B?SEtqcFlFNVZ3YlZFbFgxMEd5QnY3alVJY0FzYTZZMXlSTkNXdDRhY2gyMVBB?=
 =?utf-8?B?RHlGY1Uyam9YZmQ3bittM2JPb0hiRnlYSTVmNHNuMW4wenRuZlhwWFRqVHRP?=
 =?utf-8?B?S1lwK2JTY1Y5UC9tODVjZTZQS25wMEVscm93VDREOXFBSHdXQUVwbEVDVHQr?=
 =?utf-8?B?VGxLcTJrUHB1MUJ1VXhSc1AxNEkxcnBodk40VWxUc05mbkNBQnNNRDFOTXhC?=
 =?utf-8?B?VWdRS21MNG9pRG9sRTlqU01DK0Y2YldCbnJQYWw3NmZOb2J6WTdudlZOOGJh?=
 =?utf-8?B?Q3Q5aDkwMGdFZVBNTjg0VUw2Rm9ESXd0dlZaZWIxQURsL0Y1NTQxODZXbnE2?=
 =?utf-8?B?ZjR1QXRYZWNtZnpSTDN6VEhqblVVK3F4OXhoY1k5eXdZd0h1emwxWnF1ZUZo?=
 =?utf-8?Q?WGMrvBpJttfeY3FwNaT/pTKct?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3835707-d6fa-48b5-a51f-08da7f3fe6ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:29:25.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJ4cLwtf84R4TXTXAw+0dQREY10Q8DbILl2sdPaP/2AdOM2Rb5XYwMEadvxl01KvD9UqQq+RsS3KSOC6jfevTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4749
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/08/22 18:34, Chao Peng wrote:
> On Fri, Aug 12, 2022 at 02:18:43PM +0530, Nikunj A. Dadhania wrote:
>>
>>
>> On 12/08/22 12:48, Gupta, Pankaj wrote:
>>>
>>>>>>>>
>>>>>>>> However, fallocate() preallocates full guest memory before starting the guest.
>>>>>>>> With this behaviour guest memory is *not* demand pinned. Is there a way to
>>>>>>>> prevent fallocate() from reserving full guest memory?
>>>>>>>
>>>>>>> Isn't the pinning being handled by the corresponding host memory backend with mmu > notifier and architecture support while doing the memory operations e.g page> migration and swapping/reclaim (not supported currently AFAIU). But yes, we need> to allocate entire guest memory with the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE etc}.
>>>>>>
>>>>>> That is correct, but the question is when does the memory allocated, as these flags are set,
>>>>>> memory is neither moved nor reclaimed. In current scenario, if I start a 32GB guest, all 32GB is
>>>>>> allocated.
>>>>>
>>>>> I guess so if guest memory is private by default.
>>>>>
>>>>> Other option would be to allocate memory as shared by default and
>>>>> handle on demand allocation and RMPUPDATE with page state change event. But still that would be done at guest boot time, IIUC.
>>>>
>>>> Sorry! Don't want to hijack the other thread so replying here.
>>>>
>>>> I thought the question is for SEV SNP. For SEV, maybe the hypercall with the page state information can be used to allocate memory as we use it or something like quota based memory allocation (just thinking).
>>>
>>> But all this would have considerable performance overhead (if by default memory is shared) and used mostly at boot time. 
>>
>>> So, preallocating memory (default memory private) seems better approach for both SEV & SEV SNP with later page management (pinning, reclaim) taken care by host memory backend & architecture together.
>>
>> I am not sure how will pre-allocating memory help, even if guest would not use full memory it will be pre-allocated. Which if I understand correctly is not expected.
> 
> Actually the current version allows you to delay the allocation to a
> later time (e.g. page fault time) if you don't call fallocate() on the
> private fd. fallocate() is necessary in previous versions because we
> treat the existense in the fd as 'private' but in this version we track
> private/shared info in KVM so we don't rely on that fact from memory
> backstores.

Thanks for confirming Chao, in that case we can drop fallocate() from qemu 
in both the case
* Once while creating the memfd private object
* During ram_block_convert_range() for shared->private and vice versa.
 
> Definitely the page will still be pinned once it's allocated, there is
> no way to swap it out for example just with the current code. 

Agree, at present once the page is brought in, page will remain till VM shutdown.

> That kind of support, if desirable, can be extended through MOVABLE flag and some
> other callbacks to let feature-specific code to involve.

Sure, that could be future work.

Regards
Nikunj
