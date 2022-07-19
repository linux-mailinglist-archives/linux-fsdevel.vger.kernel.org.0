Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCE857A1A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiGSOeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbiGSOdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:33:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D5955BC;
        Tue, 19 Jul 2022 07:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBTU1uh8BK6k7Le/YIEDtKouj0FJON4dNZNsCHv78alPsAIol75XExohctHcFqb1YdHbYSQCR0UV/8WU3YnaiNaH+BbEnTj4MFaAYyzTfPNHv7lMtv9exr9E4yqcJ3Qx6CPbAAQg6Im1e8P3DPXcz8lyiQMUAcZAs41514RQXIdsmCJUAZZEWp9v6nPjASZ3OMNTA9+bAh0d1I1jH6sPB2pbjtLJx8bZAAJHlhY37Cb96jYzWsVOX2z7/JQjtJ0IQ5KmyjYBz9YJhVGaTK2IrCztYdsjfop5II4ShfObidQDbSfH/7nI6XlFvjdWJwPQGchepO//8NhcI9hi2jLzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gbRxjyTfsNeCyxbMbIfPF0WYPFQW8U1LaRtDaQvFwY=;
 b=F2HfDKxUkxNelE2pSkYZl5qzjgJSMgduKrl+HmJkGYohBmi7sYv1C55tdhFQGvuEJCZy5wgvG6A2d3uRh3CVrpLGd4aaH40jmQwNNS4d44vi8ujPdcrg/S6hexF+6Mw5alyaVnAvBJ/w0opWmTDKbxifBW6IdOc5JMIDjhFuzlkBjgXkw6gvLzxv+9/pJN3CKzQEtPn//wybSrqRVzQnbTRC9lzclxmWgjqFxAArMOTSdGMmcIV+xI6MY9ewZOxEWverAZFrjf2Sq+OV+q1DLAQqoHkWWGc6IARg1Sy0ZbwyNDliTiVmFa1v9Q4zOtRidqd5YH7Y6b1MA9Z1kXGXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gbRxjyTfsNeCyxbMbIfPF0WYPFQW8U1LaRtDaQvFwY=;
 b=ysN1i3C9hz/0qPnMI88vP+EoMA8HqKkwvzTs2xbq5WXkJnvYGgAhcrgs7ciLoZTDslDilAse+XwG52vsBUpesxXpi7oZ7m4cxXemPMMIqM1JQMrhz7/ppY7iqKrlxSfPwxT2McQzYF+YG30uLSPEGQ0sAKn4JVCvGWSazYI+JoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by SJ1PR12MB6241.namprd12.prod.outlook.com
 (2603:10b6:a03:458::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 14:24:10 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5438.023; Tue, 19 Jul
 2022 14:24:10 +0000
Message-ID: <36e671d2-6b95-8e4f-c2ac-fee4b2670c6e@amd.com>
Date:   Tue, 19 Jul 2022 16:23:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
 <20220719140843.GA84779@chaop.bj.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220719140843.GA84779@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a97040-e76e-4e96-e5f2-08da69925885
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6241:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAM1X9spBJlKwV2ShK3OwFXQS1y8MnAB0v3g4kFFNZYN5/zVon7TIfy69d42gkz5xxWadsBBV18Bk3jG6EiS0/3Yg5Idya37ACe+ljw020EY4YdJWyIraJ3fkEzALzhJ304wKYC0VIaId1HIiae+w0yQIxkjZUBzh+4ZpwLbl0t2/mpXcfAUtX3brbBJ3ORckVnX5hvbF1aCffSocJFlow66eDySpvYwF0qD0R4cNRxR4/h/42NwvMU0CjRBC1nMwjqLA0o+tf0OmNe1LHE1yRrDJLJmUvaDLczcKqYBN2FPd3fRqAQHOiGImbe5VuV8sQ6vbV46F5LJk2K6nAZIoyiXPHhyKh0mtPBAYodumNEwwmz9REbouYANoedQ/e1vJkheYISXOpqHk2yfrz3ja/4uW3Qpe9kodlK9faabZjJWeNm0g7VXIONnMP8AZP6ztssCH3+I9aOedYIgrzqfQolYgxWdzVE9/+ls6VLdqY26W9n+dWYtaKmdZOLJCwS1jFhDw3kyuk+5JqzTS70f6+eweKZnn7nPl5YJR+3iknhLntVrgXyBRuS7+JkKk+xkl0ttOR5J8qpZenL7sX3s7yH8jl+BSmk/HINgWvBuQMooIB34RFogbPPYoDQyPfxziGh5DCPz3GoX7c0Xr1vyBxHOgqwS0iY1109ziEYiifud3KdKBLq0gGNdKsDnTKUMuUgkS0zzaFOuYDxCI6hTep7Z++JZM/rHqh6OuKitdAoxWo1aakOevlk4aNPg5cUn683wEp1BFdsYk1jHRFr+BDYhyF8wi8gfY9Coxa4go8VHEzoW8SZ+W7k0xcFJDxsp3cToy/U2wo+LXL3HYCoIMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(26005)(2906002)(31686004)(6512007)(6666004)(186003)(41300700001)(86362001)(478600001)(6506007)(5660300002)(7416002)(8936002)(7406005)(2616005)(31696002)(6486002)(66946007)(54906003)(6916009)(316002)(38100700002)(4326008)(66476007)(66556008)(36756003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk5kN0ZUTVFxcG5KZUlqcGtRQUJHcmFseGs3Y0hxNml0WlROdHhML2NpalVZ?=
 =?utf-8?B?STYrbUtPUWZSbFpEakFPb3VobWw3WDVMdkdVYjZhc2Y5OUVBZzRsdTVRQzBU?=
 =?utf-8?B?TEFzalBZNU9ZM2JmYTZrRE9pd3o2UStrYk5SRjNHQnpLZXVJaFRQWS9CT3U0?=
 =?utf-8?B?cGlIcjBpYnZudGYwTzJ4U3hEeWt4Q2Q3ei9zVUJtU1dDM3FrQkxGYzRtN05I?=
 =?utf-8?B?QXFjbmQ3a3ArOHlYazN4SFRyQnBjdmU2QWdQYUNsaGlZV1JmT2JHL2FQQXc1?=
 =?utf-8?B?L3JKU2ZUdDBpVDVVY3dGSnRVTWFvSlY0bGVGN2x2TXdqUlBaMTBrQldKODZO?=
 =?utf-8?B?RXdhRXlCOUU5MkhvSjhWbk9QekZhTVYvTnREZUUrNnc0TUMyVTNoOHU3U3ZG?=
 =?utf-8?B?NjNHbE1hQnJRV1BYdis5RTF5U2lwQTg3ZDNDWXl0eUlpRmJnWGwxZWRMU3pi?=
 =?utf-8?B?azhLWXJiUnZIWk9wR2thOXlkMHlWdVI0aWVwUG93YVdoUC9vT1ZCMjQxbVBC?=
 =?utf-8?B?NlBRWXVmR2tDMFJXckhmUXJ6dnJZVXc3dENQVWQyOE9jUUx5MlBadms2ZGFU?=
 =?utf-8?B?NHhoOVBJeHpDencrWFVHLzZNL200VkJ4YlVOM29rc1IrR1dUWGJYSGNhSEV0?=
 =?utf-8?B?YmNKa1FxQU5VRG1ZdnVnUkdoSU5DZGU4aG9FY3BOcEx1ZGdSMDhKRk1RKzIr?=
 =?utf-8?B?a1ZDMTVQT0pJcU9ISGJqOXZXTDZzSTBlUm9KOUV6d2VhQU1MZ3pOeVpaemVJ?=
 =?utf-8?B?cHhDZnM1Z2FoY0ZkUG40NUxUdkNGYU1welBnMHAvMFhHNk9MQmV6a3JveFda?=
 =?utf-8?B?TG96K0cxM3JoSmVUTWJzS2EzU016ZHNFalRwV1pRTVNrRlNTVytGNlVmcTZs?=
 =?utf-8?B?WjRtNm9mSzNsbFA1N1FMK3h3b1lBejM3VUpsMzFnV0svUmZvS2JtR0p0RjFh?=
 =?utf-8?B?dWYvMnhzbVJWc2ZMRDhkNmRZOVlFV2w2Q2Y0WG1pV2k2QnMrMUUvOHYrVzNI?=
 =?utf-8?B?RGtsYlI2SzlQWHRqQ1BzWXBsbFZPNGZ3ejltZkgrNmxJNHcrcUpqSG9yZEov?=
 =?utf-8?B?YkRhMlJFaktsMVFjd0dzZzhQeitGWVR2bU1SUCsvNVVwdFhHckFoaHF6SGxr?=
 =?utf-8?B?Q3laTGFMUng0WWRRN3ZDSVVFbDM4UkF6ODVHVDR1UHFuQVM1T2tFQng5dXp0?=
 =?utf-8?B?L2J1SVpYTmRTRGlabjNkbWtJSWN2TFY0TTY1eURaajVBY2VkQzRPc0I2R3VW?=
 =?utf-8?B?MnZyMkovMUZYak9yRExDL0dFVElDQWE4Z0VhMXBFTmdMZzU1MFphdGp1QkRL?=
 =?utf-8?B?WUpGakhYNURhSWJnL21hbExIalUrRHVndjgzRmRWSk1wQjBqT0U2ZUJJRitP?=
 =?utf-8?B?QmVmV2JQVE1zTWxaUUpiMmFxUVErbkhoTk5pZVN4bVJEK0IySDJYbitMMmpY?=
 =?utf-8?B?WmFrMWZQY1BrNTJsampGZmV5RE9VRVdSbDV0U0t1WitFRHRJa2txUHlhc2pL?=
 =?utf-8?B?cll4NGRDQmdVNHBiTkYzaHp2bjcwcXYrKzVFa0l2b0E4UGxNU0pnSjVoZWpa?=
 =?utf-8?B?d28zUm9UajY0cW5FTExITEJkZUxMSy8vYW9DWFZOMGFyZ1FqdlY0YmtpTkV0?=
 =?utf-8?B?NVNvQXdiWWJzckRTV2ZGbTVPWklvL0h3ZUJVZjJrNnh5eHU1ZnA1NHdlWml3?=
 =?utf-8?B?UzNpZXdabWlpWlI2a0F0TnAvbEVLYm45RmowcjQ5UGhDOFcrMlcwM2k1STVY?=
 =?utf-8?B?TDBvWWJLVW42K0p2Nm9wTms4ZkQ3RTdwelMydEtHVUVKbDBma3ExclNpNStS?=
 =?utf-8?B?RUxZakx4S3F4NU1vc3NxczZxcHBNVjhPMEgwOWxOZVcxczR4ZGQxN3p3Y2ly?=
 =?utf-8?B?MUJZMjBqTjZMVExncldIclJ1V3JVemEyUkpJNzVOMUpiUlpvNXd1OUlPT3Jr?=
 =?utf-8?B?a3A4NGNkUzd6VXlJZjlVM255Yk5qM3JmUUpqU0puVGNvREJnSW1BdHRpRkxv?=
 =?utf-8?B?ZStmZHQrWDRPR1lMRERQU0lTUDg0MmxZYUQ4QW1UK0ZTTk5zcjIvNU85WUww?=
 =?utf-8?B?aUdEaVJ0S0ZZMXJWeHQ2VHRsY3lvU3ZWVTlvSkY3U0d4R0lmYWtDdFhMWjFj?=
 =?utf-8?Q?ZO04vLQ6IOC3nZuURa2s2Npoj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a97040-e76e-4e96-e5f2-08da69925885
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 14:24:10.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COYjKWM0CmMZwrGaP/VoN7FkYMKu/zqiLEHbzzhQYkcGfjwvVOJYeB44kjeIFzVbdgzCCqTTNkE4AsW6eNyr1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> +bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
>>> +{
>>> +	return false;
>>> +}
>>
>> Does this function has to be overriden by SEV and TDX to support the private
>> regions?
> 
> Yes it should be overridden by architectures which want to support it.

o.k
> 
>>
>>> +
>>>    static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
>>>    {
>>>    	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>>> @@ -4689,6 +4729,22 @@ static long kvm_vm_ioctl(struct file *filp,
>>>    		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
>>>    		break;
>>>    	}
>>> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
>>> +	case KVM_MEMORY_ENCRYPT_REG_REGION:
>>> +	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
>>> +		struct kvm_enc_region region;
>>> +
>>> +		if (!kvm_arch_private_mem_supported(kvm))
>>> +			goto arch_vm_ioctl;
>>> +
>>> +		r = -EFAULT;
>>> +		if (copy_from_user(&region, argp, sizeof(region)))
>>> +			goto out;
>>> +
>>> +		r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
>>
>> this is to store private region metadata not only the encrypted region?
> 
> Correct.

Sorry for not being clear, was suggesting name change of this function from:
"kvm_vm_ioctl_set_encrypted_region" to "kvm_vm_ioctl_set_private_region"

> 
>>
>> Also, seems same ioctl can be used to put other regions (e.g firmware, later
>> maybe DAX backend etc) into private memory?
> 
> Possibly. Depends on what exactly the semantics is. If just want to set
> those regions as private current code already support that.

Agree. Sure!


Thanks,
Pankaj
