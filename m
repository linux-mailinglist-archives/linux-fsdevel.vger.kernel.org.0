Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5D58FB47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiHKLaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiHKLa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:30:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C8465E3;
        Thu, 11 Aug 2022 04:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOgPjYIZYEq0/0DbNaJLoPINPj/afvDeKnA/gbo/J0Ir5QP7KT8Tp9bGVeuzuzlVfi8NQW/9hEOps8mYGlQWwUWZQrAye2XVQOpCOZKzykbSn2KPXtcrZHxROB61Ch2HAu7nc5W+FIqvur8wNkrlwrCQOjniOMWIurYID3aF88dZg3dqFt4xlZs5DIuyebLgwCgW3iccPknyeyvf+tzPfgUNByUjtGnJ9XTmN34Q/yZVJXbZnltOm8Uq4iCNhahGPrO4HWGIW3T3o+ft0ILzXLgExJY9iRRRmmKMx2U6+FgayjmDB1mAmZvCZ8XI85/NrxREDbv0K8AA9ebkd8kG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9L7R6UgkmRl21JUyh9Pyl1BSlvehY1cFuv/tPM6IKU=;
 b=acjnQQKRdfTFeioNgvYASeW7J7RsmEkHARI/JR+ZLthLfriOGtBVRb7/GXL5iKA0ujeH5aMJHckVRvqoriGndk+yCetZXYpJ2tNyHqUYAf1oxfCZJXNeVPGcnfg6f4ggBCRHus6JpOnBbD8CsQn4OY1VEYlaxBTQ7xfsAWi2n33V3yhIk/9ka6Y1OIWFlaxL8nyIjEqS1blHWzabI42lyMXM+ckx70SIeTyVbQqEC1Z87/ixIlLX2TL5bYf04zkwRGBolLX55QtAMyeSG05ZtqUFgg7Sf0AlH+ytt/pxKiyZmWJsvpNLFVTx53Xfz07LeYEBC1EN7NBvRI5KgoDSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9L7R6UgkmRl21JUyh9Pyl1BSlvehY1cFuv/tPM6IKU=;
 b=oUhj4bl0uXMdyW04XtbgRlcn+S1898kuexp6c7nmOBC0cWPSGq7GnV4ffQvXj40DJHoDsUhW22r9lCRVxmYi2ZAGO6wFdy3E5vVdwMoJVSrGX2QEA8szVPCYSpbfujHZsCYpe6qBzFk2bfLTLtWZ/FBGs+/QWu4CvlO1LaD6fzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BN6PR12MB1313.namprd12.prod.outlook.com
 (2603:10b6:404:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 11:30:21 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5504.020; Thu, 11 Aug
 2022 11:30:21 +0000
Message-ID: <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
Date:   Thu, 11 Aug 2022 13:30:06 +0200
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
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::19) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3dc4bcc-767f-4826-311c-08da7b8ce01d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1313:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vY1JlstAvTD2Abobu8rB6aN3/woD2+S1DIHOAE44UUuRxVIPi1cj80Hlnf/W2gPPmpOtFVVeK8KQAhSbzRwWe1I5DN/Jzkcd7upbTgftlOrDIUY9DnQXQwwWrqPxm4HLK15+uSIrJJpaciWcrMFPSpnYe2lAm5f2SWHL2scLF+yBIomMablx80UAwO0BVh6YwK+1qHwTBZEQ4ZE8eFNsMnRsD4n4enaIlRa4+mdKY0avQR19j3AP347mv9jthEFGCEzj/nlQ2pNC/cTQ7hGypjRIF+XdGOZ1CnWlni5j5x3TH5xyA5LtgDlh08ZcuzUHNh/Apu1DaxwnmAhqAwQ4RaFnhkNovxnoLugqcdACOI/LIT2x6VyreHZwK57jTYwc9h4ilq9a0kxvpy/kUYr9EZXLXNX6zh5AdMfS/LOC5y0JfNF9BXG/uZcj3ZbPQ8bUTOanXvucs52NQ7fNqejPu54fRuo3umzPWrgQBBOcyRDpQnI/rghmqKY3eevPoFzcfUeGLg+ucAeYxwmjeC1K0y+O7TYCJrLppscMtn2EpcwftxBwNN1a3d+4JfM7e0ERycTxL/9irAqni9awSP2tZAZmFhnskIpPOruBsbieCPcXi9OTZHbwFi73d2q/27PhWQdBO8A85uK5n04cpKlMjLpIQZ/2dupbKZYpE6yDrsYoM9xaqCDl/lP8AQdrrSaE8GK98/DQxtGSOcDkVQjANkmH3SIJMSYG5EPV3KYX8fJ7tZzPeVPoUJ5lFPlV4B9FuHsBr1ekS1eHFor9P5StgdHEEYyGesQnDcITgUv1X9e/OELIXx7AKLZNXCCWgQv2uZnk5EQNfBu2FV4A2DU9c9vRLWNBe6WF7PL7JFeqvHhJgVz4hRXO3VQSTVO5tyY8k8y3y6T/TgA/wqPxfe/WWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(83380400001)(41300700001)(6666004)(4326008)(2906002)(8676002)(66556008)(66946007)(66476007)(316002)(2616005)(36756003)(110136005)(54906003)(31686004)(186003)(38100700002)(26005)(31696002)(6512007)(86362001)(8936002)(5660300002)(478600001)(6506007)(966005)(6486002)(7406005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG1SdjZtYlhFM0FlajdYbGwyVnJWOGlWUzJpZExSZEdRTElPaUh4eEE5SFFp?=
 =?utf-8?B?enNHaTB3L0tmNEZCRmc3SnhYZHBCZ0pUc2djZWgyZUUwcHExNy92NzZKY0Ez?=
 =?utf-8?B?Q0JwOVlkc1Ftb3hCdTJOeHlHOUY0dE11N0FMbDhrOEhENE9kampKTnVkNXFZ?=
 =?utf-8?B?TzRneEdoMlNSbUNKSHBmSU9LVG9vVFF1ekkyVlpuQUJGY1BSaFRrZ083SzF0?=
 =?utf-8?B?NXNxVUJ6S0NKaVVvUE1aTlM0MkJlYmY0M01zeUhCS1ozWFF6OEZGVitYUFI1?=
 =?utf-8?B?bStYK1VHcTdLakViMWlwdU5DVTZlbDY2UDFCUk1helZ5MGUvR21LM3pCYlB5?=
 =?utf-8?B?UFBUZUNtNy81eFZUc0g1QWk1cVl4THpUbm5CUGNuOXA4WVA2czd6TEJuTUFY?=
 =?utf-8?B?dUdjcWkrQ3poMWRkdDcvQnZ1VS9aM0k5QUZ2cTk3OGpoaWNwUU9SMlJkOFpZ?=
 =?utf-8?B?SWxHUTdLaGlURTNJaWpjYjNNeUltSmlhVVZxelBHZkV6bzZjVWFReWxVdEcz?=
 =?utf-8?B?OXdVUldwRkV4RVpyaGdXbnQ1ZU12ZmpKTW44WkpzYTEvOFJacUE3MlRnODJw?=
 =?utf-8?B?TWc3UjNsckV6aS9hZFU5eCtpN3ZLajU2WXRxTlY3MHcvN2twTGUwWGkyVlFB?=
 =?utf-8?B?OWs2ZmcrYkVNWURPNWlYdDhoUjZVTVB3ZDE1WFIydWhQV2RZRXVSVzg1S2xw?=
 =?utf-8?B?QkJyN2JQdjhrbUxFMGpiVXVUOEdZemNIOE1YU1ArY3JIdDNRV1RDR09QQjBE?=
 =?utf-8?B?UW0yRUVZdkVWOFNIV2ZQSDZPZDVnaC85YmFpUjI0bThDMXRWSXlFVDJWajg5?=
 =?utf-8?B?Z2dtcTZLb3ZDVTl4c080V0xMRUJFcnd4dTBNOWJ3MWM1aTJQZ2NNNURFN3Vq?=
 =?utf-8?B?Q3Mvc3JkZFJraWhIMytvRER0cmFEcXVQaHh5VkI2VExvd1IxZGh1VThCTnRx?=
 =?utf-8?B?OStCMWo3L05BbVI2K0dBNjdkNytUV2dpTWw3ekdDKzVaNzFqalFSNFRlT3hu?=
 =?utf-8?B?Zno2WEwyYlg1UzNnemxmSmt3UU91VnFUcExwY29DMnY5Z3JZeFJ4SEZsRmtC?=
 =?utf-8?B?b0t3RWNERm1GTC9XT0JSUFNqeEJXQ1NBRzR5cUdYby9EWTRtdE1zZVhiZzBU?=
 =?utf-8?B?cDBJaUdwN0tsdzdQVlhEMWRHWlRZeDNkOXVGRzZUSHdRaldPdlVTSmw5bVlo?=
 =?utf-8?B?SFFFMUk5aUw4enlqUk41ejVlZ05QMEdyR2ptb3RXV1dyckltOHhjd2MrR0tO?=
 =?utf-8?B?WndxZ0k5NHdkdWoxaVcxY0VqS0I1NCt1Vm94THhlRTZ1bldyMXlOWWczYWdO?=
 =?utf-8?B?ZDBIR3VpdlBsc2xPOFhMVnNZNGVmV1IxUXYxMkR4MkQ5NDZwSHFvWE1sQkRM?=
 =?utf-8?B?c0hvVERHV1cra24vK3htamUxdFJCeEM4TzE5N1NLeGg1dGVNbnJtQ3F5S0gz?=
 =?utf-8?B?ZzhBeVhYc3QwV25LZzRvYThGOWFRNFU5YkVyRWI4U0ZsSEVnYzNwRFArNldz?=
 =?utf-8?B?Z201VG1wTGt6S0FGajJFamFQNWRiOXFMaE1xV1h1VGpzV1dhUlZTU1hrS0pJ?=
 =?utf-8?B?OW14eDcrdC8wVlhNQU1EZUEvK2J2NCs2czJtdS9qSnZDSXUrMEJoTzZyU1pM?=
 =?utf-8?B?VzNCOUQ1RldvL3FneTlKVXdkamZIZlF2SUZHZWFxY1cvbEhqandJeXdxYm00?=
 =?utf-8?B?dlBMVHEvNWx4Rm5IU0daZVRySDF3OEVhUTlkaGtBR3FiMkk4cDRMbDB2T3V4?=
 =?utf-8?B?OEEwVDNhVnBUcE9pVWlWSUEzdjBrcVlNWTVteWVKenplcFQ0YTdMSzBWbjli?=
 =?utf-8?B?Mks3a2JlcElyMWFmWXRnenJOVXg1bUFmbjY2TEZYMVRJRXlRUnlxd3FZQkNn?=
 =?utf-8?B?aTYrb0hmOWd2dmNabUVQNU5JUU5KMlI3NGh3RnYxcHQ0ZTZNWUpHNERIV3Rz?=
 =?utf-8?B?Q3BCL09xYy9PZG9PQXNiTVJselI5V3FzbFhYamZkRkZwSExBR0J2ekZmUFgz?=
 =?utf-8?B?ZkZWMGhxQUliY3ltZmF0UWkrY1dHTVFXcVNxMk8xVUU5MzVrdUU5U0FneWNS?=
 =?utf-8?B?MWxGbmp0OG1KTU9LNUhVUjJsQUF5ekwzVy9iYmJsYjVYSWxUOHFaMDR3TFdj?=
 =?utf-8?Q?SmiS2SAkYbQYKyZeao5uuFuxY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dc4bcc-767f-4826-311c-08da7b8ce01d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 11:30:21.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8ph7ReD/GzJqWmCA6WuCqABuM0IJoaVMGUQiArlnCYzraDtXbrPRb39L7WESCkMt0hrS2BSeDYmCFbdr+s64Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> This is the v7 of this series which tries to implement the fd-based KVM
>> guest private memory. The patches are based on latest kvm/queue branch
>> commit:
>>
>>    b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>> split_desc_cache only by default capacity
>>
>> Introduction
>> ------------
>> In general this patch series introduce fd-based memslot which provides
>> guest memory through memory file descriptor fd[offset,size] instead of
>> hva/size. The fd can be created from a supported memory filesystem
>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>> and the the memory backing store exchange callbacks when such memslot
>> gets created. At runtime KVM will call into callbacks provided by the
>> backing store to get the pfn with the fd+offset. Memory backing store
>> will also call into KVM callbacks when userspace punch hole on the fd
>> to notify KVM to unmap secondary MMU page table entries.
>>
>> Comparing to existing hva-based memslot, this new type of memslot allows
>> guest memory unmapped from host userspace like QEMU and even the kernel
>> itself, therefore reduce attack surface and prevent bugs.
>>
>> Based on this fd-based memslot, we can build guest private memory that
>> is going to be used in confidential computing environments such as Intel
>> TDX and AMD SEV. When supported, the memory backing store can provide
>> more enforcement on the fd and KVM can use a single memslot to hold both
>> the private and shared part of the guest memory.
>>
>> mm extension
>> ---------------------
>> Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
>> created with these flags cannot read(), write() or mmap() etc via normal
>> MMU operations. The file content can only be used with the newly
>> introduced memfile_notifier extension.
>>
>> The memfile_notifier extension provides two sets of callbacks for KVM to
>> interact with the memory backing store:
>>    - memfile_notifier_ops: callbacks for memory backing store to notify
>>      KVM when memory gets invalidated.
>>    - backing store callbacks: callbacks for KVM to call into memory
>>      backing store to request memory pages for guest private memory.
>>
>> The memfile_notifier extension also provides APIs for memory backing
>> store to register/unregister itself and to trigger the notifier when the
>> bookmarked memory gets invalidated.
>>
>> The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
>> prevent double allocation caused by unintentional guest when we only
>> have a single side of the shared/private memfds effective.
>>
>> memslot extension
>> -----------------
>> Add the private fd and the fd offset to existing 'shared' memslot so
>> that both private/shared guest memory can live in one single memslot.
>> A page in the memslot is either private or shared. Whether a guest page
>> is private or shared is maintained through reusing existing SEV ioctls
>> KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
>>
>> Test
>> ----
>> To test the new functionalities of this patch TDX patchset is needed.
>> Since TDX patchset has not been merged so I did two kinds of test:
>>
>> -  Regresion test on kvm/queue (this patchset)
>>     Most new code are not covered. Code also in below repo:
>>     https://github.com/chao-p/linux/tree/privmem-v7
>>
>> -  New Funational test on latest TDX code
>>     The patch is rebased to latest TDX code and tested the new
>>     funcationalities. See below repos:
>>     Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
>>     QEMU: https://github.com/chao-p/qemu/tree/privmem-v7
> 
> While debugging an issue with SEV+UPM, found that fallocate() returns
> an error in QEMU which is not handled (EINTR). With the below handling
> of EINTR subsequent fallocate() succeeds:
> 
> 
> diff --git a/backends/hostmem-memfd-private.c b/backends/hostmem-memfd-private.c
> index af8fb0c957..e8597ed28d 100644
> --- a/backends/hostmem-memfd-private.c
> +++ b/backends/hostmem-memfd-private.c
> @@ -39,7 +39,7 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       MachineState *machine = MACHINE(qdev_get_machine());
>       uint32_t ram_flags;
>       char *name;
> -    int fd, priv_fd;
> +    int fd, priv_fd, ret;
>   
>       if (!backend->size) {
>           error_setg(errp, "can't create backend with size 0");
> @@ -65,7 +65,15 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>                                      backend->size, ram_flags, fd, 0, errp);
>       g_free(name);
>   
> -    fallocate(priv_fd, 0, 0, backend->size);
> +again:
> +    ret = fallocate(priv_fd, 0, 0, backend->size);
> +    if (ret) {
> +           perror("Fallocate failed: \n");
> +           if (errno == EINTR)
> +                   goto again;
> +           else
> +                   exit(1);
> +    }
> 
> However, fallocate() preallocates full guest memory before starting the guest.
> With this behaviour guest memory is *not* demand pinned. Is there a way to
> prevent fallocate() from reserving full guest memory?

Isn't the pinning being handled by the corresponding host memory backend 
with mmu notifier and architecture support while doing the memory 
operations e.g page migration and swapping/reclaim (not supported
currently AFAIU). But yes, we need to allocate entire guest memory with 
the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE etc}.


Thanks,
Pankaj

> 
>> An example QEMU command line for TDX test:
>> -object tdx-guest,id=tdx,debug=off,sept-ve-disable=off \
>> -machine confidential-guest-support=tdx \
>> -object memory-backend-memfd-private,id=ram1,size=${mem} \
>> -machine memory-backend=ram1
>>
> 
> Regards,
> Nikunj
> 
> 

