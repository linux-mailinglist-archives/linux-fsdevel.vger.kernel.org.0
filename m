Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC807634AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 13:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjGZLUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGZLUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:20:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDC611F;
        Wed, 26 Jul 2023 04:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/wcQPDSgpCFZpYnfb0T0LqbrQ+2FOWRAUDsnAilTm4bLK14eeGjbYq8lfiaMdjI3JknWRE0C5+2MtSLiG/ZW2GVJh34MxJU3dK0EeDgOWtqObAQ5b/puZapeiGzZ2hk+eYwwEpRXnAj4GVpNsJvHcMcxMS5HJ1e/Fvm4b81AKTfamcpgvwKNu+1ECd6oh1kwNloypuxKBFAp55Ya7y4DC+20MhO38qm2cIPcMQp4MFFlTDyiotBuWvOEyJRvejilC+yaVf0hFDjd+eP83F5tTjp0wpLAKMxgtHDYJTf0sMJtvcruxag6WeeV2ubQAngjazt4qjGjG+RHuuI7j5rvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/mgSlk0KD3Lz1k03Yflb5QghAokkLXooGwqBXEgxIc=;
 b=SLsWKjITkx856vlM5AB/drxbI4aw7ylHDgKpvqGQOjG/2lfPoKlLFWjDO18njcSNPhzMLxWGLnTq64eWz1fzU/FNsTo7JjyH4UQiRUe5jUPT/Cuvtda4iG2cCNAphB2viNWWKyhWExSuAkkED7oSZN7JZ4zw3Mzph/Yot+CxwIeUeT8Eihp1ZghwWkYL8KK/KHdUdzJVuzgXioWxVjBXo1IGzKt/DcaVx6IONSeUcWIf+RuROZO5DOwolBJYdZK2xudBnWdz5R5oLIMp63t+hY6BVuFTLoUKAmh494BthCbMaUNSq2DVOSMG33sPSIPI3XNwFJHoy0RWkZtV2TX9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/mgSlk0KD3Lz1k03Yflb5QghAokkLXooGwqBXEgxIc=;
 b=hj3mc6ilTZQ8PWZWZbHbHKct2lT8bW1RQNDX83z6nXyRTXwwVHUsw4U60/3KNWa7fTAZafpj/mcTVaEVsgZ5sVrLSwhHVUPfEzWjS/MCvYpCtDqngvnMnrXuTJfiHLgWBXdWZlNSUkyfReoPc4JpioVOjgZJFamootWIVTbjdYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 11:20:41 +0000
