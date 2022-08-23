Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB47259EBD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 21:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiHWTJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiHWTJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:09:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D9AE9DE;
        Tue, 23 Aug 2022 10:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlPtS0ln9KA4LWPWklOd16cHQjtnBD8aePP7NAGel8hwX9cBylYn6pO0aA4zeYvhswHA2BpAgL6ft5bhfwPWKOQf72sN1fimkTxiactL1lf9P2yAxyIA1npScLis9XcSYuV6paQILCpvr8X1WRvqWM5CpjM4Yln2uOZE/2xKTwnrJVUsE1no7Bb1WPZMtds8YQY3axJ+JIHK59cOElpO2iPsi0LVLXvK9wf+qjWbQuRcbrHIE20AeGj/ta92LOuS1eMhP6vYbgExiTjp3UFNLX1SYb1brmd+oeskYXMW7MGWc6oQj59uuqkIfh4kTnhpmdBZk3VpNGwTKRbgoFw3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHlX35ym98LXJ23NpN08gdnz+o3VaWUk/Nj7K3VV4x8=;
 b=Lh4ENWpnJ9oG6bmW+AUM2YhyrTf7I3OlcdB8su7oVNTVWRp/8PT5HMhaZDimHSlvwma/6GHmiYVjj1fg/eIEabpm/vZ2Xc/XCRGUG73n/HhN+IfUP9p4bFBP8AZk1MXI7CwLi6Sqgbyf6iCa2VoPVtfrZAXS5MCGpq/Ud/doQuKIxsRYCpekSqdR767zWICi0b4h576inCJ0zEW+l8uyQ/qpLDIJcakYCqQFYl3JMCl3nMkcRW1PvN4whmC6QQEw2i932utp/0rrXqLTYkvb6V7UA67gFnIOS5a7YuJWSS+b70diNn732Kc13bahj63B+Ge4tJM7jYTR1BqY+U99qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHlX35ym98LXJ23NpN08gdnz+o3VaWUk/Nj7K3VV4x8=;
 b=D8kDTZocmlesleno4yRyx/t/qMTRDnpn7AhdeaWkQMMXyDSjGf4n3vqTccbD7TtqfscTxzg/naN/KRjKsj8JHjymRefqVQeMVnnoLGkBKlzJaDhvLlqz8bi2HAyx9MfOkUdO4DkEqczlCGz2miBFG+lq0mC5RALQQvDYbRPiHBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by DM5PR12MB1658.namprd12.prod.outlook.com
 (2603:10b6:4:5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 17:41:48 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::dd6a:ad02:bcf4:6758]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::dd6a:ad02:bcf4:6758%11]) with mapi id 15.20.5546.022; Tue, 23 Aug
 2022 17:41:46 +0000
Message-ID: <cfd38409-d045-4cdf-2104-dc8344515ee4@amd.com>
Date:   Tue, 23 Aug 2022 19:41:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
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
References: <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
 <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
 <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
 <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
 <20220815130411.GA1073443@chaop.bj.intel.com>
 <f0094f31-9669-47b5-eb52-6754a13ce757@amd.com>
 <20220816122457.2fjyd4uz5hp5cani@box.shutemov.name>
 <f95f35af-4824-2a2a-7cd0-71d1fda6867a@amd.com> <Yvu54I7Y+/ybVyec@google.com>
