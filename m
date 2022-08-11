Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8689158FA60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiHKKCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKKCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:02:38 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6AF90C5B;
        Thu, 11 Aug 2022 03:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoP5yaIRf0pdsc+wRlyva97TRkS7aTl6BtER1qwfHo7NbDdOUWM66TEMIyDUS+lBmzCsSGDXcYVhRkWNuDtCL/NYuA2rUmgegEq8Wtv5RdGtbR+VpYw0I5Azqr+/SAhbzea6qKwx2I1nL8cqaIMwmGk3OvwAdAdDQKjT8fhB+A4FgJcel6JopYMGrIfUc2+/H+wfAXYJv4NHwlnpBM5cZfsDArG/AFaBtdjNtfvjTIFJyiYcZjqQymHx1tgv8Kvq4pP1KzaAph5W61dh8lunVTgg9ZpO9SLHr+xrWJ1XZYTsjrapK+APrHLQO80t2ldp2i7QzeZEL6D8wc88sOvy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuwtq3Wpe/IXYCBtL8rZv9MnSzmQQt2Frd2aoxUjlek=;
 b=g7Qm9GRoPATpIxxQx+CcnZqMudMmg9zEPRt8fTw/xZOkOKPMCaKnzkBr+7UsJNEJWlX7ld/4Lx7dzR6nLy/Lcl0Qd2oVhaD5s1joDSHrp84yPI63gufEJzAu4BIkVLEdnbznujde75v61s/8f+vbs7nx5Wr6Jnx1U+GNpAQRFBtCPfjN/Ms2XbsDYGywjxB466GRR+udEZqtuuJUYB0+44XRYk+Jr5kYnyOB+J9GnJItwUOw6WjpoX/Ehm3jGQcaJ0ym73Iq2QkRTtftkQOudjKeeXvoFp1YdO82dOMMpDslpJrG1qbnDb4Q17oTbhD+YjsLZ8nRZeE/VhiyBVxm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nuwtq3Wpe/IXYCBtL8rZv9MnSzmQQt2Frd2aoxUjlek=;
 b=caxUCu2ZLeFyMdJJDINlCaXBSNZ1cNiRP4nkqyaZBQItcqEF7rbIWcerCJ/yAxJ8Z3watplBxiLRNel7m/h8UW5K/xSccZRpFMIfoMKxD0Bc9HjCna2Du4QT2ErMJB3K8jbwSRabBwWlYwDl3iHLVTlf3SwNKWhrJmHwSB5/BLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BN6PR12MB1425.namprd12.prod.outlook.com (2603:10b6:404:1f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Thu, 11 Aug 2022 10:02:33 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da%9]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 10:02:33 +0000
