Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57CF595CBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiHPNE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiHPNEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:04:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47C4422D9;
        Tue, 16 Aug 2022 06:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/pklq7vSxOnOAkF71P/1VEWOU1y0BBjuu3IgodFcv0eRqj/rz4SXQ0fCwjI9t+iM+ewMMuQGf04ALTvGMRCqLnhS/DLk8IgDOiGkbFqz+f6GEYIlhNYnLt/Xt7VeduEK5BMz4afHNtq8mSAt446HPZwl/OlGPyGSkwjY2OegyjcT2FLT6OS7dTFzyJpVCKmlPQ20fUsU1XfAOUkhKrGFW8ncTTRRQ93DqQGSK0+mRC/97MHLjY4MPYOSAnYNbNVIFv0TOkpC2S4dSX8gceLablttdbH0TiURMK3WiAryvCxhEObZjh7VDpMdGdRVEJQg/j6PqjMm5kYjX8ySvSCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+8FT6JiTQcMC/ALVK6sn7OMTE0JPDM/uwycojdLWNA=;
 b=fU/GJ5HLejsFWn8vk+afk/+lTexCibOsEG+Pq7gtJntO3X0UvC5t2o+tBZ7oZ8voTlKSCQe/tSG0Arsve6PAOFaSi63HLCXCPfehW5ziIosKXugneHC608Tx73a1KLJNjrxWb716H9CEWIADQHg+3JbB7dvnN3uozXlB7h1x7YTSILlY0F9jI6zSdWb8zTwf9tnh93KGZI6pYSQvCcdLQVC8WDPSlZE0sFvFPXHrY6+BD4E+JJvtQ+pdUiJHMG49hxXiXcu6zUvs72/+FvkP7EKP1L27A/W8Ur2unGDhRL1IPYRhKSQNnmM2zmAoZB9kfnvf/dpWJIow7P+C0lPYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+8FT6JiTQcMC/ALVK6sn7OMTE0JPDM/uwycojdLWNA=;
 b=ILx28ZA63mYSvq5ws9EDir64C1C3GoLjdnrcUOY27IlArZOjmL1FZ3uqk+IS3YTwlBUrto896AVfqOsxXlHYBzyOxww6SDVXrX/QnvW/r0pV6jgV19wZPtXAqknyTIudLcVPJR/YBmcEVLZMbxVocaM7bXX7N2bDUN2TYT2TD2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by DM4PR12MB5071.namprd12.prod.outlook.com
 (2603:10b6:5:38a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 13:03:34 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5504.025; Tue, 16 Aug
 2022 13:03:33 +0000
Message-ID: <f95f35af-4824-2a2a-7cd0-71d1fda6867a@amd.com>
Date:   Tue, 16 Aug 2022 15:03:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
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
 <f0094f31-9669-47b5-eb52-6754a13ce757@amd.com>
 <20220816122457.2fjyd4uz5hp5cani@box.shutemov.name>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220816122457.2fjyd4uz5hp5cani@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::9) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13efbc1-f89b-4968-0765-08da7f87b955