Content-Language: en-US
In-Reply-To: <Yvu54I7Y+/ybVyec@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0245.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::13) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53222aa4-5744-432a-a4f4-08da852ebfcf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKgPZ8cQDWA9DmKKOVIGHcGJf0oVqyjVIMyKzWCrkox5JMj9v0f0fz/EZ+GFtH/8WNzONfRFX7TxRsOmZnNxQgQTO2NglLTg822VJ+4UtPebLzM8eVdtAPnbdY5i+apXUIr9ynwcZ9wPPfuAGfUIwzJZR9jdXDIZkMnQ6UXPbnD3ArqfkhYhUhdKsUU3t9k2vf+UXuYRJ9GCTJ/wohcZEtnvv5h/Cu5vfdqPIYhoTwQBSfgm9djuS+9iwOqcytU40e5Eczu4A7RCH49fGQasa6uOHgvPEbnAqxwj4inevuXK/d3XNYwlvSHAMy/cl1rZsYBVtUZ65mfOt8Ou8wged82eIFgcS600u0VJt6wrLrZv/KY4F1gm/swAr8k98DNLCXB3z55FpXfdiodaPuKEr+dhHjqSVELRejKRaQADzbUBKvJKw0kavM7sV5FEf08nwCDIC7YnYHaJlVzaUnSL+NclyseBDBofwm5LqfQaH78wNP+B4KNnm7tNKRyWdU6aa6LCdntbNugis/hmGludBegn0ykZcC/o0yr5UKI74LTF4woWfEBi0FioeixxewliZ6wPzNXnJMImkiCZUmnlc/9LTVlTS+epILQi1Uu+DlcrfdY+WtTNOWjJX2zLgcAib0hEPoCYWCQRzD/lvvfZkOSnjyaC5GZ1ORAx/h7yHsajic+6PMYFWV9jp+WNQAPP8TvtUM3NUEttBJp+MdqUXAuEZL7t9eIYTpghXEgcza3YPFIu6SQaHqgPvyKbWm4b5/HdnJnNlyFrFlWIeW2jv2suBeVXMUkT/w2egRur1Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(6666004)(6506007)(41300700001)(7406005)(7416002)(2906002)(31686004)(86362001)(478600001)(31696002)(36756003)(6486002)(26005)(6512007)(316002)(54906003)(6916009)(38100700002)(186003)(2616005)(8936002)(4326008)(83380400001)(66476007)(66946007)(8676002)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0NDMXppQWhzSDdGeUtoL2dmK3ljZmhPNklVS1NSNTR5Nk5aSlFlWkh3b1dN?=
 =?utf-8?B?clRSeG11LzlhUTM3TDF1Zkx6MFVIODlvZ0thSzZwRHlnb1U1RWMxbjNjc3ZV?=
 =?utf-8?B?N3A2RzVtUVM3V2xKL0FXVnRkb1RDLzh4QzlZWHUycnpxb1luYkNMUUc3ZzdB?=
 =?utf-8?B?MUw2czBOazdBbW9IZWlac2tyUkdhaVczYi9rVW1obWtJRlJMWjd4ZG9sMU5n?=
 =?utf-8?B?NDZ3VjJkaWJjc0lHekNLVjBXMDlFT0VnTmtBaW5pMmJIY3IxQW5LcytNN0xQ?=
 =?utf-8?B?WHBRSU5Fb1QwbW1FTUIxYjRITTZsTUo2TDFmYzB0RFhVcUZPVVpsYnc0M0Fw?=
 =?utf-8?B?d1Vkdlo1eWVhZVo0VmFMNjFRSDJTTmhpSE9HRlZaeVFLL3FIYlA0bDNBa1lZ?=
 =?utf-8?B?a2ZPUVV3UXN2U1IrYzM4bm1oTkptSTRzMXRIQjMvQW53cnQzTkExWEN2MWpJ?=
 =?utf-8?B?MFdldVJzVklpalZWNElGYUxyMmVtTkt1c2wwUm54U0F2a2JDMXBLOGU5R2lP?=
 =?utf-8?B?bFpyb0FRVUc2TjVLRU81bHRUcG1KZi9sZ1NEQ3pwMXR3Y2RSNTV2NW81Z2hN?=
 =?utf-8?B?Z1FoYk9YeStjek9lbnVGS2dTTkFQQmtXaFNLc0FmSkd3YkU3MnljZ0ZnUmx0?=
 =?utf-8?B?RW5ZamkxSTgrMlE5emJkZzFDY1BLS05wbDZGS2VFbFpBTllWTkVVVVY5VldR?=
 =?utf-8?B?bHY0ODNTd2NUNTlkeGdMcTVySi8xOHFhMGVCS0J3V09kMElOSFo2cmxaQUNK?=
 =?utf-8?B?M2JTU1JmWFI4bXk3eTUzNnRUQWlrYkpaTVdKdXNxSS83ekV6ZStBTUhBWEVP?=
 =?utf-8?B?UVhmc09SZ1poNFZFcU4yaFoxcFZ4OFJHSWcvSW4rRkljT0p5bzJRenJQeHlD?=
 =?utf-8?B?TUlFNEJmM01VcENhZndZdS9vL1BjT3ZoYmh0WlZwcHpDTmFrTWx0WWI5UHd6?=
 =?utf-8?B?NWJpV2V6VW5IN0plWDNXQXU2NFdqdkRtQUR4R1lqODAveUFOK3pvN3JKNkhY?=
 =?utf-8?B?MkhLN3pTTDVZcmkzTTVSQUp2MHF2SzE5c2t0TEVaM3pLV2JIMjBKSXFieWZu?=
 =?utf-8?B?S2cwN3p1dituYzZjbEVlNmw0T2UrVGU3dHpJc2lRVmhNMG5kcTRMVDlxUnh4?=
 =?utf-8?B?bno3VGZEQzM2czV6VE9xY1E2MWN2VkllSTc4Ni9kZmxpSElNQ2c0UlJWN01w?=
 =?utf-8?B?TDVIVTd4KzgwNkNSWnBvZndINm1LbGdubHVaQmdvUU5hRjR5M1hYU1ZCdXZU?=
 =?utf-8?B?b0ZyRTVpcVNmQlVGQ1BqV05nN1phOTR2bUFxOVpWVnRLWXU3UFFteVkxSFBK?=
 =?utf-8?B?L3ZJUjRlcU1GQmRYUFdXRDkzVkxzcStUQ2FjSWJGaGIwNXBQS2lja3ZCenZP?=
 =?utf-8?B?UWhhR1hnaXEyUTRMYVEzMVRzNUJ2MHgrVnk0dHl1UHN3Qk5BZTRIVGJqQjQ1?=
 =?utf-8?B?UFowd0laUkkrT0cwQTlYeDRIRG1zaG9JQzFOZkJEM1l2WXR3U1N3Ukt4UlN0?=
 =?utf-8?B?cVhqdDR6eWd1QzBMUldFTTFzbXEzaVFXUXUzNEJ5U2xJcDZ2ZVVFM245MW9U?=
 =?utf-8?B?L0ZGWW82Q09nUXFNTWtMb3orRlJOOCtwTGtiSmZXeGFmbktyOXppQldxNjFQ?=
 =?utf-8?B?UG9VRGpMc2s2eTl3VHdKVm0zZXpzSU5IYkdyejY0bisrOHU2eG9jc1JuSUxp?=
 =?utf-8?B?K2ZnaFRPWEI1dEtvcDlXS1ZZMGozeGUwZFVBQmc1aUVvQmNKUVBmWUZaK1lu?=
 =?utf-8?B?ditrR2JZNUVrb1hoMzVIbDRjZjhKOGs3REhxVU9mcTd4eDhueENUSndFSmYx?=
 =?utf-8?B?aTgvUEVNNWtONE90ZUpnNXdaamhwTDZ0b2V4b3dxZytmeFZIUFIrTGpDMmRu?=
 =?utf-8?B?N1FaMGZuRTQxRVdzL095Vkw1MUhZOGw1SkQ5YzNDTTN4Wm5saGNOT2g0aUJl?=
 =?utf-8?B?WSsrUG1VeEQ3WDRHUWozdGw1eWdlaGZxcFcyaW9aRnROc1hwQ0xLdDZSZExP?=
 =?utf-8?B?a3d3T2ErbmEwSVBobG1VWTBsWjVPTUZzNXh6Sm0veFIzL0lpREpGRnNmcXdy?=
 =?utf-8?B?UXQrQ2ZFY2tjMUZSNWg4Nk9TYUxBQXM5TjFBb3VwWVZkN0xkVmkxdTBXclQr?=
 =?utf-8?Q?IyVw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53222aa4-5744-432a-a4f4-08da852ebfcf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 17:41:46.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZNQzL12tynfrANDazWzmHWYLhO0oBQoDEFEbfruoXOHIQC1XSCHJatp4O9ykqOnkVCiSZJ4kkhBr9szJ77nyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>> Actually the current version allows you to delay the allocation to a