Message-ID: <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
Date:   Thu, 11 Aug 2022 15:32:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
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
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::9) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51000e01-ef96-48e1-f62d-08da7b809c33
X-MS-TrafficTypeDiagnostic: BN6PR12MB1425:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0F4L6a0IJCoobPF7YMyO0tic0EPNUsQdeBFOlHde+WSa3LF/wFRezNhAO0X/FoS+ENPW0ZMHppx4QYA2ajjt54QyUtfcXCeM5rWt1NVO87QQejQD3OPrK56GBBmMW8xvi4WvrlQN0ftALOXXa1etnkR3cHi+zntVLtKR7m0MBTYHlFAgw+4zOc0ywQ+rXgRZss5k2Y13DeORpiMBucPdstrNxK/ufCt4RxzMUx2Ninqpeh/hf+ZW7HnG7FSqvZ0NpulbGqBau9l4lSI6yH/4iSSURiDpYQXD0RSvprOwdB5rEI4od9qy0s6o3a5yp5NpwTht4zHvOmwSh4v9+Nt2Z6cVT9LF49QvsNoh4ORzRGVaUmi7qgwK619utQBWSbGl34wF8AjS6FLA5YVANsY73Xq+P4yP7dIFaPEjqwHs2SZ/n2UQdFW420kgnhPdniESfgBtH/f71aqTZjaT7wJeqPKkN3fhiM4sWlZRQovZgrnbu/X3v6g8vAwi7QbvOu3WKuFvRcuS6P+yocGJRBFiL1GsAHihF50WRNMYes/F5Ha0+unpp9986LpyDtf1Fv2oJoae/cBYJTbHlKkCDUnETJ8ikmrxFVON8qt4yqVYacGAiUUzBnnfZrDaVlkTsJ/a3OXm0scsxdYglb1GdD/4UXTjifg6chsdkAggfc8C6CIVGgS96mQuLYemI1chVF2zAaQqHHYMcYBOiQ9tEY1tmsth6lH2mePi1Gz8jMdLtTsr5RK9aG1xqEDCpxQBg0raKOJjRYtpajh9iNeudgZN9/QqnnSdWhu91H0isI5xf9ZOZAVhphKiakmMxt2pvkPNuuhOrLstvJB2jfPEK/AzeJfZCncGnHPtYBZshHOIV7og0D3MlJ1jmEVDfGzHTdCgqqhfGZ7KQUBdppOQyyB9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(186003)(83380400001)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(5660300002)(2906002)(6666004)(6506007)(8936002)(41300700001)(2616005)(53546011)(26005)(6512007)(110136005)(54906003)(7406005)(6486002)(36756003)(7416002)(478600001)(31696002)(966005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVAyM0Q0SXZDaXBLMzhwL0UreGQ5dk95TUdYd3hvejFNNnd0WEtJM1kxVS9K?=
 =?utf-8?B?QVRDSzQvd1Y3eVh1M245eFhZV1R3M2RNT2FaUkpqRUQrZU16WEdkTDA5M3hs?=
 =?utf-8?B?Z0FrVUJhTkpOTzkrMmFqSzJZSDd1S1FINkh3aUxDN20yUDgwTW9mU1lyY1R0?=
 =?utf-8?B?UkFabXovai8vR1hHaE5GWTVnS1M0UnloblYyUUUrUVJTaHA3TGdDbmRUNWk1?=
 =?utf-8?B?NFd6L3M1eUwwVjdTaXd6aVlvNGhBNUtjeFNVMGdyS0xWN21HNDBGaVc5OHhT?=
 =?utf-8?B?ZFk0dWovWDZXcmdlYVNwcm1lZ3FHSDBjcStPSkhnd0NtdmxCZnhYNjg3NEtX?=
 =?utf-8?B?bFNyRkVSU0VjeXRYVW9tRGpMQTY0bjFYWkEyQ21JOEgxbTR0STlOaFQ3MzRo?=
 =?utf-8?B?T2lraDhRMzIwaU9sclgxWWlWWkwxUUsyNDJmOHdUeGRPSzYrRWI4d21QZDd4?=
 =?utf-8?B?cmUrUTZnUWxTSXlqNmt6ak9HclVDZlZ5QVlZZVBZd3I4MTJxbm1zTEltRVF5?=
 =?utf-8?B?aTJ4bGR2NlRoYnp4aTd2WlZaWjJ2WWVWeWVqcnR6U0hHbU8wSW9rd2ZJcm1i?=
 =?utf-8?B?Q0d2Snc2UjlOdUEvQjcvYVBMN1JlVkRxUTU2bk5ZS1RjNXNSbEE0VHpFQUNU?=
 =?utf-8?B?T1Y5a1FRK0ptaUFMN3JYWHlGT2Q0TnZCdTlnTlFaS3RBcUtYNjhOSkMrYVA5?=
 =?utf-8?B?UVRWdmRYd2hWbmpIVlUvcnRacVlySmwrZysrczdaQ2tTNVRZMmxzNURaTUt5?=
 =?utf-8?B?YUI1ZXBSRDZiaXZRUEVIWHl1K3l0SFN3RWs3NzJ3YlJxMm9tYnlFVWZLTlZV?=
 =?utf-8?B?NGtoVDR6ZFBXZ0EzY0xKSnVjRDhKTkhEZnJUQk1FclVTS2tJbzU3Qk8zN2hV?=
 =?utf-8?B?dXdYTmc1VFpyWGN0S0lNOGtiVGk5Ry9BUjZUazIvZ0hmRlJXaU0wMGxMQW4r?=
 =?utf-8?B?UFkza3JXU1BtVjhVcXZPRzBoOEcwNE80dEZzRm4xVktCV0VHZ1A3SlBFeTU1?=
 =?utf-8?B?aWtpcGJCdXF2VzR0amZWM2pnYkhRTUVDWlVxQ05jUDJVUkgrME5ubmJOZUg3?=
 =?utf-8?B?bWZDTzU2UFZPbWVSYnV2OVVVbFFSR0NHMWo0azhJb3FUS3JJaW1sOHRDdngw?=
 =?utf-8?B?WGJxOGpiRTFKcExBUFBVMW11SnZHM0JUUGtScnhUZmVEZ0Juekw3c2RXQlo3?=
 =?utf-8?B?cEpuVytjTlMxcjdBTDk2MGtQOGhKaDV6aXliWmdRZGdXdnFOdEZzOUlFUmkw?=
 =?utf-8?B?MUpERlZVb1RuUDJCVUdPeXNFYTJZL3JRYW5JL3RhZDBNUzJyaWRoZUxTOTdp?=
 =?utf-8?B?QWpQUjVXYWJHTkQvdVlEVUN6RnFtN0VZWENwb2lEcTZqV0VZSEJhbWFFVjZv?=
 =?utf-8?B?bUhEcG1idHI0dytMSWlQTDZraUlhSkxCeVhCaDJhOXRxRHQ0V3JlaFI1U2hn?=
 =?utf-8?B?dFY4UFJoUGorWGpoUDRtekFVZUZObFpwKzlaK1hMclIyZEx3U01QcVRRSGxH?=
 =?utf-8?B?YW1OQjZmWk00eS9YUkl2ZzhBNVhNVE9uTXhNaHdPbEJMeE02TDRBVmhtMEhM?=
 =?utf-8?B?UzV0cjVlN1RIeThvUlpsbElHdnd4V29WTTlVc2Zldlh1cXgweU1OQlZtTXcx?=
 =?utf-8?B?ZFlYcWR6QmU2bGdmVE5meG9SekVtTllqRUt3cVJwZFVKbllJSVN0enVBK3I2?=
 =?utf-8?B?TWd2ZUhZeEh0OU5sekc5RjlEZWVDZnd1dDczVmVBc0pUNVM4THVLMSt5T2kx?=
 =?utf-8?B?ZlM3NERsdzdvZnBhZlY1VmNnUHBscnBiUC9MWG1nK1pLZ0grQzcrUU96dld3?=
 =?utf-8?B?aVhIYzIyRWRoOVpySlJ3SVg4L2UwMnJIZWdHNXBydk84cU5JK2JKVFBGY3F5?=
 =?utf-8?B?RTNmUHQ0b2puK2IrQWJabE5jc1k0UXdVa2docUs0dytyWEZxTERDb09LNmNE?=
 =?utf-8?B?NnhoVk1ndE9jU20vVG5QZEUvRmFOS1JnR2RLOGZGQ3VibFFvaEZzcG9TVFRj?=
 =?utf-8?B?Ynd3dmFyNjFSM0h2MnRxbStNYzgrTVhWNTRCeE1MVVV3YWtTTDg2S3Y3eVBO?=
 =?utf-8?B?ZG1qclBpN3VkWFY3bXdNWmVxVDk3T1NETUVYTTR4Nzk1OHNFNFZMdzFPdElj?=
 =?utf-8?Q?clbAG+WwZDwBaaEvFnLYFIO9T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51000e01-ef96-48e1-f62d-08da7b809c33
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 10:02:33.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9I0FKcVV1qdyZpQ7QmoMAlH2k9tBMA92oXTMQh6NFZe1P4rwi+rQ0om+CbbEN24Cjkiz1XTYdFehi/FmDZvlrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/07/22 13:50, Chao Peng wrote:
> This is the v7 of this series which tries to implement the fd-based KVM
> guest private memory. The patches are based on latest kvm/queue branch
> commit:
> 
>   b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
> split_desc_cache only by default capacity
> 
> Introduction
> ------------
> In general this patch series introduce fd-based memslot which provides
> guest memory through memory file descriptor fd[offset,size] instead of
> hva/size. The fd can be created from a supported memory filesystem
> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
> and the the memory backing store exchange callbacks when such memslot
> gets created. At runtime KVM will call into callbacks provided by the
> backing store to get the pfn with the fd+offset. Memory backing store
> will also call into KVM callbacks when userspace punch hole on the fd
> to notify KVM to unmap secondary MMU page table entries.
> 
> Comparing to existing hva-based memslot, this new type of memslot allows
> guest memory unmapped from host userspace like QEMU and even the kernel
> itself, therefore reduce attack surface and prevent bugs.
> 
> Based on this fd-based memslot, we can build guest private memory that
> is going to be used in confidential computing environments such as Intel
> TDX and AMD SEV. When supported, the memory backing store can provide
> more enforcement on the fd and KVM can use a single memslot to hold both
> the private and shared part of the guest memory. 
> 
> mm extension
> ---------------------
> Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
> created with these flags cannot read(), write() or mmap() etc via normal
> MMU operations. The file content can only be used with the newly
> introduced memfile_notifier extension.
> 
> The memfile_notifier extension provides two sets of callbacks for KVM to
> interact with the memory backing store:
>   - memfile_notifier_ops: callbacks for memory backing store to notify
>     KVM when memory gets invalidated.
>   - backing store callbacks: callbacks for KVM to call into memory
>     backing store to request memory pages for guest private memory.
> 
> The memfile_notifier extension also provides APIs for memory backing
> store to register/unregister itself and to trigger the notifier when the
> bookmarked memory gets invalidated.
> 
> The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
> prevent double allocation caused by unintentional guest when we only
> have a single side of the shared/private memfds effective.
> 
> memslot extension
> -----------------
> Add the private fd and the fd offset to existing 'shared' memslot so
> that both private/shared guest memory can live in one single memslot.
> A page in the memslot is either private or shared. Whether a guest page
> is private or shared is maintained through reusing existing SEV ioctls
> KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
> 
> Test
> ----
> To test the new functionalities of this patch TDX patchset is needed.
> Since TDX patchset has not been merged so I did two kinds of test:
> 
> -  Regresion test on kvm/queue (this patchset)
>    Most new code are not covered. Code also in below repo:
>    https://github.com/chao-p/linux/tree/privmem-v7
> 
> -  New Funational test on latest TDX code
>    The patch is rebased to latest TDX code and tested the new
>    funcationalities. See below repos:
>    Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
>    QEMU: https://github.com/chao-p/qemu/tree/privmem-v7

While debugging an issue with SEV+UPM, found that fallocate() returns 
an error in QEMU which is not handled (EINTR). With the below handling 
of EINTR subsequent fallocate() succeeds:


diff --git a/backends/hostmem-memfd-private.c b/backends/hostmem-memfd-private.c
index af8fb0c957..e8597ed28d 100644
--- a/backends/hostmem-memfd-private.c
+++ b/backends/hostmem-memfd-private.c
@@ -39,7 +39,7 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     MachineState *machine = MACHINE(qdev_get_machine());
     uint32_t ram_flags;
     char *name;
-    int fd, priv_fd;
+    int fd, priv_fd, ret;
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
@@ -65,7 +65,15 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
                                    backend->size, ram_flags, fd, 0, errp);
     g_free(name);
 
-    fallocate(priv_fd, 0, 0, backend->size);
+again:
+    ret = fallocate(priv_fd, 0, 0, backend->size);
+    if (ret) {
+           perror("Fallocate failed: \n");
+           if (errno == EINTR)
+                   goto again;
+           else
+                   exit(1);
+    }

However, fallocate() preallocates full guest memory before starting the guest.
With this behaviour guest memory is *not* demand pinned. Is there a way to 
prevent fallocate() from reserving full guest memory?

> An example QEMU command line for TDX test:
> -object tdx-guest,id=tdx,debug=off,sept-ve-disable=off \
> -machine confidential-guest-support=tdx \
> -object memory-backend-memfd-private,id=ram1,size=${mem} \
> -machine memory-backend=ram1
> 

Regards,
Nikunj