X-MS-TrafficTypeDiagnostic: DM4PR12MB5071:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3P/R0ngget9w/tNl+YiggXMHDqv2yEBs3v6AjBXC1ld07V40vX8xNu9FXGg1CUO0C063Y3QnFGbVLFNmx9mobfozniHK6xe7i8bCgYj3Gvt5gvCKNgUnB7KKs/p/ZwlflPbz8mtqrnK0HfNHzfxJZVAqbm1sKg8LZ0clYTYo6gGMw4IaV+R81Pl2bso3Lcl7ezhmjsJAEwMsaSD8YgICN4IsC4Y4RqwrscZauRxJfMT9pFMvD7M63rEMLwC2rYE3/N+fN6cgzuaNeswvAbk67Nell6CDFNedjGi8Q0X6dIa7665lf8/ynprtj2JeGqlNHKfP6BMBUeKbRc7LGX6PbSClu9GGNkHwxZnidMOj4wWT8NGgdXRf2RaLlTyBSaFyQLcpd8eX0mRuXvX33rEjkH5tcAIyipyVOdTpDLkwxSSK/0fcHgzHC7hs0tNeVZTatGItUU/4ys+FwhMiyYFUiWz9mqJubEcbRboxw/zL/worE4Ica0tfSgt3BVRVFCqkk0DsiPxYKDoRZ2NKhEsqVTuXlwC3KuaUgp3duPQSHtVwbMPOnGKY5v0QyxwO8ml+mHOtNByVq9YJsaTnl69tZvQVVa4lnPPmQEY+VT9wO0gZg4ZGcpUElW+XVNUwYpUsb9N/Qak0x9leAMArhqGMcTXMBopj4ojw2X7r7fpXYMbodRYBOijJWzoCrYXk0oTRHSga3luf/e0WdZ9u1/TzyRe35/R2FMaLnApWojtUXkvdLzpedlOV94o475U8FwqkyP9CFMM6JFVa2KzeFEl03sJodpplodgD/8n5sEsuQefcYO+gaCXUFYfQ6TpsL0/MyhjGAujR1CvHB/MRKlVbDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(186003)(31686004)(41300700001)(8676002)(2616005)(6666004)(83380400001)(66556008)(2906002)(4326008)(66946007)(66476007)(54906003)(6916009)(36756003)(316002)(38100700002)(26005)(6512007)(31696002)(5660300002)(478600001)(86362001)(8936002)(6506007)(7406005)(7416002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhMZkRKSDBjblhHZHd4a1EzOXFRUkFDOFFHaXMvcmpTUFVGNXJtUklocnB1?=
 =?utf-8?B?OTFZbG5KWUUwdllETldPc0svUEUzWm5qTjZJVjBWeGthelFSNE9YcFB4cmxl?=
 =?utf-8?B?SFlVejhMUGV4T0pXTFVpbXhIZDY5bmVvdWYyK2xEODJpa1BJQmZBQ3E1c25J?=
 =?utf-8?B?RzR3VVY4eWcxaVhjU1hyZzVYZzVEbkU5SzA0M3RncVR1aG00a3cra3F5Z2Qy?=
 =?utf-8?B?eDl3Wm1DUnhHU05acm8yUk5tVUN5a0xVSk01d1IxQlM0d2NweXN2ZElJcUNw?=
 =?utf-8?B?WWNTMFJHT0RwT1krM3I2aHlGOUdGWVlVZkdRUkl5bTRvcWNkY2kycS80WFFS?=
 =?utf-8?B?QjJWaUdjZDh2dE9wQ0dWUXdPeXVQaUdjZWJGY3BsZDd1aDdWWUtrbjh1UmU4?=
 =?utf-8?B?U0hGdms3QVZZak8rNmxPbG5vVlBpSElwU3c5QVJma0t0QlNqY1h1WG92TmVC?=
 =?utf-8?B?anBMc3pFRlBlcW8rZUFvWVdpcllHMFF6Mm1WV3A5bFBkVEU3bEwxY1c0bVlG?=
 =?utf-8?B?MFZUZVhjWWFycXc4SFhsMXNzMUNiKzZkbC9jTVZnNHNmUDNUT1RXR1Rqdm9W?=
 =?utf-8?B?STZLK0Zhaytkc3EwWjZTdjk3S3FpYUljcGpQYU5KRithcStydUV5bHBuSHd4?=
 =?utf-8?B?b05wNGFCWStLdnMraDJzRU9oQzA0UGI4VkI2Q25MSXNRSzNrUCtKdXdoYVNm?=
 =?utf-8?B?bWVMZ0xFa24rUVF3TjFSUkV1RWtyYkJHWFlENHJzSmJ2TmMvRnFjMmgwaGJr?=
 =?utf-8?B?Mlp1M3lESjVQemJJRHFnZ1RzQTVkZkd3MlU4SzlTZU55ZW1CL3ZDMzVTU0Jt?=
 =?utf-8?B?Zmk5RjVKSC9PMU1UMkZPYWFYVXRkZVo1cXpOSGFtUmdFTFZZKzRkcGs1SjZq?=
 =?utf-8?B?Z3lrZ3VjT2YvRFJCY09LUlU0VFNwdzFsdmduSlF6S0k3V21UZGU3VUxnZGpM?=
 =?utf-8?B?TnhZNE9mY1FnOG0yd0pKSjZoNHhuNi9Ec0ZHMkhZVS9RdERDNWU4Z0lPTWxv?=
 =?utf-8?B?TENBNnRqUGw2dXYraHdkL1FCOTNkYUlwMEtxSWlLS05KaEVpZXU4RE1GRXZV?=
 =?utf-8?B?eVFOK1pUcXp5Qm52QVdUenJnRExVQmFIYnFXam9rRlJhd093enpqSk03TWlJ?=
 =?utf-8?B?RDNKd09MN1A5VkQvOHFXK2RxcmlWbmFrV2pKbk13ZlIrcTM1Yk5XRTlkUHdl?=
 =?utf-8?B?WGtMdGMwdjRaZnBzN1FyWVhualp4ZjdkUmNmNzdzR1NmL0p3WG83TDliTWhU?=
 =?utf-8?B?b25iUXo1aTNSSzZNb3RwWm1SOEhQc0N2b0YvNFlvb044a2YyTXJaYkg2TmVj?=
 =?utf-8?B?Tk81SWM5K1cveWJmaE11SUV4ZDdjYlZ3N2ZaOGgrUGc2RlpZVUZHVk5oNlpN?=
 =?utf-8?B?VU9jUDRidndNTTF4UUR2Sjdld1o4azZJVmJoNG1UeGdZdlYvQldDRUtiR2Fh?=
 =?utf-8?B?MWJTcWxBZ3MvL09Sb1A5c0IrYWVFRWVlZDdLV29BQm4wQ3pRZFhXemRyZnJh?=
 =?utf-8?B?dGJZTGxFQmxpNEFYRkVxR01FekczVURuWW9nN2NSdFl2TS9YZWlQRCtnWlhi?=
 =?utf-8?B?R01rR1VQajQvb0YwVDVPMTJwUVJCUFhGMFFQYytLUkpiUzUxMXlLTHhGR0RU?=
 =?utf-8?B?M1BzTS9vRHpZUVJLWHBpSEtRdEpFRmwwbnNJdEsvYVhVWXlQYmVsNDJPTjZC?=
 =?utf-8?B?cEEvWEZzeWMvckZzYmxyUElURHppY2dFNVQ5aHJuWC9nMlFjcU1VM28xbVl2?=
 =?utf-8?B?TTVrMWZ4MlJxS0MxQWxlQ2p3cmM0UDhjU0FaaENrbWI3NDJoQ1VsUU1FMG1z?=
 =?utf-8?B?WFB4aGlsTzUzWE1kZ095aFZZVjRPa3k0eGQwK0ErakUxV3BlODd5VnYyMkts?=
 =?utf-8?B?VlR2bFpWMUJlQ0VGZnlBZ1NEbVBHMnBIeDVCYVNrdDZKcmI4cGwvSUpjYUdE?=
 =?utf-8?B?bFc2NXlaMEppTGRxbXhtblRzbVU5UWpxeC9BTlZHZnhhRnJlNi9HUStwb1lo?=
 =?utf-8?B?QisxSXdxMlhSRlFpb0t4eTl2Z1RJTmxpUkQ3RnhJK0tDMlpNbGVUQXdZZEFr?=
 =?utf-8?B?Z3hRakVyUEc0enp1UExjcVJ5OU9uRW5wdVpTdHk3MmEwWXF5K3Z2MGlyYTlw?=
 =?utf-8?Q?qQPg5tTn2CJYvlNlrpyi8bE1x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13efbc1-f89b-4968-0765-08da7f87b955
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 13:03:33.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywbB9TW87oUD4PWsX5vZlZ2sfD81AQRYc5k7m+zcgBUF5mv/QNJUEUi/uz9OIwD1EQ10ARynuIN6Sg57JTnEWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> Actually the current version allows you to delay the allocation to a
>>> later time (e.g. page fault time) if you don't call fallocate() on the
>>> private fd. fallocate() is necessary in previous versions because we
>>> treat the existense in the fd as 'private' but in this version we track
>>> private/shared info in KVM so we don't rely on that fact from memory
>>> backstores.
>>
>> Does this also mean reservation of guest physical memory with secure
>> processor (both for SEV-SNP & TDX) will also happen at page fault time?
>>
>> Do we plan to keep it this way?
> 
> If you are talking about accepting memory by the guest, it is initiated by
> the guest and has nothing to do with page fault time vs fallocate()
> allocation of host memory. I mean acceptance happens after host memory
> allocation but they are not in lockstep, acceptance can happen much later.

No, I meant reserving guest physical memory range from hypervisor e.g 
with RMPUpdate for SEV-SNP or equivalent at TDX side (PAMTs?).

Thanks,
Pankaj