>>>>> later time (e.g. page fault time) if you don't call fallocate() on the
>>>>> private fd. fallocate() is necessary in previous versions because we
>>>>> treat the existense in the fd as 'private' but in this version we track
>>>>> private/shared info in KVM so we don't rely on that fact from memory
>>>>> backstores.
>>>>
>>>> Does this also mean reservation of guest physical memory with secure
>>>> processor (both for SEV-SNP & TDX) will also happen at page fault time?
>>>>
>>>> Do we plan to keep it this way?
>>>
>>> If you are talking about accepting memory by the guest, it is initiated by
>>> the guest and has nothing to do with page fault time vs fallocate()
>>> allocation of host memory. I mean acceptance happens after host memory
>>> allocation but they are not in lockstep, acceptance can happen much later.
>>
>> No, I meant reserving guest physical memory range from hypervisor e.g with
>> RMPUpdate for SEV-SNP or equivalent at TDX side (PAMTs?).
> 
> As proposed, RMP/PAMT updates will occur in the fault path, i.e. there is no way
> for userspace to pre-map guest memory.
> 
> I think the best approach is to turn KVM_TDX_INIT_MEM_REGION into a generic
> vCPU-scoped ioctl() that allows userspace to pre-map guest memory.  Supporting
> initializing guest private memory with a source page can be implemented via a
> flag.  That also gives KVM line of sight to in-place "conversion", e.g. another
> flag could be added to say that the dest is also the source.

Questions to clarify *my* understanding here:

- Do you suggest to use KVM_TDX_INIT_MEM_REGION into a generic ioctl to
   pre-map guest private memory in addition to initialize the payload
   (in-place encryption or just copy page to guest private memory)?

- Want to clarify "pre-map": Are you suggesting to use the ioctl
   to avoid the RMP/PAMT registration at guest page fault time? instead
   pre-map guest private memory i.e to allocate and do RMP/PAMT
   registration before running the actual guest vCPU's?

Thanks,
Pankaj

> 
> The TDX and SNP restrictions would then become addition restrictions on when
> initializing with a source is allowed (and VMs that don't have guest private
> memory wouldn't allow the flag at all).
> 