Received: from MN0PR12MB6317.namprd12.prod.outlook.com
 ([fe80::dfe2:e9fa:3533:c7ab]) by MN0PR12MB6317.namprd12.prod.outlook.com
 ([fe80::dfe2:e9fa:3533:c7ab%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 11:20:41 +0000
Message-ID: <2f98a32c-bd3d-4890-b757-4d2f67a3b1a7@amd.com>
Date:   Wed, 26 Jul 2023 16:50:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nikunj@amd.com
Subject: Re: [RFC PATCH v11 00/29] KVM: guest_memfd() and per-page attributes
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <110f1aa0-7fcd-1287-701a-89c2203f0ac2@amd.com> <ZL6uMk/8UeuGj8CP@google.com>
Content-Language: en-US
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <ZL6uMk/8UeuGj8CP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::30) To MN0PR12MB6317.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6317:EE_|DM4PR12MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3186dd93-2286-477e-4e76-08db8dca5840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBizgtDFT3IBzDQBw1xGTETCrWL18qUCjwX+zbENyjvuc123B2BTr2RIUoY4IVdhnVTEXShXHG41KdZC+EwqnrR1KhKcL+YcgCqESHIOzoa5xSJyJOeaiAMXj9BEFvP2WOq3xS67VsqmrdOKiGmcVUK2EZff3EnVUndU6wh0HSMbAxh6BYJ8lKDYzTG6ng0Q93MIZLFzAjoeXU3LtNDd1DRxjMjoHsR5Qnx6cEJ+nNfAfou0DZUcT3MvrIjbmJ8gyduMDgY1K7cxb+bSJ1LtRWsZfokT3htT09fUfc6GVMV6x739HtzE1/cBnjQ96a6Udh5ynuh6k08/mB74AY9FvQc0swoIBhW1z20VPjdqk67Bk6v0o+hIHNiw6lXw9Am1zi3G94+UFb/GTjYkT+/0DCJ+ymefaLRGpPqIYoZGKUbvMY6X5bv0wpEJDdrYQpqTQvygIySxVdGLRzGIaVTuGv+5bxk0l39StN4LvYxp+EbGl/y1kv/clAko1/NY3y85fS2Yj0OyCsKApoj+GBfsYZ2r7X6GHMDGU//022Iz8H0yiFhT/wqJovlf3DcNtgazhGjG8TgxWq7zi82JkkJA8U9tTfNvrJrqaZi1aZ/1KRjArQL7E/MPKGmi/9bJ+xLg8og0PgPAp2UKbpTyZP1qFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(186003)(53546011)(83380400001)(6506007)(26005)(41300700001)(316002)(31686004)(2616005)(6512007)(6666004)(6486002)(66899021)(7416002)(478600001)(54906003)(38100700002)(6916009)(4326008)(66476007)(66556008)(66946007)(8676002)(8936002)(7406005)(31696002)(3450700001)(36756003)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5rb2ZIQS8xZFBVbXR3NFRTOTBMMWtlZnR4WFdGT3hHYndKRllTeTRMcEg2?=
 =?utf-8?B?b3BRekpZeVc4V0pOaE5GZzcraCtlVmo0Q1JTWFB4U1J2WVhKakZkQnFJWjNv?=
 =?utf-8?B?MzdqYXRIdmI5ZGtMUWwySXNMUVBONm9XeGlGUmVMOVpUS2xpNnRyNU53ZUxJ?=
 =?utf-8?B?SFBxcUhUK2V0czE1dGc4WTV5em9WVjlEMWZ5RXVkNStzVGRNM010by9qb05B?=
 =?utf-8?B?dm1qZEJJTEJjWkp4bG5PMjNlN0tpcEdaV0NYM3NvV2hMRkdWU3B3RWZjZkdH?=
 =?utf-8?B?c0RjY3AwY3hRZEk5aWIzMWhqemQ2Uk5aVDBQakx1blVybXFRMWdDbm1qVmNm?=
 =?utf-8?B?MTRXVmRaMUFQeUNvMVNKKzRrMktFbXhnamwzL2hVeHZoTTZaQ2xFd1lScTVE?=
 =?utf-8?B?eit1c2lIV1VOQTJncVRhQlBxQ2lCMEhnT0orZHU5RDcvMDNJOFlHNEhrMm5L?=
 =?utf-8?B?NENuaU9TZjhtSTRyc1Z5dy9zVHJvSnBTVHpXOVJGM0tEb3ZwL3VleEExc28x?=
 =?utf-8?B?aFdFOENTYUoxbUNKNS9MV1NaWTludTNZeWNGRElldGtJOXJFbG5MZGJVdVh6?=
 =?utf-8?B?RWYwSUZNQ1lvYVU4clV5RXRFMCtodnpVbXRKbUpScnpIV3N3ZkJwRDNYSngv?=
 =?utf-8?B?S200NW5QejZrc2syV1JKbVVUVXhuU0wrL25taW5PT0R3UXBDRENCUzVHazBW?=
 =?utf-8?B?YlRUTDhMRU5UdjAyWm9MMTEyVGVlb1RBSktBa0VmYU83a3Q5V0ptcGQ2M2Np?=
 =?utf-8?B?M3ZMM2REMW1udElHakl0KzVKMkpNcmNvOUZrdjQzbFVWN0hnQm52WVBDcGpl?=
 =?utf-8?B?K1lPbFRBZEVheGRQNDdyOVQ0amZENm9zNTBEdWJ1bmFtMVdKc1RyMXh0V3Qw?=
 =?utf-8?B?TnZ4bmhjdS9EMXBQNWNrdTNGcytHU1VwYmVnb2FkV0FsNFlMUVpLVVVhNVcy?=
 =?utf-8?B?c0FzQ3pBZ0xHU0Vha3cwWFdVcFZWNk8rakUwdno5MjVCWmNmdEZyVzJib2JY?=
 =?utf-8?B?R28rWHZwa1VHdVFGb25FN05kaFhQalRKcCtkQ1VQd1FFYWRtMzdtWE03Uy9N?=
 =?utf-8?B?amZySE9zQTRkMDBsT1BsWVgxbElVc0tNK0w2eW1xbWdrbE04VDk2TG9RY3Vw?=
 =?utf-8?B?UStiSkdQVUJzVGtIZ0VMeTdyd05QblZnRTZORUM2R0Ruc0pqOEZHUzVHeU1z?=
 =?utf-8?B?V2lTZHc2bkhYVWxIMHNIb2xJNGx5M09nM2o1QWRxb2pHR2hEbEgwMXV2OXYr?=
 =?utf-8?B?aEdOZm5MZ0sxTnNtaXMyYWNUczJDV1U4U3FDN2NtN29zdjA2eGxCVHVIY2Vq?=
 =?utf-8?B?bm5qR04wdHhMRFR4Sm9VbnZKQmIrOGN2U0QzT0hOckhvRmVndTVRb3NFM2hW?=
 =?utf-8?B?S0FySWhXcDd5RFgzaUVObUJBN3NsRG1ZblFFR0I2ZXg5RTBPeW1BeC8zNy8x?=
 =?utf-8?B?YndkTTlXYit4UVZ5SmVlRmlDZk9qWkVDYXlFNFBLQW5CM09PbktWanVpaUN0?=
 =?utf-8?B?YTNkTzZtRDNacGJDYjlIcUNEckZPVTlsZlgzbTVUV3crZ3QwUTJxQjBuQThS?=
 =?utf-8?B?TVg5ZGJKeW5odlV0WkdMZkJ4Z2xsbzZ2SzBkSm83WTFQWURFV0tpWUo4UVBj?=
 =?utf-8?B?QzRrMkU2ZUhMVkZEYlQyK0tqczlWT0pkWCtuNkZuZXNTUWFGdEdFeUQyazNo?=
 =?utf-8?B?UUR3bTFQUXJYRWN0KzVEY3cyL2RPV0JpekdiQk5MaWVlb0s0amQwc2p1YjZG?=
 =?utf-8?B?QktteGFNaEtLci9YVzBiMFJIK2lrdzlxNkRJV3VVN01MWFFkUTkvNWZoaEI0?=
 =?utf-8?B?d2FJTWRnZk9DLzJRaS9qTXVZU09BTDBBYkdJenhzYVErNG5OTjBTU0dKUXBW?=
 =?utf-8?B?VEVZbmVhOG5iVG5pUDAwdSt0ZXJZenJLUmd5OEk2bkFTNmdqZEpPTHZBdHVD?=
 =?utf-8?B?SjBSWkNhOXIwNmZSRUh4VythMWhHemkrREZRMTRrM0g5TzlFRCttUGZIMXpL?=
 =?utf-8?B?a3lHMzVNZlJwY25HVFRrdXdNcFdzNm5EUzFKb2lSa0ZBM2ZBbmNnS2VocEZ2?=
 =?utf-8?B?MWtKWmFhc041czZreFcrTWRZaWF3N1NxN1JMVDBKOEIyN1RicTZiT2pxSmNj?=
 =?utf-8?Q?jqMlbjinPgW8y3XdtYwE9QZ6C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3186dd93-2286-477e-4e76-08db8dca5840
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:20:41.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBhl0M55zZsBZsZoqa7/WWzkNxZ47yity0AoFCCmKdWb0puZlVfKxpl/vjHdRLF70RLyVc+ghkHBfM6Jx2HaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sean,

On 7/24/2023 10:30 PM, Sean Christopherson wrote:
> On Mon, Jul 24, 2023, Nikunj A. Dadhania wrote:
>> On 7/19/2023 5:14 AM, Sean Christopherson wrote:
>>> This is the next iteration of implementing fd-based (instead of vma-based)
>>> memory for KVM guests.  If you want the full background of why we are doing
>>> this, please go read the v10 cover letter[1].
>>>
>>> The biggest change from v10 is to implement the backing storage in KVM
>>> itself, and expose it via a KVM ioctl() instead of a "generic" sycall.
>>> See link[2] for details on why we pivoted to a KVM-specific approach.
>>>
>>> Key word is "biggest".  Relative to v10, there are many big changes.
>>> Highlights below (I can't remember everything that got changed at
>>> this point).
>>>
>>> Tagged RFC as there are a lot of empty changelogs, and a lot of missing
>>> documentation.  And ideally, we'll have even more tests before merging.
>>> There are also several gaps/opens (to be discussed in tomorrow's PUCK).
>>
>> As per our discussion on the PUCK call, here are the memory/NUMA accounting 
>> related observations that I had while working on SNP guest secure page migration:
>>
>> * gmem allocations are currently treated as file page allocations
>>   accounted to the kernel and not to the QEMU process.
> 
> We need to level set on terminology: these are all *stats*, not accounting.  That
> distinction matters because we have wiggle room on stats, e.g. we can probably get
> away with just about any definition of how guest_memfd memory impacts stats, so
> long as the information that is surfaced to userspace is useful and expected.
> 
> But we absolutely need to get accounting correct, specifically the allocations
> need to be correctly accounted in memcg.  And unless I'm missing something,
> nothing in here shows anything related to memcg.

I tried out memcg after creating a separate cgroup for the qemu process. Guest 
memory is accounted in memcg.

  $ egrep -w "file|file_thp|unevictable" memory.stat
  file 42978775040
  file_thp 42949672960
  unevictable 42953588736 

NUMA allocations are coming from right nodes as set by the numactl.

  $ egrep -w "file|file_thp|unevictable" memory.numa_stat
  file N0=0 N1=20480 N2=21489377280 N3=21489377280
  file_thp N0=0 N1=0 N2=21472739328 N3=21476933632
  unevictable N0=0 N1=0 N2=21474697216 N3=21478891520

> 
>>   Starting an SNP guest with 40G memory with memory interleave between
>>   Node2 and Node3
>>
>>   $ numactl -i 2,3 ./bootg_snp.sh
>>
>>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>  242179 root      20   0   40.4g  99580  51676 S  78.0   0.0   0:56.58 qemu-system-x86
>>
>>   -> Incorrect process resident memory and shared memory is reported
> 
> I don't know that I would call these "incorrect".  Shared memory definitely is
> correct, because by definition guest_memfd isn't shared.  RSS is less clear cut;
> gmem memory is resident in RAM, but if we show gmem in RSS then we'll end up with
> scenarios where RSS > VIRT, which will be quite confusing for unaware users (I'm
> assuming the 40g of VIRT here comes from QEMU mapping the shared half of gmem
> memslots).

I am not sure why will RSS exceed the VIRT, it should be at max 40G (assuming all the
memory is private)

As per my experiments with a hack below. MM_FILEPAGES does get accounted to RSS/SHR in top

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   4339 root      20   0   40.4g  40.1g  40.1g S  76.7  16.0   0:13.83 qemu-system-x86

diff --git a/mm/memory.c b/mm/memory.c
index f456f3b5049c..5b1f48a2e714 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -166,6 +166,7 @@ void mm_trace_rss_stat(struct mm_struct *mm, int member)
 {
        trace_rss_stat(mm, member);
 }
+EXPORT_SYMBOL(mm_trace_rss_stat);

 /*
  * Note: this doesn't free the actual pages themselves. That
diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index a7e926af4255..e4f268bf9ce2 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -91,6 +91,10 @@ static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
                        clear_highpage(folio_page(folio, i));
        }

+       /* Account only once for the first time */
+       if (!folio_test_dirty(folio))
+               add_mm_counter(current->mm, MM_FILEPAGES, folio_nr_pages(folio));
+
        folio_mark_accessed(folio);
        folio_mark_dirty(folio);
        folio_mark_uptodate(folio);

We can update the rss_stat appropriately to get correct reporting in userspace.

>>   Accounting of the memory happens in the host page fault handler path,
>>   but for private guest pages we will never hit that.
>>
>> * NUMA allocation does use the process mempolicy for appropriate node 
>>   allocation (Node2 and Node3), but they again do not get attributed to 
>>   the QEMU process
>>
>>   Every 1.0s: sudo numastat  -m -p qemu-system-x86 | egrep -i "qemu|PID|Node|Filepage"   gomati: Mon Jul 24 11:51:34 2023
>>
>>   Per-node process memory usage (in MBs)
>>   PID                               Node 0          Node 1          Node 2          Node 3           Total
>>   242179 (qemu-system-x86)           21.14            1.61           39.44           39.38          101.57
>>
>>   Per-node system memory usage (in MBs):
>>                             Node 0          Node 1          Node 2          Node 3           Total
>>   FilePages                2475.63         2395.83        23999.46        23373.22        52244.14
>>
>>
>> * Most of the memory accounting relies on the VMAs and as private-fd of 
>>   gmem doesn't have a VMA(and that was the design goal), user-space fails 
>>   to attribute the memory appropriately to the process.
>>
>>   /proc/<qemu pid>/numa_maps
>>   7f528be00000 interleave:2-3 file=/memfd:memory-backend-memfd-shared\040(deleted) anon=1070 dirty=1070 mapped=1987 mapmax=256 active=1956 N2=582 N3=1405 kernelpagesize_kB=4
>>   7f5c90200000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted)
>>   7f5c90400000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted) dirty=32 active=0 N2=32 kernelpagesize_kB=4
>>   7f5c90800000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted) dirty=892 active=0 N2=512 N3=380 kernelpagesize_kB=4
>>
>>   /proc/<qemu pid>/smaps
>>   7f528be00000-7f5c8be00000 rw-p 00000000 00:01 26629                      /memfd:memory-backend-memfd-shared (deleted)
>>   7f5c90200000-7f5c90220000 rw-s 00000000 00:01 44033                      /memfd:rom-backend-memfd-shared (deleted)
>>   7f5c90400000-7f5c90420000 rw-s 00000000 00:01 44032                      /memfd:rom-backend-memfd-shared (deleted)
>>   7f5c90800000-7f5c90b7c000 rw-s 00000000 00:01 1025                       /memfd:rom-backend-memfd-shared (deleted)
> 
> This is all expected, and IMO correct.  There are no userspace mappings, and so
> not accounting anything is working as intended.
Doesn't sound that correct, if 10 SNP guests are running each using 10GB, how would we know who is using 100GB of memory?

> 
>> * QEMU based NUMA bindings will not work. Memory backend uses mbind() 
>>   to set the policy for a particular virtual memory range but gmem 
>>   private-FD does not have a virtual memory range visible in the host.
> 
> Yes, adding a generic fbind() is the way to solve silve.

Regards,
Nikunj

