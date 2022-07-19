Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5395E5794C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiGSIAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSIAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:00:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6B27B25;
        Tue, 19 Jul 2022 01:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgOozxxAw5mslatr5tmJBSS+JCDy+eidQzWhCvZ9C7vnJG4KtxRMHpSMkbUSdTBLCW6oBYFlxNvdDCJrH0htUOZ8tHJPXPVDbwFbzUf3Qlp1cqZWZDLyyfDpSCMp5nBnjjUCpKIkWuY4Xy8PriMrzWc40GnqlVNqrOO2hPVYesvbBKN35sPNHNTkB08Y4WuS30T0eWxqkjWXbdLeKKxKpOM0WTECDiLt7BpkbQty409KVh3mJKPr3cyqrONTbYmcf4EvXEc/65qUl7q/tmeUjOGOIyycHEwyocmhSAgE+5e/LFwn3cOOZyGYSXCL+JlcEuyJF1YLSbIjN+nUdiB3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vYeZfmapjLmdLlPWqNiAG6ATVbljuFfKnaemzl87AU=;
 b=dzpVvKvBIIYMUo/utbvuVYeM2fNV9PMUCrbEfI/FGwX50DoWapqXvUu5VFUGSgOjoEDs2D5radA9gMcJw4wCXO49GRdlkdETdd6xFVcevRQGJCElr1Z6SpaeJvsnJzum+OyCWslWR33dxpEVToJoDSwzQdkFe04NxOm5TFSABEa0DF1hawdOV3kr/rVs/tsFAFLzSooVK/slQolXn+IAintzekk1wTs4VYxy8SZjRmZDBotwK1ad8OIsB6PNt8CNpPHSHqa+x4E5Bv10939NWTu7RTa7omMk5AvBrAkeO9tnb5V/vJ7iitLysn5jiCvn8dD8EYjSo+73nMWhp3Q6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vYeZfmapjLmdLlPWqNiAG6ATVbljuFfKnaemzl87AU=;
 b=u3K9Y8nT8fEblBexNa0+c1rDPxLkvplr5XthBD6/Iz5M1LW0O2gZ3EjXTROM2mXxmhx5GaC024hGXZ0Pvgc+uB6ioThe04XfwdZ3TXXDCDhHtfWKTXfBXjQLpyTBGgxQwVh+4Roi7romomX+EVHI94I1lEADr+2b+ptMl4RjhmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by DM6PR12MB4531.namprd12.prod.outlook.com
 (2603:10b6:5:2a4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 08:00:28 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5438.023; Tue, 19 Jul
 2022 08:00:26 +0000
Message-ID: <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
Date:   Tue, 19 Jul 2022 10:00:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2a7699c-58a0-4b6a-9481-08da695cbd06
X-MS-TrafficTypeDiagnostic: DM6PR12MB4531:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4uh20U9nrxQejvAS1Z+Vxa8vRSD0xCCyLhF11MhBTPsD0sYpxFt/QJCSA3o/xGer13z2Qe1fFDX5iIecrpQj7xqRK+8HyqZmX4XcDw2WXQVRYfOblnxvXiKUWWhxvJyjn4gFcIYEdNAxFUvmm7v7FxQJnk7Q6yXu3eovvnEWbf6g2pYugk8wfz6WPiH/NvWZBxqg5O/Q8gBoXp34f3sMwTZ/SQLIjNf5X7wLWd2E8eMcA/F2ABX4aedjo6Vx6fJct5HwtO52f8gaVjpfReJrSM7skHNnDC1Pa1bPp3AUH3x36JpPNOSSsDQJxly6OEZUD1P2hak6kOXqkA/gKJrlHBagLl3yT8T7b9lkXQZtYezI/0IanflQIUY62yGyhNBaBueKLOCGkFIDaCvnoPXcS+t/mRJRYxcfAnxO4J9Sn2KXV/a3FsIPindIqtC9PQJWKpMeCXaPmpgHqaVhkBpb8FrrVdf2OesLAZFq0enH2w2iFFDkDQHZ48fOJeZX9b6gsOQKjgIDLumN6PK/mEGtkN4UlqVnR3S0smplHU0Iev7fnsHVOCXFiQic0Iy+CPYR9XXQ5PiR2ZT/7dFoVkMkIeky81ddIDIy3pFI3u6CUMDWSzWpe2siWO+xFd7ZxX8yKcR2O9YxrCQVEddp+ILjhHvCqCNV1bPjZwuqYeFBioCbBxXs/godh72+bCwHPP/VNoNes4wvsJ6OwWjvNOIWAX2nFhI7AtQO0WYK1n10TBjwrEr+r0UxPKroC1zoYoH00aZ98iHWaMQZXVjDVmJXKXLrGo3FKLInszGiyyiGS4PQTGwSswDnUv8dWcIg0vq1uAB8YLHAltrmsDCMIxXrkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(83380400001)(6512007)(2906002)(6666004)(41300700001)(5660300002)(86362001)(6506007)(186003)(66476007)(6486002)(7406005)(2616005)(7416002)(31696002)(478600001)(8936002)(54906003)(316002)(38100700002)(66556008)(4326008)(31686004)(36756003)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T25od0I4V0pNNnhGempLSWFaUTZabGxFZVJDd01adWFFdHlmNlRWUFlaVEJs?=
 =?utf-8?B?L1N1aU9qbjIzdkVGeFlZMCtZandEb2NyQnUvQk9mMk1SaWR5WXFtZ2xaN2JP?=
 =?utf-8?B?cnR4QWVTWENBazhFTnRIa20rdmM5S2VMUUIxZ1pJcjZOV2Vhd3JUdHd2Zm9v?=
 =?utf-8?B?cFlsRnlWZmhKeit1UnNVZjVuMVVPc1ZOUFVjdzh1K0FDQkkxbWZUREVmRVVL?=
 =?utf-8?B?UElHTlplem4veVpYMUN3RDZKem5tVE1iTHUyRWtiM1pWa2JrK3NHK2hhRk1x?=
 =?utf-8?B?TG5IaHE3YVpUeHluTzlFMklUbG9jeUJueUZESzc3WmlmMUFhUmVpc0VGSzBL?=
 =?utf-8?B?R0huc1kxTitWaHlaN2tzT3dhdno2NFU3SkxLN0tUVVN3VU13cDd6SGRVTHR3?=
 =?utf-8?B?dW9XUVlucEpMcnlpV2pRSkZNSU1mMElMRlF2RDNkeGgrU0hlWXplL3UxZU9J?=
 =?utf-8?B?ZjNqRXJ6Zko5MElpNWR3WFo1STJZZ3luNG9SMzQxYzl1T1dyODNwQUlEWTE0?=
 =?utf-8?B?YzlwOWNvdkhGL2FjT2FkYXBoSTJlc3NjTDhEdkUrS0VZMkdmYVpsQ2t0OXZo?=
 =?utf-8?B?bkNmNHdKZjQwV29Eb01rY0lXL3hsNEFJOU5EZVhCdEs3anNMODlLL2o0S0Rk?=
 =?utf-8?B?bm5LTGlCRkRQejNsK0F0aVJoMUNEVEtZcTNuaFZlUVhjTTZuRThucXkxUVl2?=
 =?utf-8?B?M0ZZYnFkeXJoZjc1Z0xvVUQzVFYwOTcxN3ZoTDQ3ZWdocTNVcTk5SzNyMW9y?=
 =?utf-8?B?d3ZKVlp0TVNuR1M5QlJMb0RZTCtOVnlseDlUUmtZeTdNd0FMa2x5Qnh4NzY1?=
 =?utf-8?B?cmtXVWV0RDZjVkRKbVpScGw2bmN0QXB4ekUyZ1dSM2U0U0Z5VVJtSWJ5Z0Vm?=
 =?utf-8?B?aHBZY0p3RTB5MnFpNWoyMTNUaVVZQTRnblRwYXQ5ZWlJeVJXdXJEYkJPQ1Zn?=
 =?utf-8?B?ZkFVMDJhWlhDV1Y1QW9uNUFQMXlFMGI5U3c1M0RZQ2ZJOUVBODJuc3lOSyt2?=
 =?utf-8?B?d0dhM2lZWkJQV0hWZ1k3aUNDQ2JiNHdzenUrVHU0NndsaUQ0RmtvcGhuNm83?=
 =?utf-8?B?eHV6SDQ4V2xFcFltc01BYVJBc3VBcitpVjlRRXVETVdiUXNnT2pGUFlmaUdk?=
 =?utf-8?B?L01PZ2VCT3hwU1FKL2c5Y1ZObzQyOFNWQklESkNpU2dzNEMrTXpaclhNWmt4?=
 =?utf-8?B?ZGQ5d2QxTU9TbFVhc1hncnJjOWhzalNtVTZiUTBZSFp6L0F3RUZaR2hadkdi?=
 =?utf-8?B?aXBib1RtSzl1T1pucllQdTBSQ1d5UlVBZ2FwWnFLelV1RFI5MGU0ZG1aNFlr?=
 =?utf-8?B?QzIwTExPVHNnWjNLSzYzOWRCNzJTL0dXbmtlUkhtbzZTcy82R3prV05zc0ZO?=
 =?utf-8?B?YmNOaFd4dzNYaUNxbDFkWDY0M2FGMHUya1I2d1J6VFBwUEZNczBmaGh6UDgz?=
 =?utf-8?B?SjZCWlp5aWtLR2kxYzN5QlJRM0xCOHNtMVN3UGFTNnNkRkNsY3BaR2s5L080?=
 =?utf-8?B?Zm9ndldyM0laT01DcnZWSVhvaEhmQmVCT2o5Wld1Z1ZXK0w1SmpuQnJWMkF3?=
 =?utf-8?B?eURKRzNpY0JFQTZTRDZLT01rMExnekt2TUVwNkx0WERkWjg3OG9sT3JmVWR0?=
 =?utf-8?B?KzNrMzZCUUlTaEEzSUpDYlRqTTdoQ0p0QlZlcnNiM25adnIrSWlBeXJrSHJn?=
 =?utf-8?B?ZHFBMVJjWkEwSCt1cjBpV3dlZk5PaHhKVVl4dG1NNTl5eFJSZVZmOExJZVdw?=
 =?utf-8?B?cS94U2NhRTR1M05ZY3RRZmZHU00xM3o5alF6ajVTL0pxanFVajBaTk9CTk5q?=
 =?utf-8?B?SlJMcjRBWGpvUjVhRzJPa1crOGNabTl3aG9qY0RDWmJTZjBXTXVEVkZCVlFH?=
 =?utf-8?B?NGtYNGFmUUtxYXhHcm9KeWJVTnZ6bmRVSzBJVXo5WGpCVlk2czYwT2VhMnV2?=
 =?utf-8?B?cHQweXNFRFUrTGRSaFZWdnZqa1RXRDE5VWpjVHZKRUdEWGRCcDRwUzBreE8z?=
 =?utf-8?B?OWtqc1Mvdnl3WTVIN1FKcnBJQ2xMenE3R2d4ZEJyUjVoUlpnSHRtU0ZMSU5s?=
 =?utf-8?B?MkJaK0RrbTZyRnpEQ3pxNEorMGJ5dG93VU92QnNneTRDdTFGSlRPSWNLcW5B?=
 =?utf-8?B?STdNSGxoOWtIWmZKNUx4YkFzWlZiTkNaOXB2WWdoOTV5UmVyaCtrSlFVQ3BM?=
 =?utf-8?Q?7I84xZnw5TD6Ty/3irCVdkU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a7699c-58a0-4b6a-9481-08da695cbd06
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 08:00:26.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPQ1sDIuH8eLLbIONGnIGYA2dKfsZejM+j6FuUzWpHVsAaVD0KGoWan93qeUzqEZSBIODjOZMgIToe3BqMeXZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4531
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chao,

Some comments below:

> If CONFIG_HAVE_KVM_PRIVATE_MEM=y, userspace can register/unregister the
> guest private memory regions through KVM_MEMORY_ENCRYPT_{UN,}REG_REGION
> ioctls. The patch reuses existing SEV ioctl but differs that the
> address in the region for private memory is gpa while SEV case it's hva.
> 
> The private memory region is stored as xarray in KVM for memory
> efficiency in normal usages and zapping existing memory mappings is also
> a side effect of these two ioctls.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>   Documentation/virt/kvm/api.rst  | 17 +++++++---
>   arch/x86/include/asm/kvm_host.h |  1 +
>   arch/x86/kvm/Kconfig            |  1 +
>   arch/x86/kvm/mmu.h              |  2 --
>   include/linux/kvm_host.h        |  8 +++++
>   virt/kvm/kvm_main.c             | 57 +++++++++++++++++++++++++++++++++
>   6 files changed, 80 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 5ecfc7fbe0ee..dfb4caecab73 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -4715,10 +4715,19 @@ Documentation/virt/kvm/amd-memory-encryption.rst.
>   This ioctl can be used to register a guest memory region which may
>   contain encrypted data (e.g. guest RAM, SMRAM etc).
>   
> -It is used in the SEV-enabled guest. When encryption is enabled, a guest
> -memory region may contain encrypted data. The SEV memory encryption
> -engine uses a tweak such that two identical plaintext pages, each at
> -different locations will have differing ciphertexts. So swapping or
> +Currently this ioctl supports registering memory regions for two usages:
> +private memory and SEV-encrypted memory.
> +
> +When private memory is enabled, this ioctl is used to register guest private
> +memory region and the addr/size of kvm_enc_region represents guest physical
> +address (GPA). In this usage, this ioctl zaps the existing guest memory
> +mappings in KVM that fallen into the region.
> +
> +When SEV-encrypted memory is enabled, this ioctl is used to register guest
> +memory region which may contain encrypted data for a SEV-enabled guest. The
> +addr/size of kvm_enc_region represents userspace address (HVA). The SEV
> +memory encryption engine uses a tweak such that two identical plaintext pages,
> +each at different locations will have differing ciphertexts. So swapping or
>   moving ciphertext of those pages will not result in plaintext being
>   swapped. So relocating (or migrating) physical backing pages for the SEV
>   guest will require some additional steps.
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index dae190e19fce..92120e3a224e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -37,6 +37,7 @@
>   #include <asm/hyperv-tlfs.h>
>   
>   #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
> +#define __KVM_HAVE_ZAP_GFN_RANGE
>   
>   #define KVM_MAX_VCPUS 1024
>   
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 1f160801e2a7..05861b9656a4 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -50,6 +50,7 @@ config KVM
>   	select HAVE_KVM_PM_NOTIFIER if PM
>   	select HAVE_KVM_PRIVATE_MEM if X86_64
>   	select MEMFILE_NOTIFIER if HAVE_KVM_PRIVATE_MEM
> +	select XARRAY_MULTI if HAVE_KVM_PRIVATE_MEM
>   	help
>   	  Support hosting fully virtualized guest machines using hardware
>   	  virtualization extensions.  You will need a fairly recent
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index a99acec925eb..428cd2e88cbd 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -209,8 +209,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>   	return -(u32)fault & errcode;
>   }
>   
> -void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> -
>   int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
>   
>   int kvm_mmu_post_init_vm(struct kvm *kvm);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 1b203c8aa696..da33f8828456 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -260,6 +260,10 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
>   bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
>   #endif
>   
> +#ifdef __KVM_HAVE_ZAP_GFN_RANGE
> +void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> +#endif
> +
>   enum {
>   	OUTSIDE_GUEST_MODE,
>   	IN_GUEST_MODE,
> @@ -795,6 +799,9 @@ struct kvm {
>   	struct notifier_block pm_notifier;
>   #endif
>   	char stats_id[KVM_STATS_NAME_SIZE];
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +	struct xarray mem_attr_array;
> +#endif
>   };
>   
>   #define kvm_err(fmt, ...) \
> @@ -1459,6 +1466,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
>   int kvm_arch_post_init_vm(struct kvm *kvm);
>   void kvm_arch_pre_destroy_vm(struct kvm *kvm);
>   int kvm_arch_create_vm_debugfs(struct kvm *kvm);
> +bool kvm_arch_private_mem_supported(struct kvm *kvm);
>   
>   #ifndef __KVM_HAVE_ARCH_VM_ALLOC
>   /*
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 230c8ff9659c..bb714c2a4b06 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -914,6 +914,35 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>   
>   #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>   
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +#define KVM_MEM_ATTR_PRIVATE	0x0001
> +static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl,
> +					     struct kvm_enc_region *region)
> +{
> +	unsigned long start, end;
> +	void *entry;
> +	int r;
> +
> +	if (region->size == 0 || region->addr + region->size < region->addr)
> +		return -EINVAL;
> +	if (region->addr & (PAGE_SIZE - 1) || region->size & (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	start = region->addr >> PAGE_SHIFT;
> +	end = (region->addr + region->size - 1) >> PAGE_SHIFT;
> +
> +	entry = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION ?
> +				xa_mk_value(KVM_MEM_ATTR_PRIVATE) : NULL;
> +
> +	r = xa_err(xa_store_range(&kvm->mem_attr_array, start, end,
> +					entry, GFP_KERNEL_ACCOUNT));
> +
> +	kvm_zap_gfn_range(kvm, start, end + 1);
> +
> +	return r;
> +}
> +#endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
> +
>   #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>   static int kvm_pm_notifier_call(struct notifier_block *bl,
>   				unsigned long state,
> @@ -1138,6 +1167,9 @@ static struct kvm *kvm_create_vm(unsigned long type)
>   	spin_lock_init(&kvm->mn_invalidate_lock);
>   	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>   	xa_init(&kvm->vcpu_array);
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +	xa_init(&kvm->mem_attr_array);
> +#endif
>   
>   	INIT_LIST_HEAD(&kvm->gpc_list);
>   	spin_lock_init(&kvm->gpc_lock);
> @@ -1305,6 +1337,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
>   		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>   		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>   	}
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +	xa_destroy(&kvm->mem_attr_array);
> +#endif
>   	cleanup_srcu_struct(&kvm->irq_srcu);
>   	cleanup_srcu_struct(&kvm->srcu);
>   	kvm_arch_free_vm(kvm);
> @@ -1508,6 +1543,11 @@ static void kvm_replace_memslot(struct kvm *kvm,
>   	}
>   }
>   
> +bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
> +{
> +	return false;
> +}

Does this function has to be overriden by SEV and TDX to support the 
private regions?

> +
>   static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
>   {
>   	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> @@ -4689,6 +4729,22 @@ static long kvm_vm_ioctl(struct file *filp,
>   		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
>   		break;
>   	}
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +	case KVM_MEMORY_ENCRYPT_REG_REGION:
> +	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
> +		struct kvm_enc_region region;
> +
> +		if (!kvm_arch_private_mem_supported(kvm))
> +			goto arch_vm_ioctl;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&region, argp, sizeof(region)))
> +			goto out;
> +
> +		r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);

this is to store private region metadata not only the encrypted region?

Also, seems same ioctl can be used to put other regions (e.g firmware, 
later maybe DAX backend etc) into private memory?

> +		break;
> +	}
> +#endif
>   	case KVM_GET_DIRTY_LOG: {
>   		struct kvm_dirty_log log;
>   
> @@ -4842,6 +4898,7 @@ static long kvm_vm_ioctl(struct file *filp,
>   		r = kvm_vm_ioctl_get_stats_fd(kvm);
>   		break;
>   	default:
> +arch_vm_ioctl:
>   		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
>   	}
>   out:

